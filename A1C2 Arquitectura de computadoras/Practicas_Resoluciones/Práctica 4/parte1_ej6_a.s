# 6. Recorrido básico de vectores⭐
# Dado un vector definido como: V: .word 5, 2, 6, escribir programas para:
# a) Calcular la suma de los 3 valores sin utilizar un loop o lazo
# Pista: Usar tres instrucciones ld $t1, V($t2), donde $t2 va aumentando de a 8 bytes el desplazamiento.

.data
    V: .word 5, 2, 6
    SUMA: .word 0
.code
    ld $t0, V($zero) # cargo V en $t0
    dadd $t1, $zero, $t0 # sumo el primer número a $t1
    daddi $t2, $zero, 8 # cargo 8 en $t2, reg. auxiliar para desplazarme
    ld $t0, V($t2) # cargo el 2do número del vector en $t0
    dadd $t1, $t1, $t0 # sumo el 2do número del vector al acumulador
    daddi $t2, $t2, 8 # aumento el aux desplazamiento x 8
    ld $t0, V($t2) # cargo el 3er número del vector en $t0
    dadd $t1, $t1, $t0 # sumo el 3er número del vector al acumulador
    sd $t1, SUMA($zero) # guardo el total en SUMA
halt
