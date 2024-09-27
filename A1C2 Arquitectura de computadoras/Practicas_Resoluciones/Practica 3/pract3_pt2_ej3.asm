;3) Contador de pulsaciones ⭐El siguiente programa cuenta el número de veces que se presiona la tecla F10 y
;acumula este valor en el registro DX. El programa nunca termina, ya que ejecuta un loop infinito. Completar
;las instrucciones faltantes para que el programa funcione correctamente.

EOI EQU 20H
IMR EQU 21H
INT0 EQU 24H ; Faltante: definir el puerto para INT0
N_F10 EQU 15

ORG 60 ; Faltante: Dirección para redireccionar el puerto
IP_F10 DW RUT_F10

ORG 2000H
CLI
MOV AL, 0FEH
OUT IMR, AL ; Faltante: inicializar el IMR
MOV AL, N_F10 ; Faltante: poblar AL con la dirección para redireccionamiento de instrucción de interrupción
OUT INT0, AL
MOV DX, 0
STI
LAZO:JMP LAZO

ORG 3000H
RUT_F10:PUSH AX
INC DX ; Faltante: incrementar el contador
MOV AL, EOI
OUT EOI, AL ; Faltante: enviar 20h al EOI
POP AX
IRET
END

;Luego de completarlo, verifique su funcionamiento en el simulador, y explicar detalladamente:
;A. ¿Qué hacen las instrucciones CLI y STI? ¿Qué podría suceder si no están las mismas y la persona que
;usa el programa presiona F10 rápidamente durante la configuración del PIC?
;RTA: CLI es un flag del lado del CPU que detiene las interrupciones. STI re-comienza a recibir interrupciones.
;Si no estuvieran y se presionase F10 anteriormente, la instrucción no se ejecutaría ya que todavía no están
;configuradas las instrucciones.

;B. ¿Por qué se usa el valor 0FEH en el programa?
;RTA: Para poblar el IMR con 1111 1110 y habilitar así la interrupción por F10 (INT0 -> el bit 0)

;C. ¿Qué instrucciones le indican al PIC que la interrupción ha terminado?
;RTA: Las instrucciones OUT EOI, AL que envía la señal 20h al EOI y la instrucción IRET que regresa al programa principal.
;D. ¿En qué dirección se encuentra la subrutina que atiende las interrupciones del F10?
;El vector de interrupciones se encuentra en la posición 60 de la tabla, y la subrutina se encuentra en 3000h.