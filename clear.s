//10-7-2026:11:04 Angel Ruiz 
/*
    investigando me di cuenta que hay una secuencia ansi, \033[2J\033[H que me permite limpiar la pantalla
    el j2 mueve limpia la pantala
     y la H lo mueve a la superior isquierda
    y el 033 es el escape para enviar los comentarios a la terminar

    para esto solo tengo que copiar una siscall de otro lado
    correcion, investigando mas me di cuenta que es literalmente una imprecion, solo tengo que llamar a imprimir el nuevo archivo

*/
.data
    clear:
        .ascii "\033[2J\033[H"
        clear_len = . - clear
.text
clear_Command:
    stp     x29, x30, [sp, #-16]! // guardar el puntero ver cometnario del 11:48
    ldr x1, =clear
    mov x2, #clear_len
    bl print
       
    ldp x29, x30, [sp], #16 //cargar el puntero, ahora con este cambio ya deberia funcionar como deberia
    ret
