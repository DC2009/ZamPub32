unit Zp41;

interface

uses WinTypes, WinProcs, Classes, Graphics, Forms, Controls, Buttons,
  StdCtrls, Tabs, ExtCtrls, Mask, SysUtils, Dialogs, Printers, Rprev,
  SiwzIni,
  ZpBoxes,
  UserUnit,
  SkOk,
  Utils,
  DrMsg, IntDate, Sk;

type
  TPRecord=^TRecord;
  TRecord=Record
    Memo1: PChar;
    Edit1: String;
    MaskEdit1: String[10];
    Edit2: String;
    Edit3: String;
    Edit4: String;
    DateEdit2: TDateTime;
    Edit5: String;
    Memo2: PChar;
  end;

  TZp41Dlg = class(TForm)
    TabSet: TTabSet;
    NewBtn: TButton;
    DelBtn: TButton;
    Paneld: TPanel;
    Label7: TLabel;
    Label1: TLabel;
    Memo1: TMemo;
    GB1: TGroupBox;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    MaskEdit1: TMaskEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    Label8: TLabel;
    Label9: TLabel;
    Edit5: TEdit;
    Label10: TLabel;
    Memo2: TMemo;
    OpenDialog: TOpenDialog;
    SaveDialog: TSaveDialog;
    Panel2: TPanel;
    OKBtn: TBitBtn;
    CancelBtn: TBitBtn;
    PrintBtn: TBitBtn;
    PreviewBtn: TBitBtn;
    OpenBtn: TBitBtn;
    SaveBtn: TBitBtn;
    HelpBtn: TBitBtn;
    Edit1: TEdit;
    Date1: TIntDate;
    Label29: TLabel;
    NumEdit: TEdit;
    Date2: TIntDate;
    Sk: TSmartKey;
    procedure TabSetClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure NewBtnClick(Sender: TObject);
    procedure DelBtnClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure Memo1Change(Sender: TObject);
    procedure Memo2Change(Sender: TObject);
    procedure MaskEdit1Change(Sender: TObject);
    procedure Edit2Change(Sender: TObject);
    procedure Edit3Change(Sender: TObject);
    procedure Edit4Change(Sender: TObject);
    procedure Edit5Change(Sender: TObject);
    procedure Date2Change(Sender: TObject);
    procedure PreviewBtnClick(Sender: TObject);
    procedure OpenBtnClick(Sender: TObject);
    procedure SaveBtnClick(Sender: TObject);
    procedure OKBtnClick(Sender: TObject);
    procedure HelpBtnClick(Sender: TObject);
    procedure CancelBtnClick(Sender: TObject);
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
    procedure AddPage;
    procedure FreeRec(var Rec:TPRecord);
    procedure LoadFile;
    procedure MakePrint;
    procedure MakeRecordHdr;
    procedure SaveFile;
  public
    { Public declarations }
  end;

var
  Zp41Dlg: TZp41Dlg;

procedure DrukZp41; export;

implementation

{$R *.DFM}

procedure DrukZp41;
var
  Cur:Integer;
begin
  Cur:=Screen.Cursor;
  Screen.Cursor:=crHourGlass;
  ZP41Dlg:=TZp41Dlg.Create(Nil);
  Screen.Cursor:=Cur;
  ZP41Dlg.ShowModal;
  ZP41Dlg.Free;
end;

procedure TZp41Dlg.FormCreate(Sender: TObject);
var
  Rec:TRecord;
begin
  Application.HelpFile:=DruZpHelpFile;
  FilePwd:=LoadFilePwd(AddBackSlash(ProgramDir)+SecurityFileName);
  List:=TList.Create;
  AddPage;
end;

procedure TZp41Dlg.AddPage;
var
  Rec:TPRecord;
begin
  New(Rec);
  List.Add(Rec);
  with Rec^ do
    begin
      Memo1:=StrAlloc(1);
      StrCopy(Memo1,#0);
      Edit1:='';
      MaskEdit1:='';
      Edit2:='';
      Edit3:='';
      Edit4:='';
      DateEdit2:=Now;
      Edit5:='';
      Memo2:=StrAlloc(1);
      StrCopy(Memo2,#0);
    end;
  TabSet.Tabs.Add(IntToStr(TabSet.Tabs.Count+1));
  TabSet.TabIndex:=TabSet.Tabs.Count-1;
  Memo1.Clear;
  Edit1.Clear;
  MaskEdit1.Clear;
  Edit2.Clear;
  Edit3.Clear;
  Edit4.Clear;
  Edit5.Clear;
  Memo2.Clear;
  Rec^.Memo1:=StrAlloc(Memo1.GetTextLen + 1);
  Memo1.GetTextBuf(Rec^.Memo1, Memo1.GetTextLen+1);
  Rec^.Memo2:=StrAlloc(Memo2.GetTextLen + 1);
  Memo2.GetTextBuf(Rec^.Memo2, Memo2.GetTextLen+1);
end;

procedure TZp41Dlg.NewBtnClick(Sender: TObject);
begin
  AddPage;
end;

procedure TZp41Dlg.TabSetClick(Sender: TObject);
var
  Rec:TPRecord;
begin
  if Tabset.TabIndex>-1
    then begin
      Rec:=List.Items[TabSet.TabIndex];
      Memo1.SetTextBuf(Rec^.Memo1);
      Memo2.SetTextBuf(Rec^.Memo2);
      Edit1.Text:=Rec^.Edit1;
      MaskEdit1.Text:=Rec^.MaskEdit1;
      Edit2.Text:=Rec^.Edit2;
      Edit3.Text:=Rec^.Edit3;
      Edit4.Text:=Rec^.Edit4;
      Date2.EditDate:=Rec^.DateEdit2;
      Edit5.Text:=Rec^.Edit5;
    end;
end;

procedure TZp41Dlg.FreeRec(var Rec:TPRecord);
begin
  with Rec^ do
    begin
      StrDispose(Memo1);
      StrDispose(Memo2);
    end;
  Dispose(Rec);
end;

procedure TZp41Dlg.DelBtnClick(Sender: TObject);
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


procedure TZp41Dlg.Memo1Change(Sender: TObject);
var
  Rec:TPRecord;
begin
  Rec:=List.Items[TabSet.TabIndex];
  Rec^.Memo1:=StrAlloc(Memo1.GetTextLen + 1);
  Memo1.GetTextBuf(Rec^.Memo1, Memo1.GetTextLen+1);
end;

procedure TZp41Dlg.Memo2Change(Sender: TObject);
var
  Rec:TPRecord;
begin
  Rec:=List.Items[TabSet.TabIndex];
  Rec^.Memo2:=StrAlloc(Memo2.GetTextLen + 1);
  Memo2.GetTextBuf(Rec^.Memo2, Memo2.GetTextLen+1);
end;

procedure TZp41Dlg.Edit1Change(Sender: TObject);
var
  Rec:TPRecord;
begin
  Rec:=List.Items[TabSet.TabIndex];
  Rec^.Edit1:=Edit1.Text;
end;

procedure TZp41Dlg.MaskEdit1Change(Sender: TObject);
var
  Rec:TPRecord;
begin
  Rec:=List.Items[TabSet.TabIndex];
  Rec^.MaskEdit1:=MaskEdit1.Text;
end;

procedure TZp41Dlg.Edit2Change(Sender: TObject);
var
  Rec:TPRecord;
begin
  Rec:=List.Items[TabSet.TabIndex];
  Rec^.Edit2:=Edit2.Text;
end;

procedure TZp41Dlg.Edit3Change(Sender: TObject);
var
  Rec:TPRecord;
begin
  Rec:=List.Items[TabSet.TabIndex];
  Rec^.Edit3:=Edit3.Text;
end;

procedure TZp41Dlg.Edit4Change(Sender: TObject);
var
  Rec:TPRecord;
begin
  Rec:=List.Items[TabSet.TabIndex];
  Rec^.Edit4:=Edit4.Text;
end;

procedure TZp41Dlg.Date2Change(Sender: TObject);
var
  Rec:TPRecord;
begin
  Rec:=List.Items[TabSet.TabIndex];
  Rec^.DateEdit2:=Date2.EditDate;
end;

procedure TZp41Dlg.Edit5Change(Sender: TObject);
var
  Rec:TPRecord;
begin
  Rec:=List.Items[TabSet.TabIndex];
  Rec^.Edit5:=Edit5.Text;
end;

procedure TZp41Dlg.MakeRecordHdr;
var
  Rct:TRect;
  LP:Integer; {Line position}
  X:Integer;
  A,B,C,D,E:Integer;
begin
  with Ry do
    begin
      Rct.Left:=XLOff;
      Rct.Right:=XROff;
      Rct.Top:=PPos+Ymm(3);
      Font.Size:=10;
      LP:=Rct.Top+Ymm(2);
      A:=Rct.Left+Xmm(8);
      E:=Rct.Right-TextWidth(Label10.Caption)-Xmm(30);
      D:=E-TextWidth(Label9.Caption)-Xmm(10);
      C:=D-TextWidth(Label7.Caption)-Xmm(10);
      B:=((C-A) div 2)+A;
      Line(Point(Rct.Left,Rct.Top),Point(Rct.Right,Rct.Top));
      TextOutCenter(((A-Rct.Left) div 2)+Rct.Left,LP,'l.p.');
      TextOutCenter(((B-A)div 2)+A,LP,Label1.Caption);
      TextOutCenter(((C-B)div 2)+B,LP,GB1.Caption);
      TextOutCenter(((D-C)div 2)+C,LP,Label7.Caption);
      TextOutCenter(((E-D)div 2)+D,LP,Label9.Caption);
      TextOutCenter(((XROff-E)div 2)+E,LP,Label10.Caption);
      LP:=LP+TextHeight+Ymm(1);
      Rct.Bottom:=LP;
      Line(Point(Rct.Left,Rct.Top),Point(Rct.Left,Rct.Bottom));
      Line(Point(A,Rct.Top),Point(A,Rct.Bottom));
      Line(Point(B,Rct.Top),Point(B,Rct.Bottom));
      Line(Point(C,Rct.Top),Point(C,Rct.Bottom));
      Line(Point(D,Rct.Top),Point(D,Rct.Bottom));
      Line(Point(E,Rct.Top),Point(E,Rct.Bottom));
      Line(Point(Rct.Right,Rct.Top),Point(Rct.Right,Rct.Bottom));
      Line(Point(Rct.Left,Rct.Bottom),Point(Rct.Right,Rct.Bottom));
      PPos:=Rct.Bottom;
    end;
end;

procedure TZp41Dlg.AddBox(ARec:Integer);
var
  A,B,C,D,E:Integer;
  Rct:TRect;
  LP:Integer; {Line position}
  q,p1,p2,p3,p4,p5:PChar;
  Rec:TPRecord;
  s:String;
  H1,H2,H3,H4,H5:Integer;
  procedure DoRect;
  begin
    with Ry do
      begin
        Line(Point(Rct.Left,Rct.Top),Point(Rct.Left,Rct.Bottom));
        Line(Point(A,Rct.Top),Point(A,Rct.Bottom));
        Line(Point(B,Rct.Top),Point(B,Rct.Bottom));
        Line(Point(C,Rct.Top),Point(C,Rct.Bottom));
        Line(Point(D,Rct.Top),Point(D,Rct.Bottom));
        Line(Point(E,Rct.Top),Point(E,Rct.Bottom));
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
          E:=Rct.Right-TextWidth(Label10.Caption)-Xmm(30);
          D:=E-TextWidth(Label9.Caption)-Xmm(10);
          C:=D-TextWidth(Label7.Caption)-Xmm(10);
          B:=((C-A) div 2)+A;
        end;
      Rec:=List.Items[ARec];
      p1:=Rec^.Memo1;
      p2:=Rec^.Memo2;
      s:=Rec^.Edit3;
      if s=''
        then s:='                  ';
      q:=StrAlloc(Length(Label2.Caption)+Length(Rec^.Edit1)+
                  Length(Label4.Caption)+Length(Rec^.Edit2)+
                  Length(Label3.Caption)+Length(Rec^.MaskEdit1)+
                  Length(Label5.Caption)+Length(s)+Length(Label6.Caption)+Length(Rec^.Edit4)+15);
      StrPCopy(q,Label2.Caption+Rec^.Edit1+#13+#10+
                 Label4.Caption+Rec^.Edit2+#13+#10+
                 Label3.Caption+Rec^.MaskEdit1+#13+#10+
                 Label5.Caption+s+'   '+Label6.Caption+Rec^.Edit4);
      p3:=q;
      s:=DateToStr(Rec^.DateEdit2);
      p4:=StringAsPChar(s);
      p5:=StringAsPChar(Rec^.Edit5);
      if p1<>Nil
        then H1:=MemoOut(Rect(A+Xmm(2),LP,B-Xmm(2),PrintSpace-LP),p1, False, True)
        else H1:=0;
      if p2<>Nil
        then H2:=MemoOut(Rect(E+Xmm(2),LP,Rct.Right-Xmm(2),PrintSpace-LP),p2, False, True)
        else H2:=0;
      if p3<>Nil
        then H3:=MemoOut(Rect(B+Xmm(2),LP,C-Xmm(2),PrintSpace-LP),p3, False, True)
        else H3:=0;
      if p4<>Nil
        then H4:=MemoOut(Rect(C+Xmm(2),LP,D-Xmm(2),PrintSpace-LP),p4, False, True)
        else H4:=0;
      if p5<>Nil
        then H5:=MemoOut(Rect(D+Xmm(2),LP,E-Xmm(2),PrintSpace-LP),p5, False, True)
        else H5:=0;
      if H2>H1 then H1:=H2;
      if H3>H1 then H1:=H3;
      if H4>H1 then H1:=H4;
      if H5>H1 then H1:=H5; {H1 contains the max height of the box}
      if LP+H1>PrintSpace
        then begin
          MakeNewPage(Ry,Label8.Caption+Date1.Text,'41',NumEdit.Text,PPos,PrintSpace);
          MakeRecordHdr;
          MakeFooter(Ry,PrintSpace);
          Rct.Top:=PPos;
          LP:=Rct.Top+Ymm(2);
        end;
      TextOut(Rct.Left+Xmm(2),LP,IntToStr(ARec+1));
      if p1<>Nil
        then MemoOut(Rect(A+Xmm(2),LP,B-Xmm(2),PrintSpace-LP),p1, False, False);
      if p2<>Nil
        then MemoOut(Rect(E+Xmm(2),LP,Rct.Right-Xmm(2),PrintSpace-LP),p2, False, False);
      if p3<>Nil
        then MemoOut(Rect(B+Xmm(2),LP,C-Xmm(2),PrintSpace-LP),p3, False, False);
      if p4<>Nil
        then MemoOut(Rect(C+Xmm(2),LP,D-Xmm(2),PrintSpace-LP),p4, False, False);
      if p5<>Nil
        then MemoOut(Rect(D+Xmm(2),LP,E-Xmm(2),PrintSpace-LP),p5, False, False);
      Rct.Bottom:=H1+LP+Ymm(1);
      DoRect;
      LP:=LP+H1;
      PPos:=LP;
      StrDispose(q);
    end;
end;

procedure TZp41Dlg.MakePrint;
var
  x:LongInt;
begin
    with Ry do
      begin
        Orientation:=poLandscape;
        NewJob;
        SetMinMargins(Xmm(10),Ymm(15),Xmm(20),Ymm(10));
        MakeHeader(Ry,Label8.Caption+Date1.Text,'41',NumEdit.Text,'',PPos);
        PrintSpace:=YBOff-Ymm(PageBottomSpace);
        MakeFooter(Ry,PrintSpace);
        MakeRecordHdr;
        for x:=0 to Tabset.Tabs.Count-1 do
          AddBox(x);
      end;
end;

procedure TZp41Dlg.PreviewBtnClick(Sender: TObject);
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

procedure TZp41Dlg.SaveFile;
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
      SaveString(Zp41FileHdr,FHandle);
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
          SaveString(Rec^.Edit1,FHandle);
          SaveString(Rec^.MaskEdit1,FHandle);
          SaveString(Rec^.Edit2,FHandle);
          SaveString(Rec^.Edit3,FHandle);
          SaveString(Rec^.Edit4,FHandle);
          SaveDateTime(Rec^.DateEdit2,FHandle);
          SaveString(Rec^.Edit5,FHandle);
          M.SetTextBuf(Rec^.Memo2);
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

procedure TZp41Dlg.LoadFile;
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
        if s=Zp41FileHdr
          then begin
            LoadString(s,FHandle);
            if (s=FilePwd)
              then begin
                MakeCodeKey(FilePwd);
                LoadEdit(NumEdit,FHandle);
                while List.Count>0 do
                  begin
                    Rec:=List.Items[0];
                    List.Delete(0);
                    List.Pack;
                    Tabset.Tabs.Delete(0);
                    FreeRec(Rec);
                  end;
                LoadInteger(Tot,FHandle);
                LoadDateTime(DT,FHandle);
                Date1.EditDate:=DT;
                x:=0;
                while x<Tot do
                  begin
                    AddPage;
                    LoadMemo(Memo1,FHandle);
                    LoadEdit(Edit1,FHandle);
                    LoadMaskEdit(MaskEdit1,FHandle);
                    LoadEdit(Edit2,FHandle);
                    LoadEdit(Edit3,FHandle);
                    LoadEdit(Edit4,FHandle);
                    LoadDateTime(DT,FHandle);
                    Date2.EditDate:=DT;
                    LoadEdit(Edit5,FHandle);
                    LoadMemo(Memo2,FHandle);
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

procedure TZp41Dlg.OpenBtnClick(Sender: TObject);
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

procedure TZp41Dlg.SaveBtnClick(Sender: TObject);
begin
  if SaveDialog.Execute
    then begin
      FileName:=SaveDialog.FileName;
      SaveFile;
    end;
end;

procedure TZp41Dlg.FormDestroy(Sender: TObject);
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

procedure TZp41Dlg.OKBtnClick(Sender: TObject);
var
  x:Integer;
begin
  x:=MessageDlg(wmSaveOnExit,mtWarning,[mbYes,mbNo,mbCancel],0);
  case x of
    mrYes: begin
             SaveBtnClick(Sender);
             ModalResult:=mrOk;
             Close;
           end;
    mrNo: begin
            ModalResult:=mrCancel;
            Close;
          end;
    mrCancel: ModalResult:=0;
  end;{case}
end;

procedure TZp41Dlg.HelpBtnClick(Sender: TObject);
begin
  Application.HelpContext(41);
end;

procedure TZp41Dlg.CancelBtnClick(Sender: TObject);
begin
  Close;
end;

end.

