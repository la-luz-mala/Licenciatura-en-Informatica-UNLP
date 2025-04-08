# 4. Pantalla gráfica: puntos y líneas
# El siguiente programa pinta el pixel con coordenadas (24,24) de la pantalla gráfica de color de magenta. Ir a Ventana
# →Terminal en el simulador WinMIPS64 para ver el resultado luego de ejecutar el programa.
# b) Cambio de color ⭐Modifique el programa original para que el punto vaya cambiando de color, desde negro
# (255,0,0) hasta rojo puro (255,0,0).

.data
    coorX:   .byte 0 # coordenada X de un punto
    coorY:   .byte 0 # coordenada Y de un punto
    color:  .byte 0, 0, 0, 0 # color: máximo rojo + máximo azul => magenta
    CONTROL: .word 0x10000
    DATA:    .word 0x10008
.code
    ld $t0, CONTROL($zero) # $t0 = dirección de CONTROL
    ld $t1, DATA($zero) # $t1 = dirección de DATA
    lwu $t2, color($zero) # $t2 = valor de color a pintar (4 bytes)
    sw $t2, 0($t1) # DATA recibe el valor del color a pintar
    lbu $t2, coorX($zero) # $t2 = valor de coordenada X
    sb $t2, 5($t1) # DATA+5 recibe el valor de coordenada X
    lbu $t2, coorY($zero) # $t2 = valor de coordenada Y
    sb $t2, 4($t1) # DATA+4 recibe el valor de coordenada Y
    daddi $t2, $zero, 5 # $t2 = 5 -> función 5: salida gráfica
    sd $t2, 0($t0) # CONTROL recibe 5 y produce el dibujo del punto
    daddi $t3, $0, 0 # Inicio contador en 0
    LOOP:
    daddi $t3, $t3, 1
    sb $t3, 0($t1) # Actualizo solo el byte de RED
    daddi $t2, $zero, 5 # $t2 = 5 -> función 5: salida gráfica
    sd $t2, 0($t0) # CONTROL recibe 5 y produce el dibujo del punto
    slti $s0, $t3, 256 # t3 < 256?
    bnez $s0, LOOP # Si es menor, vuelvo a loopear
halt


