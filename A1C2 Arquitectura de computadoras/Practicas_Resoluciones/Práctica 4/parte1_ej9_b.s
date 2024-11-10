# 9. Operaciones con strings⭐⭐
# b) Contar apariciones de carácter Escribir un programa que cuente la cantidad de veces que un determinado carácter
# aparece en una cadena de texto.

.data
        cadena: .asciiz "adbdcdedfdgdhdid" # cadena a analizar
        car: .ascii "d" # carácter buscado
        cant: .word 0 # cantidad de veces que se repite el carácter car en cadena.
.code
        lbu $s0, car($0) # cargar el caracter buscado en $s0 con lbu
        daddi $s1, $0, 0 # inicializar desplazamiento en $s1 = 0
        daddi $s2, $0, 0 # inicializar contador en $s2 = 0 
LOOP:   lbu $t0, cadena($s1) # loop: traer caracter a t0 desde cadena(despl)
        daddi $s1, $s1, 1 # aumento el aux de desplazamiento en 1
        beqz $t0, FIN # el caracter es 0? SI -> saltar a FIN
        bne $t0, $s0, LOOP # NO: el caracter es el buscado? NO -> salta a loop
        daddi $s2, $s2, 1 # SI: contador +1
        j LOOP # salta a loop
FIN:    sd $s2, cant($0) # fin: cargo contador en cant
halt
