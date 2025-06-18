Program uno;
Type
    nodo:= ^item;
    item = record
        dato:integer;
        sig:lista;
    end;
var
    lista:nodo;
    num:integer;

Procedure crear(var li:nodo, var ult:nodo)
begin
    li:=nil;
    ult:=nil;
end;

Procedure agregarAdelante(var li:nodo; num:integer)
var
    nuevo:nodo;
begin
    new(nuevo);
    writeln('Ingrese legajo del alumno');
    readln(nuevo^.dato);
    nuevo^.sig:=nil;
    if (li = nil) then li:=nuevo;
    else begin
        nuevo^.sig:= li;
        li:=nuevo;
    end;
end;

Begin
    crear(lista);
End.

///////////////////////////////

Program dos;
Type
    listaE= ^datosEnteros;
    datosEnteros = record
        elem:integer;
        sig:listaE;
    end;
Var
    pri: listaE;
    num: integer;
Begin
    crear(pri);
    cargar(pri); // Se dispone
    readln(num);
    if (buscar(pri,num)) then write ('El elemento existe');
End.

// descomponer - pasar CODIGO por valor
function descomponer(codigo:int):boolean;
var
    aux:integer;
    ok:boolean;
    pares:integer;
begin
pares:=0;
while (codigo <> 0) do
    begin
        aux := codigo mod 10 // por ej 1233
        if (aux mod 2 = 0) then
            pares + 1;
        codigo := codigo div 10 // 1233 se convierte en 123
    end;
if (pares >= 3) then ok:= true;
else ok := false;
descomponer:= ok;
end

///////////////////////////

Program uno;
Type
    vuelo = record
        num:integer;
        empresa:string;
        origen:string;
        destino:string;
    end;
    lista = ^nodo;
    nodo = record
        dato: vuelo;
        sig: lista;
    end;
    
// Procesos
Procedure cargarvuelo(var v:vuelo);
begin
    writeln('Ingrese el número de vuelo');
    readln(v.num);
    writeln('Ingrese la empresa aérea');
    readln(v.empresa);
    writeln('Ingrese el orígen');
    readln(v.origen);
    writeln('Ingrese el destino');
    readln(v.destino);
end;

Procedure agregaradelante(var l:lista; v:vuelo);
var
    aux:lista;
begin
    l:=nil;
    new(aux);
    aux^.dato:= v;
    aux^.sig:= l;
    l:= aux;
end;
// Variables
Var
    v:vuelo;
    l:lista;

// Cuerpo del programa
Begin
    repeat
        cargarvuelo(v);
        agregaradelante(l,v);
    until l^.dato.num = 1133;
End.