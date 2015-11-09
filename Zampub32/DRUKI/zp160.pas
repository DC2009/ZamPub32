unit Zp160;

interface

uses WinTypes, WinProcs, Classes, Graphics, Forms, Controls, Buttons,
  StdCtrls, ExtCtrls, Mask, TabNotBk, Grids, Spin, SysUtils,
  Messages, Dialogs, Printers,
  Utils,
  SiwzIni,
  UserUnit,
  SkOk,
  PrtRecIo,
  ZpBoxes,
  RPrev, Timeedit, IntDate, NumInp, Sk;

type
  TZp160Dlg = class(TForm)
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
    Panel4: TPanel;
    Label4_1: TLabel;
    Bevel8: TBevel;
    Label4: TLabel;
    Label4_2: TLabel;
    Label4_4: TLabel;
    Label4_8: TLabel;
    Label4_10: TLabel;
    Label4_6: TLabel;
    Edit4_3: TEdit;
    Edit4_5: TEdit;
    Edit4_7: TEdit;
    Time4_9: TTimeEdit;
    Time4_11: TTimeEdit;
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
    Sk: TSmartKey;
    Panel5: TPanel;
    Label13_1: TLabel;
    Label13_2: TLabel;
    Label13_17: TLabel;
    Label13_18: TLabel;
    Label13_20: TLabel;
    CB13_4: TCheckBox;
    Date13_5: TIntDate;
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
    procedure MakeUZPPage(Ry:TRyPrinter;PPos:Integer);
  public
    { Public declarations }
  end;

var
  Zp160Dlg: TZp160Dlg;

procedure DrukZp160; export;

implementation

{$R *.DFM}

uses
  DrMsg,
  DateUtil;

procedure DrukZp160;
var
  Cur:Integer;
begin
  Cur:=Screen.Cursor;
  Screen.Cursor:=crHourGlass;
  ZP160Dlg:=TZp160Dlg.Create(Nil);
  Screen.Cursor:=Cur;
  ZP160Dlg.ShowModal;
  ZP160Dlg.Free;
end;

procedure TZp160Dlg.TimeEditExit(Sender: TObject);
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

procedure TZp160Dlg.NumEditKeyPress(Sender: TObject; var Key: Char);
begin
  if not (Key in ['0'..'9',#8])
    then begin
      Key:=#0;
      MessageBeep(0);
    end;
end;

procedure TZp160Dlg.FormCreate(Sender: TObject);
begin
  RB1_21.Checked:=TRUE;
  RB1_21Click(Sender);
  Application.HelpFile:=DruZpHelpFile;
  FilePwd:=LoadFilePwd(AddBackSlash(ProgramDir)+SecurityFileName);
end;

procedure TZp160Dlg.RB1_21Click(Sender: TObject);
begin
  MaskEdit1_24.Enabled:=TRUE;
  MaskEdit1_24.Color:=clWhite;
  MaskEdit1_25.Enabled:=FALSE;
  MaskEdit1_25.Color:=clGray;
end;

procedure TZp160Dlg.RB1_22Click(Sender: TObject);
begin
  MaskEdit1_24.Enabled:=FALSE;
  MaskEdit1_24.Color:=clGray;
  MaskEdit1_25.Enabled:=TRUE;
  MaskEdit1_25.Color:=clWhite;
end;

procedure TZp160Dlg.MakeBox1(Ry:TRyPrinter; var PPos:Integer);
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
      AddZp1Box(Ry,'1',[p1,p2,p3,p4,p5,p6,p7],[1,1,1,1,1,1,1],ZP160Tit1+Zp160Tit2,'160',NumEdit.Text,PrintSpace,PPos);
      StrDispose(p1);
      StrDispose(p2);
      StrDispose(p3);
      StrDispose(p4);
      StrDispose(p5);
      StrDispose(p6);
      StrDispose(p7);
    end;
end;

procedure TZp160Dlg.MakeBox2(Ry:TRyPrinter; var PPos:Integer);
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
      AddZp1Box(Ry,'2',[p1,p2,p3,p4,p5,p6],[1,1,1,1,1,1],ZP160Tit1+Zp160Tit2,'160',NumEdit.Text,PrintSpace,PPos);
      StrDispose(p1);
      StrDispose(p2);
      StrDispose(p3);
      StrDispose(p4);
      StrDispose(p5);
      StrDispose(p6);
    end;
end;

procedure TZp160Dlg.MakeBox3(Ry:TRyPrinter; var PPos:Integer);
var
  p:PChar;
begin
  with Ry do
    begin
      p:=StrAlloc(Length(Label3_1.Caption)+Length(Date3_2.Text) + 1);
      StrPCopy(p,Label3_1.Caption+Date3_2.Text);
      AddZp1Box(Ry,'3',[p],[1],ZP160Tit1+Zp160Tit2,'160',NumEdit.Text,PrintSpace,PPos);
      StrDispose(p);
    end;
end;

procedure TZp160Dlg.MakeBox4(Ry:TRyPrinter; var PPos:Integer);
var
  p1,p2,p3,p4,p5:PChar;
begin
  with Ry do
    begin
      p1:=StrAlloc(Length(Label4_1.Caption)+1);
      StrPCopy(p1,Label4_1.Caption);
      p2:=StrAlloc(Length(Label4_2.Caption)+Length(Edit4_3.Text)+1);
      StrPCopy(p2,Label4_2.Caption+Edit4_3.Text);
      p3:=StrAlloc(Length(Label4_4.Caption)+Length(Edit4_5.Text)+1);
      StrPCopy(p3,Label4_4.Caption+Edit4_5.Text);
      p4:=StrAlloc(Length(Label4_6.Caption)+Length(Edit4_7.Text)+1);
      StrPCopy(p4,Label4_6.Caption+Edit4_7.Text);
      p5:=StrAlloc(Length(Label4_8.Caption)+Length(Time4_9.Text)+Length(Time4_11.Text)+4);
      StrPCopy(p5,Label4_8.Caption+Time4_9.Text+' - '+Time4_11.Text);
      AddZp1Box(Ry,'4',[p1,p2,p3,p4,p5],[1,1,1,1,1],ZP160Tit1+Zp160Tit2,'160',NumEdit.Text,PrintSpace,PPos);
      StrDispose(p1);
      StrDispose(p2);
      StrDispose(p3);
      StrDispose(p4);
      StrDispose(p5);
    end;
end;

procedure TZp160Dlg.MakeUZPPage(Ry:TRyPrinter;PPos:Integer);
var
  X:Integer;
  p:PChar;
begin
  with Ry do
    begin
      NewPage;
      Font.Name:='Times New Roman CE';
      PPos:=YTOff;
      MakeZpNumStr(Ry,XROff-Xmm(4),'160',PPos);
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
      PPos:=PPos+X+Ymm(4);
{2}
      if CB13_4.Checked
        then begin
          p:=StrAlloc(Length(Label13_2.Caption)+1);
          StrPCopy(p,Label13_2.Caption);
          X:=MemoOut(Rect(XLOff,PPos,XROff,YBOff), p, False, False);
          StrDispose(p);
          PPos:=PPos+X+Ymm(2);
          TextOut(XLOff+Xmm(10),PPos,CB13_4.Caption+Date13_5.Text);
          PPos:=PPos+TextHeight+Ymm(2);
        end;
      PPos:=PPos+Ymm(30);
      Font.Size:=8;
      TextOutRight(XROff-Xmm(5),PPos,'imiê, nazwisko i podpis osoby uprawnionej');
    end;
end;

procedure TZp160Dlg.MakePrint;
var
  p,q,r:PChar;
begin
    with Ry do
      begin
        NewJob;
        SetMinMargins(Xmm(20),Ymm(10),Xmm(20),Ymm(10));
        MakeHeader(Ry,Zp160Tit1+Zp160Tit2,'160',NumEdit.Text,'',PPos);
        PrintSpace:=YBOff-Ymm(35);
        MakeFooter(Ry,PrintSpace);
        MakeBox1(Ry,PPos);
        MakeBox2(Ry,PPos);
        MakeBox3(Ry,PPos);
        MakeBox4(Ry,PPos);
        MakeUZPPage(Ry,PPos);
      end;
end;

procedure TZp160Dlg.PreviewBtnClick(Sender: TObject);
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

procedure TZp160Dlg.PrintBtnClick(Sender: TObject);
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

procedure TZp160Dlg.SaveFile;
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
      SaveString(Zp160FileHdr,FHandle);
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
      SaveEdit(Edit4_3,FHandle);
      SaveEdit(Edit4_5,FHandle);
      SaveEdit(Edit4_7,FHandle);
      SaveDateTime(Time4_9.EditTime,FHandle);
      SaveDateTime(Time4_11.EditTime,FHandle);
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

procedure TZp160Dlg.LoadFile;
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
        if s=Zp160FileHdr
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
                Date3_2.EditDate:=DT;
                LoadEdit(Edit4_3,FHandle);
                LoadEdit(Edit4_5,FHandle);
                LoadEdit(Edit4_7,FHandle);
                LoadDateTime(DT,FHandle);
                Time4_9.EditTime:=DT;
                LoadDateTime(DT,FHandle);
                Time4_11.EditTime:=DT;
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

procedure TZp160Dlg.OpenBtnClick(Sender: TObject);
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

procedure TZp160Dlg.SaveBtnClick(Sender: TObject);
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

procedure TZp160Dlg.FormDestroy(Sender: TObject);
begin
  if FileIsOpen
    then begin
      CloseFile(FHandle);
      FileIsOpen:=FALSE;
    end;
end;

procedure TZp160Dlg.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key=#13
    then begin
      Key:=#0;
      Perform(wm_NextDlgCtl,0,0);
    end;
end;

procedure TZp160Dlg.OKBtnClick(Sender: TObject);
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

procedure TZp160Dlg.SiwzBtnClick(Sender: TObject);
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
            Memo2_2.SetTextBuf(ObjectMemo);
            RB2_6.Checked:=OKind=okDostawa;
            RB2_7.Checked:=OKind=okUslugi;
            RB2_8.Checked:=OKind=okRobBud;
            Date3_2.EditDate:=EndDate;
          end;
        FreePrtRec;
      end;
    OpenDialog.DefaultExt:='160';
    OpenDialog.Filter:='Druki ZP160|*.160';
{$ENDIF}
end;

procedure TZp160Dlg.HelpBtnClick(Sender: TObject);
begin
  Application.HelpContext(150);
end;

end.

