# Parcial 2 fecha 1, 2023
# Tema 1

# 1. Analizar el siguiente programa (se ejecuta con forwarding, BTB y delay slot DESACTIVADOS)

    .data
tabla: .word    10, 18, 22, 45, 63
    .code
daddi $t1, $zero, 5 # Puebla t1 con 5
daddi $t2, $zero, 0 # Puebla t2 con 0
daddi $t3, $zero, 0 # Puebla t3 con 0
loop:
sd $t2, tabla($t3) # Reemplaza el primer valor de Tabla con 0 en la primera vuelta
daddi $t1, $t1, -1 # Resta 1 a T1 (el contador q arranca en 5)
daddi $t2, $t2, 3 # suma 3 a t2 - O sea, le suma 3 al elemento de tabla  - 2da vuelta reemplaza por 3, después por 6, después por 9
bnez $t1, loop # Si t1 no es 0, loopea
halt

# a) Qué hace el programa anterior?
# Guarda en la primera posición de tabla los valores 0, 3, 6, 9, 12, siempre sobreescribiendo el anterior.
# b) Cuántas veces se ejecutará la instrucción escrita a continuación de bnez $t1, loop con delay slot DESHABILITADO?
# Una sola - el HALT solo se ejecutará al llegar a 0 el contador y salir del loop.
# c) Cuántas veces se ejecutará la instrucción escrita a continuación de bnez $t1, loop con delay slot HABILITADO?
# Una sola porque es un HALT y detiene el programa.
# d) Cómo modificaría el código para ejecutar correctamente el programa con la opción delay slot habilitada?
# Movería el daddi $t2, $t2, 3 abajo del loop: es una instrucción inofensiva y de la que no depende el bnez, entonces quedaría igual que el programa actual: se ejecutaría la suma, luego el salto.

# 2) La instrucción bnez $t2, loop se ejecuta con la opción delay slot deshabilitada.
# En qué etapa del pipeline se determina si hay que tomar el salto o no?
# En la etapa ID se calcula el salto y se decide si se toma o no.

# 3) El siguiente programa pinta un cuadro de color azul de 5x5 pixeles en el extremo superior izquierdo de la pantalla gráfica.
# Completar instrucciones faltantes.
    .data
X:          .byte   0
Y:          .byte   45
color:      .byte   0, 0, 255, 0
CONTROL:    .word32 0x10000
DATA:       .word32 0x10008
    .code
lwu $s0, CONTROL($0) # Inicializo CONTROL
lwu $s1, DATA($0) # Inicializo DATA
lwu $t0, color($0) # Cargo COLOR en t0
sw $t0, 0($s1) # Mando el color entero a DATA
lbu $t1, Y($0) # Cargoe l eje Y en t1
lbu $t2, X($0) # Faltante: Cargo la coordenada de X en T2
daddi $t4, $0, 5 # Inicializo maximo de eje X
daddi $t5, $0, 50 # Inicializo máximo de eje Y
loop:
sb $t1, 4($s1) # Mando la posición del eje Y a DATA
sb $t2, 5($s1) # Mando la posición del eje X a DATA
daddi $t3, $0, 5 # Inicializo t3 con la directiva de imprimir en pantalla gráfica
sb $t3, 0($s0) # Faltante: le mando a CONTROL la directiva de imprimir en pantalla gráfica
daddi $t2, $t2, 1 # +1 contador
bne $t4, $t2, loop # Comparo coordenada de X con contador
lbu $t2, X($0) # Vuelvo X a coord inicial
daddi $t1, $t1, 1 # Faltante: +1 coord Y
bne $t5, $t1, loop # Si t1 != del máximo en eje Y, volvemos a loopear
halt

# 4) Los atascos "estructurales" se generan
# a. Por la ejecución de una instrucción condicional.
# b. Porque dos o más instrucciones intentan acceder a la misma etapa del pipeline. # OPCIÓN CORRECTA
# c. Porque hay una dependencia de datos.
# d. Por la ejecución con delay slot habilitado.

# 5. Codificar una subrutina PROCESAR_CADENA que reciba como parámetro las direcciones de dos cadenas de caracteres ("cadena" y "mayu") y convierta cada letra minúscula de "cadena" en mayúscula. Además, debe incorporar cada letra cambiada a la cadena "mayu".
# Ejemplo: si cadena = "Cadena<-enTRADa>!!!" el resultado de PROCESAR_CADENA debe ser:
# - cadena = "CADENA<-ENTRADA->!!!"
# - mayu = "ADENAENA" (solo contiene las letras que se tuvieron que convertir)
# A su vez, para implementar PROCESAR_CADENA se deben generar e invocar a las siguientes subrutinas:
# ES_MINU que recibe como parámetro un caracter y retorna 1 si es una letra minúscula y 0 en caso contrario.
# OBTENER_MAYU que recibe un carácter en minúscula y devuelve la mayúscula correspondiente.
# Recordar: rango ASCII minúsculas: entre 61h y 7Ah (97 a 122 en decimal), rango ASCII mayúsculas: entre 41h y 5Ah (65 a 90 en decimal)