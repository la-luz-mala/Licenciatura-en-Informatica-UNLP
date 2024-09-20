;--------------------------------------------------------;
;5) Acceso con contraseña ⭐⭐ Escribir un programa que solicite el ingreso de una contraseña de 4
;caracteres por teclado, sin visualizarla en pantalla. En caso de coincidir con una clave predefinida (y
;guardada en memoria) que muestre el mensaje "Acceso permitido"; caso contrario mostrar el mensaje
;"Acceso denegado", y volver a pedir que se ingrese una contraseña. Al 5to intento fallido, debe mostrarse el
;mensaje “Acceso BLOQUEADO” y terminar el programa.
;--------------------------------------------------------;

;Crear msj para pedir contraseña y finmsj
;crear cont 4
;crear passcorr db 1234 y passingr db ? ? ? ?
;crear mensajes
;poblar BX con offset msj y AL con la dif de los offsets
;imprimir msj
;poblar BX con offset passingr y pedir int 6
;cont -1
;passingr +1
;cont = 0? si NO, volver a pedir int 6
;
;
ORG 1000h
INGRESE     DB "Ingrese su contraseña"
CORRECTO    DB "Acceso permitido"
INCORR      DB "Acceso denegado"
BLOQ        DB "Acceso BLOQUEADO"
ERROR       DB  0
PASS        DB "1234"
PASSING     DB ?

ORG 2000H
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
