Program ParcialE;
Const sucursales = 10;
Type
	sub_sucursal = 1..sucursales;
	venta = record					{venta}
		dniC: integer;
		codSuc: sub_sucursal;
		numFactura: integer;
		monto: real;
	end;

	lista = ^nodo;
	nodo = record					{lista para adentro del arbol}
		dato:venta;
		sig: lista;
	end;
	
	arbol = ^nodoArbol;
	nodoArbol = record				{arbol de listas orednado por DNI}
		datoArbol: lista;
		dni:integer;
		HI, HD: arbol;
	end;
	
	vectorSuc = array [sub_sucursal] of integer; {vector de sucursales}

{-----------------------------------}
{PUNTO A}
Procedure inicalizarVector(var v:vectorSuc);
var i:integer;
begin
	for i:= 1 to sucursales do v[i] := 0;
end;

Procedure leerVenta(var v:venta);	{genera una venta random}
begin
	Randomize;
	v.dniC := Random(2000);
	if (v.dniC<>0) then begin
		v.codSuc:= random(10) +1;
		v.numFactura := random(10000) + 1;
		v.monto := random (2000) / (Random(10) + 1);
	end;
end;

procedure crearLista(var l:lista; v:venta);	{inicializa y crea una lista nueva}
begin
	new(l);
	l^.dato := v;
	l^.sig := nil;
end;

procedure agregarAdelante(var l: lista; v: venta); {agrega adelante de la lista}
var nuevo: lista;
begin
  new(nuevo);
  nuevo^.dato := v;
  nuevo^.sig := l;
  l := nuevo;
end;


procedure agregar(var a:arbol; v:venta);	{agrega venta al arbol}
var l:lista;
begin
	if (a = nil) then begin {si es la primera compra}
		crearLista(l,v);
		new(a);
		a^.datoArbol := l;
		a^.dni := v.dniC;
		a^.HI := nil;
		a^.HD := nil;
		end
	else
		if(v.dniC = a^.dni) then			{si el DNI ya existe}
			agregarAdelante(a^.datoArbol, v)
		else 
			if (v.dniC < a^.dni) then agregar(a^.HI, v) {recorrer hacia la izq}
			else agregar(a^.HD, v);						{recorrer hacia la der}
end;

procedure cargarVentas(var a:arbol; var vec:vectorSuc);
var 
	v:venta;
begin
	inicalizarVector(vec); {inicializo el vector en 0}
	leerVenta(v);
	while (v.dniC <> 0) do begin
		agregar(a,v);
		vec[v.codSuc] := vec[v.codSuc] +1; {cuento las ventas por sucursal}
	end;
end;

{PUNTO B}

Procedure revisarFacturas(l:lista; monto:real; var fc:integer);
begin
	fc := 0;
	while l <> nil do begin
		if (l^.dato.monto > monto) then begin
			fc := fc + 1;
			l := l^.sig;
		end
		else
			l := l^.sig;		
	end;	
end;

Procedure buscarFacPorDNI(a:arbol;monto:real;dni:integer;var fc:integer);
begin
	if (a^.dni = dni) then revisarFacturas(a^.datoArbol, monto, fc)
	else
		if (dni < a^.dni) then buscarFacPorDNI(a^.HI,monto,dni,fc)
		else buscarFacPorDNI(a^.HD,monto,dni,fc);
	writeln('La cantidad de facturas de monto superior al ingresado es de ',fc);
end;

{PUNTO C}
Procedure sucMasVentas(vec:vectorSuc;var max:integer;var aux:integer);
begin
	if (vec[aux] > max) then max := vec[aux];
	aux := aux + 1;
	if (aux < sucursales) then sucMasVentas(vec,max,aux)
	else writeln('La sucursal con más ventas es  de código',max);	
end;

{-----------------------------------}
{PROGRAMA PRINCIPAL}
Var
	a:arbol;
	vec:vectorSuc;
	monto:real;
	aux,max,fc,dni:integer;
Begin
	aux:=1;
	max:=0;
	cargarVentas(a,vec);
	{Módulo de búsqueda}
	writeln('Ingrese DNI a buscar');
	readln(dni);
	writeln('Ingrese monto');
	readln(monto);
	buscarFacPorDNI(a,monto,dni,fc);
	sucMasVentas(vec,max,aux);
End.
