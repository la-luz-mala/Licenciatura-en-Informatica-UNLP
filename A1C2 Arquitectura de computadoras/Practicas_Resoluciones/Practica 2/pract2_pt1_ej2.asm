;2) Uso de las luces y las llaves a través del PIO.⭐⭐
;Ejecutar los programas con el simulador VonSim utilizando los dispositivos “Llaves y Luces” que conectan
;las llaves al puerto PA del PIO y a las luces al puerto PB.
;a) Patrón de Luces Fijo Escribir un programa que encienda las luces con el patrón 11000011, o sea, solo
;las primeras y las últimas dos luces deben prenderse, y el resto deben apagarse.

PA EQU 30H ; Inicializo clavijas
PB EQU 31H ; Inicializo leds
CA EQU 32H ; Inicializo seteo de clavijas
CB EQU 33H ; Inicializo seteo de leds

ORG 2000
MOV AL, 00h 
OUT CB, AL ; Habilito todos los leds como salida con 00h
MOV AL, 11000011B ; Muevo el valor deseado a AL
OUT PB, AL ; Envío a los leds el valor deseado
INT 0
END

;b) Verificar Llave Escribir un programa que verifique si la llave de más a la izquierda está prendida. Si es
;así, mostrar en pantalla el mensaje “Llave prendida”, y de lo contrario mostrar “Llave apagada”. Solo
;importa el valor de la llave de más a la izquierda (bit más significativo). Recordar que las llaves se
;manejan con las teclas 0-7.

PA EQU 30H
PB EQU 31H
CA EQU 32H
CB EQU 33H

ORG 1000h
WIN DB "Llave prendida"
FAIL DB "Llave apagada"
FN DB ?

ORG 2000h
MOV AL, 0FFH
OUT CA, AL ; Seteo las clavijas todas como IN
IN AL, PA ; Traigo el valor de las clavijas a AL
AND AL, 1 ; Hago un AND con 0000 0001 - si da cero, el bit de más a la izq esta en cero, sino está en 1
JNZ PRENDIDA
;Si está apagado, imprimo:
MOV BX, OFFSET FAIL
MOV AL, OFFSET FAIL - OFFSET FN
INT 7
JMP FIN
;Si está prendido, imprimo:
PRENDIDA: 
MOV BX, OFFSET WIN
MOV AL, OFFSET FAIL - OFFSET WIN
INT 7

FIN: INT 0
END


;c) Control de luces mediante llaves Escribir un programa que permite encender y apagar las luces
;mediante las llaves. El programa no deberá terminar nunca, y continuamente revisar el estado de las
;llaves, y actualizar de forma consecuente el estado de las luces. La actualización se realiza simplemente
;prendiendo la luz i, si la llave i correspondiente está encendida (valor 1), y apagándola en caso
;contrario. Por ejemplo, si solo la primera llave está encendida, entonces solo la primera luz se debe
;quedar encendida.

PA EQU 30H
PB EQU 31H
CA EQU 32H
CB EQU 33H

ORG 2000H
MOV AL, 0FFH
OUT CA, AL ; Indico con 0FFh que todas las llaves están activas para INGRESO
MOV AL, 0
OUT CB, AL ; Indico con 00h que todos los leds están activos para SALIDA
LOOP: 
IN AL, PA ; Tomo el valor que tengan las llaves
OUT PB, AL ; Envío el valor a los leds
JMP LOOP ; Loop infinito
INT 0
END