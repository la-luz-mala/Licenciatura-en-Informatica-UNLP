;1) Instrucciones de entrada y salida con Luces y Llaves⭐
;Los siguientes programas interactúan mediante instrucciones IN y OUT con las luces y llaves a través del PIO.
;Completar las instrucciones faltantes, e indicar que hace el programa en cada caso.

PB EQU 31h
CB EQU 33h ; Faltante: Inicializo CB en 33h

ORG 2000H
MOV AL, 00H ; Faltante: Inicializo CB en 00h, todos los bits como salida.
out CB, al
mov al, 0Fh
out PB, al
int 0
end

;______________________;

PA EQU 30h ; Faltante: Inicializo PA en 30h
CA EQU 32h

ORG 1000h
msj db “Apagadas”
ORG 2000H
mov al, 0FFh
OUT CA, AL ; Faltante: Seteo CA todo en 1, todos los bits como entrada
in al, PA ; Traigo el estado actual de las clavijas
cmp al, 0 ; Si no están las clavijas en 0, salto a FIN
jnz fin ; si están todas apagadas, imprimo el mensaje
mov al, 8 
mov bx , offset msj
int 7
fin: int 0
end

;______________________;

PA EQU 30h ; Faltante: Inicializo PA en 30h
PB EQU 31h
CA EQU 32h
CB EQU 33h ; Faltante: Inicializo CB en 33h

ORG 2000h
MOV AL, 0FFH ; Faltante: muevo FFh a AL
OUT CA, AL ; Faltante: Paso a CA el valor 0FFh para habilitar todas las clavijas como entrada
MOV AL, 00H ; Faltante: muevo 00h a AL
out CB, al ; Paso a CB el valor 00h para habilitar todos los leds como salida
in al, PA ; Leo qué clavijas están activadas y paso ese valor a AL
out PB, al ; Replico en las luces el valor de AL, es decir activo los leds de acuerdo a que clavijas estaban activas
int 0
end