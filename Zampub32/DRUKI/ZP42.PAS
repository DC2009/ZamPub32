unit Zp42;

interface

uses WinTypes, WinProcs, Classes, Graphics, Forms, Controls, Buttons,
  StdCtrls, Tabs, ExtCtrls, Mask, SysUtils, Dialogs, Printers,
  SiwzIni,
  ZpBoxes,
  UserUnit,
  RPrev,
  Utils,
  DrMsg,
  SkOk,
  IntDate, Sk;

type
  TPRecord=^TRecord;
  TRecord=Record
    Memo1: PChar;
    Memo2: PChar;
    Memo3: PChar;
  end;

  TZp42Dlg = class(TForm)
    TabSet: TTabSet;
    NewBtn: TButton;
    DelBtn: TButton;
    Paneld: TPanel;
    Label2: TLabel;
    Label1: TLabel;
    Memo1: TMemo;
    Label8: TLabel;
    Label3: TLabel;
    Memo2: TMemo;
    Memo3: TMemo;
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
    Date1: TIntDate;
    Label29: TLabel;
    NumEdit: TEdit;
    Sk: TSmartKey;
    procedure TabSetClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure NewBtnClick(Sender: TObject);
    procedure DelBtnClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Memo1Change(Sender: TObject);
    procedure Memo2Change(Sender: TObject);
    procedure PreviewBtnClick(Sender: TObject);
    procedure Memo3Change(Sender: TObject);
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
    FileIsOpen:Boolean;
    FilePwd:String;
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
  Zp42Dlg: TZp42Dlg;

procedure DrukZp42; export;

implementation

{$R *.DFM}

procedure DrukZp42;
var
  Cur:Integer;
begin
  Cur:=Screen.Cursor;
  Screen.Cursor:=crHourGlass;
  ZP42Dlg:=TZp42Dlg.Create(Nil);
  Screen.Cursor:=Cur;
  ZP42Dlg.ShowModal;
  ZP42Dlg.Free;
end;

procedure TZp42Dlg.FormCreate(Sender: TObject);
var
  Rec:TRecord;
begin
  Application.HelpFile:=DruZpHelpFile;
  FilePwd:=LoadFilePwd(AddBackSlash(ProgramDir)+SecurityFileName);
  List:=TList.Create;
  AddPage;
end;

procedure TZp42Dlg.AddPage;
var
  Rec:TPRecord;
begin
  New(Rec);
  List.Add(Rec);
  with Rec^ do
    begin
      Memo1:=StrAlloc(1);
      StrCopy(Memo1,#0);
      Memo2:=StrAlloc(1);
      StrCopy(Memo2,#0);
      Memo3:=StrAlloc(1);
      StrCopy(Memo3,#0);
    end;
  TabSet.Tabs.Add(IntToStr(TabSet.Tabs.Count+1));
  TabSet.TabIndex:=TabSet.Tabs.Count-1;
  Memo1.Clear;
  Memo2.Clear;
  Memo3.Clear;
  Rec^.Memo1:=StrAlloc(Memo1.GetTextLen + 1);
  Memo1.GetTextBuf(Rec^.Memo1, Memo1.GetTextLen+1);
  Rec^.Memo2:=StrAlloc(Memo2.GetTextLen + 1);
  Memo2.GetTextBuf(Rec^.Memo2, Memo2.GetTextLen+1);
  Rec^.Memo3:=StrAlloc(Memo3.GetTextLen + 1);
  Memo3.GetTextBuf(Rec^.Memo3, Memo3.GetTextLen+1);
end;

procedure TZp42Dlg.NewBtnClick(Sender: TObject);
begin
  AddPage;
end;

procedure TZp42Dlg.TabSetClick(Sender: TObject);
var
  Rec:TPRecord;
begin
  if Tabset.TabIndex>-1
    then begin
      Rec:=List.Items[TabSet.TabIndex];
      Memo1.SetTextBuf(Rec^.Memo1);
      Memo2.SetTextBuf(Rec^.Memo2);
      Memo3.SetTextBuf(Rec^.Memo3);
    end;
end;

procedure TZp42Dlg.FreeRec(var Rec:TPRecord);
begin
  with Rec^ do
    begin
      StrDispose(Memo1);
      StrDispose(Memo2);
      StrDispose(Memo3);
    end;
  Dispose(Rec);
end;

procedure TZp42Dlg.DelBtnClick(Sender: TObject);
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

procedure TZp42Dlg.Memo1Change(Sender: TObject);
var
  Rec:TPRecord;
begin
  Rec:=List.Items[TabSet.TabIndex];
  Rec^.Memo1:=StrAlloc(Memo1.GetTextLen + 1);
  Memo1.GetTextBuf(Rec^.Memo1, Memo1.GetTextLen+1);
end;

procedure TZp42Dlg.Memo2Change(Sender: TObject);
var
  Rec:TPRecord;
begin
  Rec:=List.Items[TabSet.TabIndex];
  Rec^.Memo2:=StrAlloc(Memo2.GetTextLen + 1);
  Memo2.GetTextBuf(Rec^.Memo2, Memo2.GetTextLen+1);
end;

procedure TZp42Dlg.Memo3Change(Sender: TObject);
var
  Rec:TPRecord;
begin
  Rec:=List.Items[TabSet.TabIndex];
  Rec^.Memo3:=StrAlloc(Memo3.GetTextLen + 1);
  Memo3.GetTextBuf(Rec^.Memo3, Memo3.GetTextLen+1);
end;

procedure TZp42Dlg.MakeRecordHdr;
var
  Rct:TRect;
  LP:Integer; {Line position}
  X:Integer;
  A,B,C:Integer;
begin
  with Ry do
    begin
      Rct.Left:=XLOff;
      Rct.Right:=XROff;
      Rct.Top:=PPos+Ymm(3);
      Font.Size:=10;
      LP:=Rct.Top+Ymm(2);
      A:=Rct.Left+Xmm(8);
      B:=A+TextWidth(Label1.Caption)+Xmm(20);
      C:=((Rct.Right-B) div 2)+B;
      Line(Point(Rct.Left,Rct.Top),Point(Rct.Right,Rct.Top));
      TextOutCenter(((A-Rct.Left) div 2)+Rct.Left,LP,'l.p.');
      TextOutCenter(((B-A)div 2)+A,LP,Label1.Caption);
      TextOutCenter(((C-B)div 2)+B,LP,Label2.Caption);
      TextOutCenter(((XROff-C)div 2)+C,LP,Label3.Caption);
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

procedure TZp42Dlg.AddBox(ARec:Integer);
var
  A,B,C:Integer;
  Rct:TRect;
  LP:Integer; {Line position}
  p0,p1,p2,p3:PChar;
  Rec:TPRecord;
  s:String;
  H0,H1,H2,H3:Integer;
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
          A:=Rct.Left+Xmm(8);
          B:=A+TextWidth(Label1.Caption)+Xmm(20);
          C:=((Rct.Right-B) div 2)+B;
        end;
      Rec:=List.Items[ARec];
      p1:=Rec^.Memo1;
      p2:=Rec^.Memo2;
      p3:=Rec^.Memo3;
      s:=IntToStr(ARec+1);
      p0:=StringAsPChar(s);
      while (p0<>nil) or (p1<>nil) or (p2<>nil) or (p3<>nil) do
        begin
          if p0<>Nil
            then H0:=PCharOut(Rect(Rct.Left+Xmm(2),LP,A-Xmm(2),PrintSpace-LP),p0, False, False, TRUE,p0)
            else H0:=0;
          if p1<>Nil
            then H1:=PCharOut(Rect(A+Xmm(2),LP,B-Xmm(2),PrintSpace-LP),p1, False, False, TRUE,p1)
            else H1:=0;
          if p2<>Nil
            then H2:=PCharOut(Rect(B+Xmm(2),LP,C-Xmm(2),PrintSpace-LP),p2, False, False, TRUE,p2)
            else H2:=0;
          if p3<>Nil
            then H3:=PCharOut(Rect(C+Xmm(2),LP,Rct.Right-Xmm(2),PrintSpace-LP),p3, False, False, TRUE,p3)
            else H3:=0;
          if H0>H1 then H1:=H0;
          if H2>H1 then H1:=H2;
          if H3>H1 then H1:=H3; {H1=max(Hx)}
          Rct.Bottom:=H1+LP+Ymm(1);
          DoRect;
          if LP+H1>PrintSpace
            then begin
              MakeNewPage(Ry,Label8.Caption+Date1.Text,'42',NumEdit.Text,PPos,PrintSpace);
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

procedure TZp42Dlg.MakePrint;
var
  x:LongInt;
begin
    with Ry do
      begin
        Orientation:=poLandscape;
        NewJob;
        SetMinMargins(Xmm(10),Ymm(15),Xmm(20),Ymm(10));
        PrintSpace:=YBOff-Ymm(PageBottomSpace);
        MakeHeader(Ry,Label8.Caption+Date1.Text,'42',NumEdit.Text,'',PPos);
        MakeFooter(Ry,PrintSpace);
        MakeRecordHdr;
        for x:=0 to Tabset.Tabs.Count-1 do
          AddBox(x);
      end;
end;

procedure TZp42Dlg.PreviewBtnClick(Sender: TObject);
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

procedure TZp42Dlg.SaveFile;
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
      SaveString(Zp42FileHdr,FHandle);
      SaveString(FilePwd,FHandle);
      MakeCodeKey(FilePwd);
      SaveEdit(NumEdit,FHandle);
      SaveInteger(List.Count,FHandle);
      SaveDateTime(Date1.EditDate,FHandle);
      M:=TMemo.Create(Self);
      M.Name:='M';
      M.Parent:=Self;
      x:=0;
      while x<List.Count do
        begin
          Rec:=List.Items[x];
          M.SetTextBuf(Rec^.Memo1);
          SaveMemo(M,FHandle);
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

procedure TZp42Dlg.LoadFile;
var
  s:String;
  i:Integer;
  Rec:TPRecord;
  x,Tot:Integer;
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
        if s=Zp42FileHdr
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
                LoadDateTime(DT,FHandle);
                Date1.EditDate:=DT;
                x:=0;
                while x<Tot do
                  begin
                    AddPage;
                    LoadMemo(Memo1,FHandle);
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

procedure TZp42Dlg.OpenBtnClick(Sender: TObject);
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

procedure TZp42Dlg.SaveBtnClick(Sender: TObject);
begin
  if SaveDialog.Execute
    then begin
      FileName:=SaveDialog.FileName;
      SaveFile;
    end;
end;

procedure TZp42Dlg.FormDestroy(Sender: TObject);
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

procedure TZp42Dlg.OKBtnClick(Sender: TObject);
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

procedure TZp42Dlg.HelpBtnClick(Sender: TObject);
begin
  Application.HelpContext(42);
end;

end.
