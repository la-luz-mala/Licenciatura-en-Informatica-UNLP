# 5. Programas simples⭐⭐.
# Escribir un programa en WinMIPS64 que:
# d) Calcula el logaritmo (entero) en base 2 de N (N positivo) mediante divisiones sucesivas y lo guarda en L
# L = 0
# while N > 0:
# N = N / 2
# L = L + 1

.data
    L:  .word 0
    N:  .word 64
.code
    ld $t0, L($zero) # load L in t0
    ld $t1, N($zero) # load N in t1
    daddi $t2, $zero, 2 # cargo 2 en un registro para usar en el div
lazo:
    slt $t3, $t1, $t2 # si N < 2, t3 = 1 (para evitar el N = 1 del último loop)
    bnez $t3, end
    ddivu $t1, $t1, $t2 # si != 0, N = N / 2
    daddi $t0, $t0, 1 # L++
    j lazo
end: # terminar: 
    sd $t0, L($zero) # cargar L
halt