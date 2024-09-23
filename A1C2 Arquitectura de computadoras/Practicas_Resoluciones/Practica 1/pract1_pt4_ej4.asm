;--------------------------------------------------------;
;4) Multiplicación de números sin signo con parámetros
;El pasaje de parámetros más usual suele ser por valor y por registro. No obstante, en algunas ocasiones
;también se utilizan pasajes de parámetros más avanzados que permiten más flexibilidad o eficiencia.
;Escribir un programa que tenga dos valores de 8 bits A y B almacenados en su memoria y realice la
;multiplicación de A y B. El resultado se debe guardar en la variable RES de 16 bits, o sea que RES = A ⨯ B.
;Para hacerlo, implementar una subrutina MUL:
;;A. ⭐ Pasando los parámetros por valor desde el programa principal a través de los registros AL y
;AH, y devolviendo el resultado a través del registro AX por valor.
;--------------------------------------------------------;

ORG 1000H
A db 3
B db 2
RES DW ?

ORG 3000H
MULT:
CMP AL, 0
JZ FIN
CMP AH, 0
JZ FIN
LOOP: ADD CL, AL
DEC AH
JNZ LOOP

MOV AL, CL
FIN: RET

ORG 2000H
MOV AL, A
MOV AH, B
MOV CX, 0
CALL MULT
MOV RES, AX
HLT
END

;B. ⭐⭐Pasando los parámetros por referencia desde el programa principal a través de registros, y
;devolviendo el resultado a través de un registro por valor.

ORG 3000H
MULT:
    MOV CL, BYTE PTR [BX]
    MOV BX, AX
    MOV CH, BYTE PTR [BX]
    MOV AX, 0
    LOOP: ADD AL, CL
    DEC CH
    JNZ LOOP
    MOV RES, AX ; en AX queda el valor final
RET

ORG 2000H
    CMP A, 0
    JZ FIN
    CMP B, 0
    JZ FIN
    MOV AX, OFFSET A
    MOV BX, OFFSET B
    MOV CX, 0
    CALL MULT
    FIN: HLT
END

;C. ⭐⭐ Pasando los parámetros por valor desde el programa principal a través de registros, y
;devolviendo el resultado a través de un registro por referencia.

ORG 3000H
MULT:
    CMP AL, 0
    JZ FIN
    CMP AH, 0
    JZ FIN
LOOP: ADD CL, AL
    DEC AH
    JNZ LOOP

    MOV RES, CX
    MOV AX, OFFSET RES ; En AX queda la dirección en que está RES

FIN: RET

ORG 2000H
    MOV AL, A
    MOV AH, B
    MOV CX, 0
    CALL MULT
HLT
END

;D. ⭐⭐ Pasando los parámetros por valor desde el programa principal a través de la pila, y
;devolviendo el resultado a través de un registro por valor.

ORG 3000H
MULT:
    PUSH CX ; salvo lo que hubiera en CX para usar de contador
    MOV CX, 0
    MOV BX, SP ; traigo el stack pointer a BX
    ADD BX, 6 ; llevo la dirección en BX a la posición del primer push (A)
    MOV AX, [BX] ; traigo A a AX
    SUB BX, 2 ; resto 2 al stack pointer
    MOV BX, [BX] ; traigo B a BX
LOOP: ADD CX, AX
    DEC BX
    JNZ LOOP
    MOV RES, CX ; En CX y en RET queda el resultado
    POP CX
RET

ORG 2000H
    CMP A, 0
    JZ FIN
    CMP B, 0
    JZ FIN
    MOV AX, 0
    MOV AL, A
    PUSH AX
    MOV AL, B
    PUSH AX
    CALL MULT
FIN: HLT
END


;E. ⭐⭐⭐Pasando los parámetros por referencia desde el programa principal a través de la pila, y
;devolviendo el resultado a través de un registro por valor.

ORG 1000H
    A db 3
    B db 2
    RES DW ?

ORG 3000H
MULT:
    PUSH CX
    MOV BX, SP ; Muevo el SP a BX
    ADD BX, 6 ; Sumo 10 para ubicarme en la primera dirección que pasé
    MOV CX, [BX];
    SUB BX, 2
    MOV BX, [BX]
    MOV AL, [BX]
    MOV BX, CX
    MOV AH, [BX]
    CMP AL, 0
    JZ FIN
    CMP AL, 0
    JZ FIN
    MOV CX, 0
LOOP: ADD CL, AL
    DEC AH
    JNZ LOOP

    MOV RES, CX
    POP CX
FIN: RET

ORG 2000H
    MOV AX, OFFSET A
    MOV BX, OFFSET B
    PUSH AX
    PUSH BX
    CALL MULT
    HLT
END