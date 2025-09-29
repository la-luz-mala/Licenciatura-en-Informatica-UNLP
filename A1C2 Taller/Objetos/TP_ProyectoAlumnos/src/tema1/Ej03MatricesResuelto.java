/*
3- Escriba un programa que defina una matriz de enteros de tamaño 5x5. Inicialice
la matriz con números aleatorios entre 0 y 30.
Luego realice las siguientes operaciones:
- Mostrar el contenido de la matriz en consola.
- Calcular e informar la suma de los elementos de la fila 1
- Generar un vector de 5 posiciones donde cada posición j contiene la suma
de los elementos de la columna j de la matriz. Luego, imprima el vector.
- Leer un valor entero e indicar si se encuentra o no en la matriz. En caso de
encontrarse indique su ubicación (fila y columna) en caso contrario
imprima “No se encontró el elemento”.
 */
package tema1;

//Paso 1. importar la funcionalidad para generar datos aleatorios
import PaqueteLectura.GeneradorAleatorio;
import PaqueteLectura.Lector;

public class Ej03MatricesResuelto {

    public static void main(String[] args) {
        //Paso 2. iniciar el generador aleatorio     
        GeneradorAleatorio.iniciar();
	 
        //Paso 3. definir la matriz de enteros de 5x5 e iniciarla con nros. aleatorios 
        int[][] m = new int[5][5];
        int i,j,aux = 0;
        
        for (i = 0; i < 5; i++) {
            for (j = 0; j < 5; j++) {
                m[i][j] = GeneradorAleatorio.generarInt(30);
            }
        }
        
        //Paso 4. mostrar el contenido de la matriz en consola
        for (i = 0; i < 5; i++) {
            for (j = 0; j < 5; j++) {
                System.out.print(" | " + m[i][j] + " | ");
            }
            System.out.println("");
        }
        System.out.println("--------------------");
        //Paso 5. calcular e informar la suma de los elementos de la fila 1
        for(j = 0; j < 5; j++) {
            aux += m[0][j];
        }
        System.out.println("La suma de los elementos de la primera fila es de "+aux);
        System.out.println("--------------------");
        
        //Paso 6. generar un vector de 5 posiciones donde cada posición j contiene la suma de los elementos de la columna j de la matriz. 
        //        Luego, imprima el vector.
        int[] v = new int[5];
        for (j=0; j<5; j++) {
            for (i = 0; i < 5; i++){
                v[j] += m[i][j];
            }
            System.out.println("Total columna "+(j+1)+": "+v[j]);
        }
        System.out.println("--------------------");

        //Paso 7. lea un valor entero e indique si se encuentra o no en la matriz. En caso de encontrarse indique su ubicación (fila y columna)
        //   y en caso contrario imprima "No se encontró el elemento".
        System.out.println("Ingrese un valor para buscar:");
        int num = Lector.leerInt();
        boolean ok = false;
        
        for (j=0; j<5; j++) {
            for (i = 0; i < 5; i++){
                if (m[i][j] == num) {
                    System.out.println("El valor se encontró en la fila "+(i+1)+", columna "+(j+1)+".");
                    ok = true;
                }
            }
        }
        if (ok == false) System.out.println("No se encontró el elemento");
    }
}
