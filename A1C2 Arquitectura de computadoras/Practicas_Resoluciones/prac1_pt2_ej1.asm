;--------------------------------------------------------;
;1) Mostrar mensajes en la pantalla de comandos⭐
;El siguiente programa del lenguaje assembler del simulador VonSim muestra en la pantalla de comandos
;un mensaje previamente almacenado en memoria de datos, aplicando la interrupción por software INT 7.
;Probar en el simulador y responder:
;a) Ejecutar en el simulador ¿qué imprime?
;-------RTA: Imprime "ARQUITECTURA DE COMPUTADORAS-FACULTAD DE INFORMATICA-UNLP"
;b) ¿Por qué imprime “UNLP” al final?
;-------RTA: Porque en la tabla ASCII 55h = U, 4Eh = N, 4Ch = L y 50h = P.
;c) Con referencia a la interrupción INT 7, ¿qué se almacena en los registros BX y AL?
;-------RTA: en BX se almacena el comienzo del mensaje, en AL la longitud del mensaje, obtenida de la diferencia entre MSJ y FIN.
;--------------------------------------------------------;

ORG 1000H
    MSJ DB "ARQUITECTURA DE COMPUTADORAS-"
    DB "FACULTAD DE INFORMATICA-"
    DB 55H
    DB 4EH
    DB 4CH
    DB 50H
    FIN DB ?

ORG 2000H
    MOV BX, OFFSET MSJ
    MOV AL, OFFSET FIN - OFFSET MSJ
    INT 7
    INT 0
END