/*
Intinerario:
porque aqui y no en un notion o algo parecido? buena pregunta, no hay respuesta, esto lo tenia a la mano

plan de 7 dias para el proyecto //antes dije 5 pero vi que no cambia
Dia 0) leer el proyecto ---- realizado el 10/6/2026 martes by: Angel Ruiz
Dia 1) realiazar el help ---- realizado el 10/6/2026 martes by: Angel Ruiz //esto no es de un dia pero lo pongo porque si 
Dia 2) realizar el echo ---- reañozadp el 10/7/2026  by: Angel Ruiz//solo es compiar un mensaje, que tanto podria salir mal,salio todo mal 
Dia 3) ralizar el clear // sigo pensando si realizar una llamada al sistema o como podria hacer algo asi 
Dia 4) realizar el exit // ya esta hecho y reutilizado de la practica: by: el auxliar, gracias auxiliar si lee esto
Dia 5) realizar bypass hacia llamadas del sistemas // no se como hacer esto, basicamente la idea general es ejecutar el comando literal que pide, como se podra hacer, ni idea
Dia 6) unir todo y rezar parea que funcione
Dia 7) y el creados descanso de su creacion, o  eso diria si no tengo que borrar todos los comentarios, posiblemente los deje como evidencia de mi trabajo y caida a la locura
*/
// x0-x8 no tocar,
//x9-x15 uso temporal
//x16-x17 para temporal PERO A LARGO PLAZO
//X19-X28 guardar datos

//x0 intrucion
//x1 y x2 para imprimir
//x3-10 estan usados en atol
//x11-17 libres


//x15 bandera temporar para ciclos
//x14 bandera de intrucion 

//x16 = intrucion commando_buffer
//x17 = segundo mensaje de la intrucion mensaje_buffer
//x18 tamaño del mensaje descnosco si servira para algo, update servira para una comparacion rapida
//x19, tamaño del mensaje unicamente
    //historial de pensamientos: demostracion de como caigo cada ves mas a la locura
    //10-6-2026-10:50 Angel Ruiz
    //comentario me di cuenta que puedo escribir cosas en x1 y usarlas como depúrador.
    //comentario 2, lo probaremos la teoria ahorita para comprobar si funciona
    //comentario 3, recorde que necesito la longitud del mensaje, desconosco como obtenerla
    //comentario 4, recorde el atol, eso servira para los print
    //comentario 5, reutilizare la funcion del resultado ya que esa trae incluida el integrer to number

    //10-6-2026-10:52 Angel Ruiz
    //comentario 1, dio muchos errores en la prueba de codigo 1, buscare las soluciones a estos errores
    /*
        comentario 2:
        escribiendo estos comentarios me di cuenta que puedo escribir en multi linea, ayudara mucho a la hora de escribir todos los cometnarios
        ademas puedo agregar los errores para tener mejor manejo:

        daniel@DESKTOP-5SA89G3:~/arqui1$ aarch64-linux-gnu-as practica.s -o practica.o
        practica.s: Assembler messages:
        practica.s: Warning: end of file not at end of a line; newline inserted // no se que es i lo ignoro
        help.s: Warning: end of file not at end of a line; newline inserted // no se que es i lo ignoro
        interpretar.s: Warning: end of file not at end of a line; newline inserted // no se que es i lo ignoro
        interpretar.s:15: Error: unknown mnemonic `b.nq' -- `b.nq fin' // me confundi y puse q en lugar de la N
        interpretar.s:19: Error: unexpected characters following instruction at operand 2 -- `ldrb w14,[x16]#1' // me falto la ,
        interpretar.s:20: Error: unexpected characters following instruction at operand 2 -- `ldrb w13,[x16]#1'
        interpretar.s:21: Error: unknown mnemonic `cpm' -- `cpm w14,#10' // puse compara mal, la falta de sueño ya me esta afectado
        interpretar.s:23: Error: unknown mnemonic `cpm' -- `cpm w14,'
        practica.s:82: Error: can't open leer_comando for reading: No such file or directory
        daniel@DESKTOP-5SA89G3:~/arqui1$
        // parece que todos los errores son faciles de solucionar ahorita los arreglo
        // se me olvido donde iba cada error y lo tengo que repasar
        al parecer todos son de interpretar y no se porque puse las // anteriormente si ya estoy en un bloque de comentarios
    */
    //10-6-2026-10:58 Angel Ruiz
    /*
        solucione muchos de los errores pero siguen apareciendo
        practica.s: Assembler messages:
        practica.s: Warning: end of file not at end of a line; newline inserted
        help.s: Warning: end of file not at end of a line; newline inserted
        interpretar.s: Warning: end of file not at end of a line; newline inserted
        leer_comando.s: Warning: end of file not at end of a line; newline inserted //estos no se porque siguen saliendo pero los sigo ignorando, todo warning no creo que afecte al final
        leer_comando.s:19: Error: unknown mnemonic `cpm' -- `cpm w14,#"32"'
        leer_comando.s:33: Error: unknown mnemonic `cpm' -- `cpm w14,#10' //sigo confundiendo cpm con cmp
    */
    //10-6-2026-11:00 Angel Ruiz 
    /*
        porque hago tantos comentarios: para la posteridad y no caer en la locura
        practica.s: Assembler messages:
        practica.s: Warning: end of file not at end of a line; newline inserted
        help.s: Warning: end of file not at end of a line; newline inserted
        interpretar.s: Warning: end of file not at end of a line; newline inserted
        leer_comando.s: Warning: end of file not at end of a line; newline inserted // creo que ya ni me molestare en explicar los warnings
        leer_comando.s:19: Error: undefined symbol 32 used as an immediate value // el 32 estaba entre comillas

        luego de estos cambios complilo finalmente: 
        practica.s: Assembler messages:
practica.s: Warning: end of file not at end of a line; newline inserted
help.s: Warning: end of file not at end of a line; newline inserted
interpretar.s: Warning: end of file not at end of a line; newline inserted
leer_comando.s: Warning: end of file not at end of a line; newline inserted
sigue pasando los errores
traduciendolos son final del archivo no ternina al final de la linea, nueva linea insertada
voy a probart a agregar una linea al final para ver si lo soluciona, correcto si era eso, no entiendo porque pasa, deberia ser alrever avisarme que hay una linea extra pero bueno, arm64 y sus cosas

    */
    //10-6-2026:11:04 Angel Ruiz
    /*
    nuevos errores aparecieron, lo que faltaba
        daniel@DESKTOP-5SA89G3:~/arqui1$ aarch64-linux-gnu-ld practica.o -o programa
        /usr/bin/aarch64-linux-gnu-ld.bfd: practica.o: in function `comprar_echo_recurcivo':
        (.text+0x38): undefined reference to `final_m'
        /usr/bin/aarch64-linux-gnu-ld.bfd: practica.o: conditional branch to undefined symbol `final_m' not allowed
        (.text+0x38): dangerous relocation: unsupported relocation
        /usr/bin/aarch64-linux-gnu-ld.bfd: (.text+0x44): undefined reference to `comprar_recurcivo'
        daniel@DESKTOP-5SA89G3:~/arqui1$
        genial estos nisiquiera me dicen donde esta el error o en que linea, voy a ver en la de leer comandos
    */
    //10-6-2026:11:07 Angel Ruiz 
    /*
    errores nuevos encontrados, geniaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaal
    solucione los errores anteriores por cierto, era que habia hecho refrencias a cosas que no existian y nombres antiguos
    daniel@DESKTOP-5SA89G3:~/arqui1$ aarch64-linux-gnu-ld practica.o -o programa
daniel@DESKTOP-5SA89G3:~/arqui1$ qemu-aarch64 ./programa
Comandos comunes:
 help:
 clear:
 echo
 exit
 Ingrese una opción: echo hola
0
Comandos comunes:
 help:
 clear:
 echo
 exit
 Ingrese una opción:

 funciona, si, se repite help, si
 ya se como solucionar el help, solo tengo que buscar donde hay una referencia a start y cambiarla, que es en comparar
 de hecho eso puede estar afectado, le dare cuello de una, como afecta al proprama, pues si afecta
 idea, comparar no le daremos cuello, simplemente lo dejaremos alli para cuando sea el momento simplemente guardare en un registro el comando elegido
 1 = help
 2 = clear
pausa
como se supone que voy a limpiar la consola
una syscall?
talves podria hacer que el claer literalmente llame a clear en linux en lugar de hacer un bypass directo a la shell real
3 = echo el mas facil
talves tuve que haberlo hecho en orden, posiblemente no estuviera programando a las 11 de la noche si hubiera empezado pór el clear
1 funcion por dia me parece bien
 voy a agregar al inicio el comando
 tambien deberia renombrar esto a proyecto y no practica
 cosas que se encargara el angel del futuro
    intinerario terminado, en que estasba
    a cierto en lo del 0
    no se ejecuto multipleveces
    no tiene sentido, se deberia haber ejecutado minimo 3 veces, hiso el return y todo


    */

        //10-6-2026:11:23 Angel Ruiz 
        /*
        luego de revisar esto: el error fue facil de encontrar o al menos eso creo
        1) no llamaba al tamaño para imprimir, lo que se supone que solucione con el atol

        volvemos a buscar el error
        */
        //10-6-2026:11:26 Angel Ruiz 
        /*
         no pienso dormir hasta que logre solucionar esto, ademas mañana no hay mucho que hacer temprano
         por lo que veo mi mentodo no funcioa, hise un ejecutable de prueba y no llamo 
         okey, soluicion al probalema, por alguna razon no llega el numero, ahorita probae agrergarrlo manualmente y si funciono
         teoria, en algun lado se sobreescribe x20 antes de llegar
         teoria 2, no veo que se llame el mensaje de error tampoco, me indica que algo esta pasando en la lectura
        */ 
                //10-6-2026:11:34 Angel Ruiz 
        /*
        le di cuello a todo el codigo del comparacion del menu y operaciones matematicvas, no creo que sirva por el momento, espero que eso me ayude a ver mejor y encontrar mas errores
        */
        //10-6-2026:11:37 Angel Ruiz 
        /*
        emprezare a realizar esto, podria crear un numero bandera para saber si esta corriendo
        el numero sera 67, no profundizare el porque
        okey teoria resuleta, comento esto y primero escribo lo que descubri escribiendo el resto
        solo se ejecuta 1 ves al hacer el print numer
        y lo que descubri es: o bueno logre llegar a la conclucion
        supondre que el print_final de un numero no tenia return, revizare eso para confirmar la teoria 
        correcto, no hay return, problema, eso usa un monton de bl que arruina el return
        tendre que aprender stack, algo que no queria

                */
        //10-6-2026:11:42 Angel Ruiz
        /*
        al parecer
        stp es el equivalente a un pust
        y el ldp para recuperar
        stp     x29, x30, [sp, #-16]!

        ldp     x29, x30, [sp], #16

        esto era como el mov que usaba, que podria ver si no hubiera elimiado el codigo viejo
        solo tengo que guardar este codigo y no perderlo, como si lo fuera a perder entre millones de cometario
        solo es mover el puntery y llamarlo denuevo nada especial
        */
        //10-6-2026:11:50 Angel Ruiz
        /*
        tengo sueñoooooooo
        pero ya funciono
        o eso creo
        ando escuchadno bad apple mientras programo

        Comandos comunes:
        help:
        clear:
        echo
        exit
        Ingrese una opción: test
        67
        67
        67
        67
        67
        67
        67
        67
        67
        67
        67
        67
        67
        67
        67
        67
        67
        67
        67
        67
        67

        imprime una cantidad fija de 67 voy a cambiarlo por los numeros reales, 18 veces la llama 19 teniendo en cuenta el original y crashea luego luego 
        o bueno no crashea pero no seale ningun mensaje

        
        */
        //10-6-2026:11:55 Angel Ruiz
        /*
        sabia que iba a serivr de algooo
        0
        1
        2
        3
        4
        5
        6
        7
        8
        9
        9
        9
        10
        11
        12
        13
        14
        15
        16
        17
        18 
        hay 
        donde 
        aparece
        el 
        9 
        3 veces seguidas
        es donde esta el eroror
         Ingrese una opción:
         I 1
         N 2
         G3
         R 4
         e5
         s6
         e7 
        de onde mrd lee 8 cosas
        sabes que
        adios al mensaje
        solo asi que se vaya
        a ver si asi funciona
        aunque no se
        lee incluso vacio
        deberia tirar error
        hay balazos aqui afuera
        a no
        son cuentes
        o cuetes con balasos
        o las dos
        quien sabe

        */
    //10-7-2026:12:00 Angel Ruiz
    /*
    Finalmente encontre el error
    siempre que se envia el mensaje
    existe
    1 byte
    el /n
    el programa no estaba preparado para eos
    y crasheaba y se reiniciaba
    */
        //10-7-2026:12:11 Angel Ruiz
    /*
    Finalmente encontre el error
    v2 el error es que print mensaje cambia x1....
    x22 sera la encargada de guardar el mensaje...
    y tampoco se reajustaban las llamadas del stack eso causaba el error...
    tengo duda que escribira el codigo anterior, volvere a cambiar x1 por probar cuando sea el momento del echo

    */
    //10-7-2026:12:23 Angel Ruiz
    /*
        funcionaaaaa, lee el mensaje pero por alguna razon unca termina el /N es el error deplano, aparecia un monton de numeros
    */
    //10-7-2026:12:56 Angel Ruiz
    /*
        logre, lo logre hacer, ya funciona el echo, el error no era en leer, era en interpretar, el codigo se volvia un bucle infinito, ademas no impimia el mensaje, porque me confiundi er la longitud, pero ya funcionaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
    */
.data

    msg_inicial:
        .ascii "OMEGA_TERMINAL>"
        msg_inicial_len = . - msg_inicial
    
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
    comando_buffer:
        .skip 64
    mensaje_buffer:
        .skip 64
    //desconosco que hace esto, pero si funciona no lo toques 
    //ya se que son los buffers(texto) donde se vab a gyardar
    
    .text
    .global _start

    .include "help.s" //comando help (solo es un echo de los comandos)
    .include "interpretar.s" // es donde se buscara si el comando coincide con los del help, en caso contrario deberia llamar a  linux y esperar su respuesta 
    //por motivos tecnicos en lavercion 1 nomas comparar el tamaño con el echo, no buscara siquiera si es un echo
    .include "leer_comando.s" //lee el comando y lo guarda    
    .include "05_atoi.s"
    .include "06_itoa.s" //incluir atol asi deberia incluir los otros archivos para las diferentes funciones
    //ejemplo el help primer comando a realiar
    .include "echo.s" //escribir el comando



    _start: //iniciar el proceso
        bl help
        bl print
        //mensaje de arriba servira para imprimir
        // imprimir mensaje de opcion
        ldr x1, =msg_opcion
        mov x2, msg_opcion_len
        bl print

        ldr x16,=comando_buffer
        ldr x17,=mensaje_buffer
        bl read
            

        bl intrucion_init


        bl comparar

        // cargar el dato
        ldr x1, =input_buffer // cargar el primer byte del buffer 
        ldrb w0, [x1]            // cargo el primer bite
    comparacion: // comparacion con las opciones del menu

        cmp w0, '7' // esto solo puede comparar numeros, hay que ver la manera de comparar strings
        beq exit
        
        b error
        



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
        stp     x29, x30, [sp, #-16]! // guardar el puntero ver cometnario del 11:48
        mov x0, x20
        ldr x1, =output_buffer
        add x1, x1, #64
        bl itoa
        bl print

        // imprimir nueva linea
        ldr x1, =newline
        mov x2, #1
        bl print
        ldp x29, x30, [sp], #16 //cargar el puntero, ahora con este cambio ya deberia funcionar como deberia
        ret

    read: // leer una palabra
        // read(stdin, input_buffer, 64)
        mov x0, #0              // stdin
        ldr x1, =input_buffer   // dirección del buffer 
        mov x2, #64             // tamaño a leer
        mov x8, #63             // syscall read
        svc #0                  // hacer la llamada al sistema

        // comparación
        cmp x0, #2
        // compara que no este vacio, creo o que no sea 0, supongo que el numero 0 significa un numero vacio
        //update x0 uncamente contiene los bites leidos
        b.lt error

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
