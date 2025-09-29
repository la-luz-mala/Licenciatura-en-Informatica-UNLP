/*
1- Analice el programa Ej01Tabla2.java, que carga un vector que representa la
tabla del 2.
Genere enteros aleatorios hasta obtener el número 11. Para cada número muestre
el resultado de multiplicarlo por 2 (accediendo al vector)
*/

package tema1;

import PaqueteLectura.GeneradorAleatorio;

public class Ej01Tabla2Resuelto {

    /**
     * Carga un vector que representa la tabla del 2
     * @param args
     */
    public static void main(String[] args) {
        int DF=11;  
        int [] tabla2 = new int[DF]; // indices de 0 a 10
        int i;
        for (i=0;i<DF;i++) 
            tabla2[i]=2*i;
        System.out.println("2x" + "5" + "="+ tabla2[5]);
        
        GeneradorAleatorio.iniciar(); // Inicio el generador aleatorio
        int aux = 1 + GeneradorAleatorio.generarInt(11); // Inicio una auxiliar y asigno valor random
        while (aux != 11) { // Valor de corte
            System.out.println(tabla2[aux]); // Imprimo su correspondiente en la tabla
            aux = 1 + GeneradorAleatorio.generarInt(11); // Genero un nuevo valor random
        }
    }
    
}
