.data
    dir_control: .word 0x10000 # declaro la dirección de control
    dir_data:    .word 0x10008 # declaro la dirección de data
    num:         .word 5
.code
    ld $t2, dir_control($0) # cargo la dirección de control en un registro
    ld $t3, dir_data($0) # cargo la dirección de data en un registro
    ld $t1, num($0) # cargo el número a imprimir

    sd $t1, 0($t3) # envío el número a imprimir a Data
    daddi $t1, $0, 1 # cargo el num 1 en un registro
    sd $t1, 0($t2) # envío el código 1 a control
halt