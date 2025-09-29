Program parcialG;
Const generos = 15;
Type
	sub_genero = 1..generos;
	libro = record
		isbn : integer;
		codAutor : integer;
		codGenero : sub_genero;
	end;
	
	lista = ^nodo;
	nodo = record
		dato:libro;
		sig:lista;
	end;
	
	arbol = ^nodoArbol;
	nodoArbol = record
		datoArbol : lista;
		codAutorArbol: integer;
		HI : arbol;
		HD : arbol;
	end;
	
	listaB = ^nodoB;
	nodoB = record
		codAutorB:integer;
		librosGen:integer;
		sig:listaB;
	end;
{-----------------------------------}
{------INCISO A------}
Procedure leerLibro (var l:libro);
begin
	read(l.isbn);
	if(l.isbn <> 0) then begin
		l.codAutor := Random(2000) + 1;
		l.codGenero := Random(15) + 1;
	end;
end;

Procedure agregarAdelante(var l:lista; r:libro);
var
	nuevo:lista;
begin
	new(nuevo);
	nuevo^.dato := r;
	nuevo^.sig := l;
	l := nuevo;
end;

Procedure agregarArbol(var a:arbol; l:libro);
var n:lista;
begin
	if (a = nil) then begin
		new(a);
		a^.codAutorArbol := l.codAutor;
		a^.HI := nil;
		a^.HD := nil;
		new(n);
		n^.dato := l;
		n^.sig := nil;
		a^.datoArbol := n;
	end
	else
		if (a^.codAutorArbol = l.codAutor) then
			agregarAdelante(a^.datoArbol,l)
		else
			if (l.codAutor < a^.codAutorArbol) then
				agregarArbol(a^.HI,l)
			else
				agregarArbol(a^.HD,l);	
end;


Procedure cargarLibros(var a:arbol);
var
	l:libro;
begin
	leerLibro(l);
	while l.isbn <> 0 do begin
		agregarArbol(a,l);
		leerLibro(l);
	end;
end;

{-----------------------------------}
{------INCISO B------}
Procedure agregaraLista(l:lista; ba:integer; bg:sub_genero; var lb:listaB);
var aux:listaB; cant:integer;
begin
	new(aux);
	cant:=0;
	aux^.codAutorB := ba;
	while l <> nil do begin
		if (l^.dato.codGenero = bg) then cant:= cant+1;
		l:= l^.sig;
	end;
	aux^.librosGen := cant;
	aux^.sig := lb;
	lb := aux;
end;

Procedure procesarArbol(a:arbol;var lb:listaB;ba:integer;bg:sub_genero);
begin
	if (a <> nil) then begin
		if (a^.codAutorArbol >= ba) then begin
			agregaraLista(a^.datoArbol,a^.codAutorArbol, bg,lb);
			procesarArbol(a^.HI, lb, ba, bg);
			procesarArbol(a^.HD, lb, ba, bg);
		end
		else
			procesarArbol(a^.HD, lb, ba, bg);
	end;
end;

{-----------------------------------}
{------INCISO C------}
Procedure maxLibros(lb:listaB;var codMax:integer;var libMax:integer);
begin
	if (lb <> nil) then begin
		if (lb^.librosGen > libMax) then begin
			libMax:=lb^.librosGen;
			codMax:=lb^.codAutorB;
		end;
		maxLibros(lb^.sig,codMax,libMax);
	end;
end;

Var
	a:arbol;
	busqAutor:integer;
	busqGenero:sub_genero;
	lb:listaB;
	codMax:integer;
	libMax:integer;
Begin
	a:=nil;
	lb:=nil;
	libMax:=0;
	Randomize;
	cargarLibros(a);
	writeln('Ingrese codigo del autor a buscar: ');
	readln(busqAutor);
	writeln('Ingrese genero a buscar: ');
	readln(busqGenero);
	procesarArbol(a,lb,busqAutor,busqGenero);
	maxLibros(lb,codMax,libMax);
End.
