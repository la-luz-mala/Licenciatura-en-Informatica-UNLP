;5) Uso de la impresora a través del HAND-SHAKE. ⭐⭐
;El HANDSHAKE es un dispositivo diseñado específicamente para interactuar con la impresora mediante el
;protocolo centronics. Por este motivo, no requiere enviar la señal de flanco ascendente manualmente; en
;lugar de eso, al escribir un valor en su registro DATA, el mismo HANDSHAKE manda el flanco ascendente.
;Ejecutar los programas configurando el simulador VonSim con los dispositivos “Impresora (Handshake)”
;a) Escribir un programa que imprime “INGENIERIA E INFORMATICA” en la impresora a través del
;HAND-SHAKE. La comunicación se establece por consulta de estado (polling). Para ello, implementar
;la subrutina imprimir_caracter_hand que funcione de forma análoga a imprimir_caracter pero con el
;handshake en lugar del PIO.

DATO EQU 40H
ESTADO EQU 41H

ORG 1000H
MSJ DB "INGENIERIA E INFORMATICA"
FIN DB ?

ORG 3000H
POLL:
    IN AL, ESTADO ; 
    AND AL, 1 ; XXXX XXXX AND 0000 0001 = 0000 000X - salta si bit 0 = 0, impresora not busy
    JNZ POLL
RET

ORG 3200H
IMPRIMIR_CARACTER_HAND:
    PUSH AX ; Salvo el valor de AX
    CALL POLL ; Chequeo si la impresora está disponible
    POP AX ; Devuelvo AX
    OUT DATO, AL ; Mando el dato a imprimir
RET

ORG 2000H
IN AL, ESTADO
AND AL, 7FH ; XXXX XXXX AND 0111 1111 = 0XXX XXXX
MOV BX, OFFSET MSJ
MOV CL, OFFSET FIN - OFFSET MSJ
LAZO: MOV AL, [BX] ; Mando el caracter a imprimir
CALL IMPRIMIR_CARACTER_HAND
INC BX
DEC CL
JNZ LAZO

INT 0
END


;b) ¿Qué diferencias encuentra con el ejercicio anterior? ¿Cuál es la ventaja en utilizar el HAND-SHAKE
;con respecto al PIO para comunicarse con la impresora? ¿Esta ventaja también valdría para otros
;dispositivos, como las luces?
;La ventaja es que no tengo que manejar el STROBE, se ocupa el HAND; y no hay tantos registros 
;que setear y de los que ocuparse. No valdría para las luces porque no tienen strobe.