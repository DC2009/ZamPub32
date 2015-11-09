unit Umopom;

interface

uses WinTypes, WinProcs, Classes, Graphics, Forms, Controls, Buttons,
  StdCtrls, ExtCtrls, Mask, TabNotBk, Grids, Spin, SysUtils,
  Messages, Dialogs, Printers,
  Utils,
  UserUnit,
  SiwzIni,
  ZpBoxes,
  RPrev, IntDate;

const
  DecyzjaFileHdr='ZP3DEC';

type
  TUmowaDlg = class(TForm)
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
    Panel8: TPanel;
    Bevel8: TBevel;
    Label8: TLabel;
    Label8_1: TLabel;
    Panel11: TPanel;
    Panel2: TPanel;
    Bevel2: TBevel;
    Label2: TLabel;
    Memo2_6: TMemo;
    Label0_2: TLabel;
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
    CB1: TComboBox;
    Label0_4: TLabel;
    Label3: TLabel;
    Edit0_5: TEdit;
    Label0_6: TLabel;
    Edit0_7: TEdit;
    Label0_8: TLabel;
    Panel1: TPanel;
    Bevel1: TBevel;
    Label11: TLabel;
    Label1_1: TLabel;
    Label1_2: TLabel;
    Label1_3: TLabel;
    Edit1_4: TEdit;
    Label1_5: TLabel;
    Edit1_6: TEdit;
    Edit1_8: TEdit;
    Label1_7: TLabel;
    Label1_9: TLabel;
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
    Combo3: TComboBox;
    Label4_1: TLabel;
    Label4_2: TLabel;
    Label5_2: TLabel;
    Label6_1: TLabel;
    Label6_2: TLabel;
    Label6_3: TLabel;
    Panel7: TPanel;
    Label7_1: TLabel;
    Bevel7: TBevel;
    Label7: TLabel;
    Label7_2: TLabel;
    Label7_3: TLabel;
    Panel9: TPanel;
    Bevel9: TBevel;
    Label33: TLabel;
    Label9_1: TLabel;
    Label9_2: TLabel;
    Panel10: TPanel;
    Bevel10: TBevel;
    Label36: TLabel;
    Label10_1: TLabel;
    Label10_2: TLabel;
    Panel4: TPanel;
    Bevel11: TBevel;
    Label39: TLabel;
    Label11_1: TLabel;
    Label11_2: TLabel;
    Panel13: TPanel;
    Bevel12: TBevel;
    Label42: TLabel;
    Label12_2: TLabel;
    Combo12: TComboBox;
    Date0_3: TIntDate;
    Memo1_10: TMemo;
    Label29: TLabel;
    NumEdit: TEdit;
    procedure TimeEditExit(Sender: TObject);
    procedure NumEditKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure PreviewBtnClick(Sender: TObject);
    procedure PrintBtnClick(Sender: TObject);
    procedure OpenBtnClick(Sender: TObject);
    procedure SaveBtnClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure OKBtnClick(Sender: TObject);
    procedure CB1Change(Sender: TObject);
    procedure Combo3Change(Sender: TObject);
    procedure Combo12Change(Sender: TObject);
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
    procedure MakeBox0(Ry:TRyPrinter; var PPos:Integer);
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
  public
    { Public declarations }
  end;

var
  UmowaDlg: TUmowaDlg;

procedure Decyzja;export;

implementation

{$R *.DFM}

uses
  DrMsg,
  DateUtil;

procedure Decyzja;
var
  Cur:Integer;
begin
  Cur:=Screen.Cursor;
  Screen.Cursor:=crHourGlass;
  DecyzjaDlg:=TDecyzjaDlg.Create(Nil);
  Screen.Cursor:=Cur;
  DecyzjaDlg.ShowModal;
  DecyzjaDlg.Free;
end;

procedure TUmowaDlg.TimeEditExit(Sender: TObject);
var
  s:String[5];
  Err:Boolean;
begin
  if ActiveControl=CancelBtn
    then Exit;
  s:=TMaskEdit(Sender).Text;
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

procedure TUmowaDlg.NumEditKeyPress(Sender: TObject; var Key: Char);
begin
  if not (Key in ['0'..'9',#8])
    then begin
      Key:=#0;
      MessageBeep(0);
    end;
end;

procedure TUmowaDlg.FormCreate(Sender: TObject);
begin
  Application.HelpFile:=RapHelpFile;
  CB1.ItemIndex:=0;
  CB2_1.Checked:=TRUE;
  CB2_2.Checked:=TRUE;
  CB2_3.Checked:=TRUE;
  CB2_4.Checked:=TRUE;
  CB2_5.Checked:=TRUE;
  CB1Change(Sender);
  FilePwd:=LoadFilePwd(AddBackSlash(ProgramDir)+SecurityFileName);
end;

procedure TUmowaDlg.MakeBox0(Ry:TRyPrinter; var PPos:Integer);
var
  p1,p2,p3:PChar;
begin
  with Ry do
    begin
      p1:=StrAlloc(Length(CB1.Text)+Length(Label0_2.Caption)+Length(Date0_3.Text)+Length(Label0_4.Caption)+1);
      StrPCopy(p1, CB1.Text+Label0_2.Caption+Date0_3.Text+Label0_4.Caption);
      p2:=StrAlloc(Length(Edit0_5.Text)+1);
      StrPCopy(p2, Edit0_5.Text);
      p3:=StrAlloc(Length(Label0_6.Caption)+Length(Edit0_7.Text)+Length(Label0_8.Caption)+1);
      StrPCopy(p3, Label0_6.Caption+Edit0_7.Text+Label0_8.Caption);
      AddBox(Ry,[p1,p2,p3],[1,1,1],Self.Caption,'',NumEdit.Text,PrintSpace,PPos);
      StrDispose(p1);
      StrDispose(p2);
      StrDispose(p3);
    end;
end;

procedure TUmowaDlg.MakeBox1(Ry:TRyPrinter; var PPos:Integer);
var
  p1,p2,p3,p4,p5,p6:PChar;
begin
  with Ry do
    begin
      p1:=StrAlloc(Length(Label1_1.Caption)+Length(Label1_2.Caption)+1);
      StrPCopy(p1, Label1_1.Caption+Label1_2.Caption);
      p2:=StrAlloc(Length(Label1_3.Caption)+Length(Edit1_4.Text)+1);
      StrPCopy(p2, Label1_3.Caption+Edit1_4.Text);
      p3:=StrAlloc(Length(Label1_5.Caption)+Length(Edit1_6.Text)+1);
      StrPCopy(p3, Label1_5.Caption+Edit1_6.Text);
      p4:=StrAlloc(Length(Label1_7.Caption)+Length(Edit1_8.Text)+1);
      StrPCopy(p4, Label1_7.Caption+Edit1_8.Text);
      p5:=StrAlloc(Length(Label1_9.Caption)+1);
      StrPCopy(p5, Label1_9.Caption);
      p6:=StrAlloc(Memo1_10.GetTextLen + 1);
      Memo1_10.GetTextBuf(p6, Memo1_10.GetTextLen+1);
      AddZp1Box(Ry,'1',[p1,p2,p3,p4,p5,p6],[1,1,1,1,1,1],Self.Caption,'',NumEdit.Text,PrintSpace,PPos);
      StrDispose(p1);
      StrDispose(p2);
      StrDispose(p3);
      StrDispose(p4);
      StrDispose(p5);
      StrDispose(p6);
    end;
end;

procedure TUmowaDlg.MakeBox2(Ry:TRyPrinter; var PPos:Integer);
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

procedure TUmowaDlg.MakeBox3(Ry:TRyPrinter; var PPos:Integer);
var
  p1:PChar;
begin
  with Ry do
    begin
      p1:=StrAlloc(Length(Label3_1.Caption)+Length(Label3_2.Caption)+Length(Combo3.Text)+1);
      StrPCopy(p1,Label3_1.Caption+Label3_2.Caption+Combo3.Text);
      AddZp1Box(Ry,'3',[p1],[1],Self.Caption,'',NumEdit.Text,PrintSpace,PPos);
      StrDispose(p1);
    end;
end;

procedure TUmowaDlg.MakeBox4(Ry:TRyPrinter; var PPos:Integer);
var
  p1,p2:PChar;
begin
  with Ry do
    begin
      p1:=StrAlloc(Length(Label4_1.Caption)+1);
      StrPCopy(p1,Label4_1.Caption);
      p2:=StrAlloc(Length(Label4_2.Caption)+1);
      StrPCopy(p2,Label4_2.Caption);
      AddZp1Box(Ry,'4',[p1,p2],[1,1],Self.Caption,'',NumEdit.Text,PrintSpace,PPos);
      StrDispose(p1);
      StrDispose(p2);
    end;
end;

procedure TUmowaDlg.MakeBox5(Ry:TRyPrinter; var PPos:Integer);
var
  p1:PChar;
begin
  with Ry do
    begin
      p1:=StrAlloc(Length(Label5_1.Caption)+Length(Label5_2.Caption)+1);
      StrPCopy(p1,Label5_1.Caption+Label5_2.Caption);
      AddZp1Box(Ry,'5',[p1],[1],Self.Caption,'',NumEdit.Text,PrintSpace,PPos);
      StrDispose(p1);
    end;
end;

procedure TUmowaDlg.MakeBox6(Ry:TRyPrinter; var PPos:Integer);
var
  p1:PChar;
begin
  with Ry do
    begin
      p1:=StrAlloc(Length(Label6_1.Caption)+Length(Label6_2.Caption)+Length(Label6_3.Caption)+1);
      StrPCopy(p1,Label6_1.Caption+Label6_2.Caption+Label6_3.Caption);
      AddZp1Box(Ry,'6',[p1],[1],Self.Caption,'',NumEdit.Text,PrintSpace,PPos);
      StrDispose(p1);
    end;
end;

procedure TUmowaDlg.MakeBox7(Ry:TRyPrinter; var PPos:Integer);
var
  p1:PChar;
begin
  with Ry do
    begin
      p1:=StrAlloc(Length(Label7_1.Caption)+Length(Label7_2.Caption)+Length(Label7_3.Caption)+1);
      StrPCopy(p1,Label7_1.Caption+Label7_2.Caption+Label7_3.Caption);
      AddZp1Box(Ry,'7',[p1],[1],Self.Caption,'',NumEdit.Text,PrintSpace,PPos);
      StrDispose(p1);
    end;
end;

procedure TUmowaDlg.MakeBox8(Ry:TRyPrinter; var PPos:Integer);
var
  p1:PChar;
begin
  with Ry do
    begin
      p1:=StrAlloc(Length(Label8_1.Caption)+1);
      StrPCopy(p1,Label8_1.Caption);
      AddZp1Box(Ry,'8',[p1],[1],Self.Caption,'',NumEdit.Text,PrintSpace,PPos);
      StrDispose(p1);
    end;
end;

procedure TUmowaDlg.MakeBox9(Ry:TRyPrinter; var PPos:Integer);
var
  p:PChar;
begin
  with Ry do
    begin
      p:=StrAlloc(Length(Label9_1.Caption)+Length(Label9_2.Caption)+1);
      StrPCopy(p,Label9_1.Caption+Label9_2.Caption);
      AddZp1Box(Ry,'9',[p],[1],Self.Caption,'',NumEdit.Text,PrintSpace,PPos);
      StrDispose(p);
    end;
end;

procedure TUmowaDlg.MakeBox10(Ry:TRyPrinter; var PPos:Integer);
var
  p:PChar;
begin
  with Ry do
    begin
      p:=StrAlloc(Length(Label10_1.Caption)+Length(Label10_2.Caption)+1);
      StrPCopy(p,Label10_1.Caption+Label10_2.Caption);
      AddZp1Box(Ry,'10',[p],[1],Self.Caption,'',NumEdit.Text,PrintSpace,PPos);
      StrDispose(p);
    end;
end;

procedure TUmowaDlg.MakeBox11(Ry:TRyPrinter; var PPos:Integer);
var
  p:PChar;
begin
  with Ry do
    begin
      p:=StrAlloc(Length(Label11_1.Caption)+Length(Label11_2.Caption)+1);
      StrPCopy(p,Label11_1.Caption+Label11_2.Caption);
      AddZp1Box(Ry,'11',[p],[1],Self.Caption,'',NumEdit.Text,PrintSpace,PPos);
      StrDispose(p);
    end;
end;

procedure TUmowaDlg.MakeBox12(Ry:TRyPrinter; var PPos:Integer);
var
  p:PChar;
begin
  with Ry do
    begin
      p:=StrAlloc(Length(Combo12.Text)+Length(Label12_2.Caption)+1);
      StrPCopy(p,Combo12.Text+Label12_2.Caption);
      AddZp1Box(Ry,'12',[p],[1],Self.Caption,'',NumEdit.Text,PrintSpace,PPos);
      StrDispose(p);
    end;
end;

procedure TUmowaDlg.MakePrint;
var
  p,q,r:PChar;
begin
    with Ry do
      begin
        NewJob;
        SetMinMargins(Xmm(20),Ymm(10),Xmm(20),Ymm(10));
        MakeHeader(Ry,Self.Caption,'',NumEdit.Text,'',PPos);
        PrintSpace:=YBOff-Ymm(35);
        MakeFooter(Ry,PrintSpace);
        MakeBox0(Ry,PPos);
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
        MakeBox12(Ry,PPos);
      end;
end;

procedure TUmowaDlg.PreviewBtnClick(Sender: TObject);
var
  Cur:Integer;
begin
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

procedure TUmowaDlg.PrintBtnClick(Sender: TObject);
var
  Cur:Integer;
begin
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

procedure TUmowaDlg.SaveFile;
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
      SaveString(DecyzjaFileHdr,FHandle);
      SaveString(FilePwd,FHandle);
      MakeCodeKey(FilePwd);
      SaveEdit(NumEdit,FHandle);
      SaveInteger(CB1.ItemIndex,FHandle);
      SaveDateTime(Date0_3.EditDate,FHandle);
      SaveEdit(Edit0_5,FHandle);
      SaveEdit(Edit0_7,FHandle);
      SaveEdit(Edit1_4,FHandle);
      SaveEdit(Edit1_6,FHandle);
      SaveEdit(Edit1_8,FHandle);
      SaveMemo(Memo1_10,FHandle);
      SaveBoolean(CB2_1.Checked,FHandle);
      SaveBoolean(CB2_2.Checked,FHandle);
      SaveInteger(Combo2_1.ItemIndex,FHandle);
      SaveBoolean(CB2_3.Checked,FHandle);
      SaveBoolean(CB2_4.Checked,FHandle);
      SaveBoolean(CB2_5.Checked,FHandle);
      SaveMemo(Memo2_6,FHandle);
      SaveInteger(Combo3.ItemIndex,FHandle);
      SaveInteger(Combo12.ItemIndex,FHandle);
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

procedure TUmowaDlg.LoadFile;
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
        if s=DecyzjaFileHdr
          then begin
            LoadString(FPwd,FHandle);
            if (FPwd=FilePwd)
              then begin
                MakeCodeKey(FPwd);
                LoadEdit(NumEdit,FHandle);
                LoadInteger(i,FHandle);
                CB1.ItemIndex:=i;
                LoadDateTime(DT,FHandle);
                Date0_3.EditDate:=DT;
                LoadEdit(Edit0_5,FHandle);
                LoadEdit(Edit0_7,FHandle);
                LoadEdit(Edit1_4,FHandle);
                LoadEdit(Edit1_6,FHandle);
                LoadEdit(Edit1_8,FHandle);
                LoadMemo(Memo1_10,FHandle);
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
                LoadInteger(i,FHandle);
                Combo3.ItemIndex:=i;
                LoadInteger(i,FHandle);
                Combo12.ItemIndex:=i;
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

procedure TUmowaDlg.OpenBtnClick(Sender: TObject);
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

procedure TUmowaDlg.SaveBtnClick(Sender: TObject);
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

procedure TUmowaDlg.FormDestroy(Sender: TObject);
begin
  if FileIsOpen
    then begin
      CloseFile(FHandle);
      FileIsOpen:=FALSE;
    end;
end;

procedure TUmowaDlg.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key=#13
    then begin
      Key:=#0;
      Perform(wm_NextDlgCtl,0,0);
    end;
end;

procedure TUmowaDlg.OKBtnClick(Sender: TObject);
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

procedure TUmowaDlg.CB1Change(Sender: TObject);
begin
  Combo3.ItemIndex:=CB1.ItemIndex;
  Combo12.ItemIndex:=CB1.ItemIndex;
end;

procedure TUmowaDlg.Combo3Change(Sender: TObject);
begin
  CB1.ItemIndex:=Combo3.ItemIndex;
  Combo12.ItemIndex:=Combo3.ItemIndex;
end;

procedure TUmowaDlg.Combo12Change(Sender: TObject);
begin
  CB1.ItemIndex:=Combo12.ItemIndex;
  Combo3.ItemIndex:=Combo12.ItemIndex;
end;

procedure TUmowaDlg.HelpBtnClick(Sender: TObject);
begin
  Application.HelpContext(401);
end;

end.

