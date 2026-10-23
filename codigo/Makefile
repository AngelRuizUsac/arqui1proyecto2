# MiniShell ARM-64 - Makefile
# make        -> compila todo con un solo comando (genera ./programa)
# make run    -> compila y ejecuta con QEMU
# make debug  -> ejecuta bajo QEMU esperando a GDB en el puerto 1234
# make gdb    -> (en otra terminal) abre GDB y corre el script s.gdb
# make test   -> corre las pruebas automaticas (pruebas.sh)
# make clean  -> borra objetos y binario
#
# En una maquina ARM64 nativa:  make CROSS= QEMU=

CROSS  ?= aarch64-linux-gnu-
QEMU   ?= qemu-aarch64
AS      = $(CROSS)as
LD      = $(CROSS)ld
GDB    ?= gdb-multiarch

TARGET  = programa
MAIN    = practica.s
INCS    = $(filter-out $(MAIN),$(wildcard *.s))

all: $(TARGET)

$(TARGET): practica.o
	$(LD) $< -o $@

practica.o: $(MAIN) $(INCS)
	$(AS) -g $(MAIN) -o $@

run: $(TARGET)
	$(QEMU) ./$(TARGET)

debug: $(TARGET)
	@echo "Esperando a GDB en :1234 (en otra terminal: make gdb)"
	$(QEMU) -g 1234 ./$(TARGET)

gdb: $(TARGET)
	$(GDB) -q -x s.gdb $(TARGET)

test: $(TARGET)
	QEMU="$(QEMU)" bash ./pruebas.sh ./$(TARGET)

clean:
	rm -f *.o $(TARGET)

.PHONY: all run debug gdb test clean
