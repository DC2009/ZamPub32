unit Zp45;

interface

uses WinTypes, WinProcs, Classes, Graphics, Forms, Controls, Buttons,
  StdCtrls, Mask, ExtCtrls, SysUtils, Messages, Dialogs,
  UserUnit,
  SkOk,
  RPrev, Grids, Printers, Esgrid, Sk;

const
  Col3L1='Liczba';
  Col3L2='wymaganych kopii';

type
  TZP45Dlg = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
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
    SG: TEnhStringGrid;
    Label29: TLabel;
    NumEdit: TEdit;
    AddBtn: TButton;
    InsertBtn: TButton;
    DelBtn: TButton;
    Sk: TSmartKey;
    procedure FormCreate(Sender: TObject);
    procedure PreviewBtnClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure SGKeyPress(Sender: TObject; var Key: Char);
    procedure OpenBtnClick(Sender: TObject);
    procedure SaveBtnClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure OKBtnClick(Sender: TObject);
    procedure HelpBtnClick(Sender: TObject);
    procedure AddBtnClick(Sender: TObject);
    procedure InsertBtnClick(Sender: TObject);
    procedure DelBtnClick(Sender: TObject);
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
    procedure MakeKritHeadRect(Ry:TRyPrinter; var PPos:Integer);
    procedure ClearSG;
  public
    { Public declarations }
  end;

var
  ZP45Dlg: TZP45Dlg;

procedure DrukZp45; export;

implementation

{$R *.DFM}

uses
  SiwzIni,
  ZpBoxes,
  Utils,
  DrMsg;

const
  DCol=0;
  NCol=1;

procedure DrukZp45;
var
  Cur:Integer;
begin
  Cur:=Screen.Cursor;
  Screen.Cursor:=crHourGlass;
  ZP45Dlg:=TZp45Dlg.Create(Nil);
  Screen.Cursor:=Cur;
  ZP45Dlg.ShowModal;
  ZP45Dlg.Free;
end;

procedure TZP45Dlg.FormCreate(Sender: TObject);
var
  i:Integer;
begin
  Application.HelpFile:=DruZpHelpFile;
  FilePwd:=LoadFilePwd(AddBackSlash(ProgramDir)+SecurityFileName);
  ClearSG;
end;

procedure TZP45Dlg.ClearSG;
var
  i,j:LongInt;
begin
  SG.Cells[DCol,0]:='Nazwa (rodzaj) dokumentu';
  SG.Cells[NCol,0]:='Liczba wym. kopii';
  for i:=0 to SG.ColCount-1 do
    for j:=1 to SG.RowCount-1 do
      SG.Cells[i,j]:='';
end;

procedure TZP45Dlg.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key=#13
    then begin
      Key:=#0;
      Perform(wm_NextDlgCtl,0,0);
    end;
end;

procedure TZP45Dlg.SGKeyPress(Sender: TObject; var Key: Char);
var
  Rct:TGridRect;
begin
  if SG.Selection.Left=NCol
    then begin
      if (not (Key in ['0'..'9',#8]))
        then Key:=#0
    end;
end;

procedure TZP45Dlg.MakeKritHeadRect(Ry:TRyPrinter; var PPos:Integer);
var
  Rct:TRect;
  p:Byte;
  LP:Integer;
  A,B:Integer;
begin
  with Ry do
    begin
      Rct.Left:=XLOff;
      Rct.Right:=XROff;
      Rct.Top:=PPos+Ymm(3);
      Font.Size:=10;
      LP:=Rct.Top+Ymm(2);
      A:=Rct.Left+Xmm(10);
      B:=Rct.Right-TextWidth(Col3L2)-Xmm(5);
      Line(Point(Rct.Left,Rct.Top),Point(Rct.Right,Rct.Top));
      TextOutCenter(((A-Rct.Left) div 2)+Rct.Left,LP,'l.p.');
      TextOutCenter(((B-A)div 2)+A,LP,SG.Cells[DCol,0]);
      TextOutCenter(((XROff-B)div 2)+B,LP,Col3L1);
      LP:=LP+TextHeight+Ymm(1);
      TextOutCenter(((XROff-B)div 2)+B,LP,Col3L2);
      LP:=LP+TextHeight+Ymm(1);
      Rct.Bottom:=LP;
      Line(Point(Rct.Left,Rct.Top),Point(Rct.Left,Rct.Bottom));
      Line(Point(A,Rct.Top),Point(A,Rct.Bottom));
      Line(Point(B,Rct.Top),Point(B,Rct.Bottom));
      Line(Point(Rct.Right,Rct.Top),Point(Rct.Right,Rct.Bottom));
      Line(Point(Rct.Left,Rct.Bottom),Point(Rct.Right,Rct.Bottom));
      PPos:=Rct.Bottom;
    end;
end;

procedure TZp45Dlg.AddBox(ARec:Integer);
var
  A,B:Integer;
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
        Line(Point(B,Rct.Top),Point(B,Rct.Bottom));
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
          A:=Rct.Left+Xmm(10);
          B:=Rct.Right-TextWidth(Col3L2)-Xmm(5);
        end;
      s:=IntToStr(ARec);
      q1:=StrAlloc(Length(s)+1);
      StrPCopy(q1,s);
      s:=SG.Cells[DCol,ARec];
      q2:=StrAlloc(Length(s)+1);
      StrPCopy(q2,s);
      s:=SG.Cells[NCol,ARec];
      q3:=StrAlloc(Length(s)+1);
      StrPCopy(q3,s);
      p1:=q1; p2:=q2; p3:=q3;
      while (p1<>nil) or (p2<>nil) or (p3<>nil) do
        begin
          if p1<>Nil
            then H1:=PCharOut(Rect(Rct.Left+Xmm(2),LP,A-Xmm(2),PrintSpace-LP),p1, False, False, TRUE,p1)
            else H1:=0;
          if p2<>Nil
            then H2:=PCharOut(Rect(A+Xmm(2),LP,B-Xmm(2),PrintSpace-LP),p2, False, False, TRUE,p2)
            else H2:=0;
          if p3<>Nil
            then H3:=PCharOut(Rect(B+Xmm(2),LP,Rct.Right-Xmm(2),PrintSpace-LP),p3, False, False, TRUE,p3)
            else H3:=0;
          if H2>H1 then H1:=H2;
          if H3>H1 then H1:=H3; {H1=max(Hx)}
          Rct.Bottom:=H1+LP+Ymm(4);
          DoRect;
          if (LP+H1+Ymm(4)>PrintSpace)
            then begin
              MakeNewPage(Ry,Zp45Tit1+Zp45Tit2,'45',NumEdit.Text,PPos,PrintSpace);
              MakeFooter(Ry,PrintSpace);
              MakeKritHeadRect(Ry,PPos);
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

procedure TZp45Dlg.MakePrint;
var
  p : PChar;
  x:LongInt;
begin
    with Ry do
      begin
        Orientation:=poPortrait;
        NewJob;
        SetMinMargins(Xmm(20),Ymm(10),Xmm(20),Ymm(10));
        MakeHeader(Ry,Zp45Tit1+Zp45Tit2,'45',NumEdit.Text,'',PPos);
        PrintSpace:=YBOff-Ymm(PageBottomSpace)-Ymm(15);
        MakeKritHeadRect(Ry,PPos);
        MakeFooter(Ry,PrintSpace);
        for x:=1 to SG.RowCount-1 do
          AddBox(x);
      end;
end;

procedure TZP45Dlg.PreviewBtnClick(Sender: TObject);
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

procedure TZp45Dlg.SaveFile;
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
      SaveString(Zp45FileHdr,FHandle);
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

procedure TZp45Dlg.LoadFile;
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
        if s=Zp45FileHdr
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

procedure TZp45Dlg.OpenBtnClick(Sender: TObject);
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

procedure TZp45Dlg.SaveBtnClick(Sender: TObject);
begin
  if SaveDialog.Execute
    then begin
      FileName:=SaveDialog.FileName;
      SaveFile;
    end;
end;

procedure TZp45Dlg.FormDestroy(Sender: TObject);
begin
  if FileIsOpen
    then begin
      CloseFile(FHandle);
      FileIsOpen:=FALSE;
    end;
end;

procedure TZP45Dlg.OKBtnClick(Sender: TObject);
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

procedure TZP45Dlg.HelpBtnClick(Sender: TObject);
begin
  Application.HelpContext(45);
end;

procedure TZP45Dlg.AddBtnClick(Sender: TObject);
begin
  SG.InsertRow(SG.RowCount);
end;

procedure TZP45Dlg.InsertBtnClick(Sender: TObject);
begin
  SG.InsertRow(SG.Row);
end;

procedure TZP45Dlg.DelBtnClick(Sender: TObject);
begin
  SG.DeleteRow(SG.Row);
end;

end.
