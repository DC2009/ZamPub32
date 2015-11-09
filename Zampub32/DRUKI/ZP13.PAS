unit Zp13;

interface

uses WinTypes, WinProcs, Classes, Graphics, Forms, Controls, Buttons,
  StdCtrls, Tabs, ExtCtrls, Mask, SysUtils, Dialogs, Printers,
  Utils,
  UserUnit,
  ZpBoxes,
  SiwzIni,
  SkOk,
  RPrev,
  DrMsg, Sk;

type
  TPRecord=^TRecord;
  TRecord=Record
    Memo1: PChar;
    Edit1: String;
    MaskEdit1: String;
    Edit2: String;
    Edit3: String;
    Edit4: String;
  end;

  TZp13Dlg = class(TForm)
    TabSet: TTabSet;
    NewBtn: TButton;
    DelBtn: TButton;
    Paneld: TPanel;
    Label1: TLabel;
    Memo1: TMemo;
    GB1: TGroupBox;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Edit1: TEdit;
    MaskEdit1: TMaskEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    Panel2: TPanel;
    OKBtn: TBitBtn;
    CancelBtn: TBitBtn;
    PrintBtn: TBitBtn;
    PreviewBtn: TBitBtn;
    OpenBtn: TBitBtn;
    SaveBtn: TBitBtn;
    HelpBtn: TBitBtn;
    SaveDialog: TSaveDialog;
    OpenDialog: TOpenDialog;
    Label29: TLabel;
    NumEdit: TEdit;
    Sk: TSmartKey;
    procedure TabSetClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure NewBtnClick(Sender: TObject);
    procedure DelBtnClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure Memo1Change(Sender: TObject);
    procedure MaskEdit1Change(Sender: TObject);
    procedure Edit2Change(Sender: TObject);
    procedure Edit3Change(Sender: TObject);
    procedure Edit4Change(Sender: TObject);
    procedure PreviewBtnClick(Sender: TObject);
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
    procedure LoadFile;
    procedure SaveFile;
    procedure MakePrint;
    procedure FreeRec(var Rec:TPRecord);
    procedure AddPage;
    procedure MakeRecordHdr;
    procedure MakeRecordBox(i:LongInt);
    function GetRecordHeight(i:LongInt):Integer;
  public
    { Public declarations }
  end;

var
  Zp13Dlg: TZp13Dlg;

procedure DrukZp13; export;

implementation

{$R *.DFM}

procedure DrukZp13;
var
  Cur:Integer;
begin
  Cur:=Screen.Cursor;
  Screen.Cursor:=crHourGlass;
  ZP13Dlg:=TZp13Dlg.Create(Nil);
  Screen.Cursor:=Cur;
  ZP13Dlg.ShowModal;
  ZP13Dlg.Free;
end;

procedure TZp13Dlg.FormCreate(Sender: TObject);
var
  Rec:TRecord;
begin
  Application.HelpFile:=DruZpHelpFile;
  FilePwd:=LoadFilePwd(AddBackSlash(ProgramDir)+SecurityFileName);
  List:=TList.Create;
  AddPage;
end;

procedure TZp13Dlg.AddPage;
var
  Rec:TPRecord;
begin
  TabSet.Tabs.Add(IntToStr(TabSet.Tabs.Count+1));
  New(Rec);
  List.Add(Rec);
  with Rec^ do
    begin
      Memo1:=StrAlloc(1);
      StrPCopy(Memo1,'');
      Edit1:='';
      MaskEdit1:='';
      Edit2:='';
      Edit3:='';
      Edit4:='';
    end;
  TabSet.TabIndex:=TabSet.Tabs.Count-1;
  Memo1.Clear;
  Edit1.Clear;
  MaskEdit1.Clear;
  Edit2.Clear;
  Edit3.Clear;
  Edit4.Clear;
end;

procedure TZp13Dlg.NewBtnClick(Sender: TObject);
begin
  AddPage;
end;

procedure TZp13Dlg.TabSetClick(Sender: TObject);
var
  Rec:TPRecord;
begin
  if Tabset.TabIndex>-1
    then begin
      Rec:=List.Items[TabSet.TabIndex];
      Memo1.SetTextBuf(Rec^.Memo1);
      Edit1.Text:=Rec^.Edit1;
      MaskEdit1.Text:=Rec^.MaskEdit1;
      Edit2.Text:=Rec^.Edit2;
      Edit3.Text:=Rec^.Edit3;
      Edit4.Text:=Rec^.Edit4;
    end;
end;

procedure TZp13Dlg.FreeRec(var Rec:TPRecord);
begin
  with Rec^ do
    StrDispose(Memo1);
  Dispose(Rec);
end;

procedure TZp13Dlg.DelBtnClick(Sender: TObject);
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

procedure TZp13Dlg.Memo1Change(Sender: TObject);
var
  Rec:TPRecord;
begin
  Rec:=List.Items[TabSet.TabIndex];
  Rec^.Memo1:=StrAlloc(Memo1.GetTextLen + 1);
  Memo1.GetTextBuf(Rec^.Memo1, Memo1.GetTextLen+1);
end;

procedure TZp13Dlg.Edit1Change(Sender: TObject);
var
  Rec:TPRecord;
begin
  Rec:=List.Items[TabSet.TabIndex];
  Rec^.Edit1:=Edit1.Text;
end;

procedure TZp13Dlg.MaskEdit1Change(Sender: TObject);
var
  Rec:TPRecord;
begin
  Rec:=List.Items[TabSet.TabIndex];
  Rec^.MaskEdit1:=MaskEdit1.Text;
end;

procedure TZp13Dlg.Edit2Change(Sender: TObject);
var
  Rec:TPRecord;
begin
  Rec:=List.Items[TabSet.TabIndex];
  Rec^.Edit2:=Edit2.Text;
end;

procedure TZp13Dlg.Edit3Change(Sender: TObject);
var
  Rec:TPRecord;
begin
  Rec:=List.Items[TabSet.TabIndex];
  Rec^.Edit3:=Edit3.Text;
end;

procedure TZp13Dlg.Edit4Change(Sender: TObject);
var
  Rec:TPRecord;
begin
  Rec:=List.Items[TabSet.TabIndex];
  Rec^.Edit4:=Edit4.Text;
end;

procedure TZp13Dlg.MakeRecordHdr;
var
  Rct:TRect;
  LP:Integer; {Line position}
  X:Integer;
  A,B:Integer;
begin
  with Ry do
    begin
      Rct.Left:=XLOff;
      Rct.Right:=XROff;
      Rct.Top:=PPos+Ymm(3);
      Font.Size:=10;
      LP:=Rct.Top+Ymm(2);
      A:=Rct.Left+Xmm(8);
      B:=((Rct.Right-A) div 2)+A;
      Line(Point(Rct.Left,Rct.Top),Point(Rct.Right,Rct.Top));
      TextOutCenter(((A-Rct.Left) div 2)+Rct.Left,LP,'l.p.');
      TextOutCenter(((B-A)div 2)+A,LP,Label1.Caption);
      TextOutCenter(((Rct.Right-B)div 2)+B,LP,GB1.Caption);
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

function TZp13Dlg.GetRecordHeight(i:LongInt):Integer;
var
  p:PChar;
  Rct:TRect;
  LP,L1:Integer; {Line position}
  X,Y:Integer;
  A,B:Integer;
  Rec:TPRecord;
begin
  with Ry do
    begin
      Rct.Left:=XLOff;
      Rct.Right:=XROff;
      Font.Size:=10;
      A:=Rct.Left+Xmm(8);
      B:=((Rct.Right-A) div 2)+A;
      LP:=Ymm(1);
      L1:=LP;
      Rec:=List.Items[i];
      X:=MemoOut(Rect(A+Xmm(2),LP,B-Xmm(2),10), Rec^.Memo1, False, TRUE);
      LP:=LP+X+Ymm(1);
      p:=StrAlloc(Length(Label2.Caption)+Length(Rec^.Edit1)+1);
      StrPCopy(p,Label2.Caption+Rec^.Edit1);
      Y:=MemoOut(Rect(B+Xmm(2),L1,Rct.Right-Xmm(2),10), p, False, TRUE);
      StrDispose(p);
      L1:=L1+Y+Ymm(1);
      p:=StrAlloc(Length(Label4.Caption)+Length(Rec^.Edit2)+1);
      StrPCopy(p,Label4.Caption+Rec^.Edit2);
      Y:=MemoOut(Rect(B+Xmm(2),L1,Rct.Right-Xmm(2),10), p, False, TRUE);
      StrDispose(p);
      L1:=L1+Y+Ymm(1);
      p:=StrAlloc(Length(Label3.Caption)+Length(Rec^.MaskEdit1)+1);
      StrPCopy(p,Label3.Caption+Rec^.MaskEdit1);
      Y:=MemoOut(Rect(B+Xmm(2),L1,Rct.Right-Xmm(2),10), p, False, TRUE);
      StrDispose(p);
      L1:=L1+Y+Ymm(1);
      p:=StrAlloc(Length(Label5.Caption)+Length(Rec^.Edit3)+Length(Label6.Caption)+Length(Rec^.Edit4)+2);
      StrPCopy(p,Label5.Caption+Rec^.Edit3+' '+Label6.Caption+Rec^.Edit4);
      Y:=MemoOut(Rect(B+Xmm(2),L1,Rct.Right-Xmm(2),10), p, False, TRUE);
      StrDispose(p);
      L1:=L1+Y+Ymm(1);
      if L1>X
        then LP:=L1
        else LP:=LP+X+Ymm(1);
      Result:=LP;
    end;
end;

procedure TZp13Dlg.MakeRecordBox(i:LongInt);
var
  p:PChar;
  Rct:TRect;
  LP,L1:Integer; {Line position}
  X,Y:Integer;
  A,B:Integer;
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
      A:=Rct.Left+Xmm(8);
      B:=((Rct.Right-A) div 2)+A;
      Line(Point(Rct.Left,LP),Point(Rct.Right,LP));
      LP:=LP+Ymm(1);
      L1:=LP;
      TextOutCenter(((A-Rct.Left) div 2)+Rct.Left,LP,IntToStr(i+1));
      Rec:=List.Items[i];
      X:=MemoOut(Rect(A+Xmm(2),LP,B-Xmm(2),10), Rec^.Memo1, False, False);
      LP:=LP+X+Ymm(1);
      p:=StrAlloc(Length(Label2.Caption)+Length(Rec^.Edit1)+1);
      StrPCopy(p,Label2.Caption+Rec^.Edit1);
      Y:=MemoOut(Rect(B+Xmm(2),L1,Rct.Right-Xmm(2),10), p, False, False);
      StrDispose(p);
      L1:=L1+Y+Ymm(1);
      p:=StrAlloc(Length(Label4.Caption)+Length(Rec^.Edit2)+1);
      StrPCopy(p,Label4.Caption+Rec^.Edit2);
      Y:=MemoOut(Rect(B+Xmm(2),L1,Rct.Right-Xmm(2),10), p, False, False);
      StrDispose(p);
      L1:=L1+Y+Ymm(1);
      p:=StrAlloc(Length(Label3.Caption)+Length(Rec^.MaskEdit1)+1);
      StrPCopy(p,Label3.Caption+Rec^.MaskEdit1);
      Y:=MemoOut(Rect(B+Xmm(2),L1,Rct.Right-Xmm(2),10), p, False, False);
      StrDispose(p);
      L1:=L1+Y+Ymm(1);
      s:=Rec^.Edit3;
      if s=''
        then s:='                      ';
      p:=StrAlloc(Length(Label5.Caption)+Length(s)+Length(Label6.Caption)+Length(Rec^.Edit4)+4);
      StrPCopy(p,Label5.Caption+s+'   '+Label6.Caption+Rec^.Edit4);
      Y:=MemoOut(Rect(B+Xmm(2),L1,Rct.Right-Xmm(2),10), p, False, False);
      StrDispose(p);
      L1:=L1+Y+Ymm(1);
      if L1>LP
        then LP:=L1;
      Rct.Bottom:=LP;
      Line(Point(Rct.Left,Rct.Top),Point(Rct.Left,Rct.Bottom));
      Line(Point(A,Rct.Top),Point(A,Rct.Bottom));
      Line(Point(B,Rct.Top),Point(B,Rct.Bottom));
      Line(Point(Rct.Right,Rct.Top),Point(Rct.Right,Rct.Bottom));
      Line(Point(Rct.Left,Rct.Bottom),Point(Rct.Right,Rct.Bottom));
      PPos:=Rct.Bottom;
    end;
end;

procedure TZp13Dlg.MakePrint;
var
  p : PChar;
  Rect:TRect;
  x:LongInt;
  FullPage:Boolean;
begin
    with Ry do
      begin
        Orientation:=poPortrait;
        NewJob;
        SetMinMargins(Xmm(20),Ymm(10),Xmm(20),Ymm(10));
        x:=0;
        repeat
          MakeHeader(Ry,Zp13Tit,'13',NumEdit.Text,'',PPos);
          PrintSpace:=YBOff-Ymm(35);
          MakeFooter(Ry,PrintSpace);
          MakeRecordHdr;
          FullPage:=False;
          while (x<Tabset.Tabs.Count) and not FullPage do
            begin
              FullPage:=(PPos+GetRecordHeight(x))>PrintSpace;
              if not FullPage
                then begin
                  MakeRecordBox(x);
                  Inc(x);
                end;
            end;
          if FullPage
            then NewPage;
        until x>=Tabset.Tabs.Count;
      end;
end;

procedure TZp13Dlg.PreviewBtnClick(Sender: TObject);
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

procedure TZp13Dlg.SaveFile;
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
      SaveString(Zp13FileHdr,FHandle);
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
          SaveString(Rec^.Edit1,FHandle);
          SaveString(Rec^.MaskEdit1,FHandle);
          SaveString(Rec^.Edit2,FHandle);
          SaveString(Rec^.Edit3,FHandle);
          SaveString(Rec^.Edit4,FHandle);
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

procedure TZp13Dlg.LoadFile;
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
        if s=Zp13FileHdr
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
                    LoadEdit(Edit1,FHandle);
                    LoadMaskEdit(MaskEdit1,FHandle);
                    LoadEdit(Edit2,FHandle);
                    LoadEdit(Edit3,FHandle);
                    LoadEdit(Edit4,FHandle);
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

procedure TZp13Dlg.OpenBtnClick(Sender: TObject);
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

procedure TZp13Dlg.SaveBtnClick(Sender: TObject);
begin
  if SaveDialog.Execute
    then begin
      FileName:=SaveDialog.FileName;
      SaveFile;
    end;
end;

procedure TZp13Dlg.FormDestroy(Sender: TObject);
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

procedure TZp13Dlg.OKBtnClick(Sender: TObject);
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

procedure TZp13Dlg.HelpBtnClick(Sender: TObject);
begin
  Application.HelpContext(13);
end;

end.
