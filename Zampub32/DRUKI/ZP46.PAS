unit Zp46;

interface

uses WinTypes, WinProcs, Classes, Graphics, Forms, Controls, Buttons,
  StdCtrls, Mask, ExtCtrls, SysUtils, Messages, Dialogs,
  UserUnit,
  SkOk,
  RPrev, Grids, Printers, Esgrid, Sk;

const
  WarunPrintSpace=30;

type
  TZP46Dlg = class(TForm)
    Panel1: TPanel;
    Label2: TLabel;
    SG2: TStringGrid;
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
    AddLineBtn: TButton;
    AddColBtn: TButton;
    DelBtn: TButton;
    DelColBtn: TButton;
    SG1: TEnhStringGrid;
    Panel3: TPanel;
    Memo1: TMemo;
    Label29: TLabel;
    NumEdit: TEdit;
    Sk: TSmartKey;
    procedure FormCreate(Sender: TObject);
    procedure PreviewBtnClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure OpenBtnClick(Sender: TObject);
    procedure SaveBtnClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure OKBtnClick(Sender: TObject);
    procedure AddLineBtnClick(Sender: TObject);
    procedure AddColBtnClick(Sender: TObject);
    procedure SG1KeyPress(Sender: TObject; var Key: Char);
    procedure SG2DblClick(Sender: TObject);
    procedure HelpBtnClick(Sender: TObject);
    procedure DelBtnClick(Sender: TObject);
    procedure DelColBtnClick(Sender: TObject);
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
    procedure ClearSG(SG:TStringGrid);
    procedure MakeSecretBox;
    function GetGridHeadHeight:Integer;
    procedure MakeGridHeadRect(var Places:Byte);
    procedure AddOfferLine(Warun,FOffer,Offers:Integer);
    function GetOfferHeight(Warun:Integer):Integer;
  public
    { Public declarations }
  end;

var
  ZP46Dlg: TZP46Dlg;

procedure DrukZp46; export;

implementation

{$R *.DFM}

uses
  SiwzIni,
  ZpBoxes,
  Utils,
  DrMsg;

const
  WCol=1;

procedure DrukZp46;
var
  Cur:Integer;
begin
  Cur:=Screen.Cursor;
  Screen.Cursor:=crHourGlass;
  ZP46Dlg:=TZp46Dlg.Create(Nil);
  Screen.Cursor:=Cur;
  ZP46Dlg.ShowModal;
  ZP46Dlg.Free;
end;

procedure TZP46Dlg.ClearSG(SG:TStringGrid);
var
  i,j:LongInt;
begin
  for i:=0 to SG.ColCount-1 do
    for j:=1 to SG.RowCount-1 do
      SG.Cells[i,j]:='';
end;

procedure TZP46Dlg.FormCreate(Sender: TObject);
var
  i:Integer;
begin
  Application.HelpFile:=DruZpHelpFile;
  FilePwd:=LoadFilePwd(AddBackSlash(ProgramDir)+SecurityFileName);
  SG1.RowCount:=2;
  SG1.Cells[0,0]:='l.p.';
  SG1.Cells[WCol,0]:='Warunki wymagane od dostawców/wykonawców';
  for i:=1 to SG1.RowCount-1 do
    SG1.Cells[0,i]:=' '+IntToStr(i);
  SG2.RowCount:=2;
  SG2.ColCount:=2;
  for i:=1 to SG2.RowCount-1 do
    SG2.Cells[0,i]:='Warunek '+IntToStr(i);
  for i:=1 to SG2.ColCount-1 do
    SG2.Cells[i,0]:='Oferta '+IntToStr(i);
end;

procedure TZP46Dlg.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key=#13
    then begin
      Key:=#0;
      Perform(wm_NextDlgCtl,0,0);
    end;
end;

procedure TZP46Dlg.SG1KeyPress(Sender: TObject; var Key: Char);
var
  Rct:TGridRect;
begin
  if SG1.Selection.Left=0
    then Key:=#0
end;

procedure TZP46Dlg.MakeSecretBox;
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
      p:=StrAlloc(Length(Sec1)+Length(Sec2_46)+1);
      StrPCopy(p,Sec1+Sec2_46);
      X:=MemoOut(Rect(XLOff+Xmm(4),Rct.Top+Ymm(2),XROff-Xmm(4),10),p,False,False);
      Rct.Bottom:=Rct.Top+Ymm(4)+X;
      RoundRectangle(Rct);
      PPos:=Rct.Bottom;
    end;
end;

function TZp46Dlg.GetGridHeadHeight:Integer;
const
  S1='Warunki wymagane od dostawców/wykonawców';
var
  x:Integer;
begin
  with Ry do
    begin
      x:=Ymm(3);
      x:=x+MemoOut(Rect(XLOff+Xmm(2),X,XLOff+Xmm(38),10),S1,False,TRUE);
      x:=x+Ymm(2);
      Result:=x;
    end;
end;

procedure TZp46Dlg.MakeGridHeadRect(var Places:Byte);
const
  S1='Warunki wymagane od dostawców/wykonawców';
var
  A,B,A1,A2:Integer;
  i:Byte;
  X,y,Z:Integer;
  StartPlaces:Byte;
begin
  with Ry do
    begin
      PPos:=PPos+Ymm(3);
      X:=PPos;
      Font.Size:=10;
      Line(Point(XLOff,X),Point(XROff,X));
      X:=PPos+Ymm(2);
      A:=XLOff+Xmm(40);
      y:=MemoOut(Rect(XLOff+Xmm(2),X,A-Xmm(2),10),S1,False,False);
      TextOutCenter(((XROff-A) div 2)+A,X,'Numer oferty');
      PPos:=X+y div 2;
      Line(Point(A,PPos),Point(XROff,PPos));
      Z:=X+y+Ymm(2);
      Line(Point(XLOff,Z),Point(XROff,Z));
      StartPlaces:=Places;  {Last printed kriterium (first time it should be 0)}
      Places:=0;
      while A+Ymm(WarunPrintSpace)*Places<XROff do
        Inc(Places);
      A1:=A;
      Places:=Places-1;
      for i:=StartPlaces+1 to StartPlaces+Places do
        begin
          A2:=A1+Ymm(WarunPrintSpace);
          TextOutCenter(((A2-A1) div 2)+A1,PPos+Ymm(1),IntToStr(i));
          Line(Point(A1,PPos),Point(A1,Z));
          A1:=A2;
        end;
      Places:=StartPlaces+Places;
      Line(Point(XLOff,X-Ymm(2)),Point(XLOff,Z));
      Line(Point(XROff,X-Ymm(2)),Point(XROff,Z));
      Line(Point(A,X-Ymm(2)),Point(A,Z));
      PPos:=Z;
    end;
end;

function TZp46Dlg.GetOfferHeight(Warun:Integer):Integer;
var
  x:Integer;
  s:String;
begin
  with Ry do
    begin
      s:=SG1.Cells[WCol,Warun];
      x:=MemoOut(Rect(XLOff+Xmm(2),0,XLOff+Xmm(38),10),StringAsPChar(s),False,TRUE);
      Result:=x+Ymm(4);
    end;
end;

procedure TZp46Dlg.AddOfferLine(Warun,FOffer,Offers:Integer);
var
  A,A1,A2:Integer;
  i:Byte;
  X,y,Z:Integer;
  s:String;
begin
  with Ry do
    begin
      x:=PPos;
      Font.Size:=10;
      X:=PPos+Ymm(2);
      A:=XLOff+Xmm(40);
      s:=SG1.Cells[WCol,Warun];
      y:=MemoOut(Rect(XLOff+Xmm(2),X,A-Xmm(2),10),StringAsPChar(s),False,False);
      A1:=A;
      Z:=X+Y+Ymm(2);
      for i:=FOffer+1 to Offers do
        begin
          A2:=A1+Ymm(WarunPrintSpace);
          TextOutCenter(((A2-A1) div 2)+A1,X,SG2.Cells[i,Warun]);
          Line(Point(A1,PPos),Point(A1,Z));
          A1:=A2;
        end;
      Line(Point(XLOff,Z),Point(XROff,Z));
      Line(Point(XLOff,PPos),Point(XLOff,Z));
      Line(Point(XROff,PPos),Point(XROff,Z));
      PPos:=Z;
    end;
end;

procedure TZP46Dlg.MakePrint;
var
  p : PChar;
  Rect:TRect;
  x:LongInt;
  FullPage:Boolean;
  Places:Byte;
  StartPlace:Byte;
  TP:Byte;
  Warun:Integer;
begin
    with Ry do
      begin
        Orientation:=poPortrait;
        NewJob;
        SetMinMargins(Xmm(20),Ymm(10),Xmm(20),Ymm(10));
        x:=1;
        Places:=0;
        StartPlace:=0;
        MakeHeader(Ry,Zp46Tit,'46',NumEdit.Text,'',PPos);
        MakeSecretBox;
        PrintSpace:=YBOff-Ymm(35);
        MakeFooter(Ry,PrintSpace);
        FullPage:=False;
        repeat
          Warun:=1;
          if PPos+GetGridHeadHeight>PrintSpace
            then begin
              MakeHeader(Ry,Zp46Tit,'46',NumEdit.Text,'',PPos);
              MakeSecretBox;
              PrintSpace:=YBOff-Ymm(35);
              MakeFooter(Ry,PrintSpace);
              FullPage:=False;
            end;
          MakeGridHeadRect(Places);
          while Warun<SG2.RowCount do
            begin
              AddOfferLine(Warun,StartPlace,Places);
              if PPos+GetOfferHeight(Warun)+Ymm(10)>PrintSpace
                then begin
                  NewPage;
                  MakeHeader(Ry,Zp46Tit,'46',NumEdit.Text,'',PPos);
                  MakeSecretBox;
                  PrintSpace:=YBOff-Ymm(25);
                  MakeFooter(Ry,PrintSpace);
                  FullPage:=False;
                  TP:=StartPlace;
                  MakeGridHeadRect(TP);
                end;
              Inc(Warun);
            end;
          StartPlace:=Places;
        until Places>=SG2.ColCount-1;
      end;
end;

procedure TZP46Dlg.PreviewBtnClick(Sender: TObject);
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

procedure TZP46Dlg.SaveFile;
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
      SaveString(Zp46FileHdr,FHandle);
      SaveString(FilePwd,FHandle);
      MakeCodeKey(FilePwd);
      SaveEdit(NumEdit,FHandle);
      SaveStringGrid(SG1,FHandle);
      SaveStringGrid(SG2,FHandle);
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

procedure TZP46Dlg.LoadFile;
var
  s:String;
  i:Integer;
  j:LongInt;
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
        if s=Zp46FileHdr
          then begin
            LoadString(s,FHandle);
            if (s=FilePwd)
              then begin
                MakeCodeKey(FilePwd);
                LoadEdit(NumEdit,FHandle);
                ClearSG(SG1);
                LoadStringGrid(TStringGrid(SG1),FHandle);
                ClearSG(SG2);
                LoadStringGrid(SG2,FHandle);
                for j:=1 to SG2.ColCount-1 do
                  SG2.Cells[j,0]:='Oferta '+IntToStr(j);
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

procedure TZP46Dlg.OpenBtnClick(Sender: TObject);
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

procedure TZP46Dlg.SaveBtnClick(Sender: TObject);
begin
  if SaveDialog.Execute
    then begin
      FileName:=SaveDialog.FileName;
      SaveFile;
    end;
end;

procedure TZP46Dlg.FormDestroy(Sender: TObject);
begin
  if FileIsOpen
    then begin
      CloseFile(FHandle);
      FileIsOpen:=FALSE;
    end;
end;

procedure TZP46Dlg.OKBtnClick(Sender: TObject);
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

procedure TZP46Dlg.AddLineBtnClick(Sender: TObject);
begin
  SG1.InsertRow(SG1.RowCount);
  SG1.Cells[0,SG1.RowCount-1]:=' '+IntToStr(SG1.RowCount-1);
  SG1.Cells[1,SG1.RowCount-1]:='';
  SG2.RowCount:=SG2.RowCount+1;
  SG2.Cells[0,SG2.RowCount-1]:='Warunek '+IntToStr(SG2.RowCount-1);
end;

procedure TZP46Dlg.AddColBtnClick(Sender: TObject);
begin
  SG2.ColCount:=SG2.ColCount+1;
  SG2.Cells[SG2.ColCount-1,0]:='Oferta '+IntToStr(SG2.ColCount-1);
end;

procedure TZP46Dlg.DelBtnClick(Sender: TObject);
var
  i,j:LongInt;
begin
  if SG1.RowCount=2
    then begin
      SG1.Cells[0,SG1.RowCount-1]:=' 1';
      SG1.Cells[1,SG1.RowCount-1]:='';
      for j:=1 to SG2.ColCount-1 do
        SG2.Cells[j,1]:='';
    end
  else begin
    if SG1.Selection.Top<SG1.RowCount-1
      then for i:=SG1.Selection.Top to SG1.RowCount-2 do
        begin
          SG1.Cells[1,i]:=SG1.Cells[1,i+1];
          for j:=1 to SG2.ColCount-1 do
            SG2.Cells[j,i]:=SG2.Cells[j,i+1];
        end
      else begin
        SG1.Cells[0,SG1.RowCount-1]:='';
        SG1.Cells[1,SG1.RowCount-1]:='';
      end;
    SG1.RowCount:=SG1.RowCount-1;
    SG2.RowCount:=SG2.RowCount-1;
  end
end;

procedure TZP46Dlg.DelColBtnClick(Sender: TObject);
var
  i,j:LongInt;
begin
  if SG2.ColCount=2
    then begin
      SG2.Cells[SG2.ColCount-1,0]:='Oferta 1';
      for i:=1 to SG2.RowCount-1 do
        SG2.Cells[SG2.ColCount-1,i]:='';
    end
  else begin
    if SG2.Selection.Left<SG2.ColCount-1
      then for j:=SG2.Selection.Left to SG2.ColCount-2 do
        begin
          for i:=1 to SG2.RowCount-1 do
            SG2.Cells[j,i]:=SG2.Cells[j+1,i];
        end
      else for i:=1 to SG2.RowCount-1 do
        SG2.Cells[SG2.ColCount-1,i]:='';
    SG2.ColCount:=SG2.ColCount-1;
  end
end;

procedure TZP46Dlg.SG2DblClick(Sender: TObject);
begin
  if SG2.Cells[SG2.Selection.Left,SG2.Selection.Top]=''
    then SG2.Cells[SG2.Selection.Left,SG2.Selection.Top]:='spe³nia'
  else if SG2.Cells[SG2.Selection.Left,SG2.Selection.Top]='spe³nia'
    then SG2.Cells[SG2.Selection.Left,SG2.Selection.Top]:='nie spe³nia'
  else if SG2.Cells[SG2.Selection.Left,SG2.Selection.Top]='nie spe³nia'
    then SG2.Cells[SG2.Selection.Left,SG2.Selection.Top]:=''
end;

procedure TZP46Dlg.HelpBtnClick(Sender: TObject);
begin
  Application.HelpContext(46);
end;

end.
function TZp46Dlg.GetGridHeadHeight:Integer;
const
  S1='Warunki wymagane od dostawców/wykonawców';
var
  x:Integer;
begin
  with Ry do
    begin
      x:=Ymm(3);
      x:=x+MemoOut(Rect(XLOff+Xmm(2),X,XLOff+Xmm(38),10),S1,False,TRUE);
      x:=x+Ymm(2);
      Result:=x;
    end;
end;

procedure TZp46Dlg.MakeGridHeadRect(var Places:Byte);
const
  S1='Warunki wymagane od dostawców/wykonawców';
var
  A,B,A1,A2:Integer;
  i:Byte;
  X,y,Z:Integer;
  StartPlaces:Byte;
begin
  with Ry do
    begin
      PPos:=PPos+Ymm(3);
      X:=PPos;
      Font.Size:=10;
      Line(Point(XLOff,X),Point(XROff,X));
      X:=PPos+Ymm(2);
      A:=XLOff+Xmm(40);
      y:=MemoOut(Rect(XLOff+Xmm(2),X,A-Xmm(2),10),S1,False,False);
      TextOutCenter(((XROff-A) div 2)+A,X,'Numer oferty');
      PPos:=X+y div 2;
      Line(Point(A,PPos),Point(XROff,PPos));
      Z:=X+y+Ymm(2);
      Line(Point(XLOff,Z),Point(XROff,Z));
      StartPlaces:=Places;  {Last printed kriterium (first time it should be 0)}
      Places:=0;
      while A+Ymm(WarunPrintSpace)*Places<XROff do
        Inc(Places);
      A1:=A;
      Places:=Places-1;
      for i:=StartPlaces+1 to StartPlaces+Places do
        begin
          A2:=A1+Ymm(WarunPrintSpace);
          TextOutCenter(((A2-A1) div 2)+A1,PPos+Ymm(1),IntToStr(i));
          Line(Point(A1,PPos),Point(A1,Z));
          A1:=A2;
        end;
      Places:=StartPlaces+Places;
      Line(Point(XLOff,X-Ymm(2)),Point(XLOff,Z));
      Line(Point(XROff,X-Ymm(2)),Point(XROff,Z));
      Line(Point(A,X-Ymm(2)),Point(A,Z));
      PPos:=Z;
    end;
end;

function TZp46Dlg.GetOfferHeight(Warun:Integer):Integer;
var
  x:Integer;
  s:String;
begin
  with Ry do
    begin
      s:=SG1.Cells[WCol,Warun];
      x:=MemoOut(Rect(XLOff+Xmm(2),0,XLOff+Xmm(38),10),StringAsPChar(s),False,TRUE);
      Result:=x+Ymm(4);
    end;
end;

procedure TZp46Dlg.AddOfferLine(Warun,FOffer,Offers:Integer);
var
  A,A1,A2:Integer;
  i:Byte;
  X,y,Z:Integer;
  s:String;
begin
  with Ry do
    begin
      x:=PPos;
      Font.Size:=10;
      X:=PPos+Ymm(2);
      A:=XLOff+Xmm(40);
      s:=SG1.Cells[WCol,Warun];
      y:=MemoOut(Rect(XLOff+Xmm(2),X,A-Xmm(2),10),StringAsPChar(s),False,False);
      A1:=A;
      Z:=X+Y+Ymm(2);
      for i:=FOffer+1 to Offers do
        begin
          A2:=A1+Ymm(WarunPrintSpace);
          TextOutCenter(((A2-A1) div 2)+A1,X,SG2.Cells[i,Warun]);
          Line(Point(A1,PPos),Point(A1,Z));
          A1:=A2;
        end;
      Line(Point(XLOff,Z),Point(XROff,Z));
      Line(Point(XLOff,PPos),Point(XLOff,Z));
      Line(Point(XROff,PPos),Point(XROff,Z));
      PPos:=Z;
    end;
end;

procedure TZP46Dlg.MakePrint;
var
  p : PChar;
  Rect:TRect;
  x:LongInt;
  FullPage:Boolean;
  Places:Byte;
  StartPlace:Byte;
  TP:Byte;
  Warun:Integer;
begin
    with Ry do
      begin
        Orientation:=poPortrait;
        NewJob;
        SetMinMargins(Xmm(20),Ymm(10),Xmm(20),Ymm(10));
        x:=1;
        Places:=0;
        StartPlace:=0;
        MakeHeader(Ry,Zp46Tit,'46',NumEdit.Text,'',PPos);
        MakeSecretBox;
        PrintSpace:=YBOff-Ymm(35);
        MakeFooter(Ry,PrintSpace);
        FullPage:=False;
        repeat
          Warun:=1;
          if PPos+GetGridHeadHeight>PrintSpace
            then begin
              MakeTitle(Ry,Zp46Tit,'46',PPos);
              MakeSecretBox;
              PrintSpace:=YBOff-Ymm(35);
              MakeFooter(Ry,PrintSpace);
              FullPage:=False;
            end;
          MakeGridHeadRect(Places);
          while Warun<SG2.RowCount do
            begin
              AddOfferLine(Warun,StartPlace,Places);
              if PPos+GetOfferHeight(Warun)+Ymm(10)>PrintSpace
                then begin
                  NewPage;
                  MakeTitle(Ry,Zp46Tit,'46',PPos);
                  MakeSecretBox;
                  PrintSpace:=YBOff-Ymm(25);
                  MakeFooter(Ry,PrintSpace);
                  FullPage:=False;
                  TP:=StartPlace;
                  MakeGridHeadRect(TP);
                end;
              Inc(Warun);
            end;
          StartPlace:=Places;
        until Places>=SG2.ColCount-1;
      end;
end;


