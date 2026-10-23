.data
    msg_error_exec:
        .ascii "No se pudo ejecutar el comando\n"
    msg_error_exec_len = . - msg_error_exec
    msg_error_fork:
        .ascii "No se pudo crear el proceso hijo\n"
    msg_error_fork_len = . - msg_error_fork
.text
/* ---------------------------------------------------------------------
 * fork: ejecuta un comando externo en un proceso hijo.
 * Crea el hijo con clone(SIGCHLD) (syscall 220). x0 < 0 error, x0 = 0 hijo,
 * x0 > 0 padre (x0 = PID). El hijo llama a execve y, si esta regresa, imprime
 * un error y termina con exit(1). El padre espera con wait.
 * Guarda x29/x30 con STP/LDP.
 * --------------------------------------------------------------------- */
fork:
    stp x29, x30, [sp, #-16]!

    // clone(SIGCHLD, 0, 0, 0, 0)
    mov x0, #17
    mov x1, #0
    mov x2, #0
    mov x3, #0
    mov x4, #0

    mov x8, #220
    svc #0

    // x0 < 0 = error
    cmp x0, #0
    b.lt error_fork

    // x0 = 0 = proceso hijo
    b.eq proceso_hijo

    // x0 > 0 = proceso padre
proceso_padre:
    // x0 contiene el PID del hijo
    bl wait

    ldp x29, x30, [sp], #16
    ret


proceso_hijo:
    // Ejecutar el comando externo
    bl execve

    // Si execve funciona, nunca regresa.
    // Si regresa, significa que hubo un error.
    ldr x1, =msg_error_exec
    mov x2, #msg_error_exec_len
    bl print

    mov x0, #1
    mov x8, #93
    svc #0


error_fork:
    ldr x1, =msg_error_fork
    mov x2, #msg_error_fork_len
    bl print
    ldp x29, x30, [sp], #16
    ret
    
