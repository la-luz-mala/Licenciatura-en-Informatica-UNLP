.data
    coorX:          .byte   10
    coorY:          .byte   24
    color:          .byte   255, 0, 255, 0
    DIR_CONTROL:    .word32 0x10000
    DIR_DATA:       .word32 0x10008

.code
    # Inicializo control y data
    lwu $s6, DIR_CONTROL($0)
    lwu $s7, DIR_DATA($0)

    # Cargo y envío coordenada X
    lbu $s0, coorX($0)
    sb $s0, 5($s7)

    # Cargo y envio coordenada Y
    lbu $s1, coorY($0)
    sb $s0, 4($s7)

    # Cargo y envío color
    lwu $s2, color($0)
    sw $s2, 0($s7)

    # Cargo y envío control para salida gráfica
    daddi $s3, $0, 5
    sd $s3, 0($s6)

halt