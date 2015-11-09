unit Zp140;

interface

uses WinTypes, WinProcs, Classes, Graphics, Forms, Controls, Buttons,
  StdCtrls, ExtCtrls, Mask, TabNotBk, Grids, Spin, SysUtils,
  Messages, Dialogs, Printers,
  SiwzIni,
  PrtRecIo,
  UserUnit,
  Utils,
  ZpBoxes,
  SkOk,
  RPrev, Esgrid, Timeedit, IntDate, NumInp, Sk;

type
  TZp140Dlg = class(TForm)
    ScrollBox1: TScrollBox;
    Panel1: TPanel;
    Label1_19: TLabel;
    Label1_15: TLabel;
    Label1_14: TLabel;
    Label1_13: TLabel;
    Label1_4: TLabel;
    Label1_3: TLabel;
    Label1_8: TLabel;
    Label1_7: TLabel;
    Label1_1: TLabel;
    Bevel1: TBevel;
    Label1: TLabel;
    Label1_9: TLabel;
    NipGB1: TGroupBox;
    RB1_21: TRadioButton;
    RB1_22: TRadioButton;
    MaskEdit1_25: TMaskEdit;
    MaskEdit1_24: TMaskEdit;
    MaskEdit1_20: TMaskEdit;
    Edit1_16: TEdit;
    Edit1_17: TEdit;
    Edit1_18: TEdit;
    Edit1_5: TEdit;
    MaskEdit1_6: TMaskEdit;
    Edit1_10: TEdit;
    Edit1_11: TEdit;
    Memo1_2: TMemo;
    Panel11: TPanel;
    Panel6: TPanel;
    Bevel4: TBevel;
    Label6: TLabel;
    Label6_1: TLabel;
    Panel12: TPanel;
    OKBtn: TBitBtn;
    CancelBtn: TBitBtn;
    PrintBtn: TBitBtn;
    PreviewBtn: TBitBtn;
    OpenBtn: TBitBtn;
    SaveBtn: TBitBtn;
    HelpBtn: TBitBtn;
    SiwzBtn: TBitBtn;
    OpenDialog: TOpenDialog;
    SaveDialog: TSaveDialog;
    Edit1_12: TEdit;
    SG6_2: TEnhStringGrid;
    AddBtn: TButton;
    InsertBtn: TButton;
    DelBtn: TButton;
    Label29: TLabel;
    NumEdit: TEdit;
    Panel2: TPanel;
    Bevel2: TBevel;
    Label2: TLabel;
    Label2_1: TLabel;
    Label2_13: TLabel;
    Label2_3: TLabel;
    Label2_5: TLabel;
    Label2_9: TLabel;
    Label2_11: TLabel;
    Memo2_2: TMemo;
    Edit2_14: TEdit;
    Edit2_4: TEdit;
    RB2_6: TRadioButton;
    RB2_7: TRadioButton;
    RB2_8: TRadioButton;
    Edit2_10: TEdit;
    MaskEdit2_12: TMaskEdit;
    Panel3: TPanel;
    Bevel5: TBevel;
    Label3: TLabel;
    Label3_1: TLabel;
    Label3_3: TLabel;
    CB3_2: TComboBox;
    Panel4: TPanel;
    Label4_1: TLabel;
    Bevel6: TBevel;
    Label4: TLabel;
    Label4_2: TLabel;
    Label4_7: TLabel;
    Label4_10: TLabel;
    Label4_11: TLabel;
    Label4_13: TLabel;
    Label4_8: TLabel;
    Memo4_6: TMemo;
    RB4_3: TRadioButton;
    Edit4_4: TEdit;
    Rb4_5: TRadioButton;
    Edit4_12: TEdit;
    Edit4_9: TNumInp;
    Panel5: TPanel;
    Label5_1: TLabel;
    Bevel11: TBevel;
    Label5: TLabel;
    Label5_2: TLabel;
    Label5_4: TLabel;
    Label5_8: TLabel;
    Label5_10: TLabel;
    Label5_6: TLabel;
    Edit5_3: TEdit;
    Edit5_5: TEdit;
    Edit5_7: TEdit;
    Time5_9: TTimeEdit;
    Time5_11: TTimeEdit;
    Panel7: TPanel;
    Label7_1: TLabel;
    Bevel7: TBevel;
    Label7: TLabel;
    Label7_2: TLabel;
    Label7_7: TLabel;
    Label7_9: TLabel;
    Date7_8: TIntDate;
    Time7_10: TTimeEdit;
    Rb7_3: TRadioButton;
    Edit7_4: TEdit;
    RB7_5: TRadioButton;
    Memo7_6: TMemo;
    Sk: TSmartKey;
    Panel15: TPanel;
    Label13_1: TLabel;
    Label13_2: TLabel;
    Label13_3: TLabel;
    Label13_6: TLabel;
    Label13_9: TLabel;
    Label13_12: TLabel;
    Label13_15: TLabel;
    Label13_17: TLabel;
    Label13_18: TLabel;
    Label13_20: TLabel;
    Label13_22: TLabel;
    CB13_4: TCheckBox;
    Date13_5: TIntDate;
    CB13_7: TCheckBox;
    Date13_8: TIntDate;
    CB13_10: TCheckBox;
    Date13_11: TIntDate;
    CB13_13: TCheckBox;
    Date13_16: TIntDate;
    Edit13_14: TEdit;
    Edit13_19: TEdit;
    Edit13_21: TEdit;
    CB13_23: TCheckBox;
    procedure TimeEditExit(Sender: TObject);
    procedure NumEditKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure PreviewBtnClick(Sender: TObject);
    procedure RB1_21Click(Sender: TObject);
    procedure RB1_22Click(Sender: TObject);
    procedure SG6_2KeyPress(Sender: TObject; var Key: Char);
    procedure OKBtnClick(Sender: TObject);
    procedure PrintBtnClick(Sender: TObject);
    procedure OpenBtnClick(Sender: TObject);
    procedure SaveBtnClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormDestroy(Sender: TObject);
    procedure SiwzBtnClick(Sender: TObject);
    procedure HelpBtnClick(Sender: TObject);
    procedure AddBtnClick(Sender: TObject);
    procedure InsertBtnClick(Sender: TObject);
    procedure DelBtnClick(Sender: TObject);
  private
    { Private declarations }
    PPos:Integer;
    PrintSpace:Integer;
    Ry:TRyPrinter;
    FileName:String;
    FilePwd:String;
    FileIsOpen:Boolean;
    FHandle:File;
    procedure LoadFile;
    procedure SaveFile;
    procedure MakePrint;
    procedure MakeBox1(Ry:TRyPrinter; var PPos:Integer);
    procedure MakeBox2(Ry:TRyPrinter; var PPos:Integer);
    procedure MakeBox3(Ry:TRyPrinter; var PPos:Integer);
    procedure MakeBox4(Ry:TRyPrinter; var PPos:Integer);
    procedure MakeBox5(Ry:TRyPrinter; var PPos:Integer);
    procedure MakeBox6(Ry:TRyPrinter; var PPos:Integer);
    procedure MakeBox7(Ry:TRyPrinter; var PPos:Integer);
    procedure MakeUZPPage(Ry:TRyPrinter;PPos:Integer);
    procedure ClearSG6_2;
    function GetBox6Len(Ry:TRyPrinter):Integer;
  public
    { Public declarations }
  end;

var
  Zp140Dlg: TZp140Dlg;

procedure DrukZp140; export;

implementation

{$R *.DFM}

uses
  DrMsg,
  DateUtil;

procedure DrukZp140;
var
  Cur:Integer;
begin
  Cur:=Screen.Cursor;
  Screen.Cursor:=crHourGlass;
  ZP140Dlg:=TZp140Dlg.Create(Nil);
  Screen.Cursor:=Cur;
  ZP140Dlg.ShowModal;
  ZP140Dlg.Free;
end;

procedure TZp140Dlg.TimeEditExit(Sender: TObject);
var
  s:String[5];
  Err:Boolean;
begin
  if ActiveControl=CancelBtn
    then Exit;
  s:=TMaskEdit(Sender).Text;
  if s='  :  '
    then Exit;
  if not (s[1] in [' ','0','1','2'])
    then Err:=TRUE
  else begin
    case s[1] of
      ' ','0','1':
        begin
          if not (s[2] in ['0'..'9'])
            then Err:=TRUE;
        end;
      '2':
        begin
          if not (s[2] in ['0'..'3'])
            then Err:=TRUE;
        end;
    end {case}
  end;
  if (not (s[4] in ['0'..'5']))
    then Err:=TRUE;
  if Err
    then begin
      MessageDlg(wmTimeError,mtError,[mbOk],0);
      ActiveControl:=TMaskEdit(Sender);
    end;
end;

procedure TZp140Dlg.NumEditKeyPress(Sender: TObject; var Key: Char);
begin
  if not (Key in ['0'..'9',#8])
    then begin
      Key:=#0;
      MessageBeep(0);
    end;
end;

procedure TZp140Dlg.FormCreate(Sender: TObject);
begin
  Application.HelpFile:=DruZpHelpFile;
  FilePwd:=LoadFilePwd(AddBackSlash(ProgramDir)+SecurityFileName);
  RB1_21.Checked:=TRUE;
  RB1_21Click(Sender);
  SG6_2.Cells[0,0]:='Kryterium';
  SG6_2.Cells[1,0]:='Znaczenie';
end;

procedure TZp140Dlg.RB1_21Click(Sender: TObject);
begin
  MaskEdit1_24.Enabled:=TRUE;
  MaskEdit1_24.Color:=clWhite;
  MaskEdit1_25.Enabled:=FALSE;
  MaskEdit1_25.Color:=clGray;
end;

procedure TZp140Dlg.RB1_22Click(Sender: TObject);
begin
  MaskEdit1_24.Enabled:=FALSE;
  MaskEdit1_24.Color:=clGray;
  MaskEdit1_25.Enabled:=TRUE;
  MaskEdit1_25.Color:=clWhite;
end;

procedure TZP140Dlg.ClearSG6_2;
var
  i,j:LongInt;
begin
  for i:=0 to SG6_2.ColCount-1 do
    for j:=1 to SG6_2.RowCount-1 do
      SG6_2.Cells[i,j]:='';
end;

procedure TZp140Dlg.SG6_2KeyPress(Sender: TObject; var Key: Char);
var
  Rct:TGridRect;
begin
  if SG6_2.Selection.Left=1
    then begin
      if (not (Key in ['0'..'9',#8]))
        then Key:=#0
      else if (Length(SG6_2.Cells[SG6_2.Selection.Left,SG6_2.Selection.Top])>3) and
              (Key<>#8)
        then Key:=#0
      else if (SG6_2.Cells[SG6_2.Selection.Left,SG6_2.Selection.Top]<>'') and
              (Key<>#8) and
              (StrToInt(SG6_2.Cells[SG6_2.Selection.Left,SG6_2.Selection.Top]+Key)>100)
          then begin
            MessageDlg('Wartoœæ powyzej 100',mtError,[mbok],0);
            Key:=#0;
          end
      else if SG6_2.Cells[SG6_2.Selection.Left,SG6_2.Selection.Top]=''
          then SG6_2.Cells[SG6_2.Selection.Left,SG6_2.Selection.Top]:='0';
    end;
end;

procedure TZp140Dlg.MakeBox1(Ry:TRyPrinter; var PPos:Integer);
var
  p1,p2,p3,p4,p5,p6,p7:PChar;
begin
  with Ry do
    begin
      p1:=StrAlloc(Length(Label1_1.Caption)+1);
      StrPCopy(p1, Label1_1.Caption);
      p2:=StrAlloc(Memo1_2.GetTextLen + 1);
      Memo1_2.GetTextBuf(p2, Memo1_2.GetTextLen+1);
      p3:=StrAlloc(Length(Label1_3.Caption)+Length(Edit1_5.Text)+Length(Label1_4.Caption)+Length(MaskEdit1_6.Text)+1);
      StrPCopy(p3, Label1_3.Caption+Edit1_5.Text+Label1_4.Caption+MaskEdit1_6.Text);
      p4:=StrAlloc(Length(Label1_7.Caption)+Length(Edit1_10.Text)+Length(Label1_8.Caption)+Length(Edit1_11.Text)+
                  Length(Label1_9.Caption)+Length(Edit1_12.Text)+1);
      StrPCopy(p4, Label1_7.Caption+Edit1_10.Text+Label1_8.Caption+Edit1_11.Text+Label1_9.Caption+Edit1_12.Text);
      p5:=StrAlloc(Length(Label1_13.Caption)+Length(Edit1_16.Text)+Length(Label1_14.Caption)+Length(Edit1_17.Text)+
                  Length(Label1_15.Caption)+Length(Edit1_18.Text)+1);
      StrPCopy(p5, Label1_13.Caption+Edit1_16.Text+Label1_14.Caption+Edit1_17.Text+Label1_15.Caption+Edit1_18.Text);
      p6:=StrAlloc(Length(Label1_19.Caption)+Length(MaskEdit1_20.Text)+1);
      StrPCopy(p6, Label1_19.Caption+MaskEdit1_20.Text);
      p7:=StrAlloc(Length(NipGB1.Caption)+Length(MaskEdit1_24.Text)+1);
      if RB1_21.Checked
        then StrPCopy(p7, NipGB1.Caption+MaskEdit1_24.Text)
      else if RB1_22.Checked
        then StrPCopy(p7, NipGB1.Caption+MaskEdit1_25.Text);
      AddZp1Box(Ry,'1',[p1,p2,p3,p4,p5,p6,p7],[1,1,1,1,1,1,1],ZP140Tit,'140',NumEdit.Text,PrintSpace,PPos);
      StrDispose(p1);
      StrDispose(p2);
      StrDispose(p3);
      StrDispose(p4);
      StrDispose(p5);
      StrDispose(p6);
      StrDispose(p7);
    end;
end;

procedure TZp140Dlg.MakeBox2(Ry:TRyPrinter; var PPos:Integer);
var
  p1,p2,p3,p4,p5,p6:PChar;
  s:String;
begin
  with Ry do
    begin
      p1:=StrAlloc(Length(Label2_1.Caption)+1);
      StrPCopy(p1, Label2_1.Caption);
      p2:=StrAlloc(Memo2_2.GetTextLen + 1);
      Memo2_2.GetTextBuf(p2, Memo2_2.GetTextLen+1);
      p3:=StrAlloc(Length(Label2_3.Caption)+Length(Edit2_4.Text)+1);
      StrPCopy(p3, Label2_3.Caption+Edit2_4.Text);
      s:='';
      if RB2_6.Checked
        then s:=RB2_6.Caption
      else if RB2_7.Checked
        then s:=RB2_7.Caption
      else if RB2_8.Checked
        then s:=RB2_8.Caption;
      p4:=StrAlloc(Length(Label2_5.Caption)+Length(s)+1);
      StrPCopy(p4, Label2_5.Caption+s);
      p5:=StrAlloc(Length(Label2_9.Caption)+Length(Edit2_10.Text)+1);
      StrPCopy(p5, Label2_9.Caption+Edit2_10.Text);
      p6:=StrAlloc(Length(Label2_11.Caption)+Length(MaskEdit2_12.Text)+
                   Length(Label2_13.Caption)+Length(Edit2_14.Text)+1);
      StrPCopy(p6, Label2_11.Caption+MaskEdit2_12.Text+Label2_13.Caption+Edit2_14.Text);
      AddZp1Box(Ry,'2',[p1,p2,p3,p4,p5,p6],[1,1,1,1,1,1],ZP140Tit,'140',NumEdit.Text,PrintSpace,PPos);
      StrDispose(p1);
      StrDispose(p2);
      StrDispose(p3);
      StrDispose(p4);
      StrDispose(p5);
      StrDispose(p6);
    end;
end;

procedure TZp140Dlg.MakeBox3(Ry:TRyPrinter; var PPos:Integer);
var
  p1:PChar;
begin
  with Ry do
    begin
      p1:=StrAlloc(Length(Label3_1.Caption)+Length(CB3_2.Text)+Length(Label3_3.Caption)+1);
      StrPCopy(p1,Label3_1.Caption+CB3_2.Text+Label3_3.Caption);
      AddZp1Box(Ry,'3',[p1],[1],ZP140Tit,'140',NumEdit.Text,PrintSpace,PPos);
      StrDispose(p1);
    end;
end;

procedure TZp140Dlg.MakeBox4(Ry:TRyPrinter; var PPos:Integer);
var
  q3,p1,p2,p3,p4,p5,p6:PChar;
begin
  with Ry do
    begin
      q3:=Nil;
      p1:=StrAlloc(Length(Label4_1.Caption)+1);
      StrPCopy(p1,Label4_1.Caption);
      p2:=StrAlloc(Length(Label4_2.Caption)+1);
      StrPCopy(p2,Label4_2.Caption);
      if Rb4_3.Checked
        then begin
          p3:=StrAlloc(Length(RB4_3.Caption)+Length(Edit4_4.Text)+1);
          StrPCopy(p3, RB4_3.Caption+Edit4_4.Text);
        end
      else if Rb4_5.Checked
        then begin
          p3:=StrAlloc(Length(RB4_5.Caption)+Memo4_6.GetTextLen+1);
          StrPCopy(p3, Rb4_5.Caption);
          q3:=StrAlloc(Memo4_6.GetTextLen + 1);
          Memo4_6.GetTextBuf(q3, Memo4_6.GetTextLen+1);
          StrCat(p3,q3);
        end
      else p3:=Nil;
      p4:=StrAlloc(Length(Label4_7.Caption)+1);
      StrPCopy(p4,Label4_7.Caption);
      p5:=StrAlloc(Length(Label4_8.Caption)+Length(Edit4_9.Text)+Length(Label4_10.Caption)+1);
      StrPCopy(p5, Label4_8.Caption+Edit4_9.Text+Label4_10.Caption);
      p6:=StrAlloc(Length(Label4_11.Caption)+Length(Edit4_12.Text)+Length(Label4_13.Caption)+1);
      StrPCopy(p6, Label4_11.Caption+Edit4_12.Text+Label4_13.Caption);
      AddZp1Box(Ry,'4',[p1,p2,p3,p4,p5,p6],[1,1,1,1,1,1],ZP140Tit,'140',NumEdit.Text,PrintSpace,PPos);
      StrDispose(q3);
      StrDispose(p1);
      StrDispose(p2);
      StrDispose(p3);
      StrDispose(p4);
      StrDispose(p5);
      StrDispose(p6);
    end;
end;

procedure TZp140Dlg.MakeBox5(Ry:TRyPrinter; var PPos:Integer);
var
  p1,p2,p3,p4,p5:PChar;
begin
  with Ry do
    begin
      p1:=StrAlloc(Length(Label5_1.Caption)+1);
      StrPCopy(p1,Label5_1.Caption);
      p2:=StrAlloc(Length(Label5_2.Caption)+Length(Edit5_3.Text)+1);
      StrPCopy(p2,Label5_2.Caption+Edit5_3.Text);
      p3:=StrAlloc(Length(Label5_4.Caption)+Length(Edit5_5.Text)+1);
      StrPCopy(p3,Label5_4.Caption+Edit5_5.Text);
      p4:=StrAlloc(Length(Label5_6.Caption)+Length(Edit5_7.Text)+1);
      StrPCopy(p4,Label5_6.Caption+Edit5_7.Text);
      p5:=StrAlloc(Length(Label5_8.Caption)+Length(Time5_9.Text)+Length(Time5_11.Text)+4);
      StrPCopy(p5,Label5_8.Caption+Time5_9.Text+' - '+Time5_11.Text);
      AddZp1Box(Ry,'5',[p1,p2,p3,p4,p5],[1,1,1,1,1],ZP140Tit,'140',NumEdit.Text,PrintSpace,PPos);
      StrDispose(p1);
      StrDispose(p2);
      StrDispose(p3);
      StrDispose(p4);
      StrDispose(p5);
    end;
end;

function TZp140Dlg.GetBox6Len(Ry:TRyPrinter):Integer;
var
  p:PChar;
  Rct:TRect;
  Tx:Integer;
  LH:Integer;
  LP:Integer; {Line position}
  X,Y,Z,i:Integer;
begin
  with Ry do
    begin
      Rct.Right:=XROff;
      Tx:=XLOff+Xmm(15);
      Font.Size:=10;
      LH:=TextHeight+Ymm(1);
      LP:=Ymm(2);
      p:=StrAlloc(Length(Label6_1.Caption)+1);
      StrPCopy(p,Label6_1.Caption);
      X:=MemoOut(Rect(Tx,LP,Rct.Right-Xmm(3),100), p, False, TRUE);
      StrDispose(p);
      LP:=LP+X+Ymm(1);
      Y:=Rct.Right-Xmm(7)-TextWidth(SG6_2.Cells[1,0]);
      Z:=LP;
      LP:=LP+LH;
      i:=1;
      while (i<SG6_2.RowCount) do
        begin
          if (SG6_2.Cells[0,i]<>'')
            then begin
              p:=StrAlloc(Length(SG6_2.Cells[0,i])+1);
              StrPCopy(p,SG6_2.Cells[0,i]);
              X:=MemoOut(Rect(Tx,LP,Y-Xmm(3),100), p, False, TRUE);
              StrDispose(p);
              LP:=LP+X+Ymm(1);
            end;
          Inc(i);
        end;
      Result:=LP+Ymm(1);
    end;
end;

procedure TZp140Dlg.MakeBox6(Ry:TRyPrinter; var PPos:Integer);
var
  p:PChar;
  Rct:TRect;
  Tx:Integer;
  LH:Integer;
  LP:Integer; {Line position}
  X,Y,Z,i:Integer;
begin
  with Ry do
    begin
      Rct.Left:=XLOff;
      Rct.Right:=XROff;
      Rct.Top:=PPos+Ymm(3);
      Tx:=Rct.Left+Xmm(15);
      Font.Size:=10;
      LH:=TextHeight+Ymm(1);
      LP:=Rct.Top+Ymm(2);
      p:=StrAlloc(Length(Label6_1.Caption)+1);
      StrPCopy(p,Label6_1.Caption);
      X:=MemoOut(Rect(Tx,LP,Rct.Right-Xmm(3),100), p, False, False);
      StrDispose(p);
      LP:=LP+X+Ymm(1);
      TextOut(Tx,LP,SG6_2.Cells[0,0]);
      TextOutRight(Rct.Right-Xmm(5),LP,SG6_2.Cells[1,0]);
      Y:=Rct.Right-Xmm(7)-TextWidth(SG6_2.Cells[1,0]);
      Z:=LP;
      LP:=LP+LH;
      i:=1;
      while (i<SG6_2.RowCount) do
        begin
          if (SG6_2.Cells[0,i]<>'')
            then begin
              Line(Point(Tx,LP),Point(Rct.Right,LP));
              p:=StrAlloc(Length(SG6_2.Cells[0,i])+1);
              StrPCopy(p,SG6_2.Cells[0,i]);
              X:=MemoOut(Rect(Tx,LP,Y-Xmm(3),100), p, False, False);
              StrDispose(p);
              TextOut(Y+Xmm(5),LP,SG6_2.Cells[1,i]);
              LP:=LP+X+Ymm(1);
            end;
          Inc(i);
        end;
      Rct.Bottom:=LP+Ymm(1);
      RoundRectangle(Rct);
      Line(Point(Tx-Xmm(3),Rct.Top),Point(Tx-Xmm(3),Rct.Bottom));
      Line(Point(Y,Z),Point(Y,Rct.Bottom));
      TextOutCenter(((Tx-Xmm(3)-Rct.Left) div 2)+Rct.Left,Rct.Top+Ymm(4),'6');
      PPos:=Rct.Bottom;
    end;
end;

procedure TZp140Dlg.MakeBox7(Ry:TRyPrinter; var PPos:Integer);
var
  p1,p2,p3,p4:PChar;
begin
  with Ry do
    begin
      p1:=StrAlloc(Length(Label7_1.Caption)+1);
      StrPCopy(p1,Label7_1.Caption);
      p2:=StrAlloc(Length(Label7_2.Caption)+1);
      StrPCopy(p2,Label7_2.Caption);
      if Rb7_3.Checked
        then begin
          p3:=StrAlloc(Length(RB7_3.Caption)+Length(Edit7_4.Text)+1);
          StrPCopy(p3, RB7_3.Caption+Edit7_4.Text);
        end
      else if Rb7_5.Checked
        then begin
          p3:=StrAlloc(Memo7_6.GetTextLen + 1);
          Memo7_6.GetTextBuf(p3, Memo7_6.GetTextLen+1);
        end
      else p3:=Nil;
      p4:=StrAlloc(Length(Label7_7.Caption)+Length(Date7_8.Text)+
                   Length(Label7_9.Caption)+Length(Time7_10.Text)+1);
      StrPCopy(p4,Label7_7.Caption+Date7_8.Text+Label7_9.Caption+Time7_10.Text);
      AddZp1Box(Ry,'7',[p1,p2,p3,p4],[1,1,1,1],ZP140Tit,'140',NumEdit.Text,PrintSpace,PPos);
      StrDispose(p1);
      StrDispose(p2);
      StrDispose(p3);
      StrDispose(p4);
    end;
end;

procedure TZp140Dlg.MakeUZPPage(Ry:TRyPrinter;PPos:Integer);
var
  X:Integer;
  p:PChar;
begin
  with Ry do
    begin
      NewPage;
      Font.Name:='Times New Roman CE';
      PPos:=YTOff;
      MakeZpNumStr(Ry,XROff-Xmm(4),'140',PPos);
      PPos:=PPos+Ymm(10);
      MakeUZPTitle(Ry,Label13_1.Caption,PPos);
      Font.Size:=12;
      Font.Style:=[];
{1}
      p:=StrAlloc(Length(Label13_2.Caption)+1);
      StrPCopy(p,Label13_2.Caption);
      X:=MemoOut(Rect(XLOff,PPos,XROff,YBOff), p, False, False);
      StrDispose(p);
      PPos:=PPos+X+Ymm(2);
      if CB13_4.Checked
        then begin
          TextOut(XLOff+Xmm(10),PPos,Label13_3.Caption);
          PPos:=PPos+TextHeight+Ymm(1);
          TextOut(XLOff+Xmm(10),PPos,CB13_4.Caption+Date13_5.Text);
          PPos:=PPos+TextHeight+Ymm(2);
        end;
      if CB13_7.Checked
        then begin
          TextOut(XLOff+Xmm(10),PPos,Label13_6.Caption);
          PPos:=PPos+TextHeight+Ymm(1);
          TextOut(XLOff+Xmm(10),PPos,CB13_7.Caption+Date13_8.Text);
          PPos:=PPos+TextHeight+Ymm(2);
        end;
      if CB13_10.Checked
        then begin
          TextOut(XLOff+Xmm(10),PPos,Label13_9.Caption);
          PPos:=PPos+TextHeight+Ymm(1);
          TextOut(XLOff+Xmm(10),PPos,CB13_10.Caption+Date13_11.Text);
          PPos:=PPos+TextHeight+Ymm(2);
        end;
      if CB13_13.Checked
        then begin
          TextOut(XLOff+Xmm(10),PPos,Label13_12.Caption);
          PPos:=PPos+TextHeight+Ymm(1);
          p:=StrAlloc(Length(CB13_13.Caption)+Length(Edit13_14.Text)+
                      Length(Label13_15.Caption)+Length(Date13_16.Text)+1);
          StrPCopy(p,CB13_13.Caption+Edit13_14.Text+Label13_15.Caption+Date13_16.Text);
          X:=MemoOut(Rect(XLOff+Xmm(10),PPos,XROff,YBOff), p, False, False);
          StrDispose(p);
          PPos:=PPos+X+Ymm(2);
        end;
      PPos:=PPos+Ymm(2);
{2}
      p:=StrAlloc(Length(Label13_17.Caption)+1);
      StrPCopy(p,Label13_17.Caption);
      X:=MemoOut(Rect(XLOff,PPos,XROff,YBOff), p, False, False);
      StrDispose(p);
      PPos:=PPos+X+Ymm(2);
      p:=StrAlloc(Length(Label13_18.Caption)+Length(Edit13_19.Text)+1);
      StrPCopy(p,Label13_18.Caption+Edit13_19.Text);
      X:=MemoOut(Rect(XLOff+Xmm(10),PPos,XROff,YBOff), p, False, False);
      StrDispose(p);
      PPos:=PPos+X+Ymm(2);
      p:=StrAlloc(Length(Label13_20.Caption)+Length(Edit13_21.Text)+1);
      StrPCopy(p,Label13_20.Caption+Edit13_21.Text);
      X:=MemoOut(Rect(XLOff+Xmm(10),PPos,XROff,YBOff), p, False, False);
      StrDispose(p);
      PPos:=PPos+X+Ymm(4);
{3}
      p:=StrAlloc(Length(Label13_22.Caption)+1);
      StrPCopy(p,Label13_22.Caption);
      X:=MemoOut(Rect(XLOff,PPos,XROff,YBOff), p, False, False);
      StrDispose(p);
      PPos:=PPos+X+Ymm(2);
      if CB13_23.Checked
        then TextOut(XLOff+Xmm(10),PPos,CB13_23.Caption)
        else TextOut(XLOff+Xmm(10),PPos,'nie '+CB13_23.Caption);
      PPos:=PPos+TextHeight+Ymm(30);
      Font.Size:=8;
      TextOutRight(XROff-Xmm(5),PPos,'imiê, nazwisko i podpis osoby uprawnionej');
    end;
end;

procedure TZp140Dlg.MakePrint;
var
  p,q,r:PChar;
begin
    with Ry do
      begin
        NewJob;
        SetMinMargins(Xmm(20),Ymm(10),Xmm(20),Ymm(10));
        MakeHeader(Ry,Zp140Tit,'140',NumEdit.Text,'',PPos);
        PrintSpace:=YBOff-Ymm(35);
        MakeFooter(Ry,PrintSpace);
        MakeBox1(Ry,PPos);
        MakeBox2(Ry,PPos);
        MakeBox3(Ry,PPos);
        MakeBox4(Ry,PPos);
        MakeBox5(Ry,PPos);
        if GetBox6Len(Ry)+PPos+Ymm(3)>PrintSpace
          then MakeNewPage(Ry,Zp140Tit,'140',NumEdit.Text,PPos,PrintSpace);
        MakeBox6(Ry,PPos);
        MakeBox7(Ry,PPos);
        MakeUZPPage(Ry,PPos);
      end;
end;

procedure TZp140Dlg.PreviewBtnClick(Sender: TObject);
var
  Cur:Integer;
begin
{$IFDEF NONET}
  if not SmartKeyOk(Sk,SkData)
    then Exit;
{$ENDIF}
  Cur:=Screen.Cursor;
  Screen.Cursor:=crHourGlass;
  Printer.Free;
  Printer:=TPrinter.Create;
  Printer.Orientation:=poPortrait;
  try
    Ry:=TRyPrinter.Create;
    MakePrint;
    Screen.Cursor:=Cur;
    Ry.Preview;
  finally
    Ry.Free;
    Screen.Cursor:=Cur;
  end;
end;

procedure TZp140Dlg.PrintBtnClick(Sender: TObject);
var
  Cur:Integer;
begin
{$IFDEF NONET}
  if not SmartKeyOk(Sk,SkData)
    then Exit;
{$ENDIF}
  Cur:=Screen.Cursor;
  Screen.Cursor:=crHourGlass;
  Printer.Free;
  Printer:=TPrinter.Create;
  Printer.Orientation:=poPortrait;
  try
    Ry:=TRyPrinter.Create;
    MakePrint;
    Ry.PrintIt;
    Screen.Cursor:=Cur;
  finally
    Ry.Free;
    Screen.Cursor:=Cur;
  end;
end;

procedure TZp140Dlg.SaveFile;
var
  s:String;
  FO:Boolean;
begin
  FO:=FileIsOpen;
  if FO
    then CloseFile(FHandle);
  AssignFile(FHandle,FileName);
  FileMode:=fmOpenReadWrite + fmShareDenyWrite;
  try
    Rewrite(FHandle,1);
    try
      SeedKey:=SKey;
      SaveString(Zp140FileHdr,FHandle);
      SaveString(FilePwd,FHandle);
      MakeCodeKey(FilePwd);
      saveEdit(NumEdit,FHandle);
      SaveMemo(Memo1_2,FHandle);
      SaveMaskEdit(MaskEdit1_6,FHandle);
      SaveMaskEdit(MaskEdit1_20,FHandle);
      SaveMaskEdit(MaskEdit1_24,FHandle);
      SaveMaskEdit(MaskEdit1_25,FHandle);
      SaveEdit(Edit1_5,FHandle);
      SaveEdit(Edit1_10,FHandle);
      SaveEdit(Edit1_11,FHandle);
      SaveEdit(Edit1_12,FHandle);
      SaveEdit(Edit1_16,FHandle);
      SaveEdit(Edit1_17,FHandle);
      SaveEdit(Edit1_18,FHandle);
      SaveBoolean(RB1_21.Checked,FHandle);
      SaveBoolean(RB1_22.Checked,FHandle);
      SaveMemo(Memo2_2,FHandle);
      SaveEdit(Edit2_4,FHandle);
      SaveBoolean(RB2_6.Checked,FHandle);
      SaveBoolean(RB2_7.Checked,FHandle);
      SaveBoolean(RB2_8.Checked,FHandle);
      SaveEdit(Edit2_10,FHandle);
      SaveMaskEdit(MaskEdit2_12,FHandle);
      SaveEdit(Edit2_14,FHandle);
      SaveComboBox(CB3_2,FHandle);
      SaveBoolean(RB4_3.Checked,FHandle);
      SaveEdit(Edit4_4,FHandle);
      SaveBoolean(RB4_5.Checked,FHandle);
      SaveMemo(Memo4_6,FHandle);
      SaveReal(Edit4_9.Value,FHandle);
      SaveEdit(Edit4_12,FHandle);
      SaveEdit(Edit5_3,FHandle);
      SaveEdit(Edit5_5,FHandle);
      SaveEdit(Edit5_7,FHandle);
      SaveDateTime(Time5_9.EditTime,FHandle);
      SaveDateTime(Time5_11.EditTime,FHandle);
      SaveStringGrid(SG6_2,FHandle);
      SaveBoolean(RB7_3.Checked,FHandle);
      SaveEdit(Edit7_4,FHandle);
      SaveBoolean(RB7_5.Checked,FHandle);
      SaveMemo(Memo7_6,FHandle);
      SaveDateTime(Date7_8.EditDate,FHandle);
      SaveDateTime(Time7_10.EditTime,FHandle);
    finally
      if not FileIsOpen
        then begin
          CloseFile(FHandle);
          FileIsOpen:=FALSE;
        end;
    end;
  except
    on E:EInOutError do

      case E.ErrorCode of
        5: MessageDlg(wmFileAccessDenied ,mtWarning ,[mbOk] ,0);
        100: MessageDlg(wmReadBeyondEnd ,mtWarning ,[mbOk] ,0);
        else MessageDlg(IntToStr(E.ErrorCode),mtWarning,[mbOk],0);
      end;
  end;
end;

procedure TZp140Dlg.LoadFile;
var
  s:String;
  i:Integer;
  b:Boolean;
  r:Real;
  DT:TDateTime;
begin
  if FileIsOpen
    then MessageDlg(wmFileAlreadyLoaded,mtWarning,[mbOk],0)
    else begin
      AssignFile(FHandle,FileName);
      FileMode:=fmOpenReadWrite + fmShareDenyWrite;
      try
        Reset(FHandle,1);
        FileIsOpen:=TRUE;
        SeedKey:=SKey;
        LoadString(s,FHandle);
        if s=Zp140FileHdr
          then begin
            LoadString(s,FHandle);
            if (s=FilePwd)
              then begin
                MakeCodeKey(FilePwd);
                LoadEdit(NumEdit,FHandle);
                LoadMemo(Memo1_2,FHandle);
                LoadMaskEdit(MaskEdit1_6,FHandle);
                LoadMaskEdit(MaskEdit1_20,FHandle);
                LoadMaskEdit(MaskEdit1_24,FHandle);
                LoadMaskEdit(MaskEdit1_25,FHandle);
                LoadEdit(Edit1_5,FHandle);
                LoadEdit(Edit1_10,FHandle);
                LoadEdit(Edit1_11,FHandle);
                LoadEdit(Edit1_12,FHandle);
                LoadEdit(Edit1_16,FHandle);
                LoadEdit(Edit1_17,FHandle);
                LoadEdit(Edit1_18,FHandle);
                LoadBoolean(b,FHandle);
                RB1_21.Checked:=b;
                LoadBoolean(b,FHandle);
                RB1_22.Checked:=b;
                LoadMemo(Memo2_2,FHandle);
                LoadEdit(Edit2_4,FHandle);
                LoadBoolean(B,FHandle);
                RB2_6.Checked:=B;
                LoadBoolean(B,FHandle);
                RB2_7.Checked:=B;
                LoadBoolean(B,FHandle);
                RB2_8.Checked:=B;
                LoadEdit(Edit2_10,FHandle);
                LoadMaskEdit(MaskEdit2_12,FHandle);
                LoadEdit(Edit2_14,FHandle);
                LoadComboBox(CB3_2,FHandle);
                LoadBoolean(B,FHandle);
                RB4_3.Checked:=B;
                LoadEdit(Edit4_4,FHandle);
                LoadBoolean(B,FHandle);
                RB4_5.Checked:=B;
                LoadMemo(Memo4_6,FHandle);
                LoadReal(r,FHandle);
                Edit4_9.Value:=r;
                LoadEdit(Edit4_12,FHandle);
                LoadEdit(Edit5_3,FHandle);
                LoadEdit(Edit5_5,FHandle);
                LoadEdit(Edit5_7,FHandle);
                LoadDateTime(DT,FHandle);
                Time5_9.EditTime:=DT;
                LoadDateTime(DT,FHandle);
                Time5_11.EditTime:=DT;
                LoadStringGrid(TStringGrid(SG6_2),FHandle);
                LoadBoolean(B,FHandle);
                RB7_3.Checked:=B;
                LoadEdit(Edit7_4,FHandle);
                LoadBoolean(B,FHandle);
                RB7_5.Checked:=B;
                LoadMemo(Memo7_6,FHandle);
                LoadDateTime(DT,FHandle);
                Date7_8.EditDate:=DT;
                LoadDateTime(DT,FHandle);
                Time7_10.EditTime:=DT;
              end
              else begin
                MessageDlg(wmSecurityCode,mtWarning,[mbOk],0);
                CloseFile(FHandle);
                FileIsOpen:=FALSE;
              end;
          end
          else begin
            MessageDlg(wmNotAZP,mtWarning,[mbOk],0);
            CloseFile(FHandle);
            FileIsOpen:=FALSE;
          end;
      except
        on E:EInOutError do
          begin
            case E.ErrorCode of
              5: MessageDlg(wmFileAccessDenied ,mtWarning ,[mbOk] ,0);
              100: MessageDlg(wmReadBeyondEnd ,mtWarning ,[mbOk] ,0);
              else MessageDlg(IntToStr(E.ErrorCode),mtWarning,[mbOk],0);
            end;
            if FileIsOpen
              then begin
                CloseFile(FHandle);
                FileIsOpen:=FALSE;
              end;
          end;
      end;
    end;
end;

procedure TZp140Dlg.OpenBtnClick(Sender: TObject);
begin
  if OpenDialog.Execute
    then begin
      if FileName<>OpenDialog.FileName
        then if FileIsOpen
          then begin
            CloseFile(FHandle);
            FileIsOpen:=FALSE;
          end;
      FileName:=OpenDialog.FileName;
      if FileExists(FileName)
        then LoadFile;
    end;
end;

procedure TZp140Dlg.SaveBtnClick(Sender: TObject);
begin
  if SaveDialog.Execute
    then begin
      if FileName<>SaveDialog.FileName
        then if FileIsOpen
          then begin
            CloseFile(FHandle);
            FileIsOpen:=FALSE;
          end;
      FileName:=SaveDialog.FileName;
      SaveFile;
    end;
end;

procedure TZp140Dlg.FormDestroy(Sender: TObject);
begin
  if FileIsOpen
    then begin
      CloseFile(FHandle);
      FileIsOpen:=FALSE;
    end;
end;

procedure TZp140Dlg.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key=#13
    then begin
      Key:=#0;
      Perform(wm_NextDlgCtl,0,0);
    end;
end;

procedure TZp140Dlg.OKBtnClick(Sender: TObject);
var
  x:Integer;
begin
  x:=MessageDlg(wmSaveOnExit,mtWarning,[mbYes,mbNo,mbCancel],0);
  case x of
    mrYes: begin
             SaveBtnClick(Sender);
             ModalResult:=mrOk;
           end;
    mrNo: ModalResult:=mrCancel;
    mrCancel: ModalResult:=0;
  end;{case}
end;

procedure TZp140Dlg.SiwzBtnClick(Sender: TObject);
var
  i:LongInt;
  p:PChar;
begin
{$IFDEF DEMO}
  MessageDlg('Nie dostêpne w wersji DEMO',mtWarning,[mbOk],0);
{$ELSE}
    OpenDialog.DefaultExt:=NieExt;
    OpenDialog.Filter:=AllFilter;
    if OpenDialog.Execute
      then begin
        LoadPrtRec(Self,OpenDialog.FileName);
        with PrtRec do
          begin
            Memo1_2.SetTextBuf(NameMemo);
            Edit1_5.Text:=TownEdit;
            MaskEdit1_6.Text:=ZipMaskEdit;
            Edit1_10.Text:=StreetEdit;
            Edit1_11.Text:=BldgEdit;
            Edit1_12.Text:=RoomEdit;
            Edit1_16.Text:=TelEdit;
            Edit1_17.Text:=FaxEdit;
            Edit1_18.Text:=TelexEdit;
            MaskEdit1_20.Text:=RegonMaskEdit;
            RB1_21.Checked:=NipRB1;
            RB1_22.Checked:=NipRB2;
            MaskEdit1_24.Text:=NipMaskEdit1;
            MaskEdit1_25.Text:=NipMaskEdit2;
            Memo2_2.SetTextBuf(ObjectMemo);
            RB2_6.Checked:=OKind=okDostawa;
            RB2_7.Checked:=OKind=okUslugi;
            RB2_8.Checked:=OKind=okRobBud;
            if PrefKrajowe
              then CB3_2.ItemIndex:=0
              else CB3_2.ItemIndex:=1;
            ClearSG6_2;
            if SG6_2.RowCount<PrtRec.SG.RowCount
              then SG6_2.RowCount:=PrtRec.SG.RowCount;
            for i:=1 to PrtRec.SG.RowCount-1 do
              begin
                SG6_2.Cells[0,i]:=PrtRec.SG.Cells[1,i];
                SG6_2.Cells[1,i]:=PrtRec.SG.Cells[3,i];
              end;
            Date7_8.EditDate:=SkladDateEdit2_15;
            Time7_10.EditTime:=SkladTime2_17;
          end;
        FreePrtRec;
      end;
    OpenDialog.DefaultExt:='140';
    OpenDialog.Filter:='Druki ZP140|*.140';
{$ENDIF}
end;

procedure TZp140Dlg.HelpBtnClick(Sender: TObject);
begin
  Application.HelpContext(150);
end;

procedure TZp140Dlg.AddBtnClick(Sender: TObject);
begin
  SG6_2.InsertRow(SG6_2.RowCount);
end;

procedure TZp140Dlg.InsertBtnClick(Sender: TObject);
begin
  SG6_2.InsertRow(SG6_2.Row);
end;

procedure TZp140Dlg.DelBtnClick(Sender: TObject);
begin
  SG6_2.DeleteRow(SG6_2.Row);
  if SG6_2.RowCount=1
    then SG6_2.InsertRow(SG6_2.RowCount);
end;

end.

