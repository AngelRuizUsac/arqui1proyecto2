
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
    mov x0, #1
    mov x8, #93
    svc #0


error_fork:
    ldp x29, x30, [sp], #16
    ret