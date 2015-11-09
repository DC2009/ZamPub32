unit Zp150;

interface

uses WinTypes, WinProcs, Classes, Graphics, Forms, Controls, Buttons,
  StdCtrls, ExtCtrls, Mask, TabNotBk, Grids, Spin, SysUtils,
  Messages, Dialogs, Printers,
  Utils,
  SiwzIni,
  SkOk,
  UserUnit,
  PrtRecIo,
  ZpBoxes,
  RPrev, IntDate, NumInp, Sk;

type
  TZp150Dlg = class(TForm)
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
    Panel4: TPanel;
    Bevel5: TBevel;
    Label4: TLabel;
    Label4_1: TLabel;
    Label4_4: TLabel;
    Label4_2: TLabel;
    Edit4_5: TEdit;
    Panel6b: TPanel;
    Bevel6: TBevel;
    Label6b: TLabel;
    Label6b_1: TLabel;
    Panel5: TPanel;
    Label5_4: TLabel;
    Label5_1: TLabel;
    Bevel3: TBevel;
    Label6: TLabel;
    Label5_2: TLabel;
    Panel6a: TPanel;
    Label7_7: TLabel;
    Label6a_4: TLabel;
    Label6a_8: TLabel;
    Label6a_7: TLabel;
    Label6a_1: TLabel;
    Bevel7: TBevel;
    Label6a: TLabel;
    Label6a_9: TLabel;
    Label6a_2: TLabel;
    MaskEdit6a_6: TMaskEdit;
    Edit6a_11: TEdit;
    Memo6a_3: TMemo;
    Edit6a_12: TEdit;
    Panel11: TPanel;
    Label3_2: TLabel;
    Label3_4: TLabel;
    Label3_6: TLabel;
    Edit3_3: TEdit;
    Edit3_7: TEdit;
    Edit4_3: TEdit;
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
    Edit6a_5: TEdit;
    Edit6a_10: TEdit;
    NumEdit: TEdit;
    Label29: TLabel;
    Memo1_27: TMemo;
    Label1_26: TLabel;
    Panel2: TPanel;
    Bevel2: TBevel;
    Label2: TLabel;
    Label2_1: TLabel;
    Label2_7: TLabel;
    Label2_3: TLabel;
    Label2_5: TLabel;
    Memo2_2: TMemo;
    Edit2_8: TEdit;
    Edit2_4: TEdit;
    MaskEdit2_6: TMaskEdit;
    Edit3_5: TEdit;
    Edit5_3: TNumInp;
    Edit5_5: TNumInp;
    Label6a_19: TLabel;
    Edit6a_20: TNumInp;
    Label6a_13: TLabel;
    Edit6a_16: TEdit;
    Label6a_14: TLabel;
    Label6a_15: TLabel;
    Label6a_21: TLabel;
    Label6a_23: TLabel;
    Edit6a_22: TEdit;
    RB6b_2: TRadioButton;
    RB6b_3: TRadioButton;
    RB6b_5: TRadioButton;
    Label6b_4: TLabel;
    Label6b_6: TLabel;
    Label6a_24: TLabel;
    Edit6a_17: TEdit;
    Edit6a_18: TEdit;
    Sk: TSmartKey;
    procedure TimeEditExit(Sender: TObject);
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
    procedure MakeBox6a(Ry:TRyPrinter; var PPos:Integer);
    procedure MakeBox6b(Ry:TRyPrinter; var PPos:Integer);
  public
    { Public declarations }
  end;

var
  Zp150Dlg: TZp150Dlg;

procedure DrukZp150;export;

implementation

{$R *.DFM}

uses
  DrMsg,
  DateUtil;

procedure DrukZp150;
var
  Cur:Integer;
begin
  Cur:=Screen.Cursor;
  Screen.Cursor:=crHourGlass;
  ZP150Dlg:=TZp150Dlg.Create(Nil);
  Screen.Cursor:=Cur;
  ZP150Dlg.ShowModal;
  ZP150Dlg.Free;
end;

procedure TZp150Dlg.TimeEditExit(Sender: TObject);
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

procedure TZp150Dlg.NumEditKeyPress(Sender: TObject; var Key: Char);
begin
  if not (Key in ['0'..'9',#8])
    then begin
      Key:=#0;
      MessageBeep(0);
    end;
end;

procedure TZp150Dlg.FormCreate(Sender: TObject);
begin
  Application.HelpFile:=DruZpHelpFile;
  FilePwd:=LoadFilePwd(AddBackSlash(ProgramDir)+SecurityFileName);
  RB1_21.Checked:=TRUE;
  RB1_21Click(Sender);
end;

procedure TZp150Dlg.RB1_21Click(Sender: TObject);
begin
  MaskEdit1_24.Enabled:=TRUE;
  MaskEdit1_24.Color:=clWhite;
  MaskEdit1_25.Enabled:=FALSE;
  MaskEdit1_25.Color:=clGray;
end;

procedure TZp150Dlg.RB1_22Click(Sender: TObject);
begin
  MaskEdit1_24.Enabled:=FALSE;
  MaskEdit1_24.Color:=clGray;
  MaskEdit1_25.Enabled:=TRUE;
  MaskEdit1_25.Color:=clWhite;
end;

procedure TZp150Dlg.MakeBox1(Ry:TRyPrinter; var PPos:Integer);
var
  p1,p2,p3,p4,p5,p6,p7,p8,p9,p10:PChar;
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
      s:='Wydzia³ prowadz¹cy sprawê:';
      p6:=StrAlloc(Length(s)+1);
      StrPCopy(p6,s);
      p7:=StrAlloc(Memo1_27.GetTextLen + 1);
      Memo1_27.GetTextBuf(p7, Memo1_27.GetTextLen+1);
      s:='Telefon: '+Edit1_16.Text;
      p8:=StrAlloc(Length(s)+1);
      StrPCopy(p8,s);
      s:='Telefaks: '+Edit1_17.Text;
      p9:=StrAlloc(Length(s)+1);
      StrPCopy(p9,s);
      s:='Teleks: '+Edit1_18.Text;
      p10:=StrAlloc(Length(s)+1);
      StrPCopy(p10,s);
      AddZp1Box(Ry,'1',[p1,p2,p3,p4,p5,p6,p7,p8,p9,p10],[1,1,1,1,2,1,2,1,1,1],ZP150Tit,'150',NumEdit.Text,PrintSpace,PPos);
      StrDispose(p1);
      StrDispose(p2);
      StrDispose(p3);
      StrDispose(p4);
      StrDispose(p5);
      StrDispose(p6);
      StrDispose(p7);
      StrDispose(p8);
      StrDispose(p9);
      StrDispose(p10);
    end;
end;

procedure TZp150Dlg.MakeBox2(Ry:TRyPrinter; var PPos:Integer);
var
  p1,p2,p3,p4:PChar;
begin
  with Ry do
    begin
      p1:=StrAlloc(Length(Label2_1.Caption)+1);
      StrPCopy(p1, Label2_1.Caption);
      p2:=StrAlloc(Memo2_2.GetTextLen + 1);
      Memo2_2.GetTextBuf(p2, Memo2_2.GetTextLen+1);
      p3:=StrAlloc(Length(Label2_3.Caption)+Length(Edit2_4.Text)+1);
      StrPCopy(p3, Label2_3.Caption+Edit2_4.Text);
      p4:=StrAlloc(Length(Label2_5.Caption)+Length(MaskEdit2_6.Text)+
                   Length(Label2_7.Caption)+Length(Edit2_8.Text)+1);
      StrPCopy(p4, Label2_5.Caption+MaskEdit2_6.Text+Label2_7.Caption+Edit2_8.Text);
      AddZp1Box(Ry,'2',[p1,p2,p3,p4],[1,1,1,1],ZP150Tit,'150',NumEdit.Text,PrintSpace,PPos);
      StrDispose(p1);
      StrDispose(p2);
      StrDispose(p3);
      StrDispose(p4);
    end;
end;

procedure TZp150Dlg.MakeBox3(Ry:TRyPrinter; var PPos:Integer);
var
  p1,p2:PChar;
begin
  with Ry do
    begin
      p1:=StrAlloc(Length(Label3_1.Caption)+1);
      StrPCopy(p1,Label3_1.Caption);
      p2:=StrAlloc(Length(Label3_2.Caption)+Length(Edit3_3.Text)+
                   Length(Label3_4.Caption)+Length(Edit3_5.Text)+
                   Length(Label3_6.Caption)+Length(Edit3_7.Text) + 1);
      StrPCopy(p2,Label3_2.Caption+Edit3_3.Text+Label3_4.Caption+
                  Edit3_5.Text+Label3_6.Caption+Edit3_7.Text);
      AddZp1Box(Ry,'3',[p1,p2],[1,1],ZP150Tit,'150',NumEdit.Text,PrintSpace,PPos);
      StrDispose(p1);
      StrDispose(p2);
    end;
end;

procedure TZp150Dlg.MakeBox4(Ry:TRyPrinter; var PPos:Integer);
var
  p1,p2:PChar;
begin
  with Ry do
    begin
      p1:=StrAlloc(Length(Label4_1.Caption)+1);
      StrPCopy(p1,Label4_1.Caption);
      p2:=StrAlloc(Length(Label4_2.Caption)+Length(Edit4_3.Text)+
                   Length(Label4_4.Caption)+Length(Edit4_5.Text)+1);
      StrPCopy(p2,Label4_2.Caption+Edit4_3.Text+Label4_4.Caption+Edit4_5.Text);
      AddZp1Box(Ry,'4',[p1,p2],[1,1],ZP150Tit,'150',NumEdit.Text,PrintSpace,PPos);
      StrDispose(p1);
      StrDispose(p2);
    end;
end;

procedure TZp150Dlg.MakeBox5(Ry:TRyPrinter; var PPos:Integer);
var
  p1,p2,p3:PChar;
begin
  with Ry do
    begin
      p1:=StrAlloc(Length(Label5_1.Caption)+1);
      StrPCopy(p1,Label5_1.Caption);
      p2:=StrAlloc(Length(Label5_2.Caption)+Length(Edit5_3.Text)+1);
      StrPCopy(p2,Label5_2.Caption+Edit5_3.Text);
      p3:=StrAlloc(Length(Label5_4.Caption)+Length(Edit5_5.Text)+1);
      StrPCopy(p3,Label5_4.Caption+Edit5_5.Text);
      AddZp1Box(Ry,'5',[p1,p2,p3],[1,1,1],ZP150Tit,'150',NumEdit.Text,PrintSpace,PPos);
      StrDispose(p1);
      StrDispose(p2);
      StrDispose(p3);
    end;
end;

procedure TZp150Dlg.MakeBox6a(Ry:TRyPrinter; var PPos:Integer);
var
  q,p1,p2,p3,p4,p5,p6,p7:PChar;
begin
  with Ry do
    begin
      p1:=StrAlloc(Length(Label6a_1.Caption)+1);
      StrPCopy(p1,Label6a_1.Caption);
      p2:=StrAlloc(Length(Label6a_2.Caption)+Memo6a_3.GetTextLen+1);
      StrPCopy(p2,Label6a_2.Caption);
      q:=StrAlloc(Memo6a_3.GetTextLen + 1);
      Memo6a_3.GetTextBuf(q, Memo6a_3.GetTextLen+1);
      StrCat(p2,q);
      p3:=StrAlloc(Length(Label6a_4.Caption)+Length(Edit6a_5.Text)+Length(Label6a_24.Caption)+Length(MaskEdit6a_6.Text)+1);
      StrPCopy(p3,Label6a_4.Caption+Edit6a_5.Text+Label6a_24.Caption+MaskEdit6a_6.Text);
      p4:=StrAlloc(Length(Label6a_7.Caption)+Length(Edit6a_10.Text)+Length(Label6a_8.Caption)+Length(Edit6a_11.Text)+
                   Length(Label6a_9.Caption)+Length(Edit6a_12.Text)+1);
      StrPCopy(p4, Label6a_7.Caption+Edit6a_10.Text+Label6a_8.Caption+
               Edit6a_11.Text+Label6a_9.Caption+Edit6a_12.Text);
      p5:=StrAlloc(Length(Label6a_13.Caption)+Length(Edit6a_16.Text)+Length(Label6a_14.Caption)+Length(Edit6a_17.Text)+
                  Length(Label6a_15.Caption)+Length(Edit6a_18.Text)+1);
      StrPCopy(p5, Label6a_13.Caption+Edit6a_16.Text+Label6a_14.Caption+Edit6a_17.Text+Label6a_15.Caption+Edit6a_18.Text);
      p6:=StrAlloc(Length(Label6a_19.Caption)+Length(Edit6a_20.Text)+1);
      StrPCopy(p6,Label6a_19.Caption+Edit6a_20.Text);
      p7:=StrAlloc(Length(Label6a_21.Caption)+Length(Edit6a_22.Text)+Length(Label6a_23.Caption)+1);
      StrPCopy(p7,Label6a_21.Caption+Edit6a_22.Text+Label6a_23.Caption);
      AddZp1Box(Ry,'6a',[p1,p2,p3,p4,p5,p6,p7],[1,1,1,1,1,1,1],ZP150Tit,'150',NumEdit.Text,PrintSpace,PPos);
      StrDispose(q);
      StrDispose(p1);
      StrDispose(p2);
      StrDispose(p3);
      StrDispose(p4);
      StrDispose(p5);
      StrDispose(p6);
      StrDispose(p7);
    end;
end;

procedure TZp150Dlg.MakeBox6b(Ry:TRyPrinter; var PPos:Integer);
var
  p1,p2:PChar;
  s:String;
begin
  with Ry do
    begin
      p1:=StrAlloc(Length(Label6b_1.Caption)+1);
      StrPCopy(p1,Label6b_1.Caption);
      s:='';
      if RB6b_2.Checked
        then s:=RB6b_2.Caption
      else if RB6b_3.Checked
        then s:=RB6b_3.Caption + Label6b_4.Caption
      else if RB6b_5.Checked
        then s:=RB6b_5.Caption + Label6b_6.Caption;
      p2:=StrAlloc(Length(s)+1);
      StrPCopy(p2,s);
      AddZp1Box(Ry,'6b',[p1,p2],[1,1],ZP150Tit,'150',NumEdit.Text,PrintSpace,PPos);
      StrDispose(p1);
      StrDispose(p2);
    end;
end;

procedure TZp150Dlg.MakePrint;
var
  p,q,r:PChar;
begin
    with Ry do
      begin
        NewJob;
        SetMinMargins(Xmm(20),Ymm(10),Xmm(20),Ymm(10));
        MakeHeader(Ry,Zp150Tit,'150',NumEdit.Text,'',PPos);
        PrintSpace:=YBOff-Ymm(35);
        MakeFooter(Ry,PrintSpace);
        MakeBox1(Ry,PPos);
        MakeBox2(Ry,PPos);
        MakeBox3(Ry,PPos);
        MakeBox4(Ry,PPos);
        MakeBox5(Ry,PPos);
        MakeBox6a(Ry,PPos);
        MakeBox6b(Ry,PPos);
      end;
end;

procedure TZp150Dlg.PreviewBtnClick(Sender: TObject);
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

procedure TZp150Dlg.PrintBtnClick(Sender: TObject);
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

procedure TZp150Dlg.SaveFile;
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
      SaveString(Zp150FileHdr,FHandle);
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
      SaveMemo(Memo1_27,FHandle);
      SaveMemo(Memo2_2,FHandle);
      SaveEdit(Edit2_4,FHandle);
      SaveMaskEdit(MaskEdit2_6,FHandle);
      SaveEdit(Edit2_8,FHandle);
      SaveEdit(Edit3_3,FHandle);
      SaveEdit(Edit3_5,FHandle);
      SaveEdit(Edit3_7,FHandle);
      SaveEdit(Edit4_3,FHandle);
      SaveEdit(Edit4_5,FHandle);
      SaveReal(Edit5_3.Value,FHandle);
      SaveReal(Edit5_5.Value,FHandle);
      SaveMemo(Memo6a_3,FHandle);
      SaveEdit(Edit6a_5,FHandle);
      SaveMaskEdit(MaskEdit6a_6,FHandle);
      SaveEdit(Edit6a_10,FHandle);
      SaveEdit(Edit6a_11,FHandle);
      SaveEdit(Edit6a_12,FHandle);
      SaveEdit(Edit6a_16,FHandle);
      SaveEdit(Edit6a_17,FHandle);
      SaveEdit(Edit6a_18,FHandle);
      SaveReal(Edit6a_20.Value,FHandle);
      SaveEdit(Edit6a_22,FHandle);
      SaveBoolean(RB6b_2.Checked,FHandle);
      SaveBoolean(RB6b_3.Checked,FHandle);
      SaveBoolean(RB6b_5.Checked,FHandle);
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

procedure TZp150Dlg.LoadFile;
var
  s:String;
  r:Real;
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
        if s=Zp150FileHdr
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
                LoadMemo(Memo1_27,FHandle);
                LoadMemo(Memo2_2,FHandle);
                LoadEdit(Edit2_4,FHandle);
                LoadMaskEdit(MaskEdit2_6,FHandle);
                LoadEdit(Edit2_8,FHandle);
                LoadEdit(Edit3_3,FHandle);
                LoadEdit(Edit3_5,FHandle);
                LoadEdit(Edit3_7,FHandle);
                LoadEdit(Edit4_3,FHandle);
                LoadEdit(Edit4_5,FHandle);
                LoadReal(r,FHandle);
                Edit5_3.Value:=r;
                LoadReal(r,FHandle);
                Edit5_5.Value:=r;
                LoadMemo(Memo6a_3,FHandle);
                LoadEdit(Edit6a_5,FHandle);
                LoadMaskEdit(MaskEdit6a_6,FHandle);
                LoadEdit(Edit6a_10,FHandle);
                LoadEdit(Edit6a_11,FHandle);
                LoadEdit(Edit6a_12,FHandle);
                LoadEdit(Edit6a_16,FHandle);
                LoadEdit(Edit6a_17,FHandle);
                LoadEdit(Edit6a_18,FHandle);
                LoadReal(r,FHandle);
                Edit6a_20.Value:=r;
                LoadEdit(Edit6a_22,FHandle);
                LoadBoolean(B,FHandle);
                RB6b_2.Checked:=B;
                LoadBoolean(B,FHandle);
                RB6b_3.Checked:=B;
                LoadBoolean(B,FHandle);
                RB6b_5.Checked:=B;
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

procedure TZp150Dlg.OpenBtnClick(Sender: TObject);
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

procedure TZp150Dlg.SaveBtnClick(Sender: TObject);
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

procedure TZp150Dlg.FormDestroy(Sender: TObject);
begin
  if FileIsOpen
    then begin
      CloseFile(FHandle);
      FileIsOpen:=FALSE;
    end;
end;

procedure TZp150Dlg.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key=#13
    then begin
      Key:=#0;
      Perform(wm_NextDlgCtl,0,0);
    end;
end;

procedure TZp150Dlg.OKBtnClick(Sender: TObject);
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

procedure TZp150Dlg.SiwzBtnClick(Sender: TObject);
var
  x:Byte;
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
          end;
        FreePrtRec;
      end;
    OpenDialog.DefaultExt:='150';
    OpenDialog.Filter:='Druki ZP150|*.150';
{$ENDIF}
end;

procedure TZp150Dlg.HelpBtnClick(Sender: TObject);
begin
  Application.HelpContext(150);
end;

end.

