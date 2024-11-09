# 6. Recorrido básico de vectores⭐
# Dado un vector definido como: V: .word 5, 2, 6, escribir programas para:
# b) Calcular la suma de los 3 valores utilizando un lazo con la dirección base y un registro como desplazamiento.
# Pista: Idem anterior, pero ahora con una única instrucciones de lectura y $t2 se incrementa dentro de un loop

.data
    V: .word 5, 2, 6
    SUMA: .word 0
.code
    dadd $t2, $zero, $zero # Inicializo $t2 en 0 - aux de desplazamiento (AD)
    dadd $t1, $zero, $zero # Inicializo $t1 en 0 - aux acumulador (AA)
loop: 
    ld $t0, V($t2) # cargo V en $t0
    dadd $t1, $t1, $t0 # sumo el número a AA
    daddi $t2, $t2, 8 # sumo 8 a AD
    slti $t3, $t2, 17 # Si el AD es > que 17 quiere decir que me pasé
    bnez $t3, loop # Si $t3 != 0 (o sea, si AD < 17), salto al lazo
    sd $t1, SUMA($zero) # Cargo el resultado de AA en SUMA
halt
