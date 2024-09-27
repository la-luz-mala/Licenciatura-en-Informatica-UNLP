;4) Luces, llaves y opciones ⭐⭐⭐Escribir un programa que deberá utilizar las luces y llaves. El programa
;revisa el estado de las llaves, y evalúa estos tres casos:
;A. Verificar si todas llaves están apagadas. Si es así, mostrar en pantalla el mensaje “Fin de programa” y
;finalizar el mismo. Caso contrario, hacer tanto B como C.
;B. Actualizar las luces a su estado opuesto. Por ejemplo, si las llaves están en el estado “00011010” las
;luces tendrán el estado “11100101”.
;C. Si la primera llave (la del bit menos significativo) está prendida, mostrar en pantalla el mensaje
;“Arquitectura de Computadoras: ACTIVADA” .
;El programa sólo termina en el caso A. En los casos B y C, debe volver a revisar el estado de las llaves y evaluar
;los 3 casos otra vez.
;Las funciones ”A”, “B” y “C” deben implementarse utilizando tres subrutinas independientes. La subrutina A
;debe devolver 1 si hay que finalizar el programa y 0 de lo contrario.

PA EQU 30H
PB EQU 31H
CA EQU 32H
CB EQU 33H

ORG 1000H
MSJ DB "Arquitectura de Computadoras: ACTIVADA", 0AH
MSJ2 DB "Fin del programa"
FIN DB ?

ORG 3000H
INI_PIO:
;CA
    MOV AL, 0FFH
    OUT CA, AL
;CB
    MOV AL, 0
    OUT CB, AL
RET

LLAVES_APAGADAS:
    PUSH AX
    MOV AH, AL
    CMP AH, 0
    JNZ VOLVER
    MOV BX, OFFSET MSJ2
    MOV AL, OFFSET FIN - OFFSET MSJ2
    INT 7
    INC DX
VOLVER: POP AX
RET

LUCES_INVERSO:
    PUSH AX
    NOT AL
    OUT PB, AL
    POP AX
RET

LLAVES_MSJ:
    PUSH AX
    AND AL, 1
    JZ VOLVER_L
    MOV BX, OFFSET MSJ
    MOV AL, OFFSET MSJ2 - OFFSET MSJ
    INT 7
VOLVER_L: POP AX
RET


ORG 2000H
CALL INI_PIO
PROCESO: MOV DX, 0
IN AL, PA
CALL LLAVES_APAGADAS
CMP DL, 0
JNZ FINAL
CALL LUCES_INVERSO
CALL LLAVES_MSJ
JMP PROCESO
FINAL: INT 0
END