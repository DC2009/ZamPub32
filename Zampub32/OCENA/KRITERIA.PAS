unit Kriteria;

interface

uses WinTypes, WinProcs, Classes, Graphics, Forms, Controls, Buttons,
  StdCtrls, Mask, Grids, ExtCtrls, Dialogs, Messages, Printers,
  SiwzIni,
  ZpBoxes,
  KritEdit,
  RPrev,
  UserUnit,
  Price,
  SkOk,
  Sk;

const
{columns}
  MaxCol=2; {Leftmost column}
  KCCol=0;   {cena}
  KWCol=1;   {waga}
  KECol=2;   {evaluation mode}
  KDCol=3;   {Description}

type
  TKriteriaDlg = class(TForm)
    OKBtn: TBitBtn;
    HelpBtn: TBitBtn;
    KSG: TStringGrid;
    ZP51Btn: TBitBtn;
    Panel1: TPanel;
    AddBtn: TButton;
    EditBtn: TButton;
    DeleteBtn: TButton;
    CancelBtn: TBitBtn;
    Sk: TSmartKey;
    PrefKrajBtn: TButton;
    procedure AddBtnClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure DeleteBtnClick(Sender: TObject);
    procedure EditBtnClick(Sender: TObject);
    procedure MaxPointsEditKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure OKBtnClick(Sender: TObject);
    procedure KSGClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure ZP51BtnClick(Sender: TObject);
    procedure PrefKrajBtnClick(Sender: TObject);
  private
    { Private declarations }
    KritModified:Boolean;
    procedure SetTopRow(Row:LongInt);
    function StringGridDescFind(Desc:String):Boolean;
    function CheckSum:Integer;
    function WeightsOk(New:Integer):Boolean;
    {existing weights + new one less than 100}
    function TotalWeight:Integer;
    {sum of existing weights}
    procedure MakeKritHeadRect(Ry:TRyPrinter; var PPos:Integer);
    procedure AddKritRect(Ix:LongInt; Ry:TRyPrinter; var PPos:Integer);
    function GetKritRectHeight(Ix:LongInt; Ry:TRyPrinter):Integer;
  public
    { Public declarations }
    PrefKraj:Boolean;
    EditPos:LongInt;      {line to edit}
    PrintSpace:Integer;
  end;

var
  KriteriaDlg: TKriteriaDlg;

implementation

{$R *.DFM}

uses
  SysUtils,
  Utils,
  OfrtDta,
  Msg;

procedure TKriteriaDlg.FormCreate(Sender: TObject);
var
  i:LongInt;
  j:Byte;
begin
  PrefKraj:=PrefKrajowe;
  KSG.ColWidths[KDCol]:=1000;
  KSG.ColWidths[KECol]:=100;
  KSG.ColWidths[KCCol]:=20;
  KSG.Cells[KCCol,0]:='PK';
  KSG.Cells[KWCol,0]:='Waga';
  KSG.Cells[KDCol,0]:='Opis';
  KSG.Cells[KECol,0]:='Sposób';
  KSG.RowCount:=2;
  DeleteBtn.Enabled:=KSG.RowCount>1;
  EditBtn.Enabled:=KSG.RowCount>1;
  KritModified:=FALSE;
end;

procedure TKriteriaDlg.FormActivate(Sender: TObject);
begin
  EditPos:=-1;
  KSG.TopRow:=1;
end;


function TKriteriaDlg.StringGridDescFind(Desc:String):Boolean;
var
  Found:Boolean;
  i:LongInt;
begin
  Found:=FALSE;
  i:=1;
  while (i<=KSG.RowCount) and not Found do
    begin
      Found:=(AnsiCompareText(Desc,KSG.Cells[KDCol,i])=0) and
             (i<>EditPos);
      Inc(i);
    end;
  Result:=Found;
end;

function TKriteriaDlg.CheckSum:Integer;
var
  a:String;
  s:Byte;
  x:Byte;
  c:Integer;
  i:LongInt;
begin
  s:=0;
  for i:=1 to KSG.RowCount do
    begin
      a:=KSG.Cells[KWCol,i];
      Val(a,x,c);
      if c=0
        then s:=s+x;
    end;
  Result:=s;
end;

procedure TKriteriaDlg.SetTopRow(Row:LongInt);
var
  x:LongInt;
begin
  x:=KSG.TopRow;
  if x-Row<-6
    then KSG.TopRow:=Row-6
  else if x>Row
    then KSG.TopRow:=Row;
end;

function TKriteriaDlg.WeightsOk(New:Integer):Boolean;
var
  x:LongInt;
begin
  x:=CheckSum;
  if EditPos>-1
    then x:=x-StrToInt(KSG.Cells[KWCol,KSG.Row]);
  x:=x+New;
  Result:=x<=100;
end;

function TKriteriaDlg.TotalWeight:Integer;
var
 x,i:Integer;
begin
  x:=0;
  for i:=1 to KSG.RowCount-1 do
    if KSG.Cells[KWCol,i]<>''
      then x:=x+StrToInt(KSG.Cells[KWCol,i]);
  Result:=x;
end;

procedure TKriteriaDlg.AddBtnClick(Sender: TObject);
var
  GR:TGridRect;
begin
  KritEditDlg:=TKritEditDlg.Create(Self);
  with KritEditDlg do
    begin
      if (KSG.RowCount=2) and (KSG.Cells[KWCol,1]='')
        then Label9.Caption:='0'
        else Label9.Caption:=IntToStr(KSG.RowCount-1);
      Label10.Caption:=IntToStr(TotalWeight);
(*      if not StringGridDescFind(CenaStr)
        then begin
          KritEval:=evMin; {must stay before DescEdit}
          EditCena('');
        end
        else begin
          SetQuestions(1);
          Panel1.Visible:=FALSE;
        end;*)
    end;
  if KritEditDlg.ShowModal=mrOk
    then begin
      if StringGridDescFind(KritEditDlg.KritCB.Text)
        then MessageDlg(wmDescAlreadyPresent,mtWarning,[mbOk],0)
      else if not WeightsOk(StrToInt(KritEditDlg.WagaEdit.Text))
        then MessageDlg(wmWeightsSumOver100,mtWarning,[mbOk],0)
      else begin
        if (KSG.RowCount>2) or (KSG.Cells[KDCol,1]<>'')
          then KSG.RowCount:=KSG.RowCount+1;
        GR.Top:=KSG.RowCount-1;
        GR.Bottom:=KSG.RowCount-1;
        GR.Left:=0;
        GR.Right:=MaxCol;
        KSG.Cells[KWCol,GR.Top]:=KritEditDlg.WagaEdit.Text;
        KSG.Cells[KDCol,GR.Top]:=KritEditDlg.KritCB.Text;
        KSG.Cells[KECol,GR.Top]:=evArray[KritEditDlg.EvalRG.ItemIndex+1];
        SetTopRow(GR.Top);
      end;
      KritModified:=TRUE;
    end;
  KritEditDlg.Free;
end;

procedure TKriteriaDlg.DeleteBtnClick(Sender: TObject);
var
  i:LongInt;
begin
  if KSG.Row<KSG.RowCount
    then for i :=KSG.Row to KSG.RowCount-1 do
      KSG.Rows[i]:=KSG.Rows[i+1];
  KSG.Cells[KWCol,KSG.RowCount]:='';
  KSG.Cells[KDCol,KSG.RowCount]:='';
  if KSG.RowCount>2
    then KSG.RowCount:=KSG.RowCount-1;
  KritModified:=TRUE;
end;

procedure TKriteriaDlg.EditBtnClick(Sender: TObject);
begin
  KritEditDlg:=TKritEditDlg.Create(Self);
  with KritEditDlg do
    begin
      Label9.Caption:=IntToStr(KSG.RowCount-1);
      Label10.Caption:=IntToStr(TotalWeight-StrToInt(KSG.Cells[KWCol,KSG.Row]));
      EditPos:=KSG.Row;
      KritCB.Text:=KSG.Cells[KDCol,KSG.Row];
      WagaEdit.Text:=KSG.Cells[KWCol,KSG.Row];
      if KSG.Cells[KECol,KSG.Row]=evMaxS
        then EvalRG.ItemIndex:=0;
      if KSG.Cells[KECol,KSG.Row]=evMinS
        then EvalRG.ItemIndex:=1;
      if KSG.Cells[KECol,KSG.Row]=evYesNoS
        then EvalRG.ItemIndex:=2;
      if KSG.Cells[KECol,KSG.Row]=evSubjS
        then EvalRG.ItemIndex:=3;
      if ShowModal=mrOk
        then begin
          if StringGridDescFind(KritCB.Text)
            then MessageDlg(wmDescAlreadyPresent,mtWarning,[mbOk],0)
          else if not WeightsOk(StrToInt(WagaEdit.Text))
            then MessageDlg(wmWeightsSumOver100,mtWarning,[mbOk],0)
          else begin
            KSG.Cells[KWCol,EditPos]:=KritEditDlg.WagaEdit.Text;
            KSG.Cells[KDCol,EditPos]:=KritEditDlg.KritCB.Text;
            KSG.Cells[KECol,EditPos]:=evArray[KritEditDlg.EvalRG.ItemIndex+1];
            if KSG.Cells[KECol,EditPos]<>evArray[evMin]
              then KSG.Cells[KCCol,EditPos]:='';
            SetTopRow(KSG.Row);
          end;
          KritModified:=TRUE;
        end;
      Free;
    end;
  EditPos:=-1;
end;

procedure TKriteriaDlg.MaxPointsEditKeyPress(Sender: TObject;
  var Key: Char);
begin
  if not (Key in ['0'..'9',#8])
    then Key:=#0
end;

procedure TKriteriaDlg.OKBtnClick(Sender: TObject);
begin
  if CheckSum>100
    then begin
      MessageDlg(wmWeightsSumOver100,mtWarning,[mbOk],0);
      ModalResult:=0;
    end
  else if CheckSum<100
    then begin
      if MessageDlg(wmWeightsSumUnder100+#13+wmConfirmExit,mtWarning,[mbYes,mbNo],0)=mrYes
        then ModalResult:=mrOk
        else ModalResult:=0;
    end
{  else if not KritModified
    then ModalResult:=mrCancel}
  else ModalResult:=mrOk;
end;

procedure TKriteriaDlg.KSGClick(Sender: TObject);
begin
  EditBtn.Enabled:=KSG.Selection.Top>0;
  DeleteBtn.Enabled:=KSG.Selection.Top>0;
end;

procedure TKriteriaDlg.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key=#13
    then begin
      Key:=#0;
      Perform(wm_NextDlgCtl,0,0);
    end;
end;

procedure TKriteriaDlg.MakeKritHeadRect(Ry:TRyPrinter; var PPos:Integer);
var
  Rect:TRect;
  Pt1,Pt2:TPoint;
  p:Byte;
  s:String;
begin
  with Ry do
    begin
      with Rect do
        begin
          Left:=XLOff;
          Top:=PPos+Xmm(4);
          Right:=XROff;
          Bottom:=Rect.Top+Ymm(11);
          Line(Point(Left,Top),Point(Right,Top));
          Line(Point(Left,Top),Point(Left,Bottom));
          Line(Point(Left,Bottom),Point(Right,Bottom));
          Line(Point(Right,Top),Point(Right,Bottom));
        end;
      Font.Size:=10;
      TextOut(Rect.Left+Xmm(3),Rect.Top+Xmm(2),'l.p.');
      TextOut(Rect.Left+Xmm(59),Rect.Top+Xmm(2),'Opis kryteriów oceny');
      TextOut(Rect.Right-Xmm(20),Rect.Top+Xmm(2),'Znaczenie');
      Pt1.X:=Rect.Left+Xmm(10);
      Pt1.Y:=Rect.Top;
      Pt2.X:=Rect.Left+Xmm(10);
      Pt2.Y:=Rect.Bottom;
      Line(Pt1,Pt2);
      Pt1.X:=Rect.Right-Xmm(27);
      Pt1.Y:=Rect.Top;
      Pt2.X:=Rect.Right-Xmm(27);
      Pt2.Y:=Rect.Bottom;
      Line(Pt1,Pt2);
      PPos:=Rect.Bottom;
    end;
end;

procedure TKriteriaDlg.AddKritRect(Ix:LongInt; Ry:TRyPrinter; var PPos:Integer);
var
  Rect:TRect;
  Pt1,Pt2:TPoint;
  p:Byte;
  s:String;
  x:Integer;
begin
  with Ry do
    begin
      PPos:=PPos-2;
      Rect.Left:=XLOff+Xmm(12);
      Rect.Top:=PPos+Ymm(4);
      Rect.Right:=XROff-Xmm(29);
      Rect.Bottom:=Rect.Top+Ymm(12);
      s:=KSG.Cells[KDCol,Ix];
      Font.Size:=10;
      TextOut(XLoff+Xmm(2),PPos+Ymm(4),IntToStr(Ix));
      x:=MemoOut(Rect,StringAsPChar(s),FALSE,FALSE);
      s:=KSG.Cells[KWCol,Ix]+' %';
      TextOut(XROff-Xmm(18),PPos+Ymm(4),s);
      with Rect do
        begin
          Left:=XLOff;
          Top:=PPos;
          Right:=XROff;
          Bottom:=Rect.Top+Ymm(8)+x;
          Line(Point(Left,Top),Point(Left,Bottom));
          Line(Point(Left,Bottom),Point(Right,Bottom));
          Line(Point(Right,Top),Point(Right,Bottom));
          Pt1.X:=Left+Xmm(10);
          Pt1.Y:=Top;
          Pt2.X:=Left+Xmm(10);
          Pt2.Y:=Bottom;
          Line(Pt1,Pt2);
          Pt1.X:=Right-Xmm(27);
          Pt1.Y:=Top;
          Pt2.X:=Right-Xmm(27);
          Pt2.Y:=Bottom;
          Line(Pt1,Pt2);
          PPos:=Bottom;
        end;
    end;
end;

function TKriteriaDlg.GetKritRectHeight(Ix:LongInt; Ry:TRyPrinter):Integer;
var
  s:String;
  x:Integer;
begin
  with Ry do
    begin
      s:=KSG.Cells[KDCol,Ix];
      Font.Size:=10;
      x:=MemoOut(Rect(XLOff+Xmm(12),0,XROff-Xmm(29),100),StringAsPChar(s),FALSE,TRUE);
      Result:=x+Ymm(8);
    end;
end;

procedure TKriteriaDlg.ZP51BtnClick(Sender: TObject);
var
  Ry : TRyPrinter;
  p : PChar;
  PPos:Integer;
  Rect:TRect;
  Cur:Integer;
  x:LongInt;
  FullPage:Boolean;
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
    Printer.Orientation:=poPortrait;
    Ry := TRyPrinter.Create;
    with Ry do
      begin
        Orientation:=poPortrait;
        NewJob;
        SetMinMargins(Xmm(20),Ymm(10),Xmm(20),Ymm(10));
        x:=1;
        repeat
          MakeHeader(Ry,'Kryteria oceny ofert i ich znaczenie','51','','',PPos);
          MakeKritHeadRect(Ry,PPos);
          PrintSpace:=YBOff-Ymm(35);
          MakeFooter(Ry,PrintSpace);
          FullPage:=False;
          while (x<KSG.RowCount) and not FullPage do
            begin
              FullPage:=(PPos+GetKritRectHeight(x,Ry))>PrintSpace;
              if not FullPage
                then begin
                  AddKritRect(x,Ry,PPos);
                  Inc(x);
                end;
            end;
          if FullPage
            then NewPage;
        until x>=KSG.RowCount;
        Screen.Cursor:=Cur;
        Ry.Preview;
      end;
  finally
    Screen.Cursor:=Cur;
    Ry.Free;
  end;
{$ENDIF}
end;

procedure TKriteriaDlg.PrefKrajBtnClick(Sender: TObject);
var
  PK:TPriceMarkDlg;
  j:Integer;
begin
  PK:=TPriceMarkDlg.Create(Self);
  if (KSG.RowCount>1)
    then for j:=1 to KSG.RowCount-1 do
      if KSG.Cells[KECol,j]=evArray[evMin]
        then PK.KritLB.Items.Add(KSG.Cells[KDCol,j]);
  if PK.ShowModal=mrOk
    then begin
      if(KSG.RowCount>1) {clear all +}
        then for j:=1 to KSG.RowCount-1 do
          KSG.Cells[KCCol,j]:='';
      if (PK.KritLB.ItemIndex>-1)  {set + in the right position}
        then for j:=1 to KSG.RowCount-1 do
          if KSG.Cells[KDCol,j]=PK.KritLB.Items[PK.KritLB.ItemIndex]
            then begin
              KSG.Cells[KCCol,j]:=' +';
              KritModified:=TRUE;
            end;
    end;
  PK.Free;
end;

end.
