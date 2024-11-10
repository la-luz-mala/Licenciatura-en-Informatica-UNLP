# 9. Operaciones con strings⭐⭐
# c) Contar mayúsculas Escribir un programa que cuente la cantidad de letras mayúsculas de un string. Probarlo con el
# string “ArquiTectuRa de ComPutaDoras”. Pista: El código ASCII de la “A” es 65, y el de la “Z” es 90.

.data
        cadena: .asciiz "ArquiTectuRa de ComPutaDoras" # cadena a analizar
        may: .word 0 # cantidad de mayúsculas
.code
        daddi $s0, $0, 0 # inicializar contador de mayúsculas
        daddi $s1, $0, 0 # inicializar auxiliar de desplazamiento
        LAZO:
        lbu $s2, cadena($s1) # cargar caracter de la cadena
        beqz $s2, FIN # si caracter = 0 jmp fin
        daddi $s1, $s1, 1 # sumar +1 a desplazamiento
        slti $s3, $s2, 91 # caracter es menor a Z+1? 
        beqz $s3, NO_ES # si no es menor, saltar a no_es
        slti $s3, $s2, 65 # caracter es menor a A? 
        bnez $s3, NO_ES # si es menor, jmp NO_ES
        daddi $s0, $s0, 1 # +1 a contador
        NO_ES:
        j LAZO # jump LAZO
        FIN:
        sd $s0, may($0) # fin: cargar cantidad de mayúsculas en may
halt
