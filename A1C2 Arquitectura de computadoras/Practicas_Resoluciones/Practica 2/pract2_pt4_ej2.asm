;2) CriptoLlaves (Llaves, Luces):⭐⭐⭐
;Escriba un programa de VonSim que permita jugar al CriptoLlaves. El usuario debe adivinar un patrón secreto
;de 8 bits que está almacenado en la memoria del programa. Para ello, debe manipular las llaves hasta que el
;patrón de bits de las llaves sea exactamente igual al del patrón secreto. Como ayuda para el usuario, si el estado
;de una llave acierta al bit correspondiente, el programa debe prender el led correspondiente. Por ejemplo, si el
;patrón es 0100 0101 y las llaves están en el estado 1110 0100, deben prenderse las luces de los bits 1, 2, 3, 4 y 6.
;Como no acertó a todos los bits, el usuario no ha adivinado el patrón y debe continuar jugando.
;El programa termina cuando el usuario acierta todos los bits del patrón, mostrando en pantalla el mensaje
;"GANASTE".

;Declaro el PIO
PA EQU 30H
PB EQU 31H
CA EQU 32H
CB EQU 33H

ORG 1000H
PATRON DB 11111111B
WIN DB "GANASTE"

ORG 3000H
INI_PIO:
;CA
    MOV AL, 0FFH
    OUT CA, AL
;CB
    MOV AL, 0
    OUT CB, AL
RET

ORG 2000H
CALL INI_PIO
CLAVIJAS: MOV DL, PATRON ; Pongo la clave en DL
  IN AL, PA ; Traigo el estado de las clavijas
  XOR DL, AL ; XOR: vuelven 1s donde el valor es diferente
  JZ GANO ; si vuelve todo en 0, los valores son iguales
  NOT DL ; invierto el resultado del XOR: ahora hay 1 donde son iguales
  MOV AL, DL ; mando ese valor a AL
  OUT PB, AL ; mando ese valor a los pins
  JMP CLAVIJAS ; chequeo de nuevo

GANO:
  MOV AL, 0FFH ; me aseguro que todas las clavijas estén prendidas pq me salto el ultimo out
  OUT PB, AL
  MOV BX, OFFSET WIN
  MOV AL, 7
  INT 7
  
INT 0

END