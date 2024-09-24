;4) Uso de la impresora a través de la PIO⭐⭐
;Ejecutar los programas configurando el simulador VonSim con los dispositivos “Impresora (PIO)”. En esta
;configuración, el puerto de datos de la impresora se conecta al puerto PB del PIO, y los bits de busy y strobe
;de la misma se conectan a los bits 0 y 1 respectivamente del puerto PA.

;a) Imprimir letra fija Escribir un programa para imprimir la letra “A” utilizando la impresora a través de
;la PIO. Recordar que el programa deberá esperar hasta que el bit de busy esté apagado, luego enviar el
;carácter, y luego enviar el flanco ascendente a través de la señal de strobe. Modularizar el programa en
;4 subrutinas:
;📄 ini_pio: Inicializa el PIO configurando los registros CA y CB según corresponde a strobe, busy y
;puerto de datos
;📄 poll: Consulta el bit busy de la impresora, e itera hasta esté en 0. Cuando está en 0 la subrutina
;retorna sin devolver ninǵun valor
;📄flanco_ascendente: Igual que la subrutina implementada en el ejercicio anterior
;📄 imprimir_caracter: Recibe un carácter a imprimir en AL, y utilizando poll y flanco_ascendente,
;realiza todos los pasos necesarios para enviar a la impresora el carácter.

PA EQU 30h
PB EQU 31H
CA EQU 32h
CB EQU 33H

ORG 1000h
CHAR DB "A"

ORG 3000H
INI_PIO:
    ;CA
    MOV AL, 0FDH ; CA en 0FDh porque es 1111 1101 -> todos entrada menos el bit de strobe que es salida
    OUT CA, AL
    ;CB
    MOV AL, 0 ; CB en 0 proque es 0000 0000 -> todos salida
    OUT CB, AL

    IN AL, PA
    AND AL, 0FDH ; Enmascaro con 1111 1101 -> todos los demás quedan como están, fuerzo strobe a 0
    OUT PA, AL
RET

POLL:
    IN AL, PA 
    AND AL, 1 ; AND el contenido de PA con 0000 0001 -> si da 1, esta busy y lo reintenta. Si da 0, esta libre
    JNZ POLL
RET

FLANCO_ASCENDENTE:
    IN AL, PA
    OR AL, 2H ; Fuerzo a 1 el valor de strobe -> XXXX XX0X OR 0000 0010 = XXXX XX1X 
    OUT PA, AL
    IN AL, PA
    AND AL, 0FDH ; fuerzo a 0 el valor de Strobe, lo demás queda como está -> XXXX XXXX AND 1111 1101 = XXXX XX0X
    OUT PA, AL
RET

IMPRIMIR_CARACTER:
    CALL POLL ; Chequeo que la impresora esté libre
    MOV AL, BYTE PTR [BX] 
    OUT PB, AL ; envío el caracter a PB
    CALL FLANCO_ASCENDENTE ; fuerzo el Strobe a 1
RET

ORG 2000H
CALL INI_PIO
MOV BX, OFFSET CHAR
MOV CL, 1
CALL IMPRIMIR_CARACTER
INT 0
END



;b) Imprimir mensaje fijo Escribir un programa para imprimir el mensaje “ORGANIZACION Y
;ARQUITECTURA DE COMPUTADORAS” utilizando la impresora a través de la PIO. Utilizar la
;subrutina imprimir_caracter del inciso anterior.

PA EQU 30h
PB EQU 31h
CA EQU 32h
CB EQU 33h

ORG 1000H
    MSJ DB "ORGANIZACION Y ARQUITECTURA DE COMPUTADORAS"
    FINMSJ DB ?

ORG 3000H
INI_PIO:
    ;CA
    MOV AL, 0FDH ; todos en 1 menos el de strobe: 1111 1101
    OUT CA, AL
    ;CB
    MOV AL, 0 ; todos en 0
    OUT CB, AL
    ;STROBE
    IN AL, PA
    AND AL, 0FDH ; traigo PA, enmascaro para forzar a 0 strobe, devuelvo a PA
    OUT PA, AL
RET

POLL:
    IN AL, PA
    AND AL, 1 ; XXXX XXXX and 0000 0001 = 1 si el ultimo bit esta en 1, 0 si esta en 0
    JNZ POLL
RET

RESET_STROBE:
    IN AL, PA
    OR AL, 2H ; XXXX XXXX or 0000 0010 = XXXX XX1X
    OUT PA, AL
    IN AL, PA
    AND AL, 0FDH ; XXXX XX0X AND 1111 1101 = XXXX XX0X
    OUT PA, AL
RET

IMPRIMIR_CARACTER:
    CALL POLL
    MOV AL, [BX]
    OUT PB, AL
    CALL RESET_STROBE
RET

ORG 2000H
    CALL INI_PIO
    MOV BX, OFFSET MSJ
    MOV CL, OFFSET FINMSJ - OFFSET MSJ
    PRINT: CALL IMPRIMIR_CARACTER
    INC BX
    DEC CL
    JNZ PRINT
INT 0
END



;c) Imprimir mensaje leído Escribir un programa que solicita el ingreso de cinco caracteres por teclado y
;los envía de a uno por vez a la impresora a través de la PIO a medida que se van ingresando. No es
;necesario mostrar los caracteres en la pantalla. Utilizar la subrutina imprimir_caracter del inciso
;anterior.

PA EQU 30H
PB EQU 31H
CA EQU 32H
CB EQU 33H

ORG 1000h
LARGO DB 5
MSJ DB ?

ORG 3000H
INI_PIO:
    ;CA
    MOV AL, 0FDH ; todo en 1 menos strobe
    OUT CA, AL
    ;CB
    MOV AL, 0 ; todo en 0
    OUT CB, AL
    ;STROBE
    IN AL, PA
    AND AL, 0FDH ; Enmascaro para forzar strobe a 0, dejando todo lo demas en 1
    OUT PA, AL
RET

POLL:
    IN AL, PA
    AND AL, 1 ; XXXX XXXX OR 0000 0001 si da 0, el bit de la izq esta en 1
    JNZ POLL
RET

FORZAR_STROBE:
    IN AL, PA
    OR AL, 2H ; Fuerzo el bit de strobe a 1
    OUT PA, AL
    IN AL, PA
    AND AL, 0FDH ; fuerzo el bit de strobe a 0
    OUT PA, AL
RET

IMPRIMIR_CARACTER:
CALL POLL
MOV AL, BYTE PTR [BX]
OUT PB, AL
CALL FORZAR_STROBE
RET

ORG 2000H
    CALL INI_PIO
    MOV CL, LARGO
    MOV BX, OFFSET MSJ
    LEER: 
    INT 6
    CALL IMPRIMIR_CARACTER
    DEC CL
    JNZ LEER
INT 0
END