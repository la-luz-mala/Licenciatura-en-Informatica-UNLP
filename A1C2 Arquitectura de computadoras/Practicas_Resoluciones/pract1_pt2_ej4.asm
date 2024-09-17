;--------------------------------------------------------;
;4) Mostrar caracteres individuales ⭐
;a) Escribir un programa que muestre en pantalla las letras mayúsculas (“A” a la “Z”).
;Pista: Podés buscar los códigos de la “A” y la “Z” en una tabla de códigos ascii. No utilizar un vector.
;Usar una sola variable de tipo db, e incrementar el valor de esa variable antes de imprimir.
;b) ¿Qué deberías modificar en a) para mostrar los dígitos (“0” al “9”)? ¿Y para mostrar todos los
;carácteres disponibles en el código ASCII? Probar en el simulador.
;-------RTA: Poblar LETRA con 0 y en el CMP reemplazar 5Bh con 0Ah. Para todos los caracteres en ASCII, poblar LETRA con 0 y reemplazar 5Bh con 80h.
;--------------------------------------------------------;


ORG 1000H
    LETRA DB 'A' ;Pueblo una variable con "A"
ORG 2000H
    MOV BX, OFFSET LETRA ;Indico al INT 7 la dirección donde comienza el mensaje
    MOV AL, 1 ;Establezco el largo del mensaje
LOOP:
    INT 7 ;Imprimo el mensaje
    INC LETRA ;Incremento la variable para cambiar de letra
    CMP LETRA, 5BH ;Comparo la variable LETRA con el caracter siguiente a Z
    JNZ LOOP ;Si no son iguales, salto al loop de nuevo
INT 0 ;Detengo el programa
END


;--------------------------------------------------------;
;c) Modificar el ejercicio b) que muestra los dígitos, para que cada dígito se muestre en una línea separada.
;Pista: El código ASCII del carácter de nueva línea es el 10, comúnmente llamado “\n” o LF (“line
;feed” por sus siglas en inglés y porque se usaba en impresoras donde había que “alimentar” una
;nueva línea).
;--------------------------------------------------------;

ORG 1000H
    LETRA   DB '1' ;Pueblo una variable con "A"
            DB 0AH ;Agrego el salto de línea como 2do valor de LETRA
ORG 2000H
    MOV BX, OFFSET LETRA ;Indico al INT 7 la dirección donde comienza el mensaje
    MOV AL, 2 ;Establezco el largo del mensaje: 2 caracteres, o sea el número + el salto de línea
LOOP:
    INT 7 ;Imprimo el mensaje
    INC LETRA ;Incremento la variable para cambiar de número, no afecta al 2do valor
    CMP LETRA, 3Ah ;Comparo la variable LETRA con el caracter siguiente a 9
    JNZ LOOP ;Si no son iguales, salto al loop de nuevo
INT 0 ;Detengo el programa
END