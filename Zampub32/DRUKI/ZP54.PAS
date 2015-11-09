unit Zp54;

interface

uses WinTypes, WinProcs, Classes, Graphics, Forms, Controls, Buttons,
  StdCtrls, ExtCtrls, Printers, SysUtils, Dialogs,
  SiwzIni,
  DrMsg,
  Utils,
  SkOk,
  ZpBoxes,
  UserUnit,
  RPrev, Sk;
const
  Sec1='TAJNE - udostêpniane po wyborze oferty lub po zakoñczeniu postêpowania, je¿eli nie dosz³o ';
  Sec2='do wyboru oferty, dostawcom / wykonawcom, którzy ubiegali siê o udzielenie zamówienia.';

type
  TZp54Dlg = class(TForm)
    Panel1: TPanel;
    Memo1: TMemo;
    Panel2: TPanel;
    Label1: TLabel;
    Memo2: TMemo;
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
    procedure SaveBtnClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure OKBtnClick(Sender: TObject);
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
    procedure Addbox;
    procedure LoadFile;
    procedure MakePrint;
    procedure MakeSecretBox(var PPos:Integer);
    procedure SaveFile;
  public
    { Public declarations }
  end;

var
  Zp54Dlg: TZp54Dlg;

procedure DrukZp54; export;

implementation

{$R *.DFM}

procedure DrukZp54;
var
  Cur:Integer;
begin
  Cur:=Screen.Cursor;
  Screen.Cursor:=crHourGlass;
  ZP54Dlg:=TZp54Dlg.Create(Nil);
  Screen.Cursor:=Cur;
  ZP54Dlg.ShowModal;
  ZP54Dlg.Free;
end;

procedure TZp54Dlg.FormCreate(Sender: TObject);
begin
  Application.HelpFile:=DruZpHelpFile;
  FilePwd:=LoadFilePwd(AddBackSlash(ProgramDir)+SecurityFileName);
  Memo1.Clear;
  Memo1.Lines.Add(Sec1+Sec2);
end;

procedure TZp54Dlg.MakeSecretBox(var PPos:Integer);
var
  Rct:TRect;
  X:Integer;
  p:PChar;
begin
  with Ry do
    begin
      Rct.Left:=XLOff;
      Rct.Right:=XROff;
      Rct.Top:=PPos+Xmm(4);
      Font.Size:=14;
      p:=StrAlloc(Length(Sec1)+Length(Sec2)+1);
      StrPCopy(p,Sec1+Sec2);
      X:=MemoOut(Rect(Rct.Left+Xmm(3),Rct.Top+Ymm(1),Rct.Right-Xmm(3),10),p,False,False);
      Rct.Bottom:=Rct.Top+X+Ymm(2);
      StrDispose(p);
      RoundRectangle(Rct);
      PPos:=Rct.Bottom;
    end;
end;

procedure TZp54Dlg.Addbox;
var
  Rct:TRect;
  p,q:PChar;
  LP,X:LongInt;
begin
  with Ry do
    begin
      Rct.Left:=XLOff;
      Rct.Right:=XROff;
      Rct.Top:=PPos+Xmm(3);
      LP:=Rct.Top+Ymm(2);
      Font.Size:=10;
      p:=StrAlloc(Length(Label1.Caption)+Memo2.GetTextLen+1);
      StrPCopy(p,Label1.Caption);
      q:=StrAlloc(Memo2.GetTextLen + 1);
      Memo2.GetTextBuf(q, Memo2.GetTextLen+1);
      StrCat(p,q);
      StrDispose(q);
      q:=p;
      while (q<>nil) do
        begin
          X:=PCharOut(Rect(Rct.Left+Xmm(2),LP,Rct.Right-Xmm(2),PrintSpace-LP-Ymm(4)),q, False, False, TRUE,q);
          Rct.Bottom:=X+LP+Ymm(3);
          RoundRectangle(Rct);
          if (LP+X+Ymm(4)>PrintSpace) and (q<>nil)
            then begin
              MakeNewPage(Ry,Zp54Tit,'54',NumEdit.Text,PPos,PrintSpace);
              MakeFooter(Ry,PrintSpace);
              MakeSecretBox(PPos);
              Font.Size:=10;
              Rct.Top:=PPos+Xmm(3);
              LP:=Rct.Top+Ymm(2);
            end;
        end;
      StrDispose(p);
    end;
end;

procedure TZp54Dlg.MakePrint;
begin
  with Ry do
    begin
      Orientation:=poPortrait;
      NewJob;
      SetMinMargins(Xmm(20),Ymm(10),Xmm(20),Ymm(10));
      MakeHeader(Ry,Zp54Tit,'54',NumEdit.Text,'',PPos);
      PrintSpace:=YBOff-Ymm(35);
      MakeFooter(Ry,PrintSpace);
      MakeSecretBox(PPos);
      AddBox;
    end;
end;

procedure TZp54Dlg.PreviewBtnClick(Sender: TObject);
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

procedure TZp54Dlg.SaveFile;
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
      SaveString(Zp54FileHdr,FHandle);
      SaveString(FilePwd,FHandle);
      MakeCodeKey(FilePwd);
      SaveEdit(NumEdit,FHandle);
      SaveMemo(Memo2,FHandle);
      FileIsOpen:=TRUE;
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

procedure TZp54Dlg.LoadFile;
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
        if s=Zp54FileHdr
          then begin
            LoadString(s,FHandle);
            if (s=FilePwd)
              then begin
                MakeCodeKey(FilePwd);
                LoadEdit(NumEdit,FHandle);
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

procedure TZp54Dlg.OpenBtnClick(Sender: TObject);
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

procedure TZp54Dlg.SaveBtnClick(Sender: TObject);
begin
  if SaveDialog.Execute
    then begin
      FileName:=SaveDialog.FileName;
      SaveFile;
    end;
end;

procedure TZp54Dlg.FormDestroy(Sender: TObject);
begin
  if FileIsOpen
    then begin
      CloseFile(FHandle);
      FileIsOpen:=FALSE;
    end;
end;

procedure TZp54Dlg.OKBtnClick(Sender: TObject);
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

procedure TZp54Dlg.HelpBtnClick(Sender: TObject);
begin
  Application.HelpContext(54);
end;

end.
