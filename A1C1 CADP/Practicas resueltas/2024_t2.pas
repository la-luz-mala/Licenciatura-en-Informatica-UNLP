// Tema 2 - 2024 - 1º fecha
// Un fabricante de dispositivos electrónicos desea procesar información de los repuestos que compró. De cada repuesto conoce su código, precio, código de marca (entre 1 y 130) y nombre del país del que proviene. El fabricante dispone de una estructura de datos con la información de los repuestos, ordenados por nombre de país.
// Realizar un programa que:
// a. Lea el código y el nombre de las 130 marcas con las que trabaja, y las almacene en una estructura de datos. La información se ingresa sin ningún orden en particular.
// b. Una vez completada la carga, procese la información de los repuestos e informe:
// 1. La cantidad de países a los que se le compró más de 100 repuestos.
// 2. Para cada marca, nombre de la marca y el precio del producto más barato.
// 3. La cantidad de repuestos que no poseen ningún cero en su código.
// Implemente el programa principal que invoque a los módulos de los incisos a y b, e imprima los resultados.

Program parcial;
Const
    marcas= 130;
Type
    subrangomarcas=1..marcas;
    objmarcas = record
        nombre:integer;
        preciomin:real;
    end;
    vmarcas=array[subrangomarcas] of objmarcas;
    repuesto = record
        codigo:integer;
        precio:real;
        codigoMarca:vmarcas;
        pais:string;
    end;

    listarepuestos = ^nodo;
    nodo = record
        dato:repuesto;
        sig:listarepuestos;
    end;
    vprecios = array[subrangomarcas] of real;
Var
    LR:listarepuestos;
    VM:vmarcas;
    VP:vectorPrecios;

Procedure cargarlista(var LR:listarepuestos); // SE DISPONE
begin
end;

Procedure cargarVectorMarcas(var v:vmarcas);
begin
    for i:=1 to marcas do
        
        
end;

begin
    LR:=nil;
    cargarlista(LR); // Se dispone
    cargarVectorMarcas(VM);
    inicializarvectorprecios(VP);
    procesarLista(LR,VM,VP);//
end.