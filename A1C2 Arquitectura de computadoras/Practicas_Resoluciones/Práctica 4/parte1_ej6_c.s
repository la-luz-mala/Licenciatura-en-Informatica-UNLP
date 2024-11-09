# 6. Recorrido básico de vectores⭐
# c) Calcular la suma de los 3 valores utilizando un lazo, con una dirección base de 0 y un registro como puntero.
# Pista: Cargar la dirección en un registro con daddi $t2, $zero, V y luego cargar los valores con ld $t1,
# 0($t2)

.data
    V: .word 5, 2, 6
    SUMA: .word 0
.code
    dadd $t0, $zero, $zero # Inicializo $t0 en 0 - aux acumulador (AA)
    daddi $t2, $zero, V # Inicializo $t2 en V - aux de desplazamiento (AD)
    daddi $t3, $zero, 3 # Inicializo $t3 en 3 - aux contador (AC)
loop: 
    ld $t1, 0($t2) # cargo V en $t1
    dadd $t0, $t0, $t1 # sumo el número a AA
    daddi $t2, $t2, 8 # sumo 8 a AD
    daddi $t3, $t3, -1 # Resto 1 al AC
    bnez $t3, loop # Si $t3 != 0, salto al lazo
    sd $t0, SUMA($zero) # Cargo el resultado de AA en SUMA
halt
