;--------------------------------------------------------;
;Es mayúscula ⭐Escribir un programa que determine si un carácter (un string de longitud 1) es una
;letra mayúscula. El carácter está almacenado en la variable C, y el resultado se guarda en la variable
;RES de 8 bits. Si C es mayúscula, debe almacenarse el valor 0FFh en RES; de lo contrario, debe
;almacenarse 0. Pista: Los códigos de las mayúsculas son todos consecutivos. Buscar en la tabla ASCII
;los caracteres mayúscula, y observar qué valores ASCII tienen la ‘A’ y la ‘Z’.
;--------------------------------------------------------;

ORG 1000H
C DB "C"
RES DB ?

ORG 2000H
MOV BL, C ; pueblo BX con C
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

FIN: HLT

END