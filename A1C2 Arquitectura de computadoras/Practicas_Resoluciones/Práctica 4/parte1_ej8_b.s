# b) Lectura de caracteres: lbu vs. lb vs. ld: En un string, cada código ASCII ocupa 1 byte. No obstante, los registros del
# simulador tienen 8 bytes (64 bits) de capacidad. Por ende, al cargar un byte en un registro, se desperdician 7 bytes de
# espacio; esta ineficiencia es inevitable. Más allá de eso, esta diferencia nos trae otra dificultad. Cuando se carga un
# valor de memoria, no se puede utilizar ld, porque ello traería 8 caracteres (8 bytes) al registro, y sería muy difícil
# hacer operaciones sobre los caracteres individuales. Por ello, existen instrucciones para traer solo un byte desde la
# memoria: lbu y lb. ¿Cuál es la diferencia?
# - lbu asume que el valor que se trae está codificado en BSS y entonces rellena los últimos 7 bytes con 0.
# - lb asume que el valor que se trae de memoria está codificado en CA2, y entonces si el número es negativo realiza la
# expansión de signo. ¿De qué trata esto? Para que el número siga valiendo lo mismo en CA2 de 8 bytes, se rellenan los
# últimos 7 bytes con 1.
# Para probar la diferencia entre estas 3 instrucciones, ejecutar el siguiente programa en el simulador que intenta
# cargar el primer valor del vector de números datos y observar los valores finales de $t1, $t2 y $t3.
.data
    datos: .byte -2, 2, 2, 2, 2, 2
.code
    ld $t1, datos($zero)
    lb $t2, datos($zero)
    lbu $t3, datos($zero)
halt
# Responde:
# ¿Qué registro tiene el valor “correcto” del primer valor? >>> $t2, porque lo trajimos con lb que considera el signo
# ¿Qué instrucción deberías utilizar de las 3 para cargar un código ASCII que siempre es positivo? Tené en cuenta que,
# por ejemplo, el código ASCII de la Á es 181, que en BSS se escribe como 10110101.
# lbu, para tomar el byte sin sigo