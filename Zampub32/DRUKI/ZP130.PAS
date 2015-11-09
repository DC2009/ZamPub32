unit Zp130;

interface

uses WinTypes, WinProcs, Classes, Graphics, Forms, Controls, Buttons,
  StdCtrls, ExtCtrls, Mask, TabNotBk, Grids, Spin, SysUtils,
  Messages, Dialogs, Printers,
  Utils,
  SiwzIni,
  UserUnit,
  PrtRecIo,
  ZpBoxes,
  SkOk,
  RPrev, TimeEdit, IntDate, NumInp, Sk;

type
  TZp130Dlg = class(TForm)
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
    Panel3: TPanel;
    Bevel4: TBevel;
    Label3: TLabel;
    Label3_1: TLabel;
    Panel11: TPanel;
    Panel4: TPanel;
    Bevel10: TBevel;
    Label4: TLabel;
    Label4_1: TLabel;
    Label4_2: TLabel;
    Memo4_4: TMemo;
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
    Date3_2: TIntDate;
    Label29: TLabel;
    NumEdit: TEdit;
    Panel2: TPanel;
    Bevel2: TBevel;
    Label2: TLabel;
    Label2_1: TLabel;
    Label2_16: TLabel;
    Label2_6: TLabel;
    Label2_8: TLabel;
    Label2_12: TLabel;
    Label2_14: TLabel;
    Memo2_5: TMemo;
    Edit2_17: TEdit;
    Edit2_7: TEdit;
    RB2_9: TRadioButton;
    RB2_10: TRadioButton;
    RB2_11: TRadioButton;
    Edit2_13: TEdit;
    MaskEdit2_15: TMaskEdit;
    Label2_2: TLabel;
    CB2_3: TComboBox;
    Label2_4: TLabel;
    Label4_3: TLabel;
    Panel5: TPanel;
    Label5_1: TLabel;
    Bevel3: TBevel;
    Label5: TLabel;
    Label5_2: TLabel;
    Label5_7: TLabel;
    Label5_10: TLabel;
    Label5_11: TLabel;
    Label5_13: TLabel;
    Label5_8: TLabel;
    Memo5_6: TMemo;
    RB5_3: TRadioButton;
    Edit5_4: TEdit;
    Rb5_5: TRadioButton;
    Edit5_12: TEdit;
    Edit5_9: TNumInp;
    Panel6: TPanel;
    Label6_1: TLabel;
    Bevel8: TBevel;
    Label6: TLabel;
    Label6_2: TLabel;
    Label6_4: TLabel;
    Label6_8: TLabel;
    Label6_10: TLabel;
    Label6_6: TLabel;
    Edit6_3: TEdit;
    Edit6_5: TEdit;
    Edit6_7: TEdit;
    Time6_9: TTimeEdit;
    Time6_11: TTimeEdit;
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
    Panel8: TPanel;
    Label13_1: TLabel;
    Label13_17: TLabel;
    Label13_18: TLabel;
    Label13_20: TLabel;
    Edit13_19: TEdit;
    Edit13_21: TEdit;
    procedure TimeEditExit(Sender: TObject);
    procedure NumEditKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure PreviewBtnClick(Sender: TObject);
    procedure RB1_21Click(Sender: TObject);
    procedure RB1_22Click(Sender: TObject);
    procedure OKBtnClick(Sender: TObject);
    procedure PrintBtnClick(Sender: TObject);
    procedure OpenBtnClick(Sender: TObject);
    procedure SaveBtnClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormDestroy(Sender: TObject);
    procedure SiwzBtnClick(Sender: TObject);
    procedure HelpBtnClick(Sender: TObject);
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
    procedure MakeBox1(Ry:TRyPrinter; var PPos:Integer);
    procedure MakeBox2(Ry:TRyPrinter; var PPos:Integer);
    procedure MakeBox3(Ry:TRyPrinter; var PPos:Integer);
    procedure MakeBox4(Ry:TRyPrinter; var PPos:Integer);
    procedure MakeBox5(Ry:TRyPrinter; var PPos:Integer);
    procedure MakeBox6(Ry:TRyPrinter; var PPos:Integer);
    procedure MakeBox7(Ry:TRyPrinter; var PPos:Integer);
    procedure MakeUZPPage(Ry:TRyPrinter;PPos:Integer);
  public
    { Public declarations }
  end;

var
  Zp130Dlg: TZp130Dlg;

procedure DrukZp130; export;

implementation

{$R *.DFM}

uses
  DrMsg,
  DateUtil;

procedure DrukZp130;
var
  Cur:Integer;
begin
  Cur:=Screen.Cursor;
  Screen.Cursor:=crHourGlass;
  ZP130Dlg:=TZp130Dlg.Create(Nil);
  Screen.Cursor:=Cur;
  ZP130Dlg.ShowModal;
  ZP130Dlg.Free;
end;

procedure TZp130Dlg.TimeEditExit(Sender: TObject);
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

procedure TZp130Dlg.NumEditKeyPress(Sender: TObject; var Key: Char);
begin
  if not (Key in ['0'..'9',#8])
    then begin
      Key:=#0;
      MessageBeep(0);
    end;
end;

procedure TZp130Dlg.FormCreate(Sender: TObject);
begin
  RB1_21.Checked:=TRUE;
  RB1_21Click(Sender);
  Application.HelpFile:=DruZpHelpFile;
  FilePwd:=LoadFilePwd(AddBackSlash(ProgramDir)+SecurityFileName);
end;

procedure TZp130Dlg.RB1_21Click(Sender: TObject);
begin
  MaskEdit1_24.Enabled:=TRUE;
  MaskEdit1_24.Color:=clWhite;
  MaskEdit1_25.Enabled:=FALSE;
  MaskEdit1_25.Color:=clGray;
end;

procedure TZp130Dlg.RB1_22Click(Sender: TObject);
begin
  MaskEdit1_24.Enabled:=FALSE;
  MaskEdit1_24.Color:=clGray;
  MaskEdit1_25.Enabled:=TRUE;
  MaskEdit1_25.Color:=clWhite;
end;

procedure TZp130Dlg.MakeBox1(Ry:TRyPrinter; var PPos:Integer);
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
        then StrPCopy(p7, NipGB1.Caption+MaskEdit1_25.Text)
      else StrPCopy(p7, NipGB1.Caption);
      AddZp1Box(Ry,'1',[p1,p2,p3,p4,p5,p6,p7],[1,1,1,1,1,1,1],ZP130Tit,'130',NumEdit.Text,PrintSpace,PPos);
      StrDispose(p1);
      StrDispose(p2);
      StrDispose(p3);
      StrDispose(p4);
      StrDispose(p5);
      StrDispose(p6);
      StrDispose(p7);
    end;
end;

procedure TZp130Dlg.MakeBox2(Ry:TRyPrinter; var PPos:Integer);
var
  p1,p2,p3,p4,p5,p6,p7:PChar;
  s:String;
begin
  with Ry do
    begin
      p1:=StrAlloc(Length(Label2_1.Caption)+Length(Label2_2.Caption)+Length(CB2_3.Text)+1);
      StrPCopy(p1, Label2_1.Caption+Label2_2.Caption+CB2_3.Text);
      p2:=StrAlloc(Length(Label2_4.Caption)+1);
      StrPCopy(p2, Label2_4.Caption);
      p3:=StrAlloc(Memo2_5.GetTextLen + 1);
      Memo2_5.GetTextBuf(p3, Memo2_5.GetTextLen+1);
      p4:=StrAlloc(Length(Label2_6.Caption)+Length(Edit2_7.Text)+1);
      StrPCopy(p4, Label2_6.Caption+Edit2_7.Text);
      s:='';
      if RB2_9.Checked
        then s:=RB2_9.Caption
      else if RB2_10.Checked
        then s:=RB2_10.Caption
      else if RB2_11.Checked
        then s:=RB2_11.Caption;
      p5:=StrAlloc(Length(Label2_8.Caption)+Length(s)+1);
      StrPCopy(p5, Label2_8.Caption+s);
      p6:=StrAlloc(Length(Label2_12.Caption)+Length(Edit2_13.Text)+1);
      StrPCopy(p6, Label2_12.Caption+Edit2_13.Text);
      p7:=StrAlloc(Length(Label2_14.Caption)+Length(MaskEdit2_15.Text)+
                   Length(Label2_16.Caption)+Length(Edit2_17.Text)+1);
      StrPCopy(p7, Label2_14.Caption+MaskEdit2_15.Text+Label2_16.Caption+Edit2_17.Text);
      AddZp1Box(Ry,'2',[p1,p2,p3,p4,p5,p6,p7],[1,1,1,1,1,1,1],ZP130Tit,'130',NumEdit.Text,PrintSpace,PPos);
      StrDispose(p1);
      StrDispose(p2);
      StrDispose(p3);
      StrDispose(p4);
      StrDispose(p5);
      StrDispose(p6);
      StrDispose(p7);
    end;
end;

procedure TZp130Dlg.MakeBox3(Ry:TRyPrinter; var PPos:Integer);
var
  p:PChar;
begin
  with Ry do
    begin
      p:=StrAlloc(Length(Label3_1.Caption)+Length(Date3_2.Text) + 1);
      StrPCopy(p,Label3_1.Caption+Date3_2.Text);
      AddZp1Box(Ry,'3',[p],[1],ZP130Tit,'130',NumEdit.Text,PrintSpace,PPos);
      StrDispose(p);
    end;
end;

procedure TZp130Dlg.MakeBox4(Ry:TRyPrinter; var PPos:Integer);
var
  p1,p2:PChar;
begin
  with Ry do
    begin
      p1:=StrAlloc(Length(Label4_1.Caption)+Length(Label4_2.Caption)+Length(Label4_3.Caption)+1);
      StrPCopy(p1,Label4_1.Caption+Label4_2.Caption+Label4_3.Caption);
      p2:=StrAlloc(Memo4_4.GetTextLen + 1);
      Memo4_4.GetTextBuf(p2, Memo4_4.GetTextLen+1);
      AddZp1Box(Ry,'4',[p1,p2],[1,1],ZP130Tit,'130',NumEdit.Text,PrintSpace,PPos);
      StrDispose(p1);
      StrDispose(p2);
    end;
end;

procedure TZp130Dlg.MakeBox5(Ry:TRyPrinter; var PPos:Integer);
var
  q3,p1,p2,p3,p4,p5,p6:PChar;
begin
  with Ry do
    begin
      q3:=Nil;
      p1:=StrAlloc(Length(Label5_1.Caption)+1);
      StrPCopy(p1,Label5_1.Caption);
      p2:=StrAlloc(Length(Label5_2.Caption)+1);
      StrPCopy(p2,Label5_2.Caption);
      if Rb5_3.Checked
        then begin
          p3:=StrAlloc(Length(RB5_3.Caption)+Length(Edit5_4.Text)+1);
          StrPCopy(p3, RB5_3.Caption+Edit5_4.Text);
        end
      else if Rb5_5.Checked
        then begin
          p3:=StrAlloc(Length(RB5_5.Caption)+Memo5_6.GetTextLen+1);
          StrPCopy(p3, Rb5_5.Caption);
          q3:=StrAlloc(Memo5_6.GetTextLen + 1);
          Memo5_6.GetTextBuf(q3, Memo5_6.GetTextLen+1);
          StrCat(p3,q3);
        end
      else p3:=Nil;
      p4:=StrAlloc(Length(Label5_7.Caption)+1);
      StrPCopy(p4,Label5_7.Caption);
      p5:=StrAlloc(Length(Label5_8.Caption)+Length(Edit5_9.Text)+Length(Label5_10.Caption)+1);
      StrPCopy(p5, Label5_8.Caption+Edit5_9.Text+Label5_10.Caption);
      p6:=StrAlloc(Length(Label5_11.Caption)+Length(Edit5_12.Text)+Length(Label5_13.Caption)+1);
      StrPCopy(p6, Label5_11.Caption+Edit5_12.Text+Label5_13.Caption);
      AddZp1Box(Ry,'5',[p1,p2,p3,p4,p5,p6],[1,1,1,1,1,1],ZP130Tit,'130',NumEdit.Text,PrintSpace,PPos);
      StrDispose(q3);
      StrDispose(p1);
      StrDispose(p2);
      StrDispose(p3);
      StrDispose(p4);
      StrDispose(p5);
      StrDispose(p6);
    end;
end;

procedure TZp130Dlg.MakeBox6(Ry:TRyPrinter; var PPos:Integer);
var
  p1,p2,p3,p4,p5:PChar;
begin
  with Ry do
    begin
      p1:=StrAlloc(Length(Label6_1.Caption)+1);
      StrPCopy(p1,Label6_1.Caption);
      p2:=StrAlloc(Length(Label6_2.Caption)+Length(Edit6_3.Text)+1);
      StrPCopy(p2,Label6_2.Caption+Edit6_3.Text);
      p3:=StrAlloc(Length(Label6_4.Caption)+Length(Edit6_5.Text)+1);
      StrPCopy(p3,Label6_4.Caption+Edit6_5.Text);
      p4:=StrAlloc(Length(Label6_6.Caption)+Length(Edit6_7.Text)+1);
      StrPCopy(p4,Label6_6.Caption+Edit6_7.Text);
      p5:=StrAlloc(Length(Label6_8.Caption)+Length(Time6_9.Text)+Length(Time6_11.Text)+5);
      StrPCopy(p5,Label6_8.Caption+Time6_9.Text+' - '+Time6_11.Text);
      AddZp1Box(Ry,'6',[p1,p2,p3,p4,p5],[1,1,1,1,1],ZP130Tit,'130',NumEdit.Text,PrintSpace,PPos);
      StrDispose(p1);
      StrDispose(p2);
      StrDispose(p3);
      StrDispose(p4);
      StrDispose(p5);
    end;
end;

procedure TZp130Dlg.MakeBox7(Ry:TRyPrinter; var PPos:Integer);
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
      AddZp1Box(Ry,'7',[p1,p2,p3,p4],[1,1,1,1],ZP130Tit,'130',NumEdit.Text,PrintSpace,PPos);
      StrDispose(p1);
      StrDispose(p2);
      StrDispose(p3);
      StrDispose(p4);
    end;
end;

procedure TZp130Dlg.MakeUZPPage(Ry:TRyPrinter;PPos:Integer);
var
  X:Integer;
p:PChar;
begin
  with Ry do
    begin
      NewPage;
      Font.Name:='Times New Roman CE';
      PPos:=YTOff;
      MakeZpNumStr(Ry,XROff-Xmm(4),'130',PPos);
      PPos:=PPos+Ymm(10);
      MakeUZPTitle(Ry,Label13_1.Caption,PPos);
      Font.Size:=12;
      Font.Style:=[];
{1}
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

      PPos:=PPos+Ymm(30);
      Font.Size:=8;
      TextOutRight(XROff-Xmm(5),PPos,'imiê, nazwisko i podpis osoby uprawnionej');
    end;
end;

procedure TZp130Dlg.MakePrint;
var
  p,q,r:PChar;
begin
    with Ry do
      begin
        NewJob;
        SetMinMargins(Xmm(20),Ymm(10),Xmm(20),Ymm(10));
        MakeHeader(Ry,Zp130Tit,'130',NumEdit.Text,'',PPos);
        PrintSpace:=YBOff-Ymm(35);
        MakeFooter(Ry,PrintSpace);
        MakeBox1(Ry,PPos);
        MakeBox2(Ry,PPos);
        MakeBox3(Ry,PPos);
        MakeBox4(Ry,PPos);
        MakeBox5(Ry,PPos);
        MakeBox6(Ry,PPos);
        MakeBox7(Ry,PPos);
        MakeUZPPage(Ry,PPos);
      end;
end;

procedure TZp130Dlg.PreviewBtnClick(Sender: TObject);
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

procedure TZp130Dlg.PrintBtnClick(Sender: TObject);
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

procedure TZp130Dlg.SaveFile;
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
      SaveString(Zp130FileHdr,FHandle);
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
      SaveComboBox(CB2_3,FHandle);
      SaveMemo(Memo2_5,FHandle);
      SaveEdit(Edit2_7,FHandle);
      SaveBoolean(RB2_9.Checked,FHandle);
      SaveBoolean(RB2_10.Checked,FHandle);
      SaveBoolean(RB2_11.Checked,FHandle);
      SaveEdit(Edit2_13,FHandle);
      SaveMaskEdit(MaskEdit2_15,FHandle);
      SaveEdit(Edit2_17,FHandle);
      SaveDateTime(Date3_2.EditDate,FHandle);
      SaveMemo(Memo4_4,FHandle);
      SaveBoolean(RB5_3.Checked,FHandle);
      SaveEdit(Edit5_4,FHandle);
      SaveBoolean(RB5_5.Checked,FHandle);
      SaveMemo(Memo5_6,FHandle);
      SaveReal(Edit5_9.Value,FHandle);
      SaveEdit(Edit5_12,FHandle);
      SaveEdit(Edit6_3,FHandle);
      SaveEdit(Edit6_5,FHandle);
      SaveEdit(Edit6_7,FHandle);
      SaveDateTime(Time6_9.EditTime,FHandle);
      SaveDateTime(Time6_11.EditTime,FHandle);
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

procedure TZp130Dlg.LoadFile;
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
        if s=Zp130FileHdr
          then begin
            LoadString(s,FHandle);
            if (s=FilePwd)
              then begin
                MakeCodeKey(FilePwd);
                LoadEdit(NumEdit,FHandle);
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
                LoadComboBox(CB2_3,FHandle);
                LoadMemo(Memo2_5,FHandle);
                LoadEdit(Edit2_7,FHandle);
                LoadBoolean(B,FHandle);
                RB2_9.Checked:=B;
                LoadBoolean(B,FHandle);
                RB2_10.Checked:=B;
                LoadBoolean(B,FHandle);
                RB2_11.Checked:=B;
                LoadEdit(Edit2_13,FHandle);
                LoadMaskEdit(MaskEdit2_15,FHandle);
                LoadEdit(Edit2_17,FHandle);
                LoadDateTime(DT,FHandle);
                Date3_2.EditDate:=DT;
                LoadMemo(Memo4_4,FHandle);
                LoadBoolean(B,FHandle);
                RB5_3.Checked:=B;
                LoadEdit(Edit5_4,FHandle);
                LoadBoolean(B,FHandle);
                RB5_5.Checked:=B;
                LoadMemo(Memo5_6,FHandle);
                LoadReal(r,FHandle);
                Edit5_9.Value:=r;
                LoadEdit(Edit5_12,FHandle);
                LoadEdit(Edit6_3,FHandle);
                LoadEdit(Edit6_5,FHandle);
                LoadEdit(Edit6_7,FHandle);
                LoadDateTime(DT,FHandle);
                Time6_9.EditTime:=DT;
                LoadDateTime(DT,FHandle);
                Time6_11.EditTime:=DT;
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

procedure TZp130Dlg.OpenBtnClick(Sender: TObject);
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

procedure TZp130Dlg.SaveBtnClick(Sender: TObject);
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

procedure TZp130Dlg.FormDestroy(Sender: TObject);
begin
  if FileIsOpen
    then begin
      CloseFile(FHandle);
      FileIsOpen:=FALSE;
    end;
end;

procedure TZp130Dlg.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key=#13
    then begin
      Key:=#0;
      Perform(wm_NextDlgCtl,0,0);
    end;
end;

procedure TZp130Dlg.OKBtnClick(Sender: TObject);
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

procedure TZp130Dlg.SiwzBtnClick(Sender: TObject);
var
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
            Memo2_5.SetTextBuf(ObjectMemo);
            RB2_9.Checked:=OKind=okDostawa;
            RB2_10.Checked:=OKind=okUslugi;
            RB2_11.Checked:=OKind=okRobBud;
            Date3_2.EditDate:=EndDate;
            p:=StrAlloc(StrLen(WarunkiMemo1)+StrLen(WarunkiMemo2)+1);
            StrCopy(p,WarunkiMemo1);
            StrCat(p,WarunkiMemo2);
            Memo4_4.SetTextBuf(p);
            StrDispose(p);
          end;
        FreePrtRec;
      end;
    OpenDialog.DefaultExt:='130';
    OpenDialog.Filter:='Druki ZP130|*.130';
{$ENDIF}
end;

procedure TZp130Dlg.HelpBtnClick(Sender: TObject);
begin
  Application.HelpContext(130);
end;

end.

