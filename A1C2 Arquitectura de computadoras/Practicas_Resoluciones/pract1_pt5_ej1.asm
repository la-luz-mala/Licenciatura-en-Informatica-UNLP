;1) Ahorcado secuencial⭐⭐
;Escribir un programa que permita a una persona desafiar a otra jugando al ahorcado secuencial. En el
;ahorcado secuencial, a diferencia del tradicional, hay que adivinar las letras en orden. Por ejemplo, si la
;palabra a adivinar es “alma”, la persona que adivina debe ingresar primero la “a”, luego la “l”, luego la “m” y
;finalmente debe ingresar nuevamente la “a”.
;El programa tiene dos fases: primero, una persona carga la palabra a adivinar, y luego la otra persona
;adivina la palabra.
;● Fase 1: Se debe mostrar el mensaje “Ingresá la palabra a adivinar: ”. Luego, se debe leer un string
;hasta que llegue el carácter “.”, y al terminar de leer, se debe mostrar el mensaje “Comenzá a
;adivinar!”.
;● Fase 2: se deben leer carácteres hasta que la persona termine de adivinar todo el string, o se le
;acaben los intentos.
;Si la persona ingresa un carácter que coincide con el que tenía que adivinar, se muestra ese
;carácter en pantalla, y se avanza al carácter siguiente del string a adivinar. De lo contrario, no se
;muestra nada, y la persona debe seguir intentando. Sí adivinó todo el string, debe mostrarse el
;mensaje “Ganaste!”.
;La persona tiene 50 intentos de letras para adivinar el string. Si se acaba la cantidad de intentos y
;no adivinó todo el string, debe mostrarse el mensaje “Perdiste, el string era S”, donde S es el string a
;adivinar completo.

ORG 1000H
INIT DB "Ingresá la palabra a adivinar: "
ADIV DB "Comenzá a adivinar!"
WIN  DB "Ganaste!"
LOSS DB "Perdiste, el string era "
TRY  DB 3
LONG DB 0
PAL  DB ?
RTA  DB ?

ORG 1100H
RTA  DB ?

ORG 3000H
INGRESA:
    INC LONG ; +1 a la longitud de la palabra
    MOV BX, OFFSET PAL ; apunto donde empieza la palabra
    LEER: INT 6 ; ingresa caracter
    CMP BYTE PTR [BX], 2Eh ; comparo el caracter con "."
    JZ FIN ; Si el caracter es ".", salgo de la subrutina
    INC BX ; Si no, incremento BX para apuntar al siguiente
    JMP LEER ; Vuelvo a leer caracter
FIN: RET

ADIVINA:
    PUSH DX ; salvo valor de DX
    PUSH AX ; salvo valor de AX
    MOV DX, 0 ; inicio un contador en 0
LEER2: MOV BX, OFFSET PAL ; cargo la dirección de la palabra correcta
    ADD BX, DX ; sumo contador a la direccion
    MOV AL, BYTE PTR [BX] ; muevo el caracter de la palabra correcta a AX
    CMP AL, 2EH ; comparo el caracter con .
    JZ GANAS
    MOV BX, OFFSET RTA
    INT 6 ; ingreso un caracter, se carga en BX
    CMP [BX], AL
    JNZ ERROR
    MOV AL, 1 ; Cargo longitud 1
    INT 7; imprimo la letra correcta
    INC DX ; sumo el contador para pasar a la sgte letra
    JMP LEER2
ERROR:
    DEC TRY
    JZ PERDES
    JMP LEER2
GANAS:
    MOV BX, OFFSET WIN
    MOV AL, OFFSET LOSS - OFFSET WIN
    INT 7
    JMP FINADIVINA
PERDES:
    MOV BX, OFFSET LOSS
    MOV AL, OFFSET TRY - OFFSET LOSS
    INT 7
    MOV BX, OFFSET PAL
    MOV AL, LONG
    INT 7
FINADIVINA:
    POP AX
    POP DX
RET


ORG 2000H
    MOV BX, OFFSET INIT ; Cargo en BX el inicio de "Ingresa la palabra"
    MOV AL, OFFSET ADIV - OFFSET INIT ; Cargo en AL cantidad de caracteres
    INT 7 ; Imprimo "Ingresa la palabra"
    CALL INGRESA ; Llamo a la subrutina para ingresar la palabra

    MOV BX, OFFSET ADIV ; cargo en BX el inicio de "comenzá a adivinar"
    MOV AL, OFFSET WIN - OFFSET ADIV ; cargo en AL la cantidad de caracteres
    INT 7 ; imprimo

    CALL ADIVINA
    int 0
end