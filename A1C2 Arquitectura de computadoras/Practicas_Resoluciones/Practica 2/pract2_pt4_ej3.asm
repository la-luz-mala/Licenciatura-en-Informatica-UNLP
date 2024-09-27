;3) Llaves y mensajes⭐⭐
;a) Escribir un programa que continuamente verifique el estado de las llaves. Si están prendidas la
;primera y la última llave, y el resto están apagadas (patrón 1000H0001), se debe mostrar en pantalla el
;mensaje "ACTIVADO". En caso contrario, no se debe mostrar nada.

PA EQU 30H
CA EQU 32H

ORG 1000H
MSJ DB "ACTIVADO", 0AH
ORG 3000H
INI_PIO:
;CA:
    MOV AL, 0FFH ; 0FFH si es clavijas o 0FDH si es impresora
    OUT CA, AL
    ;CB - solo si usamos los leds
    ;STROBE - solo si es impresora
RET

ORG 2000H
CALL INI_PIO ; inicializo PIO
INGRESO: IN AL, PA ; traigo el valor de clavijas
XOR AL, 10000001B ;comparo con 1000 0001B
JNZ INGRESO ; si no es cero, me fijo de nuevo
MOV BX, OFFSET MSJ ; si es cero, imprimo el msj
MOV AL, 9
INT 7
JMP INGRESO
INT 0
END


;b) Modificar a) para que el mensaje se imprima una sola vez cada vez que detecte ese patrón de bits. Por
;ejemplo, si el programa lee la siguiente secuencia de patrones:
;00010101 → 10010000 → 10000001 → 10000001 → 10000001 → 10010001 → 10000001 →
;10000001 → 10010101 → 01110001
;Entonces solo deberá imprimir “ACTIVADO” dos veces.

