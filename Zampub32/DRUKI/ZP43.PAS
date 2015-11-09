unit Zp43;

interface

uses WinTypes, WinProcs, Classes, Graphics, Forms, Controls, Buttons,
  StdCtrls, Tabs, ExtCtrls, Mask, SysUtils, Dialogs, Printers,
  SiwzIni,
  ZpBoxes,
  UserUnit,
  RPrev,
  SkOk,
  Utils,
  DrMsg, Sk;

const
  Col1L1='Numer';
  Col1L2='oferty';
  Col4L1='Podpis przewodnicz¹cego';
  Col4L2='komisji przetargowej';

type
  TPRecord=^TRecord;
  TRecord=Record
    Edit1: String[10];
    Memo2: PChar;
    Memo3: PChar;
  end;

  TZp43Dlg = class(TForm)
    TabSet: TTabSet;
    NewBtn: TButton;
    DelBtn: TButton;
    Paneld: TPanel;
    Label2: TLabel;
    Label1: TLabel;
    Label3: TLabel;
    Memo2: TMemo;
    Memo3: TMemo;
    Edit1: TEdit;
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
    Label29: TLabel;
    NumEdit: TEdit;
    Sk: TSmartKey;
    procedure TabSetClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure NewBtnClick(Sender: TObject);
    procedure DelBtnClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Memo2Change(Sender: TObject);
    procedure PreviewBtnClick(Sender: TObject);
    procedure Memo3Change(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure OpenBtnClick(Sender: TObject);
    procedure SaveBtnClick(Sender: TObject);
    procedure OKBtnClick(Sender: TObject);
    procedure HelpBtnClick(Sender: TObject);
  private
    { Private declarations }
    List:TList;
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
    procedure FreeRec(var Rec:TPRecord);
    procedure AddPage;
    procedure MakeRecordHdr;
  public
    { Public declarations }
  end;

var
  Zp43Dlg: TZp43Dlg;

procedure DrukZp43; export;

implementation

{$R *.DFM}

procedure DrukZp43;
var
  Cur:Integer;
begin
  Cur:=Screen.Cursor;
  Screen.Cursor:=crHourGlass;
  ZP43Dlg:=TZp43Dlg.Create(Nil);
  Screen.Cursor:=Cur;
  ZP43Dlg.ShowModal;
  ZP43Dlg.Free;
end;

procedure TZp43Dlg.FormCreate(Sender: TObject);
var
  Rec:TRecord;
begin
  Application.HelpFile:=DruZpHelpFile;
  FilePwd:=LoadFilePwd(AddBackSlash(ProgramDir)+SecurityFileName);
  List:=TList.Create;
  AddPage;
end;

procedure TZp43Dlg.AddPage;
var
  Rec:TPRecord;
begin
  TabSet.Tabs.Add(IntToStr(TabSet.Tabs.Count+1));
  New(Rec);
  List.Add(Rec);
  with Rec^ do
    begin
      Edit1:='';
      Memo2:=StrAlloc(1);
      StrCopy(Memo2,#0);
      Memo3:=StrAlloc(1);
      StrCopy(Memo3,#0);
    end;
  TabSet.TabIndex:=TabSet.Tabs.Count-1;
  Edit1.Clear;
  Memo2.Clear;
  Memo3.Clear;
end;

procedure TZp43Dlg.NewBtnClick(Sender: TObject);
begin
  AddPage;
end;

procedure TZp43Dlg.TabSetClick(Sender: TObject);
var
  Rec:TPRecord;
begin
  if Tabset.TabIndex>-1
    then begin
      Rec:=List.Items[TabSet.TabIndex];
      Edit1.Text:=Rec^.Edit1;
      Memo2.SetTextBuf(Rec^.Memo2);
      Memo3.SetTextBuf(Rec^.Memo3);
    end;
end;

procedure TZp43Dlg.FreeRec(var Rec:TPRecord);
begin
  with Rec^ do
    begin
      StrDispose(Memo2);
      StrDispose(Memo3);
    end;
  Dispose(Rec);
end;

procedure TZp43Dlg.DelBtnClick(Sender: TObject);
var
  Rec:TPRecord;
  i:LongInt;
begin
  if MessageDlg(cmDeleteConfirm,mtConfirmation,[mbYes,mbNo],0)=mrYes
    then begin
      Rec:=List.Items[TabSet.TabIndex];
      List.Delete(TabSet.TabIndex);
      List.Pack;
      FreeRec(Rec);
      Tabset.Tabs.Delete(Tabset.TabIndex);
      if Tabset.Tabs.Count>0
        then for i:=0 to Tabset.Tabs.Count-1 do
          Tabset.Tabs[i]:=IntToStr(i+1);
      if Tabset.Tabs.Count=0
        then AddPage
    end;
end;

procedure TZp43Dlg.Edit1Change(Sender: TObject);
var
  Rec:TPRecord;
begin
  Rec:=List.Items[TabSet.TabIndex];
  Rec^.Edit1:=Edit1.Text;
end;

procedure TZp43Dlg.Memo2Change(Sender: TObject);
var
  Rec:TPRecord;
begin
  Rec:=List.Items[TabSet.TabIndex];
  Rec^.Memo2:=StrAlloc(Memo2.GetTextLen + 1);
  Memo2.GetTextBuf(Rec^.Memo2, Memo2.GetTextLen+1);
end;

procedure TZp43Dlg.Memo3Change(Sender: TObject);
var
  Rec:TPRecord;
begin
  Rec:=List.Items[TabSet.TabIndex];
  Rec^.Memo3:=StrAlloc(Memo3.GetTextLen + 1);
  Memo3.GetTextBuf(Rec^.Memo3, Memo3.GetTextLen+1);
end;

procedure TZp43Dlg.MakeRecordHdr;
var
  Rct:TRect;
  LP:Integer; {Line position}
  X:Integer;
  A,B,C:Integer;
  s:String;
begin
  with Ry do
    begin
      Rct.Left:=XLOff;
      Rct.Right:=XROff;
      Rct.Top:=PPos+Ymm(3);
      Font.Size:=10;
      LP:=Rct.Top+Ymm(2);
      A:=Rct.Left+Xmm(20);
      s:=Col4L1;
      C:=Rct.Right-TextWidth(s)-Xmm(5);
      B:=((C-A) div 2)+A;
      Line(Point(Rct.Left,Rct.Top),Point(Rct.Right,Rct.Top));
      s:=Col1L1;
      TextOutCenter(((A-Rct.Left) div 2)+Rct.Left,LP,s);
      TextOutCenter(((B-A)div 2)+A,LP,Label2.Caption);
      TextOutCenter(((C-B)div 2)+B,LP,Label3.Caption);
      s:=Col4L1;
      TextOutCenter(((XROff-C)div 2)+C,LP,s);
      LP:=LP+TextHeight+Ymm(1);
      s:=Col1L2;
      TextOutCenter(((A-Rct.Left) div 2)+Rct.Left,LP,s);
      s:=Col4L2;
      TextOutCenter(((XROff-C)div 2)+C,LP,s);
      LP:=LP+TextHeight+Ymm(1);
      Rct.Bottom:=LP;
      Line(Point(Rct.Left,Rct.Top),Point(Rct.Left,Rct.Bottom));
      Line(Point(A,Rct.Top),Point(A,Rct.Bottom));
      Line(Point(B,Rct.Top),Point(B,Rct.Bottom));
      Line(Point(C,Rct.Top),Point(C,Rct.Bottom));
      Line(Point(Rct.Right,Rct.Top),Point(Rct.Right,Rct.Bottom));
      Line(Point(Rct.Left,Rct.Bottom),Point(Rct.Right,Rct.Bottom));
      PPos:=Rct.Bottom;
    end;
end;
(*
function TZp43Dlg.GetRecordHeight(i:LongInt):Integer;
var
  p:PChar;
  Rct:TRect;
  LP,L1,L2:Integer; {Line position}
  X,Y:Integer;
  A,B,C:Integer;
  Rec:TPRecord;
  s:String;
begin
  with Ry do
    begin
      Rct.Left:=XLOff;
      Rct.Right:=XROff;
      Font.Size:=10;
      A:=Rct.Left+Xmm(20);
      s:=Col4L1;
      C:=Rct.Right-TextWidth(s)-Xmm(5);
      B:=((C-A) div 2)+A;
      LP:=Ymm(1);
      L1:=LP;
      L2:=LP;
      Rec:=List.Items[i];
      LP:=LP+Ymm(15);
      Y:=MemoOut(Rect(A+Xmm(2),L1,B-Xmm(2),10), Rec^.Memo2, False, TRUE);
      L1:=L1+Y+Ymm(1);
      Y:=MemoOut(Rect(B+Xmm(2),L2,C-Xmm(2),10), Rec^.Memo3, False, TRUE);
      L2:=L2+Y+Ymm(1);
      if L2>L1
        then L1:=L2;
      if L1>LP
        then LP:=L1;
      Result:=LP;
    end;
end;

procedure TZp43Dlg.MakeRecordBox(i:LongInt);
var
  p:PChar;
  Rct:TRect;
  LP,L1,L2:Integer; {Line position}
  X,Y:Integer;
  A,B,C:Integer;
  Rec:TPRecord;
  s:String;
begin
  with Ry do
    begin
      Rct.Left:=XLOff;
      Rct.Right:=XROff;
      Rct.Top:=PPos;
      LP:=PPos;
      Font.Size:=10;
      A:=Rct.Left+Xmm(20);
      s:=Col4L1;
      C:=Rct.Right-TextWidth(s)-Xmm(5);
      B:=((C-A) div 2)+A;
      Line(Point(Rct.Left,LP),Point(Rct.Right,LP));
      LP:=LP+Ymm(1);
      L1:=LP;
      L2:=LP;
      Rec:=List.Items[i];
      TextOutCenter(((A-Rct.Left) div 2)+Rct.Left,LP,Rec^.Edit1);
      LP:=LP+Ymm(15);
      Y:=MemoOut(Rect(A+Xmm(2),L1,B-Xmm(2),10), Rec^.Memo2, False, False);
      L1:=L1+Y+Ymm(1);
      Y:=MemoOut(Rect(B+Xmm(2),L2,C-Xmm(2),10), Rec^.Memo3, False, False);
      L2:=L2+Y+Ymm(1);
      if L2>L1
        then L1:=L2;
      if L1>LP
        then LP:=L1;
      Rct.Bottom:=LP;
      Line(Point(Rct.Left,Rct.Top),Point(Rct.Left,Rct.Bottom));
      Line(Point(A,Rct.Top),Point(A,Rct.Bottom));
      Line(Point(B,Rct.Top),Point(B,Rct.Bottom));
      Line(Point(C,Rct.Top),Point(C,Rct.Bottom));
      Line(Point(Rct.Right,Rct.Top),Point(Rct.Right,Rct.Bottom));
      Line(Point(Rct.Left,Rct.Bottom),Point(Rct.Right,Rct.Bottom));
      PPos:=Rct.Bottom;
    end;
end;
*)
procedure TZp43Dlg.AddBox(ARec:Integer);
var
  A,B,C:Integer;
  Rct:TRect;
  LP:Integer; {Line position}
  p1,p2,p3:PChar;
  Rec:TPRecord;
  s:String;
  H1,H2,H3:Integer;
  procedure DoRect;
  begin
    with Ry do
      begin
        Line(Point(Rct.Left,Rct.Top),Point(Rct.Left,Rct.Bottom));
        Line(Point(A,Rct.Top),Point(A,Rct.Bottom));
        Line(Point(B,Rct.Top),Point(B,Rct.Bottom));
        Line(Point(C,Rct.Top),Point(C,Rct.Bottom));
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
          LP:=Top+Ymm(2);
          A:=Rct.Left+Xmm(20);
          s:=Col4L1;
          C:=Rct.Right-TextWidth(s)-Xmm(5);
          B:=((C-A) div 2)+A;
        end;
      Rec:=List.Items[ARec];
      s:=Rec^.Edit1;
      p1:=StringAsPChar(s);
      p2:=Rec^.Memo2;
      p3:=Rec^.Memo3;
      while (p1<>nil) or (p2<>nil) or (p3<>nil) do
        begin
          if p1<>Nil
            then H1:=PCharOut(Rect(Rct.Left+Xmm(2),LP,A-Xmm(2),PrintSpace-LP),p1, False, False, TRUE,p1)
            else H1:=0;
          if p2<>Nil
            then H2:=PCharOut(Rect(A+Xmm(2),LP,B-Xmm(2),PrintSpace-LP),p2, False, False, TRUE,p2)
            else H2:=0;
          if p3<>Nil
            then H3:=PCharOut(Rect(B+Xmm(2),LP,C-Xmm(2),PrintSpace-LP),p3, False, False, TRUE,p3)
            else H3:=0;
          if H2>H1 then H1:=H2;
          if H3>H1 then H1:=H3; {H1=max(Hx)}
          Rct.Bottom:=H1+LP+Ymm(1);
          DoRect;
          if LP+H1>PrintSpace
            then begin
              MakeNewPage(Ry,Zp43Tit,'43',NumEdit.Text,PPos,PrintSpace);
              MakeFooter(Ry,PrintSpace);
              MakeRecordHdr;
              Rct.Top:=PPos;
              LP:=Rct.Top{+Ymm(2)};
            end
            else LP:=LP+H1;
        end;
      PPos:=LP;
    end;
end;

procedure TZp43Dlg.MakePrint;
var
  x:LongInt;
begin
    with Ry do
      begin
        Orientation:=poLandscape;
        NewJob;
        SetMinMargins(Xmm(10),Ymm(15),Xmm(20),Ymm(10));
        PrintSpace:=YBOff-Ymm(PageBottomSpace);
        MakeHeader(Ry,Zp43Tit,'43',NumEdit.Text,'',PPos);
        MakeFooter(Ry,PrintSpace);
        MakeRecordHdr;
        for x:=0 to Tabset.Tabs.Count-1 do
          AddBox(x);
      end;
end;

procedure TZp43Dlg.PreviewBtnClick(Sender: TObject);
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

procedure TZp43Dlg.SaveFile;
var
  s:String;
  FO:Boolean;
  Rec:TPRecord;
  x:Integer;
  M:TMemo;
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
      SaveString(Zp43FileHdr,FHandle);
      SaveString(FilePwd,FHandle);
      MakeCodeKey(FilePwd);
      SaveEdit(NumEdit,FHandle);
      SaveInteger(List.Count,FHandle);
      M:=TMemo.Create(Self);
      M.Name:='M';
      M.Parent:=Self;
      x:=0;
      while x<List.Count do
        begin
          Rec:=List.Items[x];
          SaveString(Rec^.Edit1,FHandle);
          M.SetTextBuf(Rec^.Memo2);
          SaveMemo(M,FHandle);
          M.SetTextBuf(Rec^.Memo3);
          SaveMemo(M,FHandle);
          Inc(x);
        end;
      M.Free;
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

procedure TZp43Dlg.LoadFile;
var
  s:String;
  i:Integer;
  Rec:TPRecord;
  x,Tot:Integer;
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
        if s=Zp43FileHdr
          then begin
            LoadString(s,FHandle);
            if (s=FilePwd)
              then begin
                MakeCodeKey(FilePwd);
                while List.Count>0 do
                  begin
                    Rec:=List.Items[0];
                    List.Delete(0);
                    List.Pack;
                    Tabset.Tabs.Delete(0);
                    FreeRec(Rec);
                  end;
                LoadEdit(NumEdit,FHandle);
                LoadInteger(Tot,FHandle);
                x:=0;
                while x<Tot do
                  begin
                    AddPage;
                    LoadEdit(Edit1,FHandle);
                    LoadMemo(Memo2,FHandle);
                    LoadMemo(Memo3,FHandle);
                    Inc(x);
                  end;
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

procedure TZp43Dlg.OpenBtnClick(Sender: TObject);
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

procedure TZp43Dlg.SaveBtnClick(Sender: TObject);
begin
  if SaveDialog.Execute
    then begin
      FileName:=SaveDialog.FileName;
      SaveFile;
    end;
end;

procedure TZp43Dlg.FormDestroy(Sender: TObject);
var
  Rec:TPRecord;
  i:LongInt;
begin
  if FileIsOpen
    then begin
      CloseFile(FHandle);
      FileIsOpen:=FALSE;
    end;
  for i:=0 to List.Count-1 do
    begin
      Rec:=List.Items[i];
      FreeRec(Rec);
    end;
  List.Free;
end;

procedure TZp43Dlg.OKBtnClick(Sender: TObject);
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

procedure TZp43Dlg.HelpBtnClick(Sender: TObject);
begin
  Application.HelpContext(43);
end;

end.
