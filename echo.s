// conseguir el mensaje
// el mensaje ya lo tenemos 
// mensaje en w0
// hagamos como que ya separamos el mensaje
// string del mensaje: echo hello world
// de esto solo nos llegara lo que este luego del echo 
// solo es imprimir
// hay que conseguir de una manera la longitud y el mensaje


echo:
    stp x29, x30, [sp, #-16]!

    mov x1,x17
    mov x2,x19 //longitud del mensaje
    bl print

    ldr x1, =newline //imprimir nueva linea
    mov x2, #1
    bl print

    ldp x29, x30, [sp], #16

    ret




