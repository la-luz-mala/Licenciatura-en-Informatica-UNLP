# 7. Operaciones con vectores ⭐⭐
# a) Definir un vector con 10 valores , y escribir programas para:
# - Contar positivos. Contar la cantidad de elementos positivos, y guardar la cantidad en una variable llamada POS.

.data
  V: .word -1, -2, -3, -4, -5, -6, 7, -8, 9, 0
  POS: .word 0
.code
    dadd $t1, $zero, $zero # inicializar t1 en 0, va a ser mi movimiento en el vector
    dadd $t2, $zero, $zero # inicializar t2 en cero, va a ser mi contador POS
    daddi $t3, $zero, 10 # inicializar t3 en 10, va a ser mi índice
LAZO:
    ld $t0, V($t1) # LAZO: cargar un num del vector en t0 con ($t1) de movimiento
    slti $t0, $t0, 0 # chequear si el numero q traje < 0
    bnez $t0, SEGUIR # si ES MENOR, saltar a SEGUIR
    daddi $t2, $t2, 1 # si no, sumar 1 a POS
SEGUIR:
    daddi $t1, $t1, 8 # SEGUIR: +8 a vector
    daddi $t3, $t3, -1 # -1 a índice
    bnez $t3, LAZO # si índice != 0, saltar a LAZO
    sd $t2, POS($zero) # sino: cargar t2 en POS
halt