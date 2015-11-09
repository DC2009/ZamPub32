unit Prt3;

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
  Value,
  Rodzaj,
  NumInp, Tabs, Sk;

const
  CCol=0;
  DCol=1;
  ECol=2;
  WCol=3;

  sRepresentedBy=' reprezentowana przez ';
  sOfferedPrice='Cena ofertowa: ';

  ZapFilter='Zapytanie o cenê|*.';

{Pages}
  page1='Zamawiaj¹cy';
  page2='Termin realizacji';
  page3='Przedmiot zamówienia';
  page4='Oferta ca³a/czêœciowa';
  page5='Zawartoœæ ofert';
  page6='Zabezpieczenie';
  page7='Wykaz oferentów';

  DefSelPages30:Array[1..Prt3MaxPages30] of Boolean=(FALSE,FALSE,FALSE,FALSE);
  DefSelPages32:Array[1..Prt3MaxPages32] of Boolean=(FALSE,FALSE,FALSE,FALSE,FALSE,FALSE,FALSE);

type
  TPrt3Dlg = class(TForm)
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
    ZamScrollBox: TScrollBox;
    NameLabel: TLabel;
    StreetLabel: TLabel;
    TownLabel: TLabel;
    NumberLabel: TLabel;
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
    ProwadMemo: TMemo;
    RoomEdit: TEdit;
    ScrollBox3: TScrollBox;
    ObjectLabel: TLabel;
    ObjectMemo: TMemo;
    Page3Button: TButton;
    ScrollBox4: TScrollBox;
    OferentLabel: TLabel;
    ChoiceLabel: TLabel;
    Page4Button: TButton;
    OferentMemo: TMemo;
    ChoiceMemo: TMemo;
    Sk: TSmartKey;
    OfertaCala1: TMenuItem;
    Zawart1: TMenuItem;
    Zabezpieczenie1: TMenuItem;
    TerminBevel: TBevel;
    TerminGB2: TGroupBox;
    TimeUnitCB: TComboBox;
    TerminEdit: TNumInp;
    TerminRb2_1: TRadioButton;
    TerminRB2_2: TRadioButton;
    CB2_5: TComboBox;
    TerminRB2: TRadioButton;
    TerminRb1: TRadioButton;
    TerminGB1: TGroupBox;
    TerminRb1_1: TRadioButton;
    TerminRB1_2: TRadioButton;
    EndDate: TIntDate;
    Page2Button: TButton;
    OfertaBevel: TBevel;
    OfertaRadioGroup: TRadioGroup;
    OfertaMemo: TMemo;
    Button1: TButton;
    ContentScrollBox: TScrollBox;
    ContentMemo1: TMemo;
    ContentMemo3: TMemo;
    Page12Button: TButton;
    ContentMemo2: TMemo;
    ContentMemo4: TMemo;
    ContentMemo5: TMemo;
    ContentMemo6: TMemo;
    ScrollBox1: TScrollBox;
    Label8: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Page7Button: TButton;
    ZabezMemo2_1: TMemo;
    ZabezMemo3_1: TMemo;
    Memo10: TMemo;
    ZabezGB1: TGroupBox;
    Label7: TLabel;
    ZabezRB1_2: TRadioButton;
    ZabezRb1_3: TRadioButton;
    ZabezCB2_2: TComboBox;
    ZabezCB3_2: TCheckBox;
    ZabezCB3_3: TCheckBox;
    ZabezCB3_4: TCheckBox;
    N2: TMenuItem;
    Rodzaj1: TMenuItem;
    Value1: TMenuItem;
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
    procedure OferentMemoDblClick(Sender: TObject);
    procedure OferentMemoEnter(Sender: TObject);
    procedure OferentMemoExit(Sender: TObject);
    procedure AddBitBtnClick(Sender: TObject);
    procedure TerminRb1Click(Sender: TObject);
    procedure TerminRB2Click(Sender: TObject);
    procedure OfertaRadioGroupClick(Sender: TObject);
    procedure ContentMemo2Enter(Sender: TObject);
    procedure ContentMemo2Exit(Sender: TObject);
    procedure ContentMemo2DblClick(Sender: TObject);
    procedure ZabezRB1_2Click(Sender: TObject);
    procedure ZabezRb1_3Click(Sender: TObject);
    procedure Value1Click(Sender: TObject);
    procedure Rodzaj1Click(Sender: TObject);
  private
    { Private declarations }
    Modified:Boolean;
    SelPages:Array[0..Prt3MaxPages32-1] of Boolean;
    FilePwd:String;
    Phase:Byte;

    PPos:Integer;
    PrintSpace:Integer;
    Ry:TRyPrinter;

    procedure ClearTabTag;
    procedure MakeZamawPrint(var LP:Integer);
    procedure MakeTerminPrint(var LP:Integer);
    procedure MakePrzedmiotPrint(var LP:Integer);
    procedure MakeRodzajPrint(var LP:Integer);
    procedure MakeContentPrint(var LP:Integer);
    procedure MakeZabezPrint(var LP:Integer);
    procedure MakeOferentPrint(var LP:Integer);
    procedure MakePrint;
    procedure InitializeSiwz;
    procedure SiwzClose;
    procedure ExportToTxt(FileName:String);
    procedure TerminActivate(AGroupBox:Byte);
    procedure ZabezActive(State:Boolean);
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

procedure Przetarg3(AFileName:String;APrt:Byte; PLN:Real;
                    ALevel:Integer; OKind:Byte; APrefKraj:Boolean); export;

implementation

{$R *.DFM}

uses
  Prt1Ini,
  Msg2,
  Utils,
  DateUtil,
  Info9,
  AddWar,
  AddCont,
  Kriteria;


procedure Przetarg3(AFileName:String;APrt:Byte;
                               PLN:Real; ALevel:Integer;
                               OKind:Byte; APrefKraj:Boolean);
var
  Curs:Integer;
  Del:Boolean;
  Prt3Dlg: TPrt3Dlg;
begin
  Curs:=Screen.Cursor;
  Screen.Cursor:=crHourGlass;
  GetAllConfiguration;
  Application.HelpFile:=SiwzHelpFile;
  FileMode:=fmOpenReadWrite + fmShareDenyWrite;
  Prt3Dlg:=TPrt3Dlg.Create(Nil);
  with Prt3Dlg do
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

procedure TPrt3Dlg.FormCreate(Sender: TObject);
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
    for i:=0 to Prt3MaxPages32-1 do
      begin
        TabSet.TabIndex:=i;
        ClearTabTag;
      end;

  NoteBook.PageIndex:=0;
  TabSet.TabIndex:=0;

  PrevBitBtn.Enabled:=FALSE;
  AddBitBtn.Enabled:=FALSE;
end;

procedure TPrt3Dlg.InitializeSiwz;
var
  F:File;
begin
  NipMaskEdit2.Enabled:=FALSE;
  NipRB1.Checked:=TRUE;
  NipRB2.Checked:=FALSE;
  TerminRB1.Checked:=TRUE;
  TerminRB1_1.Checked:=TRUE;
  TerminRB2.Checked:=FALSE;
  TerminRB2_1.Checked:=TRUE;
  ZabezRB1_2.Checked:=TRUE;
  TerminActivate(1);
  Caption:=sZapytanieOCeneTitle;
  SuwakiClick(Oba1);
  OfertaRadioGroup.ItemIndex:=0;
  with OfertaRadioGroup do  {initialize Oferta fields}
   begin
     case ObjectKind Of
       okDostawa: Items[1]:=sOfertaCzesc+sDostawy;
       okUslugi: Items[1]:=sOfertaCzesc+sUslugi;
       okRobBud: Items[1]:=sOfertaCzesc+sRobotyBud;
     end;{case}
     OfertaMemo.Enabled:=(ItemIndex=1);
     if OfertaMemo.Enabled
       then OfertaMemo.Color:=clAqua
       else OfertaMemo.Color:=clGray;
   end;
  if OpenMode=oOpen
    then begin
      LoadFromFile(FileName);
    end
    else begin
{      BeginDate.EditDate:=Now;}
      EndDate.EditDate:=Now;
    end;
  Modified:=FALSE;
end;

procedure TPrt3Dlg.PrevBitBtnClick(Sender: TObject);
begin
  PrevBitBtn.Enabled:= Notebook.PageIndex>0;
  NextBitBtn.Enabled:= Notebook.PageIndex<Prt3MaxPages32-1;
  if PrevBitBtn.Enabled
    then Notebook.PageIndex:=Notebook.PageIndex-1;
  TabSet.TabIndex:=Notebook.PageIndex;
end;

procedure TPrt3Dlg.NextBitBtnClick(Sender: TObject);
begin
  PrevBitBtn.Enabled:= Notebook.PageIndex>0;
  NextBitBtn.Enabled:= Notebook.PageIndex<Prt3MaxPages32-1;
  if NextBitBtn.Enabled
    then Notebook.PageIndex:=Notebook.PageIndex+1;
  TabSet.TabIndex:=Notebook.PageIndex;
end;

{Date fields}

procedure TPrt3Dlg.SaveBtnClick(Sender: TObject);
begin
{$IFDEF NONET}
  if not SmartKeyOk(Sk,SkData)
    then Exit;
{$ENDIF}
  if FileName=''
    then with SaveDialog do
      begin
        case TenderType of
          ttZap:
            begin
              DefaultExt:=ZapExt;
              Filter:=ZapFilter+ZapExt;
            end;
        end;{case}
        if Execute
          then begin
            SaveToFile(FileName);
          end;
      end
    else SaveToFile(FileName);
end;

procedure TPrt3Dlg.SaveToFile(FileName:String);
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
        FileHdr:=ZapFileHdr;
        SeedKey:=SKey;
        SaveString(VersionString32+FileHdr,FH);
        SaveString(FilePwd,FH);
        MakeCodeKey(FilePwd);
        SaveString(IdEdit.Text,FH);
        SaveString(DescEdit.Text,FH);
        SaveInteger(AmountLevel,FH);
        SaveInteger(ObjectKind,FH);
        SaveReal(AmountPLN,FH);
        SaveBoolean(PrefKrajowe,FH);
        SaveByte(Phase,FH);
        for i:=0 to Prt3MaxPages32-1 do
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
    {Termin}
        SaveBoolean(TerminRB1.Checked,FH);
        SaveBoolean(TerminRB2.Checked,FH);
        SaveBoolean(TerminRB1_1.Checked,FH);
        SaveBoolean(TerminRB1_2.Checked,FH);
        SaveBoolean(TerminRB2_1.Checked,FH);
        SaveBoolean(TerminRB2_2.Checked,FH);
        SaveDateTime(EndDate.EditDate,FH);
        SaveInteger(TerminEdit.AsInteger,FH);
        SaveComboBox(TimeUnitCB,FH);
        SaveComboBox(CB2_5,FH);
    {Przedmiot}
        SaveMemo(ObjectMemo,FH);
    {Rodzaj}
        SaveInteger(OfertaRadioGroup.ItemIndex,FH);
        SaveMemo(OfertaMemo,FH);
    {Zawartosc}
        SaveMemo(ContentMemo1,FH);
        SaveMemo(ContentMemo2,FH);
        SaveMemo(ContentMemo3,FH);
        SaveMemo(ContentMemo4,FH);
        SaveMemo(ContentMemo5,FH);
        SaveMemo(ContentMemo6,FH);
    {Zabez}
        SaveBoolean(ZabezRB1_2.Checked,FH);
        SaveMemo(ZabezMemo2_1,FH);
        SaveComboBox(ZabezCB2_2,FH);
        SaveMemo(ZabezMemo3_1,FH);
        SaveBoolean(ZabezCB3_2.Checked,FH);
        SaveBoolean(ZabezCB3_3.Checked,FH);
        SaveBoolean(ZabezCB3_4.Checked,FH);
    {Oferent}
        SaveMemo(OferentMemo,FH);
        SaveMemo(ChoiceMemo,FH);
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

procedure TPrt3Dlg.LoadFromFile(FileName:String);
var
  B:Boolean;
  SP:Array[0..Prt3MaxPages32-1] of Boolean;
  s:String;
  DT:TDateTime;
  FH:File;
  FileHdr:String;
  Version:Byte;

  procedure LoadVersion30;
  var
    i,j:Integer;
  begin
    ClearPrt3Fields(30,Self);
    for i:=0 to Prt3MaxPages30-1 do
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
    {Termin}
    LoadDateTime(DT,FH);
{    BeginDate.EditDate:=DT;}
    LoadDateTime(DT,FH);
    EndDate.EditDate:=DT;
    TimeUnitCb.Clear;
    TimeUnitCb.Items.Add('dni');
    TimeUnitCb.Items.Add('tygodni');
    TimeUnitCb.Items.Add('miesiêcy');
    TimeUnitCb.Items.Add('lat');
    CB2_5.Clear;
    CB2_5.Items.Add('od daty podpisania umowy');
    {Przedmiot}
    LoadMemo(ObjectMemo,FH);
    {Oferent}
    LoadMemo(OferentMemo,FH);
    LoadMemo(ChoiceMemo,FH);
    for i:=0 to Prt3MaxPages30-1 do
      begin
        if i=3
          then j:=6
          else j:=i;
        SelPages[j]:=SP[i];
        if SelPages[j]
          then TabSet.Tabs[j]:=SelectionChar+' '+TabSet.Tabs[j];
      end;
  end;

  procedure LoadVersion32;
  var
    i:Integer;
  begin
    ClearPrt3Fields(32,Self);
    for i:=0 to Prt3MaxPages32-1 do
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
    {Termin}
    LoadBoolean(B,FH);
    TerminRB1.Checked:=B;
    LoadBoolean(B,FH);
    TerminRB2.Checked:=B;
    LoadBoolean(B,FH);
    TerminRB1_1.Checked:=B;
    LoadBoolean(B,FH);
    TerminRB1_2.Checked:=B;
    LoadBoolean(B,FH);
    TerminRB2_1.Checked:=B;
    LoadBoolean(B,FH);
    TerminRB2_2.Checked:=B;
    LoadDateTime(DT,FH);
    EndDate.EditDate:=DT;
    LoadInteger(i,FH);
    TerminEdit.Value:=i;
    LoadComboBox(TimeUnitCB,FH);
    if TimeUnitCb.Items.Count=0
      then begin
        TimeUnitCb.Items.Add('dni');
        TimeUnitCb.Items.Add('tygodni');
        TimeUnitCb.Items.Add('miesiêcy');
        TimeUnitCb.Items.Add('lat');
      end;
    LoadComboBox(CB2_5,FH);
    if CB2_5.Items.Count=0
      then CB2_5.Items.Add('od daty podpisania umowy');
    {Przedmiot}
    LoadMemo(ObjectMemo,FH);
    {Rodzaj}
    LoadInteger(i,FH);
    OfertaRadioGroup.ItemIndex:=i;
    LoadMemo(OfertaMemo,FH);
    OfertaMemo.Enabled:=(i=1);
    with OfertaRadioGroup do  {initialize Oferta fields}
      begin
        case ObjectKind Of
          okDostawa: Items[1]:=sOfertaCzesc+sDostawy;
          okUslugi: Items[1]:=sOfertaCzesc+sUslugi;
          okRobBud: Items[1]:=sOfertaCzesc+sRobotyBud;
        end;{case}
        OfertaMemo.Enabled:=(ItemIndex=1);
        if OfertaMemo.Enabled
          then OfertaMemo.Color:=clAqua
          else OfertaMemo.Color:=clGray;
      end;
    {Zawartosc}
    LoadMemo(ContentMemo1,FH);
    LoadMemo(ContentMemo2,FH);
    LoadMemo(ContentMemo3,FH);
    LoadMemo(ContentMemo4,FH);
    LoadMemo(ContentMemo5,FH);
    LoadMemo(ContentMemo6,FH);
    {Zabez}
    LoadBoolean(B,FH);
    ZabezRB1_2.Checked:=B;
    ZabezRB1_3.Checked:= not B;
    LoadMemo(ZabezMemo2_1,FH);
    LoadComboBox(ZabezCB2_2,FH);
    LoadMemo(ZabezMemo3_1,FH);
    LoadBoolean(B,FH);
    ZabezCB3_2.Checked:=B;
    LoadBoolean(B,FH);
    ZabezCB3_3.Checked:=B;
    LoadBoolean(B,FH);
    ZabezCB3_4.Checked:=B;
    {Oferent}
    LoadMemo(OferentMemo,FH);
    LoadMemo(ChoiceMemo,FH);
    for i:=0 to Prt3MaxPages32-1 do
      begin
        SelPages[i]:=SP[i];
        if SelPages[i]
          then TabSet.Tabs[i]:=SelectionChar+' '+TabSet.Tabs[i];
      end;
  end;

begin
  AssignFile(FH,FileName);
  try
    Reset(FH,1);
    try
      FileHdr:=ZapFileHdr;
      SeedKey:=SKey;
      LoadString(s,FH);
      Version:=0;
      if s=VersionString+FileHdr
        then Version:=30
      else if s=VersionString32+FileHdr
        then Version:=32;
      if Version in [30,32]
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
              if Version=30
                then LoadVersion30
              else if Version=32
                then LoadVersion32;
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

procedure TPrt3Dlg.SiwzClose;
begin
  if Modified
    then begin
       if MessageDlg('Zachowaæ SIWZ ?',mtConfirmation,[mbYes,mbNo],0)=mrYes
         then SaveBtnClick(Self);
    end;
  Close;
end;

procedure TPrt3Dlg.CloseBtnClick(Sender: TObject);
begin
  SiwzClose;
end;

procedure TPrt3Dlg.ZamknijClick(Sender: TObject);
begin
  CloseBtnClick(Sender);
end;

procedure TPrt3Dlg.UstawieniedrukarkiClick(Sender: TObject);
begin
  PrinterSetupDlg.Execute;
end;

procedure TPrt3Dlg.PageConfirmButtonClick(Sender: TObject);
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

procedure TPrt3Dlg.FieldChange(Sender: TObject);
begin
  Modified:=TRUE;
  ClearTabTag;
end;

procedure TPrt3Dlg.NipRB1Click(Sender: TObject);
begin
  NipMaskEdit1.Enabled:=TRUE;
  NipMaskEdit1.Color:=clAqua;
  NipMaskEdit2.Enabled:=FALSE;
  NipMaskEdit2.Color:=clGray;
  FieldChange(Sender);
end;

procedure TPrt3Dlg.NipRB2Click(Sender: TObject);
begin
  NipMaskEdit1.Enabled:=FALSE;
  NipMaskEdit1.Color:=clGray;
  NipMaskEdit2.Enabled:=TRUE;
  NipMaskEdit2.Color:=clAqua;
  FieldChange(Sender);
end;

procedure TPrt3Dlg.MakeZamawPrint(var LP:Integer);
var
  p1,p2,p3,p4,p5,p6,p7,p8,p9,p10,p11:PChar;
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
  AddParag(Ry,[p1,p2,p3,p4,p5,p6,p7,p8,p9,p10,p11],[2,1,1,1,1,1,1,1,1,1,1,3],PrintSpace,LP);
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
end;

procedure TPrt3Dlg.MakeTerminPrint(var LP:Integer);
var
  p1:PChar;
  s:String;
begin
  if Nagwki1.Checked
    then AddBoldString(Ry,Page2,2,PrintSpace,LP);
  if TerminRB1.Checked
    then begin
      if TerminRB1_1.Checked
        then s:=TerminRB1_1.Caption
      else if TerminRB1_2.Checked
        then s:=TerminRB1_2.Caption
      else s:='';
      if s<>''
        then s:=s+DateToStr(EndDate.EditDate);
    end
  else if TerminRB2.Checked
    then begin
      if TerminRB2_1.Checked
        then s:=TerminRB2_1.Caption
      else if TerminRB2_2.Checked
        then s:=TerminRB2_2.Caption
      else s:='';
      if s<>''
        then s:=s+TerminEdit.Text+' '+TimeUnitCB.Text+' '+CB2_5.Text;
    end;
  if s<>''
    then begin
      p1:=StrAlloc(Length(s)+1);
      StrPCopy(p1,s);
      AddParag(Ry,[p1],[3],PrintSpace,LP);
      StrDispose(p1);
    end;
end;

procedure TPrt3Dlg.MakePrzedmiotPrint(var LP:Integer);
var
  p1,p2:PChar;
begin
  if Nagwki1.Checked
    then AddBoldString(Ry,Page3,2,PrintSpace,LP);
  p1:=StrAlloc(Length(ObjectLabel.Caption)+1);
  StrPCopy(p1,ObjectLabel.Caption);
  p2:=StrAlloc(ObjectMemo.GetTextLen + 1);
  ObjectMemo.GetTextBuf(p2, ObjectMemo.GetTextLen+1);
  AddParag(Ry,[p1,p2],[1,3],PrintSpace,LP);
  StrDispose(p1);
  StrDispose(p2);
end;

procedure TPrt3Dlg.MakeRodzajPrint(var LP:Integer);
var
  p1,p2:PChar;
  s:String;
begin
  if Nagwki1.Checked
    then AddBoldString(Ry,Page4,2,PrintSpace,LP);
  s:=OfertaRadioGroup.Items[OfertaRadioGroup.ItemIndex];
  p1:=StrAlloc(Length(s)+1);
  StrPCopy(p1,s);
  if OfertaRadioGroup.ItemIndex=1
    then begin
      p2:=StrAlloc(OfertaMemo.GetTextLen + 1);
      OfertaMemo.GetTextBuf(p2, OfertaMemo.GetTextLen+1);
    end
    else p2:=Nil;
  AddParag(Ry,[p1,p2],[1,3],PrintSpace,LP);
  StrDispose(p1);
  StrDispose(p2);
end;

procedure TPrt3Dlg.MakeContentPrint(var LP:Integer);
var
  p1,p2,p3,p4,p5,p6:PChar;
begin
  if Nagwki1.Checked
    then AddBoldString(Ry,Page5,2,PrintSpace,LP);
  p1:=Nil;p2:=Nil;p3:=Nil;p4:=Nil;p5:=Nil;p6:=Nil;
  p1:=StrAlloc(ContentMemo1.GetTextLen + 1);
  ContentMemo1.GetTextBuf(p1, ContentMemo1.GetTextLen+1);
  p2:=StrAlloc(ContentMemo2.GetTextLen + 1);
  ContentMemo2.GetTextBuf(p2, ContentMemo2.GetTextLen+1);
  p3:=StrAlloc(ContentMemo3.GetTextLen + 1);
  ContentMemo3.GetTextBuf(p3, ContentMemo3.GetTextLen+1);
  p4:=StrAlloc(ContentMemo4.GetTextLen + 1);
  ContentMemo4.GetTextBuf(p4, ContentMemo4.GetTextLen+1);
  p5:=StrAlloc(ContentMemo5.GetTextLen + 1);
  ContentMemo5.GetTextBuf(p5, ContentMemo5.GetTextLen+1);
  p6:=StrAlloc(ContentMemo6.GetTextLen + 1);
  ContentMemo6.GetTextBuf(p6, ContentMemo6.GetTextLen+1);
  AddParag(Ry,[p1,p2,p3,p4,p5,p6],[0,1,1,1,1,3],PrintSpace,LP);
  StrDispose(p1);
  StrDispose(p2);
  StrDispose(p3);
  StrDispose(p4);
  StrDispose(p5);
  StrDispose(p6);
end;

procedure TPrt3Dlg.MakeZabezPrint(var LP:Integer);
var
  p1,p2:PChar;
begin
  if ZabezRb1_3.Checked
    then Exit;
  if Nagwki1.Checked
    then AddBoldString(Ry,Page6,2,PrintSpace,LP);
  p1:=Nil;p2:=Nil;
  if ZabezCB2_2.Text<>''
    then ZabezMemo2_1.Lines.Add(ZabezCB2_2.Text);
  p1:=StrAlloc(ZabezMemo2_1.GetTextLen + 1);
  ZabezMemo2_1.GetTextBuf(p1, ZabezMemo2_1.GetTextLen+1);
  if ZabezCB2_2.Text<>''
    then ZabezMemo2_1.Lines.Delete(ZabezMemo2_1.Lines.Count-1);
  if ZabezCB3_2.Checked
    then ZabezMemo3_1.Lines.Add(ZabezCB3_2.Caption);
  if ZabezCB3_3.Checked
    then ZabezMemo3_1.Lines.Add(ZabezCB3_3.Caption);
  if ZabezCB3_4.Checked
    then ZabezMemo3_1.Lines.Add(ZabezCB3_4.Caption);
  p2:=StrAlloc(ZabezMemo3_1.GetTextLen + 1);
  ZabezMemo3_1.GetTextBuf(p2, ZabezMemo3_1.GetTextLen+1);
  if ZabezCB3_2.Checked
    then ZabezMemo3_1.Lines.Delete(ZabezMemo3_1.Lines.Count-1);
  if ZabezCB3_3.Checked
    then ZabezMemo3_1.Lines.Delete(ZabezMemo3_1.Lines.Count-1);
  if ZabezCB3_4.Checked
    then ZabezMemo3_1.Lines.Delete(ZabezMemo3_1.Lines.Count-1);
  AddParag(Ry,[p1,p2],[1,3],PrintSpace,LP);
  StrDispose(p1);
  StrDispose(p2);
end;

procedure TPrt3Dlg.MakeOferentPrint(var LP:Integer);
var
  p1,p2,p3,p4:PChar;
begin
  if Nagwki1.Checked
    then AddBoldString(Ry,Page7,2,PrintSpace,LP);
  p1:=StrAlloc(Length(OferentLabel.Caption)+1);
  StrPCopy(p1,OferentLabel.Caption);
  p2:=StrAlloc(OferentMemo.GetTextLen + 1);
  OferentMemo.GetTextBuf(p2, OferentMemo.GetTextLen+1);
  p3:=StrAlloc(Length(ChoiceLabel.Caption)+1);
  StrPCopy(p3,ChoiceLabel.Caption);
  p4:=StrAlloc(ChoiceMemo.GetTextLen + 1);
  ChoiceMemo.GetTextBuf(p4, ChoiceMemo.GetTextLen+1);
  AddParag(Ry,[p1,p2,p3,p4],[1,1,1,3],PrintSpace,LP);
  StrDispose(p1);
  StrDispose(p2);
  StrDispose(p3);
  StrDispose(p4);
end;

procedure TPrt3Dlg.MakePrint;
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
      s:=sDOKUM+sZapytanieOCeneTitle;
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
      MakeRodzajPrint(LP);
      MakeContentPrint(LP);
      MakeZabezPrint(LP);
      MakeOferentPrint(LP);
      PutPageNums(((XROff-XLOff) div 2) +XLOff,YBOff-Ymm(10),taCenter);
    end;
end;

procedure TPrt3Dlg.PrintBitBtnClick(Sender: TObject);
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

procedure TPrt3Dlg.Drukuj1Click(Sender: TObject);
begin
  PrintBitBtnClick(Sender);
end;

procedure TPrt3Dlg.Przegl1Click(Sender: TObject);
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

procedure TPrt3Dlg.ExportToTxt(FileName:String);
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
  {Termin}
      if Nagwki1.Checked
        then ExportString(#13#10+Page2+#13#10,FH);
      if TerminRB1.Checked
        then begin
          if TerminRB1_1.Checked
            then ExportString(TerminRB1_1.Caption+EndDate.Text,FH)
            else ExportString(TerminRB1_2.Caption+EndDate.Text,FH);
        end
      else if TerminRB2.Checked
        then begin
          if TerminRB2_1.Checked
            then s:=TerminRB2_1.Caption
            else s:=TerminRB2_2.Caption;
          p:=StrAlloc(Length(s)+Length(TerminEdit.Text)+Length(TimeUnitCB.Text)+
                      Length(CB2_5.Text)+1);
          StrPCopy(p,s+TerminEdit.Text+TimeUnitCB.Text+CB2_5.Text);
          ExportPChar(p,FH);
          StrDispose(p);
        end;
  {Przedmiot}
      if Nagwki1.Checked
        then ExportString(#13#10+Page3+#13#10,FH);
      ExportString(ObjectLabel.Caption,FH);
      ExportMemo(ObjectMemo,FH);
  {Rodzaj}
      if Nagwki1.Checked
        then ExportString(#13#10+Page4+#13#10,FH);
      ExportString(OfertaRadioGroup.Items[OfertaRadioGroup.ItemIndex],FH);
      if OfertaRadioGroup.ItemIndex=1
        then ExportMemo(OfertaMemo,FH);
  {Zawartosc}
      if Nagwki1.Checked
        then ExportString(#13#10+Page5+#13#10,FH);
      ExportMemo(ContentMemo1,FH);
      ExportMemo(ContentMemo2,FH);
      ExportMemo(ContentMemo3,FH);
      ExportMemo(ContentMemo4,FH);
      ExportMemo(ContentMemo5,FH);
      ExportMemo(ContentMemo6,FH);
  {Zabez}
      if Nagwki1.Checked
        then ExportString(#13#10+Page6+#13#10,FH);
      if ZabezRB1_2.Checked
        then begin
          ExportMemo(ZabezMemo2_1,FH);
          ExportString(ZabezCB2_2.Text,FH);
          if ZabezCB3_2.Checked
            then ZabezMemo3_1.Lines.Add(ZabezCB3_2.Caption);
          if ZabezCB3_3.Checked
            then ZabezMemo3_1.Lines.Add(ZabezCB3_3.Caption);
          if ZabezCB3_4.Checked
            then ZabezMemo3_1.Lines.Add(ZabezCB3_4.Caption);
          ExportMemo(ZabezMemo3_1,FH);
          if ZabezCB3_2.Checked
            then ZabezMemo3_1.Lines.Delete(ZabezMemo3_1.Lines.Count-1);
          if ZabezCB3_3.Checked
            then ZabezMemo3_1.Lines.Delete(ZabezMemo3_1.Lines.Count-1);
          if ZabezCB3_4.Checked
            then ZabezMemo3_1.Lines.Delete(ZabezMemo3_1.Lines.Count-1);
        end;
  {Offer}
      if Nagwki1.Checked
        then ExportString(#13#10+Page7+#13#10,FH);
      ExportString(OferentLabel.Caption,FH);
      ExportMemo(OferentMemo,FH);
      ExportMemo(ChoiceMemo,FH);
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

procedure TPrt3Dlg.ExportClick(Sender: TObject);
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

procedure TPrt3Dlg.IdEditChange(Sender: TObject);
begin
  Modified:=TRUE;
end;

procedure TPrt3Dlg.SuwakiClick(Sender: TObject);
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

procedure TPrt3Dlg.TabSetClick(Sender: TObject);
begin
  Notebook.PageIndex:=TabSet.TabIndex;
  PrevBitBtn.Enabled:= Notebook.PageIndex>0;
  NextBitBtn.Enabled:= Notebook.PageIndex<Prt3MaxPages32-1;
end;

procedure TPrt3Dlg.ClearTabTag;
begin
  with TabSet do
    if SelPages[TabIndex]=TRUE
      then begin
        if Tabs[TabIndex][1]='#'
          then Tabs[TabIndex]:=Copy(Tabs[TabIndex],3,Length(Tabs[TabIndex])-2);
        SelPages[TabIndex]:=FALSE;
      end
end;

procedure TPrt3Dlg.OknaClick(Sender: TObject);
begin
  if not (Sender is TMenuItem)
    then Exit;
  TabSet.TabIndex:=TabSet.Tabs.IndexOf(TMenuItem(Sender).Caption);
end;

procedure TPrt3Dlg.Save1Click(Sender: TObject);
begin
  SaveBtnClick(Sender);
end;

procedure TPrt3Dlg.SaveAs1Click(Sender: TObject);
var
  FN:String;
begin
  FN:=FileName;
  FileName:='';
  SaveBtnClick(Sender);
  FileName:=FN;
end;

procedure TPrt3Dlg.Nagwki1Click(Sender: TObject);
begin
  Nagwki1.Checked:=not Nagwki1.Checked;
end;

procedure TPrt3Dlg.Opis1Click(Sender: TObject);
begin
  Opis1.Checked:=not Opis1.Checked;
end;

procedure TPrt3Dlg.Ident1Click(Sender: TObject);
begin
  Ident1.Checked:=not Ident1.Checked;
end;

procedure TPrt3Dlg.Wartzam1Click(Sender: TObject);
begin
  WartZam1.Checked:=not WartZam1.Checked;
end;

procedure TPrt3Dlg.OferentMemoDblClick(Sender: TObject);
var
  Line:String;
begin
  OferentDlg:=TOferentDlg.Create(Nil);
  with OferentDlg do
    begin
      if ShowModal=mrOk
        then begin
          Line:='';
          if StripAllSpaces(CompanyEdit.Text)<>''
            then Line:=CompanyEdit.Text;
          if (Line<>'') and (StripAllSpaces(NameEdit.Text)<>'')
            then Line:=Line+sRepresentedBy;
          if StripAllSpaces(NameEdit.Text)<>''
            then Line:=Line+NameEdit.Text;
          OferentMemo.Lines.Add(Line);
          if Line<>''
            then begin
              if StripAllSpaces(AddressEdit.Text)<>''
                then OferentMemo.Lines.Add(AddressEdit.Text);
              if (StripAllSpaces(PriceEdit.Text)<>'') and
                 (UpperCase(StripAllSpaces(PriceEdit.Text))<>'PLN')
                then OferentMemo.Lines.Add(sOfferedPrice+PriceEdit.Text);
              OferentMemo.Lines.Add(' ');  {Add a line between oferentów}
            end;
        end;
      Free;
    end;
end;

procedure TPrt3Dlg.OferentMemoEnter(Sender: TObject);
begin
  WhereAdd:=OferentMemo;
  AddBitBtn.Enabled:=TRUE;
end;

procedure TPrt3Dlg.OferentMemoExit(Sender: TObject);
begin
  if not AddBitBtn.Focused
    then AddBitBtn.Enabled:=FALSE;
end;

procedure TPrt3Dlg.AddBitBtnClick(Sender: TObject);
begin
  if WhereAdd=OferentMemo
    then OferentMemoDblClick(WhereAdd)
  else if WhereAdd=ContentMemo2
    then begin
      ContentMemo2DblClick(WhereAdd);
      ContentMemo2.SetFocus;
    end
end;

procedure TPrt3Dlg.TerminActivate(AGroupBox:Byte);
begin
  case AGroupBox of
    1:begin
        TerminGB1.Enabled:=TRUE;
        TerminRB1_1.Font.Color:=clBlack;
        TerminRB1_2.Font.Color:=clBlack;
        EndDate.Enabled:=TRUE;
        EndDate.Font.Color:=clBlack;
        TerminGB2.Enabled:=FALSE;
        TerminRB2_1.Font.Color:=clGray;
        TerminRB2_2.Font.Color:=clGray;
        TerminEdit.Font.Color:=clGray;
        TimeUnitCB.Font.Color:=clGray;
        CB2_5.Font.Color:=clGray;
      end;
    2:begin
        TerminGB1.Enabled:=FALSE;
        TerminRB1_1.Font.Color:=clGray;
        TerminRB1_2.Font.Color:=clGray;
        EndDate.Enabled:=FALSE;
        EndDate.Font.Color:=clGray;
        TerminGB2.Enabled:=TRUE;
        TerminRB2_1.Font.Color:=clBlack;
        TerminRB2_2.Font.Color:=clBlack;
        TerminEdit.Font.Color:=clBlack;
        TimeUnitCB.Font.Color:=clBlack;
        CB2_5.Font.Color:=clBlack;
      end;
  end;{case}
end;

procedure TPrt3Dlg.TerminRb1Click(Sender: TObject);
begin
  TerminActivate(1);
end;

procedure TPrt3Dlg.TerminRB2Click(Sender: TObject);
begin
  TerminActivate(2);
end;

procedure TPrt3Dlg.OfertaRadioGroupClick(Sender: TObject);
begin
  OfertaMemo.Enabled:=OfertaRadioGroup.ItemIndex=1;
  if OfertaMemo.Enabled
    then begin
      OfertaMemo.Font.Color:=clBlack;
      OfertaMemo.Color:=clAqua;
    end
    else begin
      OfertaMemo.Font.Color:=clSilver;
      OfertaMemo.Color:=clGray;
    end;
  FieldChange(Sender);
end;

procedure TPrt3Dlg.ContentMemo2Enter(Sender: TObject);
begin
  WhereAdd:=ContentMemo2;
  AddBitBtn.Enabled:=TRUE;
end;

procedure TPrt3Dlg.ContentMemo2Exit(Sender: TObject);
begin
  if not AddBitBtn.Focused
    then AddBitBtn.Enabled:=FALSE;
end;

procedure TPrt3Dlg.ContentMemo2DblClick(Sender: TObject);
var
  i:LongInt;
  Comp:TComponent;
begin
  AddContDlg:=TAddContDlg.Create(Self,TenderType,Phase);
  with AddContDlg do
    if ShowModal=mrOk
      then begin
        for i:=0 to AddContDlg.ComponentCount-1 do
          begin
            Comp:=AddContDlg.Components[i];
            if (Comp is TCheckBox)
              then if TCheckBox(Comp).Checked
                then begin
                  ContentMemo2.Lines.Add(TCheckBox(Comp).Caption);
                end;
          end;
      end;
  AddContDlg.Free;
end;

procedure TPrt3Dlg.ZabezActive(State:Boolean);
var
  Clr:TColor;
begin
  if State
    then Clr:=clWhite
    else Clr:=clGray;
  ZabezMemo2_1.Color:=Clr;
  ZabezCB2_2.Color:=Clr;
  ZabezMemo3_1.Color:=Clr;
  ZabezMemo2_1.Enabled:=State;
  ZabezCB2_2.Enabled:=State;
  ZabezMemo3_1.Enabled:=State;
  ZabezCB3_2.Enabled:=State;
  ZabezCB3_3.Enabled:=State;
  ZabezCB3_4.Enabled:=State;
end;

procedure TPrt3Dlg.ZabezRB1_2Click(Sender: TObject);
begin
  ZabezActive(TRUE);
end;

procedure TPrt3Dlg.ZabezRb1_3Click(Sender: TObject);
begin
  ZabezActive(FALSE);
end;

procedure TPrt3Dlg.Value1Click(Sender: TObject);
begin
  ValueDlg:=TValueDlg.Create(Self);
  with ValueDlg do
    begin
      NEdit.Value:=AmountPLN;
      if ShowModal=mrOk
        then begin
          if AmountPLN<>NEdit.Value
            then begin
              AmountPLN:=NEdit.Value;
              AmountLevel:=ALevel;
{              MessageDlg('Pamiêtaj o zmianie wartoœci wadium',mtWarning,[mbOk],0);
              Notebook.ActivePage:='Wadium';
              TabSet.TabIndex:=Notebook.PageIndex;
              WadiumEdit2_2.SetFocus;}
            end;
        end;
      Free;
    end;
end;

procedure TPrt3Dlg.Rodzaj1Click(Sender: TObject);
begin
  RodzajDlg:=TRodzajDlg.Create(Self);
  with RodzajDlg do
    begin
      SetEdit(ttZap,ObjectKind);
      if ShowModal=mrOk
        then begin
          if ObjectKind<>OKind
            then begin
              ObjectKind:=OKind;
            end;
        end;
      Free;
    end;
end;

end.


