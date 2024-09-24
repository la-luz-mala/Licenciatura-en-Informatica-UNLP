;3) Subrutina para el envío del carácter y la señal de Strobe⭐⭐
;El envío de la señal de strobe se puede modularizar en una subrutina para ser reutilizado en distintas
;ocasiones. Implementar una subrutina 📄flanco_ascendente que envía el flanco ascendente (un 0 y luego
;un 1) a través del strobe. Asumir que el PIO ya está configurado correctamente para comunicarse con la
;impresora.

PA EQU 30h
CA EQU 32h

ORG 3000H
flanco_ascendente:
IN AL, PA ; Trae el valor de PA
AND AL, 0FDH ; enmascara el valor de PA con 1111 1101, convierte el bit de strobe en 0 sea lo que sea
OUT PA, AL ; envia este valor a PA
IN AL, PA ; trae de vuelta el valor de PA
OR AL, 02H ; enmascara el valor de PA con 0000 0010, convierte el bit de strobe en 1 sea lo que sea
OUT PA, AL ; envia este valor a PA
RET

ORG 2000H
CALL flanco_ascendente
INT 0
END