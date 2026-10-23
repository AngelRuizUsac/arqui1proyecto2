
/* ---------------------------------------------------------------------
 * wait: espera a que termine el proceso hijo (syscall wait4, 260).
 * Entrada: x0 = PID del hijo. Repite la espera si fue interrumpida (EINTR).
 * Guarda x29/x30 con STP/LDP.
 * --------------------------------------------------------------------- */
wait:
    stp x29, x30, [sp, #-16]!

    // x0 = PID del hijo
    mov x9, x0                  // guardar el PID (la syscall devuelve su resultado en x0)
wait_reintentar:
    mov x0, x9
    mov x1, #0
    mov x2, #0
    mov x3, #0

    mov x8, #260
    svc #0
    cmn x0, #4                  // x0 == -4 (EINTR): la espera fue interrumpida, repetir
    b.eq wait_reintentar

    ldp x29, x30, [sp], #16
    ret
