# 4. Pantalla gráfica: puntos y líneas
# El siguiente programa pinta el pixel con coordenadas (24,24) de la pantalla gráfica de color de magenta. Ir a Ventana
# →Terminal en el simulador WinMIPS64 para ver el resultado luego de ejecutar el programa.
# c) Línea azul ⭐⭐Modifique el programa original para pintar una línea horizontal de 50 pixeles desde el 0,0
# hasta el 0,49 de azul puro.

.data
coorX:      .byte 0 # coordenada X de un punto
coorY:      .byte 0 # coordenada Y de un punto
color:      .byte 0, 0, 255, 0 # color: máximo rojo + máximo azul => magenta
CONTROL:    .word 0x10000
DATA:       .word 0x10008

.code
    ld $t0, CONTROL($zero) # $t0 = dirección de CONTROL
    ld $t1, DATA($zero) # $t1 = dirección de DATA
    lwu $t2, color($zero) # $t2 = valor de color a pintar (4 bytes)
    sw $t2, 0($t1) # DATA recibe el valor del color a pintar
    lbu $t2, coorX($zero) # $t2 = valor de coordenada X
    sb $t2, 5($t1) # DATA+5 recibe el valor de coordenada X
    lbu $t3, coorY($zero) # $t3 = valor de coordenada Y
    sb $t3, 4($t1) # DATA+4 recibe el valor de coordenada Y
    daddi $t2, $zero, 5 # $t2 = 5 -> función 5: salida gráfica
    
    LOOP:
    sd $t2, 0($t0) # enviar instrucción de impresión
    daddi $t3, $t3, 1 # incrementar coordenada Y
    sb $t3, 4($t1) # enviar a DATA
    slti $t4, $t3, 50
    bnez $t4, LOOP
halt