# 3. Lectura e impresión de números enteros
# b) Operaciones con números ⭐⭐ Modificar a) para que además de leer los números, se lea un carácter que
# corresponda a distintas operaciones: +, -, * y /. Calcule la operación correspondiente (suma, resta, multiplicación o
# división). Asumir que el usuario siempre ingresa un carácter correspondiente a una operación válida.
.data
    DIR_CONTROL:    .word   0x10000
    DIR_DATA:       .word   0x10008
    suma:           .word   43
    resta:          .word   45
    mult:           .word   42
    divi:           .word   47
    msj1:           .asciiz "Ingrese el primer numero\n"
    msj2:           .asciiz "Ingrese el segundo numero\n"
    msj3:           .asciiz "Ingrese el operando\n"
    msj4:           .asciiz "El resultado es:\n"
.code
    ld $s5, DIR_CONTROL($0) # inicializo control
    ld $s6, DIR_DATA($0) # inicializo data
    
    daddi $a0, $0, msj1
    jal IMPRIMIR

    # ingreso primer número
    daddi $t0, $0, 8
    sd $t0, 0($s5) # mando comando para habilitar ingreso de #
    ld $s0, 0($s6) # cargo en s0 el num ingresado

    daddi $a0, $0, msj2
    jal IMPRIMIR
    # ingreso segundo número
    daddi $t0, $0, 8
    sd $t0, 0($s5) # mando comando para habilitar ingreso de #
    ld $s1, 0($s6) # cargo en s1 el num ingresado
    
    daddi $a0, $0, msj3
    jal IMPRIMIR
    # ingreso caracter operación
    daddi $t0, $0, 9
    sd $t0, 0($s5) # mando comando para habilitar ingreso de #
    lbu $s3, 0($s6) # cargo en s3 el caracter ingresado

    # chequeo a qué operación corresponde el caracter
    lbu $t1, suma($0)
    beq $s3, $t1, SUMAR
    lbu $t1, resta($0)
    beq $s3, $t1, RESTAR
    lbu $t1, mult($0)
    beq $s3, $t1, MULTIPLICAR
    lbu $t1, divi($0)
    beq $s3, $t1, DIVIDIR
    # si no es ninguna, termino
    j fin
    # realizo la operación
    SUMAR:
    dadd $s2, $s0, $s1
    j TERMINAR
    RESTAR:
    dsubu $s2, $s0, $s1
    j TERMINAR
    MULTIPLICAR:
    dmul $s2, $s0, $s1
    j TERMINAR
    DIVIDIR:
    ddiv $s2, $s0, $s1
    j TERMINAR

    IMPRIMIR:
    sd $a0, 0($s6) # guardo lo que venga en a0 en Data
    daddi $t2, $0, 4 # código para imprimir
    sd $t2, 0($s5) # envío instrucción para imprimir
    jr $ra

    TERMINAR:
    daddi $a0, $0, msj4
    jal IMPRIMIR
    sd $s2, 0($s6)
    daddi $t0, $0, 2
    sd $t0, 0($s5) # imprime número entero

fin: halt