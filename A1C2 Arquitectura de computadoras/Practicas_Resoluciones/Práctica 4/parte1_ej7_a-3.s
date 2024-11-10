# 7. Operaciones con vectores ⭐⭐
# a) Definir un vector con 10 valores , y escribir programas para:
# - Modificar valores Modificar los elementos del vector, de modo que cada elemento se multiplique por 2.

.data
  V: .word 1, 2, 3, 4, 5, 6, 16, 8, 9, 0
.code
  daddi $t1, $zero, 10  # Inicio índice t1 = 10
  dadd $t2, $zero, $zero  # Inicio desplazador de vector t2 = 0
  daddi $t4, $t4, 2
LAZO:
  ld $t0, V($t2)  # Cargo el valor en t0 
  dmul $t0, $t0, $t4  # Multiplico el valor de t0 * 2
  sd $t0, V($t2)  # Guardo t0 en la posición vector(desplazador)
  daddi $t1, $t1, -1  # -1 al índice
  daddi $t2, $t2, 8  # +8 al desplazador
  beqz $t1, FIN  # El índice es 0? SI > Me voy a FIN
  j LAZO # salto a LAZO
FIN:
halt