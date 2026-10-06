    .data

    msg_inicial:
        .ascii "OMEGA_TERMINAL>"
        msg_inicial_len = . - msg_menu
    
    msg_menu:
        .ascii "Seleccione una opción"
        msg_menu_len = . - msg_menu


    msg_opcion:
        .ascii "Ingrese una opción: "
        msg_opcion_len = . - msg_opcion


//anterior
    msg_error:
        .ascii "Opción inválida\n"
        msg_error_len = . - msg_error

    msg_primer:
        .ascii "Ingrese el primer número: "
        msg_primer_len = . - msg_primer

    msg_segundo:
        .ascii "Ingrese el segundo número: "
        msg_segundo_len = . - msg_segundo
    msg_unico:
        .ascii "Ingrese el numero: "
        msg_unico_len = . - msg_unico



//lo de arriba es unicamente para que no crashee
    newline:
        .ascii "\n"

    .bss

    input_buffer:
        .skip 64

    output_buffer:
        .skip 64
    
    //desconosco que hace esto, pero si funciona no lo toques
    
    .text
    .global _start

    .include "05_atoi.s"
    .include "06_itoa.s" //incluir atol asi deberia incluir los otros archivos para las diferentes funciones
    //ejemplo el help primer comando a realiar



    _start: //iniciar el proceso
        // imprimir el menu 
        // remplazarlo con el help incial
        ldr x1, =msg_menu 
        mov x2, msg_menu_len
        bl print
        //mensaje de arriba servira para imprimir
        // imprimir mensaje de opcion
        ldr x1, =msg_opcion
        mov x2, msg_opcion_len
        bl print

        bl read

        // cargar el dato
        ldr x1, =input_buffer
        ldrb w0, [x1]           // cargar el primer byte del buffer 
                                // cargo el primer bite

    comparacion: // comparacion con las opciones del menu

        cmp w0, '7' // esto solo puede comparar numeros, hay que ver la manera de comparar strings
        beq exit
        
        cmp w0, '1'
        beq suma

        cmp w0, '2'
        beq resta

        cmp w0, '3'
        beq multiplicacion

        cmp w0, '4'
        beq divicion

        cmp w0, '5'
        beq potecial

        cmp w0, '6'
        beq factorial

        b error



        //codigo antiguo, hay que eliminarlo: tocar al final para evitar que se rompa algo
    suma:
        bl read_numbers
        add x20, x20, x21
        b print_result

    resta:
        bl read_numbers
        sub x20, x20, x21
        b print_result

    multiplicacion:
        bl read_numbers
        mov x29, #1
        mov x19, x20
        cmp x21, #0
        b.eq multCero
    multRecursivo:
        cmp x29,x21
        b.eq multFinal
        add x20,x20,x19
        add x29,x29,#1
        b multRecursivo
    multCero:
        mov x20,#0
        b print_result
    multFinal:
         mov x29,#2
         mul x20,x20,x29
         b print_result
    divicion:
        bl read_numbers
        cmp x21,#0
        b.eq error
        udiv x20,x20,x21
        b print_result
    potecial:
        bl read_numbers

        cmp x21,#0
        b.lt error

        mov x29, #0
        mov x19, x20
        mov x20, #1
    potencialRecursivo:
    cmp x29,x21
    b.eq print_result
    mul x20,x20,x19
    add x29,x29,#1
    b potencialRecursivo

    factorial:
        bl read_only_one_numbers
        cmp x21,#0
        b.lt error
        mov x29, #1
        mov x20, #1
    factorialIterativo:
    cmp x29,x21
    b.gt print_result
    mul x20,x20,x29
    add x29,x29,#1
    b factorialIterativo
    //fin del codigo antiguo

    read_numbers: //leer numeros  codigo antiguo reutilizar lo posible y luego eliminar
        mov x26,x30
        // imprimir mensaje de primer numero
        ldr x1, =msg_primer
        mov x2, msg_primer_len
        bl print

        bl read

        ldr x21, =input_buffer
        bl atoi    
        mov x20, x10
        
        // imprimir mensaje de segundo numero
        ldr x1, =msg_segundo
        mov x2, msg_segundo_len
        bl print

        bl read

        ldr x21, =input_buffer
        bl atoi
        mov x21, x10
        mov x30,x26
        ret
    read_only_one_numbers: 
        mov x26,x30
        // imprimir mensaje de primer numero
        ldr x1, =msg_unico
        mov x2, msg_unico_len
        bl print

        bl read

        ldr x21, =input_buffer
        bl atoi    
        mov x21, x10

        mov x30,x26
        ret
    //Fin lecturas de los mensajes
    print_result: // imprimir mensaje viejo, llamaba al atol para convertir los numeros
        // imprimir el resultado
        mov x0, x20
        ldr x1, =output_buffer
        add x1, x1, #64
        bl itoa
        bl print

        // imprimir nueva linea
        ldr x1, =newline
        mov x2, #1
        bl print
        b _start

    read: // leer una palabra
        // read(stdin, input_buffer, 64)
        mov x0, #0              // stdin
        ldr x1, =input_buffer   // dirección del buffer
        mov x2, #64             // tamaño a leer
        mov x8, #63             // syscall read
        svc #0                  // hacer la llamada al sistema

        // comparación
        cmp x0, #0 
        // compara que no este vacio, creo o que no sea 0, supongo que el numero 0 significa un numero vacio
        blt error

        ret

    exit: // salir (solo llamar a la funcion)
        mov x0, #0
        mov x8, #93             // syscall exit
        svc #0

    print: // imprimir un mensaje, nomas enviar el mensaje (desconosco donde se guarda el mensaje)
            // update el mensaje se guarda en x1 y x2 
            // x1 = msg_asunto
            // x2 = msg_longitud 
            // aun falta ver como unir mensajes

        mov x0, #1              // stdout
        mov x8, #64             // syscall de escritura
        svc 0
        ret

    error: // mostrar mensaje de error solo llamar a la funcion
        ldr x1, =msg_error
        mov x2, msg_error_len
        bl print
        b _start

