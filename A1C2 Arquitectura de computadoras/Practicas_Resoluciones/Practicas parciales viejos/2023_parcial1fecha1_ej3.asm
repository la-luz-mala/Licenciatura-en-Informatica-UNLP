;1)
;El siguiente programa envía un parámetro por la pila a SUBRUT. ¿Qué valor queda almacenado en CL?
ORG 1250H
    CAD DB "HOLA"
ORG 2000H
    MOV AX, OFFSET CAD
    PUSH AX ; Se carga 1250 en la pila. SP: 7FFEh en 50
    CALL SUBRUT ; Se carga 2008 en la pila. SP 7FFC en 08
    ...

ORG 3000H
SUBRUT: MOV BX, SP ; Se carga 7FFCh en BX
    ADD BX, 2 ; BX = 7FFEh
    MOV CL, [BX] ; CL = 50h
    ...

;Respuesta:
CL = 50

;2. El siguiente programa para VonSim lee carácteres por teclado y los envía a la impresora a través del PIO a medida que se van leyendo. El programa termina cuando se lee el carácter "." Completar las instrucciones faltantes.
PA EQU 30H
PB EQU 31H
CA EQU 32H
CB EQU 33H

ORG 1000H
CAR DB ?

ORG 2000H
MOV AL, 0
OUT CB, AL
MOV AL, 11111101B
OUT CA, AL
MOV BX, OFFSET CAR
LOOP: INT 6
    CMP CAR, "."
    jnz fin ; faltante: salto a FIN si la comparación da 0
    CALL IMP
    JMP LOOP
FIN: INT 0
END

ORG 3500H
IMP: IN AL, PA
    AND AL, 1
    JNZ IMP ; este es el loop que chequea busy
    MOV AL, CAR ; faltante: cargo el caracter a imprimir
    OUT PB, AL ; faltante: lo envio a la impresora
    IN AL, PA
    AND AL, 0FFDH ; faltante: enmascaro AL para forzar a 1 el strobe con AND 1111 1101B
    OUT PA, AL
    IN AL, PA
    OR AL, 10B
    OUT PA, AL
RET

;3. Escribir un programa para VonSim que deberá utilizar las luces y llaves de la siguiente forma:
;a. Cada vez que las llaves cambien de valor, se actualizan las luces, de modo que si las llaves están en el estado "00011010" las luces tendrán el estado opuesto, es decir "111001010"
;b. Cada vez que encuentre la 8va llave (la del bit más significativo) prendida, mostrar en pantalla el mensaje "Buen día"
;c. En el caso particular en que todas las llaves estén apagadas, mostrar en pantalla el mensaje "Adios" y finalizar el mismo.
;Las funciones "a", "b" y "c" deben implementarse utilizando subrutinas.

PA EQU 30H
PB EQU 31H
CA EQU 32H
CB EQU 33H

ORG 1000H
HI DB "Buen día", 0AH
BYE DB "Adios", 0AH
FLAG DB 0

ORG 3000H
INI_PIO:
;CA
    MOV AL, 0FFH
    OUT CA, AL
;CB
    MOV AL, 0
    OUT CB, AL
RET

INVERSO:
    PUSH AX
    NOT AL
    OUT PB, AL
    POP AX
RET

SALUDO:
    PUSH AX
    AND AL, 80H
    JZ SALIR
    MOV BX, OFFSET HI
    MOV AL, OFFSET BYE - OFFSET HI
    INT 7
SALIR: POP AX
RET

CERO:
    PUSH AX
    CMP AL, 0
    JNZ SALIR2
    MOV FLAG, 1
    MOV BX, OFFSET BYE
    MOV AL, OFFSET FLAG - OFFSET BYE
    INT 7
SALIR2: POP AX
RET


ORG 2000H
CALL INI_PIO
LOOP: IN AL, PA
CALL CERO
CMP FLAG, 1
JZ FIN
CALL INVERSO
CALL SALUDO
JMP LOOP
FIN: INT 0
END


;4. Escribir un programa para VonSim que envíe la cadena de caracteres "Universidad Nacional de La Plata" a un dispositivo nuevo, conectado a los 8 bits del puerto PB. Este dispositivo recibe la cadena de a un caracter a la vez. Para que el dispositivo reconozca que se va a enviar un dato, antes de enviar un caracter debe enviar el valor 0. El programa debe finalizar cuando se han enviado todos los caracteres de la cadena, o cuando se presiona la tecla F10, cancelando el envío de los caracteres que restan.
;Ejemplo para enviar la cadena "ASDF": Envío de 0 -> Envío de la "A" -> Envío de 0 -> Envío de la "S" -> Envío de 0 -> Envío de la "D" -> Envío de 0 -> Envío de la "F".
;Nota: para comunicarse con el dispositivo no es necesario hacer una consulta de estado ni hacerlo mediante interrupciones, el protocolo solo requiere que envíe un 0 y un caracter de forma alternada.

;PIO para el dispo nuevo y PIC para el F10
EOI EQU 20H
IMR EQU 21H
INT0 EQU 24H
IP_F10 EQU 10
PB EQU 31H
CB EQU 33H

ORG 40
DIR_INT DW INT_F10

ORG 1000H
STRING DB "Universidad Nacional de La Plata"
FLAG DB 0

ORG 3000H
INT_F10:
    MOV FLAG, 1
    MOV AL, EOI
    OUT EOI, AL
IRET
INI_PIO:
;CB
    MOV AL, 0
    OUT CB, AL ; Mando 0000 0000 al puerto CB para que configure PB como salida
RET

INI_PIC:
    MOV AL, 07EH; Muevo a AL 1111 1110H
    OUT IMR, AL ; Habilito la interrupcion por INT0
    MOV AL, IP_F10 ; Muevo la dirección del subproceso a AL
    OUT INT0, AL ; lo vinculo con F10
RET
ENVIAR_LETRA:
    PUSH AX
    MOV AL, 0
    OUT PB, AL
    MOV AL, [BX]
    OUT PB, AL
    POP AX
RET

ORG 2000H
CLI ; Detengo interrupciones
;Inicializo PIO + PIC
CALL INI_PIO
CALL INI_PIC
STI
MOV BX, OFFSET STRING
MOV DL, OFFSET FLAG - OFFSET STRING ; Contador auxiliar con el largo de la cadena
ENVIAR: CALL ENVIAR_LETRA
CMP FLAG, 1
JZ FIN
INC BX
DEC DL
JNZ ENVIAR
FIN: 
MOV AL, 0FFH
OUT IMR, AL
INT 0
END