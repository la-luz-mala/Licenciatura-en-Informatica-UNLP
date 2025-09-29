{
* Datos: ATENCIONES - matricula, dni, dia, diagnostico (1-10)
* a) abb de listas
* b) recorrer y contar
* c) vector de integers
* }

Program parcialM;
Const diagnosticos = 10;
Type
	cantDiag = 1..diagnosticos;
	atencion = record
		matricula:integer;
		dni:integer;
		dia:integer;
		diagnostico:cantDiag;
	end;
	
	lista=^nodo;
	nodo = record
		dato:atencion;
		sig:lista;
	end;
	
	arbol=^nodoArbol;
	nodoArbol = record
		datoArbol:lista;
		matrArbol:integer;
		HI,HD:arbol;
	end;
	
	vectorDiag = array[1..diagnosticos] of integer;

{-----------------------------------------------}
{INCISO A}

Procedure leerAtencion(var x:atencion);
begin
	readln(x.dni);
	if (x.dni <> 0) then begin
		x.matricula := Random(2000)+1;
		x.dia:= Random(31)+1;
		x.diagnostico:= Random(diagnosticos)+1;
	end;
end;

Procedure cargarArbol(var a:arbol;x:atencion);
var l:lista;
begin
	l:=nil;
	if (a = nil) then begin
		new(a);
		a^.matrArbol := x.matricula;
		a^.HI := nil; a^.HD:= nil;
		new(l);
		l^.dato := x;
		l^.sig := nil;
		a^.datoArbol := l;
	end
	else
		if (a^.matrArbol = x.matricula) then begin
			new(l);
			l^.dato := x;
			l^.sig := a^.datoArbol;
			a^.datoArbol := l;
		end
		else
			if (x.matricula < a^.matrArbol) then cargarArbol(a^.HI, x)
			else cargarArbol(a^.HD,x);
end;

Procedure leerAtenciones(var a:arbol);
var x:atencion;
begin
	leerAtencion(x);
	while (x.dni <> 0) do begin
		cargarArbol(a,x);
		leerAtencion(x);
	end;
end;

{-----------------------------------------------}
{INCISO B}

Procedure buscarAtenciones(a:arbol;matr1:integer;matr2:integer;dniBusq:integer;var cont:integer);
var l:lista;
begin
	if(a <> nil) then
		if (a^.matrArbol <= matr1) then buscarAtenciones(a^.HD,matr1,matr2,dniBusq,cont)
		else if(a^.matrArbol >= matr2) then
			buscarAtenciones(a^.HI,matr1,matr2,dniBusq,cont)
			else begin
				l := a^.datoArbol;
				while l <> nil do begin
					if (l^.dato.dni = dniBusq) then cont := cont+1;
					l:=l^.sig;
				end;
			buscarAtenciones(a^.HI,matr1,matr2,dniBusq,cont);
			buscarAtenciones(a^.HD,matr1,matr2,dniBusq,cont)
		end;
end;

{-----------------------------------------------}
{INCISO C}
Procedure inicializarV(var v:vectorDiag);
var i:integer;
begin
	for i:= 1 to diagnosticos do
		v[i] := 0;
end;
	
	
Procedure contarDiag(a:arbol; var v:vectorDiag);
var p:lista;
begin
	if (a <> nil) then begin
		p:= a^.datoArbol;
		while p <> nil do begin
			v[p^.dato.diagnostico] := v[p^.dato.diagnostico] +1;
			p:= p^.sig;
		end;
		contarDiag(a^.HI, v);
		contarDiag(a^.HD, v);
	end;
end;


Var
	a:arbol;
	cont,matr1,matr2,dniBusq:integer;
	v:vectorDiag;
Begin
	Randomize;
	a:=nil;
	cont:=0;
	
	{Inciso a}
	leerAtenciones(a);
	{Inciso b}
	writeln('Ingrese la matricula mas chica a buscar');
	readln(matr1);
	writeln('Ingrese la matricula mas grande a buscar');
	readln(matr2);
	writeln('Ingrese el DNI a buscar');
	readln(dniBusq);
	buscarAtenciones(a,matr1,matr2,dniBusq,cont);
	{Inciso c}
	inicializarV(v);
	contarDiag(a,v);
End.
