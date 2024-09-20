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
    MOV BL, B ; pueblo BL con la variable B
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
__________
mov dl, [bx]
sub bx, 2
__________
sub bx, 2
__________
pop bx
__________
org 2000h
mov AL, A
push AX
_________
push AX
_________
push AX
call CALC
mov D, DL
______
______
______
hlt
end

;C) Modificar el programa anterior para enviar los parámetros A, B y C a través de la pila pero ahora por
;referencia.