;6) F10 con Timer
;a) Conteo regresivo ⭐⭐: Escribir un programa que implemente un conteo regresivo a partir de un valor
;(de 1 a 9) ingresado desde el teclado. El conteo debe comenzar al presionarse la tecla F10. El tiempo
;transcurrido debe mostrarse en pantalla, actualizándose el valor cada segundo. Por ejemplo, si se
;ingresa el valor 7, cuando se apreta F10 debe mostrarse en pantalla “7 6 5 4 3 2 1 0” en los 7 segundos
;siguientes
;Pista: Una vez leído el dígito se puede activar solamente la interrupción F10, y cuando se invoque la
;subrutina F10 activar el Timer para que a partir de ese momento se muestre el conteo regresivo.
;b) Conteo regresivo con pausa⭐⭐Escribir un programa que cuente de forma regresiva desde 9 hasta 0,
;mostrando el tiempo en pantalla.. Luego de que termine de contar, si se presiona F10 debe comenzar de
;nuevo la cuenta desde 9 hasta 0. Además, si en algún momento se presiona la tecla F10 durante el
;conteo, el mismo debe pausarse, y reanudarse sólo cuando se presiona nuevamente F10.
;Pista: Utilizar un flag de estado “PAUSA” que se controla mediante la tecla F10, y que la subrutina
;del timer puede consultar para saber si debe decrementar el contador y mostrar en pantalla.

EOI EQU 20H
IMR EQU 21H
INT1 EQU 25H
CONT EQU 10H
COMP EQU 11H
ID_TIMER EQU 10

ORG 40
DIR_TIMER DW CONTEO

ORG 1000H
AUX DB 9

ORG 3000H
CONTEO:
MOV BX, DL
MOV AL, 1
INT 7
DEC DL
JNZ SEGUIR
MOV AL, 0FFH
OUT IMR, AL
SEGUIR: MOV AL, EOI
OUT EOI,AL
IRET

ORG 2000H
CLI
;IMR
MOV AL, 0FDH
OUT IMR, AL
;INT1
MOV AL, ID_TIMER
OUT INT1, AL
;TIMER
MOV AL, 0
OUT CONT
MOV AL, 1
OUT COMP
STI
MOV DL, AUX
LAZO: CMP DL, 0
JNZ LAZO


INT 0
END