unit Zp81;

interface

uses WinTypes, WinProcs, Classes, Graphics, Forms, Controls, Buttons,
  StdCtrls, Mask, ExtCtrls, SysUtils, Messages, Dialogs,
  UserUnit,
  SkOk,
  RPrev, Grids, Printers, Esgrid, Sk;

type
  TZP81Dlg = class(TForm)
    Panel1: TPanel;
    Label2: TLabel;
    Panel2: TPanel;
    OKBtn: TBitBtn;
    CancelBtn: TBitBtn;
    PrintBtn: TBitBtn;
    PreviewBtn: TBitBtn;
    OpenBtn: TBitBtn;
    SaveBtn: TBitBtn;
    HelpBtn: TBitBtn;
    OpenDialog: TOpenDialog;
    SaveDialog: TSaveDialog;
    Panel3: TPanel;
    Memo1: TMemo;
    SG: TEnhStringGrid;
    AddBtn: TButton;
    InsertBtn: TButton;
    DelBtn: TButton;
    Label29: TLabel;
    NumEdit: TEdit;
    Sk: TSmartKey;
    procedure FormCreate(Sender: TObject);
    procedure PreviewBtnClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure PrintBtnClick(Sender: TObject);
    procedure OpenBtnClick(Sender: TObject);
    procedure SaveBtnClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure OKBtnClick(Sender: TObject);
    procedure AddBtnClick(Sender: TObject);
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
    procedure AddBox(ARec:Integer);
    procedure LoadFile;
    procedure SaveFile;
    procedure MakePrint;
    procedure ClearSG;
    procedure MakeSecretBox;
    procedure MakeKritHeadRect;
  public
    { Public declarations }
  end;

var
  ZP81Dlg: TZP81Dlg;

procedure DrukZp81; export;

implementation

{$R *.DFM}

uses
  SiwzIni,
  ZpBoxes,
  Utils,
  DrMsg;

const
  NCol=1;
  SCol=2;

procedure DrukZp81;
var
  Cur:Integer;
begin
  Cur:=Screen.Cursor;
  Screen.Cursor:=crHourGlass;
  ZP81Dlg:=TZp81Dlg.Create(Nil);
  Screen.Cursor:=Cur;
  ZP81Dlg.ShowModal;
  ZP81Dlg.Free;
end;

procedure TZP81Dlg.ClearSG;
var
  i,j:LongInt;
begin
  for i:=0 to SG.ColCount-1 do
    for j:=1 to SG.RowCount-1 do
      SG.Cells[i,j]:='';
end;

procedure TZP81Dlg.FormCreate(Sender: TObject);
var
  i:Integer;
begin
  Application.HelpFile:=DruZpHelpFile;
  FilePwd:=LoadFilePwd(AddBackSlash(ProgramDir)+SecurityFileName);
  SG.Cells[0,0]:='l.p.';
  SG.Cells[NCol,0]:='Imiê';
  SG.Cells[SCol,0]:='Nazwisko';
  for i:=1 to SG.RowCount-1 do
    SG.Cells[0,i]:=' '+IntToStr(i);
end;

procedure TZP81Dlg.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key=#13
    then begin
      Key:=#0;
      Perform(wm_NextDlgCtl,0,0);
    end;
end;

procedure TZP81Dlg.MakeSecretBox;
var
  Rct:TRect;
  X:Integer;
  p:PChar;
begin
  with Ry do
    begin
      Rct.Left:=XLOff;
      Rct.Right:=XROff;
      Rct.Top:=PPos+Ymm(4);
      Font.Size:=16;
      p:=StrAlloc(Length(Sec1)+Length(Sec2)+1);
      StrPCopy(p,Sec1+Sec2);
      X:=MemoOut(Rect(XLOff+Xmm(4),Rct.Top+Ymm(2),XROff-Xmm(4),10),p,False,False);
      Rct.Bottom:=Rct.Top+Ymm(4)+X;
      RoundRectangle(Rct);
      PPos:=Rct.Bottom;
    end;
end;

procedure TZP81Dlg.MakeKritHeadRect;
var
  A:Integer;
  x:Integer;
  p:Byte;
  s:String;
begin
  with Ry do
    begin
      PPos:=PPos+Ymm(4);
      x:=PPos;
      A:=XLOff+Xmm(10);
      Font.Size:=10;
      Line(Point(XLOff,x),Point(XROff,x));
      TextOutCenter(((A-XLOff)div 2)+XLOff,x+Ymm(2),'l.p.');
      PPos:=PPOs+TextHeight+Ymm(4);
      Line(Point(XLOff,PPos),Point(XROff,PPos));
      Line(Point(XLOff,x),Point(XLOff,PPos));
      Line(Point(XROff,x),Point(XROff,PPos));
      Line(Point(A,x),Point(A,PPos));
    end;
end;

procedure TZp81Dlg.AddBox(ARec:Integer);
var
  A:Integer;
  Rct:TRect;
  LP:Integer; {Line position}
  q1,q2,q3,p1,p2,p3:PChar;
  s:String;
  H1,H2,H3:Integer;
  procedure DoRect;
  begin
    with Ry do
      begin
        Line(Point(Rct.Left,Rct.Top),Point(Rct.Left,Rct.Bottom));
        Line(Point(A,Rct.Top),Point(A,Rct.Bottom));
        Line(Point(Rct.Right,Rct.Top),Point(Rct.Right,Rct.Bottom));
        Line(Point(Rct.Left,Rct.Bottom),Point(Rct.Right,Rct.Bottom));
      end;
  end;
begin
  with Ry do
    begin
      with Rct do  {set rectangles}
        begin
          Left:=XLOff;
          Right:=XROff;
          Top:=PPos;
          Font.Size:=10;
          LP:=Top+Ymm(4);
          A:=XLOff+Xmm(10);
        end;
      s:=SG.Cells[0,ARec];
      q1:=StrAlloc(Length(s)+1);
      StrPCopy(q1,s);
      s:='Imiê:     '+SG.Cells[NCol,ARec];
      q2:=StrAlloc(Length(s)+1);
      StrPCopy(q2,s);
      s:='Nazwisko: '+SG.Cells[SCol,ARec];
      q3:=StrAlloc(Length(s)+1);
      StrPCopy(q3,s);
      p1:=q1; p2:=q2; p3:=q3;
      while (p1<>nil) or (p2<>nil) or (p3<>nil) do
        begin
          if p1<>Nil
            then H1:=PCharOut(Rect(Rct.Left+Xmm(2),LP,A-Xmm(2),PrintSpace-LP),p1, False, False, TRUE,p1)
            else H1:=0;
          if p2<>Nil
            then H2:=PCharOut(Rect(A+Xmm(2),LP,Rct.Right-Xmm(2),PrintSpace-LP),p2, False, False, TRUE,p2)
            else H2:=0;
          if p3<>Nil
            then H3:=PCharOut(Rect(A+Xmm(2),LP+H2+Ymm(2),Rct.Right-Ymm(2),PrintSpace-LP),p3, False, False, TRUE,p3)+H2+Ymm(2)
            else H3:=0;
          if H2>H1 then H1:=H2;
          if H3>H1 then H1:=H3; {H1=max(Hx)}
          Rct.Bottom:=H1+LP+Ymm(4);
          DoRect;
          if (LP+H1+Ymm(4)>PrintSpace)
            then begin
              MakeNewPage(Ry,Zp81Tit,'81',NumEdit.Text,PPos,PrintSpace);
              MakeFooter(Ry,PrintSpace);
              MakeKritHeadRect;
              Rct.Top:=PPos;
              if (p1<>nil) or (p2<>nil) or (p3<>nil)
                then LP:=Rct.Top+Ymm(4)
                else LP:=Rct.Top;
            end
            else LP:=LP+H1+Ymm(4);
        end;
      PPos:=LP;
      StrDispose(p1);
      StrDispose(p2);
      StrDispose(p3);
    end;
end;

procedure TZP81Dlg.MakePrint;
var
  x:LongInt;
begin
  with Ry do
    begin
      Orientation:=poPortrait;
      NewJob;
      SetMinMargins(Xmm(20),Ymm(10),Xmm(20),Ymm(10));
      MakeHeader(Ry,Zp81Tit,'81',NumEdit.Text,'',PPos);
      MakeSecretBox;
      MakeKritHeadRect;
      PrintSpace:=YBOff-Ymm(55);
      MakeFooter(Ry,PrintSpace);
      for x:=1 to SG.RowCount-1 do
        AddBox(x);
    end;
end;

procedure TZP81Dlg.PreviewBtnClick(Sender: TObject);
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

procedure TZP81Dlg.PrintBtnClick(Sender: TObject);
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

procedure TZP81Dlg.SaveFile;
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
      SaveString(Zp81FileHdr,FHandle);
      SaveString(FilePwd,FHandle);
      MakeCodeKey(FilePwd);
      SaveEdit(NumEdit,FHandle);
      SaveStringGrid(SG,FHandle);
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

procedure TZP81Dlg.LoadFile;
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
        if s=Zp81FileHdr
          then begin
            LoadString(s,FHandle);
            if (s=FilePwd)
              then begin
                MakeCodeKey(FilePwd);
                LoadEdit(NumEdit,FHandle);
                ClearSG;
                LoadStringGrid(TStringGrid(SG),FHandle);
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

procedure TZP81Dlg.OpenBtnClick(Sender: TObject);
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

procedure TZP81Dlg.SaveBtnClick(Sender: TObject);
begin
  if SaveDialog.Execute
    then begin
      FileName:=SaveDialog.FileName;
      SaveFile;
    end;
end;

procedure TZP81Dlg.FormDestroy(Sender: TObject);
begin
  if FileIsOpen
    then begin
      CloseFile(FHandle);
      FileIsOpen:=FALSE;
    end;
end;

procedure TZP81Dlg.OKBtnClick(Sender: TObject);
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

procedure TZP81Dlg.AddBtnClick(Sender: TObject);
begin
  SG.RowCount:=SG.RowCount+1;
  SG.Cells[0,SG.RowCount-1]:=' '+IntToStr(SG.RowCount-1);
end;

procedure TZP81Dlg.DelBtnClick(Sender: TObject);
var
  i:LongInt;
begin
  if SG.RowCount=2
    then begin
      SG.Cells[0,SG.RowCount-1]:=' 1';
      SG.Cells[1,SG.RowCount-1]:='';
      SG.Cells[2,SG.RowCount-1]:='';
    end
    else SG.DeleteRow(SG.Row);
end;

procedure TZP81Dlg.HelpBtnClick(Sender: TObject);
begin
  Application.HelpContext(81);
end;

procedure TZP81Dlg.InsertBtnClick(Sender: TObject);
begin
  SG.InsertRow(SG.Row);
  SG.Cells[0,SG.Row]:=' '+IntToStr(SG.Row);
end;

end.
