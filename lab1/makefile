# Nombre del archivo ensamblador sin la extensión
TARGET = s4c

# Nombre del archivo objeto intermedio
OBJ = s0.o

# Nombre del archivo ejecutable final
EXEC = s0

# Comandos de compilación, enlazado y ejecución
AS = sisa-as --gstabs+
LD = sisa-ld
DBG = sisa-dbg

# Regla por defecto: compilar, enlazar y ejecutar
all: $(EXEC)
	$(DBG) $(EXEC)

# Regla para ensamblar el archivo fuente
$(OBJ): $(TARGET).s
	$(AS) -o $(OBJ) $(TARGET).s

# Regla para enlazar el archivo objeto y crear el ejecutable
$(EXEC): $(OBJ)
	$(LD) -o $(EXEC) $(OBJ)

# Regla para depurar el ejecutable
debug: $(EXEC)
	$(DBG) $(EXEC)

# Regla para limpiar los archivos generados
clean:
	rm -f $(OBJ) $(EXEC)