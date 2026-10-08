// https://www.8ksec.io/arm64-reversing-and-exploitation-part-5-writing-shellcode-8ksec-blogs/
/*
    encontre una guia para realizarlo, seguire los pasos necesarios para saber que es

    el siscal = x8 es 221
    x0 contiene el path donde vamos a ejecutarlo, por ende deberiamos conseguir primero el path del aerchivo
    x1 argumentos
    x2 variables
*/
execve:
    stp     x29, x30, [sp, #-16]! // guardar el puntero ver cometnario del 11:48
    
    ldr x3, =argumentos

    str x16, [x3]        // argumento[0] = comando
    cmp x19, #0
    b.eq exec_sin_argumento
    str x17, [x3,#8]     // argumento[1] = argumento
    str xzr, [x3,#16]    // argumento[2] = NULL 
    b ejecutarExecve
exec_sin_argumento:
    str xzr, [x3,#8] 
ejecutarExecve:
    mov x0,x16  // el comando
    mov x1,x3     // el argumento
    mov x2,#0
    mov x8,#221  // syscall numberto execve
    svc 0    // syscall
    cmp x0,#0
    b.lo error
    ldp x29, x30, [sp], #16 //cargar el puntero, ahora con este cambio ya deberia funcionar como deberia
    ret
