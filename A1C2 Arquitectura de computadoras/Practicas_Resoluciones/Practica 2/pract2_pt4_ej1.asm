;1) Juego de Luces con Rotaciones⭐⭐⭐
;Escribir un programa que encienda una luz a la vez, de las ocho conectadas al puerto paralelo del
;microprocesador a través de la PIO, en el siguiente orden de bits:
;0-1-2-3-4-5-6-7-6-5-4-3-2-1-0-1-2-3-4-5-6-7-6-5-4-3-2-1-0-1-..., es decir, 00000001, 00000010,
;00000100, etc. El programa nunca termina. Para ello, deberá utilizar las subrutinas ROTAR_IZQ y
;ROTAR_DER_N, que le permitirán rotar el bit de estado de las luces y generar el juego
;correspondiente.
;📄 ROTARIZQ: Escribir una subrutina ROTARIZQ que aplique una rotación hacia la izquierda a los
;bits de un byte almacenado en la memoria. Dicho byte debe pasarse por valor desde el programa
;principal a la subrutina a través de registros y por referencia. No hay valor de retorno, se modifica
;directamente la celda de memoria referenciada.
;📄 ROTARIZQ_N: Usando la subrutina ROTARIZQ del ejercicio anterior, escriba una subrutina
;ROTARIZQ_N que realice N rotaciones a la izquierda de un byte. La forma de pasaje de parámetros
;es la misma, pero se agrega el parámetro N que se recibe por valor y registro. Por ejemplo, al rotar a
;la izquierda 2 veces el byte 10010100, se obtiene el byte 01010010.
;📄ROTARDER_N: * Usando la subrutina ROTARIZQ_N del ejercicio anterior, escriba una subrutina
;ROTARDER_N que sea similar pero que realice N rotaciones hacia la derecha.
;Pista: Una rotación a derecha de N posiciones, para un byte con 8 bits, se obtiene rotando a la
;izquierda 8 - N posiciones. Por ejemplo, al rotar a la derecha 6 veces el byte 10010100 se obtiene
;el byte 01010010, que es equivalente a la rotación a la izquierda de 2 posiciones del ejemplo
;anterior.

PA EQU 30H
PB EQU 31H
CA EQU 32H
CB EQU 33H

ORG 3000H
INI_PIO:
;CA
    MOV AL, 0FFH
    OUT CA, AL
;CB
    MOV AL, 0
    OUT CB, AL
;STROBE? NO NEED PQ ES LUCES
RET

ROTARIZQ:
    ADD AL, AL
    ADC AL, 0
    OUT PB, AL
FIN: RET

ROTARIZ_N:
    MOV DH, 7
    LAZO:
    CALL ROTARIZQ
    DEC DH
    JNZ LAZO
RET

ROTARDER_N:
    MOV DH, 7
    NEG DH
LOOP2:ADD DH, 8
    CALL ROTARIZQ
    DEC DH
    JNZ LOOP2
RET

ORG 2000H
    CALL INI_PIO
    MOV AL, 1
    OUT PB, AL
    LOOP:
    CALL ROTARIZ_N
    CALL ROTARDER_N
    JMP LOOP
INT 0
END

;_a revisar, no logro que gire a la derecha_;