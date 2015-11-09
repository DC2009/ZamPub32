unit Zp71;

interface

uses WinTypes, WinProcs, Classes, Graphics, Forms, Controls, Buttons,
  StdCtrls, ExtCtrls, Printers, SysUtils,
  SiwzIni,
  DrMsg,
  Utils,
  SkOk,
  UserUnit,
  ZpBoxes,
  RPrev, Menus, Dialogs, Sk;

type
  TZp71Dlg = class(TForm)
    Panel1: TPanel;
    Memo1: TMemo;
    Panel2: TPanel;
    Label1: TLabel;
    Memo2: TMemo;
    Label2: TLabel;
    CB1: TComboBox;
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
    Label29: TLabel;
    NumEdit: TEdit;
    Sk: TSmartKey;
    procedure PreviewBtnClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure OpenBtnClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure SaveBtnClick(Sender: TObject);
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
  public
    { Public declarations }
  end;

var
  Zp71Dlg: TZp71Dlg;

procedure DrukZp71; export;

implementation

{$R *.DFM}

procedure DrukZp71;
var
  Cur:Integer;
begin
  Cur:=Screen.Cursor;
  Screen.Cursor:=crHourGlass;
  ZP71Dlg:=TZp71Dlg.Create(Nil);
  Screen.Cursor:=Cur;
  ZP71Dlg.ShowModal;
  ZP71Dlg.Free;
end;

procedure MakeSecretBox(Ry:TRyPrinter; p:PChar; var PPos:Integer);
var
  Rct:TRect;
  X:Integer;
begin
  with Ry do
    begin
      Rct.Left:=XLOff;
      Rct.Right:=XROff;
      Rct.Top:=PPos+Xmm(4);
      Font.Size:=14;
      X:=MemoOut(Rect(Rct.Left+Xmm(3),Rct.Top+Ymm(1),Rct.Right-Xmm(3),10),p,False,False);
      Rct.Bottom:=Rct.Top+X+Ymm(2);
      RoundRectangle(Rct);
      PPos:=Rct.Bottom;
    end;
end;

procedure TZp71Dlg.FormCreate(Sender: TObject);
begin
  Application.HelpFile:=DruZpHelpFile;
  FilePwd:=LoadFilePwd(AddBackSlash(ProgramDir)+SecurityFileName);
  Memo1.Clear;
  Memo1.Lines.Add(Sec1+Sec2);
  FileIsOpen:=FALSE;
end;

procedure TZp71Dlg.MakePrint;
var
  p,q,r,t:PChar;
  x:LongInt;
  FullPage:Boolean;
begin
    with Ry do
      begin
        Orientation:=poPortrait;
        NewJob;
        SetMinMargins(Xmm(20),Ymm(10),Xmm(20),Ymm(10));
        x:=0;
        MakeHeader(Ry,Zp71Tit,'71',NumEdit.Text,'',PPos);
        PrintSpace:=YBOff-Ymm(PageBottomSpace);
        MakeFooter(Ry,PrintSpace);
        p:=StrAlloc(Length(Sec1)+Length(Sec2)+1);
        StrPCopy(p,Sec1+Sec2);
        MakeSecretBox(Ry,p,PPos);
        StrDispose(p);
        p:=StrAlloc(Length(Label1.Caption)+Length(CB1.Text)+Length(Label2.Caption)+Memo2.GetTextLen+4);
        StrPCopy(p,Label1.Caption+CB1.Text+' '+Label2.Caption+#13+#10);
        q:=StrAlloc(Memo2.GetTextLen + 1);
        Memo2.GetTextBuf(q, Memo2.GetTextLen+1);
        StrCat(p,q);
        StrDispose(q);
        AddBox(Ry,[p],[1],ZP71Tit,'71',NumEdit.Text,PrintSpace,PPos);
        StrDispose(p);
      end;
end;

procedure TZp71Dlg.PreviewBtnClick(Sender: TObject);
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

procedure TZp71Dlg.SaveFile;
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
      SaveString(ZP71FileHdr,FHandle);
      SaveString(FilePwd,FHandle);
      MakeCodeKey(FilePwd);
      SaveEdit(NumEdit,FHandle);
      SaveInteger(CB1.ItemIndex,FHandle);
      SaveMemo(Memo2,FHandle);
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

procedure TZp71Dlg.LoadFile;
var
  s:String;
  i:Integer;
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
        if s=ZP71FileHdr
          then begin
            LoadString(s,FHandle);
            if (s=FilePwd)
              then begin
                MakeCodeKey(FilePwd);
                LoadEdit(NumEdit,FHandle);
                LoadInteger(i,FHandle);
                CB1.ItemIndex:=i;
                LoadMemo(Memo2,FHandle);
              end
              else MessageDlg(wmSecurityCode,mtWarning,[mbOk],0);
          end
          else MessageDlg(wmNotAZP,mtWarning,[mbOk],0);
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

procedure TZp71Dlg.OpenBtnClick(Sender: TObject);
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

procedure TZp71Dlg.SaveBtnClick(Sender: TObject);
begin
  if SaveDialog.Execute
    then begin
      FileName:=SaveDialog.FileName;
      SaveFile;
    end;
end;

procedure TZp71Dlg.FormDestroy(Sender: TObject);
begin
  if FileIsOpen
    then begin
      CloseFile(FHandle);
      FileIsOpen:=FALSE;
    end;
end;

procedure TZp71Dlg.OKBtnClick(Sender: TObject);
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

procedure TZp71Dlg.HelpBtnClick(Sender: TObject);
begin
  Application.HelpContext(71);
end;

end.

