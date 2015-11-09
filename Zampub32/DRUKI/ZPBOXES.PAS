unit ZpBoxes;

interface

uses
  WinProcs, Classes, Controls, Buttons,
  StdCtrls, ExtCtrls, Dialogs, Messages,
  WinTypes,
  Graphics,
  SysUtils,
  RPrev,
  Utils;

const
DemoStr='WERSJA 3.0 DEMO';
PageBottomSpace=40;
EmptyDateStr='               ';
EmptyStr2cm='            ';

Zp1Tit='Protokó³ postêpowania o zamówienie publiczne o wartoœci szacunkowej powy¿ej 30.000 ECU';
Zp11Tit='Dostawcy/wykonawcy uczestnicz¹cy we wstêpnej kwalifikacji';
Zp12Tit='Kryteria oceny spe³niania warunków wymaganych od dostawców/wykonawców podczas wstêpnej kwalifikacji i ich znaczenie';
Zp13Tit='Lista dostawców/wykonawców dopuszczonych do dalszego udzia³u w postêpowaniu po przeprowadzeniu wstêpnej kwalifikacji';
Zp14Tit='Potwierdzenie wys³ania/dorêczenia zaproszenia';
Zp21Tit='Oœwiadczenie cz³onka komisji przetargowej';
Zp43Tit='Stwierdzone w ofertach oczywiste omy³ki';
Zp44Tit='Oferty uznane za niewa¿ne z powodu b³êdów formalnych';
Zp45Tit1='Zestaw dokumentów wymaganych od dostawców / wykonawców bior¹cych udzia³ w postêpowaniu o udzielenie zamówienia ';
Zp45Tit2='publicznego';
Zp46Tit='Informacja o spe³nianiu warunków wymaganych od dostawców/wykonawców';
Zp51Tit='Kryteria oceny ofert i ich znaczenie';
Zp52Tit='Karta indywidualnej oceny oferty tajne';
Zp53Tit='Streszczenie oceny i porównania z³o¿onych ofert';
Zp54Tit='Powody odrzucenia wszystkich ofert';
Zp61Tit='Protesty z³o¿one podczas postêpowania o udzielenie zamówienia publicznego';
Zp71Tit='Powody niezawarcia umowy w sprawie zamówienia publicznego';
Zp81Tit='Lista bieg³ych i rzeczoznawców uczestnicz¹cych w postêpowaniu o udzielenie zamówienia publicznego';
Zp110Tit='Og³oszenie o przetargu nieograniczonym o wartoœci powy¿ej 30.000 ECU';
Zp121Tit='Zaproszenie do sk³adania ofert w przetargu ograniczonym';
Zp120Tit1='Zaproszenie do zg³oszenia zainteresowania udzia³em w przetargu ograniczonym ';
Zp120Tit2='o wartoœci szacunkowej powy¿ej 30.000 ECU';
Zp130Tit='Informacja o wstêpnej kwalifikacji';
Zp140Tit='Og³oszenie o przetargu dwustopniowym o wartoœci powy¿ej 30.000 ECU';
Zp141Tit='Zaproszenie do sk³adania ofert ostatecznych w przetargu dwustopniowym';
Zp150Tit='Informacja o wyniku postêpowania';
Zp160Tit1='Informacja o rozpoczêciu postêpowania w trybie negocjacji z zachowaniem konkurencji ';
Zp160Tit2='o wartoœci powy¿ej 200.000 ECU';
Zp170Tit1='Informacja o rozpoczêciu postêpowania w trybie zapytania o cenê ';
Zp170Tit2='o wartoœci powy¿ej 200.000 ECU';
Zp210Tit='Formularz wstêpnej kwalifikacji';

ZP1FileHdr='DR30ZP1';
ZP11FileHdr='DR30ZP11';
ZP12FileHdr='DR30ZP12';
ZP13FileHdr='DR30ZP13';
ZP14FileHdr='DR30ZP14';
ZP21FileHdr='DR30ZP21';
ZP31FileHdr='DR30ZP31';
ZP41FileHdr='DR30ZP41';
ZP42FileHdr='DR30ZP42';
ZP43FileHdr='DR30ZP43';
ZP44FileHdr='DR30ZP44';
ZP45FileHdr='DR30ZP45';
ZP46FileHdr='DR30ZP46';
ZP51FileHdr='DR30ZP51';
ZP52FileHdr='DR30ZP52';
ZP53FileHdr='DR30ZP53';
ZP54FileHdr='DR30ZP54';
ZP61FileHdr='DR30ZP61';
ZP71FileHdr='DR30ZP71';
ZP81FileHdr='DR30ZP81';
ZP110FileHdr='DR30ZP110';
ZP121FileHdr='DR30ZP121';
ZP150FileHdr='DR30ZP150';
ZP160FileHdr='DR30ZP160';
ZP170FileHdr='DR30ZP170';

ZP120FileHdr='DR30ZP120';
ZP130FileHdr='DR30ZP130';
ZP140FileHdr='DR30ZP140';
ZP141FileHdr='DR30ZP141';
ZP210FileHdr='DR30ZP210';

Sec1='TAJNE - udostêpniane po wyborze oferty lub po zakoñczeniu postêpowania, je¿eli nie dosz³o ';
Sec2='do wyboru oferty, dostawcom / wykonawcom, którzy ubiegali siê o udzielenie zamówienia.';
Sec2_46='do wyboru oferty, dostawcom / wykonawcom, którzy ubiegali siê o wykonanie zamówienia.';

procedure AddBox(Ry:TRyPrinter; const P:Array of PChar; const D:Array of Byte;
                 ATitle,ZpNum,NumSpraw:String; var PageSpace:Integer; var PPos:Integer);
procedure AddZp1Box(Ry:TRyPrinter; BoxNum:String; const P:Array of PChar; const D:Array of Byte;
                    ATitle,ZpNum,NumSpraw:String; var PageSpace:Integer; var PPos:Integer);
procedure MakeHeader(var Ry:TRyPrinter; ZpTitle,ZpNumStr,NumSpraw,PageNum:String; var PPos:Integer);
procedure MakeFooter(Ry:TRyPrinter; APSpace:Integer);
procedure MakeSecretBox(Ry:TRyPrinter; var PPos:Integer);
procedure MakeNewPage(Ry:TRyPrinter; ATitl,ZpNum,NumSpraw:String; var PPos,PSpace:Integer);
procedure MakeZpNumStr(Ry:TRyPrinter; ARight:Integer; ZpNumStr:String; var PPos:Integer);
procedure MakeUZPTitle(Ry:TRyPrinter; Str:String; var PPos:Integer);

implementation

{$R ZPLOGO.RES}

procedure MakeUZPTitle(Ry:TRyPrinter; Str:String; var PPos:Integer);
begin
  with Ry do
    begin
      Font.Name:='Times New Roman CE';
      Font.Size:=14;
      Font.Style:=[fsBold];
      TextOut(XLOff,PPos,Str);
      PPos:=PPos+TextHeight+Ymm(5);
    end;
end;

procedure MakeNumSprawy(Ry:TRyPrinter; NumSpraw:String; var PPos:Integer);
var
  s:String;
begin
  with Ry do
    begin
      Font.Name:='Times New Roman CE';
      Font.Size:=10;
      PPos:=YTOff;
      s:='numer sprawy:  ';
      if NumSpraw=''
        then s:=s+'_________________'
        else s:=s+NumSpraw;
      TextOut(XLOff,YTOff,s);
    end;
end;

procedure MakeZpNumStr(Ry:TRyPrinter; ARight:Integer; ZpNumStr:String; var PPos:Integer);
begin
  with Ry do
    begin
      Font.Name:='Times New Roman CE';
      Font.Size:=16;
      Font.Style:=[fsBold];
      {$IFDEF DEMO}
      if (ZpNumStr<>'')
        then TextOutRight(ARight+Xmm(2),YTOff,DemoStr+'    '+DemoStr+'    DRUK ZP-'+ZpNumStr);
      {$ELSE}
      if (ZpNumStr<>'')
        then TextOutRight(ARight+Xmm(2),YTOff,'DRUK ZP-'+ZpNumStr);
      {$ENDIF}
      PPos:=PPos-Font.Height+Ymm(2);
    end;
end;

procedure MakeZpLogo(Ry:TRyPrinter; var ALeft,PPos:Integer);
var
  Rct:TRect;
  BM:TBitMap;
  x,BmpR,BmpL:Integer;
begin
  with Ry do
    begin
      BM:=TBitMap.Create;
      BM.Handle:=LoadBitmap(HInstance,'ZPLOGO');
      BmpR:=XROff-Xmm(2);
      BmpL:=BmpR-Xmm(20);
      Rct.Right:=BmpR;
      Rct.Left:=BmpL;
      Rct.Top:=YTOff;
      Rct.Bottom:=Rct.Top+Ymm(20);
      StretchDraw(Rct,BM);
      BM.Free;
      ALeft:=Rct.Left;
    end;
end;

procedure MakePageNum(Ry:TRyPrinter; PageNum:String; var PPos:Integer);
var
  s:String;
begin
  with Ry do
    begin
      Font.Size:=14;
      if PageNum=''
        then s:=IntToStr(CurrentPage)
        else s:=PageNum;
      TextOut(XLOff,PPos,'str. '+s);
    end;
end;

procedure MakeStamp(Ry:TRyPrinter; var ARight,ARctBtm:Integer);
var
  s:String;
  Rct:TRect;
begin
  with Ry do
    begin
      Rct.Right:=ARight - Xmm(4);
      Rct.Left:=Rct.Right - Xmm(50);
      Rct.Top:=ARctBtm;
      Rct.Bottom:=Rct.Top+Ymm(25);
      RoundRectangle(Rct);
      Font.Size:=8;
      TextOut(Rct.Left+Xmm(10),Rct.Bottom-Ymm(4),'pieczêæ zamawiaj¹cego');
      ARight:=Rct.Left;
      ARctBtm:=Rct.Bottom;
    end;
end;

procedure MakeZpTitle(Ry:TRyPrinter; ARctLeft,ARctBtm:Integer; ZpTitle:String; var PPos:Integer);
var
  s:String;
  p:PChar;
  x:Integer;
begin
  with Ry do
    begin
      Font.Size:=14;
      p:=StrAlloc(Length(ZpTitle)+1);
      StrPCopy(p,ZpTitle);
      x:=MemoOut(Rect(XLOff,PPos+TextHeight+Ymm(2),ARctLeft-Xmm(5),ARctBtm),p,FALSE,FALSE);
      StrDispose(p);
      if PPos+TextHeight+Ymm(2)+x>ARctBtm
        then PPos:=PPos+TextHeight+Ymm(2)+x
        else PPos:=ARctBtm;
    end;
end;

procedure MakeHeader(var Ry:TRyPrinter; ZpTitle,ZpNumStr,NumSpraw,PageNum:String; var PPos:Integer);
var
  X,RctBtm:Integer;
begin
  MakeNumSprawy(Ry,NumSpraw,PPos); {don't change the order of these procedures}
  MakeZpLogo(Ry,X,PPos);
  MakeZpNumStr(Ry,X,ZpNumStr,PPos);
  MakePageNum(Ry,PageNum,PPos);
  RctBtm:=PPos;
  MakeStamp(Ry,X,RctBtm);
  MakeZpTitle(Ry,X,RctBtm,ZpTitle,PPos);
end;

procedure MakeFooter(Ry:TRyPrinter; APSpace:Integer);
var
  Rect:TRect;
  Pt1,Pt2:TPoint;
  p:Byte;
  s:String;
begin
  with Ry do
    begin
      Font.Size:=10;
      {$IFDEF DEMO}
      TextOutRight(XROff-Xmm(3),APSpace + Ymm(25),DemoStr+'    podpis ________________________');
      {$ELSE}
      TextOutRight(XROff-Xmm(3),APSpace + Ymm(25),'podpis ________________________');
      {$ENDIF}
    end;
end;

procedure MakeSecretBox(Ry:TRyPrinter; var PPos:Integer);
var
  Rct:TRect;
begin
  with Ry do
    begin
      Rct.Left:=XLOff;
      Rct.Right:=XROff;
      Rct.Top:=PPos+Xmm(4);
      Rct.Bottom:=Rct.Top+Ymm(8);
      RoundRectangle(Rct);
      Font.Size:=16;
      TextOut(Rct.Left+Xmm(14),Rct.Top+Ymm(1),'TAJNE');
      PPos:=Rct.Bottom;
    end;
end;

procedure MakeNewPage(Ry:TRyPrinter; ATitl,ZpNum,NumSpraw:String; var PPos,PSpace:Integer);
begin
  with Ry do
    begin
      NewPage;
{      SetMinMargins(Xmm(10),Ymm(15),Xmm(20),Ymm(10));}
{      SetMinMargins(Xmm(20),Ymm(10),Xmm(20),Ymm(10));}
      PSpace:=YBOff-Ymm(PageBottomSpace);
      MakeHeader(Ry,ATitl,ZpNum,NumSpraw,'',PPos);
      MakeFooter(Ry,PSpace);
    end;
end;

procedure AddBox(Ry:TRyPrinter; const P:Array of PChar; const D:Array of Byte;
                 ATitle,ZpNum,NumSpraw:String; var PageSpace:Integer; var PPos:Integer);
var
  Rct:TRect;
  Tx:Integer;
  LH:Integer; {Line height}
  LP:Integer; {Line position}
  X:Integer;
  i:Word;
  q,r:PChar;
  NoRect:Boolean;
  procedure DoRect;
  begin
    Ry.RoundRectangle(Rct);
  end;
begin
  with Ry do
    begin
      NoRect:=FALSE;
      Rct.Left:=XLOff;
      Rct.Right:=XROff;
      Rct.Top:=PPos+Xmm(3);
      Tx:=Rct.Left+Xmm(2);
      Font.Size:=10;
      LH:=TextHeight+Ymm(1);
      LP:=Rct.Top+Ymm(2);
      i:=0;
      while (i<=High(P)) do
        begin
          q:=P[i];
          while (q<>Nil) and (q[0]<>#0) do
            begin
              X:=PCharOut(Rect(Tx,LP,Rct.Right-Xmm(3),PageSpace-LP-Ymm(D[i])), q, False, False, TRUE,q);
              if LP+X+Ymm(D[i])>PageSpace
                then begin
                  Rct.Bottom:=LP+X+Ymm(D[i])+Ymm(1);
                  DoRect;
                  if q=nil
                    then NoRect:=TRUE;
                  MakeNewPage(Ry,ATitle,ZpNum,NumSpraw,PPos,PageSpace);
                  Rct.Top:=PPos+Xmm(3);
                  LP:=Rct.Top+Ymm(2);
                end
                else LP:=LP+X+Ymm(D[i]);
            end;
          Inc(i);
        end;
      Rct.Bottom:=LP+Ymm(1);
      if not NoRect
        then DoRect;
      PPos:=Rct.Bottom;
    end;
end;

procedure AddZp1Box(Ry:TRyPrinter; BoxNum:String; const P:Array of PChar; const D:Array of Byte;
                    ATitle,ZpNum,NumSpraw:String; var PageSpace:Integer; var PPos:Integer);
var
  Rct:TRect;
  Tx:Integer;
  LH:Integer; {Line height}
  LP:Integer; {Line position}
  X:Integer;
  i:Word;
  q,r:PChar;
  NoRect:Boolean;
  procedure DoRect;
  begin
    with Ry do
      begin
        RoundRectangle(Rct);
        Line(Point(Tx-Xmm(3),Rct.Top),Point(Tx-Xmm(3),Rct.Bottom));
        TextOutCenter(((Tx-Xmm(3)-Rct.Left) div 2)+Rct.Left,Rct.Top+Ymm(2),BoxNum);
      end;
  end;
begin
  with Ry do
    begin
      NoRect:=FALSE;
      Rct.Left:=XLOff;
      Rct.Right:=XROff;
      Rct.Top:=PPos+Xmm(3);
      Tx:=Rct.Left+Xmm(15);
      Font.Size:=10;
      LH:=TextHeight+Ymm(1);
      LP:=Rct.Top+Ymm(2);
      i:=0;
      while (i<=High(P)) do
        begin
          q:=P[i];
          while (q<>Nil) and (q[0]<>#0) do
            begin
              X:=PCharOut(Rect(Tx,LP,Rct.Right-Xmm(3),PageSpace-LP-Ymm(D[i])), q, False, False, TRUE,q);
              if LP+X+Ymm(D[i])>PageSpace
                then begin
                  Rct.Bottom:=LP+X+Ymm(D[i])+Ymm(1);
                  DoRect;
                  if (q=nil) and (i>=High(P))
                    then NoRect:=TRUE;
                  MakeNewPage(Ry,ATitle,ZpNum,NumSpraw,PPos,PageSpace);
                  Rct.Top:=PPos+Xmm(3);
                  LP:=Rct.Top+Ymm(2);
                end
                else LP:=LP+X+Ymm(D[i]);
            end;
          Inc(i);
        end;
      Rct.Bottom:=LP+Ymm(1);
      if not NoRect
        then DoRect;
      PPos:=Rct.Bottom;
    end;
end;

end.

procedure MakeHeader(var Ry:TRyPrinter; ZpTitle,ZpNumStr,NumSpraw,PageNum:String; var PPos:Integer);
var
  Rct:TRect;
  BM:TBitMap;
  x,BmpR,BmpL:Integer;
  s:String;
  p:PChar;
  Fnt:TFont;
begin
MakeNumSprawy(Ry,NumSpraw,PPos);
MakeZpNumStr(Ry,ZpNumStr,PPos);
  with Ry do
    begin
{      Fnt:=TFont.Create;
      Fnt.Name:='Times New Roman CE';
      Fnt.Size:=10;
      Fnt.Color:=clBlack;}
{      Font.Name:='Times New Roman CE';
      Font.Size:=10;}
{      Font.Assign(Fnt);
      PPos:=YTOff;
      s:='numer sprawy:  ';
      if NumSpraw=''
        then s:=s+'_________________'
        else s:=s+NumSpraw;
      TextOut(XLOff,YTOff,s);}
{      Font.Size:=16; }
{      Font.Style:=[fsBold];}
{      Fnt.Free;
      Fnt:=TFont.Create;
      Fnt.Name:='Times New Roman CE';
      Fnt.Color:=clBlack;
      Fnt.Size:=16;
      Fnt.Style:=[fsBold];
      Font.Assign(Fnt);}
{      BM:=TBitMap.Create;
      BM.Handle:=LoadBitmap(HInstance,'ZPLOGO');}
{      BmpR:=XROff-Xmm(2);
      BmpL:=BmpR-Xmm(20);
      Rct.Right:=BmpR;
      Rct.Left:=BmpL;
      Rct.Top:=YTOff;
      Rct.Bottom:=Rct.Top+Ymm(20);}
{      StretchDraw(Rct,BM);
      BM.Free;}
(*      {$IFDEF DEMO}
      if (ZpNumStr<>'')
        then TextOutRight(Rct.Left+Xmm(2),YTOff,DemoStr+'    '+DemoStr+'    DRUK ZP-'+ZpNumStr);
      {$ELSE}
      if (ZpNumStr<>'')
        then TextOutRight(Rct.Left+Xmm(2),YTOff,'DRUK ZP-'+ZpNumStr);
      {$ENDIF}*)
{      PPos:=PPos-Font.Height+Ymm(2);}
{      Font.Size:=14;}
{      if PageNum=''
        then s:=IntToStr(CurrentPage)
        else s:=PageNum;
      TextOut(XLOff,PPos,'str. '+s);}
{      Rct.Right:=BmpL - Xmm(4);
      Rct.Left:=Rct.Right - Xmm(50);
      Rct.Top:=PPos;
      Rct.Bottom:=Rct.Top+Ymm(25);
      RoundRectangle(Rct);}
(*      Font.Size:=8;
      TextOut(Rct.Left+Xmm(10),Rct.Bottom-Ymm(4),'pieczêæ zamawiaj¹cego');*)
{      Font.Size:=14;
      p:=StrAlloc(Length(ZpTitle)+1);
      StrPCopy(p,ZpTitle);
      x:=MemoOut(Rect(XLOff,PPos+TextHeight+Ymm(2),Rct.Left-Xmm(5),Rct.Bottom),p,FALSE,FALSE);
      StrDispose(p);}
{      if PPos+TextHeight+Ymm(2)+x>Rct.Bottom
        then }PPos:=PPos+TextHeight+Ymm(2);{+x}
{        else PPos:=Rct.Bottom;}
{      Fnt.Free;}
    end;
end;


