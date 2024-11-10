# 9. Operaciones con strings⭐⭐
# a) Longitud de un string Escribir un programa que cuente la longitud de un string iterando el mismo hasta llegar al
# valor 0 y guarde el resultado en una variable llamada LONGITUD. Probarlo con el string “ArquiTectuRa de
# ComPutaDoras”.

.data
    string: .asciiz "ArquiTectuRa de ComPutaDoras"
    long: .word 0
.code
        dadd $t0, $zero, $zero    # Inicializar auxiliar de desplazamiento en t0 = 0
        dadd $t1, $zero, $zero    # Inicializar longitud en t1 = 0
LAZO:   lbu $t2, string($t0)          # LAZO: Traer la letra de string(t0)
        beqz $t2, FIN             # letra = 0? SI -> saltar a FIN
        daddi $t1, $t1, 1         # Sino, sumar +1 al contador de longitud
        daddi $t0, $t0, 1         # sumar +1 al aux de desplazamiento - Por qué 1? cada caracter ASCII ocupa 1 byte y me muevo de a bytes
        j LAZO                    # saltar a LAZO
FIN:    sd $t1, long($zero)    # FIN: cargar longitud t1 en long
halt
