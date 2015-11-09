unit Neg;

interface

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, StdCtrls, Mask, TabNotBk, Buttons, ExtCtrls, Menus,
  Grids, Lbtab, Clipbrd, Spin,
  WinCrt,
  Printers,
  RPrev,
  DateEdit,
  SiwzIni,
  PrzHdr2;


const

{Free space in the record}
  FreeSpaceSize=99;

  DefSelPages:Array[1..NegMaxPages] of Boolean=(FALSE,FALSE,FALSE,FALSE,FALSE,FALSE,FALSE,FALSE,FALSE,FALSE,FALSE,FALSE);

type
  TNegDlg = class(TForm)
    TitleLabel: TLabel;
    TabNotebook: TTabbedNotebook;
    ZamScrollBox: TScrollBox;
    NameLabel: TLabel;
    NameMemo: TMemo;
    StreetLabel: TLabel;
    StreetEdit: TEdit;
    TownEdit: TEdit;
    TownLabel: TLabel;
    NumberLabel: TLabel;
    ZipLabel: TLabel;
    ZipMaskEdit: TMaskEdit;
    TelEdit: TEdit;
    TelLabel: TLabel;
    FaxEdit: TEdit;
    FaxLabel: TLabel;
    TelexEdit: TEdit;
    TelexLabel: TLabel;
    RegonMaskEdit: TMaskEdit;
    RegonLabel: TLabel;
    ZamawEdit: TEdit;
    ObjectLabel: TLabel;
    TerminBevel: TBevel;
    OfertaMemo: TMemo;
    CountryBevel: TBevel;
    OfertaBevel: TBevel;
    InfoScrollBox: TScrollBox;
    InfoMemo1: TMemo;
    InfoMemo2: TMemo;
    InfoMemo3: TMemo;
    InfoMemo4: TMemo;
    InfoMemo5: TMemo;
    InfoMemo6: TMemo;
    InfoMemo7: TMemo;
    InfoMemo8: TMemo;
    InfoMemo9_1: TMemo;
    InfoMemo10: TMemo;
    InfoEdit11_1: TEdit;
    SkladScrollBox: TScrollBox;
    SkladEdit1_1: TEdit;
    SkladEdit1_14: TEdit;
    SkladEdit1_16: TEdit;
    SkladMaskEdit1_17: TMaskEdit;
    SkladMemo2: TMemo;
    SkladEdit5: TEdit;
    SkladMemo4: TMemo;
    SkladMemo5: TMemo;
    SkladMemo6: TMemo;
    SkladMemo7: TMemo;
    SkladMemo8_1: TMemo;
    SkladEdit8_2: TEdit;
    SkladEdit8_3: TEdit;
    SkladEdit8_5: TEdit;
    SkladMaskEdit8_6: TMaskEdit;
    SkladMemo8_7: TMemo;
    OpeningScrollBox: TScrollBox;
    OpeningEdit1_1: TEdit;
    OpeningEdit1_2: TEdit;
    OpeningMaskEdit1_2: TMaskEdit;
    OpeningEdit1_3: TEdit;
    OpeningEdit1_4: TEdit;
    OpeningEdit1_5: TEdit;
    OpeningEdit1_6: TEdit;
    OpeningMemo2: TMemo;
    OpeningEdit3_1: TEdit;
    OpeningEdit3_2: TEdit;
    OpeningMaskEdit3_2: TMaskEdit;
    OpeningMemo3_2: TMemo;
    ContentScrollBox: TScrollBox;
    ContentMemo1: TMemo;
    ContentMemo3: TMemo;
    OcenaScrollBox: TScrollBox;
    TitleBevel: TBevel;
    CloseBtn: TBitBtn;
    HelpBtn: TBitBtn;
    NextBitBtn: TBitBtn;
    PrevBitBtn: TBitBtn;
    PrintBitBtn: TBitBtn;
    AddBitBtn: TBitBtn;
    SaveBitBtn: TBitBtn;
    ObjectMemo: TMemo;
    Page1Button: TButton;
    ZwanyEdit: TEdit;
    Page2Button: TButton;
    Page4Button: TButton;
    Page5Button: TButton;
    SkladMemo3: TMemo;
    MainMenu1: TMainMenu;
    Plik: TMenuItem;
    Ustawieniedrukarki: TMenuItem;
    Export: TMenuItem;
    N1: TMenuItem;
    Zamknij: TMenuItem;
    PrintDlg: TPrintDialog;
    PrinterSetupDlg: TPrinterSetupDialog;
    Page12Button: TButton;
    Page7Button: TButton;
    Page8Button: TButton;
    Page9Button: TButton;
    OcenaMemo2: TMemo;
    OcenaMemo3_1: TMemo;
    OcenaMemo5: TMemo;
    OcenaMemo6: TMemo;
    OcenaMemo7: TMemo;
    OcenaMemo8: TMemo;
    OcenaMemo9: TMemo;
    OcenaMemo10: TMemo;
    OcenaMemo11: TMemo;
    Page10Button: TButton;
    ProtScrollBox: TScrollBox;
    ProtMemo1: TMemo;
    ProtMemo2: TMemo;
    ProtMemo3: TMemo;
    ProtMemo4: TMemo;
    ProtMemo5: TMemo;
    ProtMemo6: TMemo;
    ProtMemo7: TMemo;
    Page11Button: TButton;
    AnnexMemo: TMemo;
    AnnexLabel: TLabel;
    OfertaRadioGroup: TRadioGroup;
    TerminRadioGroup: TRadioGroup;
    WadiumScrollBox: TScrollBox;
    WadiumEdit1_2: TEdit;
    WadiumEdit1_1: TEdit;
    WadiumMaskEdit1: TMaskEdit;
    WadiumMemo2_1: TMemo;
    WadiumMemo2_3: TMemo;
    WadiumMemo2_4: TMemo;
    WadiumMemo3: TMemo;
    WadiumMemo4: TMemo;
    WadiumMemo5: TMemo;
    WadiumMemo6_1: TMemo;
    WadiumMaskEdit6: TMaskEdit;
    WadiumEdit6: TEdit;
    WadiumMemo6_2: TMemo;
    WadiumMemo7: TMemo;
    WadiumMemo8: TMemo;
    WadiumMemo9: TMemo;
    WadiumMemo10: TMemo;
    Page6Button: TButton;
    WadiumEdit2_1: TEdit;
    WadiumEdit2_2: TEdit;
    WadiumEdit2_3: TEdit;
    WadiumMemo2_2: TMemo;
    SkladMemo9: TMemo;
    CountryRadioGroup: TRadioGroup;
    ContentMemo2: TMemo;
    WarunScrollBox: TScrollBox;
    WarunkiEdit1: TEdit;
    WarunkiMemo1: TMemo;
    WarunkiMemo2: TMemo;
    WarunLabel2: TLabel;
    Button1: TButton;
    Drukuj1: TMenuItem;
    CountryMemo1: TMemo;
    WadiumMemo2_5: TMemo;
    Przegl1: TMenuItem;
    NipGroupBox: TGroupBox;
    NipRB1: TRadioButton;
    NipRB2: TRadioButton;
    NipMaskEdit2: TMaskEdit;
    NipMaskEdit1: TMaskEdit;
    EndDateEdit: TDateEdit;
    Bevel1: TBevel;
    IdLabel: TLabel;
    InfoDateEdit11_2: TDateEdit;
    InfoMemo9_2: TMemo;
    SkladDateEdit1_15: TDateEdit;
    SkladDateEdit8_4: TDateEdit;
    OpeningDateEdit1_1: TDateEdit;
    OpeningDateEdit3_1: TDateEdit;
    OcenaEdit1: TEdit;
    OcenaSG1: TStringGrid;
    OcenaEdit3_2: TEdit;
    OcenaEdit3_3: TEdit;
    OcenaSE2: TSpinEdit;
    OcenaMemo3_4: TMemo;
    OcenaCB1: TCheckBox;
    OcenaMemo3_5: TMemo;
    OcenaCB2: TCheckBox;
    OcenaCB3: TCheckBox;
    OcenaCB4: TCheckBox;
    OcenaMemo3_6: TMemo;
    OcenaMemo3_7: TMemo;
    OcenaMemo3_8: TMemo;
    BldgEdit: TEdit;
    RoomEdit: TEdit;
    RoomLabel: TLabel;
    CountryLabel1: TLabel;
    SaveDialog: TSaveDialog;
    SkladLabel1_2: TLabel;
    SkladMemo1_3: TMemo;
    SkladLabel1_4: TLabel;
    SkladEdit1_6: TEdit;
    SkladLabel1_5: TLabel;
    SkladMaskEdit1_7: TMaskEdit;
    SkladLabel1_8: TLabel;
    SkladEdit1_11: TEdit;
    SkladLabel1_9: TLabel;
    SkladEdit1_12: TEdit;
    SkladLabel1_10: TLabel;
    SkladEdit1_13: TEdit;
    PhaseBtn: TButton;
    procedure FormCreate(Sender: TObject);
    procedure PrevBitBtnClick(Sender: TObject);
    procedure NextBitBtnClick(Sender: TObject);
    procedure PrintBitBtnClick(Sender: TObject);
    procedure TabNotebookClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure AddBitBtnClick(Sender: TObject);
    procedure SaveBitBtnClick(Sender: TObject);
    procedure PageConfirmButtonClick(Sender: TObject);
    procedure FieldChange(Sender: TObject);
    procedure InfoMemo9_2DblClick(Sender: TObject);
    procedure CloseBtnClick(Sender: TObject);
    procedure InfoMemo9_2Enter(Sender: TObject);
    procedure InfoMemo9_2Exit(Sender: TObject);
    procedure UstawieniedrukarkiClick(Sender: TObject);
    procedure ZamknijClick(Sender: TObject);
    procedure HelpBtnClick(Sender: TObject);
    procedure OfertaRadioGroupClick(Sender: TObject);
    procedure CountryRadioGroupClick(Sender: TObject);
    procedure ContentMemo2Enter(Sender: TObject);
    procedure ContentMemo2Exit(Sender: TObject);
    procedure ContentMemo2DblClick(Sender: TObject);
    procedure WarunkiMemo2DblClick(Sender: TObject);
    procedure WarunkiMemo2Enter(Sender: TObject);
    procedure WarunkiMemo2Exit(Sender: TObject);
    procedure OcenaEdit1Exit(Sender: TObject);
    procedure OcenaEdit1Enter(Sender: TObject);
    procedure Drukuj1Click(Sender: TObject);
    procedure Przegl1Click(Sender: TObject);
    procedure NipRB1Click(Sender: TObject);
    procedure NipRB2Click(Sender: TObject);
    procedure TimeEditExit(Sender: TObject);
    procedure OcenaCBClick(Sender: TObject);
    procedure OcenaEdit1DblClick(Sender: TObject);
    procedure OcenaSE2Change(Sender: TObject);
    procedure OcenaSE2Exit(Sender: TObject);
    procedure SkladDateEdit1_15Change(Sender: TObject);
    procedure SkladDateEdit1_15Exit(Sender: TObject);
    procedure OpeningDateEdit1_1Change(Sender: TObject);
    procedure OpeningDateEdit1_1Exit(Sender: TObject);
    procedure ExportClick(Sender: TObject);
    procedure PhaseBtnClick(Sender: TObject);
  private
    { Private declarations }
    Modified:Boolean;
    SelPages:Array[0..NegMaxPages-1] of Boolean;

    PPos:Integer;
    PrintSpace:Integer;
    Ry:TRyPrinter;

    procedure MakeZamawPrint(var LP:Integer);
    procedure MakeTerminPrint(var LP:Integer);
    procedure MakeWarunkiPrint(var LP:Integer);
    procedure MakeRodzajPrint(var LP:Integer);
    procedure MakeInfoPrint(var LP:Integer);
    procedure MakeWadiumPrint(var LP:Integer);
    procedure MakeSkladPrint(var LP:Integer);
    procedure MakeOpenPrint(var LP:Integer);
    procedure MakeContentPrint(var LP:Integer);
    procedure MakeOcenaPrint(var LP:Integer);
    procedure MakeProtestPrint(var LP:Integer);
    procedure MakeCountryPrint(var LP:Integer);
    procedure MakePrint;
    procedure AddPage(var LP:Integer);
    function GetTextHeight(p:PChar):Integer;
    procedure ResetFields;
    procedure InitFields;
    procedure InitializeSiwz;
    procedure SiwzClose;
    procedure ExportToTxt(FileName:String);
  public
    { Public declarations }
    FHndl:File;
    DbDir:String;
    FileName:String;
    DefFileName:String;
    FileIsOpen:Boolean;

    Phase:Byte; {first or second phase}

    OpenMode:Byte; {New/Open}

    Id:TIdStr;             {Identifier of the tender}
    Description:TDescStr;  {SIWZ short description for retrieval}

    AmountLevel:Integer;   {cost levels, see SiwzIni}
    ObjectKind:Integer;     {Dostawa / Us³ugi / Roboty bud.}
    AmountPLN:Real;    {cost}

    WhereAdd:TObject;
    procedure SaveToFile(var FH:File; Id,Desc:String; Default:Boolean);
    procedure LoadFromFile(var FH:File; Default:Boolean);
    procedure SetPhase;
  end;

var
  NegDlg: TNegDlg;

procedure Negocjacje(FDbDir,FileName,FId,FDesc:String;
                               PLN:Real; ALevel:Integer;
                               OKind,OMode:Byte); export;

implementation

{$R *.DFM}

uses
  Msg2,
  Utils,
  DateUtil,
  PlCalDlg,
  Save,
  NewSiwz,
  Info9,
  AddWar,
  AddCont,
  Kriteria;


procedure Negocjacje(FDbDir,FileName,FId,FDesc:String;
                     PLN:Real; ALevel:Integer;
                     OKind,OMode:Byte);
var
  Curs:Integer;
  Del:Boolean;
begin
  Curs:=Screen.Cursor;
  Screen.Cursor:=crHourGlass;
  GetAllConfiguration;
  Application.HelpFile:=SiwzHelpFile;
  AssignFile(FHandle,AddBackSlash(FDbDir)+FileName);
  FileMode:=fmOpenReadWrite + fmShareDenyWrite;
  try
    if OMode=oOpen
      then Reset(FHandle,1)
    else if OMode=oNew
      then Rewrite(FHandle,1);
    NegDlg:=TNegDlg.Create(Nil);
    NegDlg.DbDir:=FDbDir;
    NegDlg.FileName:=FileName;
    NegDlg.Id:=FId;
    NegDlg.Description:=FDesc;
    NegDlg.OpenMode:=OMode;
    NegDlg.AmountPLN:=PLN;
    NegDlg.AmountLevel:=ALevel;
    NegDlg.ObjectKind:=OKind;
    Screen.Cursor:=Curs;
    NegDlg.ShowModal;
    NegDlg.Free;
    Del:=FileSize(FHandle)<Length(VersionString+NegFileHdr)+2;
    CloseFile(FHandle);
    if Del
      then DeleteFile(AddBackSlash(FDbDir)+FileName);
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

procedure TNegDlg.FormCreate(Sender: TObject);
var
  i:Byte;
begin
  Menu:=MainMenu1;
  OpenMode:=oNew;
  AmountLevel:=-1;
  AmountPLN:=-1;
  ObjectKind:=-1;
  FileIsOpen:=TRUE;
  Phase:=1;

  TabNoteBook.PageIndex:=0;
  ZamScrollBox.ScrollInView(NameLabel);
  WarunScrollBox.ScrollInView(WarunkiEdit1);
  InfoScrollBox.ScrollInView(InfoMemo1);
  WadiumScrollBox.ScrollInView(WadiumEdit1_1);
  SkladScrollBox.ScrollInView(SkladEdit1_1);
  OpeningScrollBox.ScrollInView(OpeningEdit1_1);
  ContentScrollBox.ScrollInView(ContentMemo1);
  OcenaScrollBox.ScrollInView(OcenaEdit1);
  ProtScrollBox.ScrollInView(ProtMemo1);

  OcenaSG1.ColWidths[ECol]:=KrytEvalModeLen;
  OcenaSG1.ColWidths[DCol]:=KrytDescLen;
  OcenaSG1.Cells[WCol,0]:='Waga';
  OcenaSG1.Cells[DCol,0]:='Opis';
  OcenaSG1.Cells[ECol,0]:='Sposób';

{Reset TabNotebook pages}
  with TabNotebook do
    for i:=0 to NegMaxPages-1 do
      begin
        SelPages[i]:=FALSE;
        if Pages[i][1]='#'
          then Pages[i]:=Copy(Pages[i],3,Length(Pages[i])-2);
      end;

{ no Preferencje krajowe}
  if CountryRadioGroup.ItemIndex=1
    then begin
      OcenaMemo5.Color:=clGray;
      OcenaMemo5.Enabled:=FALSE;
    end;

  PrevBitBtn.Enabled:=FALSE;
  AddBitBtn.Enabled:=FALSE;
end;

procedure TNegDlg.InitializeSiwz;
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
        FileIsOpen:=TRUE;
        InitFields;
        LoadFromFile(F,TRUE);
        CloseFile(F);
        EndDateEdit.Date:=Now;
        InfoDateEdit11_2.Date:=Now;
        OpeningDateEdit1_1.Date:=Now;
        OpeningDateEdit3_1.Date:=Now;
        SkladDateEdit1_15.Date:=Now;
        SkladDateEdit8_4.Date:=Now;
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
    InfoDateEdit11_2.Date:=Now;
    OpeningDateEdit1_1.Date:=Now;
    OpeningDateEdit3_1.Date:=Now;
    SkladDateEdit1_15.Date:=Now;
    SkladDateEdit8_4.Date:=Now;
  end;
end;

procedure TNegDlg.ResetFields;
begin
  NipMaskEdit2.Enabled:=FALSE;
  NipRB1.Checked:=TRUE;
  NipRB2.Checked:=FALSE;
  OcenaCB1.Checked:=FALSE;
  OcenaCB2.Checked:=FALSE;
  OcenaCB3.Checked:=FALSE;
  OcenaCB4.Checked:=FALSE;
  OcenaMemo3_5.Enabled:=FALSE;
  OcenaMemo3_6.Enabled:=FALSE;
  OcenaMemo3_7.Enabled:=FALSE;
  OcenaMemo3_8.Enabled:=FALSE;
  OcenaMemo3_5.Color:=clGray;
  OcenaMemo3_6.Color:=clGray;
  OcenaMemo3_7.Color:=clGray;
  OcenaMemo3_8.Color:=clGray;
end;

procedure TNegDlg.InitFields;
begin
{ Zamaw. }
  NameMemo.Clear;
  StreetEdit.Clear;
  TownEdit.Clear;
  BldgEdit.Clear;
  RoomEdit.Clear;
  ZipMaskEdit.Clear;
  TelEdit.Clear;
  FaxEdit.Clear;
  RegonMaskEdit.Clear;
  NipMaskEdit1.Clear;
  NipMaskEdit2.Clear;
  NipMaskEdit2.Enabled:=FALSE;
  NipRB1.Checked:=TRUE;
  NipRB2.Checked:=FALSE;
  ZwanyEdit.Clear;
  ZamawEdit.Clear;
  ObjectMemo.Clear;
  AnnexMemo.Clear;
{Termin}
  TerminRadioGroup.ItemIndex:=0;
  EndDateEdit.Clear;
{Warunki}
  WarunkiEdit1.Clear;
  WarunkiMemo1.Clear;
  WarunkiMemo2.Clear;
{Rodzaj}
  OfertaMemo.Clear;
{Info}
  InfoMemo1.Clear;
  InfoMemo2.Clear;
  InfoMemo3.Clear;
  InfoMemo4.Clear;
  InfoMemo5.Clear;
  InfoMemo6.Clear;
  InfoMemo7.Clear;
  InfoMemo8.Clear;
  InfoMemo9_1.Clear;
  InfoMemo9_2.Clear;
  InfoMemo10.Clear;
  InfoEdit11_1.Clear;
{Wadium}
  WadiumEdit1_1.Clear;
  WadiumMaskEdit1.Clear;
  WadiumEdit1_2.Clear;
  WadiumMemo2_1.Clear;
  WadiumEdit2_1.Clear;
  WadiumEdit2_2.Clear;
  WadiumEdit2_3.Clear;
  WadiumMemo2_2.Clear;
  WadiumMemo2_3.Clear;
  WadiumMemo2_4.Clear;
  WadiumMemo2_5.Clear;
  WadiumMemo3.Clear;
  WadiumMemo4.Clear;
  WadiumMemo5.Clear;
  WadiumMemo6_1.Clear;
  WadiumMaskEdit6.Clear;
  WadiumEdit6.Clear;
  WadiumMemo6_2.Clear;
  WadiumMemo7.Clear;
  WadiumMemo8.Clear;
  WadiumMemo9.Clear;
  WadiumMemo10.Clear;
{Skladanie}
  SkladEdit1_1.Clear;
  SkladMemo1_3.Clear;
  SkladEdit1_6.Clear;
  SkladMaskEdit1_7.Clear;
  SkladEdit1_11.Clear;
  SkladEdit1_12.Clear;
  SkladEdit1_13.Clear;
  SkladEdit1_14.Clear;
  SkladDateEdit1_15.Clear;
  SkladEdit1_16.Clear;
  SkladMaskEdit1_17.Clear;
  SkladMemo2.Clear;
  SkladMemo3.Clear;
  SkladMemo4.Clear;
  SkladEdit5.Clear;
  SkladMemo5.Clear;
  SkladMemo6.Clear;
  SkladMemo7.Clear;
  SkladMemo8_1.Clear;
  SkladEdit8_2.Clear;
  SkladEdit8_3.Clear;
  SkladDateEdit8_4.Clear;
  SkladEdit8_5.Clear;
  SkladMaskEdit8_6.Clear;
  SkladMemo8_7.Clear;
  SkladMemo9.Clear;
{Otwarcie}
  OpeningEdit1_1.Clear;
  OpeningDateEdit1_1.Clear;
  OpeningEdit1_2.Clear;
  OpeningMaskEdit1_2.Clear ;
  OpeningEdit1_3.Clear;
  OpeningEdit1_4.Clear;
  OpeningEdit1_5.Clear;
  OpeningEdit1_6.Clear;
  OpeningMemo2.Clear;
  OpeningEdit3_1.Clear;
  OpeningDateEdit3_1.Clear;
  OpeningEdit3_2.Clear;
  OpeningMaskEdit3_2.Clear;
  OpeningMemo3_2.Clear;
{Zawartosc}
  ContentMemo1.Clear;
  ContentMemo2.Clear;
  ContentMemo3.Clear;
{Ocena}
  OcenaEdit1.Clear;
{  OcenaSG1.Clear;}
  OcenaMemo2.Clear;
  OcenaMemo3_1.Clear;
  OcenaEdit3_2.Clear;
  OcenaSE2.Clear;
  OcenaEdit3_3.Clear;
  OcenaMemo3_4.Clear;
  OcenaMemo3_5.Clear;
  OcenaMemo3_6.Clear;
  OcenaMemo3_7.Clear;
  OcenaMemo3_8.Clear;
  OcenaMemo5.Clear;
  OcenaMemo6.Clear;
  OcenaMemo7.Clear;
  OcenaMemo8.Clear;
  OcenaMemo9.Clear;
  OcenaMemo10.Clear;
  OcenaMemo11.Clear;
  OcenaCB1.Checked:=FALSE;
  OcenaCB2.Checked:=FALSE;
  OcenaCB3.Checked:=FALSE;
  OcenaCB4.Checked:=FALSE;
  OcenaMemo3_5.Color:=clGray;
  OcenaMemo3_6.Color:=clGray;
  OcenaMemo3_7.Color:=clGray;
  OcenaMemo3_8.Color:=clGray;
  OcenaMemo3_5.Enabled:=FALSE;
  OcenaMemo3_6.Enabled:=FALSE;
  OcenaMemo3_7.Enabled:=FALSE;
  OcenaMemo3_8.Enabled:=FALSE;
{Protesty}
  ProtMemo1.Clear;
  ProtMemo2.Clear;
  ProtMemo3.Clear;
  ProtMemo4.Clear;
  ProtMemo5.Clear;
  ProtMemo6.Clear;
  ProtMemo7.Clear;
{Pref. krajowe}
  CountryRadioGroup.ItemIndex:=0;
  CountryMemo1.Clear;
end;

procedure TNegDlg.SetPhase;
begin
  if Phase=1
    then begin
      Caption:=UpperCase(sNegocjacje)+' '+mFirstPhase;
      ContentMemo1.Color:=clWhite;
      ContentMemo2.Color:=clYellow;
      WadiumEdit1_1.Color:=clWhite;
      WadiumMaskEdit1.Color:=clWhite;
      WadiumEdit1_2.Color:=clWhite;
      WadiumMemo2_1.Color:=clWhite;
      WadiumEdit2_1.Color:=clWhite;
      WadiumEdit2_2.Color:=clWhite;
      WadiumEdit2_3.Color:=clWhite;
      WadiumMemo2_2.Color:=clWhite;
      WadiumMemo2_3.Color:=clWhite;
      WadiumMemo2_4.Color:=clWhite;
      WadiumMemo3.Color:=clWhite;
      WadiumMemo4.Color:=clWhite;
      WadiumMemo5.Color:=clWhite;
      if (ObjectKind=okRobBud)
        then begin
          WadiumMemo6_1.Color:=clWhite;
          WadiumEdit6.Color:=clWhite;
          WadiumMemo6_2.Color:=clWhite;
          WadiumMemo7.Color:=clWhite;
          WadiumMemo8.Color:=clWhite;
          WadiumMemo9.Color:=clWhite;
          WadiumMemo10.Color:=clWhite;
        end;
      ProtMemo1.Color:=clWhite;
      ProtMemo2.Color:=clWhite;
      ProtMemo3.Color:=clWhite;
      ProtMemo4.Color:=clWhite;
      ProtMemo5.Color:=clWhite;
      ProtMemo6.Color:=clWhite;
      ProtMemo7.Color:=clWhite;
    end
    else begin
      Caption:=UpperCase(sNegocjacje)+' '+mSecondPhase;
      if ((AmountLevel=alMedium) or (AmountLevel=alHigh))
        then begin
          ContentMemo1.Color:=clAqua;
          ContentMemo2.Color:=clYellow;
          WadiumEdit1_1.Color:=clAqua;
          WadiumMaskEdit1.Color:=clAqua;
          WadiumEdit1_2.Color:=clAqua;
          WadiumMemo2_1.Color:=clAqua;
          WadiumEdit2_1.Color:=clAqua;
          WadiumEdit2_2.Color:=clAqua;
          WadiumEdit2_3.Color:=clAqua;
          WadiumMemo2_2.Color:=clAqua;
          WadiumMemo2_3.Color:=clAqua;
          WadiumMemo2_4.Color:=clAqua;
          WadiumMemo3.Color:=clAqua;
          WadiumMemo4.Color:=clAqua;
          WadiumMemo5.Color:=clAqua;
          if (ObjectKind=okRobBud)
            then begin
              WadiumMemo6_1.Color:=clAqua;
              WadiumEdit6.Color:=clAqua;
              WadiumMemo6_2.Color:=clAqua;
              WadiumMemo7.Color:=clAqua;
              WadiumMemo8.Color:=clAqua;
              WadiumMemo9.Color:=clAqua;
              WadiumMemo10.Color:=clAqua;
            end;
          ProtMemo1.Color:=clAqua;
          ProtMemo2.Color:=clAqua;
          ProtMemo3.Color:=clAqua;
          ProtMemo4.Color:=clAqua;
          ProtMemo5.Color:=clAqua;
          ProtMemo6.Color:=clAqua;
          ProtMemo7.Color:=clAqua;
        end;
    end;
end;

procedure TNegDlg.FormActivate(Sender: TObject);
var
  i:Byte;
begin
  FileName:=FileName+'.'+NegExt;
  DefFileName:=DefaultFileName+'.'+NegExt;
  IdLabel.Caption:=Id;
  TitleLabel.Caption:=Description;

  if OpenMode=oNew   { initialize new SIWZ kind fields }
    then begin
      ZamawEdit.Text:=AddEndSpaceIfNone(sOglasza)+sNegocjacje;
      with ZamawEdit do
        case ObjectKind of
          okDostawa: Text:=Text+sNaWykonanie+sDostaw;
          okUslugi: Text:=Text+sNaWykonanie+sUslug;
          okRobBud: Text:=Text+sNaWykonanie+sRobotBud;
        end;{case}
      with WarunkiEdit1 do
        case ObjectKind Of
          okDostawa: Text:=sWarunkiEdit1+sDostawcy+sWarunkiEdit2;
          okUslugi: Text:=sWarunkiEdit1+sWykonawcy+sWarunkiEdit2;
          okRobBud: Text:=sWarunkiEdit1+sWykonawcy+sWarunkiEdit2;
        end;{case}
      OfertaRadioGroup.ItemIndex:=0;
    end;

  with OfertaRadioGroup do  {initialize Oferta fields}
    case ObjectKind Of
      okDostawa: Items[1]:=sOfertaCzesc+sDostawy;
      okUslugi: Items[1]:=sOfertaCzesc+sUslugi;
      okRobBud: Items[1]:=sOfertaCzesc+sRobotyBud;
    end;{case}

  InitializeSiwz;

  WarunkiEdit1.Color:=clWhite;
  WarunkiMemo1.Color:=clWhite;
  WarunkiMemo2.Color:=clWhite;
  InfoMemo9_2.Color:=clWhite;
  InfoEdit11_1.Color:=clWhite;
  InfoDateEdit11_2.Color:=clWhite;
  SkladEdit1_1.Color:=clWhite;
  SkladMemo1_3.Color:=clWhite;
  SkladEdit1_6.Color:=clWhite;
  SkladMaskEdit1_7.Color:=clWhite;
  SkladEdit1_11.Color:=clWhite;
  SkladEdit1_12.Color:=clWhite;
  SkladEdit1_13.Color:=clWhite;
  SkladEdit1_14.Color:=clWhite;
  SkladDateEdit1_15.Color:=clWhite;
  SkladEdit1_16.Color:=clWhite;
  SkladMaskEdit1_17.Color:=clWhite;
  SkladMemo3.Color:=clWhite;
  OpeningEdit1_1.Color:=clWhite;
  OpeningEdit1_2.Color:=clWhite;
  OpeningEdit1_3.Color:=clWhite;
  OpeningEdit1_4.Color:=clWhite;
  OpeningEdit1_5.Color:=clWhite;
  OpeningEdit1_6.Color:=clWhite;
  OpeningDateEdit1_1.Color:=clWhite;
  OpeningMaskEdit1_2.Color:=clWhite;
  OpeningEdit3_1.Color:=clWhite;
  OpeningDateEdit3_1.Color:=clWhite;
  OpeningEdit3_2.Color:=clWhite;
  OpeningMaskEdit3_2.Color:=clWhite;
  OpeningMemo3_2.Color:=clWhite;
  OcenaEdit1.Color:=clWhite;
  OcenaMemo8.Color:=clWhite;
  OcenaMemo9.Color:=clWhite;

  SetPhase;

  with OfertaRadioGroup do  {initialize Oferta fields}
    begin
      OfertaMemo.Enabled:=(ItemIndex=1);
      if OfertaMemo.Enabled
        then OfertaMemo.Color:=clAqua
        else OfertaMemo.Color:=clGray;
    end;

{Set the parts depending on the amount of money}
  if AmountLevel in [alMin,alLow]
    then begin
      OpeningEdit3_1.Enabled:=FALSE;
      OpeningEdit3_1.Font.Color:=clSilver;
      OpeningEdit3_2.Enabled:=FALSE;
      OpeningEdit3_2.Font.Color:=clSilver;
      OpeningDateEdit3_1.Enabled:=FALSE;
      OpeningDateEdit3_1.Font.Color:=clSilver;
      OpeningMaskEdit3_2.Enabled:=FALSE;
      OpeningMaskEdit3_2.Font.Color:=clSilver;
      OpeningMemo3_2.Enabled:=FALSE;
      OpeningMemo3_2.Font.Color:=clSilver;
    end;

  Modified:=FALSE;
end;

procedure TNegDlg.PrevBitBtnClick(Sender: TObject);
begin
  if TabNotebook.PageIndex>0
    then TabNotebook.PageIndex:=TabNotebook.PageIndex-1;
  PrevBitBtn.Enabled:= TabNotebook.PageIndex>0;
  NextBitBtn.Enabled:= TabNotebook.PageIndex<NegMaxPages-1;
end;

procedure TNegDlg.NextBitBtnClick(Sender: TObject);
begin
  if TabNotebook.PageIndex<NegMaxPages-1
    then TabNotebook.PageIndex:=TabNotebook.PageIndex+1;
  PrevBitBtn.Enabled:= TabNotebook.PageIndex>0;
  NextBitBtn.Enabled:= TabNotebook.PageIndex<NegMaxPages-1;
end;

procedure TNegDlg.TabNotebookClick(Sender: TObject);
begin
  PrevBitBtn.Enabled:= TabNotebook.PageIndex>0;
  NextBitBtn.Enabled:= TabNotebook.PageIndex<NegMaxPages-1;
end;

{Date fields}

procedure TNegDlg.InfoMemo9_2Enter(Sender: TObject);
begin
  WhereAdd:=InfoMemo9_2;
  AddBitBtn.Enabled:=TRUE;
end;

procedure TNegDlg.InfoMemo9_2Exit(Sender: TObject);
begin
  if not AddBitBtn.Focused
    then AddBitBtn.Enabled:=FALSE;
end;

procedure TNegDlg.InfoMemo9_2DblClick(Sender: TObject);
var
  i:Byte;
  j:LongInt;
  Line:String;
  Already:Boolean;
begin
  Info9Dlg:=TInfo9Dlg.Create(Nil);
  with Info9Dlg do
    begin
      OuExt:=NegOuExt;
      Kind:=ObjectKind;
      if ShowModal=mrOk
        then for i:=0 to Info9MaxPages-1 do
          if Info9Dlg.SelPages[i]
            then if (StripAllSpaces(GetName(i))<>'')
              then begin
                Line:=GetName(i);
                if StripAllSpaces(GetRoom(i))<>''
                  then Line:=Line+' '+s9Room+' '+GetRoom(i);
                if StripAllSpaces(GetTel(i))<>''
                  then Line:=Line+' '+s9Tel+' '+GetTel(i);
                with InfoMemo9_2 do {lines already in SIWZ}
                  if Lines.Count<=0
                    then Lines.Add(Line)
                    else begin
                      for j:=0 to Lines.Count-1 do
                        begin
                          Already:=Pos(UpperCase(StripAllSpaces(GetName(i))),
                                       UpperCase(StripAllSpaces(Lines[j])))>0;
                          if Already
                            then Break;
                        end;
                      if not Already
                        then Lines.Add(Line);
                    end;
              end;
      Free;
    end;
end;

procedure TNegDlg.WarunkiMemo2DblClick(Sender: TObject);
var
  i:LongInt;
  Comp:TComponent;
begin
  AddWarDlg:=TAddWarDlg.Create(Self);
  with AddWarDlg do
    if ShowModal=mrOk
      then begin
        for i:=0 to AddWarDlg.ComponentCount-1 do
          begin
            Comp:=AddWarDlg.Components[i];
            if (Comp is TCheckBox)
              then if TCheckBox(Comp).Checked
                then begin
                  WarunkiMemo2.Lines.Add(TCheckBox(Comp).Caption);
{                  WarunkiMemo2.Lines.Add(Chr(13));}
                end;
          end;
      end;
  AddWarDlg.Free;
end;

procedure TNegDlg.WarunkiMemo2Enter(Sender: TObject);
begin
  WhereAdd:=WarunkiMemo2;
  AddBitBtn.Enabled:=TRUE;
end;

procedure TNegDlg.WarunkiMemo2Exit(Sender: TObject);
begin
  if not AddBitBtn.Focused
    then AddBitBtn.Enabled:=FALSE;
end;

procedure TNegDlg.ContentMemo2DblClick(Sender: TObject);
var
  i:LongInt;
  Comp:TComponent;
begin
  AddContDlg:=TAddContDlg.Create(Self);
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
{                  ContentMemo2.Lines.Add(Chr(13));}
                end;
          end;
      end;
  AddContDlg.Free;
end;

procedure TNegDlg.ContentMemo2Enter(Sender: TObject);
begin
  WhereAdd:=ContentMemo2;
  AddBitBtn.Enabled:=TRUE;
end;

procedure TNegDlg.ContentMemo2Exit(Sender: TObject);
begin
  if not AddBitBtn.Focused
    then AddBitBtn.Enabled:=FALSE;
end;

procedure TNegDlg.OcenaEdit1Enter(Sender: TObject);
begin
  WhereAdd:=OcenaEdit1;
  AddBitBtn.Enabled:=TRUE;
end;

procedure TNegDlg.OcenaEdit1Exit(Sender: TObject);
begin
  if not AddBitBtn.Focused
    then AddBitBtn.Enabled:=FALSE;
end;

procedure TNegDlg.AddBitBtnClick(Sender: TObject);
begin
  if WhereAdd=WarunkiMemo2
    then begin
      WarunkiMemo2DblClick(WhereAdd);
      WarunkiMemo2.SetFocus;
    end
  else if WhereAdd=ContentMemo2
    then begin
      ContentMemo2DblClick(WhereAdd);
      ContentMemo2.SetFocus;
    end
  else if WhereAdd=OcenaEdit1
    then begin
      OcenaEdit1DblClick(WhereAdd);
      OcenaSG1.SetFocus;
    end
  else if WhereAdd=InfoMemo9_2
    then begin
      InfoMemo9_2DblClick(WhereAdd);
      InfoMemo9_2.SetFocus;
    end
end;

procedure TNegDlg.SaveBitBtnClick(Sender: TObject);
var
  F:File;
begin
  SaveDlg:=TSaveDlg.Create(Self);
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
                NewSiwzDlg.NewExt:=NegExt;
                NewSiwzDlg.DbDir:=DbDir;
                if NewSiwzDlg.ShowModal=mrOk
                  then begin
                    try
                      AssignFile(F,AddBackSlash(DbDir)+NewSiwzDlg.NewFileName+'.'+NegExt);
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
                          FileIsOpen:=FALSE;
                        end;
                    end;
                  end;
                NewSiwzDlg.Free;
              end;
            2: {Domyœlna}
              try
                AssignFile(F,AddBackSlash(DbDir)+DefaultFileName+'.'+NegExt);
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
                    FileIsOpen:=FALSE;
                  end;
              end;
          end;{case}
        end;
    end;
  SaveDlg.Free;
end;

procedure TNegDlg.SaveToFile(var FH:File; Id,Desc:String; Default:Boolean);
var
  i:Byte;
begin
  try
    MakeFKey(ExtractFilePath(FileName));
    SaveString(VersionString+NegFileHdr,FH);
    SaveInteger(FKey,FH);
    SaveString(Id,FH);
    SaveString(Desc,FH);
    SaveInteger(AmountLevel,FH);
    SaveInteger(ObjectKind,FH);
    SaveReal(AmountPLN,FH);
    if Default
      then SaveByte(1,FH)
      else SaveByte(Phase,FH);
    if Default
      then for i:=0 to NegMaxPages-1 do
        SaveBoolean(DefSelPages[i],FH)
      else for i:=0 to NegMaxPages-1 do
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
    SaveEdit(ZwanyEdit,FH);
    SaveEdit(ZamawEdit,FH);
    SaveMemo(ObjectMemo,FH);
    SaveMemo(AnnexMemo,FH);
{Termin}
    SaveInteger(TerminRadioGroup.ItemIndex,FH);
    SaveDateEdit(EndDateEdit,FH);
{Warunki}
    SaveEdit(WarunkiEdit1,FH);
    SaveMemo(WarunkiMemo1,FH);
    SaveMemo(WarunkiMemo2,FH);
{Rodzaj}
    SaveInteger(OfertaRadioGroup.ItemIndex,FH);
    SaveMemo(OfertaMemo,FH);
{Info}
    SaveMemo(InfoMemo1,FH);
    SaveMemo(InfoMemo2,FH);
    SaveMemo(InfoMemo3,FH);
    SaveMemo(InfoMemo4,FH);
    SaveMemo(InfoMemo5,FH);
    SaveMemo(InfoMemo6,FH);
    SaveMemo(InfoMemo7,FH);
    SaveMemo(InfoMemo8,FH);
    SaveMemo(InfoMemo9_1,FH);
    SaveMemo(InfoMemo9_2,FH);
    SaveMemo(InfoMemo10,FH);
    SaveEdit(InfoEdit11_1,FH);
    SaveDateEdit(InfoDateEdit11_2,FH);
{Wadium}
    SaveEdit(WadiumEdit1_1,FH);
    SaveMaskEdit(WadiumMaskEdit1,FH);
    SaveEdit(WadiumEdit1_2,FH);
    SaveMemo(WadiumMemo2_1,FH);
    SaveEdit(WadiumEdit2_1,FH);
    SaveEdit(WadiumEdit2_2,FH);
    SaveEdit(WadiumEdit2_3,FH);
    SaveMemo(WadiumMemo2_2,FH);
    SaveMemo(WadiumMemo2_3,FH);
    SaveMemo(WadiumMemo2_4,FH);
    SaveMemo(WadiumMemo2_5,FH);
    SaveMemo(WadiumMemo3,FH);
    SaveMemo(WadiumMemo4,FH);
    SaveMemo(WadiumMemo5,FH);
    SaveMemo(WadiumMemo6_1,FH);
    SaveMaskEdit(WadiumMaskEdit6,FH);
    SaveEdit(WadiumEdit6,FH);
    SaveMemo(WadiumMemo6_2,FH);
    SaveMemo(WadiumMemo7,FH);
    SaveMemo(WadiumMemo8,FH);
    SaveMemo(WadiumMemo9,FH);
    SaveMemo(WadiumMemo10,FH);
{Sklad}
    SaveEdit(SkladEdit1_1,FH);
    SaveMemo(SkladMemo1_3,FH);
    SaveEdit(SkladEdit1_6,FH);
    SaveMaskEdit(SkladMaskEdit1_7,FH);
    SaveEdit(SkladEdit1_11,FH);
    SaveEdit(SkladEdit1_12,FH);
    SaveEdit(SkladEdit1_13,FH);
    SaveEdit(SkladEdit1_14,FH);
    SaveDateEdit(SkladDateEdit1_15,FH);
    SaveEdit(SkladEdit1_16,FH);
    SaveMaskEdit(SkladMaskEdit1_17,FH);
    SaveMemo(SkladMemo2,FH);
    SaveMemo(SkladMemo3,FH);
    SaveMemo(SkladMemo4,FH);
    SaveEdit(SkladEdit5,FH);
    SaveMemo(SkladMemo5,FH);
    SaveMemo(SkladMemo6,FH);
    SaveMemo(SkladMemo7,FH);
    SaveMemo(SkladMemo8_1,FH);
    SaveEdit(SkladEdit8_2,FH);
    SaveEdit(SkladEdit8_3,FH);
    SaveDateEdit(SkladDateEdit8_4,FH);
    SaveEdit(SkladEdit8_5,FH);
    SaveMaskEdit(SkladMaskEdit8_6,FH);
    SaveMemo(SkladMemo8_7,FH);
    SaveMemo(SkladMemo9, FH);
{Otwarcie}
    SaveEdit(OpeningEdit1_1,FH);
    SaveDateEdit(OpeningDateEdit1_1,FH);
    SaveEdit(OpeningEdit1_2,FH);
    SaveMaskEdit(OpeningMaskEdit1_2,FH);
    SaveEdit(OpeningEdit1_3,FH);
    SaveEdit(OpeningEdit1_4,FH);
    SaveEdit(OpeningEdit1_5,FH);
    SaveEdit(OpeningEdit1_6,FH);
    SaveMemo(OpeningMemo2,FH);
    SaveEdit(OpeningEdit3_1,FH);
    SaveDateEdit(OpeningDateEdit3_1,FH);
    SaveEdit(OpeningEdit3_2,FH);
    SaveMaskEdit(OpeningMaskEdit3_2,FH);
    SaveMemo(OpeningMemo3_2,FH);
{Zawartosc}
    SaveMemo(ContentMemo1,FH);
    SaveMemo(ContentMemo2,FH);
    SaveMemo(ContentMemo3,FH);
{Ocena}
    SaveEdit(OcenaEdit1,FH);
    SaveStringGrid(OcenaSG1,FH);
    SaveMemo(OcenaMemo2,FH);
    SaveMemo(OcenaMemo3_1,FH);
    SaveEdit(OcenaEdit3_2,FH);
    SaveSpinEdit(OcenaSE2,FH);
    SaveEdit(OcenaEdit3_3,FH);
    SaveMemo(OcenaMemo3_4,FH);
    SaveMemo(OcenaMemo3_5,FH);
    SaveMemo(OcenaMemo3_6,FH);
    SaveMemo(OcenaMemo3_7,FH);
    SaveMemo(OcenaMemo3_8,FH);
    SaveMemo(OcenaMemo5,FH);
    SaveMemo(OcenaMemo6,FH);
    SaveMemo(OcenaMemo7,FH);
    SaveMemo(OcenaMemo8,FH);
    SaveMemo(OcenaMemo9,FH);
    SaveMemo(OcenaMemo10,FH);
    SaveMemo(OcenaMemo11,FH);
{Protesty}
    SaveMemo(ProtMemo1,FH);
    SaveMemo(ProtMemo2,FH);
    SaveMemo(ProtMemo3,FH);
    SaveMemo(ProtMemo4,FH);
    SaveMemo(ProtMemo5,FH);
    SaveMemo(ProtMemo6,FH);
    SaveMemo(ProtMemo7,FH);
{Pref. kraiowe}
    SaveInteger(CountryRadioGroup.ItemIndex,FH);
    SaveMemo(CountryMemo1,FH);
  except
    on E:EInOutError do
      MessageDlg(IntToStr(E.ErrorCode),mtWarning,[mbOk],0);
  end;
end;

procedure TNegDlg.LoadFromFile(var FH:File; Default:Boolean);
var
  LId:String;
  LDesc:String;
  Am:Integer;
  OKind:Integer;
  APLN:Real;
  Ph:Byte;
  i:Integer;
  B:Boolean;
  SP:Array[0..NegMaxPages-1] of Boolean;
  T:Integer;
  s:String;
  Event:TNotifyEvent;
begin
  try
    MakeFKey(ExtractFilePath(FileName));
    LoadString(s,FH);
    if s=VersionString+NegFileHdr
      then begin
        LoadInteger(i,FH);
        if i=FKey
          then begin
            LoadString(LId,FH);
            LoadString(LDesc,FH);
            LoadInteger(Am,FH);
            LoadInteger(OKind,FH);
            LoadReal(APLN,FH);
            LoadByte(Ph,FH);
            if not Default
              then begin
                Description:=LDesc;
                Id:=LId;
                AmountPLN:=APLN;
                ObjectKind:=OKind;
                AmountLevel:=Am;
                Phase:=Ph;
              end;
            for i:=0 to NegMaxPages-1 do
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
            LoadEdit(ZwanyEdit,FH);
            LoadEdit(ZamawEdit,FH);
            LoadMemo(ObjectMemo,FH);
            LoadMemo(AnnexMemo,FH);
{Termin}
            LoadInteger(T,FH);
            if not Default
              then TerminRadioGroup.ItemIndex:=T;
            LoadDateEdit(EndDateEdit,FH);
{Warunki}
            LoadEdit(WarunkiEdit1,FH);
            LoadMemo(WarunkiMemo1,FH);
            LoadMemo(WarunkiMemo2,FH);
{Rodzaj}
            LoadInteger(T,FH);
            if not Default
              then begin
                OfertaRadioGroup.ItemIndex:=T;
                OfertaMemo.Enabled:=(T=1);
                if OfertaMemo.Enabled
                  then OfertaMemo.Color:=clAqua
                  else OfertaMemo.Color:=clGray;
              end;
            LoadMemo(OfertaMemo,FH);
{Info}
            LoadMemo(InfoMemo1,FH);
            LoadMemo(InfoMemo2,FH);
            LoadMemo(InfoMemo3,FH);
            LoadMemo(InfoMemo4,FH);
            LoadMemo(InfoMemo5,FH);
            LoadMemo(InfoMemo6,FH);
            LoadMemo(InfoMemo7,FH);
            LoadMemo(InfoMemo8,FH);
            LoadMemo(InfoMemo9_1,FH);
            LoadMemo(InfoMemo9_2,FH);
            LoadMemo(InfoMemo10,FH);
            LoadEdit(InfoEdit11_1,FH);
            LoadDateEdit(InfoDateEdit11_2,FH);
{Wadium}
            LoadEdit(WadiumEdit1_1,FH);
            LoadMaskEdit(WadiumMaskEdit1,FH);
            LoadEdit(WadiumEdit1_2,FH);
            LoadMemo(WadiumMemo2_1,FH);
            LoadEdit(WadiumEdit2_1,FH);
            LoadEdit(WadiumEdit2_2,FH);
            LoadEdit(WadiumEdit2_3,FH);
            LoadMemo(WadiumMemo2_2,FH);
            LoadMemo(WadiumMemo2_3,FH);
            LoadMemo(WadiumMemo2_4,FH);
            LoadMemo(WadiumMemo2_5,FH);
            LoadMemo(WadiumMemo3,FH);
            LoadMemo(WadiumMemo4,FH);
            LoadMemo(WadiumMemo5,FH);
            LoadMemo(WadiumMemo6_1,FH);
            LoadMaskEdit(WadiumMaskEdit6,FH);
            LoadEdit(WadiumEdit6,FH);
            LoadMemo(WadiumMemo6_2,FH);
            LoadMemo(WadiumMemo7,FH);
            LoadMemo(WadiumMemo8,FH);
            LoadMemo(WadiumMemo9,FH);
            LoadMemo(WadiumMemo10,FH);
{Sklad}
            LoadEdit(SkladEdit1_1,FH);
            LoadMemo(SkladMemo1_3,FH);
            LoadEdit(SkladEdit1_6,FH);
            LoadMaskEdit(SkladMaskEdit1_7,FH);
            LoadEdit(SkladEdit1_11,FH);
            LoadEdit(SkladEdit1_12,FH);
            LoadEdit(SkladEdit1_13,FH);
            LoadEdit(SkladEdit1_14,FH);
            LoadDateEdit(SkladDateEdit1_15,FH);
            LoadEdit(SkladEdit1_16,FH);
            LoadMaskEdit(SkladMaskEdit1_17,FH);
            LoadMemo(SkladMemo2,FH);
            LoadMemo(SkladMemo3,FH);
            LoadMemo(SkladMemo4,FH);
            LoadEdit(SkladEdit5,FH);
            LoadMemo(SkladMemo5,FH);
            LoadMemo(SkladMemo6,FH);
            LoadMemo(SkladMemo7,FH);
            LoadMemo(SkladMemo8_1,FH);
            LoadEdit(SkladEdit8_2,FH);
            LoadEdit(SkladEdit8_3,FH);
            LoadDateEdit(SkladDateEdit8_4,FH);
            LoadEdit(SkladEdit8_5,FH);
            LoadMaskEdit(SkladMaskEdit8_6,FH);
            LoadMemo(SkladMemo8_7,FH);
            LoadMemo(SkladMemo9,FH);
{Otwarcie}
            LoadEdit(OpeningEdit1_1,FH);
            LoadDateEdit(OpeningDateEdit1_1,FH);
            LoadEdit(OpeningEdit1_2,FH);
            LoadMaskEdit(OpeningMaskEdit1_2,FH);
            LoadEdit(OpeningEdit1_3,FH);
            LoadEdit(OpeningEdit1_4,FH);
            LoadEdit(OpeningEdit1_5,FH);
            LoadEdit(OpeningEdit1_6,FH);
            LoadMemo(OpeningMemo2,FH);
            LoadEdit(OpeningEdit3_1,FH);
            LoadDateEdit(OpeningDateEdit3_1,FH);
            LoadEdit(OpeningEdit3_2,FH);
            LoadMaskEdit(OpeningMaskEdit3_2,FH);
            LoadMemo(OpeningMemo3_2,FH);
{Zawartosc}
            LoadMemo(ContentMemo1,FH);
            LoadMemo(ContentMemo2,FH);
            LoadMemo(ContentMemo3,FH);
{Ocena}
            LoadEdit(OcenaEdit1,FH);
            LoadStringGrid(OcenaSG1,FH);
            LoadMemo(OcenaMemo2,FH);
            LoadMemo(OcenaMemo3_1,FH);
            LoadEdit(OcenaEdit3_2,FH);
            LoadSpinEdit(OcenaSE2,FH);
            LoadEdit(OcenaEdit3_3,FH);
            LoadMemo(OcenaMemo3_4,FH);
            LoadMemo(OcenaMemo3_5,FH);
            LoadMemo(OcenaMemo3_6,FH);
            LoadMemo(OcenaMemo3_7,FH);
            LoadMemo(OcenaMemo3_8,FH);
            LoadMemo(OcenaMemo5,FH);
            LoadMemo(OcenaMemo6,FH);
            LoadMemo(OcenaMemo7,FH);
            LoadMemo(OcenaMemo8,FH);
            LoadMemo(OcenaMemo9,FH);
            LoadMemo(OcenaMemo10,FH);
            LoadMemo(OcenaMemo11,FH);
{Protesty}
            LoadMemo(ProtMemo1,FH);
            LoadMemo(ProtMemo2,FH);
            LoadMemo(ProtMemo3,FH);
            LoadMemo(ProtMemo4,FH);
            LoadMemo(ProtMemo5,FH);
            LoadMemo(ProtMemo6,FH);
            LoadMemo(ProtMemo7,FH);
{Pref. kraiowe}
            LoadInteger(T,FH);
            if not Default
              then begin
                Event:=CountryRadioGroup.OnClick;
                CountryRadioGroup.OnClick:=Nil;
                CountryRadioGroup.ItemIndex:=T;
                CountryRadioGroup.OnClick:=Event;
              end;
            LoadMemo(CountryMemo1,FH);
            if not Default
              then for i:=0 to NegMaxPages-1 do
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

{---------------------------- close SIWZ -------------------------}

procedure TNegDlg.SiwzClose;
begin
  if Modified
    then begin
       if MessageDlg('Zachowaæ SIWZ ?',mtConfirmation,[mbYes,mbNo],0)=mrYes
         then SaveBitBtnClick(Self);
    end;
  Close;
end;

procedure TNegDlg.CloseBtnClick(Sender: TObject);
begin
  SiwzClose;
end;

procedure TNegDlg.ZamknijClick(Sender: TObject);
begin
  CloseBtnClick(Sender);
end;

procedure TNegDlg.UstawieniedrukarkiClick(Sender: TObject);
begin
  PrinterSetupDlg.Execute;
end;

procedure TNegDlg.PageConfirmButtonClick(Sender: TObject);
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

procedure TNegDlg.FieldChange(Sender: TObject);
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

procedure TNegDlg.CountryRadioGroupClick(Sender: TObject);
begin
  if CountryRadioGroup.ItemIndex=1
    then begin
      MessageDlg(wmGetPermit,mtWarning,[mbOk],0);
      OcenaMemo5.Color:=clGray;
      OcenaMemo5.Enabled:=FALSE;
    end
    else begin
      OcenaMemo5.Color:=clWhite;
      OcenaMemo5.Enabled:=TRUE;
    end;
  FieldChange(Sender);
end;

procedure TNegDlg.HelpBtnClick(Sender: TObject);
begin
  Application.HelpContext(2005);
end;

procedure TNegDlg.OfertaRadioGroupClick(Sender: TObject);
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

procedure TNegDlg.NipRB1Click(Sender: TObject);
begin
  NipMaskEdit1.Enabled:=TRUE;
  NipMaskEdit1.Color:=clAqua;
  NipMaskEdit2.Enabled:=FALSE;
  NipMaskEdit2.Color:=clGray;
  FieldChange(Sender);
end;

procedure TNegDlg.NipRB2Click(Sender: TObject);
begin
  NipMaskEdit1.Enabled:=FALSE;
  NipMaskEdit1.Color:=clGray;
  NipMaskEdit2.Enabled:=TRUE;
  NipMaskEdit2.Color:=clAqua;
  FieldChange(Sender);
end;

procedure TNegDlg.TimeEditExit(Sender: TObject);
var
  s:String[5];
  Err:Boolean;
begin
  if ActiveControl=CloseBtn
    then Exit;
  s:=TMaskEdit(Sender).Text;
  if not (s[1] in [' ','0','1','2'])
    then Err:=TRUE
  else begin
    case s[1] of
      ' ','0','1':
        begin
          if not (s[2] in ['0'..'9'])
            then Err:=TRUE;
        end;
      '2':
        begin
          if not (s[2] in ['0'..'3'])
            then Err:=TRUE;
        end;
    end {case}
  end;
  if (not (s[4] in ['0'..'5']))
    then Err:=TRUE;
  if Err
    then begin
      MessageDlg(wmTimeError,mtError,[mbOk],0);
      ActiveControl:=TMaskEdit(Sender);
    end;
end;

procedure TNegDlg.OcenaCBClick(Sender: TObject);
begin
  if (Sender=OcenaCB1)
    then begin
      if OcenaCB1.Checked
        then OcenaMemo3_5.Color:=clWhite
        else OcenaMemo3_5.Color:=clGray;
    end;
  if (Sender=OcenaCB2)
    then begin
      if OcenaCB2.Checked
        then OcenaMemo3_6.Color:=clWhite
        else OcenaMemo3_6.Color:=clGray;
    end;
  if (Sender=OcenaCB3)
    then begin
      if OcenaCB3.Checked
        then OcenaMemo3_7.Color:=clWhite
        else OcenaMemo3_7.Color:=clGray;
    end;
  if (Sender=OcenaCB4)
    then begin
      if OcenaCB4.Checked
        then OcenaMemo3_8.Color:=clWhite
        else OcenaMemo3_8.Color:=clGray;
    end;
end;

procedure TNegDlg.OcenaEdit1DblClick(Sender: TObject);
var
  i,j:LongInt;
begin
  KriteriaDlg:=TKriteriaDlg.Create(Self);
  KriteriaDlg.InitGrid(OcenaSG1);
  if KriteriaDlg.ShowModal=mrOk
    then with KriteriaDlg do
      begin
        OcenaSG1.RowCount:=KrytSG.RowCount;
        OcenaSG1.ColCount:=KrytSG.ColCount;
        for i:=1 to KrytSG.RowCount do
          for j:=0 to KrytSG.ColCount do
            OcenaSG1.Cells[j,i]:=KrytSG.Cells[j,i];
        FieldChange(Sender);
      end;
  KriteriaDlg.Free;
end;

procedure TNegDlg.OcenaSE2Change(Sender: TObject);
begin
  if OcenaSE2.Text=''
    then Exit;
  if StrToInt(OcenaSE2.Text)>OcenaSE2.MaxValue
    then begin
      MessageDlg(wmValueOver32767,mtWarning,[mbOk],0);
      OcenaSE2.Text:='32767'
    end;
end;

procedure TNegDlg.OcenaSE2Exit(Sender: TObject);
begin
  if OcenaSE2.Text=''
    then OcenaSE2.Text:='0';
end;

procedure TNegDlg.SkladDateEdit1_15Exit(Sender: TObject);
begin
  if not CheckDate(SkladDateEdit1_15.Text,SkladDateEdit1_15.DateFormat)
    then MessageDlg(wmIncorrectDate,mtWarning,[mbOk],0);
end;

procedure TNegDlg.OpeningDateEdit1_1Exit(Sender: TObject);
begin
  if not CheckDate(OpeningDateEdit1_1.Text,OpeningDateEdit1_1.DateFormat)
    then MessageDlg(wmIncorrectDate,mtWarning,[mbOk],0);
end;

procedure TNegDlg.SkladDateEdit1_15Change(Sender: TObject);
begin
  OpeningDateEdit1_1Change(Sender);
end;

procedure TNegDlg.OpeningDateEdit1_1Change(Sender: TObject);
var
  by,bm,bd,
  ey,em,ed:Word;
  Ok:Boolean;
begin
  if CheckDate(SkladDateEdit1_15.Text,SkladDateEdit1_15.DateFormat) and
     CheckDate(OpeningDateEdit1_1.Text,OpeningDateEdit1_1.DateFormat)
    then begin
      try
        DecodeDate(StrToDate(SkladDateEdit1_15.Text),by,bm,bd);
        DecodeDate(StrToDate(OpeningDateEdit1_1.Text),ey,em,ed);
        Ok := (JulianDate(ey,em,ed)-JulianDate(by,bm,bd)) >= 0;
        if not Ok
          then begin
            MessageDlg(wmOpenDateBeforeSkladDate,mtWarning,[mbOk],0);
          end;
      finally
      end;
    end;
  FieldChange(Sender);
end;

procedure TNegDlg.AddPage(var LP:Integer);
begin
  LP:=Ry.YTOff;
  Ry.NewPage;
  Ry.Font.Name:='Arial CE';
  Ry.Font.Style:=[];
  Ry.Font.Size:=10;
{$IFDEF DEMO}
Ry.WriteDemo(LP);
{$ENDIF}
end;

function TNegDlg.GetTextHeight(p:PChar):Integer;
begin
  with Ry do
    Result:=MemoOut(Rect(XLOff+Xmm(2),0,XROff-Xmm(2),10), p, False, True);
end;

procedure TNegDlg.MakeZamawPrint(var LP:Integer);
var
  p:PChar;
  X:Integer;
  s:String;
begin
  with Ry do
    begin
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
      p:=StrAlloc(Length(ZwanyEdit.Text)+Length(ZamawEdit.Text)+1);
      StrPCopy(p,ZwanyEdit.Text+ZamawEdit.Text);
      if GetTextHeight(p)+LP>PrintSpace
        then AddPage(LP);
      X:=MemoOut(Rect(XLOff+Xmm(2),LP,XROff-Xmm(2),10), p, False, False);
      StrDispose(p);
      LP:=LP+X+Ymm(3);
      p:=StrAlloc(ObjectMemo.GetTextLen + 1);
      ObjectMemo.GetTextBuf(p, ObjectMemo.GetTextLen+1);
      if GetTextHeight(p)+LP>PrintSpace
        then AddPage(LP);
      X:=MemoOut(Rect(XLOff+Xmm(2),LP,XROff-Xmm(2),10), p, False, False);
      StrDispose(p);
      LP:=LP+X+Ymm(3);
      p:=StrAlloc(AnnexMemo.GetTextLen + 1);
      AnnexMemo.GetTextBuf(p, AnnexMemo.GetTextLen+1);
      if GetTextHeight(p)+LP>PrintSpace
        then AddPage(LP);
      X:=MemoOut(Rect(XLOff+Xmm(2),LP,XROff-Xmm(2),10), p, False, False);
      StrDispose(p);
      LP:=LP+X+Ymm(3);
    end;
end;

procedure TNegDlg.MakeTerminPrint(var LP:Integer);
var
  p:PChar;
  X:Integer;
  s:String;
begin
  with Ry do
    begin
{$IFDEF DEMO}
WriteDemo(LP);
{$ENDIF}
      s:=TerminRadioGroup.Items[TerminRadioGroup.ItemIndex];
      p:=StrAlloc(Length(s)+Length(EndDateEdit.Text)+1);
      StrPCopy(p,s+EndDateEdit.Text);
      if GetTextHeight(p)+LP>PrintSpace
        then AddPage(LP);
      X:=MemoOut(Rect(XLOff+Xmm(2),LP,XROff-Xmm(2),10), p, False, False);
      StrDispose(p);
      LP:=LP+X+Ymm(3);
    end;
end;

procedure TNegDlg.MakeWarunkiPrint(var LP:Integer);
var
  p:PChar;
  X:Integer;
  s:String;
begin
  with Ry do
    begin
{$IFDEF DEMO}
WriteDemo(LP);
{$ENDIF}
      p:=StrAlloc(Length(WarunkiEdit1.Text)+1);
      StrPCopy(p,WarunkiEdit1.Text);
      if GetTextHeight(p)+LP>PrintSpace
        then AddPage(LP);
      X:=MemoOut(Rect(XLOff+Xmm(2),LP,XROff-Xmm(2),10), p, False, False);
      StrDispose(p);
      LP:=LP+X+Ymm(1);
      p:=StrAlloc(WarunkiMemo1.GetTextLen + 1);
      WarunkiMemo1.GetTextBuf(p, WarunkiMemo1.GetTextLen+1);
      if GetTextHeight(p)+LP>PrintSpace
        then AddPage(LP);
      X:=MemoOut(Rect(XLOff+Xmm(2),LP,XROff-Xmm(2),10), p, False, False);
      StrDispose(p);
      LP:=LP+X;
      p:=StrAlloc(WarunkiMemo2.GetTextLen + 1);
      WarunkiMemo2.GetTextBuf(p, WarunkiMemo2.GetTextLen+1);
      if GetTextHeight(p)+LP>PrintSpace
        then AddPage(LP);
      X:=MemoOut(Rect(XLOff+Xmm(2),LP,XROff-Xmm(2),10), p, False, False);
      StrDispose(p);
      LP:=LP+X+Ymm(3);
    end;
end;

procedure TNegDlg.MakeRodzajPrint(var LP:Integer);
var
  p:PChar;
  X:Integer;
  s:String;
begin
  with Ry do
    begin
{$IFDEF DEMO}
WriteDemo(LP);
{$ENDIF}
      s:=OfertaRadioGroup.Items[TerminRadioGroup.ItemIndex];
      p:=StrAlloc(Length(s)+1);
      StrPCopy(p,s);
      if GetTextHeight(p)+LP>PrintSpace
        then AddPage(LP);
      X:=MemoOut(Rect(XLOff+Xmm(2),LP,XROff-Xmm(2),10), p, False, False);
      StrDispose(p);
      LP:=LP+X+Ymm(1);
      if OfertaRadioGroup.ItemIndex=1
        then begin
          p:=StrAlloc(OfertaMemo.GetTextLen + 1);
          OfertaMemo.GetTextBuf(p, OfertaMemo.GetTextLen+1);
          if GetTextHeight(p)+LP>PrintSpace
            then AddPage(LP);
          X:=MemoOut(Rect(XLOff+Xmm(2),LP,XROff-Xmm(2),10), p, False, False);
          StrDispose(p);
          LP:=LP+X+Ymm(3);
        end;
    end;
end;

procedure TNegDlg.MakeInfoPrint(var LP:Integer);
var
  p:PChar;
  X:Integer;
  s:String;
begin
  with Ry do
    begin
{$IFDEF DEMO}
WriteDemo(LP);
{$ENDIF}
      p:=StrAlloc(InfoMemo1.GetTextLen + 1);
      InfoMemo1.GetTextBuf(p, InfoMemo1.GetTextLen+1);
      if GetTextHeight(p)+LP>PrintSpace
        then AddPage(LP);
      X:=MemoOut(Rect(XLOff+Xmm(2),LP,XROff-Xmm(2),10), p, False, False);
      StrDispose(p);
      LP:=LP+X+Ymm(1);
      p:=StrAlloc(InfoMemo2.GetTextLen + 1);
      InfoMemo2.GetTextBuf(p, InfoMemo2.GetTextLen+1);
      if GetTextHeight(p)+LP>PrintSpace
        then AddPage(LP);
      X:=MemoOut(Rect(XLOff+Xmm(2),LP,XROff-Xmm(2),10), p, False, False);
      StrDispose(p);
      LP:=LP+X+Ymm(1);
      p:=StrAlloc(InfoMemo3.GetTextLen + 1);
      InfoMemo3.GetTextBuf(p, InfoMemo3.GetTextLen+1);
      if GetTextHeight(p)+LP>PrintSpace
        then AddPage(LP);
      X:=MemoOut(Rect(XLOff+Xmm(2),LP,XROff-Xmm(2),10), p, False, False);
      StrDispose(p);
      LP:=LP+X+Ymm(1);
      p:=StrAlloc(InfoMemo4.GetTextLen + 1);
      InfoMemo4.GetTextBuf(p, InfoMemo4.GetTextLen+1);
      if GetTextHeight(p)+LP>PrintSpace
        then AddPage(LP);
      X:=MemoOut(Rect(XLOff+Xmm(2),LP,XROff-Xmm(2),10), p, False, False);
      StrDispose(p);
      LP:=LP+X+Ymm(1);
      p:=StrAlloc(InfoMemo5.GetTextLen + 1);
      InfoMemo5.GetTextBuf(p, InfoMemo5.GetTextLen+1);
      if GetTextHeight(p)+LP>PrintSpace
        then AddPage(LP);
      X:=MemoOut(Rect(XLOff+Xmm(2),LP,XROff-Xmm(2),10), p, False, False);
      StrDispose(p);
      LP:=LP+X+Ymm(1);
      p:=StrAlloc(InfoMemo6.GetTextLen + 1);
      InfoMemo6.GetTextBuf(p, InfoMemo6.GetTextLen+1);
      if GetTextHeight(p)+LP>PrintSpace
        then AddPage(LP);
      X:=MemoOut(Rect(XLOff+Xmm(2),LP,XROff-Xmm(2),10), p, False, False);
      StrDispose(p);
      LP:=LP+X+Ymm(1);
      p:=StrAlloc(InfoMemo7.GetTextLen + 1);
      InfoMemo7.GetTextBuf(p, InfoMemo7.GetTextLen+1);
      if GetTextHeight(p)+LP>PrintSpace
        then AddPage(LP);
      X:=MemoOut(Rect(XLOff+Xmm(2),LP,XROff-Xmm(2),10), p, False, False);
      StrDispose(p);
      LP:=LP+X+Ymm(1);
      p:=StrAlloc(InfoMemo8.GetTextLen + 1);
      InfoMemo8.GetTextBuf(p, InfoMemo8.GetTextLen+1);
      if GetTextHeight(p)+LP>PrintSpace
        then AddPage(LP);
      X:=MemoOut(Rect(XLOff+Xmm(2),LP,XROff-Xmm(2),10), p, False, False);
      StrDispose(p);
      LP:=LP+X+Ymm(1);
      if InfoMemo9_2.Lines.Count>0
        then begin
          p:=StrAlloc(InfoMemo9_1.GetTextLen + 1);
          InfoMemo9_1.GetTextBuf(p, InfoMemo9_1.GetTextLen+1);
          if GetTextHeight(p)+LP>PrintSpace
            then AddPage(LP);
          X:=MemoOut(Rect(XLOff+Xmm(2),LP,XROff-Xmm(2),10), p, False, False);
          StrDispose(p);
          LP:=LP+X;
          p:=StrAlloc(InfoMemo9_2.GetTextLen + 1);
          InfoMemo9_2.GetTextBuf(p, InfoMemo9_2.GetTextLen+1);
          if GetTextHeight(p)+LP>PrintSpace
            then AddPage(LP);
          X:=MemoOut(Rect(XLOff+Xmm(2),LP,XROff-Xmm(2),10), p, False, False);
          StrDispose(p);
          LP:=LP+X+Ymm(1);
        end;
      p:=StrAlloc(InfoMemo10.GetTextLen + 1);
      InfoMemo10.GetTextBuf(p, InfoMemo10.GetTextLen+1);
      if GetTextHeight(p)+LP>PrintSpace
        then AddPage(LP);
      X:=MemoOut(Rect(XLOff+Xmm(2),LP,XROff-Xmm(2),10), p, False, False);
      StrDispose(p);
      LP:=LP+X+Ymm(1);
      p:=StrAlloc(Length(InfoEdit11_1.Text)+Length(InfoDateEdit11_2.Text)+1);
      StrPCopy(p,InfoEdit11_1.Text+InfoDateEdit11_2.Text);
      if GetTextHeight(p)+LP>PrintSpace
        then AddPage(LP);
      X:=MemoOut(Rect(XLOff+Xmm(2),LP,XROff-Xmm(2),10), p, False, False);
      StrDispose(p);
      LP:=LP+X+Ymm(3);
    end;
end;

procedure TNegDlg.MakeWadiumPrint(var LP:Integer);
var
  p,q:PChar;
  X:Integer;
  s:String;
begin
  with Ry do
    begin
{$IFDEF DEMO}
WriteDemo(LP);
{$ENDIF}
      p:=StrAlloc(Length(WadiumEdit1_1.Text)+Length(WadiumMaskEdit1.Text)+Length(WadiumEdit1_2.Text)+1);
      StrPCopy(p,WadiumEdit1_1.Text+WadiumMaskEdit1.Text+WadiumEdit1_2.Text);
      if GetTextHeight(p)+LP>PrintSpace
        then AddPage(LP);
      X:=MemoOut(Rect(XLOff+Xmm(2),LP,XROff-Xmm(2),10), p, False, False);
      StrDispose(p);
      LP:=LP+X+Ymm(1);
      p:=StrAlloc(WadiumMemo2_1.GetTextLen + 1);
      WadiumMemo2_1.GetTextBuf(p, WadiumMemo2_1.GetTextLen+1);
      if GetTextHeight(p)+LP>PrintSpace
        then AddPage(LP);
      X:=MemoOut(Rect(XLOff+Xmm(2),LP,XROff-Xmm(2),10), p, False, False);
      StrDispose(p);
      LP:=LP+X;
      if WadiumEdit2_2.Text<>''
        then begin
          p:=StrAlloc(Length(WadiumEdit2_1.Text)+Length(WadiumEdit2_2.Text)+1);
          StrPCopy(p,WadiumEdit2_1.Text+WadiumEdit2_2.Text);
          if GetTextHeight(p)+LP>PrintSpace
            then AddPage(LP);
          X:=MemoOut(Rect(XLOff+Xmm(2),LP,XROff-Xmm(2),10), p, False, False);
          StrDispose(p);
          LP:=LP+X;
        end;
      if WadiumMemo2_5.Lines.Count>0
        then begin
          p:=StrAlloc(Length(WadiumEdit2_3.Text)+1);
          StrPCopy(p,WadiumEdit2_3.Text);
          if GetTextHeight(p)+LP>PrintSpace
            then AddPage(LP);
          X:=MemoOut(Rect(XLOff+Xmm(2),LP,XROff-Xmm(2),10), p, False, False);
          StrDispose(p);
          LP:=LP+X;
          p:=StrAlloc(WadiumMemo2_5.GetTextLen + 1);
          WadiumMemo2_5.GetTextBuf(p, WadiumMemo2_5.GetTextLen+1);
          if GetTextHeight(p)+LP>PrintSpace
            then AddPage(LP);
          X:=MemoOut(Rect(XLOff+Xmm(2),LP,XROff-Xmm(2),10), p, False, False);
          StrDispose(p);
          LP:=LP+X;
        end;
      p:=StrAlloc(WadiumMemo2_2.GetTextLen + 1);
      WadiumMemo2_2.GetTextBuf(p, WadiumMemo2_2.GetTextLen+1);
      if GetTextHeight(p)+LP>PrintSpace
        then AddPage(LP);
      X:=MemoOut(Rect(XLOff+Xmm(2),LP,XROff-Xmm(2),10), p, False, False);
      StrDispose(p);
      LP:=LP+X;
      p:=StrAlloc(WadiumMemo2_3.GetTextLen + 1);
      WadiumMemo2_3.GetTextBuf(p, WadiumMemo2_3.GetTextLen+1);
      if GetTextHeight(p)+LP>PrintSpace
        then AddPage(LP);
      X:=MemoOut(Rect(XLOff+Xmm(2),LP,XROff-Xmm(2),10), p, False, False);
      StrDispose(p);
      LP:=LP+X+Ymm(1);
      p:=StrAlloc(WadiumMemo2_4.GetTextLen + 1);
      WadiumMemo2_4.GetTextBuf(p, WadiumMemo2_4.GetTextLen+1);
      if GetTextHeight(p)+LP>PrintSpace
        then AddPage(LP);
      X:=MemoOut(Rect(XLOff+Xmm(2),LP,XROff-Xmm(2),10), p, False, False);
      StrDispose(p);
      LP:=LP+X+Ymm(1);
      p:=StrAlloc(WadiumMemo3.GetTextLen + 1);
      WadiumMemo3.GetTextBuf(p, WadiumMemo3.GetTextLen+1);
      if GetTextHeight(p)+LP>PrintSpace
        then AddPage(LP);
      X:=MemoOut(Rect(XLOff+Xmm(2),LP,XROff-Xmm(2),10), p, False, False);
      StrDispose(p);
      LP:=LP+X+Ymm(1);
      p:=StrAlloc(WadiumMemo4.GetTextLen + 1);
      WadiumMemo4.GetTextBuf(p, WadiumMemo4.GetTextLen+1);
      if GetTextHeight(p)+LP>PrintSpace
        then AddPage(LP);
      X:=MemoOut(Rect(XLOff+Xmm(2),LP,XROff-Xmm(2),10), p, False, False);
      StrDispose(p);
      LP:=LP+X+Ymm(1);
      p:=StrAlloc(WadiumMemo5.GetTextLen + 1);
      WadiumMemo5.GetTextBuf(p, WadiumMemo5.GetTextLen+1);
      if GetTextHeight(p)+LP>PrintSpace
        then AddPage(LP);
      X:=MemoOut(Rect(XLOff+Xmm(2),LP,XROff-Xmm(2),10), p, False, False);
      StrDispose(p);
      LP:=LP+X+Ymm(1);
      p:=StrAlloc(WadiumMemo6_1.GetTextLen+Length(WadiumMaskEdit6.Text)+Length(WadiumEdit6.Text)+1);
      WadiumMemo6_1.GetTextBuf(p, WadiumMemo6_1.GetTextLen+1);
      q:=StrAlloc(Length(WadiumMaskEdit6.Text)+Length(WadiumEdit6.Text)+1);
      StrPCopy(q,WadiumMaskEdit6.Text+WadiumEdit6.Text);
      StrCat(p,q);
      if GetTextHeight(p)+LP>PrintSpace
        then AddPage(LP);
      X:=MemoOut(Rect(XLOff+Xmm(2),LP,XROff-Xmm(2),10), p, False, False);
      StrDispose(q);
      StrDispose(p);
      LP:=LP+X;
      p:=StrAlloc(WadiumMemo6_2.GetTextLen + 1);
      WadiumMemo6_2.GetTextBuf(p, WadiumMemo6_2.GetTextLen+1);
      if GetTextHeight(p)+LP>PrintSpace
        then AddPage(LP);
      X:=MemoOut(Rect(XLOff+Xmm(2),LP,XROff-Xmm(2),10), p, False, False);
      StrDispose(p);
      LP:=LP+X+Ymm(1);
      p:=StrAlloc(WadiumMemo7.GetTextLen + 1);
      WadiumMemo7.GetTextBuf(p, WadiumMemo7.GetTextLen+1);
      if GetTextHeight(p)+LP>PrintSpace
        then AddPage(LP);
      X:=MemoOut(Rect(XLOff+Xmm(2),LP,XROff-Xmm(2),10), p, False, False);
      StrDispose(p);
      LP:=LP+X+Ymm(1);
      p:=StrAlloc(WadiumMemo8.GetTextLen + 1);
      WadiumMemo8.GetTextBuf(p, WadiumMemo8.GetTextLen+1);
      if GetTextHeight(p)+LP>PrintSpace
        then AddPage(LP);
      X:=MemoOut(Rect(XLOff+Xmm(2),LP,XROff-Xmm(2),10), p, False, False);
      StrDispose(p);
      LP:=LP+X+Ymm(1);
      p:=StrAlloc(WadiumMemo9.GetTextLen + 1);
      WadiumMemo9.GetTextBuf(p, WadiumMemo9.GetTextLen+1);
      if GetTextHeight(p)+LP>PrintSpace
        then AddPage(LP);
      X:=MemoOut(Rect(XLOff+Xmm(2),LP,XROff-Xmm(2),10), p, False, False);
      StrDispose(p);
      LP:=LP+X+Ymm(1);
      p:=StrAlloc(WadiumMemo10.GetTextLen + 1);
      WadiumMemo10.GetTextBuf(p, WadiumMemo10.GetTextLen+1);
      if GetTextHeight(p)+LP>PrintSpace
        then AddPage(LP);
      X:=MemoOut(Rect(XLOff+Xmm(2),LP,XROff-Xmm(2),10), p, False, False);
      StrDispose(p);
      LP:=LP+X+Ymm(1);
    end;
end;

procedure TNegDlg.MakeSkladPrint(var LP:Integer);
var
  p,q:PChar;
  X:Integer;
  s:String;
begin
  with Ry do
    begin
{$IFDEF DEMO}
WriteDemo(LP);
{$ENDIF}
      p:=StrAlloc(Length(SkladEdit1_1.Text)+1);
      StrPCopy(p,SkladEdit1_1.Text);
      if GetTextHeight(p)+LP>PrintSpace
        then AddPage(LP);
      X:=MemoOut(Rect(XLOff+Xmm(2),LP,XROff-Xmm(2),10), p, False, False);
      StrDispose(p);
      LP:=LP+X;
      p:=StrAlloc(SkladMemo1_3.GetTextLen + 1);
      SkladMemo1_3.GetTextBuf(p, SkladMemo1_3.GetTextLen+1);
      if GetTextHeight(p)+LP>PrintSpace
        then AddPage(LP);
      X:=MemoOut(Rect(XLOff+Xmm(2),LP,XROff-Xmm(2),10), p, False, False);
      StrDispose(p);
      LP:=LP+X;
      p:=StrAlloc(Length(SkladLabel1_4.Caption)+Length(SkladEdit1_6.Text)+
                  Length(SkladLabel1_5.Caption)+Length(SkladMaskEdit1_7.Text)+1);
      StrPCopy(p,SkladLabel1_4.Caption+SkladEdit1_6.Text+SkladLabel1_5.Caption+SkladMaskEdit1_7.Text);
      if GetTextHeight(p)+LP>PrintSpace
        then AddPage(LP);
      X:=MemoOut(Rect(XLOff+Xmm(2),LP,XROff-Xmm(2),10), p, False, False);
      StrDispose(p);
      LP:=LP+X;
      p:=StrAlloc(Length(SkladLabel1_8.Caption)+Length(SkladEdit1_11.Text)+
                  Length(SkladLabel1_9.Caption)+Length(SkladEdit1_12.Text)+
                  Length(SkladLabel1_10.Caption)+Length(SkladEdit1_13.Text)+1);
      StrPCopy(p,SkladLabel1_8.Caption+SkladEdit1_11.Text+SkladLabel1_9.Caption+
                 SkladEdit1_12.Text+SkladLabel1_10.Caption+SkladEdit1_12.Text);
      if GetTextHeight(p)+LP>PrintSpace
        then AddPage(LP);
      X:=MemoOut(Rect(XLOff+Xmm(2),LP,XROff-Xmm(2),10), p, False, False);
      StrDispose(p);
      LP:=LP+X;
      p:=StrAlloc(Length(SkladEdit1_14.Text)+Length(SkladDateEdit1_15.Text)+
                  Length(SkladEdit1_16.Text)+Length(SkladMaskEdit1_17.Text)+1);
      StrPCopy(p,SkladEdit1_14.Text+SkladDateEdit1_15.Text+SkladEdit1_16.Text+SkladMaskEdit1_17.Text);
      if GetTextHeight(p)+LP>PrintSpace
        then AddPage(LP);
      X:=MemoOut(Rect(XLOff+Xmm(2),LP,XROff-Xmm(2),10), p, False, False);
      StrDispose(p);
      LP:=LP+X+Ymm(1);
      p:=StrAlloc(SkladMemo2.GetTextLen + 1);
      SkladMemo2.GetTextBuf(p, SkladMemo2.GetTextLen+1);
      if GetTextHeight(p)+LP>PrintSpace
        then AddPage(LP);
      X:=MemoOut(Rect(XLOff+Xmm(2),LP,XROff-Xmm(2),10), p, False, False);
      StrDispose(p);
      LP:=LP+X+Ymm(1);
      p:=StrAlloc(SkladMemo3.GetTextLen + 1);
      SkladMemo3.GetTextBuf(p, SkladMemo3.GetTextLen+1);
      if GetTextHeight(p)+LP>PrintSpace
        then AddPage(LP);
      X:=MemoOut(Rect(XLOff+Xmm(2),LP,XROff-Xmm(2),10), p, False, False);
      StrDispose(p);
      LP:=LP+X+Ymm(1);
      p:=StrAlloc(SkladMemo4.GetTextLen + 1);
      SkladMemo4.GetTextBuf(p, SkladMemo4.GetTextLen+1);
      if GetTextHeight(p)+LP>PrintSpace
        then AddPage(LP);
      X:=MemoOut(Rect(XLOff+Xmm(2),LP,XROff-Xmm(2),10), p, False, False);
      StrDispose(p);
      LP:=LP+X+Ymm(1);
      p:=StrAlloc(Length(SkladEdit5.Text)+1);
      StrPCopy(p,SkladEdit5.Text);
      if GetTextHeight(p)+LP>PrintSpace
        then AddPage(LP);
      X:=MemoOut(Rect(XLOff+Xmm(2),LP,XROff-Xmm(2),10), p, False, False);
      StrDispose(p);
      LP:=LP+X+Ymm(1);
      p:=StrAlloc(SkladMemo5.GetTextLen + 1);
      SkladMemo5.GetTextBuf(p, SkladMemo5.GetTextLen+1);
      if GetTextHeight(p)+LP>PrintSpace
        then AddPage(LP);
      X:=MemoOut(Rect(XLOff+Xmm(2),LP,XROff-Xmm(2),10), p, False, False);
      StrDispose(p);
      LP:=LP+X+Ymm(1);
      p:=StrAlloc(SkladMemo5.GetTextLen + 1);
      SkladMemo5.GetTextBuf(p, SkladMemo5.GetTextLen+1);
      if GetTextHeight(p)+LP>PrintSpace
        then AddPage(LP);
      X:=MemoOut(Rect(XLOff+Xmm(2),LP,XROff-Xmm(2),10), p, False, False);
      StrDispose(p);
      LP:=LP+X+Ymm(1);
      p:=StrAlloc(SkladMemo6.GetTextLen + 1);
      SkladMemo6.GetTextBuf(p, SkladMemo6.GetTextLen+1);
      if GetTextHeight(p)+LP>PrintSpace
        then AddPage(LP);
      X:=MemoOut(Rect(XLOff+Xmm(2),LP,XROff-Xmm(2),10), p, False, False);
      StrDispose(p);
      LP:=LP+X+Ymm(1);
      p:=StrAlloc(SkladMemo7.GetTextLen + 1);
      SkladMemo7.GetTextBuf(p, SkladMemo7.GetTextLen+1);
      if GetTextHeight(p)+LP>PrintSpace
        then AddPage(LP);
      X:=MemoOut(Rect(XLOff+Xmm(2),LP,XROff-Xmm(2),10), p, False, False);
      StrDispose(p);
      LP:=LP+X+Ymm(1);
      p:=StrAlloc(SkladMemo8_1.GetTextLen+Length(SkladEdit8_2.Text)+Length(SkladEdit8_3.Text)+
                  Length(SkladDateEdit8_4.Text)+Length(SkladEdit8_5.Text)+Length(SkladMaskEdit8_6.Text)+1);
      SkladMemo8_1.GetTextBuf(p, SkladMemo8_1.GetTextLen+1);
      q:=StrAlloc(Length(SkladEdit8_2.Text)+Length(SkladEdit8_3.Text)+
                  Length(SkladDateEdit8_4.Text)+Length(SkladEdit8_5.Text)+Length(SkladMaskEdit8_6.Text)+1);
      StrPCopy(q,SkladEdit8_2.Text+SkladEdit8_3.Text+SkladDateEdit8_4.Text+SkladEdit8_5.Text+SkladMaskEdit8_6.Text);
      StrCat(p,q);
      StrDispose(q);
      if GetTextHeight(p)+LP>PrintSpace
        then AddPage(LP);
      X:=MemoOut(Rect(XLOff+Xmm(2),LP,XROff-Xmm(2),10), p, False, False);
      StrDispose(p);
      LP:=LP+X;
      p:=StrAlloc(SkladMemo8_7.GetTextLen+1);
      SkladMemo8_7.GetTextBuf(p, SkladMemo8_7.GetTextLen+1);
      if GetTextHeight(p)+LP>PrintSpace
        then AddPage(LP);
      X:=MemoOut(Rect(XLOff+Xmm(2),LP,XROff-Xmm(2),10), p, False, False);
      StrDispose(p);
      LP:=LP+X+Ymm(1);
      p:=StrAlloc(SkladMemo9.GetTextLen + 1);
      SkladMemo9.GetTextBuf(p, SkladMemo9.GetTextLen+1);
      if GetTextHeight(p)+LP>PrintSpace
        then AddPage(LP);
      X:=MemoOut(Rect(XLOff+Xmm(2),LP,XROff-Xmm(2),10), p, False, False);
      StrDispose(p);
      LP:=LP+X+Ymm(1);
    end;
end;

procedure TNegDlg.MakeOpenPrint(var LP:Integer);
var
  p,q:PChar;
  X:Integer;
  s:String;
begin
  with Ry do
    begin
{$IFDEF DEMO}
WriteDemo(LP);
{$ENDIF}
      p:=StrAlloc(Length(OpeningEdit1_1.Text)+Length(OpeningDateEdit1_1.Text)+Length(OpeningEdit1_2.Text)+
                  Length(OpeningMaskEdit1_2.Text)+Length(OpeningEdit1_3.Text)+Length(OpeningEdit1_4.Text)+
                  Length(OpeningEdit1_5.Text)+Length(OpeningEdit1_6.Text)+1);
      StrPCopy(p,OpeningEdit1_1.Text+OpeningDateEdit1_1.Text+OpeningEdit1_2.Text+OpeningMaskEdit1_2.Text+
               OpeningEdit1_3.Text+OpeningEdit1_4.Text+OpeningEdit1_5.Text+OpeningEdit1_6.Text);
      if GetTextHeight(p)+LP>PrintSpace
        then AddPage(LP);
      X:=MemoOut(Rect(XLOff+Xmm(2),LP,XROff-Xmm(2),10), p, False, False);
      StrDispose(p);
      LP:=LP+X+Ymm(1);
      p:=StrAlloc(OpeningMemo2.GetTextLen + 1);
      OpeningMemo2.GetTextBuf(p, OpeningMemo2.GetTextLen);
      if GetTextHeight(p)+LP>PrintSpace
        then AddPage(LP);
      X:=MemoOut(Rect(XLOff+Xmm(2),LP,XROff-Xmm(2),10), p, False, False);
      StrDispose(p);
      LP:=LP+X+Ymm(1);
      p:=StrAlloc(Length(OpeningEdit3_1.Text)+Length(OpeningDateEdit3_1.Text)+Length(OpeningEdit3_2.Text)+
                  Length(OpeningMaskEdit3_2.Text)+OpeningMemo3_2.GetTextLen+1);
      StrPCopy(p,OpeningEdit3_1.Text+OpeningDateEdit3_1.Text+OpeningEdit3_2.Text+OpeningMaskEdit3_2.Text);
      q:=StrAlloc(OpeningMemo3_2.GetTextLen+1);
      OpeningMemo3_2.GetTextBuf(q, OpeningMemo3_2.GetTextLen);
      StrCat(p,q);
      if GetTextHeight(p)+LP>PrintSpace
        then AddPage(LP);
      X:=MemoOut(Rect(XLOff+Xmm(2),LP,XROff-Xmm(2),10), p, False, False);
      StrDispose(p);
      StrDispose(q);
      LP:=LP+X+Ymm(1);
    end;
end;

procedure TNegDlg.MakeContentPrint(var LP:Integer);
var
  p,q:PChar;
  X:Integer;
  s:String;
begin
  with Ry do
    begin
{$IFDEF DEMO}
WriteDemo(LP);
{$ENDIF}
      p:=StrAlloc(ContentMemo1.GetTextLen + 1);
      ContentMemo1.GetTextBuf(p, ContentMemo1.GetTextLen+1);
      if GetTextHeight(p)+LP>PrintSpace
        then AddPage(LP);
      X:=MemoOut(Rect(XLOff+Xmm(2),LP,XROff-Xmm(2),10), p, False, False);
      StrDispose(p);
      LP:=LP+X+Ymm(1);
      p:=StrAlloc(ContentMemo2.GetTextLen + 1);
      ContentMemo2.GetTextBuf(p, ContentMemo2.GetTextLen+1);
      if GetTextHeight(p)+LP>PrintSpace
        then AddPage(LP);
      X:=MemoOut(Rect(XLOff+Xmm(2),LP,XROff-Xmm(2),10), p, False, False);
      StrDispose(p);
      LP:=LP+X+Ymm(1);
      p:=StrAlloc(ContentMemo3.GetTextLen + 1);
      ContentMemo3.GetTextBuf(p, ContentMemo3.GetTextLen+1);
      if GetTextHeight(p)+LP>PrintSpace
        then AddPage(LP);
      X:=MemoOut(Rect(XLOff+Xmm(2),LP,XROff-Xmm(2),10), p, False, False);
      StrDispose(p);
      LP:=LP+X+Ymm(1);
    end;
end;

procedure TNegDlg.MakeOcenaPrint(var LP:Integer);
var
  p:PChar;
  X,i:Integer;
  s,s1,s2:String;
begin
  with Ry do
    begin
{$IFDEF DEMO}
WriteDemo(LP);
{$ENDIF}
      p:=StrAlloc(Length(OcenaEdit1.Text)+1);
      StrPCopy(p,OcenaEdit1.Text);
      if GetTextHeight(p)+LP>PrintSpace
        then AddPage(LP);
      X:=MemoOut(Rect(XLOff+Xmm(2),LP,XROff-Xmm(2),10), p, False, False);
      StrDispose(p);
      LP:=LP+X;
      with OcenaSG1 do
        for i:=1 to OcenaSG1.RowCount-1 do
          if Cells[DCol,i]<>''
            then begin
              s:='- '+Cells[DCol,i];
              s1:=', waga: '+Cells[WCol,i];
              s2:=', sposób oceny: '+Cells[ECol,i];
              p:=StrAlloc(Length(s)+Length(s1)+Length(s2)+1);
              StrPCopy(p,s+s1+s2);
              if GetTextHeight(p)+LP>PrintSpace
                then AddPage(LP);
              X:=MemoOut(Rect(XLOff+Xmm(2),LP,XROff-Xmm(2),10), p, False, False);
              StrDispose(p);
              LP:=LP+X;
            end;
      LP:=LP+Ymm(1);
      p:=StrAlloc(OcenaMemo2.GetTextLen + 1);
      OcenaMemo2.GetTextBuf(p, OcenaMemo2.GetTextLen+1);
      if GetTextHeight(p)+LP>PrintSpace
        then AddPage(LP);
      X:=MemoOut(Rect(XLOff+Xmm(2),LP,XROff-Xmm(2),10), p, False, False);
      StrDispose(p);
      LP:=LP+X+Ymm(1);
      p:=StrAlloc(OcenaMemo3_1.GetTextLen+1);
      OcenaMemo3_1.GetTextBuf(p, OcenaMemo3_1.GetTextLen+1);
      if GetTextHeight(p)+LP>PrintSpace
        then AddPage(LP);
      X:=MemoOut(Rect(XLOff+Xmm(2),LP,XROff-Xmm(2),10), p, False, False);
      StrDispose(p);
      LP:=LP+X;
      p:=StrAlloc(Length(OcenaEdit3_2.Text)+Length(OcenaSE2.Text)+Length(OcenaEdit3_3.Text)+1);
      StrPCopy(p,OcenaEdit3_2.Text+OcenaSE2.Text+OcenaEdit3_3.Text);
      if GetTextHeight(p)+LP>PrintSpace
        then AddPage(LP);
      X:=MemoOut(Rect(XLOff+Xmm(2),LP,XROff-Xmm(2),10), p, False, False);
      StrDispose(p);
      LP:=LP+X;
      if (OcenaCB1.Checked) or (OcenaCB2.Checked) or (OcenaCB3.Checked) or (OcenaCB4.Checked)
        then begin
          p:=StrAlloc(OcenaMemo3_4.GetTextLen+1);
          OcenaMemo3_4.GetTextBuf(p, OcenaMemo3_4.GetTextLen+1);
          if GetTextHeight(p)+LP>PrintSpace
            then AddPage(LP);
          X:=MemoOut(Rect(XLOff+Xmm(2),LP,XROff-Xmm(2),10), p, False, False);
          StrDispose(p);
          LP:=LP+X;
          if OcenaCB1.Checked
            then begin
              s:=OcenaCB1.Caption+':';
              p:=StrAlloc(OcenaMemo3_5.GetTextLen+1);
              OcenaMemo3_5.GetTextBuf(p, OcenaMemo3_5.GetTextLen+1);
              if GetTextHeight(StringAsPChar(s))+GetTextHeight(p)+LP>PrintSpace
                then AddPage(LP);
              X:=MemoOut(Rect(XLOff+Xmm(2),LP,XROff-Xmm(2),10), StringAsPChar(s), False, False);
              LP:=LP+X;
              X:=MemoOut(Rect(XLOff+Xmm(2),LP,XROff-Xmm(2),10), p, False, False);
              LP:=LP+X;
              StrDispose(p);
            end;
          if OcenaCB2.Checked
            then begin
              s:=OcenaCB2.Caption+':';
              p:=StrAlloc(OcenaMemo3_6.GetTextLen+1);
              OcenaMemo3_6.GetTextBuf(p, OcenaMemo3_6.GetTextLen+1);
              if GetTextHeight(StringAsPChar(s))+GetTextHeight(p)+LP>PrintSpace
                then AddPage(LP);
              X:=MemoOut(Rect(XLOff+Xmm(2),LP,XROff-Xmm(2),10), StringAsPChar(s), False, False);
              LP:=LP+X;
              X:=MemoOut(Rect(XLOff+Xmm(2),LP,XROff-Xmm(2),10), p, False, False);
              LP:=LP+X;
              StrDispose(p);
            end;
          if OcenaCB3.Checked
            then begin
              s:=OcenaCB3.Caption+':';
              p:=StrAlloc(OcenaMemo3_7.GetTextLen+1);
              OcenaMemo3_7.GetTextBuf(p, OcenaMemo3_7.GetTextLen+1);
              if GetTextHeight(StringAsPChar(s))+GetTextHeight(p)+LP>PrintSpace
                then AddPage(LP);
              X:=MemoOut(Rect(XLOff+Xmm(2),LP,XROff-Xmm(2),10), StringAsPChar(s), False, False);
              LP:=LP+X;
              X:=MemoOut(Rect(XLOff+Xmm(2),LP,XROff-Xmm(2),10), p, False, False);
              LP:=LP+X;
              StrDispose(p);
            end;
          if OcenaCB4.Checked
            then begin
              s:=OcenaCB4.Caption+':';
              p:=StrAlloc(OcenaMemo3_8.GetTextLen+1);
              OcenaMemo3_8.GetTextBuf(p, OcenaMemo3_8.GetTextLen+1);
              if GetTextHeight(StringAsPChar(s))+GetTextHeight(p)+LP>PrintSpace
                then AddPage(LP);
              X:=MemoOut(Rect(XLOff+Xmm(2),LP,XROff-Xmm(2),10), StringAsPChar(s), False, False);
              LP:=LP+X;
              X:=MemoOut(Rect(XLOff+Xmm(2),LP,XROff-Xmm(2),10), p, False, False);
              LP:=LP+X;
              StrDispose(p);
            end;
        end;
      LP:=LP+Ymm(1);
    end;
end;

procedure TNegDlg.MakeCountryPrint(var LP:Integer);
var
  p,q:PChar;
  X:Integer;
  s:String;
begin
  with Ry do
    begin
{$IFDEF DEMO}
WriteDemo(LP);
{$ENDIF}
      if CountryRadioGroup.ItemIndex>=0
        then begin
          p:=StrAlloc(Length(CountryRadioGroup.Items[CountryRadioGroup.ItemIndex])+1);
          StrPCopy(p, CountryRadioGroup.Items[CountryRadioGroup.ItemIndex]);
          if GetTextHeight(p)+LP>PrintSpace
            then AddPage(LP);
          X:=MemoOut(Rect(XLOff+Xmm(2),LP,XROff-Xmm(2),10), p, False, False);
          StrDispose(p);
          LP:=LP+X+Ymm(1);
        end;
      if CountryRadioGroup.ItemIndex=1
        then begin
          p:=StrAlloc(CountryMemo1.GetTextLen + 1);
          CountryMemo1.GetTextBuf(p, CountryMemo1.GetTextLen+1);
          if GetTextHeight(p)+LP>PrintSpace
            then AddPage(LP);
          X:=MemoOut(Rect(XLOff+Xmm(2),LP,XROff-Xmm(2),10), p, False, False);
          StrDispose(p);
          LP:=LP+X+Ymm(1);
        end;
    end;
end;

procedure TNegDlg.MakeProtestPrint(var LP:Integer);
var
  p,q:PChar;
  X:Integer;
  s:String;
begin
  with Ry do
    begin
{$IFDEF DEMO}
WriteDemo(LP);
{$ENDIF}
      p:=StrAlloc(ProtMemo1.GetTextLen + 1);
      ProtMemo1.GetTextBuf(p, ProtMemo1.GetTextLen+1);
      if GetTextHeight(p)+LP>PrintSpace
        then AddPage(LP);
      X:=MemoOut(Rect(XLOff+Xmm(2),LP,XROff-Xmm(2),10), p, False, False);
      StrDispose(p);
      LP:=LP+X+Ymm(1);
      p:=StrAlloc(ProtMemo2.GetTextLen + 1);
      ProtMemo2.GetTextBuf(p, ProtMemo2.GetTextLen+1);
      if GetTextHeight(p)+LP>PrintSpace
        then AddPage(LP);
      X:=MemoOut(Rect(XLOff+Xmm(2),LP,XROff-Xmm(2),10), p, False, False);
      StrDispose(p);
      LP:=LP+X+Ymm(1);
      p:=StrAlloc(ProtMemo3.GetTextLen + 1);
      ProtMemo3.GetTextBuf(p, ProtMemo3.GetTextLen+1);
      if GetTextHeight(p)+LP>PrintSpace
        then AddPage(LP);
      X:=MemoOut(Rect(XLOff+Xmm(2),LP,XROff-Xmm(2),10), p, False, False);
      StrDispose(p);
      LP:=LP+X+Ymm(1);
      p:=StrAlloc(ProtMemo4.GetTextLen + 1);
      ProtMemo4.GetTextBuf(p, ProtMemo4.GetTextLen+1);
      if GetTextHeight(p)+LP>PrintSpace
        then AddPage(LP);
      X:=MemoOut(Rect(XLOff+Xmm(2),LP,XROff-Xmm(2),10), p, False, False);
      StrDispose(p);
      LP:=LP+X+Ymm(1);
      p:=StrAlloc(ProtMemo5.GetTextLen + 1);
      ProtMemo5.GetTextBuf(p, ProtMemo5.GetTextLen+1);
      if GetTextHeight(p)+LP>PrintSpace
        then AddPage(LP);
      X:=MemoOut(Rect(XLOff+Xmm(2),LP,XROff-Xmm(2),10), p, False, False);
      StrDispose(p);
      LP:=LP+X+Ymm(1);
      p:=StrAlloc(ProtMemo6.GetTextLen + 1);
      ProtMemo6.GetTextBuf(p, ProtMemo6.GetTextLen+1);
      if GetTextHeight(p)+LP>PrintSpace
        then AddPage(LP);
      X:=MemoOut(Rect(XLOff+Xmm(2),LP,XROff-Xmm(2),10), p, False, False);
      StrDispose(p);
      LP:=LP+X+Ymm(1);
      p:=StrAlloc(ProtMemo7.GetTextLen + 1);
      ProtMemo7.GetTextBuf(p, ProtMemo7.GetTextLen+1);
      if GetTextHeight(p)+LP>PrintSpace
        then AddPage(LP);
      X:=MemoOut(Rect(XLOff+Xmm(2),LP,XROff-Xmm(2),10), p, False, False);
      StrDispose(p);
      LP:=LP+X+Ymm(1);
    end;
end;

procedure TNegDlg.MakePrint;
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
      Font.Name:='Arial CE';
      Font.Size:=16;
      Font.Style:=[fsBold,fsUnderLine];
      X:=MemoOut(Rect(XLOff+Xmm(2),LP,XROff-Xmm(2),10), sSIWZ, False, False);
      LP:=LP+X+Ymm(3);
      Font.Size:=14;
      Font.Style:=[fsBold];
      X:=MemoOut(Rect(XLOff+Xmm(2),LP,XROff-Xmm(2),10), sNegocjacje, False, False);
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
      LP:=LP+X+Ymm(1);
      if Phase=1
        then s:=mFirstPhase
        else s:=mSecondPhase;
      p:=StrAlloc(Length(s)+1);
      StrPCopy(p,s);
      if GetTextHeight(p)+LP+Ymm(1)>PrintSpace
        then AddPage(LP);
      X:=MemoOut(Rect(XLOff+Xmm(2),LP,XROff-Xmm(2),10), p, False, False);
      StrDispose(p);
      LP:=LP+X+Ymm(10);
      MakeZamawPrint(LP);
      MakeTerminPrint(LP);
      MakeWarunkiPrint(LP);
      MakeRodzajPrint(LP);
      MakeInfoPrint(LP);
      MakeWadiumPrint(LP);
      MakeSkladPrint(LP);
{      MakeOpenPrint(LP);}
      MakeContentPrint(LP);
      MakeOcenaPrint(LP);
      MakeProtestPrint(LP);
      MakeCountryPrint(LP);
{$IFDEF DEMO}
WriteDemo(LP);
{$ENDIF}

      PutPageNums(((XROff-XLOff) div 2) +XLOff,YBOff-Ymm(10),taCenter);
    end;
end;

procedure TNegDlg.PrintBitBtnClick(Sender: TObject);
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

procedure TNegDlg.Drukuj1Click(Sender: TObject);
begin
  PrintBitBtnClick(Sender);
end;

procedure TNegDlg.Przegl1Click(Sender: TObject);
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

procedure TNegDlg.ExportToTxt(FileName:String);
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
      if Phase=1
        then s:=mFirstPhase
        else s:=mSecondPhase;
      ExportString(s,FH);
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
      ExportEdit(ZwanyEdit,FH);
      ExportEdit(ZamawEdit,FH);
      ExportMemo(ObjectMemo,FH);
      ExportMemo(AnnexMemo,FH);
  {Termin}
      ExportString(TerminRadioGroup.Items[TerminRadioGroup.ItemIndex]+
                   EndDateEdit.Text,FH);
  {Warunki}
      ExportEdit(WarunkiEdit1,FH);
      ExportMemo(WarunkiMemo1,FH);
      ExportMemo(WarunkiMemo2,FH);
  {Rodzaj}
      ExportString(OfertaRadioGroup.Items[OfertaRadioGroup.ItemIndex],FH);
      if OfertaRadioGroup.ItemIndex=1
        then ExportMemo(OfertaMemo,FH);
  {Info}
      ExportMemo(InfoMemo1,FH);
      ExportMemo(InfoMemo2,FH);
      ExportMemo(InfoMemo3,FH);
      ExportMemo(InfoMemo4,FH);
      ExportMemo(InfoMemo5,FH);
      ExportMemo(InfoMemo6,FH);
      ExportMemo(InfoMemo7,FH);
      ExportMemo(InfoMemo8,FH);
      ExportMemo(InfoMemo9_1,FH);
      ExportMemo(InfoMemo9_2,FH);
      ExportMemo(InfoMemo10,FH);
      ExportString(InfoEdit11_1.Text+InfoDateEdit11_2.Text,FH);
  {Wadium}
      ExportString(WadiumEdit1_1.Text+WadiumMaskEdit1.Text+
                   WadiumEdit1_2.Text,FH);
      ExportMemo(WadiumMemo2_1,FH);
      ExportEdit(WadiumEdit2_1,FH);
      ExportEdit(WadiumEdit2_2,FH);
      ExportEdit(WadiumEdit2_3,FH);
      ExportMemo(WadiumMemo2_2,FH);
      ExportMemo(WadiumMemo2_3,FH);
      ExportMemo(WadiumMemo2_4,FH);
      ExportMemo(WadiumMemo2_5,FH);
      ExportMemo(WadiumMemo3,FH);
      ExportMemo(WadiumMemo4,FH);
      ExportMemo(WadiumMemo5,FH);
      p:=StrAlloc(WadiumMemo6_1.GetTextLen+Length(WadiumMaskEdit6.Text)+
                  Length(WadiumEdit6.Text)+WadiumMemo6_2.GetTextLen+1);
      WadiumMemo6_1.GetTextBuf(p,WadiumMemo6_1.GetTextLen);
      q:=StrAlloc(Length(WadiumMaskEdit6.Text)+Length(WadiumEdit6.Text)+1);
      StrPCopy(q,WadiumMaskEdit6.Text+WadiumEdit6.Text);
      StrCat(p,q);
      StrDispose(q);
      q:=StrAlloc(WadiumMemo6_2.GetTextLen+1);
      WadiumMemo6_2.GetTextBuf(q,WadiumMemo6_2.GetTextLen);
      StrCat(p,q);
      StrDispose(q);
      ExportPChar(p,FH);
      StrDispose(p);
      ExportMemo(WadiumMemo7,FH);
      ExportMemo(WadiumMemo8,FH);
      ExportMemo(WadiumMemo9,FH);
      ExportMemo(WadiumMemo10,FH);
  {Sklad}
      p:=StrAlloc(Length(SkladEdit1_1.Text)+1);
      StrPCopy(p,SkladEdit1_1.Text);
      ExportPChar(p,FH);
      ExportMemo(SkladMemo1_3,FH);
      p:=StrAlloc(Length(SkladLabel1_4.Caption)+Length(SkladEdit1_6.Text)+
                  Length(SkladLabel1_5.Caption)+Length(SkladMaskEdit1_7.Text)+1);
      StrPCopy(p,SkladLabel1_4.Caption+SkladEdit1_6.Text+SkladLabel1_5.Caption+SkladMaskEdit1_7.Text);
      ExportPChar(p,FH);
      p:=StrAlloc(Length(SkladLabel1_8.Caption)+Length(SkladEdit1_11.Text)+
                  Length(SkladLabel1_9.Caption)+Length(SkladEdit1_12.Text)+
                  Length(SkladLabel1_10.Caption)+Length(SkladEdit1_13.Text)+1);
      StrPCopy(p,SkladLabel1_8.Caption+SkladEdit1_11.Text+SkladLabel1_9.Caption+
                 SkladEdit1_12.Text+SkladLabel1_10.Caption+SkladEdit1_12.Text);
      ExportPChar(p,FH);
      p:=StrAlloc(Length(SkladEdit1_14.Text)+Length(SkladDateEdit1_15.Text)+
                  Length(SkladEdit1_16.Text)+Length(SkladMaskEdit1_17.Text)+1);
      StrPCopy(p,SkladEdit1_14.Text+SkladDateEdit1_15.Text+SkladEdit1_16.Text+SkladMaskEdit1_17.Text);
      ExportPChar(p,FH);
      StrDispose(p);
      ExportMemo(SkladMemo2,FH);
      ExportMemo(SkladMemo3,FH);
      ExportMemo(SkladMemo4,FH);
      ExportEdit(SkladEdit5,FH);
      ExportMemo(SkladMemo5,FH);
      ExportMemo(SkladMemo6,FH);
      ExportMemo(SkladMemo7,FH);
      p:=StrAlloc(SkladMemo8_1.GetTextLen+Length(SkladEdit8_2.Text)+Length(SkladEdit8_3.Text)+
                  Length(SkladDateEdit8_4.Text)+Length(SkladEdit8_5.Text)+Length(SkladMaskEdit8_6.Text)+1);
      SkladMemo8_1.GetTextBuf(p, SkladMemo8_1.GetTextLen+1);
      q:=StrAlloc(Length(SkladEdit8_2.Text)+Length(SkladEdit8_3.Text)+
                  Length(SkladDateEdit8_4.Text)+Length(SkladEdit8_5.Text)+Length(SkladMaskEdit8_6.Text)+1);
      StrPCopy(q,SkladEdit8_2.Text+SkladEdit8_3.Text+SkladDateEdit8_4.Text+SkladEdit8_5.Text+SkladMaskEdit8_6.Text);
      StrCat(p,q);
      StrDispose(q);
      ExportPChar(p,FH);
      StrDispose(p);
      ExportMemo(SkladMemo8_7,FH);
      ExportMemo(SkladMemo9, FH);
  {Otwarcie}
      p:=StrAlloc(Length(OpeningEdit1_1.Text)+Length(OpeningDateEdit1_1.Text)+Length(OpeningEdit1_2.Text)+
                  Length(OpeningMaskEdit1_2.Text)+Length(OpeningEdit1_3.Text)+Length(OpeningEdit1_4.Text)+
                  Length(OpeningEdit1_5.Text)+Length(OpeningEdit1_6.Text)+1);
      StrPCopy(p,OpeningEdit1_1.Text+OpeningDateEdit1_1.Text+OpeningEdit1_2.Text+OpeningMaskEdit1_2.Text+
               OpeningEdit1_3.Text+OpeningEdit1_4.Text+OpeningEdit1_5.Text+OpeningEdit1_6.Text);
      ExportPChar(p,FH);
      StrDispose(p);
      ExportMemo(OpeningMemo2,FH);
      p:=StrAlloc(Length(OpeningEdit3_1.Text)+Length(OpeningDateEdit3_1.Text)+Length(OpeningEdit3_2.Text)+
                  Length(OpeningMaskEdit3_2.Text)+OpeningMemo3_2.GetTextLen+1);
      StrPCopy(p,OpeningEdit3_1.Text+OpeningDateEdit3_1.Text+OpeningEdit3_2.Text+OpeningMaskEdit3_2.Text);
      ExportPChar(p,FH);
      StrDispose(p);
  {Zawartosc}
      ExportMemo(ContentMemo1,FH);
      ExportMemo(ContentMemo2,FH);
      ExportMemo(ContentMemo3,FH);
  {Ocena}
      ExportEdit(OcenaEdit1,FH);
      with OcenaSG1 do
        for i:=1 to OcenaSG1.RowCount-1 do
          if Cells[DCol,i]<>''
            then begin
              s:='- '+Cells[DCol,i];
              s1:=', waga: '+Cells[WCol,i];
              s2:=', sposób oceny: '+Cells[ECol,i];
              p:=StrAlloc(Length(s)+Length(s1)+Length(s2)+1);
              StrPCopy(p,s+s1+s2);
              ExportPChar(p,FH);
              StrDispose(p);
            end;
      ExportMemo(OcenaMemo2,FH);
      ExportMemo(OcenaMemo3_1,FH);
      p:=StrAlloc(Length(OcenaEdit3_2.Text)+Length(OcenaSE2.Text)+Length(OcenaEdit3_3.Text)+1);
      StrPCopy(p,OcenaEdit3_2.Text+OcenaSE2.Text+OcenaEdit3_3.Text);
      ExportPChar(p,FH);
      StrDispose(p);
      ExportMemo(OcenaMemo3_4,FH);
      ExportMemo(OcenaMemo3_5,FH);
      ExportMemo(OcenaMemo3_6,FH);
      ExportMemo(OcenaMemo3_7,FH);
      ExportMemo(OcenaMemo3_8,FH);
      ExportMemo(OcenaMemo5,FH);
      ExportMemo(OcenaMemo6,FH);
      ExportMemo(OcenaMemo7,FH);
      ExportMemo(OcenaMemo8,FH);
      ExportMemo(OcenaMemo9,FH);
      ExportMemo(OcenaMemo10,FH);
      ExportMemo(OcenaMemo11,FH);
  {Protesty}
      ExportMemo(ProtMemo1,FH);
      ExportMemo(ProtMemo2,FH);
      ExportMemo(ProtMemo3,FH);
      ExportMemo(ProtMemo4,FH);
      ExportMemo(ProtMemo5,FH);
      ExportMemo(ProtMemo6,FH);
      ExportMemo(ProtMemo7,FH);
  {Pref. kraiowe}
      ExportString(CountryRadioGroup.Items[CountryRadioGroup.ItemIndex],FH);
      ExportMemo(CountryMemo1,FH);
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

procedure TNegDlg.ExportClick(Sender: TObject);
begin
  if SaveDialog.Execute
    then ExportToTxt(SaveDialog.FileName);
end;

procedure TNegDlg.PhaseBtnClick(Sender: TObject);
begin
  if Phase=1
    then Phase:=2
    else Phase:=1;
  SetPhase;
end;

end.


