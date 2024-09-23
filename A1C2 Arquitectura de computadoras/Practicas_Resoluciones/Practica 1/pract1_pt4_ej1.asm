;--------------------------------------------------------;
;Parte 4: Pasaje de parámetros
;1) Tipos de Pasajes de Parámetros⭐ Indicar con un tilde, para los siguientes ejemplos, si el pasaje del
;parámetro es por registro o pila, y por valor o referencia:
;--------------------------------------------------------;

;NOTA: Indicado con texto por conveniencia
;OPCIONES: A través de REGISTRO / PILA, por VALOR/REFERENCIA
;a)
mov ax,5
call subrutina
;A través de REGISTRO por VALOR

;b)
mov dx, offset A
call subrutina
;A través de REGISTRO por REFERENCIA

;c)
mov bx, 5
push bx
call subrutina
pop bx
;A través de PILA por VALOR

;d)
mov cx, offset A
push cx
call subrutina
pop cx
;A través de PILA por REFERENCIA

;e)
mov dl, 5
call subrutina
;A través de REGISTRO por VALOR

;f)
call subrutina
mov A, dx
;A través de REGISTRO por VALOR