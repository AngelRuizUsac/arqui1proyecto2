// leer el comando 


// el mensaje esa guardado en por read
//mensaje guardado en x0

//x1 es donde esta el buffer, x1+1 etxc 

//x11 sera el comando

//tenemos el buffer en x1 

intrucion_init:
    stp x29, x30, [sp, #-16]!

    ldr x22, =input_buffer 

    mov x15,#0
    ldrb w14, [x22,x15]

intrucion_recurcivo:
    ldrb w14, [x22,x15]

    cmp w14, #' '      
    b.eq mensaje
    cmp w14, #10
    b.eq final_leer_corto

    strb w14, [x16,x15]
    add x15,x15,#1
    b intrucion_recurcivo
mensaje:
    mov x18,x15
    mov x19,#0
    strb wzr, [x16,x15]
    add x15,x15,#1
mensaje_recursivo:
    ldrb w14, [x22,x15]
    strb w14, [x17,x19]
    add x15,x15,#1
    add x19,x19,#1
    cmp w14, #10
    b.eq final_leer
    b mensaje_recursivo
final_leer: 
   strb wzr, [x17,x19]

    ldp x29, x30, [sp], #16
    ret
final_leer_corto:
    mov x18,x15
    strb wzr,[x16,x15]

    mov x19,#0
    strb wzr,[x17]
    b final_leer

    