# 5. Programas simples⭐⭐.
# Escribir un programa en WinMIPS64 que:
# c) Calcula el factorial de N, y lo guarda en F
# F = 1
# for i=1..N:
# F = F * i

.data
    N:  .word 5
    F:  .word 1
.code
    ld $t0, F($zero) # Cargar F = 1 en t0
    ld $t1, N($zero) # Cargar N = 3 en t1
    daddi $t1, $t1, 1 # Sumar 1 a t1 para que se ejecute la multiplicación cuando aux = N
    daddi $t2, $zero, 1 # Inicializar t2 en 1 como auxiliar
loop:
    beq $t1, $t2, fin # chequear si t2 = t1
    dmul $t0, $t0, $t2 # DMUL t0 con el auxiliar t2
    daddi $t2, $t2, 1  # aumentar t2
    j loop # si NO, saltar a loop
    fin: # si SI, saltar a guardar t0 en F
    sd $t0, N($zero)
halt