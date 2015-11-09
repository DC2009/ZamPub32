unit Zp61;

interface

uses WinTypes, WinProcs, Classes, Graphics, Forms, Controls, Buttons,
  StdCtrls, Tabs, ExtCtrls, Mask, SysUtils, Dialogs, Printers, Messages,
  SiwzIni,
  ZpBoxes,
  RPrev,
  SkOk,
  UserUnit,
  Utils,
  DrMsg, IntDate, Sk;

const
  C6L1='Odwo³anie do';
  C6L2='Prezesa UZP';
  NastUndef=0;
  NastYes=1;
  NastNo=2;

type
  TPRecord=^TRecord;
  TRecord=Record
    Cb1:Integer;
    DateEdit1:TDateTime;
    Memo1: PChar;
    Memo2: PChar;
    Nast:Byte;
  end;

  TZp61Dlg = class(TForm)
    TabSet: TTabSet;
    NewBtn: TButton;
    DelBtn: TButton;
    Paneld: TPanel;
    Label1: TLabel;
    Label3: TLabel;
    Memo1: TMemo;
    Memo2: TMemo;
    Label2: TLabel;
    Label4: TLabel;
    CB1: TComboBox;
    Label5: TLabel;
    RB1: TRadioButton;
    RB2: TRadioButton;
    Panel12: TPanel;
    OKBtn: TBitBtn;
    CancelBtn: TBitBtn;
    PrintBtn: TBitBtn;
    PreviewBtn: TBitBtn;
    OpenBtn: TBitBtn;
    SaveBtn: TBitBtn;
    HelpBtn: TBitBtn;
    SaveDialog: TSaveDialog;
    OpenDialog: TOpenDialog;
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
    procedure PreviewBtnClick(Sender: TObject);
    procedure Memo2Change(Sender: TObject);
    procedure DateEdit1Change(Sender: TObject);
    procedure CB1Change(Sender: TObject);
    procedure RB1Click(Sender: TObject);
    procedure RB2Click(Sender: TObject);
    procedure OKBtnClick(Sender: TObject);
    procedure OpenBtnClick(Sender: TObject);
    procedure SaveBtnClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
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
  Zp61Dlg: TZp61Dlg;

procedure DrukZp61; export;

implementation

{$R *.DFM}

procedure DrukZp61;
var
  Cur:Integer;
begin
  Cur:=Screen.Cursor;
  Screen.Cursor:=crHourGlass;
  ZP61Dlg:=TZp61Dlg.Create(Nil);
  Screen.Cursor:=Cur;
  ZP61Dlg.ShowModal;
  ZP61Dlg.Free;
end;

procedure TZp61Dlg.FormCreate(Sender: TObject);
var
  Rec:TRecord;
begin
  Application.HelpFile:=DruZpHelpFile;
  FilePwd:=LoadFilePwd(AddBackSlash(ProgramDir)+SecurityFileName);
  List:=TList.Create;
  AddPage;
end;

procedure TZp61Dlg.AddPage;
var
  Rec:TPRecord;
begin
  New(Rec);
  List.Add(Rec);
  with Rec^ do
    begin
      Cb1:=-1;
      DateEdit1:=Now;
      Memo1:=StrAlloc(1);
      StrCopy(Memo1,#0);
      Memo2:=StrAlloc(1);
      StrCopy(Memo2,#0);
      Nast:=0;
    end;
  TabSet.Tabs.Add(IntToStr(TabSet.Tabs.Count+1));
  TabSet.TabIndex:=TabSet.Tabs.Count-1;
  Date1.EditDate:=Now;
  Memo1.Clear;
  Memo2.Clear;
  CB1.ItemIndex:=-1;
  RB1.Checked:=FALSE;
  RB2.Checked:=FALSE;
end;

procedure TZp61Dlg.NewBtnClick(Sender: TObject);
begin
  AddPage;
end;

procedure TZp61Dlg.TabSetClick(Sender: TObject);
var
  Rec:TPRecord;
begin
  if Tabset.TabIndex>-1
    then begin
      Rec:=List.Items[TabSet.TabIndex];
      Date1.EditDate:=Rec^.DateEdit1;
      Memo1.SetTextBuf(Rec^.Memo1);
      Memo2.SetTextBuf(Rec^.Memo2);
      RB1.Checked:=Rec^.Nast=NastYes;
      RB2.Checked:=Rec^.Nast=NastNo;
      CB1.ItemIndex:=Rec^.CB1;
    end;
end;

procedure TZp61Dlg.FreeRec(var Rec:TPRecord);
begin
  with Rec^ do
    begin
      StrDispose(Memo1);
      StrDispose(Memo2);
    end;
  Dispose(Rec);
end;

procedure TZp61Dlg.DelBtnClick(Sender: TObject);
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

procedure TZp61Dlg.DateEdit1Change(Sender: TObject);
var
  Rec:TPRecord;
begin
  Rec:=List.Items[TabSet.TabIndex];
  Rec^.DateEdit1:=Date1.EditDate;
end;

procedure TZp61Dlg.Memo1Change(Sender: TObject);
var
  Rec:TPRecord;
begin
  Rec:=List.Items[TabSet.TabIndex];
  Rec^.Memo1:=StrAlloc(Memo1.GetTextLen + 1);
  Memo1.GetTextBuf(Rec^.Memo1, Memo1.GetTextLen+1);
end;

procedure TZp61Dlg.Memo2Change(Sender: TObject);
var
  Rec:TPRecord;
begin
  Rec:=List.Items[TabSet.TabIndex];
  Rec^.Memo2:=StrAlloc(Memo2.GetTextLen + 1);
  Memo2.GetTextBuf(Rec^.Memo2, Memo2.GetTextLen+1);
end;

procedure TZp61Dlg.CB1Change(Sender: TObject);
var
  Rec:TPRecord;
begin
  Rec:=List.Items[TabSet.TabIndex];
  Rec^.CB1:=CB1.ItemIndex;
end;

procedure TZp61Dlg.RB1Click(Sender: TObject);
var
  Rec:TPRecord;
begin
  Rec:=List.Items[TabSet.TabIndex];
  RB2.Checked:=FALSE;
  Rec^.Nast:=NastYes;
end;

procedure TZp61Dlg.RB2Click(Sender: TObject);
var
  Rec:TPRecord;
begin
  Rec:=List.Items[TabSet.TabIndex];
  RB1.Checked:=FALSE;
  Rec^.Nast:=NastNo;
end;

procedure TZp61Dlg.MakeRecordHdr;
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
      A:=Rct.Left+Xmm(12);
      B:=A+TextWidth(Label1.Caption)+Xmm(10);
      C:=B+TextWidth(Label2.Caption)+Xmm(15);
      E:=Rct.Right-TextWidth(C6L1)-Xmm(4);
      D:=E-TextWidth(Label4.Caption)-Xmm(8);
      Line(Point(Rct.Left,Rct.Top),Point(Rct.Right,Rct.Top));
      TextOutCenter(((A-Rct.Left) div 2)+Rct.Left,LP,'l.p.');
      TextOutCenter(((B-A)div 2)+A,LP,Label1.Caption);
      TextOutCenter(((C-B)div 2)+B,LP,Label2.Caption);
      TextOutCenter(((D-C)div 2)+C,LP,Label3.Caption);
      TextOutCenter(((E-D)div 2)+D,LP,Label4.Caption);
      TextOutCenter(((XROff-E)div 2)+E,LP,C6L1);
      LP:=LP+TextHeight+Ymm(1);
      TextOutCenter(((XROff-E)div 2)+E,LP,C6L2);
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

procedure TZp61Dlg.AddBox(ARec:Integer);
var
  A,B,C,D,E:Integer;
  Rct:TRect;
  LP:Integer; {Line position}
  p0,p1,p2,p3,p4,p5:PChar;
  Rec:TPRecord;
  s:String;
  H0,H1,H2,H3,H4,H5:Integer;
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
          A:=Rct.Left+Xmm(12);
          B:=A+TextWidth(Label1.Caption)+Xmm(10);
          C:=B+TextWidth(Label2.Caption)+Xmm(15);
          E:=Rct.Right-TextWidth(C6L1)-Xmm(4);
          D:=E-TextWidth(Label4.Caption)-Xmm(8);
        end;
      Rec:=List.Items[ARec];
      s:=IntToStr(ARec+1);
      p0:=StrAlloc(Length(s)+1);
      StrPCopy(p0,s);
      p1:=Rec^.Memo1;
      s:=DateToStr(Rec^.DateEdit1);
      p2:=StrAlloc(Length(s)+1);
      StrPCopy(p2,s);
      p3:=Rec^.Memo2;
      s:=CB1.Items[Rec^.CB1];
      p4:=StrAlloc(Length(s)+1);
      StrPCopy(p4,s);
      if Rec^.Nast=NastYes
        then s:=RB1.Caption
      else if Rec^.Nast=NastNo
        then s:=RB2.Caption
      else s:='';
      p5:=StrAlloc(Length(s)+1);
      StrPCopy(p5,s);
      if p0<>Nil
        then H0:=MemoOut(Rect(Rct.Left+Xmm(2),LP,A-Xmm(2),PrintSpace-LP),p0, False, TRUE)
        else H0:=0;
      if p1<>Nil
        then H1:=MemoOut(Rect(A+Xmm(2),LP,B-Xmm(2),PrintSpace-LP),p1, False, TRUE)
        else H1:=0;
      if p2<>Nil
        then H2:=MemoOut(Rect(B+Xmm(2),LP,C-Xmm(2),PrintSpace-LP),p2, False, TRUE)
        else H2:=0;
      if p3<>Nil
        then H3:=MemoOut(Rect(C+Xmm(2),LP,D-Xmm(2),PrintSpace-LP),p3, False, TRUE)
        else H3:=0;
      if p4<>Nil
        then H4:=MemoOut(Rect(D+Xmm(2),LP,E-Xmm(2),PrintSpace-LP),p4, False, TRUE)
        else H4:=0;
      if p5<>Nil
        then H5:=MemoOut(Rect(E+Xmm(2),LP,Rct.Right-Xmm(2),PrintSpace-LP),p5, False, TRUE)
        else H5:=0;
      if H0>H1 then H1:=H0; {H1 contains the max height of the box}
      if H2>H1 then H1:=H2;
      if H3>H1 then H1:=H3;
      if H4>H1 then H1:=H4;
      if H5>H1 then H1:=H5;
      if LP+H1>PrintSpace
        then begin
          MakeNewPage(Ry,Zp61Tit,'61',NumEdit.Text,PPos,PrintSpace);
          MakeRecordHdr;
          MakeFooter(Ry,PrintSpace);
          Rct.Top:=PPos;
          LP:=Rct.Top+Ymm(2);
        end;
      if p0<>Nil
        then MemoOut(Rect(Rct.Left+Xmm(2),LP,A-Xmm(2),PrintSpace-LP),p0, False, False);
      if p1<>Nil
        then MemoOut(Rect(A+Xmm(2),LP,B-Xmm(2),PrintSpace-LP),p1, False, False);
      if p2<>Nil
        then MemoOut(Rect(B+Xmm(2),LP,C-Xmm(2),PrintSpace-LP),p2, False, False);
      if p3<>Nil
        then MemoOut(Rect(C+Xmm(2),LP,D-Xmm(2),PrintSpace-LP),p3, False, False);
      if p4<>Nil
        then MemoOut(Rect(D+Xmm(2),LP,E-Xmm(2),PrintSpace-LP),p4, False, False);
      if p5<>Nil
        then MemoOut(Rect(E+Xmm(2),LP,Rct.Right-Xmm(2),PrintSpace-LP),p5, False, False);
      Rct.Bottom:=H1+LP+Ymm(1);
      DoRect;
      LP:=LP+H1;
      PPos:=LP;
      StrDispose(p0);
      StrDispose(p2);
      StrDispose(p4);
      StrDispose(p5);
    end;
end;

procedure TZp61Dlg.MakePrint;
var
  x:LongInt;
begin
    with Ry do
      begin
        Orientation:=poLandscape;
        NewJob;
        SetMinMargins(Xmm(10),Ymm(15),Xmm(20),Ymm(10));
        PrintSpace:=YBOff-Ymm(PageBottomSpace);
        MakeHeader(Ry,Zp61Tit,'61',NumEdit.Text,'',PPos);
        MakeFooter(Ry,PrintSpace);
        MakeRecordHdr;
        for x:=0 to Tabset.Tabs.Count-1 do
          AddBox(x);
      end;
end;

procedure TZp61Dlg.PreviewBtnClick(Sender: TObject);
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
  Printer.Orientation:=poLandscape;
  try
    Ry := TRyPrinter.Create;
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

procedure TZp61Dlg.SaveFile;
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
      SaveString(Zp61FileHdr,FHandle);
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
          M.SetTextBuf(Rec^.Memo1);
          SaveMemo(M,FHandle);
          SaveDateTime(Rec^.DateEdit1,FHandle);
          M.SetTextBuf(Rec^.Memo2);
          SaveMemo(M,FHandle);
          SaveInteger(Rec^.Cb1,FHandle);
          SaveByte(Rec^.Nast,FHandle);
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

procedure TZp61Dlg.LoadFile;
var
  s:String;
  i:Integer;
  Rec:TPRecord;
  x,Tot:Integer;
  Cb:Integer;
  Nast:Byte;
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
        if s=Zp61FileHdr
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
                      x:=0;
                while x<Tot do
                  begin
                    AddPage;
                    LoadMemo(Memo1,FHandle);
                    LoadDateTime(DT,FHandle);
                    Date1.EditDate:=DT;
                    LoadMemo(Memo2,FHandle);
                    LoadInteger(Cb,FHandle);
                    CB1.ItemIndex:=Cb;
                    Rec:=List.Items[x];
                    Rec^.CB1:=Cb;
                    LoadByte(Nast,FHandle);
                    case Nast of
                      NastUndef:
                        begin
                          RB1.Checked:=FALSE;
                          RB2.Checked:=FALSE;
                        end;
                      NastYes  :
                        begin
                          RB1.Checked:=TRUE;
                          RB2.Checked:=FALSE;
                        end;
                      NastNo   :
                        begin
                          RB1.Checked:=FALSE;
                          RB2.Checked:=TRUE;
                        end;
                    end;{case}
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

procedure TZp61Dlg.OpenBtnClick(Sender: TObject);
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

procedure TZp61Dlg.SaveBtnClick(Sender: TObject);
begin
  if SaveDialog.Execute
    then begin
      FileName:=SaveDialog.FileName;
      SaveFile;
    end;
end;

procedure TZp61Dlg.FormDestroy(Sender: TObject);
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

procedure TZp61Dlg.OKBtnClick(Sender: TObject);
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

procedure TZp61Dlg.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key=#13
    then begin
      Key:=#0;
      Perform(wm_NextDlgCtl,0,0);
    end;
end;

procedure TZp61Dlg.HelpBtnClick(Sender: TObject);
begin
  Application.HelpContext(61);
end;

end.
