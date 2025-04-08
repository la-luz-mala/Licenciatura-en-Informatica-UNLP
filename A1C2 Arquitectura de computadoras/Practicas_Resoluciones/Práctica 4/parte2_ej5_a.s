# 5. Pantalla Gráfica: Cuadrados
# a) Cuadrado rojo de 5x5 Completa las líneas faltantes para que el programa pinte un cuadrado rojo de
# 5x5 en la esquina superior izquierda.

.data
    X: .byte 45
    Y: .byte 45  # modificado para que sea superior IZQUIERDA
    color: .byte 255, 0, 0, 0
    CONTROL: .word32 0x10000
    DATA: .word32 0x10008
.code
    lwu $s0, CONTROL($zero)
    lwu $s1, DATA($zero)
    lwu $t0, color($zero)
    sw $t0, 0($s1)
    lbu $t1,Y($zero) # Faltante: cargo Y en T1
    lbu $t2,X($zero)
    daddi $t4,$zero,50
    daddi $t5,$zero,50 # modificado para que sea superior IZQUIERDA
    loop: sb $t1,4($s1)
    sb $t2, 5($s1) # Faltante: Mando la coord X a DATA
    daddi $t3, $zero, 5
    sd $t3,0($s0)
    daddi $t2, $t2, 1
    bne $t4,$t2,loop
    daddi $t2, $0, 45
    daddi $t1,$t1,1
    bne $t5, $t1, loop
halt