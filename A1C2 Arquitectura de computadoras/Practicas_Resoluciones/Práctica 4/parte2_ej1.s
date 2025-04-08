# 1. Lectura e impresión de strings.⭐
# El siguiente programa produce la salida de un mensaje predefinido en la ventana Terminal del simulador
# WinMIPS64.

# .data
#     texto: .asciiz "Hola, Mundo!" # El mensaje a mostrar
#     CONTROL: .word 0x10000
#     DATA: .word 0x10008
# .code
#     ld $t0, CONTROL($zero) # $t0 = dirección de CONTROL
#     ld $t1, DATA($zero) # $t1 = dirección de DATA
#     daddi $t2, $zero, texto # $t2 = dirección del mensaje a mostrar
#     sd $t2, 0($t1) # DATA recibe el puntero al comienzo del mensaje
#     daddi $t2, $zero, 4 # $t2 = 4 -> función 4: salida de una cadena ASCII
#     sd $t2, 0($t0) # CONTROL recibe 4 y produce la salida del mensaje
# halt

# a) ¿Qué valor tienen los registros $t0 y $t1?
# >> $t0 tiene el valor de la dirección de CONTROL, lo utilizamos como puntero a la hora de enviar un comando.
# >> $t1 tiene el valor de la dirección de DATA, lo utilizamos como puntero a la hora de enviar la información a operar.
# b) Modifique el programa (a) para que el mensaje se muestre 10 veces.

.data
    texto: .asciiz "Hola, Mundo!" # El mensaje a mostrar
    CONTROL: .word 0x10000
    DATA: .word 0x10008
.code
    ld $t0, CONTROL($zero) # $t0 = dirección de CONTROL
    ld $t1, DATA($zero) # $t1 = dirección de DATA
    daddi $t2, $zero, texto # $t2 = dirección del mensaje a mostrar
    sd $t2, 0($t1) # DATA recibe el puntero al comienzo del mensaje
    daddi $t2, $zero, 4 # $t2 = 4 -> función 4: salida de una cadena ASCII
    daddi $t3, $0, 10
LAZO: sd $t2, 0($t0) # CONTROL recibe 4 y produce la salida del mensaje
      daddi $t3, $t3, -1
      bnez $t3, LAZO
halt