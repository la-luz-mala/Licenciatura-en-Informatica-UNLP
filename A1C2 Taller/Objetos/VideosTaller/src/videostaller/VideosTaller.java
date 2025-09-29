package videostaller;
import PaqueteLectura .Lector;	// importa funcionalidad de lectura
/**
 *
 * @author Malu
 */
public class VideosTaller {

    /**
     * @param args the command line arguments
     */
    
    public static void main(String[] args) {
        System.out.println("Ingrese nombre");
        String nombre = Lector.leerString(); // Lee y devuelve el string ingresado antes del enter
        System.out.println("Ingrese boolean");
        boolean ok = Lector.leerBoolean();
        System.out.println("Ingrese integer");
        int numero = Lector.leerInt();
        System.out.println("Ingrese double");
        double real = Lector.leerDouble();
        System.out.println("N: "+nombre+ " B: "+ok+ " I: " +numero+ " D: "+real);
    }
}    
