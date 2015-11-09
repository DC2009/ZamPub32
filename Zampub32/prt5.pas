unit Prt5;

interface

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, StdCtrls, Mask, Buttons, ExtCtrls, Menus,
  Grids, Spin,
  WinCrt,
  Printers,
  SkOk,
  RPrev,
  SiwzIni,
  UserUnit,
  IntDate,
  Oferent,
  Timeedit,
  NumInp, Tabs, Sk;

const
  CCol=0;
  DCol=1;
  ECol=2;
  WCol=3;

  ZamFilter='Zamówienie z wolnej rêki|*.';

{Pages}
  page1='Zamawiaj¹cy';
  page2='Termin realizacji';
  page3='Przedmiot zamówienia';
  page4='Wykaz oferenta';

  DefSelPages:Array[1..Prt5MaxPages] of Boolean=(FALSE,FALSE,FALSE,FALSE);

type
  TPrt5Dlg = class(TForm)
    MainMenu1: TMainMenu;
    Plik: TMenuItem;
    Ustawieniedrukarki: TMenuItem;
    Export: TMenuItem;
    N1: TMenuItem;
    Zamknij: TMenuItem;
    PrintDlg: TPrintDialog;
    PrinterSetupDlg: TPrinterSetupDialog;
    Drukuj1: TMenuItem;
    Przegl1: TMenuItem;
    N4: TMenuItem;
    Save1: TMenuItem;
    SaveAs1: TMenuItem;
    Opcje1: TMenuItem;
    Suwaki1: TMenuItem;
    Drukowanie1: TMenuItem;
    Brak1: TMenuItem;
    Pionowe1: TMenuItem;
    Poziome1: TMenuItem;
    Oba1: TMenuItem;
    Nagwki1: TMenuItem;
    Ident1: TMenuItem;
    Wartzam1: TMenuItem;
    Pomoc1: TMenuItem;
    Okna1: TMenuItem;
    Zamawiajcy1: TMenuItem;
    Termin1: TMenuItem;
    Przedmiot1: TMenuItem;
    Oferent1: TMenuItem;
    SaveDialog: TSaveDialog;
    Panel1: TPanel;
    Label1: TLabel;
    IdEdit: TEdit;
    Label2: TLabel;
    DescEdit: TEdit;
    Panel2: TPanel;
    CloseBtn: TBitBtn;
    SaveBtn: TBitBtn;
    PrintBitBtn: TBitBtn;
    PreviewBtn: TBitBtn;
    HelpBtn: TBitBtn;
    Panel3: TPanel;
    PrevBitBtn: TBitBtn;
    NextBitBtn: TBitBtn;
    AddBitBtn: TBitBtn;
    Panel4: TPanel;
    TabSet: TTabSet;
    Opis1: TMenuItem;
    Notebook: TNotebook;
    ScrollBox2: TScrollBox;
    BeginLabel: TLabel;
    EndLabel: TLabel;
    Page2Button: TButton;
    BeginDate: TIntDate;
    EndDate: TIntDate;
    Sk: TSmartKey;
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
    RoomLabel: TLabel;
    NipGroupBox: TGroupBox;
    NipRB1: TRadioButton;
    NipRB2: TRadioButton;
    NipMaskEdit2: TMaskEdit;
    NipMaskEdit1: TMaskEdit;
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
    Art71Memo1: TMemo;
    RoomEdit: TEdit;
    Art71Memo2: TMemo;
    ProwadMemo: TMemo;
    ScrollBox3: TScrollBox;
    ObjectLabel: TLabel;
    ObjectLabel2: TLabel;
    ObjectLabel3: TLabel;
    ObjectMemo: TMemo;
    Page3Button: TButton;
    ObjectMemo2: TMemo;
    ScrollBox4: TScrollBox;
    OferentLabel1: TLabel;
    OferentLabel2: TLabel;
    Page4Button: TButton;
    OferentMemo1: TMemo;
    OferentMemo2: TMemo;
    procedure FormCreate(Sender: TObject);
    procedure PrevBitBtnClick(Sender: TObject);
    procedure NextBitBtnClick(Sender: TObject);
    procedure PrintBitBtnClick(Sender: TObject);
    procedure SaveBtnClick(Sender: TObject);
    procedure PageConfirmButtonClick(Sender: TObject);
    procedure FieldChange(Sender: TObject);
    procedure CloseBtnClick(Sender: TObject);
    procedure UstawieniedrukarkiClick(Sender: TObject);
    procedure ZamknijClick(Sender: TObject);
    procedure Drukuj1Click(Sender: TObject);
    procedure Przegl1Click(Sender: TObject);
    procedure NipRB1Click(Sender: TObject);
    procedure NipRB2Click(Sender: TObject);
    procedure ExportClick(Sender: TObject);
    procedure IdEditChange(Sender: TObject);
    procedure SuwakiClick(Sender: TObject);
    procedure TabSetClick(Sender: TObject);
    procedure OknaClick(Sender: TObject);
    procedure Save1Click(Sender: TObject);
    procedure SaveAs1Click(Sender: TObject);
    procedure Nagwki1Click(Sender: TObject);
    procedure Opis1Click(Sender: TObject);
    procedure Ident1Click(Sender: TObject);
    procedure Wartzam1Click(Sender: TObject);
  private
    { Private declarations }
    Modified:Boolean;
    SelPages:Array[0..Prt5MaxPages-1] of Boolean;
    FilePwd:String;
    Phase:Byte;

    PPos:Integer;
    PrintSpace:Integer;
    Ry:TRyPrinter;

    procedure ClearTabTag;
    procedure MakeZamawPrint(var LP:Integer);
    procedure MakeTerminPrint(var LP:Integer);
    procedure MakePrzedmiotPrint(var LP:Integer);
    procedure MakeOferentPrint(var LP:Integer);
    procedure MakePrint;
    procedure InitializeSiwz;
    procedure SiwzClose;
    procedure ExportToTxt(FileName:String);
  public
    { Public declarations }
    TenderType:Byte;
    FileName:String;
    FileIsOpen:Boolean;
    PrefKrajowe:Boolean;

    OpenMode:Byte; {New/Open}

    AmountLevel:Integer;   {cost levels, see SiwzIni}
    ObjectKind:Integer;     {Dostawa / Us³ugi / Roboty bud.}
    AmountPLN:Real;    {cost}

    WhereAdd:TObject;
    procedure SaveToFile(FileName:String);
    procedure LoadFromFile(FileName:String);
  end;

procedure Przetarg5(AFileName:String;APrt:Byte; PLN:Real;
                    ALevel:Integer; OKind:Byte; APrefKraj:Boolean); export;

implementation

{$R *.DFM}

uses
  Prt1Ini,
  Msg2,
  Art71,
  Utils;

procedure Przetarg5(AFileName:String;APrt:Byte;
                               PLN:Real; ALevel:Integer;
                               OKind:Byte; APrefKraj:Boolean);
var
  Curs:Integer;
  Del:Boolean;
  Prt5Dlg: TPrt5Dlg;
  s:String;
begin
  Curs:=Screen.Cursor;
  Screen.Cursor:=crHourGlass;
  GetAllConfiguration;
  Application.HelpFile:=SiwzHelpFile;
  FileMode:=fmOpenReadWrite + fmShareDenyWrite;
{  Art71Dlg:=TArt71Dlg.Create(Application);
  Screen.Cursor:=Curs;
  Art71Dlg.ShowModal;
  Screen.Cursor:=crHourGlass;}
  Prt5Dlg:=TPrt5Dlg.Create(Application);
  if AFileName=''
    then begin
      Art71Dlg:=TArt71Dlg.Create(Application);
      Screen.Cursor:=Curs;
      Art71Dlg.ShowModal;
      Prt5Dlg.Art71Memo2.Clear;
      with Art71Dlg do
        begin
          if CB1.Checked
            then Prt5Dlg.Art71Memo2.Lines.Add('- '+L1_1.Caption+L1_2.Caption+L1_3.Caption+', ');
          if CB2.Checked
            then Prt5Dlg.Art71Memo2.Lines.Add('- '+L2_1.Caption+L2_2.Caption+', ');
          if CB3.Checked
            then Prt5Dlg.Art71Memo2.Lines.Add('- '+L3_1.Caption+L3_2.Caption+', ');
          if CB4.Checked
            then Prt5Dlg.Art71Memo2.Lines.Add('- '+L4_1.Caption+L4_2.Caption+', ');
          if CB5.Checked
            then Prt5Dlg.Art71Memo2.Lines.Add('- '+L5_1.Caption+L5_2.Caption+', ');
          if CB6.Checked
            then Prt5Dlg.Art71Memo2.Lines.Add('- '+L6_1.Caption+L6_2.Caption+L6_3.Caption+', ');
          if CB7.Checked
            then Prt5Dlg.Art71Memo2.Lines.Add('- '+L7_1.Caption+L7_2.Caption+', ');
          s:=Prt5Dlg.Art71Memo2.Lines[Prt5Dlg.Art71Memo2.Lines.Count-1];
          if s[Length(s)-1]=','
            then begin
              s[Length(s)-1]:='.';
              Prt5Dlg.Art71Memo2.Lines[Prt5Dlg.Art71Memo2.Lines.Count-1]:=s;
            end;
        end;
      Art71Dlg.Free;
      Screen.Cursor:=crHourGlass;
    end;
  with Prt5Dlg do
    begin
      FileName:=AFileName;
      if AFileName=''
        then OpenMode:=oNew
        else OpenMode:=oOpen;
      AmountPLN:=PLN;
      AmountLevel:=ALevel;
      ObjectKind:=OKind;
      TenderType:=APrt;
      PrefKrajowe:=APrefKraj;
      InitializeSiwz;

      Screen.Cursor:=Curs;
      ShowModal;
      Free;
    end;
end;

procedure TPrt5Dlg.FormCreate(Sender: TObject);
var
  i:Byte;
begin
  FilePwd:=LoadFilePwd(AddBackSlash(ProgramDir)+SecurityFileName);
  Menu:=MainMenu1;
  OpenMode:=oNew;
  AmountLevel:=-1;
  AmountPLN:=-1;
  ObjectKind:=-1;
  FileIsOpen:=TRUE;
  Phase:=0;

{Reset TabNotebook pages}
  with TabSet do
    for i:=0 to Prt5MaxPages-1 do
      begin
        TabSet.TabIndex:=i;
        ClearTabTag;
      end;

  NoteBook.PageIndex:=0;
  TabSet.TabIndex:=0;

  PrevBitBtn.Enabled:=FALSE;
  AddBitBtn.Enabled:=FALSE;
end;

procedure TPrt5Dlg.InitializeSiwz;
var
  F:File;
begin
  NipMaskEdit2.Enabled:=FALSE;
  NipRB1.Checked:=TRUE;
  NipRB2.Checked:=FALSE;
  Caption:=sZamowienieWRTitle;
  SuwakiClick(Oba1);
  if OpenMode=oOpen
    then begin
      ClearPrt5Fields(Self);
      LoadFromFile(FileName);
    end
    else begin
      BeginDate.EditDate:=Now;
      EndDate.EditDate:=Now;
    end;
  Modified:=FALSE;
end;

procedure TPrt5Dlg.PrevBitBtnClick(Sender: TObject);
begin
  PrevBitBtn.Enabled:= Notebook.PageIndex>0;
  NextBitBtn.Enabled:= Notebook.PageIndex<Prt5MaxPages-1;
  if PrevBitBtn.Enabled
    then Notebook.PageIndex:=Notebook.PageIndex-1;
  TabSet.TabIndex:=Notebook.PageIndex;
end;

procedure TPrt5Dlg.NextBitBtnClick(Sender: TObject);
begin
  PrevBitBtn.Enabled:= Notebook.PageIndex>0;
  NextBitBtn.Enabled:= Notebook.PageIndex<Prt5MaxPages-1;
  if NextBitBtn.Enabled
    then Notebook.PageIndex:=Notebook.PageIndex+1;
  TabSet.TabIndex:=Notebook.PageIndex;
end;

{Date fields}

procedure TPrt5Dlg.SaveBtnClick(Sender: TObject);
begin
{$IFDEF NONET}
  if not SmartKeyOk(Sk,SkData)
    then Exit;
{$ENDIF}
  if FileName=''
    then with SaveDialog do
      begin
        case TenderType of
          ttZam:
            begin
              DefaultExt:=ZamExt;
              Filter:=ZamFilter+ZamExt;
            end;
        end;{case}
        if Execute
          then begin
            SaveToFile(FileName);
          end;
      end
    else SaveToFile(FileName);
end;

procedure TPrt5Dlg.SaveToFile(FileName:String);
var
  FH:File;
  i:Byte;
  Cur:Integer;
  FileHdr:String;
  Scroll:TScrollStyle;
begin
  Cur:=Screen.Cursor;
  Screen.Cursor:=crHourGlass;
  Scroll:=ProwadMemo.ScrollBars;
  SuwakiClick(Oba1);
  AssignFile(FH,FileName);
  try
    Rewrite(FH,1);
    try
        FileHdr:=ZamFileHdr;
        SeedKey:=SKey;
        SaveString(VersionString+FileHdr,FH);
        SaveString(FilePwd,FH);
        MakeCodeKey(FilePwd);
        SaveString(IdEdit.Text,FH);
        SaveString(DescEdit.Text,FH);
        SaveInteger(AmountLevel,FH);
        SaveInteger(ObjectKind,FH);
        SaveReal(AmountPLN,FH);
        SaveBoolean(PrefKrajowe,FH);
        SaveByte(Phase,FH);
        for i:=0 to Prt5MaxPages-1 do
          SaveBoolean(SelPages[i],FH);
    { Zamaw. }
        SaveMemo(NameMemo,FH);
        SaveEdit(StreetEdit,FH);
        SaveEdit(TownEdit,FH);
        SaveEdit(BldgEdit,FH);
        SaveEdit(RoomEdit,FH);
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
    {Termin}
        SaveDateTime(BeginDate.EditDate,FH);
        SaveDateTime(EndDate.EditDate,FH);
    {Przedmiot}
        SaveMemo(ObjectMemo,FH);
        SaveMemo(ObjectMemo2,FH);
    {Oferent}
        SaveMemo(OferentMemo1,FH);
        SaveMemo(OferentMemo2,FH);
        Modified:=FALSE;
    finally
      CloseFile(FH);
    end;
  except
    on E:EInOutError do
      MessageDlg(IntToStr(E.ErrorCode),mtWarning,[mbOk],0);
  end;
  case Scroll of
    ssNone,ssVertical: SuwakiClick(Brak1);
    ssBoth,ssHorizontal: SuwakiClick(Oba1);
  end;{case}
  Screen.Cursor:=Cur;
end;

procedure TPrt5Dlg.LoadFromFile(FileName:String);
var
  i:Integer;
  B:Boolean;
  SP:Array[0..Prt5MaxPages-1] of Boolean;
  T:Integer;
  s:String;
  DT:TDateTime;
  FH:File;
  FileHdr:String;
begin
  AssignFile(FH,FileName);
  try
    Reset(FH,1);
    try
      FileHdr:=ZamFileHdr;
      SeedKey:=SKey;
      LoadString(s,FH);
      if s=VersionString+FileHdr
        then begin
          LoadString(s,FH);
          if (s=FilePwd)
            then begin
              MakeCodeKey(FilePwd);
              LoadEdit(IdEdit,FH);
              LoadEdit(DescEdit,FH);
              LoadInteger(AmountLevel,FH);
              LoadInteger(ObjectKind,FH);
              LoadReal(AmountPLN,FH);
              LoadBoolean(PrefKrajowe,FH);
              LoadByte(Phase,FH);
              for i:=0 to Prt5MaxPages-1 do
                LoadBoolean(SP[i],FH);
    { Zamaw. }
              LoadMemo(NameMemo,FH);
              LoadEdit(StreetEdit,FH);
              LoadEdit(TownEdit,FH);
              LoadEdit(BldgEdit,FH);
              LoadEdit(RoomEdit,FH);
              LoadMaskEdit(ZipMaskEdit,FH);
              LoadEdit(TelEdit,FH);
              LoadEdit(FaxEdit,FH);
              LoadEdit(TelexEdit,FH);
              LoadMaskEdit(RegonMaskEdit,FH);
              LoadBoolean(B,FH);
              NipRB1.Checked:=B;
              LoadBoolean(B,FH);
              NipRB2.Checked:=B;
              LoadMaskEdit(NipMaskEdit1,FH);
              LoadMaskEdit(NipMaskEdit2,FH);
              LoadMemo(ProwadMemo,FH);
              LoadMemo(Art71Memo1,FH);
              LoadMemo(Art71Memo2,FH);
              LoadDateTime(DT,FH);
              BeginDate.EditDate:=DT;
              LoadDateTime(DT,FH);
              EndDate.EditDate:=DT;
              LoadMemo(ObjectMemo,FH);
              LoadMemo(ObjectMemo2,FH);
              LoadMemo(OferentMemo1,FH);
              LoadMemo(OferentMemo2,FH);
              for i:=0 to Prt5MaxPages-1 do
                begin
                  SelPages[i]:=SP[i];
                  if SelPages[i]
                    then TabSet.Tabs[i]:=SelectionChar+' '+TabSet.Tabs[i];
                end;
            end;
        end;
    finally
      CloseFile(FH);
    end;
  except
    on E:EInOutError do
      MessageDlg(IntToStr(E.ErrorCode),mtWarning,[mbOk],0);
  end;
end;

{---------------------------- close SIWZ -------------------------}

procedure TPrt5Dlg.SiwzClose;
begin
  if Modified
    then begin
       if MessageDlg('Zachowaæ SIWZ ?',mtConfirmation,[mbYes,mbNo],0)=mrYes
         then SaveBtnClick(Self);
    end;
  Close;
end;

procedure TPrt5Dlg.CloseBtnClick(Sender: TObject);
begin
  SiwzClose;
end;

procedure TPrt5Dlg.ZamknijClick(Sender: TObject);
begin
  CloseBtnClick(Sender);
end;

procedure TPrt5Dlg.UstawieniedrukarkiClick(Sender: TObject);
begin
  PrinterSetupDlg.Execute;
end;

procedure TPrt5Dlg.PageConfirmButtonClick(Sender: TObject);
begin
  Modified:=TRUE;
  with TabSet do
    begin
      if SelPages[TabIndex]=TRUE
        then begin
          if Tabs[TabIndex][1]='#'
            then Tabs[TabIndex]:=Copy(Tabs[TabIndex],3,Length(Tabs[TabIndex])-2);
          SelPages[TabIndex]:=FALSE;
        end
      else begin
          Tabs[TabIndex]:=SelectionChar+' '+Tabs[TabIndex];
          SelPages[TabIndex]:=TRUE;
      end;
    end;
end;

procedure TPrt5Dlg.FieldChange(Sender: TObject);
begin
  Modified:=TRUE;
  ClearTabTag;
end;

procedure TPrt5Dlg.NipRB1Click(Sender: TObject);
begin
  NipMaskEdit1.Enabled:=TRUE;
  NipMaskEdit1.Color:=clAqua;
  NipMaskEdit2.Enabled:=FALSE;
  NipMaskEdit2.Color:=clGray;
  FieldChange(Sender);
end;

procedure TPrt5Dlg.NipRB2Click(Sender: TObject);
begin
  NipMaskEdit1.Enabled:=FALSE;
  NipMaskEdit1.Color:=clGray;
  NipMaskEdit2.Enabled:=TRUE;
  NipMaskEdit2.Color:=clAqua;
  FieldChange(Sender);
end;

procedure TPrt5Dlg.MakeZamawPrint(var LP:Integer);
var
  p1,p2,p3,p4,p5,p6,p7,p8,p9,p10,p11,p12,p13:PChar;
  s:String;
begin
  p1:=Nil;p2:=Nil;p3:=Nil;p4:=Nil;p5:=Nil;p6:=Nil;p7:=Nil;
  p8:=Nil;p9:=Nil;p10:=Nil;p11:=Nil;
  if Nagwki1.Checked
    then AddBoldString(Ry,Page1,2,PrintSpace,LP);
  p1:=StrAlloc(Length(NameLabel.Caption)+1);
  StrPCopy(p1,NameLabel.Caption);
  p2:=StrAlloc(NameMemo.GetTextLen + 1);
  NameMemo.GetTextBuf(p2, NameMemo.GetTextLen+1);
  p3:=StrAlloc(Length(sAdres)+1);
  StrPCopy(p3,sAdres);
  p4:=StrAlloc(Length(StreetEdit.Text)+Length(BldgEdit.Text)+Length(sRoom)+
               Length(RoomEdit.Text)+Length(TownEdit.Text)+Length(ZipMaskEdit.Text)+5);
  StrPCopy(p4,StreetEdit.Text+' '+BldgEdit.Text+sRoom+RoomEdit.Text+' '+TownEdit.Text+' '+ZipMaskEdit.Text);
  if TelEdit.Text<>''
    then begin
      p5:=StrAlloc(Length(sTel)+Length(TelEdit.Text)+1);
      StrPCopy(p5,sTel+TelEdit.Text);
    end;
  if FaxEdit.Text<>''
    then begin
      p6:=StrAlloc(Length(sFax)+Length(FaxEdit.Text)+1);
      StrPCopy(p6,sFax+FaxEdit.Text);
    end;
  if TelexEdit.Text<>''
    then begin
      p7:=StrAlloc(Length(sTelex)+Length(TelexEdit.Text)+1);
      StrPCopy(p7,sTelex+TelexEdit.Text);
    end;
  p8:=StrAlloc(Length(sRegon)+Length(RegonMaskEdit.Text)+1);
  StrPCopy(p8,sRegon+RegonMaskEdit.Text);
  if NipRB1.Checked
    then s:=NipMaskEdit1.Text
  else if NipRB2.Checked
    then s:=NipMaskEdit2.Text;
  p9:=StrAlloc(Length(sNip)+Length(s)+1);
  StrPCopy(p9,sNip+s);
  p10:=StrAlloc(Length(ProwadLabel.Caption)+1);
  StrPCopy(p10,ProwadLabel.Caption);
  p11:=StrAlloc(ProwadMemo.GetTextLen + 1);
  ProwadMemo.GetTextBuf(p11, ProwadMemo.GetTextLen+1);
  p12:=StrAlloc(Art71Memo1.GetTextLen + 1);
  Art71Memo1.GetTextBuf(p12, Art71Memo1.GetTextLen+1);
  p13:=StrAlloc(Art71Memo2.GetTextLen + 1);
  Art71Memo2.GetTextBuf(p13, Art71Memo2.GetTextLen+1);
  AddParag(Ry,[p1,p2,p3,p4,p5,p6,p7,p8,p9,p10,p11,p12,p13],[2,1,1,1,1,1,1,1,1,1,1,1,0,3],PrintSpace,LP);
  StrDispose(p1);
  StrDispose(p2);
  StrDispose(p3);
  StrDispose(p4);
  StrDispose(p5);
  StrDispose(p6);
  StrDispose(p7);
  StrDispose(p8);
  StrDispose(p9);
  StrDispose(p10);
  StrDispose(p11);
  StrDispose(p12);
  StrDispose(p13);
end;

procedure TPrt5Dlg.MakeTerminPrint(var LP:Integer);
var
  p1,p2:PChar;
begin
  if Nagwki1.Checked
    then AddBoldString(Ry,Page2,2,PrintSpace,LP);
  p1:=StrAlloc(Length(BeginLabel.Caption)+Length(BeginDate.Text)+1);
  StrPCopy(p1,BeginLabel.Caption+BeginDate.Text);
  p2:=StrAlloc(Length(EndLabel.Caption)+Length(EndDate.Text)+1);
  StrPCopy(p2,EndLabel.Caption+EndDate.Text);
  AddParag(Ry,[p1,p2],[1,3],PrintSpace,LP);
  StrDispose(p1);
  StrDispose(p2);
end;

procedure TPrt5Dlg.MakePrzedmiotPrint(var LP:Integer);
var
  p1,p2,p3,p4:PChar;
begin
  if Nagwki1.Checked
    then AddBoldString(Ry,Page3,2,PrintSpace,LP);
  p1:=StrAlloc(Length(ObjectLabel.Caption)+1);
  StrPCopy(p1,ObjectLabel.Caption);
  p2:=StrAlloc(ObjectMemo.GetTextLen + 1);
  ObjectMemo.GetTextBuf(p2, ObjectMemo.GetTextLen+1);
  p3:=StrAlloc(Length(ObjectLabel2.Caption)+Length(ObjectLabel3.Caption)+1);
  StrPCopy(p3,ObjectLabel2.Caption+ObjectLabel3.Caption);
  p4:=StrAlloc(ObjectMemo2.GetTextLen + 1);
  ObjectMemo2.GetTextBuf(p4, ObjectMemo2.GetTextLen+1);
  AddParag(Ry,[p1,p2,p3,p4],[1,1,1,3],PrintSpace,LP);
  StrDispose(p1);
  StrDispose(p2);
  StrDispose(p3);
  StrDispose(p4);
end;

procedure TPrt5Dlg.MakeOferentPrint(var LP:Integer);
var
  p1,p2,p3,p4:PChar;
begin
  if Nagwki1.Checked
    then AddBoldString(Ry,Page4,2,PrintSpace,LP);
  p1:=StrAlloc(Length(OferentLabel1.Caption)+1);
  StrPCopy(p1,OferentLabel1.Caption);
  p2:=StrAlloc(OferentMemo1.GetTextLen + 1);
  OferentMemo1.GetTextBuf(p2, OferentMemo1.GetTextLen+1);
  p3:=StrAlloc(Length(OferentLabel2.Caption)+1);
  StrPCopy(p3,OferentLabel2.Caption);
  p4:=StrAlloc(OferentMemo2.GetTextLen + 1);
  OferentMemo2.GetTextBuf(p4, OferentMemo2.GetTextLen+1);
  AddParag(Ry,[p1,p2,p3,p4],[1,1,1,3],PrintSpace,LP);
  StrDispose(p1);
  StrDispose(p2);
  StrDispose(p3);
  StrDispose(p4);
end;

procedure TPrt5Dlg.MakePrint;
var
  p:PChar;
  X:Integer;
  LP:Integer; {Line position}
  s:String;
begin
  with Ry do
    begin
      Orientation:=poPortrait;
      NewJob;
      SetMinMargins(Xmm(20),Ymm(15),Xmm(15),Ymm(10));
      LP:=YTOff;
      PrintSpace:=YBOff-Ymm(35);
      Font.Name:='Arial CE';
      Font.Size:=16;
      Font.Style:=[fsBold,fsUnderLine];
      s:=sDOKUM+sZamowienieWRTitle;
      p:=StrAlloc(Length(s)+1);
      StrPCopy(p,s);
      X:=MemoOut(Rect(XLOff+Xmm(2),LP,XROff-Xmm(2),10), p, False, False);
      StrDispose(p);
      LP:=LP+X+Ymm(8);
      Font.Size:=10;
      Font.Style:=[];
      if Opis1.Checked
        then begin
          p:=StrAlloc(Length(sDesc)+Length(DescEdit.Text)+1);
          StrPCopy(p,sDesc+DescEdit.Text);
          X:=MemoOut(Rect(XLOff+Xmm(2),LP,XROff-Xmm(2),10), p, False, False);
          StrDispose(p);
          LP:=LP+X+Ymm(1);
        end;
      if Ident1.Checked
        then begin
          p:=StrAlloc(Length(sId)+Length(IdEdit.Text)+1);
          StrPCopy(p,sId+IdEdit.Text);
          X:=MemoOut(Rect(XLOff+Xmm(2),LP,XROff-Xmm(2),10), p, False, False);
          StrDispose(p);
          LP:=LP+X+Ymm(1);
        end;
      if WartZam1.Checked
        then begin
          s:=FloatToStrF(AmountPLN,ffCurrency,12,2);
          p:=StrAlloc(Length(sWartZam)+Length(s)+1);
          StrPCopy(p,sWartZam+s);
          X:=MemoOut(Rect(XLOff+Xmm(2),LP,XROff-Xmm(2),10), p, False, False);
          StrDispose(p);
        end;
      LP:=LP+X+Ymm(10);
      MakeZamawPrint(LP);
      MakeTerminPrint(LP);
      MakePrzedmiotPrint(LP);
      MakeOferentPrint(LP);
      PutPageNums(((XROff-XLOff) div 2) +XLOff,YBOff-Ymm(10),taCenter);
    end;
end;

procedure TPrt5Dlg.PrintBitBtnClick(Sender: TObject);
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

procedure TPrt5Dlg.Drukuj1Click(Sender: TObject);
begin
  PrintBitBtnClick(Sender);
end;

procedure TPrt5Dlg.Przegl1Click(Sender: TObject);
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

procedure TPrt5Dlg.ExportToTxt(FileName:String);
var
  FH:TextFile;
  p,q:PChar;
  i:LongInt;
  s,s1,s2:String;
  Scroll:TScrollStyle;
begin
  Scroll:=ObjectMemo.ScrollBars;
  SuwakiClick(Oba1);
  AssignFile(FH,FileName);
  FileMode:=fmOpenReadWrite + fmShareDenyWrite;
  try
    Rewrite(FH);
    try
  { Zamaw. }
      if Nagwki1.Checked
        then ExportString(#13#10+Page1+#13#10,FH);
      ExportString(DescEdit.Text,FH);
      ExportString(IdEdit.Text,FH);
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
      ExportMemo(ProwadMemo,FH);
      ExportMemo(Art71Memo1,FH);
      ExportMemo(Art71Memo2,FH);
  {Termin}
      if Nagwki1.Checked
        then ExportString(#13#10+Page2+#13#10,FH);
      ExportString(BeginLabel.Caption+BeginDate.Text,FH);
      ExportString(EndLabel.Caption+EndDate.Text,FH);
  {Przedmiot}
      if Nagwki1.Checked
        then ExportString(#13#10+Page3+#13#10,FH);
      ExportString(ObjectLabel.Caption,FH);
      ExportMemo(ObjectMemo,FH);
      ExportString(ObjectLabel2.Caption,FH);
      ExportString(ObjectLabel3.Caption,FH);
      ExportMemo(ObjectMemo2,FH);
  {Offer}
      if Nagwki1.Checked
        then ExportString(#13#10+Page4+#13#10,FH);
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
  case Scroll of
    ssNone,ssVertical: SuwakiClick(Brak1);
    ssBoth,ssHorizontal: SuwakiClick(Oba1);
  end;{case}
end;

procedure TPrt5Dlg.ExportClick(Sender: TObject);
begin
{$IFDEF NONET}
  if not SmartKeyOk(Sk,SkData)
    then Exit;
{$ENDIF}
  with SaveDialog do
    begin
      DefaultExt:=TxtExt;
      Filter:=TxtFilter;
      if Execute
        then ExportToTxt(SaveDialog.FileName);
    end;
end;

procedure TPrt5Dlg.IdEditChange(Sender: TObject);
begin
  Modified:=TRUE;
end;

procedure TPrt5Dlg.SuwakiClick(Sender: TObject);
var
  Scrolls:TScrollStyle;
  WW:Boolean; {wordwrap}
  i:Integer;
begin
  Brak1.Checked:=FALSE;
  Pionowe1.Checked:=FALSE;
  Poziome1.Checked:=FALSE;
  Oba1.Checked:=FALSE;
  TMenuItem(Sender).Checked:=TRUE;
  if TMenuItem(Sender).Name='Brak1'
    then begin
      Scrolls:=ssNone;
      WW:=TRUE;
    end
  else if TMenuItem(Sender).Name='Pionowe1'
    then begin
      Scrolls:=ssVertical;
      WW:=TRUE;
    end
  else if TMenuItem(Sender).Name='Poziome1'
    then begin
      Scrolls:=ssHorizontal;
      WW:=FALSE;
    end
  else if TMenuItem(Sender).Name='Oba1'
    then begin
      Scrolls:=ssBoth;
      WW:=FALSE;
    end;
  for i:=0 to ComponentCount-1 do
    if Components[i] is TMemo
      then begin
        TMemo(Components[i]).ScrollBars:=Scrolls;
        TMemo(Components[i]).WordWrap:=WW;
      end;
end;

procedure TPrt5Dlg.TabSetClick(Sender: TObject);
begin
  Notebook.PageIndex:=TabSet.TabIndex;
  PrevBitBtn.Enabled:= Notebook.PageIndex>0;
  NextBitBtn.Enabled:= Notebook.PageIndex<Prt5MaxPages-1;
end;

procedure TPrt5Dlg.ClearTabTag;
begin
  with TabSet do
    if SelPages[TabIndex]=TRUE
      then begin
        if Tabs[TabIndex][1]='#'
          then Tabs[TabIndex]:=Copy(Tabs[TabIndex],3,Length(Tabs[TabIndex])-2);
        SelPages[TabIndex]:=FALSE;
      end
end;

procedure TPrt5Dlg.OknaClick(Sender: TObject);
begin
  if not (Sender is TMenuItem)
    then Exit;
  TabSet.TabIndex:=TabSet.Tabs.IndexOf(TMenuItem(Sender).Caption);
end;

procedure TPrt5Dlg.Save1Click(Sender: TObject);
begin
  SaveBtnClick(Sender);
end;

procedure TPrt5Dlg.SaveAs1Click(Sender: TObject);
var
  FN:String;
begin
  FN:=FileName;
  FileName:='';
  SaveBtnClick(Sender);
  FileName:=FN;
end;

procedure TPrt5Dlg.Nagwki1Click(Sender: TObject);
begin
  Nagwki1.Checked:=not Nagwki1.Checked;
end;

procedure TPrt5Dlg.Opis1Click(Sender: TObject);
begin
  Opis1.Checked:=not Opis1.Checked;
end;

procedure TPrt5Dlg.Ident1Click(Sender: TObject);
begin
  Ident1.Checked:=not Ident1.Checked;
end;

procedure TPrt5Dlg.Wartzam1Click(Sender: TObject);
begin
  WartZam1.Checked:=not WartZam1.Checked;
end;

end.


