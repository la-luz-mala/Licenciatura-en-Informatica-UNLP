# 4. Pantalla gráfica: puntos y líneas
# El siguiente programa pinta el pixel con coordenadas (24,24) de la pantalla gráfica de color de magenta. Ir a Ventana
# →Terminal en el simulador WinMIPS64 para ver el resultado luego de ejecutar el programa.
# a) Desde teclado⭐Modifique el programa anterior para que las coordenadas X e Y del punto a pintar se lean de
# teclado.
.data
    coorX:      .byte   0 ; coordenada X de un punto
    coorY:      .byte   0 ; coordenada Y de un punto
    color:      .byte   255, 0, 255, 0 ; color: máximo rojo + máximo azul => magenta
    CONTROL:    .word   0x10000
    DATA:       .word   0x10008
    msj1:       .asciiz "Ingrese coordenada X\n"
    msj2:       .asciiz "Ingrese coordenada Y\n"
.code
    ld $s7, CONTROL($zero); $s7 = dirección de CONTROL
    ld $s6, DATA($zero) ; $s6 = dirección de DATA

    # Imprimir mensaje
    daddi $s0, $0, msj1 # Traigo el primer mensaje
    sd $s0, 0($s6) # Lo mando a Data
    daddi $t0, $0, 4 # Cargo 4 para imprimir ASCII
    sd $t0, 0($s7) # Mando el comando de impresión

    # Permito ingresar valor del teclado
    daddi $t0, $0, 8 # Cargo 8 para permitir ingresar un número
    sd $t0, 0($s7) # Mando el comando de impresión

    # Recupero el valor ingresado
    ld $s1, 0($s6) # Cargo en s1 lo ingresado en DATA

    # Imprimir mensaje 2
    daddi $s0, $0, msj2 # Traigo el primer mensaje
    sd $s0, 0($s6) # Lo mando a Data
    daddi $t0, $0, 4 # Cargo 4 para imprimir ASCII
    sd $t0, 0($s7) # Mando el comando de impresión

    # Permito ingresar valor del teclado
    daddi $t0, $0, 8 # Cargo 8 para permitir ingresar un número
    sd $t0, 0($s7) # Mando el comando de impresión

    # Recupero el valor ingresado
    ld $s2, 0($s6) # Cargo en s1 lo ingresado en DATA

    sb $s1, 5($s6) ; DATA+5 recibe el valor de coordenada X
    sb $s2, 4($s6) ; DATA+4 recibe el valor de coordenada Y
    lwu r1, color($zero) ; r1 = valor de color a pintar (4 bytes)
    sw r1, 0($s6) ; DATA recibe el valor del color a pintar
    daddi r1, $zero, 5; r1 = 5 -> función 5: salida gráfica
    sd r1, 0($s7) ; CONTROL recibe 5 y produce el dibujo del punto
halt

