unit DateUtil;

interface

function JulianDate(Year,Month,Day:Word):LongInt;
function IsLeapYear(Year:Word): Boolean;
function CheckDate(Date,DFmt:String):Boolean;

implementation

uses
{  Utils,}
  SysUtils;

const
{Dates}
  plShortDayNames:array[1..7] of string[3]=
                  ('Nie','Pon','Wto','Œro','Czw','Pi¹','Sob');

  plLongDayNames:array[1..7] of string[15]=
                 ('Niedziela','Poniedzia³ek','Wtorek','Œroda','Czwartek','Pi¹tek','Sobota');

  plLongMonthNames:array[1..12] of string[15]=
                   ('Styczeñ','Luty','Marzec','Kwiecieñ','Maj','Czerwiec','Lipiec',
                    'Sierpieñ','Wrzesieñ','PaŸdziernik','Listopad','Grudzieñ');

  plShortMonthNames:array[1..12] of string[3]=
                    ('Sty','Lut','Mar','Kwi','Maj','Cze','Lip','Sie','Wrz','Pa¿','Lis','Gru');
  DaysPerMonth:Array[1..12] of Byte = (31,28,31,30,31,30,31,31,30,31,30,31);
  AddDays:Array[1..12] of Word = (0,31,59,90,120,151,181,212,243,273,304,334);

function JulianDate(Year,Month,Day:Word):LongInt;
var
  id :LongInt;
begin
  id:=AddDays[Month]+Day;
  id:=id+Year*365;
  if Year>0 then begin
     id:=id+((Year-1) div 4);
     if (Month>2)and((Year mod 4)=0) then
        id:=id+1;
  end;
  Result:=id;
end;

function IsLeapYear(Year:Word): Boolean;
begin
  Result := (Year mod 4 = 0) and
            ((Year mod 100 <> 0) or (Year mod 400 = 0));
end;

function LowerCaseChar(c:Char):Char;
begin
  if c in['A'..'Z']
    then Result:=Chr(Ord(c)+32)
    else Result:=c;
end;

function CheckDate(Date,DFmt:String):Boolean;
var
  ys:String[10];
  ms:String[20];
  ds:String[10];
  i:Byte;
  y,m,d:Word;
begin
  Result:=FALSE;
  ys:='';
  ms:='';
  ds:='';
  for i:=1 to Length(DFmt) do
    begin
      DFmt[i]:=LowerCaseChar(DFmt[i]);
      case DFmt[i] of
        'y': ys:=ys+Date[i];
        'm': ms:=ms+Date[i];
        'd': ds:=ds+Date[i];
      end;
    end;
  if Length(ys)>0
    then for i:=1 to Length(ys) do
        if not (ys[i] in ['0'..'9'])
          then Exit;
  if Length(ms)>0
    then for i:=1 to Length(ms) do
      if not (ms[i] in ['0'..'9'])
        then Exit;
  if Length(ds)>0
    then for i:=1 to Length(ds) do
      if not (ds[i] in ['0'..'9'])
        then Exit;
  case Length(ys) of
    2: y:=1900+(Ord(ys[1])-48)*10+Ord(ys[2])-48;
    4: y:=((Ord(ys[1])-48)*1000)+((Ord(ys[2])-48)*100)+
          (Ord(ys[3])-48)*10+Ord(ys[4])-48;
    else Exit;
  end;
  case Length(ms) of
    1:m:=Ord(ms[1])-48;
    2:m:=((Ord(ms[1])-48)*10)+Ord(ms[2])-48;
    else Exit;
  end;
  case Length(ds) of
    1:d:=Ord(ds[1])-48;
    2:d:=((Ord(ds[1])-48)*10)+Ord(ds[2])-48;
    else Exit;
  end;
  if (m<1) or (m>12)
    then Exit;
  if IsLeapYear(y)
    then DaysPerMonth[2]:=29
    else DaysPerMonth[2]:=28;
  if not d in[1..DaysPerMonth[m]]
    then Exit;
  Result:=TRUE;
end;

end.
