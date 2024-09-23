;--------------------------------------------------------;
;3) Errores comunes al mostrar y leer caracteres ⭐
;Los siguientes programas leen e imprimen carácteres. Indicar cuáles tienen errores y cómo solucionarlos.
;--------------------------------------------------------;

ORG 1000H
    A DB “HO LA”
    B DB ?
ORG 2000H
    mov bx, offset A
    mov al, 4
    int 7
END

;-------RTA: la longitud del mensaje es incorrecta: "HO LA" son 5 caracteres dado que el espacio cuenta. Falta HLT o INT 0.

ORG 1000H
    A DB “ARQ”
    B DB ?
ORG 2000H
    mov al, 3
    mov bx, A
    int 7
END
;-------RTA: lo que debe cargarse en BX es OFFSET A, es decir la dirección de la variable y no la variable en sí. Falta HLT o INT 0.

ORG 1000H
    A DB “HOLA”
    B DB ?
ORG 2000H
    mov al, offset A - offset B
    mov bx, offset A
    int 7
END
;-------RTA: OFFSET A - OFFSET B da negativo, ya que la dirección de B es mayor. Debería ser al reves: MOV AL, OFFSET B - OFFSET A. Falta HLT o INT 0.

ORG 1000H
    A DB ?
ORG 2000H
    mov al, 3
    mov bx, A
    int 6
END
;-------RTA: No debe poblarse BX con la variable (que además tiene basura en este caso) sino con el offset de A, para apuntar a la dirección que debe ir el caracter que se carga con INT 6. Falta HLT o INT 0.

ORG 1000H
    A DB ?
ORG 2000H
    int 6
    mov bx, offset A
END
;-------RTA: Están al revés las instrucciones: Si seteamos BX, OFFSET A después de INT 6, al momento de ser ejecutado INT 6 no tiene configurado dónde guardar el caracter que recibe por teclado. Falta HLT o INT 0.

ORG 1000H
    A DB ?
ORG 2000H
    mov bx, A
    int 6
    mov al, 1
    int 7
END
;-------RTA: BX debe poblarse con OFFSET A, no con A. Falta HLT o INT 0.