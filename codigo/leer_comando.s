// leer el comando 


// el mensaje esa guardado en por read
//mensaje guardado en x0

//x1 es donde esta el buffer, x1+1 etxc 

//x11 sera el comando

//tenemos el buffer en x1 

/* ---------------------------------------------------------------------
 * intrucion_init: parsing de la linea leida (input_buffer).
 * Separa el texto en comando (primera palabra -> buffer x16) y mensaje (el
 * resto -> buffer x17). Ignora espacios/tabs antes del comando y entre el
 * comando y el mensaje; el tab (9) separa igual que el espacio (32).
 * Entrada: x0 = bytes leidos, x16/x17 = buffers destino.
 * Salida:  x18 = longitud del comando (0 = linea vacia), x19 = longitud del mensaje.
 * Usa x9, x14, x15, x22. Guarda x29/x30 con STP/LDP.
 * --------------------------------------------------------------------- */
intrucion_init:

    stp x29, x30, [sp, #-16]!

    mov x9, x0
    ldr x22, =input_buffer
    mov x15, #0
    mov x18, #0
    mov x19, #0
    strb wzr, [x16] //reiniciar los textos
    strb wzr, [x17]

saltar_iniciales:               // ignorar espacios y tabs antes del comando
    cmp x15, x9
    b.hs final_leer
    ldrb w14, [x22, x15]
    cmp w14, #32
    b.eq saltar_inicial_sig
    cmp w14, #9
    b.ne intrucion_recurcivo
saltar_inicial_sig:
    add x15, x15, #1
    b saltar_iniciales

intrucion_recurcivo:

    cmp x15, x9
    b.hs final_leer
    ldrb w14, [x22, x15]

    cbz w14, final_leer
    cmp w14, #10
    b.eq final_leer
    cmp w14, #32
    b.eq mensaje
    cmp w14, #9                 // el tab tambien separa comando y mensaje
    b.eq mensaje

    cmp x18, #63
    b.hs final_leer

    strb w14, [x16, x18]
    add x18, x18, #1
    add x15, x15, #1
    b intrucion_recurcivo

mensaje:

    add x15, x15, #1

mensaje_saltar:                 // ignorar espacios/tabs extra antes del mensaje
    cmp x15, x9
    b.hs final_leer
    ldrb w14, [x22, x15]
    cmp w14, #32
    b.eq mensaje_saltar_sig
    cmp w14, #9
    b.ne mensaje_recursivo
mensaje_saltar_sig:
    add x15, x15, #1
    b mensaje_saltar

mensaje_recursivo:

    cmp x15, x9
    b.hs final_leer
    ldrb w14, [x22, x15]

    cbz w14, final_leer
    cmp w14, #10
    b.eq final_leer
    cmp x19, #63
    b.hs final_leer

    strb w14, [x17, x19]
    add x19, x19, #1
    add x15, x15, #1
    b mensaje_recursivo

final_leer:

    strb wzr, [x16, x18]
    strb wzr, [x17, x19]

    ldp x29, x30, [sp], #16
    ret
