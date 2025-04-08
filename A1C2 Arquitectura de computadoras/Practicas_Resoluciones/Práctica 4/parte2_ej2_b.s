# 2. Comprobación de clave⭐⭐
# b) Comprobación infinita Modificar el programa anterior para solicitar nuevamente el ingreso de la clave cuando es
# incorrecta. El programa solo termina cuando la clave ingresada es la correcta

.data
    DIR_CONTROL:    .word   0x10000 # declarar DIR_CONTROL
    DIR_DATA:       .word   0x10008 # declarar DIR_DATA
    clave:          .asciiz "1234" # declarar clave
    ingrese:        .asciiz "Ingrese una clave de 4 carácteres\n" # declarar string "Ingrese una clave de 4 carácteres"
    fail:           .asciiz "Clave incorrecta, inténtelo nuevamente\n" # declarar string "Clave correcta: acceso permitido"
    win:            .asciiz "Clave correcta, acceso permitido\n" # declarar string "Clave incorrecta."
    nueva:          .asciiz ""

.code
    ld $s0, DIR_CONTROL($0) # configuro control
    ld $s1, DIR_DATA($0) # configuro data

    INGRESE: daddi $a0, $0, ingrese # mando a a0 lo que quiero imprimir y llamo a la subrutina
    jal PRINT
    jal LOAD # Subrutina para ingresar 4 caracteres
    
    # Comparar los caracteres con clave
    daddi $t0, $0, 0 # inicializo un contador
    otra:
    slti $t1, $t0, 4 # comparo el contador con 4, si es menor sigo
    beqz $t1, CORRECTO # si NO es menor, todos los caracteres fueron iguales
    lbu $t1, nueva($t0) # cargo primer caracter de "nueva"
    lbu $t2, clave($t0) # cargo primer caracter de "clave"
    daddi $t0, $t0, 1 # aumento en 1 el contador
    beq $t1, $t2, otra # comparo los caracteres, si son iguales busco otro
    
    # Clave incorrecta
    daddi $a0, $0, fail
    jal PRINT
    j INGRESE # NUEVA LÍNEA PARA QUE SEA INFINITO

CORRECTO:
    daddi $a0, $0, win
    jal PRINT
    j fin

PRINT:
    sd $a0, 0($s1) # guardo lo que venga en a0 en Data
    daddi $t2, $0, 4 # código para imprimir
    sd $t2, 0($s0) # envío instrucción para imprimir
    jr $ra

LOAD:
    daddi $t2, $0, 9 # código para permitir ingreso de caracter
    daddi $t0, $0, 0 # inicializo contador en 4
    INGRESAR:
    sd $t2, 0($s0) # envío instrucción para permitir ingreso de caracter
    lbu $t3, 0($s1) # busco el caracter ingresado en DATA
    sb $t3, nueva($t0) # cargo el caracter en Nueva
    daddi $t0, $t0, 1 # sumo 1 al puntero / contador
    slti $t1, $t0, 4
    bnez $t1, INGRESAR
    jr $ra

fin: halt