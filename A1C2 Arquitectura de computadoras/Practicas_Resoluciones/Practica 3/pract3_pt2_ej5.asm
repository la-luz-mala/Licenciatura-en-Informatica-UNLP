;5) Timer, tres usos: periódico infinito, periódico finito, y única vez⭐⭐
;a) Escribir un programa que muestra el mensaje “Vamos las interrupciones!” una vez cada 2 segundos y
;no termine nunca.
;b) Modificar a) para que termine a los 10 segundos.
;c) Modificar a) para que solo imprima una vez, a los 10 segundos, y luego termine.
;d) Desafío: Modificar a) para que el primer mensaje se imprima luego de 1 segundo, el segundo luego de 2
;segundos, el tercero luego de 3, y así sucesivamente, hasta que se espere 255 en el último mensaje, y el
;programa termine,

EOI EQU 20H
IMR EQU 21H
INT1 EQU 25H
CONT EQU 10H
COMP EQU 11H
ID_T EQU 15

ORG 60
DIR_TIMER DW TIMER

ORG 1000H
MSJ DB "Vamos las interrupciones!", 0AH
FIN DB ?

ORG 3000H
TIMER:
MOV BX, OFFSET MSJ
MOV AL, OFFSET FIN - OFFSET MSJ
INT 7
MOV AL, 0
OUT CONT, AL
MOV AL, EOI
OUT EOI, AL
IRET

ORG 2000H
CLI
;INI IMR
MOV AL, 0FDH
OUT IMR, AL
;INI INT1
MOV AL, ID_T
OUT INT1, AL
;INI TIMER
MOV AL, 0
OUT CONT, AL
MOV AL, 2
OUT COMP, AL
STI
LAZO: JMP LAZO
INT 0
END

;b) Modificar a) para que termine a los 10 segundos.

EOI EQU 20H
IMR EQU 21H
INT1 EQU 25H
CONT EQU 10H
COMP EQU 11H
ID_T EQU 15

ORG 60
DIR_TIMER DW TIMER

ORG 1000H
MSJ DB "Vamos las interrupciones!", 0AH
FIN DB ?

ORG 3000H
TIMER:
MOV BX, OFFSET MSJ
MOV AL, OFFSET FIN - OFFSET MSJ
INT 7
MOV AL, 0
OUT CONT, AL
DEC DL
JNZ SEGUIR
MOV AL, 0FFH
OUT IMR, AL
SEGUIR: 
MOV AL, EOI
OUT EOI, AL
IRET

ORG 2000H
CLI
;INI IMR
MOV AL, 0FDH
OUT IMR, AL
;INI INT1
MOV AL, ID_T
OUT INT1, AL
;INI TIMER
MOV AL, 0
OUT CONT, AL
MOV AL, 2
OUT COMP, AL
STI
MOV DL, 5
LAZO: 
CMP DL, 0
JNZ LAZO
INT 0
END

;c) Modificar a) para que solo imprima una vez, a los 10 segundos, y luego termine.

EOI EQU 20H
IMR EQU 21H
INT1 EQU 25H
CONT EQU 10H
COMP EQU 11H
ID_T EQU 15

ORG 60
DIR_TIMER DW TIMER

ORG 1000H
MSJ DB "Vamos las interrupciones!", 0AH
FLAG DB 0

ORG 3000H
TIMER:
MOV BX, OFFSET MSJ
MOV AL, OFFSET FLAG - OFFSET MSJ
INT 7
MOV AL, 0FFH
OUT IMR, AL
MOV FLAG, 1
MOV AL, EOI
OUT EOI, AL
IRET

ORG 2000H
CLI
;INI IMR
MOV AL, 0FDH
OUT IMR, AL
;INI INT1
MOV AL, ID_T
OUT INT1, AL
;INI TIMER
MOV AL, 0
OUT CONT, AL
MOV AL, 10
OUT COMP, AL
STI
LAZO: CMP FLAG, 1
JNZ LAZO
INT 0
END


;d) Desafío: Modificar a) para que el primer mensaje se imprima luego de 1 segundo, el segundo luego de 2
;segundos, el tercero luego de 3, y así sucesivamente, hasta que se espere 255 en el último mensaje, y el
;programa termine,

EOI EQU 20H
IMR EQU 21H
INT1 EQU 25H
CONT EQU 10H
COMP EQU 11H
ID_T EQU 15

ORG 60
DIR_TIMER DW TIMER

ORG 1000H
MSJ DB "Vamos las interrupciones!", 0AH
FLAG DB 0

ORG 3000H
TIMER:
PUSH AX
MOV BX, OFFSET MSJ
MOV AL, OFFSET FLAG - OFFSET MSJ
INT 7
MOV AL, 0
OUT CONT, AL
MOV AL, EOI
OUT EOI, AL
POP AX
ADD AL, 1
CMP AL, 255
JNZ SEGUIR
MOV FLAG, 1
SEGUIR:OUT COMP, AL
IRET

ORG 2000H
CLI
;INI IMR
MOV AL, 0FDH
OUT IMR, AL
;INI INT1
MOV AL, ID_T
OUT INT1, AL
;INI TIMER
MOV AL, 0
OUT CONT, AL
MOV AL, 1
OUT COMP, AL
STI
LAZO: 
CMP FLAG, 1
JNZ LAZO
INT 0
END