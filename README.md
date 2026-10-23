# MiniShell — Intérprete de comandos en ARM-64 puro

Proyecto 2 — Arquitectura de Computadores y Ensambladores 1 (USAC, 2S 2026).
Escrito en ensamblador ARM-64 (GAS), sin C ni bibliotecas: toda la interacción
con el sistema es mediante syscalls de Linux.

## Requisitos
Linux ARM64 nativo, o x86-64 con QEMU user-mode:
```bash
sudo apt install binutils-aarch64-linux-gnu qemu-user make gdb-multiarch
```

## Compilar y ejecutar
```bash
make          # compila (genera ./programa)
make run      # compila y ejecuta con QEMU
make clean    # limpia
```
En ARM64 nativo: `make CROSS= QEMU=` y luego `./programa`.

## Comandos
| Comando | Descripción |
|---|---|
| `help` | lista los comandos internos |
| `echo <texto>` | imprime el texto |
| `clear` | limpia la pantalla |
| `exit` (o Ctrl+D) | sale del shell |
| otro | se ejecuta como programa externo (`ls`, `pwd`, `date`, `/bin/echo hola`) |

Manejo de errores: línea vacía (nuevo prompt), línea de más de 62 caracteres
(aviso y descarte), comando inexistente (mensaje de error).

## Archivos
| Archivo | Contenido |
|---|---|
| `practica.s` | `_start`, `read`, `verificar_largo`, `exit`, `print`, `error`, buffers |
| `leer_comando.s` | `intrucion_init`: parsing (comando / mensaje) |
| `interpretar.s` | `comparar`: despacho a builtins o externo |
| `help.s`, `echo.s`, `clear.s` | comandos internos |
| `fork.s`, `execve.s`, `wait.s` | ejecución de externos (clone, execve, wait4) |

## Depuración con GDB
```bash
make debug      # terminal 1: QEMU espera a GDB
make gdb        # terminal 2: corre s.gdb (breakpoints, x/8gx $sp, info registers)
```

## Pruebas
```bash
make test       # casos automáticos (pruebas.sh)
```
