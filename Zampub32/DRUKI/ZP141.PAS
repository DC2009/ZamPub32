unit Zp141;

interface

uses WinTypes, WinProcs, Classes, Graphics, Forms, Controls, Buttons,
  StdCtrls, ExtCtrls, Mask, TabNotBk, Grids, Spin, SysUtils,
  Messages, Dialogs, Printers,
  Utils,
  SiwzIni,
  SkOk,
  PrtRecIo,
  UserUnit,
  ZpBoxes,
  RPrev, Timeedit, IntDate, Sk;

type
  TZp141Dlg = class(TForm)
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
    Panel2: TPanel;
    Bevel2: TBevel;
    Label2: TLabel;
    Label2_1: TLabel;
    Label2_3: TLabel;
    Memo2_2: TMemo;
    Edit2_4: TEdit;
    Panel7: TPanel;
    Label4_5: TLabel;
    Label4_4: TLabel;
    Label4_9: TLabel;
    Label4_8: TLabel;
    Label4_1: TLabel;
    Bevel7: TBevel;
    Label7: TLabel;
    Label4_10: TLabel;
    Label4_2: TLabel;
    Label4_14: TLabel;
    Label4_18: TLabel;
    Label4_20: TLabel;
    Edit4_6: TEdit;
    MaskEdit4_7: TMaskEdit;
    Edit4_11: TEdit;
    Edit4_12: TEdit;
    Memo4_3: TMemo;
    Edit4_13: TEdit;
    Memo4_15: TMemo;
    Panel11: TPanel;
    Panel3: TPanel;
    Bevel10: TBevel;
    Label3: TLabel;
    Label3_1: TLabel;
    Label3_2: TLabel;
    Memo3_3: TMemo;
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
    Edit1_12: TEdit;
    Date4_19: TIntDate;
    Time4_21: TTimeEdit;
    NumEdit: TEdit;
    Label29: TLabel;
    Sk: TSmartKey;
    procedure TimeEditExit(Sender: TObject);
    procedure NumEditKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure PreviewBtnClick(Sender: TObject);
    procedure RB1_21Click(Sender: TObject);
    procedure RB1_22Click(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure OKBtnClick(Sender: TObject);
    procedure PrintBtnClick(Sender: TObject);
    procedure OpenBtnClick(Sender: TObject);
    procedure SaveBtnClick(Sender: TObject);
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
  public
    { Public declarations }
  end;

var
  Zp141Dlg: TZp141Dlg;

procedure DrukZp141; export;

implementation

{$R *.DFM}

uses
  DrMsg,
  DateUtil;

procedure DrukZp141;
var
  Cur:Integer;
begin
  Cur:=Screen.Cursor;
  Screen.Cursor:=crHourGlass;
  ZP141Dlg:=TZp141Dlg.Create(Nil);
  Screen.Cursor:=Cur;
  ZP141Dlg.ShowModal;
  ZP141Dlg.Free;
end;

procedure TZp141Dlg.TimeEditExit(Sender: TObject);
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

procedure TZp141Dlg.NumEditKeyPress(Sender: TObject; var Key: Char);
begin
  if not (Key in ['0'..'9',#8])
    then begin
      Key:=#0;
      MessageBeep(0);
    end;
end;

procedure TZp141Dlg.RB1_21Click(Sender: TObject);
begin
  MaskEdit1_24.Enabled:=TRUE;
  MaskEdit1_24.Color:=clWhite;
  MaskEdit1_25.Enabled:=FALSE;
  MaskEdit1_25.Color:=clGray;
end;

procedure TZp141Dlg.RB1_22Click(Sender: TObject);
begin
  MaskEdit1_24.Enabled:=FALSE;
  MaskEdit1_24.Color:=clGray;
  MaskEdit1_25.Enabled:=TRUE;
  MaskEdit1_25.Color:=clWhite;
end;

procedure TZp141Dlg.FormCreate(Sender: TObject);
begin
  Application.HelpFile:=DruZpHelpFile;
  FilePwd:=LoadFilePwd(AddBackSlash(ProgramDir)+SecurityFileName);
  RB1_21.Checked:=TRUE;
  RB1_21Click(Sender);
end;

procedure TZp141Dlg.MakeBox1(Ry:TRyPrinter; var PPos:Integer);
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
      AddZp1Box(Ry,'1',[p1,p2,p3,p4,p5,p6,p7],[1,1,1,1,1,1,1],ZP141Tit,'141',NumEdit.Text,PrintSpace,PPos);
      StrDispose(p1);
      StrDispose(p2);
      StrDispose(p3);
      StrDispose(p4);
      StrDispose(p5);
      StrDispose(p6);
      StrDispose(p7);
    end;
end;

procedure TZp141Dlg.MakeBox2(Ry:TRyPrinter; var PPos:Integer);
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
      AddZp1Box(Ry,'2',[p1,p2,p3],[1,1,1],ZP141Tit,'141',NumEdit.Text,PrintSpace,PPos);
      StrDispose(p1);
      StrDispose(p2);
      StrDispose(p3);
    end;
end;

procedure TZp141Dlg.MakeBox3(Ry:TRyPrinter; var PPos:Integer);
var
  p1,p2:PChar;
begin
  with Ry do
    begin
      p1:=StrAlloc(Length(Label3_1.Caption)+Length(Label3_2.Caption)+1);
      StrPCopy(p1,Label3_1.Caption+Label3_2.Caption);
      p2:=StrAlloc(Memo3_3.GetTextLen + 1);
      Memo3_3.GetTextBuf(p2, Memo3_3.GetTextLen+1);
      AddZp1Box(Ry,'3',[p1,p2],[1,1],ZP141Tit,'141',NumEdit.Text,PrintSpace,PPos);
      StrDispose(p1);
      StrDispose(p2);
    end;
end;

procedure TZp141Dlg.MakeBox4(Ry:TRyPrinter; var PPos:Integer);
var
  p1,p2,p3,p4,p5,p6,q1,q2:PChar;
begin
  with Ry do
    begin
      p1:=StrAlloc(Length(Label4_1.Caption)+1);
      StrPCopy(p1,Label4_1.Caption);
      p2:=StrAlloc(Length(Label4_2.Caption)+Memo4_3.GetTextLen+1);
      StrPCopy(p2,Label4_2.Caption);
      q1:=StrAlloc(Memo4_3.GetTextLen + 1);
      Memo4_3.GetTextBuf(q1, Memo4_3.GetTextLen+1);
      StrCat(p2,q1);
      p3:=StrAlloc(Length(Label4_4.Caption)+Length(Edit4_6.Text)+Length(Label4_5.Caption)+Length(MaskEdit4_7.Text)+1);
      StrPCopy(p3, Label4_4.Caption+Edit4_6.Text+Label4_5.Caption+MaskEdit4_7.Text);
      p4:=StrAlloc(Length(Label4_8.Caption)+Length(Edit4_11.Text)+Length(Label4_9.Caption)+Length(Edit4_12.Text)+
                  Length(Label4_10.Caption)+Length(Edit4_13.Text)+1);
      StrPCopy(p4, Label4_8.Caption+Edit4_11.Text+Label4_9.Caption+Edit4_12.Text+Label4_10.Caption+Edit4_13.Text);
      p5:=StrAlloc(Length(Label4_14.Caption)+Memo4_15.GetTextLen+1);
      StrPCopy(p5, Label4_14.Caption);
      q2:=StrAlloc(Memo4_15.GetTextLen + 1);
      Memo4_15.GetTextBuf(q2, Memo4_15.GetTextLen+1);
      StrCat(p5,q2);
      p6:=StrAlloc(Length(Label4_18.Caption)+Length(Date4_19.Text)+Length(Label4_20.Caption)+Length(Time4_21.Text)+1);
      StrPCopy(p6,Label4_18.Caption+Date4_19.Text+Label4_20.Caption+Time4_21.Text);
      AddZp1Box(Ry,'4',[p1,p2,p3,p4,p5,p6],[1,1,1,1,1,1],ZP141Tit,'141',NumEdit.Text,PrintSpace,PPos);
      StrDispose(p1);
      StrDispose(p2);
      StrDispose(p3);
      StrDispose(p4);
      StrDispose(p5);
      StrDispose(p6);
      StrDispose(q1);
      StrDispose(q2);
    end;
end;

procedure TZp141Dlg.MakePrint;
var
  p,q,r:PChar;
begin
    with Ry do
      begin
        NewJob;
        SetMinMargins(Xmm(20),Ymm(10),Xmm(20),Ymm(10));
        MakeHeader(Ry,Zp141Tit,'141',NumEdit.Text,'',PPos);
        PrintSpace:=YBOff-Ymm(35);
        MakeFooter(Ry,PrintSpace);
        MakeBox1(Ry,PPos);
        MakeBox2(Ry,PPos);
        MakeBox3(Ry,PPos);
        MakeBox4(Ry,PPos);
      end;
end;

procedure TZp141Dlg.PreviewBtnClick(Sender: TObject);
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

procedure TZp141Dlg.PrintBtnClick(Sender: TObject);
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

procedure TZp141Dlg.SaveFile;
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
      SaveString(Zp141FileHdr,FHandle);
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
      SaveMemo(Memo3_3,FHandle);
      SaveMemo(Memo4_3,FHandle);
      SaveEdit(Edit4_6,FHandle);
      SaveMaskEdit(MaskEdit4_7,FHandle);
      SaveEdit(Edit4_11,FHandle);
      SaveEdit(Edit4_12,FHandle);
      SaveEdit(Edit4_13,FHandle);
      SaveMemo(Memo4_15,FHandle);
      SaveDateTime(Date4_19.EditDate,FHandle);
      SaveDateTime(Time4_21.EditTime,FHandle);
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

procedure TZp141Dlg.LoadFile;
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
        if s=Zp141FileHdr
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
                LoadMemo(Memo3_3,FHandle);
                LoadMemo(Memo4_3,FHandle);
                LoadEdit(Edit4_6,FHandle);
                LoadMaskEdit(MaskEdit4_7,FHandle);
                LoadEdit(Edit4_11,FHandle);
                LoadEdit(Edit4_12,FHandle);
                LoadEdit(Edit4_13,FHandle);
                LoadMemo(Memo4_15,FHandle);
                LoadDateTime(DT,FHandle);
                Date4_19.EditDate:=DT;
                LoadDateTime(DT,FHandle);
                Time4_21.EditTime:=DT;
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

procedure TZp141Dlg.OpenBtnClick(Sender: TObject);
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

procedure TZp141Dlg.SaveBtnClick(Sender: TObject);
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

procedure TZp141Dlg.FormDestroy(Sender: TObject);
begin
  if FileIsOpen
    then begin
      CloseFile(FHandle);
      FileIsOpen:=FALSE;
    end;
end;

procedure TZp141Dlg.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key=#13
    then begin
      Key:=#0;
      Perform(wm_NextDlgCtl,0,0);
    end;
end;

procedure TZp141Dlg.OKBtnClick(Sender: TObject);
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

procedure TZp141Dlg.SiwzBtnClick(Sender: TObject);
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
            Memo4_3.SetTextBuf(SkladMemo2_3);
            Edit4_6.Text:=SkladEdit2_6;
            MaskEdit4_7.Text:=SkladMaskEdit2_7;
            Edit4_11.Text:=SkladEdit2_11;
            Edit4_12.Text:=SkladEdit2_12;
            Edit4_13.Text:=SkladEdit2_13;
            Date4_19.EditDate:=SkladDateEdit2_15;
            Time4_21.EditTime:=SkladTime2_17;
          end;
        FreePrtRec;
      end;
    OpenDialog.DefaultExt:='141';
    OpenDialog.Filter:='Druki ZP141|*.141';
{$ENDIF}
end;

procedure TZp141Dlg.HelpBtnClick(Sender: TObject);
begin
  Application.HelpContext(141);
end;

end.

