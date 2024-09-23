;--------------------------------------------------------;
;Reimplementar los programas del Ejercicio 1 - Parte 1, pero ahora implementando las siguientes subrutinas.
;En todos los casos, recibir los valores por parámetros pasados por registro, y devolver el resultado también
;por valor y por registro.
;--------------------------------------------------------;
;1. 📄CONTAR_CAR ⭐Recibe la dirección de comienzo de un string en BX, su longitud en AL, y el
;carácter a contar en AH. Retorna en CL la cantidad de veces que aparece el carácter.

ORG	1000H
  MSJ DB "HolaAa"
  FINMSJ DB ?
  CHAR DB "a"
ORG 3000h
  LAZO: CMP BYTE PTR [BX], AH ;comparo lo que hay en BX (la letra del msj) con la letra alojada en AH
  JNZ SIGUIENTE ; si NO son iguales, salta a Siguiente
  INC DX ; si son iguales, suma 1 al contador DX
  SIGUIENTE: INC BX ; incrementa en 1 la posición de la comparación
  DEC AL ;resta 1 al total de letras para loopear
  JNZ LAZO ; si no se nos acabaron las letras, salto a Lazo de nuevo
  RET
ORG 2000H
  MOV BX, OFFSET MSJ ; traigo la dirección del primer caracter a BX
  MOV AL, OFFSET FINMSJ - OFFSET MSJ ; me fijo cuantos numeros tengo que loopear, lo alojo en AL
  MOV DX, 0 ; inicializo el contador de "a"s en DX
  MOV AH, CHAR
  CALL LAZO
  HLT
END


;2. 📄 ES_MAYUS ⭐ Recibe un carácter en el registro AL y retorna en AH el valor 0FFh si es
;mayúscula y 0 de lo contrario.
ORG 1000H
C DB "C"
RES DB ?

ORG 3000h
ES_MAYUS:
CMP BL, 61H ; resto BX con 61h, "a"
JC MAY ; si el numero dio negativo, por ende hay carry, puede ser mayúscula. Salto a MAY
JMP MIN ; Si dio positivo puede ser minúscula, salto a MIN
MAY: CMP BL, 41h ; comparo BX con "A"
JC FIN ; si es menor, es un caracter especial
CMP BL, 5Bh ; sino, comparo BX con el caracter siguiente a "Z"
JNC FIN ; si no hay carry es un caracter especial entre "Z" y "a"
MOV RES, 0FFH; si es negativo, es una letra mayúscula
JMP FIN
MIN: CMP BL, 7BH ;comparo BC con 7BH, el caracter siguiente a "z"
JNC FIN ; si no hay carry es un caracter especial después de la "z"
MOV RES, 0 ; si hay carry es una letra minúscula
JMP FIN
RET

ORG 2000H
MOV BL, C ; pueblo BX con C
CALL ES_MAYUS
FIN: HLT

END

;3. 📄A_MINUS⭐Recibe un carácter mayúscula en AL y lo devuelve como minúscula.

ORG 1000H
C DB "B"
DIF DB "a"

ORG 3000H
A_MINUS:
SUB BL, 'A' ; resto "A" al valor de DIF, "a". Como la "a" está más adelante en la tabla ASCII, se guarda en BL la diferencia entre ambas letras
ADD C, BL ; agrego a la letra mayúscula la diferencia
RET

ORG 2000H
MOV BL, DIF ; pueblo BL con la variable DIF
CALL A_MINUS
HLT
END

;4. 📄STRING_A_MINUS ⭐⭐Recibe la dirección de comienzo de un string en BX, su longitud en
;AL. Recorre el string, cambiando a minúscula las letras que sean mayúsculas. No retorna nada, sino
;que modifica el string directamente en la memoria.

ORG 1000h
MENSAJE DB "HOLA"
FIN DB ?
DIF DB "a"

ORG 3000H
STRING_A_MINUS:
SUB DIF, 'A' ; Obtengo la diferencia entre "a" y "A" en ASCII
MOV DL, 0 ; limpio DL
MOV DL, [BX] ; pongo el código ASCII de la letra analizada en DL
ADD DL, DIF ; le sumo la diferencia entre mayúsculas & minúsculas
MOV [BX], DL ; sumo esta diferencia a la posición en memoria correspondiente
INC BL ; incremento la posición de memoria para pasar a la siguiente letra
DEC AL ; bajo en 1 el contador
JNZ STRING_A_MINUS ; si el contador != 0, sigo loopeando
RET

ORG 2000h
MOV AX, OFFSET FIN ; pueblo AX con la dirección de FIN
SUB AX, OFFSET MENSAJE ; obtengo la cantidad de caracteres de MENSAJE restando su dirección a la dirección de FIN
MOV BX, OFFSET MENSAJE ; muevo la dirección de inicio de MENSAJE a BX
CALL STRING_A_MINUS
HLT
END