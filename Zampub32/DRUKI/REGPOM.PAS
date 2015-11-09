unit Regpom;

interface

uses WinTypes, WinProcs, Classes, Graphics, Forms, Controls, Buttons,
  StdCtrls, ExtCtrls, Mask, TabNotBk, Grids, Spin, SysUtils,
  Messages, Dialogs, Printers,
  Utils,
  SiwzIni,
  ZpBoxes,
  UserUnit,
  SkOk,
  RPrev, IntDate, Sk;

const
  RegulaminFileHdr='ZP3REG';

type
  TRegulaminDlg = class(TForm)
    ScrollBox1: TScrollBox;
    Panel0: TPanel;
    Panel3: TPanel;
    Bevel5: TBevel;
    Label4: TLabel;
    Panel5: TPanel;
    Bevel6: TBevel;
    Label5: TLabel;
    Label5_1: TLabel;
    Panel6: TPanel;
    Bevel3: TBevel;
    Label6: TLabel;
    Panel11: TPanel;
    Panel2: TPanel;
    Bevel2: TBevel;
    Label2: TLabel;
    Memo2_6: TMemo;
    Panel12: TPanel;
    OKBtn: TBitBtn;
    CancelBtn: TBitBtn;
    PrintBtn: TBitBtn;
    PreviewBtn: TBitBtn;
    OpenBtn: TBitBtn;
    SaveBtn: TBitBtn;
    HelpBtn: TBitBtn;
    OpenDialog: TOpenDialog;
    SaveDialog: TSaveDialog;
    Label0_1: TLabel;
    Panel1: TPanel;
    Bevel1: TBevel;
    Label11: TLabel;
    Label1_1: TLabel;
    Edit1_3: TEdit;
    Label1_4: TLabel;
    Edit1_5: TEdit;
    Label1_6: TLabel;
    Label2_1: TLabel;
    CB2_1: TCheckBox;
    CB2_2: TCheckBox;
    Combo2_1: TComboBox;
    CB2_3: TCheckBox;
    CB2_4: TCheckBox;
    Label2_4: TLabel;
    CB2_5: TCheckBox;
    Label2_5: TLabel;
    Panel22: TPanel;
    Bevel4: TBevel;
    Label22: TLabel;
    Label3_1: TLabel;
    Label3_2: TLabel;
    Label4_1: TLabel;
    Label4_2: TLabel;
    Label5_2: TLabel;
    Label6_1: TLabel;
    Label6_2: TLabel;
    Label0_2: TLabel;
    CB1_2: TComboBox;
    Label1_8: TLabel;
    Label1_9: TLabel;
    Label1_10: TLabel;
    Label1_11: TLabel;
    Label4_3: TLabel;
    Label4_4: TLabel;
    Label4_5: TLabel;
    Label4_6: TLabel;
    Memo4_7: TMemo;
    Label4_8: TLabel;
    Label4_9: TLabel;
    Label4_10: TLabel;
    Label4_11: TLabel;
    Memo4_12: TMemo;
    Label4_13: TLabel;
    Label4_14: TLabel;
    Label4_15: TLabel;
    Label4_16: TLabel;
    Label4_17: TLabel;
    Memo5_3: TMemo;
    Label5_4: TLabel;
    Label5_5: TLabel;
    Label5_6: TLabel;
    Label5_7: TLabel;
    Label5_8: TLabel;
    Label5_9: TLabel;
    Label5_10: TLabel;
    Label5_11: TLabel;
    Label5_12: TLabel;
    Label5_13: TLabel;
    Label5_14: TLabel;
    Date1_7: TIntDate;
    Label29: TLabel;
    NumEdit: TEdit;
    Sk: TSmartKey;
    procedure NumEditKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure PreviewBtnClick(Sender: TObject);
    procedure PrintBtnClick(Sender: TObject);
    procedure OpenBtnClick(Sender: TObject);
    procedure SaveBtnClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure OKBtnClick(Sender: TObject);
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
    procedure MakeBox0(Ry:TRyPrinter; var PPos:Integer);
    procedure MakeBox1(Ry:TRyPrinter; var PPos:Integer);
    procedure MakeBox2(Ry:TRyPrinter; var PPos:Integer);
    procedure MakeBox3(Ry:TRyPrinter; var PPos:Integer);
    procedure MakeBox4(Ry:TRyPrinter; var PPos:Integer);
    procedure MakeBox5(Ry:TRyPrinter; var PPos:Integer);
    procedure MakeBox6(Ry:TRyPrinter; var PPos:Integer);
  public
    { Public declarations }
  end;

var
  RegulaminDlg: TRegulaminDlg;

procedure Regulamin;export;

implementation

{$R *.DFM}

uses
  DrMsg,
  DateUtil;

procedure Regulamin;
var
  Cur:Integer;
begin
  Cur:=Screen.Cursor;
  Screen.Cursor:=crHourGlass;
  RegulaminDlg:=TRegulaminDlg.Create(Nil);
  Screen.Cursor:=Cur;
  RegulaminDlg.ShowModal;
  RegulaminDlg.Free;
end;

procedure TRegulaminDlg.NumEditKeyPress(Sender: TObject; var Key: Char);
begin
  if not (Key in ['0'..'9',#8])
    then begin
      Key:=#0;
      MessageBeep(0);
    end;
end;

procedure TRegulaminDlg.FormCreate(Sender: TObject);
begin
  Application.HelpFile:=RapHelpFile;
  CB2_1.Checked:=TRUE;
  CB2_2.Checked:=TRUE;
  CB2_3.Checked:=TRUE;
  CB2_4.Checked:=TRUE;
  CB2_5.Checked:=TRUE;
  FilePwd:=LoadFilePwd(AddBackSlash(ProgramDir)+SecurityFileName);
end;

procedure TRegulaminDlg.MakeBox0(Ry:TRyPrinter; var PPos:Integer);
var
  p1:PChar;
begin
  with Ry do
    begin
      p1:=StrAlloc(Length(Label0_1.Caption)+Length(Label0_2.Caption)+1);
      StrPCopy(p1, Label0_1.Caption+Label0_2.Caption);
      AddBox(Ry,[p1],[1],Self.Caption,'',NumEdit.Text,PrintSpace,PPos);
      StrDispose(p1);
    end;
end;

procedure TRegulaminDlg.MakeBox1(Ry:TRyPrinter; var PPos:Integer);
var
  p1,p2,p3,p4:PChar;
begin
  with Ry do
    begin
      p1:=StrAlloc(Length(Label1_1.Caption)+Length(CB1_2.Text)+Length(Edit1_3.Text)+Length(Label1_4.Caption)+
                  Length(Edit1_5.Text)+Length(Label1_6.Caption)+Length(Date1_7.Text)+1);
      StrPCopy(p1, Label1_1.Caption+CB1_2.Text+Edit1_3.Text+Label1_4.Caption+Edit1_5.Text+Label1_6.Caption+Date1_7.Text);
      p2:=StrAlloc(Length(Label1_8.Caption)+1);
      StrPCopy(p2, Label1_8.Caption);
      p3:=StrAlloc(Length(Label1_9.Caption)+Length(Label1_10.Caption)+1);
      StrPCopy(p3, Label1_9.Caption+Label1_10.Caption);
      p4:=StrAlloc(Length(Label1_11.Caption)+1);
      StrPCopy(p4, Label1_11.Caption);
      AddZp1Box(Ry,'1',[p1,p2,p3,p4],[1,1,1,1],Self.Caption,'',NumEdit.Text,PrintSpace,PPos);
      StrDispose(p1);
      StrDispose(p2);
      StrDispose(p3);
      StrDispose(p4);
    end;
end;

procedure TRegulaminDlg.MakeBox2(Ry:TRyPrinter; var PPos:Integer);
var
  p1,p2,p3,p4,p5,p6,p7:PChar;
begin
  with Ry do
    begin
      p2:=Nil;p3:=Nil;p4:=Nil;p5:=Nil;p6:=Nil;p7:=Nil;
      p1:=StrAlloc(Length(Label2_1.Caption)+1);
      StrPCopy(p1, Label2_1.Caption);
      if CB2_1.Checked
        then begin
          p2:=StrAlloc(Length(CB2_1.Caption)+1);
          StrPCopy(p2, CB2_1.Caption);
        end;
      if CB2_2.Checked
        then begin
          p3:=StrAlloc(Length(CB2_2.Caption)+Length(Combo2_1.Text)+1);
          StrPCopy(p3, CB2_2.Caption+Combo2_1.Text);
        end;
      if CB2_3.Checked
        then begin
          p4:=StrAlloc(Length(CB2_3.Caption)+1);
          StrPCopy(p4, CB2_3.Caption);
        end;
      if CB2_4.Checked
        then begin
          p5:=StrAlloc(Length(CB2_4.Caption)+Length(Label2_4.Caption)+1);
          StrPCopy(p5, CB2_4.Caption+Label2_4.Caption);
        end;
      if CB2_5.Checked
        then begin
          p6:=StrAlloc(Length(CB2_5.Caption)+Length(Label2_5.Caption)+1);
          StrPCopy(p6, CB2_5.Caption+Label2_5.Caption);
        end;
      if Memo2_6.Text<>''
        then begin
          p7:=StrAlloc(Memo2_6.GetTextLen + 1);
          Memo2_6.GetTextBuf(p7, Memo2_6.GetTextLen+1);
        end;
      AddZp1Box(Ry,'2',[p1,p2,p3,p4,p5,p6,p7],[1,1,1,1,1,1,1],Self.Caption,'',NumEdit.Text,PrintSpace,PPos);
      StrDispose(p1);
      StrDispose(p2);
      StrDispose(p3);
      StrDispose(p4);
      StrDispose(p5);
      StrDispose(p6);
      StrDispose(p7);
    end;
end;

procedure TRegulaminDlg.MakeBox3(Ry:TRyPrinter; var PPos:Integer);
var
  p1:PChar;
begin
  with Ry do
    begin
      p1:=StrAlloc(Length(Label3_1.Caption)+Length(Label3_2.Caption)+1);
      StrPCopy(p1,Label3_1.Caption+Label3_2.Caption);
      AddZp1Box(Ry,'3',[p1],[1],Self.Caption,'',NumEdit.Text,PrintSpace,PPos);
      StrDispose(p1);
    end;
end;

procedure TRegulaminDlg.MakeBox4(Ry:TRyPrinter; var PPos:Integer);
var
  p1,p2,p3,p4,p5,p6,p7,p8,p9,p10:PChar;
begin
  with Ry do
    begin
      p1:=StrAlloc(Length(Label4_1.Caption)+1);
      StrPCopy(p1,Label4_1.Caption);
      p2:=StrAlloc(Length(Label4_2.Caption)+Length(Label4_3.Caption)+1);
      StrPCopy(p2,Label4_2.Caption+Label4_3.Caption);
      p3:=StrAlloc(Length(Label4_4.Caption)+Length(Label4_5.Caption)+1);
      StrPCopy(p3,Label4_4.Caption+Label4_5.Caption);
      p4:=StrAlloc(Length(Label4_6.Caption)+1);
      StrPCopy(p4,Label4_6.Caption);
      p5:=StrAlloc(Memo4_7.GetTextLen+1);
      Memo4_7.GetTextBuf(p5,Memo4_7.GetTextLen);
      p6:=StrAlloc(Length(Label4_8.Caption)+Length(Label4_9.Caption)+Length(Label4_10.Caption)+1);
      StrPCopy(p6,Label4_8.Caption+Label4_9.Caption+Label4_10.Caption);
      p7:=StrAlloc(Length(Label4_11.Caption)+1);
      StrPCopy(p7,Label4_11.Caption);
      p8:=StrAlloc(Memo4_12.GetTextLen+1);
      Memo4_12.GetTextBuf(p8,Memo4_12.GetTextLen);
      p9:=StrAlloc(Length(Label4_13.Caption)+Length(Label4_14.Caption)+Length(Label4_15.Caption)+1);
      StrPCopy(p9,Label4_13.Caption+Label4_14.Caption+Label4_15.Caption);
      p10:=StrAlloc(Length(Label4_16.Caption)+Length(Label4_17.Caption)+1);
      StrPCopy(p10,Label4_16.Caption+Label4_17.Caption);
      AddZp1Box(Ry,'4',[p1,p2,p3,p4,p5,p6,p7,p8,p9,p10],[1,1,1,1,1,1,0,1,1,1],
                Self.Caption,'Regulamin',NumEdit.Text,PrintSpace,PPos);
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

procedure TRegulaminDlg.MakeBox5(Ry:TRyPrinter; var PPos:Integer);
var
  p1,p2,p3,p4,p5,p6,p7:PChar;
begin
  with Ry do
    begin
      p1:=StrAlloc(Length(Label5_1.Caption)+1);
      StrPCopy(p1,Label5_1.Caption);
      p2:=StrAlloc(Length(Label5_2.Caption)+1);
      StrPCopy(p2,Label5_2.Caption);
      p3:=StrAlloc(Memo5_3.GetTextLen+1);
      Memo5_3.GetTextBuf(p3,Memo5_3.GetTextLen);
      p4:=StrAlloc(Length(Label5_4.Caption)+Length(Label5_5.Caption)+1);
      StrPCopy(p4,Label5_4.Caption+Label5_5.Caption);
      p5:=StrAlloc(Length(Label5_6.Caption)+Length(Label5_7.Caption)+Length(Label5_8.Caption)+Length(Label5_9.Caption)+1);
      StrPCopy(p5,Label5_6.Caption+Label5_7.Caption+Label5_8.Caption+Label5_9.Caption);
      p6:=StrAlloc(Length(Label5_10.Caption)+Length(Label5_11.Caption)+1);
      StrPCopy(p6,Label5_10.Caption+Label5_11.Caption);
      p7:=StrAlloc(Length(Label5_12.Caption)+Length(Label5_13.Caption)+Length(Label5_14.Caption)+1);
      StrPCopy(p7,Label5_12.Caption+Label5_13.Caption+Label5_14.Caption);
      AddZp1Box(Ry,'5',[p1,p2,p3,p4,p5,p6,p7],[1,0,1,1,1,1,1],Self.Caption,'Regulamin',NumEdit.Text,PrintSpace,PPos);
      StrDispose(p1);
      StrDispose(p2);
      StrDispose(p3);
      StrDispose(p4);
      StrDispose(p5);
      StrDispose(p6);
      StrDispose(p7);
    end;
end;

procedure TRegulaminDlg.MakeBox6(Ry:TRyPrinter; var PPos:Integer);
var
  p1:PChar;
begin
  with Ry do
    begin
      p1:=StrAlloc(Length(Label6_1.Caption)+Length(Label6_2.Caption)+1);
      StrPCopy(p1,Label6_1.Caption+Label6_2.Caption);
      AddZp1Box(Ry,'6',[p1],[1],Self.Caption,'Regulamin',NumEdit.Text,PrintSpace,PPos);
      StrDispose(p1);
    end;
end;

procedure TRegulaminDlg.MakePrint;
var
  p,q,r:PChar;
begin
    with Ry do
      begin
        NewJob;
        SetMinMargins(Xmm(20),Ymm(10),Xmm(20),Ymm(10));
        MakeHeader(Ry,Self.caption,'Regulamin',NumEdit.Text,'',PPos);
        PrintSpace:=YBOff-Ymm(35);
        MakeFooter(Ry,PrintSpace);
        MakeBox0(Ry,PPos);
        MakeBox1(Ry,PPos);
        MakeBox2(Ry,PPos);
        MakeBox3(Ry,PPos);
        MakeBox4(Ry,PPos);
        MakeBox5(Ry,PPos);
        MakeBox6(Ry,PPos);
      end;
end;

procedure TRegulaminDlg.PreviewBtnClick(Sender: TObject);
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

procedure TRegulaminDlg.PrintBtnClick(Sender: TObject);
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

procedure TRegulaminDlg.SaveFile;
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
      SaveString(RegulaminFileHdr,FHandle);
      SaveString(FilePwd,FHandle);
      MakeCodeKey(FilePwd);
      SaveEdit(NumEdit,FHandle);
      SaveInteger(CB1_2.ItemIndex,FHandle);
      SaveEdit(Edit1_3,FHandle);
      SaveEdit(Edit1_5,FHandle);
      SaveDateTime(Date1_7.EditDate,FHandle);
      SaveBoolean(CB2_1.Checked,FHandle);
      SaveBoolean(CB2_2.Checked,FHandle);
      SaveInteger(Combo2_1.ItemIndex,FHandle);
      SaveBoolean(CB2_3.Checked,FHandle);
      SaveBoolean(CB2_4.Checked,FHandle);
      SaveBoolean(CB2_5.Checked,FHandle);
      SaveMemo(Memo2_6,FHandle);
      SaveMemo(Memo4_7,FHandle);
      SaveMemo(Memo4_12,FHandle);
      SaveMemo(Memo5_3,FHandle);
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

procedure TRegulaminDlg.LoadFile;
var
  s:String;
  i:Integer;
  b:Boolean;
  DT:TDateTime;
  FPwd:String;
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
        if s=RegulaminFileHdr
          then begin
            LoadString(FPwd,FHandle);
            if (FPwd=FilePwd)
              then begin
                MakeCodeKey(FPwd);
                LoadEdit(NumEdit,FHandle);
                LoadInteger(i,FHandle);
                CB1_2.ItemIndex:=i;
                LoadEdit(Edit1_3,FHandle);
                LoadEdit(Edit1_5,FHandle);
                LoadDateTime(DT,FHandle);
                Date1_7.EditDate:=DT;
                LoadBoolean(b,FHandle);
                CB2_1.Checked:=b;
                LoadBoolean(b,FHandle);
                CB2_2.Checked:=b;
                LoadInteger(i,FHandle);
                Combo2_1.ItemIndex:=i;
                LoadBoolean(b,FHandle);
                CB2_3.Checked:=b;
                LoadBoolean(b,FHandle);
                CB2_4.Checked:=b;
                LoadBoolean(b,FHandle);
                CB2_5.Checked:=b;
                LoadMemo(Memo2_6,FHandle);
                LoadMemo(Memo4_7,FHandle);
                LoadMemo(Memo4_12,FHandle);
                LoadMemo(Memo5_3,FHandle);
              end
              else begin
                MessageDlg(mIncorrectFilePwd,mtWarning,[mbOk],0);
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

procedure TRegulaminDlg.OpenBtnClick(Sender: TObject);
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

procedure TRegulaminDlg.SaveBtnClick(Sender: TObject);
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

procedure TRegulaminDlg.FormDestroy(Sender: TObject);
begin
  if FileIsOpen
    then begin
      CloseFile(FHandle);
      FileIsOpen:=FALSE;
    end;
end;

procedure TRegulaminDlg.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key=#13
    then begin
      Key:=#0;
      Perform(wm_NextDlgCtl,0,0);
    end;
end;

procedure TRegulaminDlg.OKBtnClick(Sender: TObject);
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

procedure TRegulaminDlg.HelpBtnClick(Sender: TObject);
begin
  Application.HelpContext(402);
end;

end.

