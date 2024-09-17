;--------------------------------------------------------;
;2) Lectura de datos desde el teclado⭐
;El siguiente programa solicita el ingreso de un número (de un dígito) por teclado e inmediatamente lo
;muestra en la pantalla de comandos, haciendo uso de las interrupciones por software INT 6 e INT 7. Probar
;en el simulador y responder:
;a) Con referencia a la interrupción INT 6, ¿qué se almacena en BX?
;-------RTA: INT 6 almacena en la dirección a que apunta BX el valor  correspondiente en ASCII al caracter ingresado por teclado.
;b) En el programa anterior, ¿qué hace la segunda interrupción INT 7?
;-------RTA: Imprime el valor contenido en la dirección que apunta BX, que es el caracter ingresado por teclado.
;c) ¿Qué valor queda almacenado en el registro CL? ¿Es el mismo que el valor numérico ingresado?
;-------RTA: CL almacena el mismo valor ingresado por teclado.
;--------------------------------------------------------;

ORG 1000H
    MSJ DB "INGRESE UN NUMERO:"
    FIN DB ?
ORG 1500H
    NUM DB ?
ORG 2000H
    MOV BX, OFFSET MSJ
    MOV AL, OFFSET FIN-OFFSET MSJ
    INT 7
    MOV BX, OFFSET NUM
    INT 6
    MOV AL, 1
    INT 7
    MOV CL, NUM
    INT 0
END
