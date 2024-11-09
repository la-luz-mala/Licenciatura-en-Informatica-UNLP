# 5. Programas simples⭐⭐.
# Escribir un programa en WinMIPS64 que:
# a) Lee 2 números A y B de la memoria de datos, y calcula S, P y D, que luego se guardan en la memoria de datos.

.data
    A:  .word 5
    B:  .word 6
    S:  .word 0
    P:  .word 0
    D:  .word 0
.code
    ld $t0, A($zero)
    ld $t1, B($zero)
    dadd $t2, $t0, $t1
    sd $t2, S($zero)
    # A + B
    dmul $t2, $t0, $t1
    daddi $t2, $t2, 2
    sd $t2, P($zero)
    # 2 + (A * B)
    dmul $t2, $t0, $t0
    ddiv $t2, $t2, $t1
    sd $t2, D($zero)
    # A^2 / B
halt