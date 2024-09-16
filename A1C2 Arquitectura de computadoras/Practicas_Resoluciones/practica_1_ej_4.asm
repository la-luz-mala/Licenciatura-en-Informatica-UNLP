;--------------------------------------------------------;
;Convertir string a minúscula ⭐Escribir un programa que convierta todos los carácteres de un string
;MENSAJE a minúscula. Por ejemplo, si MENSAJE contiene “Hola, Buenas Tardes”, luego de ejecutar el
;programa debe contener “hola, buenas tardes”.
;--------------------------------------------------------;

ORG 1000h
MENSAJE DB "HOLA"
FIN DB ?
DIF DB "a"

ORG 2000h
SUB DIF, 'A' ; Obtengo la diferencia entre "a" y "A" en ASCII
MOV AX, OFFSET FIN ; pueblo AX con la dirección de FIN
SUB AX, OFFSET MENSAJE ; obtengo la cantidad de caracteres de MENSAJE restando su dirección a la dirección de FIN
MOV BX, OFFSET MENSAJE ; muevo la dirección de inicio de MENSAJE a BX

LOOP:
MOV DL, 0 ; limpio DL
MOV DL, [BX] ; pongo el código ASCII de la letra analizada en DL
ADD DL, DIF ; le sumo la diferencia entre mayúsculas & minúsculas
MOV [BX], DL ; sumo esta diferencia a la posición en memoria correspondiente
INC BL ; incremento la posición de memoria para pasar a la siguiente letra
DEC AL ; bajo en 1 el contador
JNZ LOOP ; si el contador != 0, sigo loopeando
HLT
END