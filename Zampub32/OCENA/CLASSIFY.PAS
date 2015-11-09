unit Classify;

interface
{$N+}
uses WinTypes, WinProcs, Classes, Graphics, Forms, Controls, Buttons,
  StdCtrls, ExtCtrls, SysUtils, Printers, Dialogs,
  RPrev,
  ZpBoxes,
  Utils,
  SiwzIni,
  OfrtDta,
  Kriteria,
  Points,
  Subj,
  Grids,
  SkOk,
  Sk;

type
  TClassifyDlg = class(TForm)
    OKBtn: TBitBtn;
    HelpBtn: TBitBtn;
    WinLabel: TLabel;
    ZP53Btn: TBitBtn;
    Panel1: TPanel;
    SG: TStringGrid;
    SGLabel: TLabel;
    OpisSG: TStringGrid;
    KDescLabel: TLabel;
    Sk: TSmartKey;
    procedure FormActivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ZP53BtnClick(Sender: TObject);
    procedure HelpBtnClick(Sender: TObject);
  private
    { Private declarations }
    Ry : TRyPrinter;
    PPos:Integer;
    procedure ShowResults;
    procedure MakeListHeadRect;
    procedure MakeGridHeadRect;
    procedure MakeGridHeadRect2(var Places:Byte);
    function GetGridHeadHeight:Integer;
      {height of GridHead and GridHead2}
    procedure AddOpisRect(Cnt:Integer);
    function GetOpisRectHeight(Cnt:Integer):Integer;
    procedure AddOfferLine(Offer,FKrit,Krits:Integer);
    function GetOfferHeight:Integer;
  public
    { Public declarations }
  end;

var
  ClassifyDlg: TClassifyDlg;

implementation

{$R *.DFM}

procedure TClassifyDlg.ShowResults;
var
  i,j,k:LongInt;
  x,r:Real;
  c:Integer;
  Max:Real;
  s:String;
  SL:TStringList;
begin
  for i:= 0 to KDescs.Count-1 do
    EvaluateKriterium(i);
  for i:=1 to TendersTot do       {sum the results for kriteriums for every member}
    for j:=1 to KDescs.Count do
      begin
        x:=0;
        for k:=0 to MSurnames.Count-1 do
          x:=x+GetOfferItem(k,i-1,j-1).Eval * StrToInt(KWeights[j-1]) / 100;
        SG.Cells[j,i]:=FloatToStrF(x,ffFixed,15,3);
      end;
  Max:=0;
  for i:=1 to SG.RowCount-1 do       {sum offer points for total points}
    begin
      x:=0;
      for j:=1 to SG.ColCount-2 do
        x:=x+StrToFloat(SG.Cells[j,i]);
      if x>Max
        then Max:=x;
      SG.Cells[SG.ColCount-1,i]:=FloatToStrF(x,ffFixed,15,3);
    end;
  SL:=TStringList.Create;
  for i:=1 to SG.RowCount-1 do       {sum offer points for total points}
    if StrToFloat(SG.Cells[SG.ColCount-1,i])=Max
      then SL.Add(IntToStr(i));
  if SL.Count>0
    then begin
      if SL.Count=1
        then WinLabel.Caption:=OneWinnerText+SL[0]+'.'
      else if SL.Count>1
        then begin
          s:='';
          for i:=0 to SL.Count-1 do
            s:=s+SL[i]+', ';
          s[0]:=Chr(Ord(s[0])-2);
          WinLabel.Caption:=ManyWinnersText+s+'.'
        end;
    end;
  SL.Free;
end;

procedure TClassifyDlg.FormActivate(Sender: TObject);
begin
  ShowResults;
end;

procedure TClassifyDlg.FormCreate(Sender: TObject);
var
  i:LongInt;
begin
  SG.ColWidths[0]:=64;
  SG.RowCount:=9;
{  if TendersTot>SG.RowCount
    then} SG.RowCount:=TendersTot+1;
{  if KDescs.Count>SG.ColCount-1
    then} SG.ColCount:=KDescs.Count+2;
  for i:=1 to TendersTot do
    SG.Cells[0,i]:='Oferta '+IntToStr(i);
  for i:=1 to KDescs.Count do
    SG.Cells[i,0]:='Kryterium '+IntToStr(i);
  SG.Cells[KDescs.Count+1,0]:='Suma';
  OpisSG.RowCount:=KDescs.Count;
  OpisSG.ColWidths[1]:=1000;
  for i:=0 to KDescs.Count-1 do
    begin
      OpisSG.Cells[0,i]:=IntToStr(i+1);
      OpisSG.Cells[1,i]:=KDescs[i];
    end;
end;

procedure TClassifyDlg.MakeListHeadRect;
var
  A:Integer;
  x:Integer;
begin
  with Ry do
    begin
      PPos:=PPos+Ymm(3);
      x:=PPos;
      Font.Size:=10;
      Line(Point(XLOff,x),Point(XROff,x));
      PPos:=PPos+Ymm(2);
      TextOut(XLOff+Ymm(5),PPos,'Opis kryteriów');
      PPos:=PPos+TextHeight+Ymm(2);
      Line(Point(XLOff,PPos),Point(XROff,PPos));
      Line(Point(XLOff,x),Point(XLOff,PPos));
      Line(Point(XROff,x),Point(XROff,PPos));
      A:=XLOff+TextWidth('Numer')+Xmm(5);
      x:=PPos;
      PPos:=PPos+Ymm(2);
      TextOutCenter(((A-XLOff) div 2)+XLOff,PPos,'Numer');
      TextOutCenter(((XROff-A)div 2)+A,PPos,'Opis');
      PPos:=PPos+TextHeight+Ymm(2);
      Line(Point(XLOff,PPos),Point(XROff,PPos));
      Line(Point(XLOff,x),Point(XLOff,PPos));
      Line(Point(XROff,x),Point(XROff,PPos));
      Line(Point(A,x),Point(A,PPos));
    end;
end;

function TClassifyDlg.GetOpisRectHeight(Cnt:Integer):Integer;
var
  p:Byte;
  A:Integer;
  x,y:Integer;
  s:String;
begin
  with Ry do
    begin
      A:=XLOff+TextWidth('Numer')+Xmm(5);
      x:=Ymm(2);
      s:=OpisSG.Cells[1,Cnt];
      y:=MemoOut(Rect(A+Xmm(2),x,XROff-Xmm(2),10), StringAsPChar(s), False, True);
      Result:=x+y+Ymm(2);
    end;
end;

procedure TClassifyDlg.AddOpisRect(Cnt:Integer);
var
  p:Byte;
  A:Integer;
  x,y:Integer;
  s:String;
begin
  with Ry do
    begin
      A:=XLOff+TextWidth('Numer')+Xmm(5);
      x:=PPos;
      PPos:=PPos+Ymm(2);
      TextOutCenter(((A-XLOff) div 2)+XLOff,PPos,IntToStr(Cnt+1));
      s:=OpisSG.Cells[1,Cnt];
      y:=MemoOut(Rect(A+Xmm(2),PPos,XROff-Xmm(2),10), StringAsPChar(s), False, False);
      PPos:=PPos+y+Ymm(2);
      Line(Point(XLOff,PPos),Point(XROff,PPos));
      Line(Point(XLOff,x),Point(XLOff,PPos));
      Line(Point(XROff,x),Point(XROff,PPos));
      Line(Point(A,x),Point(A,PPos));
    end;
end;

procedure TClassifyDlg.MakeGridHeadRect;
var
  A:Integer;
  x:Integer;
begin
  with Ry do
    begin
      PPos:=PPos+Ymm(3);
      x:=PPos;
      Font.Size:=10;
      Line(Point(XLOff,x),Point(XROff,x));
      PPos:=PPos+Ymm(2);
      A:=XLOff+TextWidth('Numer')+Xmm(5);
      TextOutCenter(((A-XLOff) div 2)+XLOff,PPos,'Numer');
      TextOutCenter(((XROff-A)div 2)+A,PPos,'Ocena ofert');
      PPos:=PPos+TextHeight+Ymm(1);
      TextOutCenter(((A-XLOff) div 2)+XLOff,PPos,'oferty');
      TextOutCenter(((XROff-A)div 2)+A,PPos,'Kryteria oceny / punktacja');
      PPos:=PPos+TextHeight+Ymm(2);
      Line(Point(XLOff,PPos),Point(XROff,PPos));
      Line(Point(XLOff,x),Point(XLOff,PPos));
      Line(Point(XROff,x),Point(XROff,PPos));
      Line(Point(A,x),Point(A,PPos));
    end;
end;

function TClassifyDlg.GetGridHeadHeight:Integer;
var
  x:Integer;
begin
  with Ry do
    begin
      x:=Ymm(3);
      x:=x+Ymm(2);
      x:=x+TextHeight+Ymm(1);
      x:=x+TextHeight+Ymm(2);
      x:=x+Ymm(2);
      x:=x+TextHeight+Ymm(3);
      Result:=x;
    end;
end;

procedure TClassifyDlg.MakeGridHeadRect2(var Places:Byte);
var
  A,B,A1,A2:Integer;
  i:Byte;
  x,y:Integer;
  StartPlaces:Byte;
begin
  with Ry do
    begin
      x:=PPos;
      Font.Size:=10;
      Line(Point(XLOff,x),Point(XROff,x));
      y:=PPos+Ymm(2);
      A:=XLOff+TextWidth('Numer')+Xmm(5);
      B:=XROff-TextWidth('³¹cznie')-Xmm(5);
      StartPlaces:=Places;  {Last printed kriterium (first time it should be 0)}
      Places:=0;
      while A+Ymm(15)*Places<B do
        Inc(Places);
      A1:=A;
      PPos:=PPos+TextHeight+Ymm(3);
      Places:=Places-1;
      for i:=StartPlaces+1 to StartPlaces+Places do
        begin
          A2:=A1+Ymm(15);
          TextOutCenter(((A2-A1) div 2)+A1,y,IntToStr(i));
          Line(Point(A1,x),Point(A1,PPos));
          A1:=A2;
        end;
      if StartPlaces+Places>=KDescs.Count
        then begin
          B:=A2;
          Line(Point(B,x),Point(B,PPos));
          TextOutCenter(((XROff-B) div 2)+B,y,'³¹cznie');
        end
        else begin
          Inc(Places);
          A2:=A1+Ymm(15);
          TextOutCenter(((A2-A1) div 2)+A1,y,IntToStr(i+1));
          Line(Point(A1,x),Point(A1,PPos));
          A1:=A2;
        end;
      Places:=StartPlaces+Places;
      Line(Point(XLOff,PPos),Point(XROff,PPos));
      Line(Point(XLOff,x),Point(XLOff,PPos));
      Line(Point(XROff,x),Point(XROff,PPos));
      Line(Point(A,x),Point(A,PPos));
    end;
end;

function TClassifyDlg.GetOfferHeight:Integer;
var
  x:Integer;
begin
  with Ry do
    begin
      x:=Ymm(2);
      x:=x+TextHeight+Ymm(3);
      Result:=x;
    end;
end;

procedure TClassifyDlg.AddOfferLine(Offer,FKrit,Krits:Integer);
var
  A,A1,A2:Integer;
  i:Byte;
  x,y:Integer;
begin
  with Ry do
    begin
      x:=PPos;
      Font.Size:=10;
      Line(Point(XLOff,x),Point(XROff,x));
      y:=PPos+Ymm(2);
      A:=XLOff+TextWidth('Numer')+Xmm(5);
      TextOutCenter(((A-XLOff) div 2)+XLOff,y,IntToStr(Offer));
      A1:=A;
      PPos:=PPos+TextHeight+Ymm(3);
      for i:=FKrit+1 to Krits do
        begin
          A2:=A1+Ymm(15);
          if i<SG.ColCount-1
            then TextOutCenter(((A2-A1) div 2)+A1,y,SG.Cells[i,Offer]);
          Line(Point(A1,x),Point(A1,PPos));
          A1:=A2;
        end;
      if Krits>SG.ColCount-1
        then begin
          TextOutCenter(((XROff-A1) div 2)+A1,y,SG.Cells[SG.ColCount-1,Offer]);
          Line(Point(A1,x),Point(A1,PPos));
        end;
      Line(Point(XLOff,PPos),Point(XROff,PPos));
      Line(Point(XLOff,x),Point(XLOff,PPos));
      Line(Point(XROff,x),Point(XROff,PPos));
    end;
end;


procedure TClassifyDlg.ZP53BtnClick(Sender: TObject);
var
  p : PChar;
  Rect:TRect;
  Cur:Integer;
  x:LongInt;
  FullPage:Boolean;
  PrintSpace:Integer;
  StartPlace:Byte;
  TotPlaces:Byte;
  TP:Byte;
  Offer:Integer;
  xx:Byte;
  s:String;
begin
{$IFDEF DEMO}
  MessageDlg('Nie dostêpne w wersji DEMO',mtWarning,[mbOk],0);
{$ELSE}
{$IFDEF NONET}
  if not SmartKeyOk(Sk,SkData)
    then Exit;
{$ENDIF}
  try
    Cur:=Screen.Cursor;
    Screen.Cursor:=crHourGlass;
    Printer.Free;
    Printer:=TPrinter.Create;
    Printer.Orientation:=poLandscape;
    Ry := TRyPrinter.Create;
    with Ry do
      begin
        Orientation:=poLandscape;
        NewJob;
        SetMinMargins(Xmm(10),Ymm(15),Xmm(20),Ymm(10));
        x:=0;
        repeat
          MakeHeader(Ry,'Streszczenie oceny i porównania z³o¿onych ofert','53','','',PPos);
          PrintSpace:=YBOff-Ymm(25);
          MakeFooter(Ry,PrintSpace);
          MakeListHeadRect;
          FullPage:=False;
          while (x<OpisSG.RowCount) and not FullPage do
            begin
              FullPage:=(PPos+GetOpisRectHeight(x))>PrintSpace;
              if not FullPage
                then begin
                  AddOpisRect(x);
                  Inc(x);
                end;
            end;
          if FullPage
            then NewPage;
        until x>=OpisSG.RowCount;

        TotPlaces:=0;
        Offer:=1;
        repeat
          if PPos+GetGridHeadHeight+Ymm(10)>PrintSpace
            then begin
              NewPage;
              MakeHeader(Ry,'Streszczenie oceny i porównania z³o¿onych ofert','53','','',PPos);
              PrintSpace:=YBOff-Ymm(25);
              MakeFooter(Ry,PrintSpace);
              FullPage:=False;
            end;
          MakeGridHeadRect;
          StartPlace:=TotPlaces;
          MakeGridHeadRect2(TotPlaces);
          repeat
            AddOfferLine(Offer,StartPlace,TotPlaces);
            if PPos+GetOfferHeight+Ymm(10)>PrintSpace
              then begin
                NewPage;
                MakeHeader(Ry,'Streszczenie oceny i porównania z³o¿onych ofert','53','','',PPos);
                PrintSpace:=YBOff-Ymm(25);
                MakeFooter(Ry,PrintSpace);
                FullPage:=False;
                MakeGridHeadRect;
                TP:=StartPlace;
                MakeGridHeadRect2(TP);
              end;
            Inc(Offer);
          until Offer=SG.RowCount;
        until TotPlaces>=KDescs.Count;
        Screen.Cursor:=Cur;
        Ry.Preview;
      end;
  finally
    Screen.Cursor:=Cur;
    Ry.Free;
  end;
{$ENDIF}
end;

procedure TClassifyDlg.HelpBtnClick(Sender: TObject);
begin
  Application.HelpContext(140);
end;

end.
