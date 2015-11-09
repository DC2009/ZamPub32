unit Oswpom;

interface

uses WinTypes, WinProcs, Classes, Graphics, Forms, Controls, Buttons,
  StdCtrls, ExtCtrls, Mask, TabNotBk, Grids, Spin, SysUtils,
  Messages, Dialogs, Printers,
  Utils,
  UserUnit,
  SiwzIni,
  ZpBoxes,
  SkOk,
  RPrev, IntDate, Sk;

const
  OswFileHdr='ZP3DEC';

type
  TOswDlg = class(TForm)
    ScrollBox1: TScrollBox;
    Panel11: TPanel;
    Panel12: TPanel;
    OKBtn: TBitBtn;
    CancelBtn: TBitBtn;
    PrintBtn: TBitBtn;
    PreviewBtn: TBitBtn;
    OpenBtn: TBitBtn;
    SaveBtn: TBitBtn;
    HelpBtn: TBitBtn;
    Panel1: TPanel;
    Memo1_1: TMemo;
    Memo1_2: TMemo;
    Memo1_3: TMemo;
    Memo1_4: TMemo;
    Memo1_5: TMemo;
    Memo1_6: TMemo;
    Edit1_7: TEdit;
    Edit1_0: TEdit;
    OpenDialog: TOpenDialog;
    SaveDialog: TSaveDialog;
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
    FilePwd:String;
    FileIsOpen:Boolean;
    FHandle:File;
    procedure LoadFile;
    procedure SaveFile;
    procedure MakePrint;
    procedure MakeBox1(Ry:TRyPrinter; var PPos:Integer);
  public
    { Public declarations }
  end;

var
  OswDlg: TOswDlg;

procedure Oswiadczenie;export;

implementation

{$R *.DFM}

uses
  DrMsg,
  DateUtil;

procedure Oswiadczenie;
var
  Cur:Integer;
begin
  Cur:=Screen.Cursor;
  Screen.Cursor:=crHourGlass;
  OswDlg:=TOswDlg.Create(Nil);
  Screen.Cursor:=Cur;
  OswDlg.ShowModal;
  OswDlg.Free;
end;

procedure TOswDlg.NumEditKeyPress(Sender: TObject; var Key: Char);
begin
  if not (Key in ['0'..'9',#8])
    then begin
      Key:=#0;
      MessageBeep(0);
    end;
end;

procedure TOswDlg.FormCreate(Sender: TObject);
begin
  Application.HelpFile:=RapHelpFile;
  FilePwd:=LoadFilePwd(AddBackSlash(ProgramDir)+SecurityFileName);
end;

procedure TOswDlg.MakePrint;
var
  p,q,r:PChar;
begin
    with Ry do
      begin
        NewJob;
        SetMinMargins(Xmm(20),Ymm(10),Xmm(20),Ymm(10));
        PrintSpace:=YBOff-Ymm(35);
        MakeBox1(Ry,PPos);
      end;
end;

procedure TOswDlg.PreviewBtnClick(Sender: TObject);
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

procedure TOswDlg.PrintBtnClick(Sender: TObject);
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

procedure TOswDlg.SaveFile;
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
      SaveString(OswFileHdr,FHandle);
      SaveString(FilePwd,FHandle);
      MakeCodeKey(FilePwd);
      SaveEdit(Edit1_0,FHandle);
      SaveMemo(Memo1_1,FHandle);
      SaveMemo(Memo1_2,FHandle);
      SaveMemo(Memo1_3,FHandle);
      SaveMemo(Memo1_4,FHandle);
      SaveMemo(Memo1_5,FHandle);
      SaveMemo(Memo1_6,FHandle);
      SaveEdit(Edit1_7,FHandle);
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

procedure TOswDlg.LoadFile;
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
        if s=OswFileHdr
          then begin
            LoadString(FPwd,FHandle);
            if (FPwd=FilePwd)
              then begin
                MakeCodeKey(FPwd);
                LoadEdit(Edit1_0,FHandle);
                LoadMemo(Memo1_1,FHandle);
                LoadMemo(Memo1_2,FHandle);
                LoadMemo(Memo1_3,FHandle);
                LoadMemo(Memo1_4,FHandle);
                LoadMemo(Memo1_5,FHandle);
                LoadMemo(Memo1_6,FHandle);
                LoadEdit(Edit1_7,FHandle);
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

procedure TOswDlg.OpenBtnClick(Sender: TObject);
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

procedure TOswDlg.SaveBtnClick(Sender: TObject);
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

procedure TOswDlg.FormDestroy(Sender: TObject);
begin
  if FileIsOpen
    then begin
      CloseFile(FHandle);
      FileIsOpen:=FALSE;
    end;
end;

procedure TOswDlg.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key=#13
    then begin
      Key:=#0;
      Perform(wm_NextDlgCtl,0,0);
    end;
end;

procedure TOswDlg.OKBtnClick(Sender: TObject);
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

procedure TOswDlg.HelpBtnClick(Sender: TObject);
begin
  Application.HelpContext(401);
end;

procedure TOswDlg.MakeBox1(Ry:TRyPrinter; var PPos:Integer);
const
 TitleOsw='OŒWIADCZENIE';
var
  Rct:TRect;
  Tx:Integer;
  LP:Integer; {Line position}
  p:PChar;
  procedure Print(q:PChar;Space:Integer);
  var
    X:Integer;
  begin
    while (q<>Nil) and (q[0]<>#0) do
      with Ry do
        begin
          X:=PCharOut(Rect(Tx,LP,Rct.Right-Xmm(3),PrintSpace-LP-Ymm(Space)), q, False, False, TRUE,q);
          if LP+X+Ymm(Space)>PrintSpace
            then begin
              Rct.Bottom:=LP+X+Ymm(Space)+Ymm(1);
              NewPage;
              Rct.Top:=PPos+Xmm(3);
              LP:=Rct.Top+Ymm(2);
            end
            else LP:=LP+X+Ymm(Space);
        end;
  end;
begin
  with Ry do
    begin
      Rct.Left:=XLOff;
      Rct.Right:=XROff;
      Rct.Top:=PPos+Xmm(3);
      Tx:=Rct.Left+Xmm(2);
      Font.Name:='Arial CE';
      LP:=Rct.Top+Ymm(30);
      Line(Point(Tx,LP),Point(Tx+Xmm(50),LP));
      LP:=LP+5;
      Font.Size:=8;
      TextOutCenter(Tx+Xmm(25),LP,'(Pieczêæ firmowa)');
      LP:=LP+Ymm(20);
      Font.Size:=18;
      TextOutCenter(XLOff+(XROff-XLOff)div 2,LP,TitleOsw);
      LP:=LP+Ymm(20);
      Font.Size:=10;
      p:=StrAlloc(Length(Edit1_0.Text)+1);
      StrPCopy(p, Edit1_0.Text);
      Print(p,1);
      StrDispose(p);
      p:=StrAlloc(Memo1_1.GetTextLen + 1);
      Memo1_1.GetTextBuf(p, Memo1_1.GetTextLen+1);
      Print(p,1);
      StrDispose(p);
      p:=StrAlloc(Memo1_2.GetTextLen + 1);
      Memo1_2.GetTextBuf(p, Memo1_2.GetTextLen+1);
      Print(p,1);
      StrDispose(p);
      p:=StrAlloc(Memo1_3.GetTextLen + 1);
      Memo1_3.GetTextBuf(p, Memo1_3.GetTextLen+1);
      Print(p,1);
      StrDispose(p);
      p:=StrAlloc(Memo1_4.GetTextLen + 1);
      Memo1_4.GetTextBuf(p, Memo1_4.GetTextLen+1);
      Print(p,1);
      StrDispose(p);
      p:=StrAlloc(Memo1_5.GetTextLen + 1);
      Memo1_5.GetTextBuf(p, Memo1_5.GetTextLen+1);
      Print(p,1);
      StrDispose(p);
      p:=StrAlloc(Memo1_6.GetTextLen + 1);
      Memo1_6.GetTextBuf(p, Memo1_6.GetTextLen+1);
      Print(p,30);
      StrDispose(p);
      Font.Size:=8;
      Line(Point(Tx,LP),Point(Tx+TextWidth(Edit1_7.Text)+Ymm(10),LP));
      LP:=LP+5;
      TextOutCenter(Tx+TextWidth(Edit1_7.Text)div 2+Ymm(5),LP,Edit1_7.Text);
    end;
end;

end.
procedure AddBox(Ry:TRyPrinter; const P:Array of PChar; const D:Array of Byte;
                 ATitle,ZpNum,NumSpraw:String; var PageSpace:Integer; var PPos:Integer);
var
  Rct:TRect;
  Tx:Integer;
  LH:Integer; {Line height}
  LP:Integer; {Line position}
  X:Integer;
  i:Word;
  q,r:PChar;
  NoRect:Boolean;
  procedure DoRect;
  begin
    with Ry do
      begin
        RoundRectangle(Rct);
      end;
  end;
begin
  with Ry do
    begin
      NoRect:=FALSE;
      Rct.Left:=XLOff;
      Rct.Right:=XROff;
      Rct.Top:=PPos+Xmm(3);
      Tx:=Rct.Left+Xmm(2);
      Font.Size:=10;
      LH:=TextHeight+Ymm(1);
      LP:=Rct.Top+Ymm(2);
      i:=0;
      while (i<=High(P)) do
        begin
          q:=P[i];
          while (q<>Nil) and (q[0]<>#0) do
            begin
              X:=PCharOut(Rect(Tx,LP,Rct.Right-Xmm(3),PageSpace-LP-Ymm(D[i])), q, False, False, TRUE,q);
              if LP+X+Ymm(D[i])>PageSpace
                then begin
                  Rct.Bottom:=LP+X+Ymm(D[i])+Ymm(1);
                  DoRect;
                  if q=nil
                    then NoRect:=TRUE;
                  MakeNewPage(Ry,ATitle,ZpNum,NumSpraw,PPos,PageSpace);
                  Rct.Top:=PPos+Xmm(3);
                  LP:=Rct.Top+Ymm(2);
                end
                else LP:=LP+X+Ymm(D[i]);
            end;
          Inc(i);
        end;
      Rct.Bottom:=LP+Ymm(1);
      if not NoRect
        then DoRect;
      PPos:=Rct.Bottom;
    end;
end;


