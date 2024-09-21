;2) Pasaje de parámetros a través de registros y la pila⭐
;A) Completar las instrucciones del siguiente programa, que envía a una subrutina 3 valores A, B y C a
;través de registros AL, AH y CL, calcula AL+AH-CL, y devuelve el resultado en DL.
org 1000h
    A db 8
    B db 5
    C db 4
    D db ?
org 3000h
    CALC: MOV DL, AL ; inicializo DL con el primer número para luego sumar y restar
    add DL, AH
    sub DL, CL
    RET ; retorno al programa principal
org 2000h
    MOV AL, A ; pueblo AL con la variable A
    MOV AH, B ; pueblo AH con la variable B
    mov CL, C 
    CALL CALC ; llamo la subrutina y paso los parámetros por registro, por valor
    mov D, DL
    hlt
end

;B) Idem el inciso anterior, pero los valores A, B y C se reciben mediante pasaje de parámetros por valor
;a través de la pila. El resultado se devuelve de igual forma por el registro dl y por valor.

org 1000h
    A db 8
    B db 5
    C db 4
    D db ?

org 3000h
CALC: push bx
    mov bx,sp
    add bx, 8 ; sumo 6 al stack pointer para pararme en A
    mov dl, [bx]
    sub bx, 2
    SUB dl, [bx] ; resto C al contenido de B que cargue en DL
    sub bx, 2
    ADD dl, [bx] ; sumo A al contenido de C y D que cargue en DL
    pop bx
    RET ; vuelvo al programa principal
org 2000h
    mov AL, A
    push AX
    MOV AL, C ; paso C a AL para pushearlo a la pila
    push AX
    MOV AL, B ; paso B a AL para pushearlo a la pila
    push AX
    call CALC
    mov D, DL
    POP AX ; saco C de la pila
    POP AX ; saco B de la pila
    POP AX ; saco A de la pila
hlt
end

;C) Modificar el programa anterior para enviar los parámetros A, B y C a través de la pila pero ahora por
;referencia.

org 1000h
    A db 8
    B db 5
    C db 4
    D db ?

org 3000h
CALC: push bx
    mov bx,sp
    add bx, 8 ; sumo 6 al stack pointer para pararme en A
    mov dl, [bx]
    sub bx, 2
    SUB dl, [bx] ; resto C al contenido de B que cargue en DL
    sub bx, 2
    ADD dl, [bx] ; sumo A al contenido de C y D que cargue en DL
    pop bx
    RET ; vuelvo al programa principal
org 2000h
    mov AL, OFFSET A
    push AX
    MOV AL, C ; paso C a AL para pushearlo a la pila
    push AX
    MOV AL, B ; paso B a AL para pushearlo a la pila
    push AX
    call CALC
    mov D, DL
    POP AX ; saco C de la pila
    POP AX ; saco B de la pila
    POP AX ; saco A de la pila
hlt
end