unit Zp110;

interface

uses WinTypes, WinProcs, Classes, Graphics, Forms, Controls, Buttons,
  StdCtrls, ExtCtrls, Mask, TabNotBk, Grids, Spin, SysUtils,
  Messages, Dialogs, Printers,
  Utils,
  SiwzIni,
  PrtRecIo,
  ZpBoxes,
  UserUnit,
  RPrev,
  Timeedit,
  SkOk,
  IntDate, NumInp, Esgrid, Sk;

type
  TZp110Dlg = class(TForm)
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
    Label2_13: TLabel;
    Memo2_2: TMemo;
    Edit2_14: TEdit;
    Panel3: TPanel;
    Bevel4: TBevel;
    Label3: TLabel;
    Label3_1: TLabel;
    Panel4: TPanel;
    Bevel5: TBevel;
    Label4: TLabel;
    Label6_1: TLabel;
    Label6_2: TLabel;
    Label6_4: TLabel;
    Panel5: TPanel;
    Bevel6: TBevel;
    Label5: TLabel;
    Label4_1: TLabel;
    Label4_3: TLabel;
    CB4_2: TComboBox;
    Panel6: TPanel;
    Label7_1: TLabel;
    Bevel3: TBevel;
    Label6: TLabel;
    Label7_2: TLabel;
    Memo7_6: TMemo;
    Panel7: TPanel;
    Label10_1: TLabel;
    Bevel7: TBevel;
    Label7: TLabel;
    Label10_2: TLabel;
    Label10_7: TLabel;
    Label10_9: TLabel;
    Panel8: TPanel;
    Bevel8: TBevel;
    Label8: TLabel;
    Label11_1: TLabel;
    Label11_2: TLabel;
    Label11_4: TLabel;
    Panel9: TPanel;
    Bevel9: TBevel;
    Label9: TLabel;
    Label5_1: TLabel;
    Label5_3: TLabel;
    CB5_2: TComboBox;
    Panel10: TPanel;
    Bevel10: TBevel;
    Label10: TLabel;
    Label9_1: TLabel;
    Label9_2: TLabel;
    Memo9_4: TMemo;
    Panel11: TPanel;
    OpenDialog: TOpenDialog;
    SaveDialog: TSaveDialog;
    Panel12: TPanel;
    OKBtn: TBitBtn;
    CancelBtn: TBitBtn;
    PrintBtn: TBitBtn;
    PreviewBtn: TBitBtn;
    OpenBtn: TBitBtn;
    SaveBtn: TBitBtn;
    HelpBtn: TBitBtn;
    SiwzBtn: TBitBtn;
    Date3_2: TIntDate;
    Date10_8: TIntDate;
    Time10_10: TTimeEdit;
    Date11_3: TIntDate;
    Time11_5: TTimeEdit;
    NumEdit: TEdit;
    Label29: TLabel;
    Label2_3: TLabel;
    Edit2_4: TEdit;
    Label2_5: TLabel;
    RB2_6: TRadioButton;
    RB2_7: TRadioButton;
    RB2_8: TRadioButton;
    Label2_9: TLabel;
    Edit2_10: TEdit;
    Label2_11: TLabel;
    MaskEdit2_12: TMaskEdit;
    Label6_5: TLabel;
    Edit6_6: TEdit;
    Label6_7: TLabel;
    Label7_7: TLabel;
    RB7_3: TRadioButton;
    Edit7_4: TEdit;
    Rb7_5: TRadioButton;
    Label7_10: TLabel;
    Label7_11: TLabel;
    Edit7_12: TEdit;
    Label7_13: TLabel;
    Label7_8: TLabel;
    Panel13: TPanel;
    Label8_1: TLabel;
    Bevel11: TBevel;
    Label12: TLabel;
    Label8_2: TLabel;
    Label8_4: TLabel;
    Label8_8: TLabel;
    Label8_10: TLabel;
    Label8_6: TLabel;
    Edit8_3: TEdit;
    Edit8_5: TEdit;
    Edit8_7: TEdit;
    Time8_9: TTimeEdit;
    Time8_11: TTimeEdit;
    Label9_3: TLabel;
    Rb10_3: TRadioButton;
    Edit10_4: TEdit;
    RB10_5: TRadioButton;
    Memo10_6: TMemo;
    Rb11_8: TRadioButton;
    RB11_6: TRadioButton;
    Edit11_7: TEdit;
    Memo11_9: TMemo;
    Panel14: TPanel;
    Bevel12: TBevel;
    Label19: TLabel;
    Label12_1: TLabel;
    Edit6_3: TNumInp;
    Edit7_9: TNumInp;
    SG12_2: TEnhStringGrid;
    AddBtn: TButton;
    InsertBtn: TButton;
    DelBtn: TButton;
    Sk: TSmartKey;
    Panel15: TPanel;
    Label13_1: TLabel;
    Label13_2: TLabel;
    Label13_3: TLabel;
    CB13_4: TCheckBox;
    Date13_5: TIntDate;
    Label13_6: TLabel;
    CB13_7: TCheckBox;
    Date13_8: TIntDate;
    Label13_9: TLabel;
    CB13_10: TCheckBox;
    Date13_11: TIntDate;
    Label13_12: TLabel;
    CB13_13: TCheckBox;
    Date13_16: TIntDate;
    Edit13_14: TEdit;
    Label13_15: TLabel;
    Label13_17: TLabel;
    Label13_18: TLabel;
    Edit13_19: TEdit;
    Label13_20: TLabel;
    Edit13_21: TEdit;
    Label13_22: TLabel;
    CB13_23: TCheckBox;
    procedure NumEditKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure PreviewBtnClick(Sender: TObject);
    procedure RB1_21Click(Sender: TObject);
    procedure RB1_22Click(Sender: TObject);
    procedure PrintBtnClick(Sender: TObject);
    procedure OpenBtnClick(Sender: TObject);
    procedure SaveBtnClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure OKBtnClick(Sender: TObject);
    procedure SiwzBtnClick(Sender: TObject);
    procedure HelpBtnClick(Sender: TObject);
    procedure SG12_2KeyPress(Sender: TObject; var Key: Char);
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
    procedure ClearSG12_2;
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
    procedure MakeBox8(Ry:TRyPrinter; var PPos:Integer);
    procedure MakeBox9(Ry:TRyPrinter; var PPos:Integer);
    procedure MakeBox10(Ry:TRyPrinter; var PPos:Integer);
    procedure MakeBox11(Ry:TRyPrinter; var PPos:Integer);
    procedure MakeBox12(Ry:TRyPrinter; var PPos:Integer);
    procedure MakeUZPPage(Ry:TRyPrinter;PPos:Integer);
    procedure LoadBox1;
    function GetBox12Len(Ry:TRyPrinter):Integer;
  public
    { Public declarations }
  end;

var
  Zp110Dlg: TZp110Dlg;

procedure DrukZp110; export;

implementation

{$R *.DFM}

uses
  DrMsg;

procedure DrukZp110;
var
  Cur:Integer;
begin
  Cur:=Screen.Cursor;
  Screen.Cursor:=crHourGlass;
  ZP110Dlg:=TZp110Dlg.Create(Nil);
  Screen.Cursor:=Cur;
  ZP110Dlg.ShowModal;
  ZP110Dlg.Free;
end;

procedure TZp110Dlg.NumEditKeyPress(Sender: TObject; var Key: Char);
begin
  if not (Key in ['0'..'9',#8])
    then begin
      Key:=#0;
      MessageBeep(0);
    end;
end;

procedure TZp110Dlg.FormCreate(Sender: TObject);
begin
  RB1_21.Checked:=TRUE;
  RB1_21Click(Sender);
  FilePwd:=LoadFilePwd(AddBackSlash(ProgramDir)+SecurityFileName);
  SG12_2.Cells[0,0]:='Kryterium';
  SG12_2.Cells[1,0]:='Znaczenie';
  Application.HelpFile:=DruZpHelpFile;
end;

procedure TZp110Dlg.RB1_21Click(Sender: TObject);
begin
  MaskEdit1_24.Enabled:=TRUE;
  MaskEdit1_24.Color:=clWhite;
  MaskEdit1_25.Enabled:=FALSE;
  MaskEdit1_25.Color:=clGray;
end;

procedure TZp110Dlg.RB1_22Click(Sender: TObject);
begin
  MaskEdit1_24.Enabled:=FALSE;
  MaskEdit1_24.Color:=clGray;
  MaskEdit1_25.Enabled:=TRUE;
  MaskEdit1_25.Color:=clWhite;
end;

procedure TZp110Dlg.MakeBox1(Ry:TRyPrinter; var PPos:Integer);
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
      p4:=StrAlloc(Length(Label1_7.Caption)+Length(Edit1_10.Text)+Length(Edit1_11.Text)+
                  Length(sRoom)+Length(Edit1_12.Text)+2);
      StrPCopy(p4, Label1_7.Caption+Edit1_10.Text+' '+Edit1_11.Text+sRoom+Edit1_12.Text);
      p5:=StrAlloc(Length(sTel)+Length(Edit1_16.Text)+Length(sFax)+Length(Edit1_17.Text)+
                  Length(sTelex)+Length(Edit1_18.Text)+3);
      StrPCopy(p5, sTel+Edit1_16.Text+' '+sFax+Edit1_17.Text+' '+sTelex+Edit1_18.Text);
      p6:=StrAlloc(Length(Label1_19.Caption)+Length(MaskEdit1_20.Text)+1);
      StrPCopy(p6, Label1_19.Caption+MaskEdit1_20.Text);
      p7:=StrAlloc(Length(NipGB1.Caption)+Length(MaskEdit1_24.Text)+1);
      if RB1_21.Checked
        then StrPCopy(p7, NipGB1.Caption+MaskEdit1_24.Text)
      else if RB1_22.Checked
        then StrPCopy(p7, NipGB1.Caption+MaskEdit1_25.Text);
      AddZp1Box(Ry,'1',[p1,p2,p3,p4,p5,p6,p7],[1,1,1,1,1,1,1],ZP110Tit,'110',NumEdit.Text,PrintSpace,PPos);
      StrDispose(p1);
      StrDispose(p2);
      StrDispose(p3);
      StrDispose(p4);
      StrDispose(p5);
      StrDispose(p6);
      StrDispose(p7);
    end;
end;

procedure TZp110Dlg.MakeBox2(Ry:TRyPrinter; var PPos:Integer);
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
      AddZp1Box(Ry,'2',[p1,p2,p3,p4,p5,p6],[1,1,1,1,1,1],ZP110Tit,'110',NumEdit.Text,PrintSpace,PPos);
      StrDispose(p1);
      StrDispose(p2);
      StrDispose(p3);
      StrDispose(p4);
      StrDispose(p5);
      StrDispose(p6);
    end;
end;

procedure TZp110Dlg.MakeBox3(Ry:TRyPrinter; var PPos:Integer);
var
  p1:PChar;
begin
  with Ry do
    begin
      p1:=StrAlloc(Length(Label3_1.Caption)+Length(Date3_2.Text) + 1);
      StrPCopy(p1,Label3_1.Caption+Date3_2.Text);
      AddZp1Box(Ry,'3',[p1],[1],ZP110Tit,'110',NumEdit.Text,PrintSpace,PPos);
      StrDispose(p1);
    end;
end;

procedure TZp110Dlg.MakeBox4(Ry:TRyPrinter; var PPos:Integer);
var
  p1:PChar;
begin
  with Ry do
    begin
      p1:=StrAlloc(Length(Label4_1.Caption)+Length(CB4_2.Text)+Length(Label4_3.Caption)+1);
      StrPCopy(p1,Label4_1.Caption+CB4_2.Text+Label4_3.Caption);
      AddZp1Box(Ry,'4',[p1],[1],ZP110Tit,'110',NumEdit.Text,PrintSpace,PPos);
      StrDispose(p1);
    end;
end;

procedure TZp110Dlg.MakeBox5(Ry:TRyPrinter; var PPos:Integer);
var
  p1:PChar;
begin
  with Ry do
    begin
      p1:=StrAlloc(Length(Label5_1.Caption)+Length(CB5_2.Text)+Length(Label5_3.Caption)+1);
      StrPCopy(p1,Label5_1.Caption+CB5_2.Text+Label5_3.Caption);
      AddZp1Box(Ry,'5',[p1],[1],ZP110Tit,'110',NumEdit.Text,PrintSpace,PPos);
      StrDispose(p1);
    end;
end;

procedure TZp110Dlg.MakeBox6(Ry:TRyPrinter; var PPos:Integer);
var
  p1,p2,p3:PChar;
begin
  with Ry do
    begin
      p1:=StrAlloc(Length(Label6_1.Caption)+Length(Label6_2.Caption)+1);
      StrPCopy(p1,Label6_1.Caption+Label6_2.Caption);
      p2:=StrAlloc(Length(Edit6_3.Text)+Length(Label6_4.Caption)+1);
      StrPCopy(p2,Edit6_3.Text+Label6_4.Caption);
      p3:=StrAlloc(Length(Label6_5.Caption)+Length(Edit6_6.Text)+Length(Label6_7.Caption)+1);
      StrPCopy(p3,Label6_5.Caption+Edit6_6.Text+Label6_7.Caption);
      AddZp1Box(Ry,'6',[p1,p2,p3],[1,1,1],ZP110Tit,'110',NumEdit.Text,PrintSpace,PPos);
      StrDispose(p1);
      StrDispose(p2);
      StrDispose(p3);
    end;
end;

procedure TZp110Dlg.MakeBox7(Ry:TRyPrinter; var PPos:Integer);
var
  p1,p2,p3,p4,p5,p6,p7:PChar;
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
      p4:=StrAlloc(Length(Label7_7.Caption)+1);
      StrPCopy(p4,Label7_7.Caption);
      p5:=StrAlloc(Length(Label7_8.Caption)+Length(Edit7_9.Text)+Length(Label7_10.Caption)+1);
      StrPCopy(p5, Label7_8.Caption+Edit7_9.Text+Label7_10.Caption);
      p6:=StrAlloc(Length(Label7_11.Caption)+Length(Edit7_12.Text)+Length(Label7_13.Caption)+1);
      StrPCopy(p6, Label7_11.Caption+Edit7_12.Text+Label7_13.Caption);
      AddZp1Box(Ry,'7',[p1,p2,p3,p4,p5,p6],[1,1,1,1,1,1],ZP110Tit,'110',NumEdit.Text,PrintSpace,PPos);
      StrDispose(p1);
      StrDispose(p2);
      StrDispose(p3);
      StrDispose(p4);
      StrDispose(p5);
      StrDispose(p6);
    end;
end;

procedure TZp110Dlg.MakeBox8(Ry:TRyPrinter; var PPos:Integer);
var
  p1,p2,p3,p4,p5:PChar;
begin
  with Ry do
    begin
      p1:=StrAlloc(Length(Label8_1.Caption)+1);
      StrPCopy(p1,Label8_1.Caption);
      p2:=StrAlloc(Length(Label8_2.Caption)+Length(Edit8_3.Text)+1);
      StrPCopy(p2,Label8_2.Caption+Edit8_3.Text);
      p3:=StrAlloc(Length(Label8_4.Caption)+Length(Edit8_5.Text)+1);
      StrPCopy(p3,Label8_4.Caption+Edit8_5.Text);
      p4:=StrAlloc(Length(Label8_6.Caption)+Length(Edit8_7.Text)+1);
      StrPCopy(p4,Label8_6.Caption+Edit8_7.Text);
      p5:=StrAlloc(Length(Label8_8.Caption)+Length(Time8_9.Text)+Length(Time8_11.Text)+4);
      StrPCopy(p5,Label8_8.Caption+Time8_9.Text+' - '+Time8_11.Text);
      AddZp1Box(Ry,'8',[p1,p2,p3,p4,p5],[1,1,1,1,1],ZP110Tit,'110',NumEdit.Text,PrintSpace,PPos);
      StrDispose(p1);
      StrDispose(p2);
      StrDispose(p3);
      StrDispose(p4);
      StrDispose(p5);
    end;
end;

procedure TZp110Dlg.MakeBox9(Ry:TRyPrinter; var PPos:Integer);
var
  p1,p2:PChar;
begin
  with Ry do
    begin
      p1:=StrAlloc(Length(Label9_1.Caption)+Length(Label9_2.Caption)+Length(Label9_3.Caption)+1);
      StrPCopy(p1,Label9_1.Caption+Label9_2.Caption+Label9_3.Caption);
      p2:=StrAlloc(Memo9_4.GetTextLen + 1);
      Memo9_4.GetTextBuf(p2, Memo9_4.GetTextLen+1);
      AddZp1Box(Ry,'9',[p1,p2],[1,1],ZP110Tit,'110',NumEdit.Text,PrintSpace,PPos);
      StrDispose(p1);
      StrDispose(p2);
    end;
end;

procedure TZp110Dlg.MakeBox10(Ry:TRyPrinter; var PPos:Integer);
var
  q3,p1,p2,p3,p4:PChar;
begin
  with Ry do
    begin
      p1:=StrAlloc(Length(Label10_1.Caption)+1);
      StrPCopy(p1,Label10_1.Caption);
      p2:=StrAlloc(Length(Label10_2.Caption)+1);
      StrPCopy(p2,Label10_2.Caption);
      if Rb10_3.Checked
        then begin
          p3:=StrAlloc(Length(RB10_3.Caption)+Length(Edit10_4.Text)+1);
          StrPCopy(p3, RB10_3.Caption+Edit10_4.Text);
        end
      else if Rb10_5.Checked
        then begin
{          p3:=StrAlloc(Length(RB10_5.Caption)+Memo10_6.GetTextLen+1);
          StrPCopy(p3, Rb10_5.Caption);
          q3:=StrAlloc(Memo10_6.GetTextLen + 1);
          Memo10_6.GetTextBuf(q3, Memo10_6.GetTextLen+1);
          StrCat(p3,q3);}
          p3:=StrAlloc(Memo10_6.GetTextLen+1);
          Memo10_6.GetTextBuf(p3, Memo10_6.GetTextLen+1);
        end
      else p3:=Nil;
      p4:=StrAlloc(Length(Label10_7.Caption)+Length(Date10_8.Text)+
                   Length(Label10_9.Caption)+Length(Time10_10.Text)+1);
      StrPCopy(p4,Label10_7.Caption+Date10_8.Text+Label10_9.Caption+Time10_10.Text);
      AddZp1Box(Ry,'10',[p1,p2,p3,p4],[1,1,1,1],ZP110Tit,'110',NumEdit.Text,PrintSpace,PPos);
      StrDispose(p1);
      StrDispose(p2);
      StrDispose(p3);
      StrDispose(p4);
    end;
end;

procedure TZp110Dlg.MakeBox11(Ry:TRyPrinter; var PPos:Integer);
var
  q3,p1,p2,p3:PChar;
begin
  with Ry do
    begin
      q3:=Nil;p3:=Nil;
      p1:=StrAlloc(Length(Label11_1.Caption)+1);
      StrPCopy(p1,Label11_1.Caption);
      p2:=StrAlloc(Length(Label11_2.Caption)+Length(Date11_3.Text)+
                   Length(Label11_4.Caption)+Length(Time11_5.Text)+1);
      StrPCopy(p2,Label11_2.Caption+Date11_3.Text+Label11_4.Caption+Time11_5.Text);
      if Rb11_6.Checked
        then begin
          p3:=StrAlloc(Length(RB11_6.Caption)+Length(Edit11_7.Text)+1);
          StrPCopy(p3, RB11_6.Caption+Edit11_7.Text);
        end
      else if Rb11_8.Checked
        then begin
{          p3:=StrAlloc(Length(RB11_8.Caption)+Memo11_9.GetTextLen+1);
          StrPCopy(p3, Rb11_8.Caption);
          q3:=StrAlloc(Memo11_9.GetTextLen + 1);
          Memo11_9.GetTextBuf(q3, Memo11_9.GetTextLen+1);
          StrCat(p3,q3);}
          p3:=StrAlloc(Memo11_9.GetTextLen+1);
          Memo11_9.GetTextBuf(p3, Memo11_9.GetTextLen+1);
        end;
      AddZp1Box(Ry,'11',[p1,p2,p3],[1,1,1],ZP110Tit,'110',NumEdit.Text,PrintSpace,PPos);
      StrDispose(p1);
      StrDispose(p2);
      StrDispose(p3);
    end;
end;

function TZp110Dlg.GetBox12Len(Ry:TRyPrinter):Integer;
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
      p:=StrAlloc(Length(Label12_1.Caption)+1);
      StrPCopy(p,Label12_1.Caption);
      X:=MemoOut(Rect(Tx,LP,Rct.Right-Xmm(3),100), p, False, TRUE);
      StrDispose(p);
      LP:=LP+X+Ymm(1);
      Y:=Rct.Right-Xmm(7)-TextWidth(SG12_2.Cells[1,0]);
      Z:=LP;
      LP:=LP+LH;
      i:=1;
      while (i<SG12_2.RowCount) do
        begin
          if (SG12_2.Cells[0,i]<>'')
            then begin
              p:=StrAlloc(Length(SG12_2.Cells[0,i])+1);
              StrPCopy(p,SG12_2.Cells[0,i]);
              X:=MemoOut(Rect(Tx,LP,Y-Xmm(3),100), p, False, TRUE);
              StrDispose(p);
              LP:=LP+X+Ymm(1);
            end;
          Inc(i);
        end;
      Result:=LP+Ymm(1);
    end;
end;

procedure TZp110Dlg.MakeBox12(Ry:TRyPrinter; var PPos:Integer);
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
      p:=StrAlloc(Length(Label12_1.Caption)+1);
      StrPCopy(p,Label12_1.Caption);
      X:=MemoOut(Rect(Tx,LP,Rct.Right-Xmm(3),100), p, False, False);
      StrDispose(p);
      LP:=LP+X+Ymm(1);
      TextOut(Tx,LP,SG12_2.Cells[0,0]);
      TextOutRight(Rct.Right-Xmm(5),LP,SG12_2.Cells[1,0]);
      Y:=Rct.Right-Xmm(7)-TextWidth(SG12_2.Cells[1,0]);
      Z:=LP;
      LP:=LP+LH;
      i:=1;
      while (i<SG12_2.RowCount) do
        begin
          if (SG12_2.Cells[0,i]<>'')
            then begin
              Line(Point(Tx,LP),Point(Rct.Right,LP));
              p:=StrAlloc(Length(SG12_2.Cells[0,i])+1);
              StrPCopy(p,SG12_2.Cells[0,i]);
              X:=MemoOut(Rect(Tx,LP,Y-Xmm(3),100), p, False, False);
              StrDispose(p);
              TextOut(Y+Xmm(5),LP,SG12_2.Cells[1,i]);
              LP:=LP+X+Ymm(1);
            end;
          Inc(i);
        end;
      Rct.Bottom:=LP+Ymm(1);
      RoundRectangle(Rct);
      Line(Point(Tx-Xmm(3),Rct.Top),Point(Tx-Xmm(3),Rct.Bottom));
      Line(Point(Y,Z),Point(Y,Rct.Bottom));
      TextOutCenter(((Tx-Xmm(3)-Rct.Left) div 2)+Rct.Left,Rct.Top+Ymm(4),'12');
      PPos:=Rct.Bottom;
    end;
end;

procedure TZp110Dlg.MakeUZPPage(Ry:TRyPrinter;PPos:Integer);
var
  X:Integer;
p:PChar;
begin
  with Ry do
    begin
      NewPage;
      Font.Name:='Times New Roman CE';
      PPos:=YTOff;
      MakeZpNumStr(Ry,XROff-Xmm(4),'110',PPos);
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

procedure TZp110Dlg.MakePrint;
var
  p,q,r:PChar;
begin
    with Ry do
      begin
        NewJob;
        SetMinMargins(Xmm(20),Ymm(10),Xmm(20),Ymm(10));
        MakeHeader(Ry,Zp110Tit,'110',NumEdit.Text,'',PPos);
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
        MakeBox9(Ry,PPos);
        MakeBox10(Ry,PPos);
        MakeBox11(Ry,PPos);
        if GetBox12Len(Ry)+PPos+Ymm(3)>PrintSpace
          then MakeNewPage(Ry,Zp110Tit,'110',NumEdit.Text,PPos,PrintSpace);
        MakeBox12(Ry,PPos);
        MakeUZPPage(Ry,PPos);
      end;
end;

procedure TZp110Dlg.PreviewBtnClick(Sender: TObject);
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

procedure TZp110Dlg.PrintBtnClick(Sender: TObject);
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

procedure TZp110Dlg.SaveFile;
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
      SaveString(Zp110FileHdr,FHandle);
      SaveString(FilePwd,FHandle);
      MakeCodeKey(FilePwd);
      SaveEdit(NumEdit,FHandle);
      SaveMemo(Memo1_2,FHandle);
      SaveEdit(Edit1_5,FHandle);
      SaveMaskEdit(MaskEdit1_6,FHandle);
      SaveEdit(Edit1_10,FHandle);
      SaveEdit(Edit1_11,FHandle);
      SaveEdit(Edit1_12,FHandle);
      SaveEdit(Edit1_16,FHandle);
      SaveEdit(Edit1_17,FHandle);
      SaveEdit(Edit1_18,FHandle);
      SaveMaskEdit(MaskEdit1_20,FHandle);
      SaveBoolean(RB1_21.Checked,FHandle);
      SaveBoolean(RB1_22.Checked,FHandle);
      SaveMaskEdit(MaskEdit1_24,FHandle);
      SaveMaskEdit(MaskEdit1_25,FHandle);
      SaveMemo(Memo2_2,FHandle);
      SaveEdit(Edit2_4,FHandle);
      SaveBoolean(RB2_6.Checked,FHandle);
      SaveBoolean(RB2_7.Checked,FHandle);
      SaveBoolean(RB2_8.Checked,FHandle);
      SaveEdit(Edit2_10,FHandle);
      SaveMaskEdit(MaskEdit2_12,FHandle);
      SaveEdit(Edit2_14,FHandle);
      SaveDateTime(Date3_2.EditDate,FHandle);
      SaveComboBox(CB4_2,FHandle);
      SaveComboBox(CB5_2,FHandle);
      SaveReal(Edit6_3.Value,FHandle);
      SaveEdit(Edit6_6,FHandle);
      SaveBoolean(RB7_3.Checked,FHandle);
      SaveEdit(Edit7_4,FHandle);
      SaveBoolean(RB7_5.Checked,FHandle);
      SaveMemo(Memo7_6,FHandle);
      SaveReal(Edit7_9.Value,FHandle);
      SaveEdit(Edit7_12,FHandle);
      SaveEdit(Edit8_3,FHandle);
      SaveEdit(Edit8_5,FHandle);
      SaveEdit(Edit8_7,FHandle);
      SaveDateTime(Time8_9.EditTime,FHandle);
      SaveDateTime(Time8_11.EditTime,FHandle);
      SaveMemo(Memo9_4,FHandle);
      SaveBoolean(RB10_3.Checked,FHandle);
      SaveEdit(Edit10_4,FHandle);
      SaveBoolean(RB10_5.Checked,FHandle);
      SaveMemo(Memo10_6,FHandle);
      SaveDateTime(Date10_8.EditDate,FHandle);
      SaveDateTime(Time10_10.EditTime,FHandle);
      SaveDateTime(Date11_3.EditDate,FHandle);
      SaveDateTime(Time11_5.EditTime,FHandle);
      SaveBoolean(RB11_6.Checked,FHandle);
      SaveEdit(Edit11_7,FHandle);
      SaveBoolean(RB11_8.Checked,FHandle);
      SaveMemo(Memo11_9,FHandle);
      SaveStringGrid(SG12_2,FHandle);
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

procedure TZp110Dlg.LoadBox1;
var
  b:Boolean;
begin
  LoadMemo(Memo1_2,FHandle);
  LoadEdit(Edit1_5,FHandle);
  LoadMaskEdit(MaskEdit1_6,FHandle);
  LoadEdit(Edit1_10,FHandle);
  LoadEdit(Edit1_11,FHandle);
  LoadEdit(Edit1_12,FHandle);
  LoadEdit(Edit1_16,FHandle);
  LoadEdit(Edit1_17,FHandle);
  LoadEdit(Edit1_18,FHandle);
  LoadMaskEdit(MaskEdit1_20,FHandle);
  LoadBoolean(b,FHandle);
  RB1_21.Checked:=b;
  LoadBoolean(b,FHandle);
  RB1_22.Checked:=b;
  LoadMaskEdit(MaskEdit1_24,FHandle);
  LoadMaskEdit(MaskEdit1_25,FHandle);
end;

procedure TZp110Dlg.LoadFile;
var
  s:String;
  i:Integer;
  DT:TDateTime;
  B:Boolean;
  r:Real;
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
        if s=Zp110FileHdr
          then begin
            LoadString(s,FHandle);
            if (s=FilePwd)
              then begin
                MakeCodeKey(FilePwd);
                LoadEdit(NumEdit,FHandle);
                LoadBox1;
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
                LoadDateTime(DT,FHandle);
                Date3_2.EditDate:=DT;
                LoadComboBox(CB4_2,FHandle);
                LoadComboBox(CB5_2,FHandle);
                LoadReal(r,FHandle);
                Edit6_3.Value:=r;
                LoadEdit(Edit6_6,FHandle);
                LoadBoolean(B,FHandle);
                RB7_3.Checked:=B;
                LoadEdit(Edit7_4,FHandle);
                LoadBoolean(B,FHandle);
                RB7_5.Checked:=B;
                LoadMemo(Memo7_6,FHandle);
                LoadReal(r,FHandle);
                Edit7_9.Value:=r;
                LoadEdit(Edit7_12,FHandle);
                LoadEdit(Edit8_3,FHandle);
                LoadEdit(Edit8_5,FHandle);
                LoadEdit(Edit8_7,FHandle);
                LoadDateTime(DT,FHandle);
                Time8_9.EditTime:=DT;
                LoadDateTime(DT,FHandle);
                Time8_11.EditTime:=DT;
                LoadMemo(Memo9_4,FHandle);
                LoadBoolean(B,FHandle);
                RB10_3.Checked:=B;
                LoadEdit(Edit10_4,FHandle);
                LoadBoolean(B,FHandle);
                RB10_5.Checked:=B;
                LoadMemo(Memo10_6,FHandle);
                LoadDateTime(DT,FHandle);
                Date10_8.EditDate:=DT;
                LoadDateTime(DT,FHandle);
                Time10_10.EditTime:=DT;
                LoadDateTime(DT,FHandle);
                Date11_3.EditDate:=DT;
                LoadDateTime(DT,FHandle);
                Time11_5.EditTime:=DT;
                LoadBoolean(B,FHandle);
                RB11_6.Checked:=B;
                LoadEdit(Edit11_7,FHandle);
                LoadBoolean(B,FHandle);
                RB11_8.Checked:=B;
                LoadMemo(Memo11_9,FHandle);
                LoadStringGrid(TStringGrid(SG12_2),FHandle);
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

procedure TZp110Dlg.OpenBtnClick(Sender: TObject);
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

procedure TZp110Dlg.SaveBtnClick(Sender: TObject);
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

procedure TZp110Dlg.FormDestroy(Sender: TObject);
begin
  if FileIsOpen
    then begin
      CloseFile(FHandle);
      FileIsOpen:=FALSE;
    end;
end;

procedure TZp110Dlg.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key=#13
    then begin
      Key:=#0;
      Perform(wm_NextDlgCtl,0,0);
    end;
end;

procedure TZp110Dlg.OKBtnClick(Sender: TObject);
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

procedure TZp110Dlg.SiwzBtnClick(Sender: TObject);
var
  s:String;
  i:LongInt;
  x:Byte;
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
            Date3_2.EditDate:=EndDate;
            if PrefKrajowe
              then CB5_2.ItemIndex:=0
              else CB5_2.ItemIndex:=1;
            Edit6_3.Value:=WadiumEdit2_2;
            Edit6_6.Text:=WadiumEdit2_5;
            p:=StrAlloc(StrLen(WarunkiMemo1)+StrLen(WarunkiMemo2)+2);
            StrCopy(p,WarunkiMemo1);
            StrCat(p,WarunkiMemo2);
            Memo9_4.SetTextBuf(p);
            StrDispose(p);
            Date10_8.EditDate:=SkladDateEdit2_15;
            Time10_10.EditTime:=SkladTime2_17;
            Date11_3.EditDate:=OpeningDateEdit1_2;
            Time11_5.EditTime:=OpeningTime1_4;
            ClearSG12_2;
            if SG12_2.RowCount<PrtRec.SG.RowCount
              then SG12_2.RowCount:=PrtRec.SG.RowCount;
            for i:=1 to PrtRec.SG.RowCount-1 do
              begin
                SG12_2.Cells[0,i]:=PrtRec.SG.Cells[1,i];
                SG12_2.Cells[1,i]:=PrtRec.SG.Cells[3,i];
              end;
          end;
        FreePrtRec;
      end;
    OpenDialog.DefaultExt:='110';
    OpenDialog.Filter:='Druki ZP110|*.110';
{$ENDIF}
end;

procedure TZp110Dlg.HelpBtnClick(Sender: TObject);
begin
  Application.HelpContext(110);
end;

procedure TZP110Dlg.ClearSG12_2;
var
  i,j:LongInt;
begin
  for i:=0 to SG12_2.ColCount-1 do
    for j:=1 to SG12_2.RowCount-1 do
      SG12_2.Cells[i,j]:='';
end;

procedure TZp110Dlg.SG12_2KeyPress(Sender: TObject; var Key: Char);
var
  Rct:TGridRect;
begin
  if SG12_2.Selection.Left=1
    then begin
      if (not (Key in ['0'..'9',#8]))
        then Key:=#0
      else if (Length(SG12_2.Cells[SG12_2.Selection.Left,SG12_2.Selection.Top])>3) and
              (Key<>#8)
        then Key:=#0
      else if (SG12_2.Cells[SG12_2.Selection.Left,SG12_2.Selection.Top]<>'') and
              (Key<>#8) and
              (StrToInt(SG12_2.Cells[SG12_2.Selection.Left,SG12_2.Selection.Top]+Key)>100)
          then begin
            MessageDlg('Wartoœæ powyzej 100',mtError,[mbok],0);
            Key:=#0;
          end
      else if SG12_2.Cells[SG12_2.Selection.Left,SG12_2.Selection.Top]=''
          then SG12_2.Cells[SG12_2.Selection.Left,SG12_2.Selection.Top]:='0';
    end;
end;

procedure TZp110Dlg.AddBtnClick(Sender: TObject);
begin
  SG12_2.InsertRow(SG12_2.RowCount);
end;

procedure TZp110Dlg.InsertBtnClick(Sender: TObject);
begin
  SG12_2.InsertRow(SG12_2.Row);
end;

procedure TZp110Dlg.DelBtnClick(Sender: TObject);
begin
  SG12_2.DeleteRow(SG12_2.Row);
  if SG12_2.RowCount=1
    then SG12_2.InsertRow(SG12_2.RowCount);
end;

end.

