#!/bin/bash
# Pruebas automaticas de MiniShell. Uso: bash pruebas.sh ./programa
# Cada linea se envia con una pausa, como si se tecleara.
BIN=${1:-./programa}
QEMU=${QEMU-qemu-aarch64}
pass=0; fail=0
run() { local IFS='|'; local cmds=($1)
  ( for c in "${cmds[@]}"; do printf '%s\n' "$c"; sleep 0.3; done ) | timeout 10 $QEMU $BIN 2>&1; }
ok()   { echo "OK    $1"; pass=$((pass+1)); }
bad()  { echo "FALLA $1"; fail=$((fail+1)); }
check() { local out; out=$(run "$2"); if grep -qF -- "$3" <<<"$out"; then ok "$1"; else bad "$1  (esperaba: $3)"; fi; }
check_not() { local out; out=$(run "$2"); if grep -qF -- "$3" <<<"$out"; then bad "$1  (no debia aparecer: $3)"; else ok "$1"; fi; }

check     "prompt"                    "exit"                      "OMEGA_TERMINAL>"
check     "help"                      "help|exit"                 "Comandos comunes"
check     "echo"                      "echo hola mundo|exit"      "hola mundo"
check     "echo: espacios extra"      "echo     hola|exit"        "OMEGA_TERMINAL>hola"
check     "echo: tab"                 $'echo\thola|exit'           "OMEGA_TERMINAL>hola"
check     "espacios antes del comando" "   echo hola|exit"        "OMEGA_TERMINAL>hola"
check     "clear (ANSI)"              "clear|exit"                $'\033[2J'
check     "externo pwd"               "pwd|exit"                  "/"
check     "externo ls con args"       "ls -l /|exit"              "total"
check     "externo date"              "date|exit"                 "20"
check     "ruta con /"                "/bin/echo directo|exit"    "directo"
check     "desconocido: mensaje"      "noexiste|exit"             "No se pudo ejecutar el comando"
check     "desconocido: sigue vivo"   "noexiste|echo vivo|exit"   "vivo"
check_not "linea vacia no ejecuta"    "|echo despues|exit"        "No se pudo ejecutar"
check     "linea vacia: sigue vivo"   "|echo despues|exit"        "despues"
check     "linea larga: aviso"        "echo $(printf 'a%.0s' {1..90})|echo ok|exit" "excede 62"
check_not "linea larga: no ejecuta resto" "echo $(printf 'a%.0s' {1..90})|echo ok|exit" "No se pudo ejecutar"
check     "linea larga: sigue vivo"   "echo $(printf 'a%.0s' {1..90})|echo ok|exit" "OMEGA_TERMINAL>ok"
check     "exit"                      "exit"                      "OMEGA_TERMINAL>"
( printf 'echo x\n'; sleep 0.3 ) | timeout 5 $QEMU $BIN >/dev/null 2>&1; rc=$?
if [ $rc -ne 124 ]; then ok "EOF (Ctrl+D) termina limpio"; else bad "EOF (Ctrl+D) se cicla"; fi
echo "---- $pass OK, $fail FALLAS"
[ $fail -eq 0 ]
