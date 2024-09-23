;2) Estadísticas de notas⭐⭐⭐
;Escribir un programa que permite calcular estadísticas de las notas de los exámenes de una materia. Las
;notas son valores entre 0 y 9, donde 4 es el valor mínimo para aprobar. El programa debe leer de teclado las
;notas y almacenarlas en un vector, convertidas a números; la lectura termina con el carácter “.”. Luego, el
;programa debe informar el promedio de las notas y almacenar en memoria el porcentaje de exámenes
;aprobados.
;Para desarrollar el programa, implementar las subrutinas:
;● 📄 CANT_APROBADOS: Recibe un vector de números y su longitud, y retorna la cantidad de
;números iguales o mayores a 4.
;● 📄 DIV: calcula el resultado de la división entre 2 números positivos A y B de 16 bits. Pasaje de
;parámetros por valor y por registro. Retorna el cociente y el resto en dos registros respectivamente.
;● 📄MUL: calcula el resultado de la multiplicación entre 2 números positivos A y B de 16 bits. Pasaje
;de parámetros por valor y por registro. Retorna el resultado en un registro.
;● 📄PORCENTAJE: Recibe la cantidad de notas aprobadas, y la cantidad total de notas, y retorna el
;porcentaje de aprobadas.
;Pista: Como VonSim no tiene soporte para números en punto flotante, el porcentaje debe calcularse
;con enteros utilizando las subrutinas DIV y MUL. Es decir, si se leen 3 notas y 2 son aprobadas, el
;porcentaje de aprobados sería 66%, o sea (2 * 100)/3. Como son números enteros, es importante
;primero hacer la multiplicación y luego la división (¿por qué?).

ORG 1000H
    MSJ DB "Ingrese las notas: "
    CANTALUMNOS DW 0
    NOTAMIN DB "4"
    APROB DW 0
    PORCENTAJE DW 0
    NOTAS DB ?

ORG 3000H
CANT_APROBADOS:
    MOV DX, 0
    LAZO: MOV AH, BYTE PTR [BX]
    CMP AH, 2EH
    JZ FIN_CANT
    INC BX
    CMP AH, AL
    JS LAZO
    INC DX
    JMP LAZO
FIN_CANT: RET

;● 📄 DIV: calcula el resultado de la división entre 2 números positivos A y B de 16 bits. Pasaje de
;parámetros por valor y por registro. Retorna el cociente y el resto en dos registros respectivamente.
DIV:
    MOV BX, 0 ; Reseteo el contador auxiliar
    LAZO_DIV: SUB CX, DX ; resto AX (divisor) de DX (dividendo)
    JS FIN_DIV ; si da menos de 0, se acabó la división
    INC BX ; sino aumento la cantidad de veces que dividí
    JMP LAZO_DIV ; y vuelvo a dividir
FIN_DIV: RET
;● 📄MUL: calcula el resultado de la multiplicación entre 2 números positivos A y B de 16 bits. Pasaje
;de parámetros por valor y por registro. Retorna el resultado en un registro.
MUL:
    MOV CX, 0
    LAZO_MUL: ADD CX, AX
    DEC BX
    JNZ LAZO_MUL
RET

;● 📄PORCENTAJE: Recibe la cantidad de notas aprobadas, y la cantidad total de notas, y retorna el
;porcentaje de aprobadas.
PORC:
    MOV AX, 100
    CALL MUL
    CALL DIV
RET

ORG 2000H
    MOV BX, OFFSET MSJ
    MOV AL, OFFSET CANTALUMNOS - OFFSET MSJ
    INT 7
;Ingresar alumnos, contarlos y contar aprobados
MOV BX, OFFSET NOTAS
LOOP: INT 6
MOV AL, BYTE PTR [BX]
CMP AL, 2EH
JZ SALIR
INC CANTALUMNOS
INC BX
JMP LOOP
SALIR: 
;Sacar cuantos aprobaron
MOV BX, OFFSET NOTAS
MOV AL, NOTAMIN
CALL CANT_APROBADOS
MOV APROB, DX

MOV DX, CANTALUMNOS
MOV BX, APROB
CALL PORC
MOV PORCENTAJE, BX

HLT
END