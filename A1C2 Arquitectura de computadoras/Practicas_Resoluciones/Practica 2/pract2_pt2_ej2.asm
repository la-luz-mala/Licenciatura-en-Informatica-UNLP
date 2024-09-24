;2) Verificación del bit busy⭐
;El siguiente programa tiene como objetivo verificar el bit de busy a través del PIO e imprimir “Ocupada” si la
;impresora está ocupada y “Libre” de lo contrario.
;a) Complete el código para que el programa funcione correctamente.

PA EQU 30h
CA EQU 32h
ORG 1000h
si db “Ocupada”
no db “Libre”
ORG 2000H
MOV AL, 0FDH ; Faltante: Seteo AL como 0FDH (1111 1101 porque el bit de strobe tiene que estar en 0)
out CA, al
in al, PA
AND AL, 1 ; Faltante: Máscara con 1 para que devuelva 0000 0000 si el bit de busy es 0 (es decir: está libre)
jnz ocupada
MOV BX, OFFSET no ; Faltante: posición de inicio del mensaje
mov al, 5
int 7
jmp fin
ocupada: mov bx, offset si
mov al, 7
int 7 ; Faltante: Imprimir el mensaje de Ocupada
fin: int 0
end

;b) Modifique el código para que el programa no imprima “Ocupada”. En lugar de eso, el programa debe
;esperar a que el bit de busy sea 0 usando consulta de estado. Cuando eso suceda, imprimir “Libre” y
;terminar el programa.

PA EQU 30h
CA EQU 32h
ORG 1000h
    si db "Ocupada"
    no db "Libre"
ORG 2000H
    MOV AL, 0FFH
    out CA, al
chequear: 
    in al, PA ; Agrego: tag Chequear
    AND AL, 1
    jnz chequear ; si la impresora está ocupada (es decir si el and no da cero) salto de nuevo a Chequear
    MOV BX, OFFSET no
    mov al, 5
    int 7
    int 0
end