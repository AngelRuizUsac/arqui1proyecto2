.data
command_echo:
    .ascii "echo"
command_echo_len = . - command_echo

.text
comparar:
    stp x29, x30, [sp, #-16]!

    cmp x18, #command_echo_len
    b.ne fin_comparar

    mov x15, #0
    ldr x13, =command_echo

comparar_echo_recursivo:
    ldrb w14, [x16, x15]    
    ldrb w12, [x13, x15]     

    cmp w14, w12
    b.ne fin_comparar       

    add x15, x15, #1
    cmp x15, #command_echo_len
    b.lo comparar_echo_recursivo

    bl echo

fin_comparar:
    ldp x29, x30, [sp], #16
    ret
    