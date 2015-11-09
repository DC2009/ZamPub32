unit Zamwr;

interface

uses WinTypes, WinProcs, Classes, Graphics, Forms, Controls, Buttons,
  StdCtrls, Menus, Mask, TabNotBk, ExtCtrls, Dialogs, Dateedit,
  Printers,
  NewSiwz,
  RPrev,
  PrzHdr2;

const
  MaxPages=4;

  sRepresentedBy=' reprezentowana przez ';
  sOfferedPrice='Cena ofertowa: ';

  DefSelPages:Array[1..MaxPages] of Boolean=(FALSE,FALSE,FALSE,FALSE);

type
  TZamWRDlg = class(TForm)
    Bevel: TBevel;
    TitleBevel: TBevel;
    TitleLabel: TLabel;
    CloseBitBtn: TBitBtn;
    BitBtn2: TBitBtn;
    NextBitBtn: TBitBtn;
    PrevBitBtn: TBitBtn;
    SaveBitBtn: TBitBtn;
    PrintBitBtn: TBitBtn;
    MainMenu1: TMainMenu;
    Plik1: TMenuItem;
    Ustaldrukark1: TMenuItem;
    Drukuj: TMenuItem;
    Export1: TMenuItem;
    N1: TMenuItem;
    Zamknji1: TMenuItem;
    TabNotebook: TTabbedNotebook;
    ZamScrollBox: TScrollBox;
    NameLabel: TLabel;
    StreetLabel: TLabel;
    TownLabel: TLabel;
    BldgLabel: TLabel;
    ZipLabel: TLabel;
    TelLabel: TLabel;
    FaxLabel: TLabel;
    TelexLabel: TLabel;
    RegonLabel: TLabel;
    ProwadLabel: TLabel;
    TownEdit: TEdit;
    BldgEdit: TEdit;
    ZipMaskEdit: TMaskEdit;
    NameMemo: TMemo;
    TelEdit: TEdit;
    FaxEdit: TEdit;
    StreetEdit: TEdit;
    Page1Button: TButton;
    TelexEdit: TEdit;
    RegonMaskEdit: TMaskEdit;
    ProwadMemo: TMemo;
    ScrollBox2: TScrollBox;
    BeginLabel: TLabel;
    Page2Button: TButton;
    ScrollBox3: TScrollBox;
    ObjectLabel: TLabel;
    ObjectMemo: TMemo;
    Page3Button: TButton;
    ScrollBox4: TScrollBox;
    OferentLabel1: TLabel;
    Page4Button: TButton;
    OferentMemo1: TMemo;
    PrintDlg: TPrintDialog;
    PrinterSetupDlg: TPrinterSetupDialog;
    OferentMemo2: TMemo;
    OferentLabel2: TLabel;
    Art71Memo1: TMemo;
    Art71Memo2: TMemo;
    EndLabel: TLabel;
    Pregl1: TMenuItem;
    ObjectMemo2: TMemo;
    ObjectLabel2: TLabel;
    ObjectLabel3: TLabel;
    NipGroupBox: TGroupBox;
    NipRB1: TRadioButton;
    NipRB2: TRadioButton;
    NipMaskEdit2: TMaskEdit;
    NipMaskEdit1: TMaskEdit;
    RoomEdit: TEdit;
    RoomLabel: TLabel;
    SaveDialog: TSaveDialog;
    IdBevel: TBevel;
    IdLabel: TLabel;
    procedure Kalendarz1Click(Sender: TObject);
    procedure PrevBitBtnClick(Sender: TObject);
    procedure NextBitBtnClick(Sender: TObject);
    procedure FieldChange(Sender: TObject);
    procedure PageConfirmBtnClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure SaveBitBtnClick(Sender: TObject);
    procedure CloseBitBtnClick(Sender: TObject);
    procedure Zamknji1Click(Sender: TObject);
    procedure Ustaldrukark1Click(Sender: TObject);
    procedure DrukujClick(Sender: TObject);
    procedure PrintBitBtnClick(Sender: TObject);
    procedure Editor1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure TabNotebookClick(Sender: TObject);
    procedure BeginDateEditChange(Sender: TObject);
    procedure BeginDateEditExit(Sender: TObject);
    procedure EndDateEditChange(Sender: TObject);
    procedure EndDateEditExit(Sender: TObject);
    procedure NipRB1Click(Sender: TObject);
    procedure NipRB2Click(Sender: TObject);
    procedure Export1Click(Sender: TObject);
  private
    { Private declarations }
    Modified:Boolean;
    SelPages:Array[0..MaxPages-1] of Boolean;

    {printing variables}
    PixelsInInchX:Integer;
    TenthsOfInchPixelsY:Integer;
    LineHeight:Integer;
    AmountPrinted:Integer;

    PPos:Integer;
    PrintSpace:Integer;
    Ry:TRyPrinter;

    function AllPagesConfirmed:Boolean;

    procedure InitFields;
    procedure ResetFields;
    procedure InitializeSiwz;

    procedure LoadFromFile(var F:File; Default:Boolean);
    procedure SaveToFile(var FH:File; Id,Desc:String; Default:Boolean);
    procedure ExportToTxt(FileName:String);
    procedure AddPage(var LP:Integer);
    procedure MakePrint;
    function GetTextHeight(p:PChar):Integer;
  public
    { Public declarations }
    DbDir:String;
    FileName:String;
    DefFileName:String;

    OpenMode:Byte; {New/Open}

    Id:TIdStr;             {Identifier of the tender}
    Description:TDescStr;  {SIWZ short description for retrieval}

  end;

var
  ZamWRDlg: TZamWRDlg;

procedure ZamowienieZWR(DBDir,FileName,FId,FDesc:String; OMode:Byte); export;

implementation

{$R *.DFM}
uses
  SysUtils,
  Msg2,
  Utils,
  Save,
  DateUtil,
  SiwzIni,
  Art71,
  PlCalDlg;

var
  Art71Array:Array[1..7] of Boolean;

procedure ZamowienieZWR(DBDir,FileName,FId,FDesc:String; OMode:Byte);
var
  Curs:Integer;
  Del:Boolean;
  x:Integer;
begin
  GetAllConfiguration;
  Application.HelpFile:=SiwzHelpFile;
  Art71Dlg:=TArt71Dlg.Create(Nil);
  if OMode=ONew
    then begin
      x:=Art71Dlg.ShowModal;
      Art71Array[1]:=Art71Dlg.CB1.State=cbChecked;
      Art71Array[2]:=Art71Dlg.CB2.State=cbChecked;
      Art71Array[3]:=Art71Dlg.CB3.State=cbChecked;
      Art71Array[4]:=Art71Dlg.CB4.State=cbChecked;
      Art71Array[5]:=Art71Dlg.CB5.State=cbChecked;
      Art71Array[6]:=Art71Dlg.CB6.State=cbChecked;
      Art71Array[7]:=Art71Dlg.CB7.State=cbChecked;
      if x<>mrOk
        then Exit;
    end;
  Curs:=Screen.Cursor;
  Screen.Cursor:=crHourGlass;
  AssignFile(FHandle,AddBackSlash(DbDir)+FileName);
  FileMode:=fmOpenReadWrite + fmShareDenyWrite;
  try
    if OMode=oOpen
      then Reset(FHandle,1)
    else if OMode=oNew
      then Rewrite(FHandle,1);
    ZamWRDlg:=TZamWRDlg.Create(Nil);
    ZamWRDlg.DbDir:=DbDir;
    ZamWRDlg.FileName:=FIleName;
    ZamWRDlg.OpenMode:=OMode;
    ZamWRDlg.Id:=FId;
    ZamWRDlg.Description:=FDesc;
    Screen.Cursor:=Curs;
    ZamWRDlg.ShowModal;
    ZamWRDlg.Free;
    Del:=FileSize(FHandle)<Length(VersionString+ZamFileHdr)+2;
    CloseFile(FHandle);
    if Del
      then DeleteFile(AddBackSlash(DbDir)+FileName);
  except
    on E:EInOutError do
      begin
        case E.ErrorCode of
          5: MessageDlg(wmFileAccessDenied ,mtWarning ,[mbOk] ,0);
          else MessageDlg(IntToStr(E.ErrorCode),mtWarning,[mbOk],0);
        end;{case}
      end;
  end;
  Art71Dlg.Free;
end;

procedure TZamWRDlg.FormActivate(Sender: TObject);
var
  SR:TSearchRec;
  i:Byte;
  s:String;
begin
  DefFileName:=DefaultFileName+'.'+ZamExt;
  Caption:=sZamowienieWRTitle;
  IdLabel.Caption:=Id;
  TitleLabel.Caption:=Description;

  TabNoteBook.PageIndex:=0;
  ZamScrollBox.ScrollInView(NameLabel);
  PrevBitBtn.Enabled:=FALSE;

  TitleLabel.Caption:=Description;

  with TabNotebook do
    for i:=0 to MaxPages-1 do
      begin
        SelPages[i]:=FALSE;
        if Pages[i][1]='#'
          then Pages[i]:=Copy(Pages[i],3,Length(Pages[i])-2);
      end;

  InitializeSiwz;

  if OpenMode=oNew
    then begin
      Art71Memo2.Clear;
      with Art71Dlg do
        begin
          if Art71Array[1]
            then Art71Memo2.Lines.Add('- '+L1_1.Caption+L1_2.Caption+L1_3.Caption+', ');
          if Art71Array[2]
            then Art71Memo2.Lines.Add('- '+L2_1.Caption+L2_2.Caption+', ');
          if Art71Array[3]
            then Art71Memo2.Lines.Add('- '+L3_1.Caption+L3_2.Caption+', ');
          if Art71Array[4]
            then Art71Memo2.Lines.Add('- '+L4_1.Caption+L4_2.Caption+', ');
          if Art71Array[5]
            then Art71Memo2.Lines.Add('- '+L5_1.Caption+L5_2.Caption+', ');
          if Art71Array[6]
            then Art71Memo2.Lines.Add('- '+L6_1.Caption+L6_2.Caption+L6_3.Caption+', ');
          if Art71Array[7]
            then Art71Memo2.Lines.Add('- '+L7_1.Caption+L7_2.Caption+', ');
          s:=Art71Memo2.Lines[Art71Memo2.Lines.Count-1];
          if s[Length(s)-1]=','
            then begin
              s[Length(s)-1]:='.';
              Art71Memo2.Lines[Art71Memo2.Lines.Count-1]:=s;
            end;
        end;
    end;

  Modified:=FALSE;
end;

procedure TZamWRDlg.ResetFields;
begin
  NipMaskEdit2.Enabled:=FALSE;
  NipRB1.Checked:=TRUE;
  NipRB2.Checked:=FALSE;
end;

procedure TZamWRDlg.InitFields;
begin
  NameMemo.Clear;
  StreetEdit.Clear;
  BldgEdit.Clear;
  RoomEdit.Clear;
  TownEdit.Clear;
  ZipMaskEdit.Clear;
  TelEdit.Clear;
  FaxEdit.Clear;
  TelexEdit.Clear;
  RegonMaskEdit.Clear;
  NipMaskEdit1.Clear;
  NipMaskEdit2.Clear;
  NipMaskEdit2.Enabled:=FALSE;
  NipRB1.Checked:=TRUE;
  NipRB2.Checked:=FALSE;
  ProwadMemo.Clear;
  Art71Memo1.Clear;
  Art71Memo2.Clear;
  ObjectMemo.Clear;
  ObjectMemo2.Clear;
  BeginDateEdit.Clear;
  EndDateEdit.Clear;
  OferentMemo1.Clear;
  OferentMemo2.Clear;
end;

procedure TZamWRDlg.InitializeSiwz;
var
  F:File;
begin
  if OpenMode=oOpen
    then begin
      InitFields;
      LoadFromFile(FHandle,FALSE);
    end
  else if FileExists(AddBackSlash(DbDir)+DefFileName)
    then begin
      if OpenMode<>oNew
        then MessageDlg(wmOpenDefaultFile,mtWarning,[mbOk],0);
      AssignFile(F,AddBackSlash(DbDir)+DefFileName);
      FileMode:=fmOpenReadWrite + fmShareDenyWrite;
      try
        Reset(F,1);
        InitFields;
        LoadFromFile(F,TRUE);
        CloseFile(F);
        EndDateEdit.Date:=Now;
        BeginDateEdit.Date:=Now;
      except
        on E:EInOutError do
          case E.ErrorCode of
            5: MessageDlg(wmFileAccessDenied ,mtWarning ,[mbOk] ,0);
            else MessageDlg(IntToStr(E.ErrorCode),mtWarning,[mbOk],0);
          end;
      end;
    end
  else begin
    MessageDlg(wmSiwzToBasicValues,mtWarning,[mbOk],0);
    ResetFields;
    EndDateEdit.Date:=Now;
    BeginDateEdit.Date:=Now;
  end;
end;

procedure TZamWRDlg.Kalendarz1Click(Sender: TObject);
begin
  CalendarForm.ShowModal;
end;

procedure TZamWRDlg.PrevBitBtnClick(Sender: TObject);
begin
  if TabNotebook.PageIndex>0
    then TabNotebook.PageIndex:=TabNotebook.PageIndex-1;
  PrevBitBtn.Enabled:= TabNotebook.PageIndex>0;
  NextBitBtn.Enabled:= TabNotebook.PageIndex<MaxPages-1;
end;

procedure TZamWRDlg.NextBitBtnClick(Sender: TObject);
begin
  if TabNotebook.PageIndex<MaxPages-1
    then TabNotebook.PageIndex:=TabNotebook.PageIndex+1;
  PrevBitBtn.Enabled:= TabNotebook.PageIndex>0;
  NextBitBtn.Enabled:= TabNotebook.PageIndex<MaxPages-1;
end;

procedure TZamWRDlg.FieldChange(Sender: TObject);
begin
  Modified:=TRUE;
  with TabNotebook do
    if SelPages[PageIndex]=TRUE
      then begin
        if Pages[PageIndex][1]='#'
          then Pages[PageIndex]:=Copy(ActivePage,3,Length(ActivePage)-2);
        SelPages[PageIndex]:=FALSE;
      end
end;

procedure TZamWRDlg.PageConfirmBtnClick(Sender: TObject);
begin
  Modified:=TRUE;
  with TabNotebook do
    begin
      if SelPages[PageIndex]=TRUE
        then begin
          if Pages[PageIndex][1]='#'
            then Pages[PageIndex]:=Copy(ActivePage,3,Length(ActivePage)-2);
          SelPages[PageIndex]:=FALSE;
        end
      else begin
          Pages[PageIndex]:=SelectionChar+' '+ActivePage;
          SelPages[PageIndex]:=TRUE;
      end;
    end;
end;

procedure TZamWRDlg.SaveBitBtnClick(Sender: TObject);
var
  F:File;
begin
  SaveDlg:=TSaveDlg.Create(ZamWRDlg);
  with SaveDlg do
    begin
      RadioGroup.ItemIndex:=0;
      ShowModal;
      if ModalResult=mrOk
        then begin
          case RadioGroup.ItemIndex of
            0: {Aktualna}
              begin
                Seek(FHandle,0);
                SaveToFile(FHandle,ID,Description,FALSE);
                Modified:=FALSE;
              end;
            1: {Nowa}
              begin
                NewSiwzDlg:=TNewSiwzDlg.Create(Self);
                NewSiwzDlg.NewExt:=ZamExt;
                if NewSiwzDlg.ShowModal=mrOk
                  then begin
                    try
                      AssignFile(F,AddBackSlash(DbDir)+NewSiwzDlg.NewFileName+'.'+ZamExt);
                      FileMode:=fmOpenReadWrite + fmShareDenyWrite;
                      Rewrite(F,1);
                      SaveToFile(F,NewSiwzDlg.NewIdEdit.Text,NewSiwzDlg.NewDescEdit.Text,TRUE);
                      CloseFile(F);
                    except
                      on E:EInOutError do
                        begin
                          case E.ErrorCode of
                            5: MessageDlg(wmFileAccessDenied ,mtWarning ,[mbOk] ,0);
                            else MessageDlg(IntToStr(E.ErrorCode),mtWarning,[mbOk],0);
                          end;{case}
                        end;
                    end;
                  end;
                NewSiwzDlg.Free;
              end;
            2: {Domyœlna}
              try
                AssignFile(F,AddBackSlash(DbDir)+DefaultFileName+'.'+ZamExt);
                FileMode:=fmOpenReadWrite + fmShareDenyWrite;
                Rewrite(F,1);
                SaveToFile(F,DefaultId,DefaultDesc,TRUE);
                CloseFile(F);
              except
                on E:EInOutError do
                  begin
                    case E.ErrorCode of
                      5: MessageDlg(wmFileAccessDenied ,mtWarning ,[mbOk] ,0);
                      else MessageDlg(IntToStr(E.ErrorCode),mtWarning,[mbOk],0);
                    end;{case}
                  end;
              end;
          end;{case}
        end;
    end;
  SaveDlg.Free;
end;

procedure TZamWRDlg.SaveToFile(var FH:File; Id,Desc:String; Default:Boolean);
var
  i:Byte;
begin
  try
    MakeFKey(ExtractFilePath(FileName));
    SaveString(VersionString+ZamFileHdr,FH);
    SaveInteger(FKey,FH);
    SaveString(Id,FH);
    SaveString(Desc,FH);
    if Default
      then for i:=0 to MaxPages-1 do
        SaveBoolean(DefSelPages[i],FH)
      else for i:=0 to MaxPages-1 do
        SaveBoolean(SelPages[i],FH);
      SaveMemo(NameMemo,FH);
      SaveEdit(StreetEdit,FH);
      SaveEdit(BldgEdit,FH);
      SaveEdit(RoomEdit,FH);
      SaveEdit(TownEdit,FH);
      SaveMaskEdit(ZipMaskEdit,FH);
      SaveEdit(TelEdit,FH);
      SaveEdit(FaxEdit,FH);
      SaveEdit(TelexEdit,FH);
      SaveMaskEdit(RegonMaskEdit,FH);
      SaveBoolean(NipRB1.Checked,FH);
      SaveBoolean(NipRB2.Checked,FH);
      SaveMaskEdit(NipMaskEdit1,FH);
      SaveMaskEdit(NipMaskEdit2,FH);
      SaveMemo(ProwadMemo,FH);
      SaveMemo(Art71Memo1,FH);
      SaveMemo(Art71Memo2,FH);
      SaveMemo(ObjectMemo,FH);
      SaveMemo(ObjectMemo2,FH);
      SaveString(BeginDateEdit.Text,FH);
      SaveString(EndDateEdit.Text,FH);
      SaveMemo(OferentMemo1,FH);
      SaveMemo(OferentMemo2,FH);
  except
    on E:EInOutError do
      MessageDlg(IntToStr(E.ErrorCode),mtWarning,[mbOk],0);
  end;
end;

procedure TZamWRDlg.LoadFromFile(var F:File; Default:Boolean);
var
  LId:String;
  LDesc:String;
  i:Integer;
  B:Boolean;
  SP:Array[0..MaxPages-1] of Boolean;
  s:String;
begin
  try
    MakeFKey(ExtractFilePath(FileName));
    LoadString(s,F);
    if s=VersionString+ZamFileHdr
      then begin
        LoadInteger(i,F);
        if i=FKey
          then begin
            LoadString(LId,F);
            LoadString(LDesc,F);
            if not Default
              then begin
                Description:=LDesc;
                Id:=LId;
              end;
            for i:=0 to MaxPages-1 do
              LoadBoolean(SP[i],F);
            LoadMemo(NameMemo,F);
            LoadEdit(StreetEdit,F);
            LoadEdit(BldgEdit,F);
            LoadEdit(RoomEdit,F);
            LoadEdit(TownEdit,F);
            LoadMaskEdit(ZipMaskEdit,F);
            LoadEdit(TelEdit,F);
            LoadEdit(FaxEdit,F);
            LoadEdit(TelexEdit,F);
            LoadMaskEdit(RegonMaskEdit,F);
            LoadBoolean(B,F);
            NipRB1.Checked:=B;
            LoadBoolean(B,F);
            NipRB2.Checked:=B;
            LoadMaskEdit(NipMaskEdit1,F);
            LoadMaskEdit(NipMaskEdit2,F);
            LoadMemo(ProwadMemo,F);
            LoadMemo(Art71Memo1,F);
            LoadMemo(Art71Memo2,F);
            LoadMemo(ObjectMemo,F);
            LoadMemo(ObjectMemo2,F);
            LoadString(s,F);
            BeginDateEdit.Date:=StrToDate(s);
            LoadString(s,F);
            EndDateEdit.Date:=StrToDate(s);
            LoadMemo(OferentMemo1,F);
            LoadMemo(OferentMemo2,F);
            if not Default
              then for i:=0 to MaxPages-1 do
                begin
                  SelPages[i]:=SP[i];
                  if SelPages[i]
                    then TabNoteBook.Pages[i]:=SelectionChar+' '+TabNoteBook.Pages[i];
                end;
          end;
      end;
  except
    on E:EInOutError do
      begin
        case E.ErrorCode of
          100: MessageDlg(wmReadBeyondEnd ,mtWarning ,[mbOk] ,0);
          else MessageDlg(IntToStr(E.ErrorCode),mtWarning,[mbOk],0);
        end;
      end;
  end;
end;

procedure TZamWRDlg.CloseBitBtnClick(Sender: TObject);
begin
  if Modified
    then begin
       if MessageDlg('Zachowaæ SIWZ ?',mtConfirmation,[mbYes,mbNo],0)=mrYes
         then SaveBitBtnClick(Self);
    end;
  Close;
end;

procedure TZamWRDlg.Zamknji1Click(Sender: TObject);
begin
  CloseBitBtnClick(Sender);
end;

procedure TZamWRDlg.Ustaldrukark1Click(Sender: TObject);
begin
  PrinterSetupDlg.Execute;
end;

procedure TZamWRDlg.AddPage(var LP:Integer);
begin
  LP:=Ry.YTOff;
  Ry.NewPage;
{$IFDEF DEMO}
Ry.WriteDemo(LP);
{$ENDIF}
end;

function TZamWRDlg.GetTextHeight(p:PChar):Integer;
begin
  with Ry do
    Result:=MemoOut(Rect(XLOff+Xmm(2),0,XROff-Xmm(2),10), p, False, True);
end;

procedure TZamWRDlg.MakePrint;
var
  p : PChar;
  x:LongInt;
  LP:Integer; {Line position}
  FullPage:Boolean;
  s:String;
begin
  with Ry do
    begin
      Orientation:=poPortrait;
      NewJob;
      SetMinMargins(Xmm(20),Ymm(15),Xmm(15),Ymm(10));
      LP:=YTOff;
      Font.Name:='Times New Roman CE';
      Font.Size:=16;
      Font.Style:=[fsBold,fsUnderLine];
      X:=MemoOut(Rect(XLOff+Xmm(2),LP,XROff-Xmm(2),10), sSIWZ, False, False);
      LP:=LP+X+Ymm(3);
      Font.Size:=14;
      Font.Style:=[fsBold];
      X:=MemoOut(Rect(XLOff+Xmm(2),LP,XROff-Xmm(2),10), sZamowienieWRTitle, False, False);
      LP:=LP+X+Ymm(5);
      Font.Size:=10;
      Font.Style:=[];
      PrintSpace:=YBOff-Ymm(35);
      p:=StrAlloc(Length(Description)+1);
      StrPCopy(p,Description);
      if GetTextHeight(p)+LP+Ymm(1)>PrintSpace
        then AddPage(LP);
      X:=MemoOut(Rect(XLOff+Xmm(2),LP,XROff-Xmm(2),10), p, False, False);
      StrDispose(p);
      LP:=LP+X+Ymm(1);
      p:=StrAlloc(Length(sId)+Length(Id)+1);
      StrPCopy(p,sId+Id);
      if GetTextHeight(p)+LP+Ymm(1)>PrintSpace
        then AddPage(LP);
      X:=MemoOut(Rect(XLOff+Xmm(2),LP,XROff-Xmm(2),10), p, False, False);
      StrDispose(p);
      LP:=LP+X+Ymm(10);
{$IFDEF DEMO}
WriteDemo(LP);
{$ENDIF}
      p:=StrAlloc(Length(NameLabel.Caption)+1);
      StrPCopy(p,NameLabel.Caption);
      if GetTextHeight(p)+LP>PrintSpace
        then AddPage(LP);
      X:=MemoOut(Rect(XLOff+Xmm(2),LP,XROff-Xmm(2),10), p, False, False);
      StrDispose(p);
      LP:=LP+X+Ymm(1);
      p:=StrAlloc(NameMemo.GetTextLen + 1);
      NameMemo.GetTextBuf(p, NameMemo.GetTextLen+1);
      if GetTextHeight(p)+LP>PrintSpace
        then AddPage(LP);
      X:=MemoOut(Rect(XLOff+Xmm(2),LP,XROff-Xmm(2),10), p, False, False);
      LP:=LP+X+Ymm(3);
      StrDispose(p);
      if GetTextHeight(p)+LP>PrintSpace
        then AddPage(LP);
      X:=MemoOut(Rect(XLOff+Xmm(2),LP,XROff-Xmm(2),10), sAdres, False, False);
      LP:=LP+X+Ymm(1);
      p:=StrAlloc(Length(StreetEdit.Text)+Length(BldgEdit.Text)+Length(sRoom)+Length(RoomEdit.Text)+
                  Length(TownEdit.Text)+Length(ZipMaskEdit.Text)+4);
      StrPCopy(p,StreetEdit.Text+' '+BldgEdit.Text+sRoom+RoomEdit.Text+' '+TownEdit.Text+' '+ZipMaskEdit.Text);
      if GetTextHeight(p)+LP>PrintSpace
        then AddPage(LP);
      X:=MemoOut(Rect(XLOff+Xmm(2),LP,XROff-Xmm(2),10), p, False, False);
      StrDispose(p);
      LP:=LP+X+Ymm(1);
      if TelEdit.Text<>''
        then begin
          p:=StrAlloc(Length(sTel)+Length(TelEdit.Text)+1);
          StrPCopy(p,sTel+TelEdit.Text);
          if GetTextHeight(p)+LP>PrintSpace
            then AddPage(LP);
          X:=MemoOut(Rect(XLOff+Xmm(2),LP,XROff-Xmm(2),10), p, False, False);
          StrDispose(p);
          LP:=LP+X+Ymm(1);
        end;
{$IFDEF DEMO}
WriteDemo(LP);
{$ENDIF}
      if FaxEdit.Text<>''
        then begin
          p:=StrAlloc(Length(sFax)+Length(FaxEdit.Text)+1);
          StrPCopy(p,sFax+FaxEdit.Text);
          if GetTextHeight(p)+LP>PrintSpace
            then AddPage(LP);
          X:=MemoOut(Rect(XLOff+Xmm(2),LP,XROff-Xmm(2),10), p, False, False);
          StrDispose(p);
          LP:=LP+X+Ymm(1);
        end;
      if TelexEdit.Text<>''
        then begin
          p:=StrAlloc(Length(sTelex)+Length(TelexEdit.Text)+1);
          StrPCopy(p,sTelex+TelexEdit.Text);
          if GetTextHeight(p)+LP>PrintSpace
            then AddPage(LP);
          X:=MemoOut(Rect(XLOff+Xmm(2),LP,XROff-Xmm(2),10), p, False, False);
          StrDispose(p);
          LP:=LP+X+Ymm(1);
        end;
      LP:=LP+Ymm(2);
      p:=StrAlloc(Length(sRegon)+Length(RegonMaskEdit.Text)+1);
      StrPCopy(p,sRegon+RegonMaskEdit.Text);
      if GetTextHeight(p)+LP>PrintSpace
        then AddPage(LP);
      X:=MemoOut(Rect(XLOff+Xmm(2),LP,XROff-Xmm(2),10), p, False, False);
      StrDispose(p);
      LP:=LP+X+Ymm(3);
      if NipRB1.Checked
        then s:=NipMaskEdit1.Text
      else if NipRB2.Checked
        then s:=NipMaskEdit2.Text;
      p:=StrAlloc(Length(sNip)+Length(s)+1);
      StrPCopy(p,sNip+s);
      if GetTextHeight(p)+LP>PrintSpace
        then AddPage(LP);
      X:=MemoOut(Rect(XLOff+Xmm(2),LP,XROff-Xmm(2),10), p, False, False);
      StrDispose(p);
      LP:=LP+X+Ymm(3);
      p:=StrAlloc(Length(ProwadLabel.Caption)+1);
      StrPCopy(p,ProwadLabel.Caption);
      if GetTextHeight(p)+LP>PrintSpace
        then AddPage(LP);
      X:=MemoOut(Rect(XLOff+Xmm(2),LP,XROff-Xmm(2),10), p, False, False);
      StrDispose(p);
      LP:=LP+X+Ymm(1);
      p:=StrAlloc(ProwadMemo.GetTextLen + 1);
      ProwadMemo.GetTextBuf(p, ProwadMemo.GetTextLen+1);
      if GetTextHeight(p)+LP>PrintSpace
        then AddPage(LP);
      X:=MemoOut(Rect(XLOff+Xmm(2),LP,XROff-Xmm(2),10), p, False, False);
      LP:=LP+X+Ymm(3);
      StrDispose(p);
      p:=StrAlloc(Art71Memo1.GetTextLen + 1);
      Art71Memo1.GetTextBuf(p, Art71Memo1.GetTextLen+1);
      if GetTextHeight(p)+LP>PrintSpace
        then AddPage(LP);
      X:=MemoOut(Rect(XLOff+Xmm(2),LP,XROff-Xmm(2),10), p, False, False);
      LP:=LP+X+Ymm(1);
      StrDispose(p);
      p:=StrAlloc(Art71Memo2.GetTextLen + 1);
      Art71Memo2.GetTextBuf(p, Art71Memo2.GetTextLen+1);
      if GetTextHeight(p)+LP>PrintSpace
        then AddPage(LP);
      X:=MemoOut(Rect(XLOff+Xmm(2),LP,XROff-Xmm(2),10), p, False, False);
      LP:=LP+X+Ymm(3);
      StrDispose(p);
      p:=StrAlloc(Length(BeginLabel.Caption)+Length(BeginDateEdit.Text)+1);
      StrPCopy(p,BeginLabel.Caption+BeginDateEdit.Text);
      if GetTextHeight(p)+LP>PrintSpace
        then AddPage(LP);
      X:=MemoOut(Rect(XLOff+Xmm(2),LP,XROff-Xmm(2),10), p, False, False);
      StrDispose(p);
      LP:=LP+X+Ymm(1);
      p:=StrAlloc(Length(EndLabel.Caption)+Length(EndDateEdit.Text)+1);
      StrPCopy(p,EndLabel.Caption+EndDateEdit.Text);
      if GetTextHeight(p)+LP>PrintSpace
        then AddPage(LP);
      X:=MemoOut(Rect(XLOff+Xmm(2),LP,XROff-Xmm(2),10), p, False, False);
      StrDispose(p);
      LP:=LP+X+Ymm(3);
{$IFDEF DEMO}
WriteDemo(LP);
{$ENDIF}
      p:=StrAlloc(Length(ObjectLabel.Caption)+1);
      StrPCopy(p,ObjectLabel.Caption);
      if GetTextHeight(p)+LP>PrintSpace
        then AddPage(LP);
      X:=MemoOut(Rect(XLOff+Xmm(2),LP,XROff-Xmm(2),10), p, False, False);
      StrDispose(p);
      LP:=LP+X+Ymm(1);
      p:=StrAlloc(ObjectMemo.GetTextLen + 1);
      ObjectMemo.GetTextBuf(p, ObjectMemo.GetTextLen+1);
      if GetTextHeight(p)+LP>PrintSpace
        then AddPage(LP);
      X:=MemoOut(Rect(XLOff+Xmm(2),LP,XROff-Xmm(2),10), p, False, False);
      LP:=LP+X+Ymm(3);
      StrDispose(p);
      p:=StrAlloc(Length(ObjectLabel2.Caption)+Length(ObjectLabel3.Caption)+1);
      StrPCopy(p,ObjectLabel2.Caption+ObjectLabel3.Caption);
      if GetTextHeight(p)+LP>PrintSpace
        then AddPage(LP);
      X:=MemoOut(Rect(XLOff+Xmm(2),LP,XROff-Xmm(2),10), p, False, False);
      StrDispose(p);
      LP:=LP+X+Ymm(1);
      p:=StrAlloc(ObjectMemo2.GetTextLen + 1);
      ObjectMemo2.GetTextBuf(p, ObjectMemo2.GetTextLen+1);
      if GetTextHeight(p)+LP>PrintSpace
        then AddPage(LP);
      X:=MemoOut(Rect(XLOff+Xmm(2),LP,XROff-Xmm(2),10), p, False, False);
      LP:=LP+X+Ymm(3);
      StrDispose(p);
      p:=StrAlloc(Length(OferentLabel1.Caption)+1);
      StrPCopy(p,OferentLabel1.Caption);
      if GetTextHeight(p)+LP>PrintSpace
        then AddPage(LP);
      X:=MemoOut(Rect(XLOff+Xmm(2),LP,XROff-Xmm(2),10), p, False, False);
      StrDispose(p);
      LP:=LP+X+Ymm(1);
      p:=StrAlloc(OferentMemo1.GetTextLen + 1);
      OferentMemo1.GetTextBuf(p, OferentMemo1.GetTextLen+1);
      if GetTextHeight(p)+LP>PrintSpace
        then AddPage(LP);
      X:=MemoOut(Rect(XLOff+Xmm(2),LP,XROff-Xmm(2),10), p, False, False);
      LP:=LP+X+Ymm(3);
      StrDispose(p);
      p:=StrAlloc(Length(OferentLabel2.Caption)+1);
      StrPCopy(p,OferentLabel2.Caption);
      if GetTextHeight(p)+LP>PrintSpace
        then AddPage(LP);
      X:=MemoOut(Rect(XLOff+Xmm(2),LP,XROff-Xmm(2),10), p, False, False);
      StrDispose(p);
      LP:=LP+X+Ymm(1);
      p:=StrAlloc(OferentMemo2.GetTextLen + 1);
      OferentMemo2.GetTextBuf(p, OferentMemo2.GetTextLen+1);
      if GetTextHeight(p)+LP>PrintSpace
        then AddPage(LP);
      X:=MemoOut(Rect(XLOff+Xmm(2),LP,XROff-Xmm(2),10), p, False, False);
      LP:=LP+X+Ymm(3);
      StrDispose(p);
{$IFDEF DEMO}
WriteDemo(LP);
{$ENDIF}
      PutPageNums(((XROff-XLOff) div 2) +XLOff,YBOff-Ymm(10),taCenter);
    end;
end;

procedure TZamWRDlg.DrukujClick(Sender: TObject);
begin
  PrintBitBtnClick(Sender);
end;

procedure TZamWRDlg.PrintBitBtnClick(Sender: TObject);
var
  Cur:Integer;
begin
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

procedure TZamWRDlg.Editor1Click(Sender: TObject);
var
  Cur:Integer;
begin
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

function TZamWRDlg.AllPagesConfirmed:Boolean;
var
  i:Byte;
  B:Boolean;
begin
  B:=TRUE;
  for i:=0 to MaxPages-1 do
    if not SelPages[i]
      then B:=FALSE;
  AllPagesConfirmed:=B;
end;

procedure TZamWRDlg.BitBtn2Click(Sender: TObject);
begin
  Application.HelpContext(2005);
end;

procedure TZamWRDlg.TabNotebookClick(Sender: TObject);
begin
  PrevBitBtn.Enabled:= TabNotebook.PageIndex>0;
  NextBitBtn.Enabled:= TabNotebook.PageIndex<MaxPages-1;
end;

procedure TZamWRDlg.BeginDateEditExit(Sender: TObject);
begin
  if not CheckDate(BeginDateEdit.Text,BeginDateEdit.DateFormat)
    then MessageDlg(wmIncorrectDate,mtWarning,[mbOk],0);
end;

procedure TZamWRDlg.BeginDateEditChange(Sender: TObject);
begin
  EndDateEditChange(Sender);
end;

procedure TZamWRDlg.EndDateEditChange(Sender: TObject);
var
  by,bm,bd,
  ey,em,ed:Word;
  Ok:Boolean;
begin
  if CheckDate(BeginDateEdit.Text,BeginDateEdit.DateFormat) and
     CheckDate(EndDateEdit.Text,EndDateEdit.DateFormat)
    then begin
      try
        DecodeDate(StrToDate(BeginDateEdit.Text),by,bm,bd);
        DecodeDate(StrToDate(EndDateEdit.Text),ey,em,ed);
        Ok := (JulianDate(ey,em,ed)-JulianDate(by,bm,bd)) >= 0;
        if not Ok
          then begin
            MessageDlg(wmEndDateBeforeStartDate,mtWarning,[mbOk],0);

          end;
      finally

      end;
    end;
  FieldChange(Sender);
end;

procedure TZamWRDlg.EndDateEditExit(Sender: TObject);
begin
  if not CheckDate(EndDateEdit.Text,EndDateEdit.DateFormat)
    then MessageDlg(wmIncorrectDate,mtWarning,[mbOk],0);
end;

procedure TZamWRDlg.NipRB1Click(Sender: TObject);
begin
  NipMaskEdit1.Enabled:=TRUE;
  NipMaskEdit1.Color:=clAqua;
  NipMaskEdit2.Enabled:=FALSE;
  NipMaskEdit2.Color:=clGray;
end;

procedure TZamWRDlg.NipRB2Click(Sender: TObject);
begin
  NipMaskEdit1.Enabled:=FALSE;
  NipMaskEdit1.Color:=clGray;
  NipMaskEdit2.Enabled:=TRUE;
  NipMaskEdit2.Color:=clAqua;
end;

procedure TZamWRDlg.ExportToTxt(FileName:String);
var
  FH:TextFile;
  p,q:PChar;
  i:LongInt;
  s,s1,s2:String;
begin
  AssignFile(FH,FileName);
  FileMode:=fmOpenReadWrite + fmShareDenyWrite;
  try
    Rewrite(FH);
    try
  { Zamaw. }
      ExportString(Description,FH);
      ExportString(Id,FH);
      ExportMemo(NameMemo,FH);
      ExportEdit(StreetEdit,FH);
      ExportEdit(TownEdit,FH);
      ExportEdit(BldgEdit,FH);
      ExportEdit(RoomEdit,FH);
      ExportMaskEdit(ZipMaskEdit,FH);
      ExportString(sTel+TelEdit.Text,FH);
      ExportString(sFax+FaxEdit.Text,FH);
      ExportString(sTelex+TelexEdit.Text,FH);
      ExportString(sRegon+RegonMaskEdit.Text,FH);
      if NipRB1.Checked
        then ExportString(sNip+NipMaskEdit1.Text,FH)
      else if NipRB2.Checked
        then ExportString(sNip+NipMaskEdit2.Text,FH);
      ExportString(ProwadLabel.Caption,FH);
      ExportMemo(ProwadMemo,FH);
      ExportMemo(Art71Memo1,FH);
      ExportMemo(Art71Memo2,FH);
  {Termin}
      ExportString(BeginLabel.Caption+BeginDateEdit.Text,FH);
      ExportString(EndLabel.Caption+EndDateEdit.Text,FH);
  {Przedmiot zam.}
      ExportString(ObjectLabel.Caption,FH);
      ExportMemo(ObjectMemo,FH);
      ExportString(ObjectLabel2.Caption,FH);
      ExportString(ObjectLabel3.Caption,FH);
      ExportMemo(ObjectMemo2,FH);
  {Offer}
      ExportString(OferentLabel1.Caption,FH);
      ExportMemo(OferentMemo1,FH);
      ExportString(OferentLabel2.Caption,FH);
      ExportMemo(OferentMemo2,FH);
    finally
      CloseFile(FH);
    end;
  except
    on E:EInOutError do
      case E.ErrorCode of
        5: MessageDlg(wmFileAccessDenied ,mtWarning ,[mbOk] ,0);
        else MessageDlg(IntToStr(E.ErrorCode),mtWarning,[mbOk],0);
      end;
  end;
end;

procedure TZamWRDlg.Export1Click(Sender: TObject);
begin
  if SaveDialog.Execute
    then ExportToTxt(SaveDialog.FileName);
end;

end.
