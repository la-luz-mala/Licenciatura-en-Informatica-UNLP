# 5. Programas simples⭐⭐.
# Escribir un programa en WinMIPS64 que:
# b) Dadas dos variables A y B de la memoria, calcula y almacena C

# if A == 0:
# C = 0
# else:
# if A > B:
# C = A * 2
# else:
# C = B

.data
    A:  .word 3
    B:  .word 1
    C:  .word 0
.code
    ld $t0, A($zero)
    ld $t1, B($zero)
    bnez $t0, not_zero
    dadd $t2, $zero, $zero
    sd $t2, C($zero)
    j end
not_zero:
    slt $t2, $t1, $t0
    # B es menor a A? si es verdadero, T2 = 1. Si es falso, T2 = 0
    bnez $t2, op
    dadd $t2, $zero, $t1
    sd $t2, C($zero)
    j end
op: # C = A * 2
    dadd $t2, $t0, $t0
    sd $t2, C($zero)
end: halt