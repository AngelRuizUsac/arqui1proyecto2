.data
    prefijo_bin:
        .asciz "/bin/"

.bss
    ruta_buffer:
        .skip 80

.text
execve:
    stp x29, x30, [sp, #-16]!

    bl preparar_argumentos

    // Buscar "/" únicamente en el comando
    mov x9, x16

buscar_barra:
    ldrb w10, [x9], #1
    cbz w10, probar_bin

    cmp w10, #'/'
    b.eq ejecutar_ruta_directa

    b buscar_barra

ejecutar_ruta_directa:
    mov x0, x16
    b ejecutar_comando

probar_bin:
    ldr x0, =prefijo_bin
    bl construir_ruta

ejecutar_comando:
    bl llamar_execve

    // Si execve regresa, falló
    ldp x29, x30, [sp], #16
    ret


llamar_execve:
    // x0 = ruta del ejecutable
    ldr x1, =argumentos
    mov x2, #0
    mov x8, #221
    svc #0
    ret


construir_ruta:
    // x0 = dirección del prefijo "/bin/"
    ldr x9, =ruta_buffer
    mov x10, x0

copiar_prefijo:
    ldrb w11, [x10], #1
    cbz w11, comenzar_nombre

    strb w11, [x9], #1
    b copiar_prefijo

comenzar_nombre:
    mov x10, x16

copiar_nombre:
    ldrb w11, [x10], #1
    strb w11, [x9], #1
    cbnz w11, copiar_nombre

    // Devolver dirección de la ruta completa
    ldr x0, =ruta_buffer
    ret


preparar_argumentos:
    ldr x9, =argumentos

    // argv[0] = comando
    str x16, [x9], #8

    mov x10, x17

buscar_argumento:
    ldrb w11, [x10]
    cbz w11, terminar_argumentos

    // Aceptar el salto de línea del parser anterior
    cmp w11, #10
    b.eq terminar_linea_argumentos

    cmp w11, #32
    b.eq saltar_separador

    cmp w11, #9
    b.eq saltar_separador

    // Guardar dirección del argumento
    str x10, [x9], #8

recorrer_argumento:
    ldrb w11, [x10]
    cbz w11, terminar_argumentos

    cmp w11, #10
    b.eq terminar_linea_argumentos

    cmp w11, #32
    b.eq cerrar_argumento

    cmp w11, #9
    b.eq cerrar_argumento

    add x10, x10, #1
    b recorrer_argumento

cerrar_argumento:
    strb wzr, [x10]

saltar_separador:
    add x10, x10, #1
    b buscar_argumento

terminar_linea_argumentos:
    strb wzr, [x10]

terminar_argumentos:
    // argv termina con un puntero NULL
    str xzr, [x9]
    ret