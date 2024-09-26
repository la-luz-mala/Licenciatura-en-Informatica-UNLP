;1) PIO con dispositivos genéricos⭐⭐⭐
;Si bien el PIO solo permite conectarse a las luces, interruptores y la impresora en este simulador, al ser un
;dispositivo programable podríamos utilizarlo para interactuar con nuevos dispositivos que no cuenten con un
;hardware especializado para interactuar con ellos. En los siguientes incisos, te proponemos escribir programas
;que usen nuevos dispositivos ficticios, pero con un protocolo de comunicación definido. Nota: los dispositivos
;nuevos no están implementados en el simulador, pero podés probar el funcionamiento del programa utilizando
;las luces y las llaves haciendo de cuenta que sirven como entrada y salida del dispositivo.
;a) Escribir un programa que, utilizando el puerto PB del PIO, envíe la cadena de caracteres “UNLP” a un
;dispositivo nuevo. Este dispositivo debe recibir la cadena de a un carácter a la vez. Para distinguir
;entre caracteres, el dispositivo necesita que antes de cada carácter nuevo se envíe el código ASCII 0.
;Además, para indicar que se finalizó el envío, debe mandarse el código ASCII 255.
;Ejemplo: Para transmitir la cadena “UNLP”, debe enviarse: 0, “U”, 0, “N”, 0, “L”, 0, “P”, 255

PB EQU 31H 
CB EQU 33H

ORG 1000H
STRING DB "UNLP", 255
FIN DB ?
CERO DB 0

ORG 3000H
INI_PIO:
    MOV AL, 0
    OUT CB, AL
RET

IMPRIMIR:
    MOV AL, BYTE PTR [BX]
    OUT PB, AL
    MOV AL, 0
    OUT PB, AL
    INC BX
    CMP BYTE PTR [BX], 255
    JNZ IMPRIMIR
RET
ORG 2000H
    MOV BX, OFFSET STRING
    CALL INI_PIO
    CALL IMPRIMIR
INT 0
END


;b) Escribir un programa que reciba una cadena de caracteres de un dispositivo nuevo conectado a los
;puertos PA y PB. Este dispositivo envía la cadena de a un carácter a la vez. Para que el dispositivo sepa
;cuándo la CPU está lista para recibir un carácter, la CPU deberá enviar el valor FF al dispositivo a
;través del puerto PB. Luego, la CPU deberá leer desde el puerto PA, y volver a enviar el valor FF al
;dispositivo. La transmisión termina cuando se recibe el código ASCII 0.
;Ejemplo para recibir la cadena “ASD”: CPU envía el FF por PB → CPU recibe “A” por PA → CPU envía
;el FF por PB → CPU recibe “S” por PA → CPU envía el FF por PB → CPU recibe “D” por PA → CPU
;envía el FF por PB → CPU recibe 0 por PA

PA EQU 30H
PB EQU 31H
CA EQU 32H
CB EQU 33H

ORG 1000H
STRING DB ?

ORG 3000H
INI_PIO:
    MOV AL, 0FFH
    OUT CA, AL

    MOV AL, 0
    OUT CB, AL
RET

ORG 2000H
    CALL INI_PIO
    MOV BX, OFFSET STRING
READ: 
    MOV AL, 0FFH
    OUT PB, AL
    IN AL, PA
    CMP AL, 0
    JZ FIN
    MOV BYTE PTR [BX], AL
    INC BX
    JMP READ
FIN: INT 0
END