;--------------------------------------------------------;
;1) Repaso de Conceptos de Pila y Subrutinas
;A) Uso de la pila ⭐Si el registro SP vale 8000h al comenzar el programa, indicar el valor del registro SP
;luego de ejecutar cada una de las instrucciones de la tabla, en el orden en que aparecen. Indicar, de la
;misma forma, los valores de los registros AX y BX.
;--------------------------------------------------------;

;Instrucción Valor del registro SP AX BX
; INICIAL -- SP: 8000h; AX: ????; BX: ????
1   mov ax,5 ; SP: 8000h (no se modifica); AX: 0005h; BX: ???? (no se modifica)
2   mov bx,3 ; SP: 8000h (no se modifica); AX: 0005h (no se modifica); BX: 0003h
3   push ax ; SP: 7FFEh (-2 por push); AX: 0005h (no se modifica); BX: 0003h (no se modifica)
4   push ax ; SP: 7FFCh (-2 por push); AX: 0005h (no se modifica); BX: 0003h (no se modifica)
5   push bx ; SP: 7FFAh (-2 por push); AX: 0005h (no se modifica); BX: 0003h (no se modifica)
6   pop bx ; SP: 7FFCh (+2 por push); AX: 0005h (no se modifica); BX: 0003h (no se modifica)
7   pop bx ; SP: 7FFEh (+2 por push); AX: 0005h (no se modifica); BX: 0005h
8   pop ax ; SP: 8000h (+2 por push); AX: 0005h (no se modifica); BX: 0005h (no se modifica)

;--------------------------------------------------------;
;B) Llamadas a subrutinas y la pila⭐Si el registro SP vale 8000h al comenzar el programa, indicar el valor
;del registro SP luego de ejecutar cada instrucción. Considerar que el programa comienza a ejecutarse con el
;IP en la dirección 2000h, es decir que la primera instrucción que se ejecuta es la de la línea 5 (push ax).
;Nota: Las sentencias ORG y END no son instrucciones sino indicaciones al compilador, por lo tanto no se
;ejecutan.
;--------------------------------------------------------;
; INICIAL -- SP: 8000h

;Instrucción Valor del registro SP
1 org 3000h             -----
2 rutina: mov bx,3      ;SP: 7FFCh (no se modifica con MOV)
3 ret                   ;SP: 7FFEh (+2 por el pop implicito en el ret)
4 org 2000h             -----
5 push ax               ;SP: 7FFEh (-2 por push)
6 call rutina           ;SP: 7FFCh (-2 por el push implicito en el call)
7 pop bx                ;SP: 8000h (+2 por el pop)
8 hlt                   ;SP: 8000h (no se modifica por el hlt)
9 end                   -----

;--------------------------------------------------------;
;C) Llamadas a subrutinas y dirección de retorno⭐
;Si el registro SP vale 8000h al comenzar el programa, indicar el valor de SP y el contenido de la pila luego
;de ejecutar cada instrucción. Si el contenido es desconocido/basura, indicarlo con el símbolo ?. Considerar
;que el programa comienza a ejecutarse con el IP en la dirección 2000h, es decir que la primera instrucción
;que se ejecuta es la de la línea 5 (call rut). Se provee la ubicación de las instrucciones en memoria, para
;poder determinar la dirección de retorno de la rutina.
;Además, explicar detalladamente:
;a) Las acciones que tienen lugar al ejecutarse la instrucción call rut
;b) Las acciones que tienen lugar al ejecutarse la instrucción ret
;--------------------------------------------------------;

org 3000h
rut: mov bx,3 ; Dirección 3000h         ;SP: 7FFEh (no se modifica). Pila: al tope, 2002h. 2do llamado, al tope: 2006h
ret ; Dirección 3002h                   ;SP: 8000h (+2 por pop implicito). Pila: al tope, ?

org 2000h                               ;INICIO -- SP: 8000h. Pila: ?
call rut ; Dirección 2000h              ;SP: 7FFEh (-2 por push implicito). Pila: Al tope, 2002h
add cx,5 ; Dirección 2002h              ;SP: 8000h. Pila: ?
call rut ; Dirección 2004h              ;SP: 7FFEh (-2 por push implicito). Pila: Al tope, 2006h
hlt ; Dirección 2006h                   ;SP: 8000h. Pila: al tope, ?
end

;a) Al ejecutarse la instrucción call rut, la dirección de retorno (de la siguiente instrucción) es agregada al tope de la pila, moviendo el SP -2 posiciones. Se pone como IP actual la dirección de la rutina llamada.
;b) Al ejecutarse la instrucción ret, la dirección de retorno es tomada del tope de la pila y colocada como IP actual para regresar al programa principal, moviendo el SP +2 posiciones por desapilar.