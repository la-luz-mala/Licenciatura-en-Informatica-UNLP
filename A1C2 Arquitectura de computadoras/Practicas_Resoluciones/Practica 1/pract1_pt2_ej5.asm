;--------------------------------------------------------;
;5) Acceso con contraseña ⭐⭐ Escribir un programa que solicite el ingreso de una contraseña de 4
;caracteres por teclado, sin visualizarla en pantalla. En caso de coincidir con una clave predefinida (y
;guardada en memoria) que muestre el mensaje "Acceso permitido"; caso contrario mostrar el mensaje
;"Acceso denegado", y volver a pedir que se ingrese una contraseña. Al 5to intento fallido, debe mostrarse el
;mensaje “Acceso BLOQUEADO” y terminar el programa.
;--------------------------------------------------------;


ORG 1000h
INGRESE     DB "Ingrese su contraseña "
CORRECTO    DB "Acceso permitido "
INCORR      DB "Acceso denegado "
BLOQ        DB "Acceso BLOQUEADO "
ERROR       DB  0
PASS        DB "1234"
PASSING     DB ?

ORG 2000H
INICIO:
    MOV BX, OFFSET INGRESE ; cargo la dirección de "Ingrese" en BX
    MOV AL, OFFSET CORRECTO - OFFSET INGRESE ; cargo el largo del mensaje
    INT 7 ; muestro el mensaje
    MOV BX, OFFSET PASSING ; cargo la dirección donde ingresar los caracteres
    MOV CL, 4 ; inicio un contador en 4

LEER:
    INT 6 ; habilito el ingreso de caracter
    INC BX ; +1 a la dirección apuntada
    DEC CL ; -1 al contador
    JNZ LEER ; si el contador es 0 se ingresaron los 4 caracteres, sino vuelvo al loop
    MOV DX, 3 ; inicializo registro auxiliar una vez que se ingresaron los 4

COMPARAR:
    MOV BX, OFFSET PASS ; pueblo BX con la dirección de la contraseña correcta
    ADD BX, DX ; sumo el registro auxiliar a la dirección
    MOV AL, [BX] ; muevo el contenido donde apunta BX a AL
    MOV BX, OFFSET PASSING ; pueblo bx con la dirección del caracter de la contraseña ingresada
    ADD BX, DX ; sumo el registro auxiliar a la dirección
    CMP [BX], AL ; toda esta vuelta? porque no puedo usar [AL]. comparo ambos registros
    JNZ FAIL ; si los caracteres son diferentes, salto a FAIL
    DEC DX ; bajo el contador auxiliar
    JNZ COMPARAR ; si no llego a cero, vuelvo a loopear comparar

    MOV BX, OFFSET CORRECTO ; si llegue a cero sin errores, pueblo BX con inicio del mensaje CORRECTO
    MOV AL, OFFSET INCORR - OFFSET CORRECTO ; cargo en AL la cantidad de caracteres
    INT 7 ; imprimo
    JMP FIN ; termina el programa

FAIL:
    INC ERROR ; aumento el contador de errores
    CMP ERROR, 5 ; comparo con el máximo de errores (4, más 1 por el incremento al principio)
    JZ BLOCK ; si llegué al máximo, salto a block
    MOV BX, OFFSET INCORR ; pueblo BX con inicio del mensaje INCORR
    MOV AL, OFFSET BLOQ - OFFSET INCORR ; pueblo AL con cantidad de caracteres
    INT 7 ; imprimo
    JMP INICIO ; volvemos a empezar

BLOCK:
    MOV BX, OFFSET BLOQ ; cargo inicio del mensaje BLOQ
    MOV AL, OFFSET ERROR - OFFSET BLOQ ; cargo largo
    INT 7
FIN: 
    INT 0

END