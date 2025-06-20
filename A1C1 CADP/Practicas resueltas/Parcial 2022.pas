// Una panadería artesanal de La Plata vende productos de elaboración propia. La panadería agrupa a sus productos en 26 categorías (por ej. 1. Pan, 2. Medialunas, 3. Masas finas, etc).
// Para cada categoría se conoce su nombre y el precio por kilo del producto.
// La panadería DISPONE de información de todas las compras realizadas en el último año. De cada compra se conoce el DNI del cliente, la categoría del producto (entre 1 y 26) y la cantidad de kilos comprados. La información se encuentra ordenada por DNI del cliente.
// a) Realizar un módulo que retorne la información de las categorías en una estructura de datos adecuada. La información se lee por teclado sin ningún orden. De cada categoría se lee el nombre, el código (1 a 26) y el precio por kilo.
// b) Realizar un módulo que reciba la infrmaci´n de todas las compras, la información de las categorías y retorne:
// 1. DNI del cliente que más compras ha realizado
// 2. Monto total recaudado por cada categoría
// 3. Cantidad total de compras de clientes con DNI compuesto por, al menos, 3 dígitos pares.
// Aclaración: se pide también implementar el programa principal

program ParcialTema1;
const
    cantCategorias = 26; // Un solo valor para controlar la cant de categorias en todo el programa
Type
    categoria = record // Composición de cada categoría
        nombre: string;
        precio: real;
    end;
    rangoCategorias = [1..cantCategorias]; // Defino este subrango para reutilizarlo donde pueda
    vectorCategoria = array [rangoCategorias] of categoria; // Array de categorías
    compra = record // Composición de cada compra
        dni:integer;
        categoria: rangoCategorias;
        cantKilos: real;
    end;
    lista = ^nodo;
    nodo = record
        dato: compra;
        sig: lista;
    end;
    vectorMonto =  array [rangoCategorias] of real; //Para guardar el monto recaudado por categoría
var
    l:lista;
    vec:vectorCategoria;
    dnimax,cantcompras:integer;
    montos:vectorMonto;

//PROGRAMA PRINCIPAL
begin
    cargarlista(l); // Se dispone.
    cargarcategorias(vec); // Inciso (a)
    procesarcompras(l,vec,dnimax,montos,cantcompras); // Inciso (b)
end.

procedure leerCategoria(var cat: categoria; var cod:rangoCategorias);
begin
    readln(categoria.nombre);
    readln(categoria.precio);
    readln(cod); // Según la consigna se lee pero no se almacena
end;
procedure cargarcategorias(var v:vectorCategoria);
var
cod,i: rangoCategorias; // reutilizo el rango
cat:categoria;
begin
    for i:= 1 to cantCategorias do begin
        LeerCategoria(cat,cod);
        v[cod] := cat; // Asigno los datos a la categoría correspondiente dentro del vector.
end;

// PROCESO PARA INICIALIZAR EL VECTOR EN 0
procedure inicializarVector(var v:vectorMonto);
var
    i:rangoMontos;
begin
    for i:=1 to cargarcategorias do v[i] := 0
end;

function dni3pares(dni:integer):boolean;
var
    dig,cantPares:integer;
begin
    cantPares:=0;
    while(dni <> 0) and (cantPares < 3) do begin
        dig:= num MOD 10;
        if(dig MOD 2 = 0) then cantPares:=cantPares +1;
        num:= num DIV 10;
    end;
    dni3pares:= (cantPares = 3);
end;

procedure actualMax(dni, cantCompras: integer; var dnimax, cantComprasMax: integer);
begin
    if(cantcompras > cantComprasMax) then begin
        maxcompras := cantcompras;
        maxdni := dni;
end;

// INCISO B
procedure procesarcompras(l:lista; vec:vectorCategoria, var dnimax: integer; var montos:vectorMonto; cantcompras:integer);
var
    cantComprasMax,cantComprasActual,dniactual:integer;
begin
   cantcompras:=0;
   inicializarVector(montos);
   cantComprasMax:=0; // No hace falta inicializar dnimax

   while l <> nil do begin
    dniactual:= l^.dato.dni;
    cantComprasActual:=0;
    while (l<>nil) and (dniactual = l^.dato.dni) do begin
        cantComprasActual:= cantComprasActual +1;
        montos[l^.dato.categoria] := montos[l^.dato.categoria] + (l^.dato.cantKilos * vec[l^.dato.categoria].precio);
        if (dni3pares(l^.dato.dni)) then
            cantcompras := cantcompras + 1;
        l:= l^.sig;
    end;
    actualMax(dniactual,cantComprasActual,dnimax,cantComprasMax);

    dniactual:=l^dato.dni;
   end;
end;