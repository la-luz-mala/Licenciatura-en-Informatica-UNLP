# e) Escriba un programa que utilice potencia. En el programa principal se solicitará el ingreso de la base y
# del exponente (ambos enteros) y se deberá utilizar la subrutina potencia para calcular el resultado
# pedido. Muestre el resultado numérico de la operación en pantalla.

.data
    msj1:   .asciiz     "Ingrese la base\n"
    msj2:   .asciiz     "Ingrese el exponente\n"
    msj3:   .asciiz     "El resultado es: "
    DATA:   .word       0x10008
    CTRL:   .word       0x10000
.code
    ld $s6, CTRL($0) # inicializo CTRL
    ld $s7, DATA($0) # inicializo DATA

    daddi $s0, $0, msj1 # cargo msj1 en $s0
    sb $s0, 0($s7) # mando $s0 a DATA
    daddi $s1, $0, 4 # cargo 4 en $s1
    sd $s1, 0($s6) # mando $s1 a CONTROL

    daddi $s1, $0, 8 # cargo 8 en $s1
    sd $s1, 0($s6) # mando $s1 a CONTROL
    ld $a0, 0($s7) # cargo lo que haya en DATA en $a0

    daddi $s0, $0, msj2 # cargo msj2 en $s0
    sb $s0, 0($s7) # mando $s0 a DATA
    daddi $s1, $0, 4 # cargo 4 en $s1
    sd $s1, 0($s6) # mando $s1 a CONTROL

    daddi $s1, $0, 8 # cargo 8 en $s1
    sd $s1, 0($s6) # mando $s1 a CONTROL
    ld $a1, 0($s7) # cargo lo que haya en DATA en $a1

    # ld $a0, base($zero)             # Cargo BASE (5) en a0
    # ld $a1, exponente($zero)        # Cargo EXPONENTE (4) en a1
    jal potencia                    # Llamo a Potencia

    daddi $s0, $0, msj3 # cargo msj3 en $s0
    sb $s0, 0($s7) # mando $s0 a DATA
    daddi $s1, $0, 4 # cargo 4 en $s1
    sd $s1, 0($s6) # mando $s1 a CONTROL
    
    sd $v0, 0($s7) # cargo v0 en DATA
    daddi $s1, $0, 1 # cargo 4 en $s1
    sd $s1, 0($s6) # mando $s1 a CONTROL
halt


    potencia:
    daddi $v0, $zero, 1    # Seteo v0 en 1
    lazo:
    beqz $a1, terminar         # a1 = 0? Si = 0, salimos de la subrutina
    daddi $a1, $a1, -1              # Sino: Resto 1 a a1
    dmul $v0, $v0, $a0              # multiplico v0 por a0
    j lazo                          # salto a lazo
    terminar:
    jr $ra                 # vuelvo al programa