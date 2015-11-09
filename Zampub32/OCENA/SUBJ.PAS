unit Subj;

interface

uses WinTypes, WinProcs, Classes, Graphics, Forms, Controls, Buttons,
  StdCtrls, ExtCtrls, Tabs, SysUtils, Spin, Grids, Dialogs, Printers,
  SiwzIni,
  Msg,
  Pwd,
  NewPwd,
  RPrev,
  ZpBoxes,
  AskOfrt,
  Utils,
  OfrtDta,
  Kriteria,
  Members;

const
  UMinS='minimalizacja - proporcjonalnie do najni¿szej wartoœci';
  UMaxS='maksymalizacja - proporcjonalnie do najwy¿szej wartoœci';
  UTakS='oferta spe³nia warunek';
  UNieS='oferta nie spe³nia warunku';

type
  TSubjDlg = class(TForm)
    OKBtn: TBitBtn;
    CancelBtn: TBitBtn;
    HelpBtn: TBitBtn;
    TabSet: TTabSet;
    Notebook: TNotebook;
    Panel1: TPanel;
    Panel: TPanel;
    Label7: TLabel;
    SE: TSpinEdit;
    Memo1: TMemo;
    SG: TStringGrid;
    Label1: TLabel;
    Label2: TLabel;
    NextBtn: TButton;
    ListBox1: TListBox;
    Label3: TLabel;
    Button1: TButton;
    ZP52Btn: TBitBtn;
    Memo2: TMemo;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure TabSetClick(Sender: TObject);
    procedure KriteriaSBChange(Sender: TObject);
    procedure ScrollBar1Scroll(Sender: TObject; ScrollCode: TScrollCode;
      var ScrollPos: Integer);
    procedure SEChange(Sender: TObject);
    procedure NextBtnClick(Sender: TObject);
    procedure SGClick(Sender: TObject);
    procedure PwdBtnClick(Sender: TObject);
    procedure LB0DoubleClick(Sender: TObject);
    procedure ZP52BtnClick(Sender: TObject);
    procedure Memo2Exit(Sender: TObject);
    procedure HelpBtnClick(Sender: TObject);
    procedure Memo2Change(Sender: TObject);
  private
    { Private declarations }
    PPos:Integer;
    procedure InitTabs;
    procedure SetPanel(Tender,Kryt:LongInt);
    procedure SetTopRow(Row:LongInt);
    procedure SetLeftCol(Col:LongInt);
    procedure SetNextCell;
    procedure SetCell(Col,Row:LongInt);
    function GetNextSubjKrit(x:LongInt):LongInt;
    procedure MakeMemberBox(Ry:TRyPrinter; TNum:Integer);
    procedure MakeTableHeadRect(Ry:TRyPrinter; var OLeft,ORight:Integer);
    procedure GetTendersToPrint(var FOfrt,LOfrt:Integer);
    function GetKritRectHeight(Ix,TNum:LongInt; Ry:TRyPrinter; OLeft,ORight:Integer):Integer;
    procedure AddKritRect(Ix,TNum:LongInt; Ry:TRyPrinter; OLeft,ORight:Integer);
  public
    { Public declarations }
    SubjModified:Boolean;
  end;

var
  SubjDlg: TSubjDlg;

implementation

{$R *.DFM}
uses
  Ocena1;

function TSubjDlg.GetNextSubjKrit(x:LongInt):LongInt;
var
  i,j:LongInt;
begin
  j:=0;
  i:=x+1;
  while (i <= KEvalModes.Count) and (j<>i) do
    begin
      if KEvalModes[i-1]=evSubjS
        then j:=i
        else Inc(i);
    end;
  Result:=j;
end;

procedure TSubjDlg.FormCreate(Sender: TObject);
var
  i,j:LongInt;
  cur:Integer;
begin
  cur:=Screen.Cursor;
  Screen.Cursor:=crHourGlass;
  InitTabs;
  for i:=1 to Notebook.Pages.Count do
    begin
      Notebook.PageIndex:=i{-1};
      j:=GetNextSubjKrit(0);
      if j>0
        then SetCell(j,1)
        else SetCell(1,1);
    end;
  Notebook.PageIndex:=0;
  Screen.Cursor:=cur;
  SubjModified:=FALSE;
end;

procedure TSubjDlg.InitTabs;
var
  i,j,k:LongInt;
  La:TLabel;
  SG:TStringGrid;
  Pa:TPanel;
  Me:TMemo;
  SE:TSpinEdit;
  Bt:TButton;
  LB:TListBox;
begin
  Notebook.Pages.Add(' Has³a ');
  Notebook.Pages.Delete(0);
  Notebook.PageIndex:=0;
  La:=TLabel.Create(Notebook);
  La.Parent:=TWinControl(Notebook.Pages.Objects[Notebook.PageIndex]);
  La.Name:='L1_0';
  La.Top:=16;
  La.Left:=128;
  La.Font:=Notebook.Font;
  La.Font.Size:=8;
  La.Caption:='Lista cz³onków komisji';
  LB:=TListBox.Create(Notebook);
  LB.Parent:=TWinControl(Notebook.Pages.Objects[Notebook.PageIndex]);
  LB.Name:='LB0';
  LB.Top:=32;
  LB.Left:=128;
  LB.Width:=353;
  LB.Height:=169;
  LB.Clear;
  for i:=0 to MSurnames.Count-1 do
    LB.Items.Add(MNames[i]+' '+MSurnames[i]);
  LB.OnDblClick:=LB0DoubleClick;
  Bt:=TButton.Create(Notebook);
  Bt.Parent:=TWinControl(Notebook.Pages.Objects[Notebook.PageIndex]);
  Bt.Name:='HB0';
  Bt.Top:=264;
  Bt.Left:=256;
  Bt.Height:=33;
  Bt.Width:=89;
  Bt.Caption:='Has³o';
  Bt.OnClick:=PwdBtnClick;

  for i:=1 to MSurnames.Count do
    begin
      Notebook.Pages.Add('  '+MNames[i-1][1]+'. '+MSurnames[i-1]);
      Notebook.PageIndex:=i;
      TWinControl(Notebook.Pages.Objects[Notebook.PageIndex]).Name:='NP'+IntToStr(Notebook.PageIndex);
{Member}
      La:=TLabel.Create(Notebook);
      La.Parent:=TWinControl(Notebook.Pages.Objects[Notebook.PageIndex]);
      La.Name:='Mbm'+IntToStr(Notebook.PageIndex{-1});
      La.Top:=4;
      La.Left:=8;
      La.Font:=Notebook.Font;
      La.Font.Size:=12;
      La.Caption:=MNames[i-1]+' '+MSurnames[i-1];
{StringGrid}
      SG:=TStringGrid.Create(Notebook);
      SG.Parent:=TWinControl(Notebook.Pages.Objects[Notebook.PageIndex]);
      SG.Name:='SG'+IntToStr(Notebook.PageIndex{-1});
      SG.Top:=24;
      SG.Left:=8;
      SG.Height:=120;
      SG.Width:=585;
      SG.ColCount:=8;
      SG.RowCount:=5;
      SG.Options:=SG.Options-[goRangeSelect];
      SG.FixedCols:=1;
      SG.FixedRows:=1;
      SG.RowCount:=2;
      SG.DefaultColWidth:=100;
      SG.OnClick:=SGClick;
      if TendersTot>SG.RowCount-1
        then SG.RowCount:=TendersTot+1;
      SG.ColCount:=2;
      if KDescs.Count>SG.ColCount-1
        then SG.ColCount:=KDescs.Count+1;
      for k:=1 to TendersTot do
        SG.Cells[0,k]:='Oferta '+IntToStr(k);
      for k:=1 to KDescs.Count do
        SG.Cells[k,0]:='Kryt. '+IntToStr(k);
      for k:=1 to TendersTot do
        for j:=1 to KDescs.Count do
          if (KEvalModes[j-1] = evMaxS) or
             (KEvalModes[j-1] = evMinS)
            then SG.Cells[j,k]:=FloatToStrF(GetOfferItem(i-1,k-1,j-1).Pts,ffGeneral,10,4)
          else if KEvalModes[j-1] = evYesNoS
            then begin
              if GetOfferItem(i-1,k-1,j-1).Pts=MaxPoints
                then SG.Cells[j,k]:='Tak'
                else SG.Cells[j,k]:='Nie';
            end
          else if KEvalModes[j-1] = evSubjS
            then SG.Cells[j,k]:=FloatToStr(GetOfferItem(i-1,k-1,j-1).Pts);
{Panel}
      Pa:=TPanel.Create(Notebook);
      Pa.Parent:=TWinControl(Notebook.Pages.Objects[Notebook.PageIndex]);
      Pa.Name:='NPanel'+IntToStr(Notebook.PageIndex{-1});
      Pa.Top:=152;
      Pa.Left:=8;
      Pa.Height:=217;
      Pa.Width:=585;
      Pa.Caption:='';
      Pa.BevelInner:=bvLowered;
      Pa.BevelOuter:=bvLowered;
{Oferta title}
      La:=TLabel.Create(Pa);
      La.Parent:=TWinControl(Pa);
      La.Name:='LO_'+IntToStr(Notebook.PageIndex{-1});
      La.Top:=4;
      La.Left:=8;
      La.Font.Size:=10;
{Krit. title}
      La:=TLabel.Create(Pa);
      La.Parent:=TWinControl(Pa);
      La.Name:='LT_'+IntToStr(Notebook.PageIndex{-1});
      La.Top:=4;
      La.Left:=192;
      La.Font.Size:=10;
{Memo1 title}
      La:=TLabel.Create(Pa);
      La.Parent:=TWinControl(Pa);
      La.Name:='LM1_'+IntToStr(Notebook.PageIndex{-1});
      La.Top:=24;
      La.Left:=8;
      La.Font.Size:=8;
      La.Caption:='Opis kryterium';
{Memo1}
      Me:=TMemo.Create(Pa);
      Me.Parent:=TWinControl(Pa);
      Me.Name:='ME1_'+IntToStr(Notebook.PageIndex{-1});
      Me.Top:=40;
      Me.Left:=8;
      Me.Height:=73;
      Me.Width:=569;
      Me.Enabled:=FALSE;
{SpinEdit title}
      La:=TLabel.Create(Pa);
      La.Parent:=TWinControl(Pa);
      La.Name:='LSE_'+IntToStr(Notebook.PageIndex{-1});
      La.Top:=120;
      La.Left:=144;
      La.Font.Size:=8;
      La.Caption:='Ocena';
{SpinEdit}
      SE:=TSpinEdit.Create(Pa);
      SE.Parent:=TWinControl(Pa);
      SE.Name:='SE_'+IntToStr(Notebook.PageIndex{-1});
      SE.Top:=136;
      SE.Left:=144;
      SE.Height:=30;
      SE.Width:=65;
      SE.MaxValue:=MaxPoints;
      SE.MinValue:=0;
      SE.MaxLength:=Length(IntToStr(MaxPoints));
      SE.Font.Size:=12;
      SE.Text:='0';
      SE.OnChange:=SEChange;
{Memo2 title}
      La:=TLabel.Create(Pa);
      La.Parent:=TWinControl(Pa);
      La.Name:='LM2_'+IntToStr(Notebook.PageIndex{-1});
      La.Top:=120;
      La.Left:=232;
      La.Font.Size:=8;
      La.Caption:='Uzasadnienie';
{Memo2}
      Me:=TMemo.Create(Pa);
      Me.Parent:=TWinControl(Pa);
      Me.Name:='ME2_'+IntToStr(Notebook.PageIndex{-1});
      Me.Top:=136;
      Me.Left:=232;
      Me.Height:=73;
      Me.Width:=345;
      Me.MaxLength:=255;
      Me.OnExit:=Memo2Exit;
{$IFDEF DEMO}
      Me.Enabled:=FALSE;
{$ENDIF}
{NextBtn}
      Bt:=TButton.Create(Pa);
      Bt.Parent:=TWinControl(Pa);
      Bt.Name:='NB_'+IntToStr(Notebook.PageIndex{-1});
      Bt.Top:=176;
      Bt.Left:=8;
      Bt.Height:=33;
      Bt.Width:=201;
      Bt.Caption:='Nastêpne kryterium indywidualne';
      Bt.OnClick:=NextBtnClick;
      Bt.Visible:=TRUE;
    end;
  Notebook.PageIndex:=0;
  TabSet.Tabs:=Notebook.Pages;
end;

procedure TSubjDlg.KriteriaSBChange(Sender: TObject);
var
  L:TLabel;
begin
  L:=TLabel(Notebook.FindComponent('KLabel'+IntToStr(Notebook.PageIndex)));
  L.Caption:=IntToStr(12);
end;

procedure TSubjDlg.ScrollBar1Scroll(Sender: TObject;
  ScrollCode: TScrollCode; var ScrollPos: Integer);
var
  L:TLabel;
begin
  L:=TLabel(Notebook.FindComponent('KLabel'+IntToStr(Notebook.PageIndex)));
  L.Caption:=IntToStr(12);
end;

procedure TSubjDlg.SetPanel(Tender,Kryt:LongInt);
var
  i:Byte;
  Dsc:String;
  EM:Byte;
  PIS:String[8];
{  KL:TKrLineArray;}
  Comp:TComponent;
  SE:TSpinEdit;
  Pnl:TPanel;
  La:TLabel;
  Bt:TButton;
  Me:TMemo;
  Sg:TStringGrid;
begin
  PIS:=IntToStr(Notebook.PageIndex);
  Dsc:=KDescs[Kryt-1];
  Comp:=Notebook.FindComponent('NPanel'+PIS);
  La:=TLabel(Comp.FindComponent('LO_'+PIS));
  Sg:=TStringGrid(Notebook.FindComponent('SG'+PIS));
  La.Caption:=TenderS+IntToStr(Sg.Row);
  EM:=EMStrToByte(KEvalModes[Kryt-1]);
  Me:=TMemo(Comp.FindComponent('ME1_'+PIS));
  Me.Clear;
  Me.Lines.Add(Dsc);
  Me:=TMemo(Comp.FindComponent('ME2_'+PIS));
  Me.Clear;
  case EM of
    evMin,
    evMax,
    evYesNo:
      begin
        La:=TLabel(Comp.FindComponent('LT_'+PIS));
        case EM of
          evMax:   La.Caption:=EvalModeStr+evMaxS;
          evMin:   La.Caption:=EvalModeStr+evMinS;
          evYesNo: La.Caption:=EvalModeStr+evYesNoS;
        end;{case}
        SE:=TSpinEdit(Comp.FindComponent('SE_'+PIS));
        SE.Visible:=FALSE;
      end;
    evSubj:
      begin
        La:=TLabel(Comp.FindComponent('LT_'+PIS));
        La.Caption:=TitleSubj2+IntToStr(SG.Col)+':';
        SE:=TSpinEdit(Comp.FindComponent('SE_'+PIS));
        SE.Visible:=TRUE;
        SE.Text:=IntToStr(Trunc(GetOfferItem(Notebook.PageIndex-1,Tender-1,Kryt-1).Pts));
        Me.SetTextBuf(GetOfferItem(Notebook.PageIndex-1,Tender-1,Kryt-1).Memo);
      end;
  end;{case}
end;

procedure TSubjDlg.SetTopRow(Row:LongInt);
var
  x:LongInt;
  SG:TStringGrid;
  PIS:String[10];
begin
  PIS:=IntToStr(Notebook.PageIndex);
  SG:=TStringGrid(Notebook.FindComponent('SG'+PIS));
  x:=SG.TopRow;
  if x-Row<-2
    then SG.TopRow:=Row-2
  else if x>Row
    then SG.TopRow:=Row;
end;

procedure TSubjDlg.SetLeftCol(Col:LongInt);
var
  x:LongInt;
  SG:TStringGrid;
  PIS:String[10];
begin
  PIS:=IntToStr(Notebook.PageIndex);
  SG:=TStringGrid(Notebook.FindComponent('SG'+PIS));
  x:=SG.LeftCol;
  if (x-Col)<-3
    then SG.LeftCol:=Col-3
  else if (x>Col)
    then SG.LeftCol:=Col;
end;

procedure TSubjDlg.SetNextCell;
var
  GR:TGridRect;
  j:LongInt;
  SG:TStringGrid;
  PIS:String[10];
begin
  PIS:=IntToStr(Notebook.PageIndex);
  SG:=TStringGrid(Notebook.FindComponent('SG'+PIS));
  GR:=SG.Selection;
  j:=GetNextSubjKrit(GR.Left);
  if j>0
    then SetCell(j,GR.Top)
  else if GR.Top<SG.RowCount-1
    then begin
      MessageDlg(imNextTender,mtInformation,[mbOk],0);
      Inc(GR.Top);
      Inc(GR.Bottom);
      j:=GetNextSubjKrit(0);
      if j>0
        then SetCell(j,GR.Top)
        else SetCell(1,GR.Top)
    end
  else MessageDlg(imLastCell,mtInformation,[mbOk],0);
end;

procedure TSubjDlg.SetCell(Col,Row:LongInt);
var
  GR:TGridRect;
  SG:TStringGrid;
  PIS:String[10];
begin
  PIS:=IntToStr(Notebook.PageIndex);
  SG:=TStringGrid(Notebook.FindComponent('SG'+PIS));
  GR.Left:=Col;
  GR.Right:=Col;
  GR.Top:=Row;
  GR.Bottom:=Row;
  SG.Selection:=GR;
  SetPanel(GR.Top,GR.Left);
  SetTopRow(GR.Top);
  SetLeftCol(GR.Left);
end;

procedure TSubjDlg.SEChange(Sender: TObject);
var
  SE:TSpinEdit;
  SG:TStringGrid;
  Comp:TComponent;
  PIS:String[10];
  i:Integer;
begin
  PIS:=IntToStr(Notebook.PageIndex);
  SG:=TStringGrid(Notebook.FindComponent('SG'+PIS));
  Comp:=Notebook.FindComponent('NPanel'+PIS);
  SE:=TSpinEdit(Comp.FindComponent('SE_'+PIS));
  if SE.Text=''
    then for i:=0 to Offers.Count-1 do
      begin
        if (TOfferItem(Offers.Items[i]^).KNum=SG.Selection.Left-1) and
           (TOfferItem(Offers.Items[i]^).ONum=SG.Selection.Top-1) and
           (TOfferItem(Offers.Items[i]^).MNum=Notebook.PageIndex-1)
          then TOfferItem(Offers.Items[i]^).Pts:=0;
      end
    else begin
      if StrToInt(SE.Text)>MaxPoints
        then begin
          MessageDlg(wmPointsOverMax,mtError,[mbOk],0);
          SE.Text:=IntToStr(MaxPoints);
        end;
      for i:=0 to Offers.Count-1 do
        begin
          if (TOfferItem(Offers.Items[i]^).KNum=SG.Selection.Left-1) and
             (TOfferItem(Offers.Items[i]^).ONum=SG.Selection.Top-1) and
             (TOfferItem(Offers.Items[i]^).MNum=Notebook.PageIndex-1)
            then TOfferItem(Offers.Items[i]^).Pts:=StrToInt(SE.Text);
        end
    end;
  SG.Cells[SG.Selection.Left,SG.Selection.Top]:=SE.Text;
  SubjModified:=TRUE;
end;

procedure TSubjDlg.Memo2Exit(Sender: TObject);
var
  Me:TMemo;
  SG:TStringGrid;
  Comp:TComponent;
  PIS:String[10];
  i:Integer;
begin
  PIS:=IntToStr(Notebook.PageIndex);
  SG:=TStringGrid(Notebook.FindComponent('SG'+PIS));
  Comp:=Notebook.FindComponent('NPanel'+PIS);
  Me:=TMemo(Comp.FindComponent('ME2_'+PIS));
  for i:=0 to Offers.Count-1 do
    begin
      if (TOfferItem(Offers.Items[i]^).KNum=SG.Selection.Left-1) and
         (TOfferItem(Offers.Items[i]^).ONum=SG.Selection.Top-1) and
         (TOfferItem(Offers.Items[i]^).MNum=Notebook.PageIndex-1)
        then begin
          StrDispose(TOfferItem(Offers.Items[i]^).Memo);
          TOfferItem(Offers.Items[i]^).Memo:=StrAlloc(Me.GetTextLen+1);
          Me.GetTextBuf(TOfferItem(Offers.Items[i]^).Memo,Me.GetTextLen+1);
        end;
    end

end;

procedure TSubjDlg.NextBtnClick(Sender: TObject);
begin
  SetNextCell;
end;

procedure TSubjDlg.SGClick(Sender: TObject);
var
  SG:TStringGrid;
  PIS:String[10];
begin
  PIS:=IntToStr(Notebook.PageIndex);
  SG:=TStringGrid(Notebook.FindComponent('SG'+PIS));
  SetPanel(SG.Selection.Top,SG.Selection.Left);
end;

procedure TSubjDlg.PwdBtnClick(Sender: TObject);
var
  LB:TListBox;
begin
  LB:=TListBox(Notebook.FindComponent('LB0'));
  if LB.ItemIndex>-1
    then begin
      if MPwds[LB.ItemIndex]<>''
        then begin
          PwdDlg:=TPwdDlg.Create(Nil);
          PwdDlg.Caption:='Has³o administratora';
          if PwdDlg.ShowModal=mrOk
            then begin
              if PwdDlg.PwdEdit.Text=MPwds[LB.ItemIndex]
                then GetNewPassword(LB.ItemIndex+1)
                else MessageDlg(wmIncorrectPwd,mtError,[mbOk],0);
            end;
          PwdDlg.Free;
        end
        else GetNewPassword(LB.ItemIndex+1);
    end;
end;

procedure TSubjDlg.LB0DoubleClick(Sender: TObject);
var
  LB:TListBox;
begin
  LB:=TListBox(Notebook.FindComponent('LB0'));
  TabSet.TabIndex:=LB.ItemIndex+1;
  TabSetClick(Sender);
end;

procedure TSubjDlg.TabSetClick(Sender: TObject);
begin
  if TabSet.TabIndex>0
    then begin
      if MPwds[TabSet.TabIndex-1]<>''
        then begin
          PwdDlg:=TPwdDlg.Create(Nil);
          if PwdDlg.ShowModal=mrOk
            then begin
              if PwdDlg.PwdEdit.Text{=}<>MPwds[TabSet.TabIndex-1]
                then begin
                  TabSet.TabIndex:=0;
                  MessageDlg(wmIncorrectPwd,mtError,[mbOk],0);
                end;
            end
            else TabSet.TabIndex:=0;
          PwdDlg.Free;
        end
    end;
  Notebook.PageIndex:=TabSet.TabIndex;
{  Zp52Btn.Enabled:=TabSet.TabIndex>0;}
end;

procedure TSubjDlg.MakeMemberBox(Ry:TRyPrinter; TNum:Integer);
var
  Rct:TRect;
  i:Integer;
begin
  with Ry do
    begin
      Rct.Left:=XLOff;
      Rct.Right:=XROff;
      Rct.Top:=PPos+Xmm(2);
      Rct.Bottom:=Rct.Top+Ymm(18);
      RoundRectangle(Rct);
      Font.Size:=10;
      TextOut(Rct.Left+Xmm(4),Rct.Top+Ymm(2),'Imiê i nazwisko cz³onka komisji przetargowej');
      i:=TabSet.TabIndex;
      Font.Size:=12;
      if i>0
        then TextOut(Rct.Left+Xmm(4),Rct.Top+Ymm(7),MNames[i-1]+' '+MSurnames[i-1])
        else TextOut(Rct.Left+Xmm(4),Rct.Top+Ymm(7),'____________________________   ____________________________________');
      Font.Size:=10;
      if (TNum>0)
        then TextOut(Rct.Left+Xmm(4),Rct.Bottom-Ymm(5),'Numer oferty   '+IntToStr(TNum))
        else TextOut(Rct.Left+Xmm(4),Rct.Bottom-Ymm(5),'Numer oferty   _______');
      PPos:=Rct.Bottom;
    end;
end;

procedure TSubjDlg.GetTendersToPrint(var FOfrt,LOfrt:Integer);
var
  SG:TStringGrid;
begin
    AskOfrtDlg:=TAskOfrtDlg.Create(Self);
    if AskOfrtDlg.ShowModal=mrOk
      then begin
        SG:=TStringGrid(Notebook.FindComponent('SG'+IntToStr(Notebook.PageIndex)));
        case AskOfrtDlg.RG.ItemIndex of
          0:begin
              FOfrt:=1;
              LOfrt:=SG.RowCount-1;
            end;
          1:begin
              FOfrt:=SG.Row;
              LOfrt:=SG.Row;
            end;
          2:begin
              FOfrt:=StrToInt(AskOfrtDlg.Edit1.Text);
              LOfrt:=StrToInt(AskOfrtDlg.Edit2.Text);
              if FOfrt>SG.RowCount-1
                then FOfrt:=SG.RowCount-1;
              if LOfrt>SG.RowCount
                then LOfrt:=SG.RowCount-1;
              if LOfrt<FOfrt
                then LOfrt:=FOfrt;
            end;
        end;{case}
      end
      else begin
        FOfrt:=0;
        LOfrt:=0;
      end;
    AskOfrtDlg.Free;
end;

procedure TSubjDlg.MakeTableHeadRect(Ry:TRyPrinter; var OLeft,ORight:Integer);
var
  Rct:TRect;
  i:Integer;
begin
  with Ry do
    begin
      OLeft:=(XROff-XLOff-Xmm(25))div 2 + XLOff;
      ORight:=OLeft+Xmm(25);
      Rct.Left:=XLOff;
      Rct.Right:=XROff;
      Rct.Top:=PPos+Xmm(2);
      Rct.Bottom:=Rct.Top+Ymm(7);
      Rectangle(Rct);
      Font.Size:=10;
      Line(Point(OLeft,Rct.Top),Point(OLeft,Rct.Bottom));
      Line(Point(ORight,Rct.Top),Point(ORight,Rct.Bottom));
      TextOutCenter(((OLeft-Rct.Left) div 2)+Rct.Left,Rct.Top+Ymm(2),'Opis kryterium');
      TextOutCenter(OLeft+Xmm(12.5),Rct.Top+Ymm(2),'Ocena');
      TextOutCenter(((XROff-ORight)div 2)+ORight,Rct.Top+Ymm(2),'Uzasadnienie');
      PPos:=Rct.Bottom;
    end;
end;

function TSubjDlg.GetKritRectHeight(Ix,TNum:LongInt; Ry:TRyPrinter; OLeft,ORight:Integer):Integer;
var
  s:String;
  x,
  y:Integer;
  SG:TStringGrid;
  OI:TOfferItem;
  EM:Byte;
begin
  with Ry do
    begin
      OI:=GetOfferItem(Notebook.PageIndex-1,TNum-1,Ix-1);
      SG:=TStringGrid(Notebook.FindComponent('SG'+IntToStr(Notebook.PageIndex)));
      s:=SG.Cells[KDCol,Ix];
      Font.Size:=10;
      x:=MemoOut(Rect(XLoff+Xmm(2),0,OLeft-Xmm(2),100),StringAsPChar(s),FALSE,TRUE);
      EM:=EMStrToByte(KEvalModes[Ix-1]);
      case EM of
        evMin: y:=MemoOut(Rect(ORight+Xmm(2),PPos+Ymm(4),XROff-Xmm(2),10),UMinS,FALSE,FALSE);
        evMax: y:=MemoOut(Rect(ORight+Xmm(2),PPos+Ymm(4),XROff-Xmm(2),10),UMaxS,FALSE,FALSE);
        evYesNo:if OI.Pts=0
                  then y:=MemoOut(Rect(ORight+Xmm(2),PPos+Ymm(4),XROff-Xmm(2),10),UNieS,FALSE,FALSE)
                  else y:=MemoOut(Rect(ORight+Xmm(2),PPos+Ymm(4),XROff-Xmm(2),10),UTakS,FALSE,FALSE);
        evSubj: y:=MemoOut(Rect(ORight+Xmm(2),PPos+Ymm(4),XROff-Xmm(2),10),OI.Memo,FALSE,FALSE);
      end;
      if x<y
        then x:=y;
      Result:=x+Ymm(4);
    end;
end;

procedure TSubjDlg.AddKritRect(Ix,TNum:LongInt; Ry:TRyPrinter; OLeft,ORight:Integer);
var
  s:String;
  x,y:Integer;
  SG:TStringGrid;
  OI:TOfferItem;
  EM:Byte;
begin
  with Ry do
    begin
      OI:=GetOfferItem(Notebook.PageIndex-1,TNum-1,Ix-1);
      SG:=TStringGrid(Notebook.FindComponent('SG'+IntToStr(Notebook.PageIndex)));
      s:=KDescs[Ix-1];
      Font.Size:=10;
      x:=MemoOut(Rect(XLoff+Xmm(2),PPos+Ymm(4),OLeft-Xmm(2),10),StringAsPChar(s),FALSE,FALSE);
      EM:=EMStrToByte(KEvalModes[Ix-1]);
      case EM of
        evMin: y:=MemoOut(Rect(ORight+Xmm(2),PPos+Ymm(4),XROff-Xmm(2),10),UMinS,FALSE,FALSE);
        evMax: y:=MemoOut(Rect(ORight+Xmm(2),PPos+Ymm(4),XROff-Xmm(2),10),UMaxS,FALSE,FALSE);
        evYesNo:if OI.Pts=0
                  then y:=MemoOut(Rect(ORight+Xmm(2),PPos+Ymm(4),XROff-Xmm(2),10),UNieS,FALSE,FALSE)
                  else y:=MemoOut(Rect(ORight+Xmm(2),PPos+Ymm(4),XROff-Xmm(2),10),UTakS,FALSE,FALSE);
        evSubj: y:=MemoOut(Rect(ORight+Xmm(2),PPos+Ymm(4),XROff-Xmm(2),10),OI.Memo,FALSE,FALSE);
      end;
      s:=FloatToStrF(OI.Eval,ffFixed,15,3);
      TextOutCenter(OLeft+Xmm(12.5),PPos+Ymm(4),s);
      if x<y
        then x:=y;
      x:=x+PPos;
      Line(Point(XLOff,PPos),Point(XLOff,x+Ymm(8)));
      Line(Point(XROff,PPos),Point(XROff,x+Ymm(8)));
      Line(Point(XLOff,x+Ymm(8)),Point(XROff,x+Ymm(8)));
      Line(Point(OLeft,PPos),Point(OLeft,x+Ymm(8)));
      Line(Point(ORight,PPos),Point(ORight,x+Ymm(8)));
      PPos:=x+Ymm(8);
    end;
end;

procedure TSubjDlg.ZP52BtnClick(Sender: TObject);
var
  Ry : TRyPrinter;
  p : PChar;
  Rect:TRect;
  Cur:Integer;
  x,i:LongInt;
  FullPage:Boolean;
  PrintSpace:Integer;
  TFrom,
  TTo,
  TNum:Integer;
  SG:TStringGrid;
  OLeft,
  ORight:Integer;
  xx:Byte;
  s:String;
begin
{$IFDEF DEMO}
  MessageDlg('Nie dostêpne w wersji DEMO',mtWarning,[mbOk],0);
{$ELSE}
  if TabSet.TabIndex>0
    then GetTendersToPrint(TFrom,TTo)
    else begin
      TFrom:=0;
      TTo:=0;
    end;
  try
    Cur:=Screen.Cursor;
    Screen.Cursor:=crHourGlass;
    Printer.Free;
    Printer:=TPrinter.Create;
    Printer.Orientation:=poPortrait;
    Ry := TRyPrinter.Create;
    for i:= 0 to KDescs.Count-1 do
      EvaluateKriterium(i);
    with Ry do
      begin
        Orientation:=poPortrait;
        NewJob;
        SetMinMargins(Xmm(20),Ymm(10),Xmm(20),Ymm(10));
        TNum:=TFrom;
        SG:=TStringGrid(Notebook.FindComponent('SG'+IntToStr(Notebook.PageIndex)));
        repeat
          x:=1;
          if TabSet.TabIndex>0
            then repeat
              MakeHeader(Ry,'Karta indywidualnej oceny oferty','52','','',PPos);
              PrintSpace:=YBOff-Ymm(35);
              MakeFooter(Ry,PrintSpace);
              MakeSecretBox(Ry,PPos);
              MakeMemberBox(Ry,TNum);
              MakeTableHeadRect(Ry,OLeft,ORight);
              FullPage:=False;
              while (x<SG.ColCount) and not FullPage do
                begin
                  FullPage:=(PPos+GetKritRectHeight(x,TNum,Ry,OLeft,ORight))>PrintSpace;
                  if not FullPage
                    then begin
                      AddKritRect(x,TNum,Ry,OLeft,ORight);
                      Inc(x);
                    end;
                end;
              if FullPage
                then NewPage;
            until x>=SG.ColCount
            else begin
              MakeHeader(Ry,'Karta indywidualnej oceny oferty','52','','',PPos);
              PrintSpace:=YBOff-Ymm(35);
              MakeFooter(Ry,PrintSpace);
              MakeSecretBox(Ry,PPos);
              MakeMemberBox(Ry,TNum);
              MakeTableHeadRect(Ry,OLeft,ORight);
            end;
          if TNum<TTo
            then NewPage;
          Inc(TNum);
        until TNum>TTo;
        Screen.Cursor:=Cur;
        Ry.Preview;
      end;
  finally
    Screen.Cursor:=Cur;
    Ry.Free;
  end;
{$ENDIF}
end;

procedure TSubjDlg.HelpBtnClick(Sender: TObject);
begin
  Application.HelpContext(131);
end;

procedure TSubjDlg.Memo2Change(Sender: TObject);
begin
  SubjModified:=TRUE;
end;

end.
