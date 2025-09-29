Program ParcialJ;
Const cabanas = 20;
Type
	sub_cabanas = 1..cabanas;
	sub_dias = 1..31;
	sub_meses = 1..12;
	
	reserva = record
		dni:integer;
		dia_reserva: sub_dias;
		mes_reserva: sub_meses;
		cant_dias: integer;
		cod_cabana: sub_cabanas;
	end;
	
	arbol = ^nodoArbol;
	nodoArbol = record
		datoArbol: reserva;
		dni:integer;
		HI, HD: arbol;
	end;
	
	vector = array[1..cabanas] of arbol;
	
{------------------------------}
{INCISO A}
Procedure leerReserva(var r:reserva);
begin
	{r.cant_dias := Random(32000);}
	writeln('Ingrese cantidad de dias');
	readln(r.cant_dias); {debugging}
	if (r.cant_dias <> 0) then begin
		r.dni := Random(32000);
		r.dia_reserva := Random(30)+1;
		r.mes_reserva := Random (11)+1;
		r.cant_dias := Random(30) +1;
		r.cod_cabana := Random(19)+1;
	end;
end;
	
Procedure cargarReservas(var v:vector; var a:arbol;var r:reserva;var dimL: integer);
begin
	if (r.cant_dias <> 0) then begin
		if v[r.cod_cabana] = nil then begin
			new(a);
			a^.datoArbol := r;
			a^.dni:= r.dni;
			a^.HI := nil; a^.HD:= nil;
			dimL := dimL +1;
			leerReserva(r);
		end
		else
			if (r.dni < v[r.cod_cabana]^.dni) then
				cargarReservas(v,v[r.cod_cabana]^.HI,r,dimL)
			else cargarReservas(v,v[r.cod_cabana]^.HD,r,dimL);
	end;
end;

{------------------------------}
{INCISO B}

Procedure recorrerArbol(a:arbol; var cant:integer);
begin
	if (a <> nil) then begin
		cant := cant + a^.datoArbol.cant_dias;
		recorrerArbol(a^.HI, cant);
		recorrerArbol(a^.HD, cant);
	end;
end;

Procedure evaluarReservas(v:vector; var max:integer; var cod:sub_cabanas;dimL:integer);
var cant,i:integer;
begin
	for i:=1 to dimL do
		if v[i] <> nil then begin
			cant:=0;
			recorrerArbol(v[i], cant);
			if cant > max then begin
				max := cant;
				cod := i;
			end;
		end;
	
end;


{------------------------------}
{INCISO C}

Procedure recorrerPorDni(a:arbol; dniMax,dniMin: integer; var cantRvas:integer);
begin
	if a <> nil then begin
		if dniMin > a^.datoArbol.dni then recorrerPorDni(a^.HD,dniMax,dniMin,cantRvas)
		else if dniMax < a^.datoArbol.dni then recorrerPorDni(a^.HI,dniMax,dniMin,cantRvas)
			else begin
				{min < dni < max}
				cantRvas := cantRvas + a^.datoArbol.cant_dias;
				recorrerPorDni(a^.HI,dniMax,dniMin,cantRvas);
				recorrerPorDni(a^.HD,dniMax,dniMin,cantRvas)
			end;
	end;		
end;

Procedure sumarRvasPorDni(v:vector;var dniMax:integer; var dniMin: integer; var cantRvas:integer; dimL:integer);
var i:integer;
begin
	for i:= 1 to dimL do
		if v[i] <> nil then recorrerPorDni(v[i],dniMax,dniMin,cantRvas)
end;

Var
	a:arbol;
	r:reserva;
	v:vector;
	dimL:integer;
	maxRvas:integer;
	codMax:sub_cabanas;
	cantRvas,dniMax,dniMin: integer;
Begin
	Randomize;
	new(a);
	a:=nil;
	dimL := 0;
	{Inciso a}
	leerReserva(r);
	cargarReservas(v,a,r,dimL);
	{Inciso b}
	maxRvas := -1;
	evaluarReservas(v,maxRvas,codMax,dimL);
	writeln('La cabaña con mas reservas es la ',codMax,' con ',maxRvas,' reservas.');
	{Inciso c}
	writeln('Ingrese un DNI minimo');
	readln(dniMin);
	writeln('Ingrese un DNI maximo');
	readln(dniMax);
	cantRvas := 0;
	sumarRvasPorDni(v,dniMax,dniMin,cantRvas, dimL);
	writeln('La cantidad de reservas entre el DNI ',dniMin,' y el DNI ',dniMax,' es de ',cantRvas);
End.
