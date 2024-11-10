# 9. Operaciones con strings⭐⭐
# c) d) Generar string Escribir un programa que genere un string de la siguiente forma: “abbcccddddeeeee….”, así hasta la
# letra “h”. Para ello debe utilizar un loop e ir guardando los códigos ascii en la memoria. El string debe finalizar con el
# valor ascii 0 para que esté bien formado (debe agregar un elemento más, que valga 0, al final del string).

.data
        cadena: .ascii 0
.code
        daddi $s0, $0, 0 # s0 inicializamos auxiliar de desplazamiento
        daddi $s1, $0, 0x61 # s1 cargar el valor "a" en una variable con 0x61
        daddi $s2, $0, 0x68 # s2 cargar el valor "h" en una variable con 0x68 (donde terminamos)
        daddi $s3, $0, 1 # s3 inicializamos auxiliar de letra, empieza en 1
        daddi $s4, $0, 0 # s4 inicializo cant de letras guardadas en 0

LAZO:   sb $s1, cadena($s0) # lazo: guardo s1 en cadena
        daddi $s0, $s0, 1 # +1 a aux de desplazamiento
        daddi $s4, $s4, 1 # +1 a cant guardadas
        bne $s3, $s4, LAZO # aux de letra = cant guardadas? NO -> lazo
        daddi $s1, $s1, 1 # +1 a S1 para cambiar de letra
        beq $s1, $s2, FIN # s1 es = s2? SI -> fin
        daddi $s4, $0, 0 # vuelvo s4 a 0
        daddi $s3, $s3, 1 # +1 a aux de letra
        j LAZO # j lazo
FIN:    sb $0, cadena($s0)
halt
