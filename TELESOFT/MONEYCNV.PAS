{Conversion routine for numeric string to plain language string.}
{Max conversion is 99,999,999.99}
{Version 1.0   02-26-96}
{Roger Nyberg  roger@servtech.com}

unit Moneycnv;

interface
uses
  SysUtils,Dialogs;
type
nummap = array[0..19] of string[9];
nummap2 = array[0..9] of string[9];
devidermap = array[0..2] of string[9];
const
{Constants for US currency. Do not remove empty string}
  numstr:nummap = ('','One','Two','Three','Four','Five','Six','Seven','Eight','Nine',
  'Ten','Eleven','Twelve','Thirteen','Fourteen','Fifteen','Sixteen','Seventeen',
  'Eighteen','Nineteen');

  numstr2:nummap2 = ('','','Twenty','Thirty','Fourty','Fifty',
                     'Sixty','Seventy','Eighty','Ninty');

 devidestr:devidermap = ('Hundred','Thousand','Million');
 AndStr ='And';
 CurrencyStr = 'Dollars';
 ReverseOverTwenty = False; {Set reverse on tenth translation}

function MoneyStr(var Text:string):String;

implementation

function MoneyStr(var Text:string):string;
var
IntStr,revtext,amount,decstring,TrashText:String;
i:integer;
begin
IntStr:='';
amount:='';
revtext:='';
decstring:='';
TrashText:='';

{Remove all non numeric characters. Used for text with Currency or Number Format}
for i:=0 to length(Text) do
 if ( Text[i] in ['0'..'9',DecimalSeparator,'-','+','e','E']) then
      TrashText:=TrashText+Text[i];

{Running this to make sure that if exponent string was sent it's handled correctly
 and convert to ffFixed format with only two Decimals}
 Text:=FloatToStrF (StrToFloat(TrashText), ffFixed, 11,2);

{Check for max value}
if StrToFloat(Text) > 99999999.99 then
begin
MessageDlg('Exceeded max value of 99,999,999.99', mtError, [mbOK], 0);
result:='ERROR';
exit;
end;

{Reversing the text. Easier to work with}
for i:=length(Text) downto 1 do
begin
{ Get the value before Decimal}
if (i < pos(DecimalSeparator,Text)) and (pos(DecimalSeparator,Text)>0)then
    IntStr:=Text[i]+IntStr;
if Text[i] in ['0'..'9',DecimalSeparator] then
revtext:=revtext+Text[i];
end;

{Take out the Decimal portion and delete all characters after decimal
  including decimal point}
  while pos(DecimalSeparator,revtext)>0 do
  begin
   if revtext[1]<>DecimalSeparator then
   decstring:=revtext[1]+decstring;
   delete(revtext,1,1);
  end;

{Check the value of revtext and convert it to text amount}
if (StrToInt(IntStr) > 0) then
if (StrToInt(IntStr) < 10) then
amount:=amount+NUMSTR[strtoint(revtext[1])]+' '
else
if (StrToInt(IntStr) >= 10) and (revtext[2]<'2')then
amount:=amount+NUMSTR[strtoint(revtext[2]+revtext[1])]+' '
else if  ReverseOverTwenty then
amount:=amount+NUMSTR[strtoint(revtext[1])]+' '+NUMSTR2[strtoint(revtext[2])]+' '
else
amount:=amount+NUMSTR2[strtoint(revtext[2])]+' '+NUMSTR[strtoint(revtext[1])]+' ';

if (StrToInt(IntStr) >=100)and (revtext[3]<>'0')   then
amount:=NUMSTR[strtoint(revtext[3])]+' '+DevideStr[0]+' '+amount;

if(StrToInt(IntStr) >= 1000) and (StrToInt(IntStr) < 10000)then
amount:=NUMSTR[strtoint(revtext[4])]+' '+DevideStr[1]+' '+ amount
else
if (StrToInt(IntStr) >= 10000) and (revtext[5]<'2')and (revtext[5]<>'0') then
amount:=NUMSTR[strtoint(revtext[5]+revtext[4])]+' '+DevideStr[1]+' '+amount
else
if (StrToInt(IntStr) >= 20000)and (revtext[5]<>'0') then
if  ReverseOverTwenty then
amount:=NUMSTR[strtoint(revtext[4])]+' '+NUMSTR2[strtoint(revtext[5])]+' '+DevideStr[1]+' '+amount
else
amount:=NUMSTR2[strtoint(revtext[5])]+' '+NUMSTR[strtoint(revtext[4])]+' '+DevideStr[1]+' '+amount;

if (StrToInt(IntStr) >=100000) and (revtext[6]<>'0') then
begin
if (revtext[5]='0') and (revtext[4]='0') then
amount:=NUMSTR[strtoint(revtext[6])]+' '+DevideStr[0]+' '+DevideStr[1]+' '+amount
else
amount:=NUMSTR[strtoint(revtext[6])]+' '+DevideStr[0]+' '+amount;
end;

if(StrToInt(IntStr) >= 1000000) and (StrToInt(IntStr) < 10000000)then
amount:=NUMSTR[strtoint(revtext[7])]+' '+DevideStr[2]+' '+ amount
else
if (StrToInt(IntStr) >= 10000000) and (revtext[8]<'2') then
amount:=NUMSTR[strtoint(revtext[8]+revtext[7])]+' '+DevideStr[2]+' '+amount
else
if (StrToInt(IntStr) >= 20000000) then
if  ReverseOverTwenty then
amount:=NUMSTR[strtoint(revtext[7])]+' '+NUMSTR2[strtoint(revtext[8])]+' '+DevideStr[2]+' '+amount
else
amount:=NUMSTR2[strtoint(revtext[8])]+' '+NUMSTR[strtoint(revtext[7])]+' '+DevideStr[2]+' '+amount;

if decstring = '' then decstring:='00';
if amount = '' then amount:= '********';

{Return the result}
result:=amount+AndStr+' '+decstring+'/100 '+CurrencyStr;
end;

end.
