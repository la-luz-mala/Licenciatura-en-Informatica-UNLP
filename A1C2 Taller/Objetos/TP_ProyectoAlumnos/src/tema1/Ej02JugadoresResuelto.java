/*
2- Escriba un programa que lea las alturas de los 15 jugadores de un equipo de
básquet y las almacene en un vector. Luego informe:
- la altura promedio
- la cantidad de jugadores con altura por encima del promedio
*/
package tema1;

//Paso 1: Importar la funcionalidad para lectura de datos
import PaqueteLectura.Lector;

public class Ej02JugadoresResuelto {

  
    public static void main(String[] args) {
        //Paso 2: Declarar la variable vector de double 
        double [] vectorJugadores;
        
        //Paso 3: Crear el vector para 15 double 
        vectorJugadores = new double[15];
        
        //Paso 4: Declarar indice y variables auxiliares a usar
        int i,cont = 0;
        double aux = 0;
        double promedio;
        
        //Paso 6: Ingresar 15 numeros (altura), cargarlos en el vector, ir calculando la suma de alturas
        for (i = 0; i < 15; i++) {
            System.out.println("Ingrese altura:");
            vectorJugadores[i] = Lector.leerDouble();
            aux = aux + vectorJugadores[i];
        }
        //Paso 7: Calcular el promedio de alturas, informarlo
        promedio = aux / 15;
        
        //Paso 8: Recorrer el vector calculando lo pedido (cant. alturas que están por encima del promedio)
        for (i = 0; i<15; i++) {
            if (vectorJugadores[i] > promedio) 
                cont++;
        }
        //Paso 9: Informar la cantidad.
        System.out.println("La cantidad de jugadores cuya altura es superior al promedio de "+promedio+" es de "+cont);
    }
    
}
