# Makefile

# Variables: definís una vez, usás en cualquier lugar
CC      = gcc
CFLAGS  = -shared -fPIC -g3
LIB     = src/libgini.so
SRC     = src/gini_calc.c src/func_asm.s

# Regla principal: "make" o "make all" compila todo
all: $(LIB)

# Regla para construir libgini.so
# Formato: objetivo: dependencia
#              comando (DEBE empezar con un TAB, no espacios)
$(LIB): $(SRC)
	$(CC) $(CFLAGS) -o $(LIB) $(SRC)
	@echo "✓ $(LIB) compilado correctamente"

# Regla para ejecutar el programa completo
run: $(LIB)
	python3 src/main.py

# Regla para limpiar los archivos generados
clean:
	rm -f $(LIB)
	@echo "✓ Archivos generados eliminados"

# Le dice a make que "clean", "run" y "all" no son archivos reales
.PHONY: all run clean