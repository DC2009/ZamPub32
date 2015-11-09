unit Zp12;

interface

uses WinTypes, WinProcs, Classes, Graphics, Forms, Controls, Buttons,
  StdCtrls, Mask, ExtCtrls, SysUtils, Messages, Dialogs,
  RPrev, Grids, Printers, Esgrid,
  SkOk,
  UserUnit, Sk;

type
  TZP12Dlg = class(TForm)
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
    SiwzBtn: TBitBtn;
    OpenDialog: TOpenDialog;
    SaveDialog: TSaveDialog;
    Label29: TLabel;
    NumEdit: TEdit;
    SG: TEnhStringGrid;
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
    procedure SiwzBtnClick(Sender: TObject);
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
    function EmptyGrid:Boolean;
    function GetKritRectHeight(Ix:LongInt; Ry:TRyPrinter):Integer;
    procedure AddKritRect(Ix:LongInt; Ry:TRyPrinter; var PPos:Integer);
    procedure ClearSG;
    procedure LoadFile;
    procedure MakeKritHeadRect(Ry:TRyPrinter; var PPos:Integer);
    procedure MakePrint;
    procedure SaveFile;
    procedure SetGridRowNumbers;
  public
    { Public declarations }
  end;

var
  ZP12Dlg: TZP12Dlg;

procedure DrukZp12; export;

implementation

{$R *.DFM}

uses
  SiwzIni,
  PrtRecIo,
  ZpBoxes,
  Utils,
  DrMsg;

const
  DCol=1;
  WCol=2;

procedure DrukZp12;
var
  Cur:Integer;
begin
  Cur:=Screen.Cursor;
  Screen.Cursor:=crHourGlass;
  ZP12Dlg:=TZp12Dlg.Create(Nil);
  Screen.Cursor:=Cur;
  ZP12Dlg.ShowModal;
  ZP12Dlg.Free;
end;


procedure TZP12Dlg.ClearSG;
var
  i,j:LongInt;
begin
  for i:=0 to SG.ColCount-1 do
    for j:=1 to SG.RowCount-1 do
      SG.Cells[i,j]:='';
end;

procedure TZP12Dlg.SetGridRowNumbers;
var
  i:Integer;
begin
  for i:=1 to SG.RowCount-1 do
    SG.Cells[0,i]:=' '+IntToStr(i);
end;

procedure TZP12Dlg.FormCreate(Sender: TObject);
begin
  Application.HelpFile:=DruZpHelpFile;
  FilePwd:=LoadFilePwd(AddBackSlash(ProgramDir)+SecurityFileName);
  SG.Cells[0,0]:='l.p.';
  SG.Cells[DCol,0]:='Opis kryteriów oceny';
  SG.Cells[WCol,0]:='Znaczenie';
  SetGridRowNumbers;
end;

procedure TZP12Dlg.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key=#13
    then begin
      Key:=#0;
      Perform(wm_NextDlgCtl,0,0);
    end;
end;

procedure TZP12Dlg.SGKeyPress(Sender: TObject; var Key: Char);
var
  Rct:TGridRect;
begin
  if SG.Selection.Left=0
    then Key:=#0
  else if SG.Selection.Left=WCol
    then begin
      if (not (Key in ['0'..'9',#8]))
        then Key:=#0
      else if (Length(SG.Cells[SG.Selection.Left,SG.Selection.Top])>3) and
              (Key<>#8)
        then Key:=#0
      else if (SG.Cells[SG.Selection.Left,SG.Selection.Top]<>'') and
              (Key<>#8) and
              (StrToInt(SG.Cells[SG.Selection.Left,SG.Selection.Top]+Key)>100)
          then begin
            MessageDlg('Wartoœæ powyzej 100',mtError,[mbok],0);
            Key:=#0;
          end
      else if SG.Cells[SG.Selection.Left,SG.Selection.Top]=''
          then SG.Cells[SG.Selection.Left,SG.Selection.Top]:='0';
    end;
end;

procedure TZP12Dlg.MakeKritHeadRect(Ry:TRyPrinter; var PPos:Integer);
var
  Rect:TRect;
  Pt1,Pt2:TPoint;
  p:Byte;
  s:String;
begin
  with Ry do
    begin
      Rect.Left:=XLOff;
      Rect.Top:=PPos+Xmm(4);
      Rect.Right:=XROff+1;
      Rect.Bottom:=Rect.Top+Ymm(11);
      Rectangle(Rect);
      Rect.Right:=XROff;
      Font.Size:=10;
      TextOut(Rect.Left+Xmm(3),Rect.Top+Xmm(2),'l.p.');
      TextOut(Rect.Left+Xmm(59),Rect.Top+Xmm(2),'Opis kryteriów oceny');
      TextOut(Rect.Right-Xmm(20),Rect.Top+Xmm(2),'Znaczenie');
      Pt1.X:=Rect.Left+Xmm(10);
      Pt1.Y:=Rect.Top;
      Pt2.X:=Rect.Left+Xmm(10);
      Pt2.Y:=Rect.Bottom;
      Line(Pt1,Pt2);
      Pt1.X:=Rect.Right-Xmm(27);
      Pt1.Y:=Rect.Top;
      Pt2.X:=Rect.Right-Xmm(27);
      Pt2.Y:=Rect.Bottom;
      Line(Pt1,Pt2);
      PPos:=Rect.Bottom;
    end;
end;

procedure TZP12Dlg.AddKritRect(Ix:LongInt; Ry:TRyPrinter; var PPos:Integer);
var
  Rect:TRect;
  Pt1,Pt2:TPoint;
  p:Byte;
  s:String;
  x:Integer;
begin
  with Ry do
    begin
      PPos:=PPos-2;
      Rect.Left:=XLOff+Xmm(12);
      Rect.Top:=PPos+Ymm(4);
      Rect.Right:=XROff-Xmm(29);
      Rect.Bottom:=Rect.Top+Ymm(12);
      s:=SG.Cells[DCol,Ix];
      Font.Size:=10;
      TextOut(XLoff+Xmm(3)+5,PPos+Ymm(4),IntToStr(Ix));
      x:=MemoOut(Rect,StringAsPChar(s),FALSE,FALSE);
      s:=SG.Cells[WCol,Ix];
      if s<>''
        then s:=s+' %'
        else s:='     %';
      TextOut(XROff-Xmm(17),PPos+Ymm(4),s);
      with Rect do
        begin
          Left:=XLOff;
          Top:=PPos;
          Right:=XROff;
          Bottom:=Top+Ymm(8)+x;
    {      Rectangle(Rect);}
          Line(Point(Left,Top),Point(Left,Bottom));
          Line(Point(Left,Bottom),Point(Right,Bottom));
          Line(Point(Right,Top),Point(Right,Bottom));
          Pt1.X:=Left+Xmm(10);
          Pt1.Y:=Top;
          Pt2.X:=Left+Xmm(10);
          Pt2.Y:=Bottom;
          Line(Pt1,Pt2);
          Pt1.X:=Right-Xmm(27);
          Pt1.Y:=Top;
          Pt2.X:=Right-Xmm(27);
          Pt2.Y:=Bottom;
          Line(Pt1,Pt2);
          PPos:=Bottom;
        end;
    end;
end;

function TZP12Dlg.GetKritRectHeight(Ix:LongInt; Ry:TRyPrinter):Integer;
var
  s:String;
  x:Integer;
begin
  with Ry do
    begin
      s:=SG.Cells[DCol,Ix];
      Font.Size:=10;
      x:=MemoOut(Rect(XLOff+Xmm(12),0,XROff-Xmm(29),100),StringAsPChar(s),FALSE,TRUE);
      Result:=x+Ymm(8);
    end;
end;

function TZp12Dlg.EmptyGrid:Boolean;
var
  Found:Boolean;
  i:Integer;
begin
  for i:=1 to SG.RowCount do
    begin
      Found:=SG.Cells[DCol,i]<>'';
      if Found
        then Break;
    end;
  Result:= not Found;
end;

procedure TZp12Dlg.MakePrint;
var
  p : PChar;
  PPos:Integer;
  Rect:TRect;
  x:LongInt;
  FullPage:Boolean;
begin
    with Ry do
      begin
        Orientation:=poPortrait;
        NewJob;
        Font.Color:=clBlack;
        SetMinMargins(Xmm(20),Ymm(10),Xmm(20),Ymm(10));
        x:=1;
        repeat
          MakeHeader(Ry,Zp12Tit,'12',NumEdit.Text,'',PPos);
          MakeKritHeadRect(Ry,PPos);
          PrintSpace:=YBOff-Ymm(35);
          MakeFooter(Ry,PrintSpace);
          FullPage:=False;
          if EmptyGrid
            then begin
              while not FullPage do
                begin
                  FullPage:=(PPos+GetKritRectHeight(x,Ry))>PrintSpace;
                  if not FullPage
                    then begin
                      AddKritRect(x,Ry,PPos);
                      Inc(x);
                    end;
                end;
              x:=SG.RowCount+1;
            end
            else begin
              while (x<SG.RowCount) and not FullPage do
                begin
                  FullPage:=(PPos+GetKritRectHeight(x,Ry))>PrintSpace;
                  if not FullPage
                    then begin
                      if (SG.Cells[DCol,x]<>'')
                        then AddKritRect(x,Ry,PPos);
                      Inc(x);
                    end;
                end;
              if FullPage
                then NewPage;
            end;
        until x>=SG.RowCount;
      end;
end;

procedure TZp12Dlg.PreviewBtnClick(Sender: TObject);
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

procedure TZp12Dlg.SaveFile;
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
      SaveString(Zp12FileHdr,FHandle);
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

procedure TZp12Dlg.LoadFile;
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
        if s=Zp12FileHdr
          then begin
            LoadString(s,FHandle);
            if (s=FilePwd)
              then begin
                MakeCodeKey(FilePwd);
                ClearSG;
                LoadEdit(NumEdit,FHandle);
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

procedure TZp12Dlg.OpenBtnClick(Sender: TObject);
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

procedure TZp12Dlg.SaveBtnClick(Sender: TObject);
begin
  if SaveDialog.Execute
    then begin
      FileName:=SaveDialog.FileName;
      SaveFile;
    end;
end;

procedure TZp12Dlg.FormDestroy(Sender: TObject);
begin
  if FileIsOpen
    then begin
      CloseFile(FHandle);
      FileIsOpen:=FALSE;
    end;
end;

procedure TZP12Dlg.OKBtnClick(Sender: TObject);
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

procedure TZp12Dlg.SiwzBtnClick(Sender: TObject);
var
  i:LongInt;
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
        ClearSG;
        if SG.RowCount<PrtRec.SG.RowCount
          then SG.RowCount:=PrtRec.SG.RowCount;
        for i:=1 to PrtRec.SG.RowCount-1 do
          begin
            SG.Cells[0,i]:=IntToStr(i);
            SG.Cells[1,i]:=PrtRec.SG.Cells[1,i];
            SG.Cells[2,i]:=PrtRec.SG.Cells[3,i];
          end;
        FreePrtRec;
      end;
    OpenDialog.DefaultExt:='012';
    OpenDialog.Filter:='Druki ZP12|*.012';
{$ENDIF}
end;

procedure TZP12Dlg.HelpBtnClick(Sender: TObject);
begin
  Application.HelpContext(12);
end;

procedure TZP12Dlg.AddBtnClick(Sender: TObject);
begin
  SG.InsertRow(SG.RowCount);
  SetGridRowNumbers;
end;

procedure TZP12Dlg.InsertBtnClick(Sender: TObject);
begin
  SG.InsertRow(SG.Row);
  SetGridRowNumbers;
end;

procedure TZP12Dlg.DelBtnClick(Sender: TObject);
begin
  SG.DeleteRow(SG.Row);
  SetGridRowNumbers;
end;

end.
