unit Tzpmod;

interface

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, ExtCtrls;

type
  TZPModule = class(TImage)
  private
    { Private declarations }
  protected
    { Protected declarations }
    procedure StrPartTextOut(XSize,X,Y:Integer; var P:PChar);
    procedure TextFill(Text:TStrings; x1,x2:Word;var y; YPos:Word);
  public
    { Public declarations }
    procedure FixCharPosTextOut(S:String;X,Y:Integer; Interval:Integer);
    function StringAsPChar(var S: OpenString): PChar;
  published
    { Published declarations }
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('Telesoft', [TZPModule]);
end;

function TZPModule.StringAsPChar(var S: OpenString): PChar;
{ This function null-terminates a string so that it can be passed to functions }
{ that require PChar types. If string is longer than 254 chars, then it will   }
{ be truncated to 254. }
begin
  if Length(S) = High(S) then Dec(S[0]); { Truncate S if it's too long }
  S[Ord(Length(S)) + 1] := #0;           { Place null at end of string }
  Result := @S[1];                       { Return "PChar'd" string }
end;

procedure TZPModule.FixCharPosTextOut(S:String;X,Y:Integer; Interval:Integer);
var
  i:Byte;
  j:Word;
begin
  j:=Abs(Canvas.Font.Height);
  for i:=1 to Length(S) do
    Canvas.TextOut(x+Interval*(i-1),Y - j,S[i]);
end;

procedure TZPModule.StrPartTextOut(XSize,X,Y:Integer; var P:PChar);
var
  SLen:LongInt;
  P0,P1:PChar;
  TextEnd:Boolean;
  LineFull:Boolean;
begin
  P0:=P;
  repeat
    P1:=P;
    while not (p^ in [#0, ' ']) do
      Inc(P);
    TextEnd:=P^<>' ';
    SetTextJustification(Canvas.Handle,0,0);
    SLen:=GetTextExtent(Canvas.Handle,P0,P-P0);
    LineFull:=(LoWord(SLen)>=XSize);
    if (not TextEnd) or LineFull
      then Inc(P);
  until TextEnd or LineFull;
  if TextEnd and not LineFull
    then P1:=P;
  while P1^<>' ' do
    Dec(P1);
  TextOut(Canvas.Handle,X,Y-Abs(Canvas.Font.Height),P0,P1-P0);
  if P^<>#0
    then P:=P1;
end;

procedure TZPModule.TextFill(Text:TStrings; x1,x2:Word;var y; YPos:Word);
var
  Len:Word;
  j:Byte;
  i,l:LongInt;
  p,p1:PChar;
  yWord: Array[1..100] of Word Absolute y;
begin
  if YPos>100
    then {Error} Exit;
  Len:=0;
  for i:=0 to Text.Count-1 do
    begin
      Len:=Len+Length(Text[i]);
      if Text[i][Length(Text[i])]<>' '
        then Inc(Len);
    end;
  p:=StrAlloc(Len+1);
  l:=0;
  for i:=0 to Text.Count-1 do
    begin
      for j:=1 to Length(Text[i]) do
        begin
          p[l]:=Text[i][j];
          Inc(l);
        end;
      if p[l-1]<>' '
        then begin
          p[l]:=' ';
          Inc(l);
        end;
    end;
  p1:=p;
  i:=1;
  while (p1^<>#0) or (i<=YPos) do
    begin
      StrPartTextOut(x2-x1,x1,yWord[i],p1);
      Inc(i);
    end;
  StrDispose(p);
end;

end.
