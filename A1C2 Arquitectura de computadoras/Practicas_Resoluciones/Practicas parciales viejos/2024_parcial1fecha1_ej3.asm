;El siguiente programa utiliza la pila para guardar valores y realizar un cálculo. ¿Qué valor queda almacenado en DL?

ORG 1000H
    CAD DB 15,12,10 ; Posiciones 1000h, 1001h y 1002h respectivamente
ORG 2000H
    MOV DX, OFFSET CAD ; DX = 1000h
    PUSH DX ; SP pasa de 8000h a 7FFEh y se pushea 1000h a esa posicion
    CALL ZXCV ; SP pasa de 7FFEh a 7FFCh y se pushea 200X a esa posicion
    ...
ORG 3000H
ZXCV: MOV BX, SP ; BX = 7FFCh
    ADD BX, 2 ; BX = 7FFEh
    MOV BX, [BX] ; BX = 1000h
    MOV DL, [BX] ; BX = 15

;RTA:
;DL = 15

;2. El siguiente programa para VonSim incrementa un contador cada vez que se presiona la tecla F10 El programa termina cuando el CONTADOR llega a 10. Si el CONTADOR llega a 10, apretar F10 nuevamente no cambia el valor del CONTADOR. Completar las instrucciones faltantes.
EOI EQU 20H
IMR EQU 21H
INT0 EQU 24H

ORG 60
DIR_INT DW INTERRUP ; Faltante: vinculo la subrutina

ORG 1000h
CONTADOR DB 0

ORG 3000H
INTERRUP:CMP CONTADOR, 10 ; Faltante: inicializo subrutina, comparo contador con 10
JZ FIN
INC CONTADOR
FIN: MOV AL, 20H
OUT EOI, AL
IRET

ORG 2000H
CLI
MOV AL, 11111110B
OUT IMR, AL
MOV AL, 15 ; Faltante: muevo 15 a AL para hacer 15x4 y buscar en ORG 60 las instrucciones de la interrupción
OUT INT0, AL
STI
LOOP: CMP CONTADOR, 10
JNZ LOOP
INT 0
END

;3. Escribir un programa para VonSim que cuente la cantidad de valores pares de un vector de números de 16 bits. Luego, deberá informar "Ganan los pares" si hay más valores pares que impares, o "Ganan los impares" en caso contrario. Para ello deberá implementar las subrutinas:
;-es_par: recibe en AX un número y devuelve en DX el valor 1 si es par y el valor 0 de lo contrario.
;-contar_pares: recibe a través de la pila la dirección de memoria donde empieza un vector, y además su longitud. Retorna la cantidad de valores pares del vector en el registro AX.
ORG 1000h
VECTOR DW 50, 15, 25, 12, 3, 5, 4, 3, 1
PARES DW 0 ; contador auxiliar
MAS_PARES DB "Ganan los pares"
MAS_IMPARES DB "Ganan los impares"
TOTAL DW 0 ; contador auxiliar

ORG 3000H
ES_PAR:
    MOV DX, AX ; llevo el num a AX
    AND DX, 1 ; XXXX XXXX AND 0000 00001 = 0000 0000 si el num es par, 0000 0001 si el num es impar
    JNZ IMPAR ; si no da cero, es impar
    INC DX ; si no salto a IMPAR, incremento DX para devolver 1 por consigna
    JMP SALIR
IMPAR: DEC DX ; si es impar, decremento DX para devolver 0 por consigna
SALIR: RET

CONTAR_PARES:
    MOV BX, SP ; stack pointer a BX
    ADD BX, 2 ; lo aumento en 2 para recuperar donde está la dirección del vector
    MOV BX, [BX] ; envío la dirección del vector a la pila
    LOOP: CMP BX, OFFSET PARES ; comparo la dirección con la siguiente variable para no pasarme
    JZ FIN ; si son iguales, terminé
    MOV AX, [BX] ; mando a AX el número al que apunta la posición de memoria
    CALL ES_PAR ; llamo la rutina ES_PAR
    ADD PARES, DX ; sumo DX a PARES: si es impar, traigo 0 y la suma es irrelevante
    INC TOTAL ; aumento el total de números
    ADD BX, 2 ; paso a la sgte posición de memoria
    JMP LOOP ; salto
FIN: MOV AX, PARES ; devuelvo PARES por AX por consigna
RET

ORG 2000H
    MOV BX, OFFSET VECTOR ; paso la dirección de inicio del vector a BX
    PUSH BX ; y a la pila
    CALL CONTAR_PARES ; llamo la subrutina
    MOV CX, TOTAL ; pongo TOTAL en CX
    SUB CX, PARES ; resto PARES a TOTAL - la diferencia es la cant de números impares, que queda en CX
    SUB PARES, CX ; si da negativo, hay más impares que pares
    JS GANAN_PARES
    MOV BX, OFFSET MAS_PARES
    MOV AL, OFFSET MAS_IMPARES - OFFSET MAS_PARES
    INT 7
    JMP FINAL
GANAN_PARES: MOV BX, OFFSET MAS_IMPARES
MOV AL, OFFSET TOTAL - OFFSET MAS_IMPARES
INT 7
FINAL: INT 0
END