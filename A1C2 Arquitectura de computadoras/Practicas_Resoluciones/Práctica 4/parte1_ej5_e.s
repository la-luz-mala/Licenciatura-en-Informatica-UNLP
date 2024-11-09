# 5. Programas simples⭐⭐.
# Escribir un programa en WinMIPS64 que:
# e) Guarda en B el valor 1 si A es impar y 0 de lo contrario
# if impar(A):
# B = 1
# else:
# B = 0

.data
    A:  .word 6
    B:  .word 0
.code
    ld $t0, A($zero) # load A en $t0
    andi $t0, $t0, 1 # andi t0 con 1 y guardar en t0
    sd $t0, B($zero) # save t0 en B
halt