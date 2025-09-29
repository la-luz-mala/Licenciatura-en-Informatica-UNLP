/*
4- Un edificio de oficinas está conformado por 8 pisos (1..8) y 4 oficinas por piso
(1..4). Realice un programa que permita informar la cantidad de personas que
concurrieron a cada oficina de cada piso. Para esto, simule la llegada de personas al
edificio de la siguiente manera: a cada persona se le pide el nro. de piso y nro. de
oficina a la cual quiere concurrir. La llegada de personas finaliza al indicar un nro.
de piso 9. Al finalizar la llegada de personas, informe lo pedido. 
*/
package tema1;
// Importar paquete
// import PaqueteLectura.GeneradorAleatorio;
import PaqueteLectura.Lector;

public class Ej04Resuelto {
    public static void main(String [] args) {
        //1. Crear la matriz y declarar auxiliares
        int[][] edificio = new int[8][4];
        int p,o;
        
        //1.1 Inicializar vector en 0
        for(p = 0; p<8;p++){
            for(o=0;o<4;o++){
                edificio[p][o] = 0;
            }
        }
        //2. Leer persona
        System.out.println("Ingrese el piso:");
        p = Lector.leerInt()-1;
        //3. Sumar persona adonde corresponda
        while (p != 8) {
            System.out.println("Ingrese la oficina:");
            o = Lector.leerInt()-1;
            edificio[p][o]++;
            System.out.println("Ingrese el piso:");
            p = Lector.leerInt()-1;
        }
        
        //4. Imprimir matriz
        for(p = 0; p<8;p++){
            for(o=0;o<4;o++){
                System.out.println("Piso "+(p+1)+", oficina "+(o+1)+": "+edificio[p][o]+" ingresos.");
            }
        }
    }    
}
