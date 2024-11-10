# 7. Operaciones con vectores ⭐⭐
# b) Impares Generar un vector con los primeros 10 números impares.

.data
  V: .word 0
.code
  daddi $t0, $zero, 10  # Inicializar contador en 10
  dadd $t1, $zero, $zero  # inicializar desplazador de vector en 0
  dadd $t2, $zero, $zero  # Inicializar numero en 0
LAZO:
  andi $t3, $t2, 1  # Numero and 1 = t3
  beqz $t3, NEXT  # T3 = 0? SI -> next
  sd $t2, V($t1)  # cargar el número en el vector
  daddi $t1, $t1, 8  # vector +8
  daddi $t0, $t0, -1  # No -> contador -1
NEXT:
  daddi $t2, $t2, 1  # next: numero +1
  beqz $t0, FIN  # contador = 0? si -> fin
  j LAZO  # no - jmp lazo
FIN:
halt