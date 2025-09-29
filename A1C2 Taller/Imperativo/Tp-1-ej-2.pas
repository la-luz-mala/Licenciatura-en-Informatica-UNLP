{2.- El administrador de un edificio de oficinas cuenta, en papel, con la información del pago de
las expensas de dichas oficinas.
Implementar un programa que invoque a módulos para cada uno de los siguientes puntos:
a. Genere un vector, sin orden, con a lo sumo las 300 oficinas que administra. De cada oficina
se ingresa el código de identificación, DNI del propietario y valor de la expensa. La lectura
finaliza cuando se ingresa el código de identificación -1, el cual no se procesa.
b. Ordene el vector, aplicando el método de inserción, por código de identificación de la
oficina.
c. Ordene el vector aplicando el método de selección, por código de identificación de la oficina.}

Program dos;
Const dimF = 300;
Type
    oficina = record
        id:integer;
        dni:integer;
        expensa:integer;
    end;
    vector = array [1..dimF] of oficina;

Procedure cargarOficinas(var v:vector; var dimL:integer);
    Procedure leerOfi(var o:oficina);
    begin
        writeln('Ingrese codigo de oficina o -1 para trminar');
        readln(o.id);
        if (o.id <> -1) then begin
            writeln('Ingrese DNI del propietario');
            readln(o.dni);
            writeln('Ingrese valor de la expensa');
            readln(o.expensa);
        end;
    end;
var o:oficina;
begin
    leerOfi(o);
    while (dimL < dimF) and (o.id <> -1) do begin
        v[dimL] := o;
        dimL := dimL +1;
        leerOfi(o);
    end;
end;

Procedure ordenarInsercion(var v:vector; dimL:integer);
var
    i,j:integer;
    actual:oficina;
begin
    for i:=2 to dimL do begin
		actual := v[i];
		j:= i-1;
		while (j > 0) and (v[j].id > actual.id) do begin
			v[j+1] := v[j];
			j := j-1;
		end;
	v[j+1] := actual;
	end;
end;

Procedure imprimirVector(v:vector;dimL:integer);
var i:integer;
begin
	writeln('-------LISTA DE OFICINAS-------');
	for i:=1 to dimL do begin
		writeln('Codigo: ',v[i].id);
		writeln('DNI: ',v[i].dni);
		writeln('Expensa: ',v[i].expensa);
		writeln();
	end;
end;

Var
dimL:integer;
v:vector;
Begin
dimL:=0;
cargarOficinas(v,dimL);
imprimirVector(v,dimL);
ordenarInsercion(v,dimL);
imprimirVector(v,dimL);
End.
