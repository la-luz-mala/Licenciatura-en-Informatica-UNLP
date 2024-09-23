;--------------------------------------------------------;
;Parte 1 - Repaso Von Sim
;1. Contar letras ⭐ Escribir un programa que dado un string llamado MENSAJE, almacenado en la
;memoria de datos, cuente la cantidad de veces que la letra ‘a’ (minúscula) aparece en MENSAJE y lo
;almacene en la variable CANT. Por ejemplo, si MENSAJE contiene “Hola, Buenas Tardes”, entonces
;CANT debe valer 3.
;--------------------------------------------------------;

ORG	1000H
  MSJ DB "Holaaa"
  FINMSJ DB ?
ORG 2000H
  MOV CX, OFFSET FINMSJ - OFFSET MSJ ; me fijo cuantos numeros tengo que loopear, lo alojo en CX
  MOV DX, 0 ; inicializo el contador de "a"s en DX
  MOV BX, OFFSET MSJ ; traigo la dirección del primer caracter a BX
  LAZO: CMP BYTE PTR [BX], 61H ;comparo lo que hay en BX (la letra del msj) con 61h (a)
  JNZ SIGUIENTE ; si NO son iguales, salta a Siguiente
  INC DX ; si son iguales, suma 1 al contador DX
  SIGUIENTE: INC BX ; incrementa en 1 la posición de la comparación
  DEC CX ;resta 1 al total de letras para loopear
  JNZ LAZO ; si no se nos acabaron las letras, salto a Lazo de nuevo
  HLT
END
