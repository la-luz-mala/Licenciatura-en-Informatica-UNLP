# 7. Operaciones con vectores ⭐⭐
# c) Fibonacci Generar un vector con los primeros 10 números de la secuencia de fibonacci
/*Ojo: Hay que re-trabajar esto ya que guarda 0, 1, 1, 1 y después todos los números correctos*/
.data
    V: .space 80 # reservo 80 lugares para el vector
    CONT: .word 10 # contador

.code
    daddi $t0, $zero, 0 # inicializo el índice en 0
    sd $zero, V($t0) # cargo el primer número
    daddi $t0, $t0, 8 # paso a la sgte posición del vector

    daddi $t1, $zero, 1 # segundo número de la secuencia
    sd $t1, V($t0) # cargo el segundo número
    daddi $t0, $t0, 8 # paso a la sgte posición del vector

    daddi $t3, $zero, 2 # inicializo t3 en 2

LAZO:
    dadd $t4, $t1, $t2  # sumo los dos términos anteriores
    sd $t4, V($t0)  # Guardo el resultado en el vector

    dadd $t1, $t2, $zero  # Muevo el valor del 2do término al 1er lugar
    dadd $t2, $t4, $zero  # Muevo el nuevo valor al 2do término

    daddi $t0, $t0, 8  # Avanzar a la siguiente posición del vector
    daddi $t3, $t3, 1  # Incrementar i

    bne $t3, CONT, loop  # Si i < cont (10), repetir el ciclo

halt