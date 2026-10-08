
wait:
    stp x29, x30, [sp, #-16]!

    // x0 = PID del hijo
    mov x1, #0
    mov x2, #0
    mov x3, #0

    mov x8, #260
    svc #0

    ldp x29, x30, [sp], #16
    ret
