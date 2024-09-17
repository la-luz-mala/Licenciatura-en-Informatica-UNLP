;--------------------------------------------------------;
;Convertir carácter a minúscula ⭐Escribir un programa que convierta un carácter de mayúsculas a
;minúsculas. El carácter está almacenado en la variable C. Asumir que el carácter es una mayúscula.
;Pista: Las mayúsculas y las minúsculas están en el mismo orden en el ASCII, y por ende la distancia
;entre, por ejemplo, la “A” y la “a” es la misma que la distancia entre la “Z” y la “z”.
;--------------------------------------------------------;

ORG 1000H
C DB "B"
DIF DB "a"

ORG 2000H
MOV BL, DIF ; pueblo BL con la variable DIF
SUB BL, 'A' ; resto "A" al valor de DIF, "a". Como la "a" está más adelante en la tabla ASCII, se guarda en BL la diferencia entre ambas letras
ADD C, BL ; agrego a la letra mayúscula la diferencia
HLT
END