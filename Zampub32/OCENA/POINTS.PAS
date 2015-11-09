unit Points;

interface

uses WinTypes, WinProcs, Classes, Graphics, Forms, Controls, Buttons,
  StdCtrls, ExtCtrls, Grids, SysUtils, Dialogs,
  Msg,
  Subj,
  Kriteria,
  Members,
  OfrtDta;

type
  TPointsDlg = class(TForm)
    OKBtn: TBitBtn;
    CancelBtn: TBitBtn;
    HelpBtn: TBitBtn;
    Bevel1: TBevel;
    SG: TStringGrid;
    Panel1: TPanel;
    KritMemo: TMemo;
    Label1: TLabel;
    NextBtn: TButton;
    NumEdit: TEdit;
    Label2: TLabel;
    YesBtn: TButton;
    NoBtn: TButton;
    Label3: TLabel;
    SubjBtn: TButton;
    CB: TCheckBox;
    procedure NumEditKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure NextBtnClick(Sender: TObject);
    procedure NumEditChange(Sender: TObject);
    procedure YesBtnClick(Sender: TObject);
    procedure NoBtnClick(Sender: TObject);
    procedure SGClick(Sender: TObject);
    procedure SubjBtnClick(Sender: TObject);
    procedure CBClick(Sender: TObject);
    procedure HelpBtnClick(Sender: TObject);
  private
    { Private declarations }
    procedure Init;
    procedure SetPanel(CurTender,CurKrit:LongInt);
    procedure SetCell(Col,Row:LongInt);
    procedure SetNextCell;
    procedure SetTopRow(Row:LongInt);
    procedure SetLeftCol(Col:LongInt);
  public
    { Public declarations }
    UzasadList:TStringList;
    PointModified:Boolean;
  end;

var
  PointsDlg: TPointsDlg;

implementation

{$R *.DFM}

procedure TPointsDlg.NumEditKeyPress(Sender: TObject; var Key: Char);
begin
  if not (Key in ['0'..'9',#8,',','.'])
    then Key:=#0;
  if Key=','
    then Key:='.';
  if (NumEdit.Text='') and (Key='.')
    then Key:=#0;
end;

procedure TPointsDlg.Init;
var
  GR:TGridRect;
  i,j:LongInt;
begin
  CB.Visible:=FALSE;
  SG.RowCount:=2;
  SG.ColWidths[0]:=64;
  if TendersTot>SG.RowCount-1
    then SG.RowCount:=TendersTot+1;
  SG.ColCount:=2;
  if KDescs.Count>SG.ColCount-1
    then SG.ColCount:=KDescs.Count+1;
  for i:=1 to TendersTot do
    SG.Cells[0,i]:='Oferta '+IntToStr(i);
  for i:=1 to KDescs.Count do
    SG.Cells[i,0]:='Kryterium '+IntToStr(i);
  for i:=1 to TendersTot do
    for j:=1 to KDescs.Count do
      if KEvalModes.Strings[j-1]=evSubjS
        then SG.Cells[j,i]:=evSubjS
        else SG.Cells[j,i]:=FloatToStrF(GetOfferItem(0,i-1,j-1).Pts,ffGeneral,10,4);
  SetCell(1,1);
end;

procedure TPointsDlg.FormCreate(Sender: TObject);
begin
  Init;
end;

procedure TPointsDlg.SetPanel(CurTender,CurKrit:LongInt);
var
  EM:Byte;
begin
  KritMemo.Clear;
  KritMemo.Lines.Add(KDescs.Strings[CurKrit-1]);
  Label3.Caption:=TenderS+IntToStr(CurTender);
  EM:=EMStrToByte(KEvalModes.Strings[CurKrit-1]);
  case EM of
    evMin,
    evMax:
      begin
        Label1.Caption:=TitleMaxMin;
        case EM of
          evMax: Label2.Caption:=EvalModeStr+evMaxS;
          evMin:
            begin
              Label2.Caption:=EvalModeStr+evMinS;
              CB.Visible:=CurKrit=ValueIndex;
              CB.Enabled:=PrefKrajowe;
              if CB.Visible and CB.Enabled
                then CB.Checked:=GetOfferItem(0,CurTender-1,CurKrit-1).PreKra;
            end;{evMin}
        end;{case}
        NumEdit.Visible:=TRUE;
        NumEdit.Text:=SG.Cells[CurKrit,CurTender];
        YesBtn.Visible:=FALSE;
        NoBtn.Visible:=FALSE;
        ActiveControl:=NumEdit;
      end;
    evYesNo:
      begin
        Label1.Caption:=TitleYesNo;
        Label2.Caption:=EvalModeStr+evYesNoS;
        NumEdit.Visible:=FALSE;
        YesBtn.Visible:=TRUE;
        NoBtn.Visible:=TRUE;
      end;
    evSubj:
      begin
        Label1.Caption:=TitleSubj1;
        Label2.Caption:=EvalModeStr+evSubjS;
        NumEdit.Visible:=FALSE;
        YesBtn.Visible:=FALSE;
        NoBtn.Visible:=FALSE;
      end;
  end;{case}
end;

procedure TPointsDlg.SetTopRow(Row:LongInt);
var
  x:LongInt;
begin
  x:=SG.TopRow;
  if x-Row<-2
    then SG.TopRow:=Row-2
  else if x>Row
    then SG.TopRow:=Row;
end;

procedure TPointsDlg.SetLeftCol(Col:LongInt);
var
  x:LongInt;
begin
  x:=SG.LeftCol;
  if (x-Col)<-3
    then SG.LeftCol:=Col-3
  else if (x>Col)
    then SG.LeftCol:=Col;
end;

procedure TPointsDlg.SetNextCell;
var
  GR:TGridRect;
begin
  GR:=SG.Selection;
  if GR.Left<SG.ColCount-1
    then begin
      SetCell(GR.Left+1,GR.Top);
    end
  else if GR.Top<SG.RowCount-1
    then begin
      MessageDlg(imNextTender,mtInformation,[mbOk],0);
      SetCell(1,GR.Top+1);
    end
  else MessageDlg(imLastCell,mtInformation,[mbOk],0);
end;

procedure TPointsDlg.SetCell(Col,Row:LongInt);
var
  GR:TGridRect;
begin
  GR.Left:=Col;
  GR.Right:=Col;
  GR.Top:=Row;
  GR.Bottom:=Row;
  SG.Selection:=GR;
  SetPanel(GR.Top,GR.Left);
  SetTopRow(GR.Top);
  SetLeftCol(GR.Left);
end;

procedure TPointsDlg.NextBtnClick(Sender: TObject);
begin
  SetNextCell;
end;

procedure TPointsDlg.NumEditChange(Sender: TObject);
var
  GR:TGridRect;
  i:LongInt;
  r:Real;
  c:Integer;
  OI:TOfferItem;
begin
  Val(NumEdit.Text,r,c);
  if c=0
    then begin
      GR:=SG.Selection;
      SG.Cells[GR.Left,GR.Top]:=NumEdit.Text;
      if NumEdit.Text<>''
        then for i:=0 to Offers.Count-1 do
          begin
            if (TOfferItem(Offers.Items[i]^).KNum=GR.Left-1) and
               (TOfferItem(Offers.Items[i]^).ONum=GR.Top-1)
              then TOfferItem(Offers.Items[i]^).Pts:=r;
          end;
      PointModified:=TRUE;
    end;
end;

procedure TPointsDlg.YesBtnClick(Sender: TObject);
var
  GR:TGridRect;
  i:LongInt;
begin
  GR:=SG.Selection;
  SG.Cells[GR.Left,GR.Top]:=InttoStr(MaxPoints);
  for i:=0 to Offers.Count-1 do
    begin
      if (TOfferItem(Offers.Items[i]^).KNum=GR.Left-1) and
         (TOfferItem(Offers.Items[i]^).ONum=GR.Top-1)
        then TOfferItem(Offers.Items[i]^).Pts:=MaxPoints;
    end;
  PointModified:=TRUE;
end;

procedure TPointsDlg.NoBtnClick(Sender: TObject);
var
  GR:TGridRect;
  i:LongInt;
begin
  GR:=SG.Selection;
  SG.Cells[GR.Left,GR.Top]:='0';
  for i:=0 to Offers.Count-1 do
    begin
      if (TOfferItem(Offers.Items[i]^).KNum=GR.Left-1) and
         (TOfferItem(Offers.Items[i]^).ONum=GR.Top-1)
        then TOfferItem(Offers.Items[i]^).Pts:=0;
    end;
  PointModified:=TRUE;
end;

procedure TPointsDlg.SGClick(Sender: TObject);
begin
  SetCell(SG.Selection.Left,SG.Selection.Top);
end;

procedure TPointsDlg.SubjBtnClick(Sender: TObject);
var
  Pa:TPanel;
  Me:TMemo;
begin
  SubjDlg:=TSubjDlg.Create(Self);
  SubjDlg.ShowModal;
  PointModified:=SubjDlg.SubjModified;
  SubjDlg.Free;
end;

procedure TPointsDlg.CBClick(Sender: TObject);
var
  GR:TGridRect;
  i:LongInt;
begin
  GR:=SG.Selection;
  for i:=0 to Offers.Count-1 do
    begin
      if (TOfferItem(Offers.Items[i]^).KNum=GR.Left-1) and
         (TOfferItem(Offers.Items[i]^).ONum=GR.Top-1)
        then TOfferItem(Offers.Items[i]^).PreKra:=CB.Checked;
    end
end;

procedure TPointsDlg.HelpBtnClick(Sender: TObject);
begin
  Application.HelpContext(130);
end;

end.
