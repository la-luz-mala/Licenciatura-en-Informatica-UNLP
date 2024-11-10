# 7. Operaciones con vectores ⭐⭐
# a) Definir un vector con 10 valores , y escribir programas para:
# - Calcular máximo. Calcular el máximo elemento del vector y guardarlo en una variable llamada MAX.

.data
  V: .word 1, -2, 3, -4, 5, -6, 16, -8, 9, 0
  MAX: .word 0
.code
    dadd $t1, $zero, $zero # Inicio $t1 en cero, aux de desplazamiento (AD)
    dadd $t2, $zero, $zero # Inicio $t2 en cero, donde guardaré el max
    daddi $t3, $zero, 10 # Inicio $t3 en 10, mi índice (IN)
LAZO:
    ld $t0, V($t1) # LAZO: Cargo en $t0 el num del vector
    slt $t4, $t0, $t2 # T0 < t2?
    bnez $t4, SEGUIR # Si es menor, salto a SEGUIR
    dadd $t2, $t0, $zero # Si no es menor, muevo t0 a t2
SEGUIR:
    daddi $t1, $t1, 8 # sumo +8 a AD
    daddi $t3, $t3, -1 # Resto 1 a IN
    bnez $t3, LAZO # IN es 0? Si != 0 salto a LAZO
    sd $t2, MAX($zero) # Guardo el valor máximo en MAX
halt