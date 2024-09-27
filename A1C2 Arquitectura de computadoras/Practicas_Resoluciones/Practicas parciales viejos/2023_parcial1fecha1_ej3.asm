;Escribir un programa para VonSim que deberá utilizar las luces y llaves de la siguiente forma:
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