# Sesion de depuracion MiniShell
# Terminal 1:  make debug     (QEMU espera a GDB)
# Terminal 2:  make gdb       (usa este script)
# Para guardar el log: ejecutar antes  script -a gdb_log.txt
set pagination off
set confirm off
set architecture aarch64
target remote :1234

break print
break intrucion_init
break comparar
break fork
break execve

echo \n=== Inicio: registros y stack ===\n
info registers x0 x1 x2 x8 x30 sp
x/8gx $sp

continue
echo \n=== Parada en print (prompt): x1 = mensaje, x2 = longitud ===\n
info registers x0 x1 x2 x8 x30 sp
x/8gx $sp

# Escribe un comando en la terminal 1 (por ejemplo: ls) y continua
continue
echo \n=== Parada en intrucion_init: x0 = bytes leidos ===\n
info registers x0 x9 x16 x17 x30 sp
x/8gx $sp
stepi
x/8gx $sp
echo (arriba: el stp ya guardo x29 y x30 en el stack)\n

continue
echo \n=== Parada en comparar: x16 = comando, x18 = longitud ===\n
info registers x16 x17 x18 x19 x30 sp
x/8gx $sp

# Usa 'continue' para llegar a fork y execve si el comando es externo
