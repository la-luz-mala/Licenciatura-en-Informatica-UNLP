# 5. Pantalla Gráfica: Cuadrados
# b) Pantalla verde⭐⭐Modifique el programa anterior para pintar toda la pantalla de verde

.data
    X: .byte 0  # modificado para esquina inferior izquierda
    Y: .byte 0  # modificado para esquina inferior izquierda
    color: .byte 0, 255, 0, 0 # cambiado a Verde
    CONTROL: .word32 0x10000
    DATA: .word32 0x10008
.code
    lwu $s0, CONTROL($zero)
    lwu $s1, DATA($zero)
    lwu $t0, color($zero)
    sw $t0, 0($s1)
    lbu $t1,Y($zero) 
    lbu $t2,X($zero)
    daddi $t4,$zero,50
    daddi $t5,$zero,50 # cambiado para pintar toda la pantalla
    loop: sb $t1,4($s1)
    sb $t2, 5($s1) 
    daddi $t3, $zero, 5
    sd $t3,0($s0)
    daddi $t2, $t2, 1
    bne $t4,$t2,loop
    daddi $t2, $0, 0 # cambiado para que arranque desde el primer px
    daddi $t1,$t1,1
    bne $t5, $t1, loop
halt