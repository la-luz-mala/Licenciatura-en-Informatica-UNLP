    .data
CONTROL:    .word 0x10000
DATA:       .word 0x10008

AZUL:       .byte 0, 0, 255, 0
DATOS:      .word 35, 20, 70, 20, 1, 1, -10, 5, 20, 30, -3, 10, 12, 20
    
    .code
ld $s0, CONTROL($0) # inicializar CONTROL
ld $s1, DATA($0) # inicializar DATA
daddi $sp, $zero, 0x400 # inicializar SP
ld $s2, AZUL($0) # cargar azul
sd $s2, 0($s1) # Cargo el color en DATA

daddi $a0, $zero, 7 # cantidad de pares
daddi $a1, $0, DATOS # mando la dirección de datos a a1

jal GRAFICAR

halt

GRAFICAR:
daddi $sp, $sp, -24
sd $a0, 0($sp)
sd $a1, 8($sp)
sd $ra, 16($ra)

daddi $t0, $a0, 0 # contador de pares (7)
daddi $t1, $a1, 0 # dirección de datos

lazo: 
beqz $t0, fin
sd $a0, 0($t1) # cargo el primer # del par en a0
daddi $t1, $t1, 8 # cambio de posición en la tabla
sd $a1, 0($t1) # cargo en 2do en a1
daddi $t1, $t1, 8 # cambio de posición en la tabla
daddi $t0, $t0, -1 # +1 contador de pares
jal EN_RANGO
beqz $v0, lazo # si v0 devuelve 0 quiere decir que no está en rango

sd $a0, 4($s1) # si está en rango, mando $a0 a X
sd $a1, 5($s1) # mando a1 a Y

daddi $t2, $0, 5 # cargo el 5 en t2 para imprimir a pantalla grafica
sd $t2, 0($s0) # mando a imprimir
j lazo

ld $ra, 16($ra)
ld $a1, 8($sp)
ld $a0, 0($sp)
daddi $sp, $sp, 24
# cargar datos en X
# cargar datos en Y

fin: jr $ra

EN_RANGO:
daddi $sp, $sp, -24
sd $a0, 0($sp)
sd $a1, 8($sp)
sd $ra, 16($ra)

slti $v0, $a0, 0 # chequeo si a0 es < 0
bnez $v0, no_entra
slti $v0, $a0, 50 # chequeo si 49 < a0
beqz $v0, no_entra
slti $v0, $a1, 0 # chequeo si a1 es < 0
bnez $v0, no_entra
slti $v0, $a1, 50 # chequeo si 49 < a1
beqz $v0, no_entra

j volver
no_entra: daddi $v0, $0, 0
volver: 
ld $ra, 16($ra)
ld $a1, 8($sp)
ld $a0, 0($sp)
daddi $sp, $sp, 24

jr $ra