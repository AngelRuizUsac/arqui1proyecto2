.data
    msg_help:
        .ascii "Comandos comunes:\n help: \n clear: \n echo \n exit\n "
    msg_help_len = . - msg_help

.text
help:
    stp     x29, x30, [sp, #-16]! // guardar el puntero ver cometnario del 11:48
    ldr x1, =msg_help 
    mov x2, msg_help_len
    bl print
    ldp x29, x30, [sp], #16 //cargar el puntero, ahora con este cambio ya deberia funcionar como deberia

    ret
    