/*
5- El dueño de un restaurante entrevista a cinco clientes y les pide que califiquen
(con puntaje de 1 a 10) los siguientes aspectos: (0) Atención al cliente (1) Calidad
de la comida (2) Precio (3) Ambiente.
Escriba un programa que lea desde teclado las calificaciones de los cinco clientes
para cada uno de los aspectos y almacene la información en una estructura. Luego
imprima la calificación promedio obtenida por cada aspecto.
 */
package tema1;
// import PaqueteLectura.GeneradorAleatorio;
import PaqueteLectura.Lector;

public class Ej05Resuelto {
    public static void main(String[] args) {
        int[][] v = new int[5][4]; // Crear el vector
        int c,p,aux;
        double auxdbl;
        for (c=0;c<5;c++){
            for (p=0; p<4;p++) {
            System.out.println("Por favor ingrese calificación:");
            aux = Lector.leerInt();
            while (aux > 10) {System.out.println("Ingrese una calificación del 1 al 10");aux = Lector.leerInt();}
            v[c][p] = aux;
            }
        }
        
        for (c=0;c<5;c++){
            for(p=0;p<4;p++){
                System.out.print("| " + v[c][p] + " | ");
            }
            System.out.println("");
        }
        
        for (p=0;p<4;p++) {
            auxdbl = 0;
            for (c=0;c<5;c++) {
                auxdbl += v[c][p];
            }
            System.out.println("El promedio de la pregunta "+p+" es de "+((double)auxdbl/4));
        }
    }
}
