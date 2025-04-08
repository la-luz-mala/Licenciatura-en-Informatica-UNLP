# 3. Uso de la pila⭐
# En WinMIPS no existen las instrucciones PUSH y POP. Por ese motivo, deben implementarse utilizando
# otras instrucciones existentes. No solo eso, sino que el registro SP es en realidad un registro usual, r29,
# que con la convención se puede llamar por otro nombre, $sp. El siguiente programa debería intercambiar
# los valores de $t0 y $t1 utilizando la pila. No obstante, así como está no va a funcionar porque push y pop
# no son instrucciones válidas. Implementar la funcionalidad que tendrían estas operaciones utilizando
# instrucciones daddi, sd y ld para que el programa funcione correctamente. Recordar que los registros
# ocupan 8 bytes, y por ende el push y el pop deberán modificar a $sp con ese valor.

# v0: devuelve 1 si a0 es par y 0 dlc
# a0: número entero cualquiera
.code
    daddi $sp, $0, 0x400 # Se inicializa el SP
    daddi $t0, $0, 5
    daddi $t1, $0, 8
    daddi $sp, $sp -16 # reduzco el SP por 16
    sd $t0, 0($sp) # push $t0
    sd $t1, 8($sp) # push $t1
    
    ld $t0, 0($sp) # pop $t0
    ld $t1, 8($sp) # pop $t1
    daddi $sp, $sp, 16 # sumo 16 y vuelvo el SP a 0x400
halt