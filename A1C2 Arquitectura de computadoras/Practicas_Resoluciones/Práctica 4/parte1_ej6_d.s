# 6. Recorrido básico de vectores⭐
# d) ¿Qué cambios se deberían realizar al programa del inciso b) si los elementos fueran de 32 bits: V: .word32 5,
# 2, 6?

.data
    V: .word32 5, 2, 6
    SUMA: .word32 0
.code
    dadd $t2, $zero, $zero # Inicializo $t2 en 0 - aux de desplazamiento (AD)
    dadd $t1, $zero, $zero # Inicializo $t1 en 0 - aux acumulador (AA)
loop: 
    ld $t0, V($t2) # cargo V en $t0
    dadd $t1, $t1, $t0 # sumo el número a AA
    daddi $t2, $t2, 32 # sumo 8 a AD
    slti $t3, $t2, 65 # Si el AD es > que 17 quiere decir que me pasé
    bnez $t3, loop # Si $t3 != 0 (o sea, si AD < 17), salto al lazo
    sd $t1, SUMA($zero) # Cargo el resultado de AA en SUMA
halt
