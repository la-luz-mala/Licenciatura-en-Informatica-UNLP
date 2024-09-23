;Escribir un programa que permita calcular estadísticas básicas de texto, como su longitud, cantidad de
;vocales, etc. El programa debe leer un string de teclado. El string se almacena en la memoria principal con
;la etiqueta CADENA. La lectura termina cuando se lee el carácter “.”
;Luego, calcular y almacenar en variables distintas: la cantidad de caracteres totales (sin contar “.”), la
;cantidad de letras, la cantidad de vocales y la cantidad de consonantes. Por último, verificar si la cadena
;contiene el carácter ‘x’.
;Para ello, implementar las subrutinas:
;● 📄ES_LETRA que recibe un carácter C por valor y retorna 0FFh si C es una letra o 00h de lo
;contrario. Para implementar la subrutina, tener en cuenta un carácter es una letra si es una
;minúscula o mayúscula.
;● 📄ES_VOCAL que recibe un carácter C por valor y retorna 0FFh si C es vocal o 00h de lo contrario.
;Para implementar la subrutina, utilizar un string auxiliar que contiene las vocales, como vocales db
;“aeiouAEIOU”, y utilizar la subrutina CONTIENE.
;● 📄CONTAR_VOC Usando la subrutina ES_VOCAL, escribir la subrutina CONTAR_VOC, que recibe
;una cadena terminada por referencia a través de un registro, su longitud en otro registro y
;devuelve, en un registro, la cantidad de vocales que tiene esa cadena.
;Ejemplo: CONTAR_VOC de ‘contar1#!’ debe retornar 2
;● 📄ES_CONSONANTE que recibe un carácter C por valor y retorna 0FFh si C es una letra
;consonante o 00h de lo contrario. Para implementar la subrutina, tener en cuenta que un carácter
;es consonante si es una letra pero no es una vocal.
;● 📄CONTAR_CONSONANTES Idem CONTAR_VOC pero para consonantes.
;● 📄CONTIENE que recibe un string A por referencia, y un carácter C por valor, ambos por registro,
;y debe retornar, también vía registro, el valor 0FFh si el string contiene a C o 00h en caso contrario.
;Ejemplo: CONTIENE de ‘a’ y “Hola” debe retornar 0FFh y CONTIENE de ‘b’ y “Hola” debe retornar 00h.


ORG 1000H
TOTAL DB 0
LETRAS DB 0
VOCAL DB 0
CONS DB 0
VOCALES DB "aeiouAEIOU."
CADENA DB ?

ORG 3000H
ES_LETRA:
    MOV DX, 0 ; Inicializo auxiliar
    CMP AL, 'A' ; si es menor que A, no es letra
    JS NO_ES
    CMP AL, '[' ; Si es mayor que A pero menor que [ (siguiente a Z), es letra mayúscula
    JS SI_ES
    CMP AL, 'a' ; si es mayor que Z pero menor que a, no es letra
    JS NO_ES
    CMP AL, '{' ; si es mayor que a pero menor que { (siguiente a z), es letra minúscula
    JS SI_ES
    JMP NO_ES
NO_ES: MOV DX, 00H
JMP FIN_LETRA
SI_ES: MOV DX, 0FFH
FIN_LETRA: RET

CONTAR_LETRAS:
    MOV CX, 0
    MOV BX, OFFSET CADENA
    LOOP: MOV AL, [BX] 
    CMP AL, '.' ; comparo con . para identificar el fin del string
    JZ EXIT
    CALL ES_LETRA ;el caracter es una letra?
    CMP DX, 0FFH ;SI
    JNZ NEXT ;Si no es una letra, salto el incremento del contador
    INC CL
    NEXT: INC BX
    JMP LOOP
EXIT: RET

CONTIENE:
MOV DX, 0
COMPARA: CMP BYTE PTR [BX], '.' ;primero que nada chequeo que no sea el fin del string
JZ NO_ESTA
CMP AL, BYTE PTR [BX]
JZ SI_ESTA
INC BX
JMP COMPARA
SI_ESTA: MOV DX, 0FFH
JMP FIN_CONTIENE
NO_ESTA: MOV DX, 00H
FIN_CONTIENE: RET

ES_VOCAL:
PUSH BX
MOV BX, OFFSET VOCALES
CALL CONTIENE
POP BX
RET

CONTAR_VOC:
MOV AH, 0 ; contador auxiliar
MOV BX, OFFSET CADENA
LOOP_CONTV: MOV AL, [BX]
CMP AL, '.'
JZ FIN_CONTV
CALL ES_VOCAL
CMP DX, 0FFH
JNZ NO_VOCAL
INC AH
NO_VOCAL:
INC BX
JMP LOOP_CONTV
FIN_CONTV: RET

ES_CONSONANTE:
PUSH BX
MOV BX, OFFSET VOCALES
CALL CONTIENE
NOT DL
POP BX
RET

CONTAR_CONS:
MOV AH, 0 ; contador auxiliar
MOV BX, OFFSET CADENA
LOOP_CONTC: MOV AL, [BX]
CMP AL, '.'
JZ FIN_CONTC
CALL ES_LETRA
CMP DX, 00H
JZ NO_CONS
CALL ES_CONSONANTE
CMP DX, 0FFH
JNZ NO_CONS
INC AH
NO_CONS:
INC BX
JMP LOOP_CONTC
FIN_CONTC: RET

ORG 2000H
MOV BX, OFFSET CADENA
MOV DX, 0
LEER: INT 6
CMP BYTE PTR [BX], '.'
JZ FIN
INC BX
INC DX
JMP LEER
FIN: MOV TOTAL, DL

CALL CONTAR_LETRAS
MOV LETRAS, CL

CALL CONTAR_VOC
MOV VOCAL, AH

CALL CONTAR_CONS
MOV CONS, AH

HLT
END