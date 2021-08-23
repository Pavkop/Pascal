program Rekord;

uses Crt;

const 
	M:array[1..7] of string=('Vypis Knih','Vyhledavani','Reset databaze','Pridej knihu','Setrid Databazi',
	'Vyber databaze','Konec');
	MM:array[1..5] of string=('Naucny','Dobrodruzny','Detektivni','Detsky','Historicky');
	MMM:array[1..5] of string=('Prvni','Druha','Treti','Ctvrta','Pata');
	MMMM:array[1..3] of string=('Nazev','Autor','Zrusit');
	MMMMM:array[1..4] of string=('Odejit','Zpet','Dalsi','Odstranit knihu');
	MMMMMM:array[1..3] of string=('Odejit','Zpet','Dalsi');

		{tyhle konstanty jsem mel pojmenovat jinak}

	Pocet=20;

type
	Kniha=record 			Nazev, Autor:string;
							Druh:string;
							cena:integer;
	end;
	Knihy				=array[1..Pocet] of Kniha;

var I,J,L,PocetKnih,PPP		:byte;
	 K						:Kniha;
	 KK					  	:Knihy;
	 W						:char;
	 XX,Z,chyba,PocetDatabaze,PocetVyberu,CisloVypisMenu,CisloVyhledejMenu		:integer;
	 SSS,Nazev_databaze					:string;
	 S						:file of Kniha;

procedure Ram(FX,FY,FD:byte);
	var I,J,K	:byte;
	begin GotoXY(FX,FY); write(#201); for I:=1 to FD do write(#205); write(#187);
			GotoXY(FX,FY+1); write(#186); for I:=1 to FD do write(' '); write(#186);
			GotoXY(FX,FY+2); write(#200); for I:=1 to FD do write(#205); write(#188);

	end;

procedure RamVelky(FX,FY,FD,FZ:byte);
	var I,J,K	:byte;
	begin GotoXY(FX,FY); write(#201); for I:=1 to FD do write(#205); write(#187);
			for K := 1 to FZ do begin
				GotoXY(FX,FY+K); write(#186); for I:=1 to FD do write(' '); write(#186); 
				end;
			GotoXY(FX,FY+FZ+1); write(#200); for I:=1 to FD do write(#205); write(#188);

	end;

procedure Vloz(FX,FY,FD:byte; var FTX: string);
begin Ram(FX,FY,FD); GotoXY(FX+2, FY+1); TextColor(11); Readln(FTX);
	TextColor(15);
	end;

procedure Menu (var FI: byte);
begin J:=1;
	ClrScr;
	writeln('Cislo knihovny: ',PocetDatabaze);
	GotoXY(30, 7);
write('#   # ##### #   # #   #');
	GotoXY(30, 8);
write('## ## #     ##  # #   #');
	GotoXY(30, 9);
write('# # # ####  # # # #   #');
	GotoXY(30, 10);
write('#   # #     #  ## #   #');
	GotoXY(30, 11);
write('#   # ##### #   #  ### ');
	RamVelky(30,15,21,13);
	repeat
		repeat
			for I:=1 to 7 do
				begin if I=J then TextColor(9) else TextColor(15);
					GotoXY(35,2*I+14); write(M[I]);
				end;
		until I=7;
		repeat W:=Readkey;
			if W=#0 then W:=ReadKey;
			until W in [#27,#72,#80,#13];
			case W of
				#80: if J=7 then J:=1 else J:= J+1;
				#72: if J=1 then J:=7 else J:= J-1;
				#13: begin FI:=J; EXIT end;
				#27: HALT;
			end;
		until 1>2;
end;

procedure uvod;
	begin ClrScr;
	TextColor(15);
	GotoXY(28, 15);
write('#  # #   # # #   # #   # ');
	GotoXY(28, 16);
write('# #  ##  # # #   #  # #  ');
	GotoXY(28, 17);
write('##   # # # # #####   #   ');
	GotoXY(28, 18);
write('# #  #  ## # #   #   #   ');
	GotoXY(28, 19);
write('#  # #   # # #   #   #   ');
	GotoXY(27, 21);
write('_________________________');
	GotoXY(27, 22);
write('_________________________');
	readln;
	ClrScr;
	end;

procedure zanry(Nova:Kniha; FXX:integer);
begin
	J:=1;
	repeat
		repeat
			for I:=1 to 5 do
				begin if I=J then TextColor(11) else TextColor(9);
					GotoXY(34,2*I+16); write(MM[I]);
				end;
		until I=5;
		repeat W:=Readkey;
			if W=#0 then W:=ReadKey;
			until W in [#27,#72,#80,#13];
			case W of
				#80: if J=5 then J:=1 else J:= J+1;
				#72: if J=1 then J:=5 else J:= J-1;
				#13: begin
						FXX:=0;
						Z := J;
						FXX :=1;
				end;
				end;
		until FXX=1;
	end;

procedure VyberCisla;
begin
	J:=1;
	repeat
		repeat
			for I:=1 to 5 do
				begin if I=J then TextColor(11) else TextColor(9);
					GotoXY(34,2*I+16); write(MMM[I]);
				end;
		until I=5;
		repeat W:=Readkey;
			if W=#0 then W:=ReadKey;
			until W in [#27,#72,#80,#13];
			case W of
				#80: if J=5 then J:=1 else J:= J+1;
				#72: if J=1 then J:=5 else J:= J-1;
				#13: begin
						if J=1 then begin Z:=1; Break; end
						else if J=2 then begin Z:=2; Break; end
						else if J=3 then begin Z:=3; Break; end
						else if J=4 then begin Z:=4; Break; end
						else begin Z:=5; Break; end;
				end;
				end;
		until 1  > 2;
	end;

procedure VyberVyhledavani;
begin
	J:=1;
	repeat
		repeat
			for I:=1 to 3 do
				begin if I=J then TextColor(11) else TextColor(9);
					GotoXY(34,2*I+16); write(MMMM[I]);
				end;
		until I=3;
		repeat W:=Readkey;
			if W=#0 then W:=ReadKey;
			until W in [#27,#72,#80,#13];
			case W of
				#80: if J=3 then J:=1 else J:= J+1;
				#72: if J=1 then J:=3 else J:= J-1;
				#13: begin
						if J=1 then begin PocetVyberu:=1; Break; end
						else if J=2 then begin PocetVyberu:=2; Break; end
						else begin PocetVyberu := 0; Break; end;
						end;
				end;
		until 1 > 2;
	end;

procedure Vkladani_Knih(var Nova:Kniha);
	begin ClrScr;

		GotoXY(15, 4);
write('#   #  ###  #   #  ###  ');
		GotoXY(15, 5);
write('##  # #   # #   # #   # ');
		GotoXY(15, 6);
write('# # # #   #  # #  ##### ');
		GotoXY(15, 7);
write('#  ## #   #  # #  #   # ');
		GotoXY(15, 8);
write('#   #  ###    #   #   # ');
	GotoXY(42, 4);
write('#  # #   # # #   #  ###  ');
	GotoXY(42, 5);
write('# #  ##  # # #   # #   # ');
	GotoXY(42, 6);
write('##   # # # # ##### ##### ');
	GotoXY(42, 7);
write('# #  #  ## # #   # #   # ');
	GotoXY(42, 8);
write('#  # #   # # #   # #   # ');
	GotoXY(20, 12);
	write('Nazev knihy: '); Vloz(32,11,20,Nova.Nazev);
	GotoXY(20,15);
	write('Autor knihy: '); Vloz(32,14,20,Nova.Autor);
	GotoXY(20,18);
	TextColor(15);
	write('Zanr knihy: ');
	RamVelky(32,17,20,10);
	zanry(K,XX);
	case Z of
		1:Nova.Druh:='Naucny';
		2:Nova.Druh:='Dobrodruzny';
		3:Nova.Druh:='Detektivni';
		4:Nova.Druh:='Detsky';
		5:Nova.Druh:='Historicky';
	end;
	writeln;
	TextColor(15);
	GotoXY(20,23);
{$I-} repeat TextColor(15);GotoXY(20,30); write('Cena knihy (v Kc): ');
		Ram(39,29,13); Gotoxy(41,30); TextColor(11); readln(Nova.Cena); TextColor(15); if IOResult<>0 then begin
		GotoXY(41,33); write('Zadejte platne cislo!'); Ram(39,29,13); Gotoxy(41,30); TextColor(11); readln(Nova.Cena); TextColor(15);
		end;
		until IOResult=0;
		end;


procedure Determinace_databaze;
	begin
	if PocetDatabaze=1 then Nazev_databaze:='Datab1.aze';
	if PocetDatabaze=2 then Nazev_databaze:='Datab2.aze';
	if PocetDatabaze=3 then Nazev_databaze:='Datab3.aze';
	if PocetDatabaze=4 then Nazev_databaze:='Datab4.aze';
	if PocetDatabaze=5 then Nazev_databaze:='Datab5.aze';
end;

procedure Ukladani_Knih;
	begin
	if PPP=1 then begin
	Assign(S,Nazev_databaze);
{$I-}		Reset(S); if IOResult <>0 then Rewrite(S);
				for I:=1 to PocetKnih do begin
					write(S,KK[I]);
				end;
				Close(S);
	end;
	end;

procedure Nacteni_Databaze;
	begin
	Assign(S,Nazev_databaze);
{$I-}		Reset(S); if IOResult <>0 then Rewrite(S);
			I:=1;
			while I<=FileSize(S) do
				begin read (S, KK[I]);
				I:=I+1
				end;
			Close(S); PocetKnih:=I-1;
	end;

procedure Reset_databaze;
	begin
	Assign(S,Nazev_databaze);
{$I-}		Reset(S); if IOResult <>0 then Rewrite(S);
				Rewrite(S);
				Close(S);
				PocetKnih:=0;
	
	end;

procedure Menu_vypis;
var FH: byte;
begin
	J:=1;
	repeat
		repeat
			for I:=1 to 4 do
				begin if I=J then TextColor(11) else TextColor(9);
					GotoXY(17+7*I,32); write(MMMMM[I]);
				end;
		until I=4;
		repeat W:=Readkey;
			if W=#0 then W:=ReadKey;
			until W in [#27,#75,#77,#13];
			case W of
				#77: if J=4 then J:=1 else J:= J+1;
				#75: if J=1 then J:=4 else J:= J-1;
				#13: begin
						CisloVypisMenu := J;
						FH := 1;
					end;
				end;
		until FH=1;
	end;

procedure Menu_vyhledej;
var FH: byte;
begin
	J:=1;
	repeat
		repeat
			for I:=1 to 3 do
				begin if I=J then TextColor(11) else TextColor(9);
					GotoXY(24+7*I,31); write(MMMMM[I]);
				end;
		until I=3;
		repeat W:=Readkey;
			if W=#0 then W:=ReadKey;
			until W in [#27,#75,#77,#13];
			case W of
				#77: if J=3 then J:=1 else J:= J+1;
				#75: if J=1 then J:=3 else J:= J-1;
				#13: begin
						CisloVyhledejMenu := J;
						FH := 1;
					end;
				end;
		until FH=1;
	end;


procedure Odstranit(FCislo:byte);
	var I,J,PocetKnih2	:byte;
	KK2			:Knihy;

	begin

	for I:=1 to FCislo-1 do
		KK2[I] := KK[I];

	for I:=FCislo to PocetKnih-1 do
		KK2[I] := KK[I+1];

	PocetKnih2 := PocetKnih - 1;

	Reset_Databaze;

	PocetKnih := PocetKnih2;

	for I := 1 to PocetKnih do 
		KK[I] := KK2[I];

	end;
	
procedure Vypis;
	var I,J,IH,IIH :byte;
	begin
	ClrScr;
	if PocetKnih>0 then begin
	I:=1;

	repeat;

	TextColor(15);

	GotoXY(37, 16);
		write('Kniha ', I);
	GotoXY(37, 17);
		for IIH:=1 to 7 do write(#205);
		Ram(37,18,20);
		GotoXY(24, 19);
		write('Nazev knihy:'); GotoXY(39,19); write(KK[I].Nazev);
		Ram(37,21,20);
	GotoXY(24, 22);
		write('Autor knihy:'); GotoXY(39,22); write(KK[I].Autor);
		Ram(37,24,20);
	GotoXY(24, 25);
		write('Zanr knihy:'); GotoXY(39,25); write(KK[I].Druh);
		Ram(37,27,20);
	GotoXY(24, 28);
		write('Cena knihy:'); GotoXY(39,28); write(KK[I].Cena); write(' Kc');
	TextColor(15);
	Menu_vypis;
	ClrScr;
	TextColor(15);
	PPP := 1;

	case CisloVypisMenu of
		1: EXIT;
		2: if I = 1 then I := PocetKnih else I := I-1;
		3: if I = PocetKnih then I := 1 else I := I+1;
		4: begin if PocetKnih <= 1 then begin
			ClrScr;
			gotoxy(28,21);
			write('Tato knihovna je prazdna!');
			Reset_Databaze;
			readln;
			EXIT;	
			end
			else
				Odstranit(I);
				Ukladani_Knih;
				I := 1;
			end;
	end;

	until 1 > 2;

	end;
	
	if PocetKnih=0 then begin gotoxy(28,21);
	write('Tato knihovna je prazdna!'); end;
	readln;
	end;

procedure Trid_databazi;
	var I,J	:byte;
	H	:Kniha;
	begin

	if PocetKnih>0 then begin
	GotoXY(26, 16);
	write('Podle ceho chcete tridit?');
	GotoXY(24, 17);
	for I:=1 to 29 do write(#205);
	VyberVyhledavani;

	if PocetVyberu = 1 then begin
	for I:=PocetKnih downto 2 do
		for J:=1 to I-1 do
			if KK[J].Nazev>KK[J+1].Nazev then
				begin H:=KK[J]; KK[J]:=KK[J+1]; KK[J+1]:=H; end;
	TextColor(15);
	ClrScr;
	gotoxy(24,21);
	write('Knihovna byla uspesne setridena!');
	readln;
		end
	
	else if PocetVyberu = 2 then begin
	for I:=PocetKnih downto 2 do
		for J:=1 to I-1 do
			if KK[J].Autor>KK[J+1].Autor then
				begin H:=KK[J]; KK[J]:=KK[J+1]; KK[J+1]:=H; end;
	TextColor(15);
	ClrScr;
	gotoxy(24,21);
	write('Knihovna byla uspesne setridena!');
	readln;
		end
	
	else begin TextColor(15); EXIT; end;

	end;
	end;

procedure Zmena_databaze;
	var I,J,IH :byte;
	begin
	ClrScr;
		GotoXY(26, 16);
	write('Vyberte cislo databaze:');
		GotoXY(26, 17);
	for IH:=1 to 23 do write(#205);
	VyberCisla;
	case Z of
		1:PocetDatabaze:=1;
		2:PocetDatabaze:=2;
		3:PocetDatabaze:=3;
		4:PocetDatabaze:=4;
		5:PocetDatabaze:=5;
	end;
	TextColor(15);
end;

procedure Vyhledej;
	type VyhledaneKnihy		=array[1..Pocet] of Kniha;
	var I,J,IH,JH 	:byte;
		VyhledavanaKniha :string;
		VyhKK	:VyhledaneKnihy;
	begin

	if PocetKnih > 0 then begin

	ClrScr;
	GotoXY(24, 16);
	write('Podle ceho chcete vyhledavat?');
	GotoXY(24, 17);
	for IH:=1 to 29 do write(#205);
	VyberVyhledavani;

	TextColor(15);

	JH := 0;

	if PocetVyberu = 1 then begin
		GotoXY(24, 24);
		write('Vyhledavani: '); readln(VyhledavanaKniha);
		for I := 1 to PocetKnih do begin
			if KK[I].Nazev = VyhledavanaKniha then begin
				JH := JH + 1;
				VyhKK[JH] := KK[I];
				end;
			end;
		end

	else if PocetVyberu = 2 then begin
		GotoXY(24, 24);
		write('Vyhledavani: '); readln(VyhledavanaKniha);
		for I := 1 to PocetKnih do begin
			if KK[I].Autor = VyhledavanaKniha then begin
				JH := JH + 1;
				VyhKK[JH] := KK[I];
				end;
			end;
		end;
	
	ClrScr;
	if JH>0 then begin
	I:=1;
	repeat;

	TextColor(15);

	GotoXY(37, 16);
		write('Kniha ', I);
	GotoXY(37, 17);
		for IH:=1 to 7 do write(#205);
		Ram(37,18,20);
		GotoXY(24, 19);
		write('Nazev knihy:'); GotoXY(39,19); write(VyhKK[I].Nazev);
		Ram(37,21,20);
	GotoXY(24, 22);
		write('Autor knihy:'); GotoXY(39,22); write(VyhKK[I].Autor);
		Ram(37,24,20);
	GotoXY(24, 25);
		write('Zanr knihy:'); GotoXY(39,25); write(VyhKK[I].Druh);
		Ram(37,27,20);
	GotoXY(24, 28);
		write('Cena knihy:'); GotoXY(39,28); write(KK[I].Cena); write(' Kc');

	TextColor(15);
	Menu_vyhledej;
	ClrScr;
	TextColor(15);
	PPP := 1;

	case CisloVyhledejMenu of
		1: EXIT;
		2: if I = JH then I := JH else I := I-1;
		3: if I = JH then I := 1 else I := I+1;
		end;

	until 1 > 2;

	end;

	if (JH = 0) and (PocetVyberu <> 0) then begin gotoxy(28,21);
	write('Zadna takova kniha tu neni!'); end;

	if PocetVyberu <> 0 then readln;
	TextColor(15);

	end

	else begin
	
	ClrScr;
	gotoxy(28,21);
	write('Tato knihovna je prazdna!');
	readln;
	end;

	end;

procedure zacatek;
	begin
	ClrScr;
	PocetKnih:=0;
	uvod;
	PocetDatabaze:=1;
	Determinace_databaze;
	Nacteni_Databaze;
	end;

procedure Vlozeni_final;
	begin 
	if PocetKnih < 20 then begin
	Vkladani_knih(K); 
	PPP:=1; 
	PocetKnih:=PocetKnih+1; 
	KK[PocetKnih]:=K; 
	Ukladani_Knih; 
	end
	else begin
	ClrScr; 
	gotoxy(28,21);
	write('Tato knihovna je plna!');
	readln;
	end;
	end;

procedure Reset_final;
	begin 
	Reset_Databaze;
	ClrScr;
	gotoxy(28,21);
	write('Knihovna byla smazana!');
	readln;
	end;

procedure Vypis_final;
	begin
	Vypis;
	Ukladani_Knih;
	end;

procedure Trideni_final;
	begin
	ClrScr;
	if PocetKnih>1 then begin
	Trid_databazi;
	Ukladani_Knih;
	end
	else if PocetKnih = 0 then begin
	ClrScr; 
	gotoxy(28,21);
	write('Tato knihovna je prazdna!');
	readln;
	end
	else begin
	ClrScr; 
	gotoxy(30,21);
	write('Zde neni co tridit!');
	readln;
	end;
	end;


procedure Zmena_final;
	begin 
	Zmena_databaze; 
	Determinace_databaze; 
	Nacteni_Databaze; 
	end;


procedure __main__;
	begin
		zacatek;
			repeat
				Menu(I);
					case I of
						1:Vypis_final;
						2:Vyhledej;
						3:Reset_final;
						4:Vlozeni_final;
						5:Trideni_final;
						6:Zmena_final;
						7:HALT;
						end;
				until 1>2;
			end;

begin
__main__; {kratsi uz to snad nejde}
end.