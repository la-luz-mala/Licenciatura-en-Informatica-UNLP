# 3. Lectura e impresión de números enteros
# a) Suma de números ⭐Escribir un programa que lea dos números enteros y muestre su suma en la salida estándar
# del simulador (ventana Terminal) el resultado numérico.

.data
    DIR_CONTROL:    .word   0x10000
    DIR_DATA:       .word   0x10008

.code
    ld $s5, DIR_CONTROL($0) # inicializo control
    ld $s6, DIR_DATA($0) # inicializo data
    
    daddi $t0, $0, 8
    sd $t0, 0($s5) # mando comando para habilitar ingreso de #
    ld $s0, 0($s6) # cargo en s0 el num ingresado

    sd $t0, 0($s5) # mando comando para habilitar ingreso de #
    ld $s1, 0($s6) # cargo en s1 el num ingresado

    dadd $s2, $s0, $s1 # sumo los números

    sd $s2, 0($s6)
    daddi $t0, $0, 1
    sd $t0, 0($s5) # imprime número entero

halt