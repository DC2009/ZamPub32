unit Zp21;

interface

uses WinTypes, WinProcs, Classes, Graphics, Forms, Controls, Buttons,
  StdCtrls, Mask, ExtCtrls, SysUtils, Messages, Dialogs, Printers,
  Utils,
  UserUnit,
  SkOk,
  RPrev, IntDate, Grids, Esgrid, Sk;

type
  TZP21Dlg = class(TForm)
    Panel1: TPanel;
    Memo: TMemo;
    Label2: TLabel;
    Panel4: TPanel;
    Label1: TLabel;
    Panel2: TPanel;
    AddBtn: TButton;
    DelBtn: TButton;
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
    Date: TIntDate;
    EG: TEnhStringGrid;
    InsertBtn: TButton;
    Label29: TLabel;
    NumEdit: TEdit;
    Sk: TSmartKey;
    procedure AddBtnClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure PreviewBtnClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure OpenBtnClick(Sender: TObject);
    procedure SaveBtnClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure OKBtnClick(Sender: TObject);
    procedure HelpBtnClick(Sender: TObject);
    procedure DelBtnClick(Sender: TObject);
    procedure InsertBtnClick(Sender: TObject);
  private
    { Private declarations }
    ListPos:LongInt;
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
    procedure MakeNameRect(Ry:TRyPrinter; var PPos:Integer);
    procedure MakeTextRect(Ry:TRyPrinter; var PPos:Integer);
  public
    { Public declarations }
  end;

var
  ZP21Dlg: TZP21Dlg;

procedure DrukZp21; export;

implementation

{$R *.DFM}

uses
  SiwzIni,
  ZpBoxes,
  DrMsg;

procedure DrukZp21;
var
  Cur:Integer;
begin
  Cur:=Screen.Cursor;
  Screen.Cursor:=crHourGlass;
  ZP21Dlg:=TZp21Dlg.Create(Nil);
  Screen.Cursor:=Cur;
  ZP21Dlg.ShowModal;
  ZP21Dlg.Free;
end;

procedure TZP21Dlg.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key=#13
    then begin
      Key:=#0;
      Perform(wm_NextDlgCtl,0,0);
    end;
end;

procedure TZP21Dlg.AddBtnClick(Sender: TObject);
begin
  EG.InsertRow(EG.RowCount);
end;

procedure TZP21Dlg.FormCreate(Sender: TObject);
begin
  Application.HelpFile:=DruZpHelpFile;
  FilePwd:=LoadFilePwd(AddBackSlash(ProgramDir)+SecurityFileName);
  EG.Cells[0,0]:='Imiona';
  EG.Cells[1,0]:='Nazwisko';
end;

procedure TZp21Dlg.MakeNameRect(Ry:TRyPrinter; var PPos:Integer);
var
  Rect:TRect;
  Pt1,Pt2:TPoint;
  s:String;
begin
  with Ry do
    begin
      Rect.Left:=XLOff;
      Rect.Top:=PPos+Xmm(4);
      Rect.Right:=XROff;
      Rect.Bottom:=Rect.Top+Ymm(18);
      RoundRectangle(Rect);
      PPos:=Rect.Bottom;
      Font.Size:=10;
      TextOut(Rect.Left+Xmm(3),Rect.Top+Ymm(4),'Imiona');
      TextOut(Rect.Left+Xmm(3),Rect.Top+Ymm(10),'Nazwisko');
      if EG.RowCount>0
        then begin
          s:=EG.Cells[0,ListPos];
          TextOut(Rect.Left+Xmm(10)+TextWidth('Nazwisko'),Rect.Top+Ymm(4),s);
          s:=EG.Cells[1,ListPos];
          TextOut(Rect.Left+Xmm(10)+TextWidth('Nazwisko'),Rect.Top+Ymm(10),s);
        end
        else begin
          Pt1.x:=Rect.Left+Xmm(6)+TextWidth('Nazwisko');
          Pt1.y:=Rect.Top+Ymm(7);
          Pt2.x:=Rect.Right-Xmm(3);
          Pt2.y:=Rect.Top+Ymm(7);
          Line(Pt1,Pt2);
          Pt1.y:=Rect.Top+Ymm(13);
          Pt2.y:=Rect.Top+Ymm(13);
          Line(Pt1,Pt2);
        end;
    end;
end;

procedure TZp21Dlg.MakeTextRect(Ry:TRyPrinter; var PPos:Integer);
var
  Rct:TRect;
  Pt1,Pt2:TPoint;
  p:PChar;
  X:Integer;
  s:String;
begin
  with Ry do
    begin
      Font.Size:=10;
      Rct.Left:=XLOff;
      Rct.Top:=PPos+Xmm(4);
      Rct.Right:=XROff;
      p := StrAlloc(Memo.GetTextLen + 1);
      Memo.GetTextBuf(p, Memo.GetTextLen);
      X:=MemoOut(Rect(Rct.Left+Xmm(3),Rct.Top+Ymm(3),Rct.Right-Xmm(3),100), p, False, False);
      StrDispose(p);
      Rct.Bottom:=Rct.Top+X+Ymm(30);
      RoundRectangle(Rct);
      s:='Dnia  '+Date.Text;
      TextOut(Rct.Left+Xmm(3),Rct.Bottom-Ymm(10),s);
      TextOutRight(Rct.Right-Xmm(10),Rct.Bottom-Ymm(10),'podpis  ________________________________');
    end;
end;

procedure MakeFooter21(Ry:TRyPrinter; PrintSpace:Integer);
var
  Rect:TRect;
  Pt1,Pt2:TPoint;
  p:Byte;
  s:String;
begin
  with Ry do
    begin
      Font.Size:=10;
      TextOutRight(XROff-Xmm(3),PrintSpace + Ymm(10),'podpis zamawiaj¹cego ________________________');
    end;
end;

procedure TZp21Dlg.MakePrint;
begin
    ListPos:=1;
    with Ry do
      begin
        Orientation:=poPortrait;
        NewJob;
        Font.Color:=clBlack;
        SetMinMargins(Xmm(20),Ymm(10),Xmm(20),Ymm(10));
        repeat
          MakeHeader(Ry,Zp21Tit,'21',NumEdit.Text,'1',PPos);
          PrintSpace:=YBOff-Ymm(35);
          MakeFooter21(Ry,PrintSpace);
          MakeNameRect(Ry,PPos);
          MakeTextRect(Ry,PPos);
          Inc(ListPos);
          if ListPos<EG.RowCount
            then NewPage;
        until ListPos>=EG.RowCount;
      end;
end;

procedure TZp21Dlg.PreviewBtnClick(Sender: TObject);
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

procedure TZp21Dlg.SaveFile;
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
      SaveString(Zp21FileHdr,FHandle);
      SaveString(FilePwd,FHandle);
      MakeCodeKey(FilePwd);
      SaveEdit(NumEdit,FHandle);
      SaveStringGrid(EG,FHandle);
      SaveDateTime(Date.EditDate,FHandle);
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

procedure TZp21Dlg.LoadFile;
var
  s:String;
  i:Integer;
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
        if s=Zp21FileHdr
          then begin
            LoadString(s,FHandle);
            if (s=FilePwd)
              then begin
                MakeCodeKey(FilePwd);
                LoadEdit(NumEdit,FHandle);
                LoadStringGrid(TStringGrid(EG),FHandle);
                LoadDateTime(DT,FHandle);
                Date.EditDate:=DT;
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

procedure TZp21Dlg.OpenBtnClick(Sender: TObject);
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

procedure TZp21Dlg.SaveBtnClick(Sender: TObject);
begin
  if SaveDialog.Execute
    then begin
      FileName:=SaveDialog.FileName;
      SaveFile;
    end;
end;

procedure TZp21Dlg.FormDestroy(Sender: TObject);
begin
  if FileIsOpen
    then begin
      CloseFile(FHandle);
      FileIsOpen:=FALSE;
    end;
end;

procedure TZP21Dlg.OKBtnClick(Sender: TObject);
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

procedure TZP21Dlg.HelpBtnClick(Sender: TObject);
begin
  Application.HelpContext(21);
end;

procedure TZP21Dlg.DelBtnClick(Sender: TObject);
begin
  EG.DeleteRow(EG.Row);
end;

procedure TZP21Dlg.InsertBtnClick(Sender: TObject);
begin
  EG.InsertRow(EG.Row);
end;

end.
