# 1. Comprendiendo la primer subrutina: potencia⭐
# f) Escriba un programa que lea un exponente x y calcule 2^x + 3^x utilizando dos llamadas a potencia.
# Muestre en pantalla el resultado. ¿Funciona correctamente? Si no lo hace, revise su implementación
# del programa ¿Qué sucede cuando realiza una segunda llamada a potencia? Pista: Como caso de prueba,
# intente calcular 2³+3³ = 8+27 = 35..

.data
    msj1:    .asciiz "Ingrese el exponente\n"
    msj2:    .asciiz "Resultado: "
    DATA:    .word   0x10008
    CTRL:    .word   0x10000
.code
    ld $t8, CTRL($0)
    ld $t9, DATA($0)
    daddi $sp, $zero, 0x300

    daddi $t0, $0, msj1         # cargar msj1 en t0
    sb $t0, 0($t9)              # mandar msj1 a Data
    daddi $t1, $0, 4            # cargar 4 en t1
    sd $t1, 0($t8)              # mandar t1 a Control p/ impresion de texto

    daddi $t1, $0, 8            # cargar 8 en t1 p/ ingreso de número
    sd $t1, 0($t8)              # mandar t1 a Control

    ld $a1, 0($t9)              # cargar en a1 lo que viene a Data
    daddi $a0, $0, 2            # cargar 2 en a0

    jal potencia                # llamar a potencia
    daddi $t5, $v0, 0

    daddi $a0, $0, 3            # cargar 3 en a0
    jal potencia                # llamar a potencia

    dadd $t5, $t5, $v0

    daddi $t0, $0, msj2         # cargar msj2 en t0
    sb $t0, 0($t9)              # mandar t0 a Data
    daddi $t1, $0, 4            # cargar 4 en t1
    sd $t1, 0($t8)              # mandar t1 a Control
    sb $t5, 0($t9)              # mandar t5 a Data
    daddi $t1, $0, 1            # cargar 1 en t1
    sd $t1, 0($t8)              # mandar t1 a Control
halt
    potencia:
    daddi $sp, $sp, -16             # resto 8 a SP
    sd $a1, 0($sp)                  # guardo a1 en el stack
    sd $ra, 8($sp)                  # guardo return address
    daddi $v0, $zero, 1             # Seteo v0 en 1
    lazo:
    beqz $a1, terminar              # a1 = 0? Si = 0, salimos de la subrutina
    daddi $a1, $a1, -1              # Sino: Resto 1 a a1
    dmul $v0, $v0, $a0              # multiplico v0 por a0
    j lazo                          # salto a lazo
    terminar:
    ld $ra, 8($sp)                  # rescato return address
    ld $a1, 0($sp)                  # rescato a1 del stack
    daddi $sp, $sp, 16              # sumo 16 a SP
    jr $ra                 # vuelvo al programa
