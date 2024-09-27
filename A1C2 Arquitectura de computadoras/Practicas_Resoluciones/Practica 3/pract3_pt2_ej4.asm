;4) Tecla F10 con pantalla y terminación⭐⭐
;A) Escribir un programa que muestre en pantalla “Vamos las interrupciones!” cada vez que se presiona la
;tecla F10. El programa nunca termina.

EOI EQU 20H
IMR EQU 21H
INT0 EQU 24H
N_F10 EQU 10

ORG 40
DIR_F10 DW IMPRIMIR

ORG 1000H
MSJ DB "Vamos las interrupciones!", 0AH
FIN DB ?

ORG 3000H
IMPRIMIR:
    MOV BX, OFFSET MSJ
    MOV AL, OFFSET FIN - OFFSET MSJ
    INT 7
    MOV AL, EOI
    OUT EOI, AL
IRET

ORG 2000H
CLI ; Bloquear interrupciones
MOV AL, 0FEh ;Inicializar IRET
OUT IMR, AL ; Enviarlo al IMR

MOV AL, N_F10 ; Inicializar INT0
OUT INT0, AL ; Envío el valor 10 a INT0

STI

LAZO: JMP LAZO

INT 0
END

;B) Idem A pero ahora el programa termina luego de mostrar 5 veces el mensaje (es decir, luego de que
;presione 5 veces la tecla F10).
;Pista: cuando se ejecuta la 5ta interrupción, deben deshabilitarse las mismas para evitar reaccionar a
;pŕoximas pulsaciones de la tecla F10. Utilizar una variable global para registrar cuántas veces falta mostrar
;el mensaje antes de terminar.

EOI EQU 20H
IMR EQU 21H
INT0 EQU 24H
N_F10 EQU 10

ORG 40
DIR_F10 DW IMPRIMIR

ORG 1000H
MSJ DB "Vamos las interrupciones!", 0AH
CONT DB 5

ORG 3000H
IMPRIMIR:
    MOV BX, OFFSET MSJ
    MOV AL, OFFSET CONT - OFFSET MSJ
    INT 7
    DEC DL
    JNZ SEGUIR
    MOV AL, 0FFH
    OUT IMR, AL
    SEGUIR: 
    MOV AL, EOI
    OUT EOI, AL
IRET

ORG 2000H
CLI ; Bloquear interrupciones
MOV AL, 0FEh ;Inicializar IRET
OUT IMR, AL ; Enviarlo al IMR

MOV AL, N_F10 ; Inicializar INT0
OUT INT0, AL ; Envío el valor 10 a INT0

STI
MOV DL, CONT
LAZO: CMP DL, 0
JNZ LAZO

INT 0
END