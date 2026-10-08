.data
    command_echo:
        .ascii "echo"
    command_echo_len = . - command_echo
    command_clear:
        .ascii "clear"
    command_clear_len = . - command_clear
    command_help:
        .ascii "help"
    command_help_len = . - command_help
    command_exit:
        .ascii "exit"
    command_exit_len = . - command_exit
.text
comparar:
    stp x29, x30, [sp, #-16]!

    cmp x18, #command_echo_len
    b.ne comparar_clear

    mov x15, #0
    ldr x13, =command_echo

comparar_echo_recursivo:
    ldrb w14, [x16, x15]    
    ldrb w12, [x13, x15]     

    cmp w14, w12
    b.ne comparar_clear       

    add x15, x15, #1
    cmp x15, #command_echo_len
    b.lo comparar_echo_recursivo

    bl echo
    b fin_comparar
comparar_clear:
    cmp x18, #command_clear_len
    b.ne comparar_help

    mov x15, #0
    ldr x13, =command_clear
comparar_clear_recursivo:
    ldrb w14, [x16, x15]    
    ldrb w12, [x13, x15]     

    cmp w14, w12
    b.ne comparar_help       

    add x15, x15, #1
    cmp x15, #command_clear_len
    b.lo comparar_clear_recursivo

    bl clear_Command
    b fin_comparar
comparar_help:
    cmp x18, #command_help_len
    b.ne comparar_exit

    mov x15, #0
    ldr x13, =command_help
comparar_help_recursivo:
    ldrb w14, [x16, x15]    
    ldrb w12, [x13, x15]     

    cmp w14, w12
    b.ne comparar_exit       

    add x15, x15, #1
    cmp x15, #command_help_len
    b.lo comparar_help_recursivo

    bl help
    b fin_comparar
comparar_exit:
    cmp x18, #command_exit_len
    b.ne Externo

    mov x15, #0
    ldr x13, =command_exit
comparar_exit_recursivo:
    ldrb w14, [x16, x15]    
    ldrb w12, [x13, x15]     

    cmp w14, w12
    b.ne Externo       

    add x15, x15, #1
    cmp x15, #command_exit_len
    b.lo comparar_exit_recursivo

    bl exit
    b fin_comparar
fin_comparar:
    ldp x29, x30, [sp], #16
    ret
Externo:

    bl fork
    b fin_comparar
    