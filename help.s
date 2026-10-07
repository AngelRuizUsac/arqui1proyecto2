.data
    msg_help:
        .ascii "Comandos comunes:\n help: \n clear: \n echo \n exit\n "
    msg_help_len = . - msg_help

.text
help:
    ldr x1, =msg_help 
    mov x2, msg_help_len
    ret
    