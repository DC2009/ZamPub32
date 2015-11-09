unit Zp210;

interface

uses WinTypes, WinProcs, Classes, Graphics, Forms, Controls, Buttons,
  StdCtrls, ExtCtrls, Mask, TabNotBk, Grids, Spin, SysUtils,
  Messages, Dialogs, Printers,
  Utils,
  SiwzIni,
  PrtRecIo,
  UserUnit,
  SkOk,
  ZpBoxes,
  RPrev, IntDate, Esgrid, Timeedit, Sk;

type
  TZp210Dlg = class(TForm)
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
    Edit1_12: TEdit;
    Panel2: TPanel;
    Bevel2: TBevel;
    Label2: TLabel;
    Label2_1: TLabel;
    Label2_3: TLabel;
    Memo2_2: TMemo;
    Edit2_4: TEdit;
    Panel3: TPanel;
    Bevel4: TBevel;
    Label3: TLabel;
    Label3_1: TLabel;
    Panel4: TPanel;
    Bevel5: TBevel;
    Label4: TLabel;
    Label4_1: TLabel;
    Memo4_3: TMemo;
    Panel5: TPanel;
    Bevel6: TBevel;
    Label5: TLabel;
    Label5_1: TLabel;
    Label5_2: TLabel;
    Panel7: TPanel;
    Label7_5: TLabel;
    Label7_4: TLabel;
    Label7_9: TLabel;
    Label7_8: TLabel;
    Label7_1: TLabel;
    Bevel7: TBevel;
    Label7: TLabel;
    Label7_10: TLabel;
    Label7_2: TLabel;
    Label7_18: TLabel;
    Label7_20: TLabel;
    Edit7_6: TEdit;
    MaskEdit7_7: TMaskEdit;
    Edit7_11: TEdit;
    Edit7_12: TEdit;
    Memo7_3: TMemo;
    Edit7_13: TEdit;
    Panel10: TPanel;
    Bevel10: TBevel;
    Label8: TLabel;
    Label8_1: TLabel;
    Label8_2: TLabel;
    Memo8_3: TMemo;
    Panel11: TPanel;
    Label4_2: TLabel;
    Memo5_3: TMemo;
    Panel6: TPanel;
    Label6_1: TLabel;
    Bevel3: TBevel;
    Label6: TLabel;
    Label6_2: TLabel;
    Memo6_3: TMemo;
    Panel8: TPanel;
    Bevel8: TBevel;
    Label9: TLabel;
    Label9_1: TLabel;
    Label9_2: TLabel;
    Panel9: TPanel;
    Label10_5: TLabel;
    Label10_4: TLabel;
    Label10_9: TLabel;
    Label10_8: TLabel;
    Label10_1: TLabel;
    Bevel9: TBevel;
    Label10: TLabel;
    Label10_10: TLabel;
    Label10_2: TLabel;
    Label10_14: TLabel;
    Label10_16: TLabel;
    Edit10_6: TEdit;
    MaskEdit10_7: TMaskEdit;
    Edit10_11: TEdit;
    Edit10_12: TEdit;
    Memo10_3: TMemo;
    Edit10_13: TEdit;
    Panel12: TPanel;
    OKBtn: TBitBtn;
    CancelBtn: TBitBtn;
    PrintBtn: TBitBtn;
    PreviewBtn: TBitBtn;
    OpenBtn: TBitBtn;
    SaveBtn: TBitBtn;
    HelpBtn: TBitBtn;
    SiwzBtn: TBitBtn;
    SaveDialog: TSaveDialog;
    OpenDialog: TOpenDialog;
    Date3_2: TIntDate;
    Date7_19: TIntDate;
    Date10_15: TIntDate;
    NumEdit: TEdit;
    Label29: TLabel;
    SG9_2: TEnhStringGrid;
    AddBtn: TButton;
    InsertBtn: TButton;
    DelBtn: TButton;
    Time10_17: TTimeEdit;
    Time7_21: TTimeEdit;
    Sk: TSmartKey;
    procedure NumEditKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure PreviewBtnClick(Sender: TObject);
    procedure RB1_21Click(Sender: TObject);
    procedure RB1_22Click(Sender: TObject);
    procedure SG9_2KeyPress(Sender: TObject; var Key: Char);
    procedure FormDestroy(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure OKBtnClick(Sender: TObject);
    procedure OpenBtnClick(Sender: TObject);
    procedure SaveBtnClick(Sender: TObject);
    procedure HelpBtnClick(Sender: TObject);
    procedure SiwzBtnClick(Sender: TObject);
    procedure AddBtnClick(Sender: TObject);
    procedure InsertBtnClick(Sender: TObject);
    procedure DelBtnClick(Sender: TObject);
  private
    { Private declarations }
    PPos:Integer;
    PrintSpace:Integer;
    Ry:TRyPrinter;
    FileName:String;
    FileIsOpen:Boolean;
    FilePwd:String;
    FHandle:File;
    procedure LoadFile;
    procedure SaveFile;
    procedure MakePrint;
    function GetBox9Len(Ry:TRyPrinter):Integer;
{    procedure MakeNewPage(Ry:TRyPrinter; var PPos,PSpace:Integer);}
    procedure MakeBox1(Ry:TRyPrinter; var PPos:Integer);
    procedure MakeBox2(Ry:TRyPrinter; var PPos:Integer);
    procedure MakeBox3(Ry:TRyPrinter; var PPos:Integer);
    procedure MakeBox4(Ry:TRyPrinter; var PPos:Integer);
    procedure MakeBox5(Ry:TRyPrinter; var PPos:Integer);
    procedure MakeBox6(Ry:TRyPrinter; var PPos:Integer);
    procedure MakeBox7(Ry:TRyPrinter; var PPos:Integer);
    procedure MakeBox8(Ry:TRyPrinter; var PPos:Integer);
    procedure MakeBox9(Ry:TRyPrinter; var PPos:Integer);
    procedure MakeBox10(Ry:TRyPrinter; var PPos:Integer);
    procedure ClearSG9_2;
  public
    { Public declarations }
  end;

var
  Zp210Dlg: TZp210Dlg;

procedure DrukZp210; export;

implementation

{$R *.DFM}

uses
  DrMsg,
  DateUtil;

procedure DrukZp210;
var
  Cur:Integer;
begin
  Cur:=Screen.Cursor;
  Screen.Cursor:=crHourGlass;
  ZP210Dlg:=TZp210Dlg.Create(Nil);
  Screen.Cursor:=Cur;
  ZP210Dlg.ShowModal;
  ZP210Dlg.Free;
end;

procedure TZp210Dlg.NumEditKeyPress(Sender: TObject; var Key: Char);
begin
  if not (Key in ['0'..'9',#8])
    then begin
      Key:=#0;
      MessageBeep(0);
    end;
end;

procedure TZp210Dlg.FormCreate(Sender: TObject);
begin
  Application.HelpFile:=DruZpHelpFile;
  FilePwd:=LoadFilePwd(AddBackSlash(ProgramDir)+SecurityFileName);
  RB1_21.Checked:=TRUE;
  RB1_21Click(Sender);
  SG9_2.Cells[0,0]:='Kryterium';
  SG9_2.Cells[1,0]:='Znaczenie';
end;

procedure TZP210Dlg.ClearSG9_2;
var
  i,j:LongInt;
begin
  for i:=0 to SG9_2.ColCount-1 do
    for j:=1 to SG9_2.RowCount-1 do
      SG9_2.Cells[i,j]:='';
end;

procedure TZp210Dlg.RB1_21Click(Sender: TObject);
begin
  MaskEdit1_24.Enabled:=TRUE;
  MaskEdit1_24.Color:=clWhite;
  MaskEdit1_25.Enabled:=FALSE;
  MaskEdit1_25.Color:=clGray;
end;

procedure TZp210Dlg.RB1_22Click(Sender: TObject);
begin
  MaskEdit1_24.Enabled:=FALSE;
  MaskEdit1_24.Color:=clGray;
  MaskEdit1_25.Enabled:=TRUE;
  MaskEdit1_25.Color:=clWhite;
end;

procedure TZp210Dlg.SG9_2KeyPress(Sender: TObject; var Key: Char);
var
  Rct:TGridRect;
begin
  if SG9_2.Selection.Left=1
    then begin
      if (not (Key in ['0'..'9',#8]))
        then Key:=#0
      else if (Length(SG9_2.Cells[SG9_2.Selection.Left,SG9_2.Selection.Top])>3) and
              (Key<>#8)
        then Key:=#0
      else if (SG9_2.Cells[SG9_2.Selection.Left,SG9_2.Selection.Top]<>'') and
              (Key<>#8) and
              (StrToInt(SG9_2.Cells[SG9_2.Selection.Left,SG9_2.Selection.Top]+Key)>100)
          then begin
            MessageDlg('Wartoœæ powyzej 100',mtError,[mbok],0);
            Key:=#0;
          end
      else if SG9_2.Cells[SG9_2.Selection.Left,SG9_2.Selection.Top]=''
          then SG9_2.Cells[SG9_2.Selection.Left,SG9_2.Selection.Top]:='0';
    end;
end;

procedure TZp210Dlg.MakeBox1(Ry:TRyPrinter; var PPos:Integer);
var
  p1,p2,p3,p4,p5,p8,p9,p10:PChar;
  s:String;
begin
  with Ry do
    begin
      s:='Pe³na nazwa zamawiaj¹cego:';
      p1:=StrAlloc(Length(s)+1);
      StrPCopy(p1,s);
      p2:=StrAlloc(Memo1_2.GetTextLen + 1);
      Memo1_2.GetTextBuf(p2, Memo1_2.GetTextLen+1);
      s:='w '+Edit1_5.Text+'  kod '+MaskEdit1_6.Text;
      p3:=StrAlloc(Length(s)+1);
      StrPCopy(p3,s);
      s:=Edit1_10.Text+'  numer domu '+Edit1_11.Text+'  numer pokoju '+Edit1_12.Text;
      p4:=StrAlloc(Length(s)+1);
      StrPCopy(p4,s);
      s:='REGON: '+MaskEdit1_20.Text+'  NIP: ';
      if RB1_21.Checked
        then s:=s+MaskEdit1_24.Text
      else if RB1_22.Checked
        then s:=s+MaskEdit1_25.Text;
      p5:=StrAlloc(Length(s)+1);
      StrPCopy(p5,s);
      s:='Telefon: '+Edit1_16.Text;
      p8:=StrAlloc(Length(s)+1);
      StrPCopy(p8,s);
      s:='Telefaks: '+Edit1_17.Text;
      p9:=StrAlloc(Length(s)+1);
      StrPCopy(p9,s);
      s:='Teleks: '+Edit1_18.Text;
      p10:=StrAlloc(Length(s)+1);
      StrPCopy(p10,s);
      AddZp1Box(Ry,'1',[p1,p2,p3,p4,p5,p8,p9,p10],[1,1,1,1,2,1,1,1],ZP210Tit,'210',NumEdit.Text,PrintSpace,PPos);
      StrDispose(p1);
      StrDispose(p2);
      StrDispose(p3);
      StrDispose(p4);
      StrDispose(p5);
      StrDispose(p8);
      StrDispose(p9);
      StrDispose(p10);
    end;
end;

procedure TZp210Dlg.MakeBox2(Ry:TRyPrinter; var PPos:Integer);
var
  p1,p2,p3:PChar;
begin
  with Ry do
    begin
      p1:=StrAlloc(Length(Label2_1.Caption)+1);
      StrPCopy(p1, Label2_1.Caption);
      p2:=StrAlloc(Memo2_2.GetTextLen + 1);
      Memo2_2.GetTextBuf(p2, Memo2_2.GetTextLen+1);
      p3:=StrAlloc(Length(Label2_3.Caption)+Length(Edit2_4.Text)+1);
      StrPCopy(p3, Label2_3.Caption+Edit2_4.Text);
      AddZp1Box(Ry,'2',[p1,p2,p3],[1,1,1],ZP210Tit,'210',NumEdit.Text,PrintSpace,PPos);
      StrDispose(p1);
      StrDispose(p2);
      StrDispose(p3);
    end;
end;

procedure TZp210Dlg.MakeBox3(Ry:TRyPrinter; var PPos:Integer);
var
  p1:PChar;
begin
  with Ry do
    begin
      p1:=StrAlloc(Length(Label3_1.Caption)+Length(Date3_2.Text) + 1);
      StrPCopy(p1,Label3_1.Caption+Date3_2.Text);
      AddZp1Box(Ry,'3',[p1],[1],ZP210Tit,'210',NumEdit.Text,PrintSpace,PPos);
      StrDispose(p1);
    end;
end;

procedure TZp210Dlg.MakeBox4(Ry:TRyPrinter; var PPos:Integer);
var
  p1,p2:PChar;
begin
  with Ry do
    begin
      p1:=StrAlloc(Length(Label4_1.Caption)+Length(Label4_2.Caption)+1);
      StrPCopy(p1,Label4_1.Caption+Label4_2.Caption);
      p2:=StrAlloc(Memo4_3.GetTextLen + 1);
      Memo4_3.GetTextBuf(p2, Memo4_3.GetTextLen+1);
      AddZp1Box(Ry,'4',[p1,p2],[1,1],ZP210Tit,'210',NumEdit.Text,PrintSpace,PPos);
      StrDispose(p1);
      StrDispose(p2);
    end;
end;

procedure TZp210Dlg.MakeBox5(Ry:TRyPrinter; var PPos:Integer);
var
  p1,p2:PChar;
begin
  with Ry do
    begin
      p1:=StrAlloc(Length(Label5_1.Caption)+Length(Label5_2.Caption)+1);
      StrPCopy(p1,Label5_1.Caption+Label5_2.Caption);
      p2:=StrAlloc(Memo5_3.GetTextLen + 1);
      Memo5_3.GetTextBuf(p2, Memo5_3.GetTextLen+1);
      AddZp1Box(Ry,'5',[p1,p2],[1,1],ZP210Tit,'210',NumEdit.Text,PrintSpace,PPos);
      StrDispose(p1);
      StrDispose(p2);
    end;
end;

procedure TZp210Dlg.MakeBox6(Ry:TRyPrinter; var PPos:Integer);
var
  p1,p2:PChar;
begin
  with Ry do
    begin
      p1:=StrAlloc(Length(Label6_1.Caption)+Length(Label6_2.Caption)+1);
      StrPCopy(p1,Label6_1.Caption+Label6_2.Caption);
      p2:=StrAlloc(Memo6_3.GetTextLen + 1);
      Memo6_3.GetTextBuf(p2, Memo6_3.GetTextLen+1);
      AddZp1Box(Ry,'6',[p1,p2],[1,1],ZP210Tit,'210',NumEdit.Text,PrintSpace,PPos);
      StrDispose(p1);
      StrDispose(p2);
    end;
end;

procedure TZp210Dlg.MakeBox7(Ry:TRyPrinter; var PPos:Integer);
var
  q,p1,p2,p3,p4,p5:PChar;
begin
  with Ry do
    begin
      p1:=StrAlloc(Length(Label7_1.Caption)+1);
      StrPCopy(p1,Label7_1.Caption);
      p2:=StrAlloc(Length(Label7_2.Caption)+Memo7_3.GetTextLen+1);
      StrPCopy(p2,Label7_2.Caption);
      q:=StrAlloc(Memo7_3.GetTextLen + 1);
      Memo7_3.GetTextBuf(q, Memo7_3.GetTextLen+1);
      StrCat(p2,q);
      p3:=StrAlloc(Length(Label7_4.Caption)+Length(Edit7_6.Text)+Length(Label7_5.Caption)+Length(MaskEdit7_7.Text)+1);
      StrPCopy(p3, Label7_4.Caption+Edit7_6.Text+Label7_5.Caption+MaskEdit7_7.Text);
      p4:=StrAlloc(Length(Label7_8.Caption)+Length(Edit7_11.Text)+Length(Label7_9.Caption)+Length(Edit7_12.Text)+
                  Length(Label7_10.Caption)+Length(Edit7_13.Text)+1);
      StrPCopy(p4, Label7_8.Caption+Edit7_11.Text+Label7_9.Caption+Edit7_12.Text+Label7_10.Caption+Edit7_13.Text);
      p5:=StrAlloc(Length(Label7_18.Caption)+Length(Date7_19.Text)+Length(Label7_20.Caption)+Length(Time7_21.Text)+1);
      StrPCopy(p5,Label7_18.Caption+Date7_19.Text+Label7_20.Caption+Time7_21.Text);
      AddZp1Box(Ry,'7',[p1,p2,p3,p4,p5],[1,1,1,1,1],ZP210Tit,'210',NumEdit.Text,PrintSpace,PPos);
      StrDispose(p1);
      StrDispose(p2);
      StrDispose(p3);
      StrDispose(p4);
      StrDispose(p5);
      StrDispose(q);
    end;
end;

procedure TZp210Dlg.MakeBox8(Ry:TRyPrinter; var PPos:Integer);
var
  p1,p2:PChar;
begin
  with Ry do
    begin
      p1:=StrAlloc(Length(Label8_1.Caption)+Length(Label8_2.Caption)+1);
      StrPCopy(p1,Label8_1.Caption+Label8_2.Caption);
      p2:=StrAlloc(Memo8_3.GetTextLen + 1);
      Memo8_3.GetTextBuf(p2, Memo8_3.GetTextLen+1);
      AddZp1Box(Ry,'8',[p1,p2],[1,1],ZP210Tit,'210',NumEdit.Text,PrintSpace,PPos);
      StrDispose(p1);
      StrDispose(p2);
    end;
end;

function TZp210Dlg.GetBox9Len(Ry:TRyPrinter):Integer;
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
      p:=StrAlloc(Length(Label9_1.Caption)+Length(Label9_2.Caption)+1);
      StrPCopy(p,Label9_1.Caption+Label9_2.Caption);
      X:=MemoOut(Rect(Tx,LP,Rct.Right-Xmm(3),100), p, False, TRUE);
      StrDispose(p);
      LP:=LP+X+Ymm(1);
      Y:=Rct.Right-Xmm(7)-TextWidth(SG9_2.Cells[1,0]);
      Z:=LP;
      LP:=LP+LH;
      i:=1;
      while (i<SG9_2.RowCount) do
        begin
          if (SG9_2.Cells[0,i]<>'')
            then begin
              p:=StrAlloc(Length(SG9_2.Cells[0,i])+1);
              StrPCopy(p,SG9_2.Cells[0,i]);
              X:=MemoOut(Rect(Tx,LP,Y-Xmm(3),100), p, False, TRUE);
              StrDispose(p);
              LP:=LP+X+Ymm(1);
            end;
          Inc(i);
        end;
      Result:=LP+Ymm(1);
    end;
end;

procedure TZp210Dlg.MakeBox9(Ry:TRyPrinter; var PPos:Integer);
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
      p:=StrAlloc(Length(Label9_1.Caption)+Length(Label9_2.Caption)+1);
      StrPCopy(p,Label9_1.Caption+Label9_2.Caption);
      X:=MemoOut(Rect(Tx,LP,Rct.Right-Xmm(3),100), p, False, False);
      StrDispose(p);
      LP:=LP+X+Ymm(1);
      TextOut(Tx,LP,SG9_2.Cells[0,0]);
      TextOutRight(Rct.Right-Xmm(5),LP,SG9_2.Cells[1,0]);
      Y:=Rct.Right-Xmm(7)-TextWidth(SG9_2.Cells[1,0]);
      Z:=LP;
      LP:=LP+LH;
      i:=1;
      while (i<SG9_2.RowCount) do
        begin
          if (SG9_2.Cells[0,i]<>'')
            then begin
              Line(Point(Tx,LP),Point(Rct.Right,LP));
              p:=StrAlloc(Length(SG9_2.Cells[0,i])+1);
              StrPCopy(p,SG9_2.Cells[0,i]);
              X:=MemoOut(Rect(Tx,LP,Y-Xmm(3),100), p, False, False);
              StrDispose(p);
              TextOut(Y+Xmm(5),LP,SG9_2.Cells[1,i]+' %');
              LP:=LP+X+Ymm(1);
            end;
          Inc(i);
        end;
      Rct.Bottom:=LP+Ymm(1);
      RoundRectangle(Rct);
      Line(Point(Tx-Xmm(3),Rct.Top),Point(Tx-Xmm(3),Rct.Bottom));
      Line(Point(Y,Z),Point(Y,Rct.Bottom));
      TextOutCenter(((Tx-Xmm(3)-Rct.Left) div 2)+Rct.Left,Rct.Top+Ymm(4),'9');
      PPos:=Rct.Bottom;
    end;
end;

procedure TZp210Dlg.MakeBox10(Ry:TRyPrinter; var PPos:Integer);
var
  q,p1,p2,p3,p4,p5:PChar;
begin
  with Ry do
    begin
      p1:=StrAlloc(Length(Label10_1.Caption)+1);
      StrPCopy(p1,Label10_1.Caption);
      p2:=StrAlloc(Length(Label10_2.Caption)+Memo10_3.GetTextLen+1);
      StrPCopy(p2,Label10_2.Caption);
      q:=StrAlloc(Memo10_3.GetTextLen + 1);
      Memo10_3.GetTextBuf(q, Memo10_3.GetTextLen+1);
      StrCat(p2,q);
      p3:=StrAlloc(Length(Label10_4.Caption)+Length(Edit10_6.Text)+Length(Label10_5.Caption)+Length(MaskEdit10_7.Text)+1);
      StrPCopy(p3, Label10_4.Caption+Edit10_6.Text+Label10_5.Caption+MaskEdit10_7.Text);
      p4:=StrAlloc(Length(Label10_8.Caption)+Length(Edit10_11.Text)+Length(Label10_9.Caption)+Length(Edit10_12.Text)+
                  Length(Label10_10.Caption)+Length(Edit10_13.Text)+1);
      StrPCopy(p4, Label10_8.Caption+Edit10_11.Text+Label10_9.Caption+Edit10_12.Text+Label10_10.Caption+Edit10_13.Text);
      p5:=StrAlloc(Length(Label10_14.Caption)+Length(Date10_15.Text)+Length(Label10_16.Caption)+Length(Time10_17.Text)+1);
      StrPCopy(p5,Label10_14.Caption+Date10_15.Text+Label10_16.Caption+Time10_17.Text);
      AddZp1Box(Ry,'10',[p1,p2,p3,p4,p5],[1,1,1,1,1],ZP210Tit,'210',NumEdit.Text,PrintSpace,PPos);
      StrDispose(p1);
      StrDispose(p2);
      StrDispose(p3);
      StrDispose(p4);
      StrDispose(p5);
      StrDispose(q);
    end;
end;
{
procedure TZp210Dlg.MakeNewPage(Ry:TRyPrinter; var PPos,PSpace:Integer);
begin
  with Ry do
    begin
      NewPage;
      MakeTitle(Ry,Zp210Tit,'210',PPos);
      PSpace:=YBOff-Ymm(35);
      MakeFooter(Ry,PSpace);
    end;
end;
}
procedure TZp210Dlg.MakePrint;
var
  p,q,r:PChar;
begin
    with Ry do
      begin
        NewJob;
        SetMinMargins(Xmm(20),Ymm(10),Xmm(20),Ymm(10));
        MakeHeader(Ry,Zp210Tit,'210',NumEdit.Text,'',PPos);
        PrintSpace:=YBOff-Ymm(PageBottomSpace);
        MakeFooter(Ry,PrintSpace);
        MakeBox1(Ry,PPos);
        MakeBox2(Ry,PPos);
        MakeBox3(Ry,PPos);
        MakeBox4(Ry,PPos);
        MakeBox5(Ry,PPos);
        MakeBox6(Ry,PPos);
        MakeBox7(Ry,PPos);
        MakeBox8(Ry,PPos);
        if GetBox9Len(Ry)+PPos+Ymm(3)>PrintSpace
          then MakeNewPage(Ry,Zp210Tit,'210',NumEdit.Text,PPos,PrintSpace);
        MakeBox9(Ry,PPos);
        MakeBox10(Ry,PPos);
      end;
end;

procedure TZp210Dlg.PreviewBtnClick(Sender: TObject);
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
    if Sender is TButton
      then begin
        if (Sender as TButton).Name='PrintBtn'
          then begin
            Ry.PrintIt;
            Screen.Cursor:=Cur;
          end
          else begin
            Screen.Cursor:=Cur;
            Ry.Preview;
          end;
      end;
  finally
    Ry.Free;
    Screen.Cursor:=Cur;
  end;
end;

procedure TZp210Dlg.SaveFile;
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
      SaveString(Zp210FileHdr,FHandle);
      SaveString(FilePwd,FHandle);
      MakeCodeKey(FilePwd);
      SaveEdit(NumEdit,FHandle);
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
      SaveDateTime(Date3_2.EditDate,FHandle);
      SaveMemo(Memo4_3,FHandle);
      SaveMemo(Memo5_3,FHandle);
      SaveMemo(Memo6_3,FHandle);
      SaveMemo(Memo7_3,FHandle);
      SaveEdit(Edit7_6,FHandle);
      SaveMaskEdit(MaskEdit7_7,FHandle);
      SaveEdit(Edit7_11,FHandle);
      SaveEdit(Edit7_12,FHandle);
      SaveEdit(Edit7_13,FHandle);
      SaveDateTime(Date7_19.EditDate,FHandle);
      SaveDateTime(Time7_21.EditTime,FHandle);
      SaveMemo(Memo8_3,FHandle);
      SaveStringGrid(SG9_2,FHandle);
      SaveMemo(Memo10_3,FHandle);
      SaveEdit(Edit10_6,FHandle);
      SaveMaskEdit(MaskEdit10_7,FHandle);
      SaveEdit(Edit10_11,FHandle);
      SaveEdit(Edit10_12,FHandle);
      SaveEdit(Edit10_13,FHandle);
      SaveDateTime(Date10_15.EditDate,FHandle);
      SaveDateTime(Time10_17.EditTime,FHandle);
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

procedure TZp210Dlg.LoadFile;
var
  s:String;
  i:Integer;
  b:Boolean;
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
        if s=Zp210FileHdr
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
                LoadDateTime(DT,FHandle);
                Date3_2.EditDate:=DT;
                LoadMemo(Memo4_3,FHandle);
                LoadMemo(Memo5_3,FHandle);
                LoadMemo(Memo6_3,FHandle);
                LoadMemo(Memo7_3,FHandle);
                LoadEdit(Edit7_6,FHandle);
                LoadMaskEdit(MaskEdit7_7,FHandle);
                LoadEdit(Edit7_11,FHandle);
                LoadEdit(Edit7_12,FHandle);
                LoadEdit(Edit7_13,FHandle);
                LoadDateTime(DT,FHandle);
                Date7_19.EditDate:=DT;
                LoadDateTime(DT,FHandle);
                Time7_21.EditTime:=DT;
                LoadMemo(Memo8_3,FHandle);
                LoadStringGrid(TStringGrid(SG9_2),FHandle);
                LoadMemo(Memo10_3,FHandle);
                LoadEdit(Edit10_6,FHandle);
                LoadMaskEdit(MaskEdit10_7,FHandle);
                LoadEdit(Edit10_11,FHandle);
                LoadEdit(Edit10_12,FHandle);
                LoadEdit(Edit10_13,FHandle);
                LoadDateTime(DT,FHandle);
                Date10_15.EditDate:=DT;
                LoadDateTime(DT,FHandle);
                Time10_17.EditTime:=DT;
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

procedure TZp210Dlg.OpenBtnClick(Sender: TObject);
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

procedure TZp210Dlg.SaveBtnClick(Sender: TObject);
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

procedure TZp210Dlg.FormDestroy(Sender: TObject);
begin
  if FileIsOpen
    then begin
      CloseFile(FHandle);
      FileIsOpen:=FALSE;
    end;
end;

procedure TZp210Dlg.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key=#13
    then begin
      Key:=#0;
      Perform(wm_NextDlgCtl,0,0);
    end;
end;

procedure TZp210Dlg.OKBtnClick(Sender: TObject);
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

procedure TZp210Dlg.SiwzBtnClick(Sender: TObject);
var
  i:LongInt;
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
            Date3_2.EditDate:=EndDate;
            ClearSG9_2;
            if SG9_2.RowCount<PrtRec.SG.RowCount
              then SG9_2.RowCount:=PrtRec.SG.RowCount;
            for i:=1 to PrtRec.SG.RowCount-1 do
              begin
                SG9_2.Cells[0,i]:=PrtRec.SG.Cells[1,i];
                SG9_2.Cells[1,i]:=PrtRec.SG.Cells[3,i];
              end;
          end;
        FreePrtRec;
      end;
    OpenDialog.DefaultExt:='210';
    OpenDialog.Filter:='Druki ZP210|*.210';
{$ENDIF}
end;

procedure TZp210Dlg.HelpBtnClick(Sender: TObject);
begin
  Application.HelpContext(210);
end;

procedure TZp210Dlg.AddBtnClick(Sender: TObject);
begin
  SG9_2.InsertRow(SG9_2.RowCount);
end;

procedure TZp210Dlg.InsertBtnClick(Sender: TObject);
begin
  SG9_2.InsertRow(SG9_2.Row);
end;

procedure TZp210Dlg.DelBtnClick(Sender: TObject);
begin
  SG9_2.DeleteRow(SG9_2.Row);
  if SG9_2.RowCount=1
    then SG9_2.InsertRow(SG9_2.RowCount);
end;

end.

