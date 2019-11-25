uses Crt,SysUtils;

type
vector= record
	x,y:byte;
	end;
flag= record
	x1,x2,y1,y2:boolean;
	end;

var
	s:array of array of string;
	i,j,r,size,size2:byte;
	d:set of byte;
	a:boolean;
	star:vector;
	step:longint;
	name:string;

function check():boolean;
var
i,j,rez:byte;
begin
	rez:=0;
	check:=false;
	for j:=0 to size-1 do
		for i:=0 to size-1 do
			if pos(IntToStr(j*size+i+1),s[i,j])<>0 then
				rez+=1;
	if rez=size2-1 then check:=true;
end;
procedure change(a,b:byte);
begin
	s[star.x,star.y]:=s[a,b];
	s[a,b]:='*  ';
	step+=1;
end;
function move():boolean;
var 
r:char;
l:flag;
begin
	r:=readkey;
	move:=false;
	l.x1:=true; l.x2:=true;
	l.y1:=true; l.y2:=true;
	if star.x=0 then
		l.x1:=false;
	if star.x=size-1 then
		l.x2:=false;
	if star.y=0 then
		l.y1:=false;
	if star.y=size-1 then
		l.y2:=false;
	if ((r='w') or (r=#072))and (l.y1) then
		change(star.x,star.y-1);
	if ((r='a') or (r=#075)) and (l.x1) then
		change(star.x-1,star.y);
	if ((r='s') or (r=#080)) and (l.y2) then
		change(star.x,star.y+1);
	if ((r='d') or (r=#077)) and (l.x2) then
		change(star.x+1,star.y);
	if r='' then
		move:=true;
end;
function find():vector;
var i,j:byte;
begin
	for j:=0 to size-1 do
		for i:=0 to size-1 do
	if pos('*',s[i,j])<>0 then 
	begin
		find.x:=i;
		find.y:=j;
	end;
end;
	
begin
	step:=0;
	randomize;
	d:=[];
	writeln('What is your name?');
	readln(name);
	writeln('Hello, ',name,'.');
	repeat
		writeln('Set length of a side of a square for 2 to 15');
		readln(size);
	until (size>=2) and (size<=15);
	size2:=size*size;
	SetLength(s,size,size);
	for j:=0 to size-1 do
		for i:=0 to size-1 do 
		begin
			repeat
				r:=random(size2);
			until not (r in d);
			d:=d+[r];
			if r=0 then
				s[i,j]:='*  '
			else if r<10 then s[i,j]:=chr(r+48)+'  '
			else if r<100 then s[i,j]:=chr(((r div 10)mod 10)+48)+chr((r mod 10)+48)+' '
			else s[i,j]:=chr((r div 100)+48)+chr(((r div 10)mod 10)+48)+chr((r mod 10)+48);
		end;
	clrscr;
	for j:=0 to size-1 do 
		begin
			writeln;
			writeln;
			for i:=0 to size-1 do
				write(s[i,j],' ');
		end;
	while not check() do 
	begin
		if Keypressed then 
		begin
			clrscr();
			star:=find();
			a:=move();
			if a then break
			else
			for j:=0 to size-1 do 
			begin
				writeln;
				writeln;
				for i:=0 to size-1 do
					write(s[i,j],' ');
			end;
		end;
	end;
	if check() then 
	begin 
		writeln('You win!!!');
		writeln(name);
		writeln('steps: ',step);
		writeln('size: ',size,'x',size);
	end;
end.
