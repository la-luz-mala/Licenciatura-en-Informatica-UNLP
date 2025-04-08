# 2. Salvado de registros⭐
# Los siguientes programas tienen errores en el uso de la convención de registros. Indicar qué registros cuál es
# el error y cómo se podría arreglar el problema en cada caso.

# A)
.code
    daddi $t0, $0, 5
    daddi $t1, $0, 7
    jal subrutina
    sd $t2, variable ($0)
halt
subrutina: daddi $t4, $0, 2
    dmul $t0, $t0, $t4 # Los parámetros para la subrutina deberían pasarse vía $aX
    dmul $t1,$t1,$t4 # Los resultados de la subrutina deberían devolverse mediante $vX
    dadd $t2,$t1,$t0
    jr $ra

# B)
.code
    daddi $a0, $0, tabla # $a0 no debería usarse para otra cosa que una subrutina - acá usar $t2 por ej
    jal subrutina
    daddi $t0, $0, 10
    daddi $t1, $0, 0
loop: bnez $t0, fin # Los parámetros deberían pasarse con $aX
    ld $t2, 0($a0)
    dadd $t1, $t1, $t2
    daddi $t0, $t0, -1
    dadd $a0, $a0, 8 # No se devuelve el resultado en $vX
    j loop
fin: halt

# C)
.code
    daddi $a0, $0, 5
    daddi $a1, $0, 7
    jal subrutina 
    dmul $t2, $a0, $v0 # Opera a0 con v0 fuera de la subr
    sd $t2, variable ($0)
halt

# D)
.code
    daddi $t0, $0, 10 # dimension
    daddi $t1, $0, 0 # contador --- Para variables permanentes o que necesito conservar usar $sX, no $tX
    daddi $t2, $0, 0 # desplazamiento
    loop: bnez $t0, fin
    ld $a0, tabla ($t2) 
    jal espar
    bnez $v0, seguir 
    dadd1 $t1, $t1, 1
seguir:daddi $t2, $t2, 1
    daddi $t0, $t0, -1
    dadd $t2, $t2, 8
    j loop
    sd $t2, resultado($0)
fin: halt