unit Prt4;

interface

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, StdCtrls, Mask, Buttons, ExtCtrls, Menus,
  Grids, Spin,
  WinCrt,
  SkOk,
  Printers,
  RPrev,
  SiwzIni,
  UserUnit,
  IntDate,
  Timeedit,
  NumInp, Tabs, Sk;

const
  CCol=0;
  DCol=1;
  ECol=2;
  WCol=3;

{  NieFilter='Prz. nieograniczony|*.';
  OgrFilter='Prz. ograniczony|*.';}
  NegFilter='Negocjacje z zach. konk.|*.';

{Pages}
  page1='Zamawiaj¹cy';
  page2='Termin realizacji';
  page3='Wymagania od oferentów';
  page4='Oferta ca³a/czêœciowa';
  page5='Informacje';
  page6='Wadium';
  page7='Zabezpieczenie';
  page8='Termin zwi¹zania ofert¹';
  page9='Sposób sk³adania';
  page10='Wycofanie, zmiany';
  page11='Otwarcia ofert';
  page12='Zawartoœæ ofert';
  page13='Ocena ofert';
  page14='Wybór najkorzystniejszej oferty';
  page15='Warunki uniewa¿nienia postêpowania';
  page16='Protesty i odwo³ania';

  DefSelPages:Array[1..Prt4MaxPages] of Boolean=(FALSE,FALSE,FALSE,FALSE,FALSE,FALSE,FALSE,FALSE,FALSE,
                                                 FALSE,FALSE,FALSE,FALSE,FALSE,FALSE,FALSE);

type
  TPrt4Dlg = class(TForm)
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
    Wymag1: TMenuItem;
    Cala1: TMenuItem;
    Informacje1: TMenuItem;
    Wadium1: TMenuItem;
    Sposob1: TMenuItem;
    Otwarcia1: TMenuItem;
    Zawartosc1: TMenuItem;
    Ocena1: TMenuItem;
    Protesty1: TMenuItem;
    SaveDialog: TSaveDialog;
    Zabez1: TMenuItem;
    Terminzwizaniaofert1: TMenuItem;
    Wycofaniezmiany1: TMenuItem;
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
    Notebook: TNotebook;
    ZamScrollBox: TScrollBox;
    NameLabel: TLabel;
    StreetLabel: TLabel;
    TownLabel: TLabel;
    NumberLabel: TLabel;
    ZipLabel: TLabel;
    TelLabel: TLabel;
    FaxLabel: TLabel;
    ObjectLabel: TLabel;
    TelexLabel: TLabel;
    RegonLabel: TLabel;
    AnnexLabel: TLabel;
    RoomLabel: TLabel;
    TownEdit: TEdit;
    ZipMaskEdit: TMaskEdit;
    NameMemo: TMemo;
    TelEdit: TEdit;
    FaxEdit: TEdit;
    ZamawEdit: TEdit;
    StreetEdit: TEdit;
    ObjectMemo: TMemo;
    Page1Button: TButton;
    ZwanyEdit: TEdit;
    TelexEdit: TEdit;
    RegonMaskEdit: TMaskEdit;
    AnnexMemo: TMemo;
    NipGroupBox: TGroupBox;
    NipRB1: TRadioButton;
    NipRB2: TRadioButton;
    NipMaskEdit2: TMaskEdit;
    NipMaskEdit1: TMaskEdit;
    BldgEdit: TEdit;
    RoomEdit: TEdit;
    TerminBevel: TBevel;
    TerminRb1: TRadioButton;
    TerminGB1: TGroupBox;
    TerminRb1_1: TRadioButton;
    TerminRB1_2: TRadioButton;
    EndDate: TIntDate;
    TerminRB2: TRadioButton;
    TerminGB2: TGroupBox;
    TimeUnitCB: TComboBox;
    TerminEdit: TNumInp;
    TerminRb2_1: TRadioButton;
    TerminRB2_2: TRadioButton;
    CB2_5: TComboBox;
    Page2Button: TButton;
    WarunScrollBox: TScrollBox;
    WarunLabel2: TLabel;
    WarunkiEdit1: TEdit;
    WarunkiMemo1: TMemo;
    WarunkiMemo2: TMemo;
    Page3Button: TButton;
    OfertaBevel: TBevel;
    OfertaMemo: TMemo;
    OfertaRadioGroup: TRadioGroup;
    Page4Button: TButton;
    InfoScrollBox: TScrollBox;
    InfoMemo1: TMemo;
    InfoMemo2: TMemo;
    InfoMemo3: TMemo;
    InfoMemo4: TMemo;
    InfoMemo5: TMemo;
    InfoMemo6: TMemo;
    InfoMemo8: TMemo;
    InfoMemo10_1: TMemo;
    InfoMemo9: TMemo;
    Page5Button: TButton;
    InfoMemo10_2: TMemo;
    InfoCB7: TCheckBox;
    WadiumScrollBox: TScrollBox;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    WadiumEdit2_3: TEdit;
    WadiumEdit2_1: TEdit;
    WadiumMemo3_1: TMemo;
    WadiumMemo4_2: TMemo;
    WadiumMemo8: TMemo;
    WadiumMemo5: TMemo;
    WadiumMemo6: TMemo;
    WadiumMemo7_1: TMemo;
    Page6Button: TButton;
    WadiumEdit4_1: TEdit;
    WadiumGB1: TGroupBox;
    WadiumLabel1_1: TLabel;
    WadiumRB1_2: TRadioButton;
    WadiumRB1_3: TRadioButton;
    WadiumEdit2_2: TNumInp;
    WadiumEdit2_4: TEdit;
    WadiumEdit2_5: TEdit;
    WadiumEdit2_6: TEdit;
    WadiumCB3_2: TCheckBox;
    WadiumCB3_3: TCheckBox;
    WadiumMemo7_2: TMemo;
    ScrollBox1: TScrollBox;
    Label8: TLabel;
    Page7Button: TButton;
    ZabezMemo2_1: TMemo;
    ZabezMemo3_1: TMemo;
    Memo10: TMemo;
    ZabezGB1: TGroupBox;
    Label7: TLabel;
    ZabezRB1_2: TRadioButton;
    ZabezRb1_3: TRadioButton;
    ZwiazPanel: TPanel;
    Label9: TLabel;
    ZwiazEdit1: TEdit;
    ZwiazEdit2: TNumInp;
    ZwiazEdit3: TEdit;
    SkladScrollBox: TScrollBox;
    SkladLabel2_2: TLabel;
    SkladLabel2_4: TLabel;
    SkladLabel2_5: TLabel;
    SkladLabel2_8: TLabel;
    SkladLabel2_9: TLabel;
    SkladLabel2_10: TLabel;
    SkladEdit2_1: TEdit;
    SkladEdit2_14: TEdit;
    SkladEdit2_16: TEdit;
    SkladMemo3: TMemo;
    SkladMemo5: TMemo;
    SkladMemo6: TMemo;
    SkladMemo4: TMemo;
    Page9Button: TButton;
    SkladMemo2_3: TMemo;
    SkladEdit2_6: TEdit;
    SkladMaskEdit2_7: TMaskEdit;
    SkladEdit2_11: TEdit;
    SkladEdit2_12: TEdit;
    SkladEdit2_13: TEdit;
    SkladDate2_15: TIntDate;
    SkladTime2_17: TTimeEdit;
    SkladMemo1: TMemo;
    ScrollBox2: TScrollBox;
    WycofMemo1: TMemo;
    WycofMemo2: TMemo;
    WycofMemo3: TMemo;
    WycofMemo4: TMemo;
    WycofMemo5: TMemo;
    Page10Button: TButton;
    OpeningScrollBox: TScrollBox;
    OpeningEdit1_1: TEdit;
    OpeningEdit1_2: TEdit;
    OpeningEdit1_3: TEdit;
    OpeningEdit1_4: TEdit;
    OpeningEdit1_5: TEdit;
    OpeningEdit1_6: TEdit;
    OpeningMemo2: TMemo;
    OpeningMemo3: TMemo;
    Page11Button: TButton;
    OpeningDate1_2: TIntDate;
    OpeningTime1_4: TTimeEdit;
    ContentScrollBox: TScrollBox;
    ContentMemo1: TMemo;
    ContentMemo3: TMemo;
    Page12Button: TButton;
    ContentMemo2: TMemo;
    OcenaScrollBox: TScrollBox;
    OcenaMemo2: TMemo;
    OcenaMemo3_1: TMemo;
    OcenaMemo5: TMemo;
    OcenaMemo6: TMemo;
    OcenaMemo7: TMemo;
    OcenaMemo8: TMemo;
    OcenaMemo9: TMemo;
    Page13Button: TButton;
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
    ProtScrollBox: TScrollBox;
    ProtMemo1: TMemo;
    ProtMemo2: TMemo;
    ProtMemo3: TMemo;
    ProtMemo4: TMemo;
    ProtMemo5: TMemo;
    ProtMemo6: TMemo;
    ProtMemo7: TMemo;
    Page16Button: TButton;
    TabSet: TTabSet;
    ZabezCB2_2: TComboBox;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    ZabezCB3_2: TCheckBox;
    ZabezCB3_3: TCheckBox;
    ZabezCB3_4: TCheckBox;
    OpeningMemo4: TMemo;
    OpeningMemo5: TMemo;
    ContentMemo4: TMemo;
    ContentMemo5: TMemo;
    ContentMemo6: TMemo;
    WyborPanel: TPanel;
    WyborMemo1: TMemo;
    WyborMemo2: TMemo;
    Wybrnajkorzystniejszejoferty1: TMenuItem;
    Uniewaz1: TMenuItem;
    UniewazPanel: TPanel;
    UniewazMemo1: TMemo;
    Opis1: TMenuItem;
    Page14Button: TButton;
    Page15Button: TButton;
    Page8Button: TButton;
    Sk: TSmartKey;
    procedure FormCreate(Sender: TObject);
    procedure PrevBitBtnClick(Sender: TObject);
    procedure NextBitBtnClick(Sender: TObject);
    procedure PrintBitBtnClick(Sender: TObject);
    procedure AddBitBtnClick(Sender: TObject);
    procedure SaveBtnClick(Sender: TObject);
    procedure PageConfirmButtonClick(Sender: TObject);
    procedure FieldChange(Sender: TObject);
    procedure InfoMemo10_2DblClick(Sender: TObject);
    procedure CloseBtnClick(Sender: TObject);
    procedure InfoMemo10_2Enter(Sender: TObject);
    procedure InfoMemo10_2Exit(Sender: TObject);
    procedure UstawieniedrukarkiClick(Sender: TObject);
    procedure ZamknijClick(Sender: TObject);
    procedure OfertaRadioGroupClick(Sender: TObject);
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
    procedure OcenaCBClick(Sender: TObject);
    procedure OcenaEdit1DblClick(Sender: TObject);
    procedure OcenaSE2Change(Sender: TObject);
    procedure OcenaSE2Exit(Sender: TObject);
    procedure SkladDateEdit1_15Change(Sender: TObject);
    procedure OpeningDateEdit1_1Change(Sender: TObject);
    procedure ExportClick(Sender: TObject);
    procedure IdEditChange(Sender: TObject);
    procedure SuwakiClick(Sender: TObject);
    procedure TerminRb1Click(Sender: TObject);
    procedure TerminRB2Click(Sender: TObject);
    procedure TabSetClick(Sender: TObject);
    procedure OknaClick(Sender: TObject);
    procedure WadiumRB1_3Click(Sender: TObject);
    procedure WadiumEdit2_2Exit(Sender: TObject);
    procedure WadiumRB1_2Click(Sender: TObject);
    procedure InfoCB7Click(Sender: TObject);
    procedure ZabezRB1_2Click(Sender: TObject);
    procedure ZabezRb1_3Click(Sender: TObject);
    procedure Save1Click(Sender: TObject);
    procedure SaveAs1Click(Sender: TObject);
    procedure Nagwki1Click(Sender: TObject);
    procedure Opis1Click(Sender: TObject);
    procedure Ident1Click(Sender: TObject);
    procedure Wartzam1Click(Sender: TObject);
  private
    { Private declarations }
    Modified:Boolean;
    SelPages:Array[0..Prt4MaxPages-1] of Boolean;
    FilePwd:String;
    Phase:Byte;
   {$IFNDEF DEMO}
    PPos:Integer;
    PrintSpace:Integer;
    Ry:TRyPrinter;
    procedure MakeZamawPrint(var LP:Integer);
    procedure MakeTerminPrint(var LP:Integer);
    procedure MakeWarunkiPrint(var LP:Integer);
    procedure MakeRodzajPrint(var LP:Integer);
    procedure MakeInfoPrint(var LP:Integer);
    procedure MakeWadiumPrint(var LP:Integer);
    procedure MakeZabezPrint(var LP:Integer);
    procedure MakeZwiazPrint(var LP:Integer);
    procedure MakeSkladPrint(var LP:Integer);
    procedure MakeWycofPrint(var LP:Integer);
    procedure MakeOpenPrint(var LP:Integer);
    procedure MakeContentPrint(var LP:Integer);
    procedure MakeOcenaPrint(var LP:Integer);
    procedure MakeWyborPrint(var LP:Integer);
    procedure MakeUniewazPrint(var LP:Integer);
    procedure MakeProtestPrint(var LP:Integer);
    procedure MakePrint;
{    procedure AddPage(var LP:Integer);}
    procedure ExportToTxt(FileName:String);
   {$ENDIF}
    procedure ClearTabTag;
    procedure InitializeSiwz;
    procedure SiwzClose;
    procedure WadiumActive(State:Boolean);
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
    procedure TerminActivate(AGroupBox:Byte);
  end;

procedure Przetarg4(AFileName:String;APrt:Byte; PLN:Real;
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


procedure Przetarg4(AFileName:String;APrt:Byte;
                               PLN:Real; ALevel:Integer;
                               OKind:Byte; APrefKraj:Boolean);
var
  Curs:Integer;
  Del:Boolean;
  Prt4Dlg: TPrt4Dlg;
begin
  Curs:=Screen.Cursor;
  Screen.Cursor:=crHourGlass;
  GetAllConfiguration;
  Application.HelpFile:=SiwzHelpFile;
  FileMode:=fmOpenReadWrite + fmShareDenyWrite;
  Prt4Dlg:=TPrt4Dlg.Create(Nil);
  with Prt4Dlg do
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

procedure TPrt4Dlg.FormCreate(Sender: TObject);
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
    for i:=0 to Prt4MaxPages-1 do
      begin
        TabSet.TabIndex:=i;
        ClearTabTag;
      end;

  NoteBook.PageIndex:=0;
  TabSet.TabIndex:=0;

  OcenaSG1.ColWidths[ECol]:=100;
  OcenaSG1.ColWidths[CCol]:=30;
  OcenaSG1.ColWidths[DCol]:=OcenaSG1.Width-194-2;
  OcenaSG1.Cells[CCol,0]:='PK';
  OcenaSG1.Cells[WCol,0]:='Waga';
  OcenaSG1.Cells[DCol,0]:='Opis';
  OcenaSG1.Cells[ECol,0]:='Sposób';

  PrevBitBtn.Enabled:=FALSE;
  AddBitBtn.Enabled:=FALSE;
end;

procedure TPrt4Dlg.InitializeSiwz;
var
  F:File;
begin
  ResetPrt4Fields(Self,TenderType,ObjectKind,AmountLevel);
  SuwakiClick(Oba1);
  if OpenMode=oOpen
    then begin
      ClearPrt4Fields(Self);
      LoadFromFile(FileName);
    end
    else begin
      EndDate.EditDate:=Now;
      OpeningDate1_2.EditDate:=Now;
      SkladDate2_15.EditDate:=Now;
    end;
  if not PrefKrajowe
    then begin
      MessageDlg(wmGetPermit,mtWarning,[mbOk],0);
      OcenaMemo5.Color:=clGray;
      OcenaMemo5.Enabled:=FALSE;
    end
    else begin
      OcenaMemo5.Color:=clWhite;
      OcenaMemo5.Enabled:=TRUE;
    end;
  Modified:=FALSE;
end;

procedure TPrt4Dlg.PrevBitBtnClick(Sender: TObject);
begin
  PrevBitBtn.Enabled:= Notebook.PageIndex>0;
  NextBitBtn.Enabled:= Notebook.PageIndex<Prt4MaxPages-1;
  if PrevBitBtn.Enabled
    then Notebook.PageIndex:=Notebook.PageIndex-1;
  TabSet.TabIndex:=Notebook.PageIndex;
end;

procedure TPrt4Dlg.NextBitBtnClick(Sender: TObject);
begin
  PrevBitBtn.Enabled:= Notebook.PageIndex>0;
  NextBitBtn.Enabled:= Notebook.PageIndex<Prt4MaxPages-1;
  if NextBitBtn.Enabled
    then Notebook.PageIndex:=Notebook.PageIndex+1;
  TabSet.TabIndex:=Notebook.PageIndex;
end;

{Date fields}

procedure TPrt4Dlg.InfoMemo10_2Enter(Sender: TObject);
begin
  WhereAdd:=InfoMemo10_2;
  AddBitBtn.Enabled:=TRUE;
end;

procedure TPrt4Dlg.InfoMemo10_2Exit(Sender: TObject);
begin
  if not AddBitBtn.Focused
    then AddBitBtn.Enabled:=FALSE;
end;

procedure TPrt4Dlg.InfoMemo10_2DblClick(Sender: TObject);
var
  i:Byte;
  j:LongInt;
  Line:String;
  Already:Boolean;
begin
  Info9Dlg:=TInfo9Dlg.Create(Nil);
  with Info9Dlg do
    begin
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
                with InfoMemo10_2 do {lines already in SIWZ}
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

procedure TPrt4Dlg.WarunkiMemo2DblClick(Sender: TObject);
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

procedure TPrt4Dlg.WarunkiMemo2Enter(Sender: TObject);
begin
  WhereAdd:=WarunkiMemo2;
  AddBitBtn.Enabled:=TRUE;
end;

procedure TPrt4Dlg.WarunkiMemo2Exit(Sender: TObject);
begin
  if not AddBitBtn.Focused
    then AddBitBtn.Enabled:=FALSE;
end;

procedure TPrt4Dlg.ContentMemo2DblClick(Sender: TObject);
var
  i:LongInt;
  Comp:TComponent;
begin
  AddContDlg:=TAddContDlg.Create(Self,iNegocjacje,Phase);
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

procedure TPrt4Dlg.ContentMemo2Enter(Sender: TObject);
begin
  WhereAdd:=ContentMemo2;
  AddBitBtn.Enabled:=TRUE;
end;

procedure TPrt4Dlg.ContentMemo2Exit(Sender: TObject);
begin
  if not AddBitBtn.Focused
    then AddBitBtn.Enabled:=FALSE;
end;

procedure TPrt4Dlg.OcenaEdit1Enter(Sender: TObject);
begin
  WhereAdd:=OcenaEdit1;
  AddBitBtn.Enabled:=TRUE;
end;

procedure TPrt4Dlg.OcenaEdit1Exit(Sender: TObject);
begin
  if not AddBitBtn.Focused
    then AddBitBtn.Enabled:=FALSE;
end;

procedure TPrt4Dlg.AddBitBtnClick(Sender: TObject);
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
  else if WhereAdd=InfoMemo10_2
    then begin
      InfoMemo10_2DblClick(WhereAdd);
      InfoMemo10_2.SetFocus;
    end
end;

procedure TPrt4Dlg.SaveBtnClick(Sender: TObject);
begin
{$IFDEF NONET}
  if not SmartKeyOk(Sk,SkData)
    then Exit;
{$ENDIF}
  if FileName=''
    then with SaveDialog do
      begin
        DefaultExt:=NegExt;
        Filter:=NegFilter+NegExt;
        if Execute
          then begin
            SaveToFile(FileName);
          end;
      end
    else SaveToFile(FileName);
end;

procedure TPrt4Dlg.SaveToFile(FileName:String);
var
  FH:File;
  i:Byte;
  Cur:Integer;
  FileHdr:String;
  Scroll:TScrollStyle;
begin
  Cur:=Screen.Cursor;
  Screen.Cursor:=crHourGlass;
  Scroll:=InfoMemo1.ScrollBars;
  SuwakiClick(Oba1);
  AssignFile(FH,FileName);
  try
    Rewrite(FH,1);
    try
        FileHdr:=NegFileHdr;
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
        for i:=0 to Prt4MaxPages-1 do
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
        SaveBoolean(InfoCB7.Checked,FH);
        SaveMemo(InfoMemo8,FH);
        SaveMemo(InfoMemo9,FH);
        SaveMemo(InfoMemo10_1,FH);
        SaveMemo(InfoMemo10_2,FH);
    {Wadium}
        SaveBoolean(WadiumRB1_2.Checked,FH);
        SaveEdit(WadiumEdit2_1,FH);
        SaveReal(WadiumEdit2_2.Value,FH);
        SaveEdit(WadiumEdit2_3,FH);
        SaveEdit(WadiumEdit2_4,FH);
        SaveEdit(WadiumEdit2_5,FH);
        SaveEdit(WadiumEdit2_6,FH);
        SaveMemo(WadiumMemo3_1,FH);
        SaveBoolean(WadiumCB3_2.Checked,FH);
        SaveBoolean(WadiumCB3_3.Checked,FH);
        SaveEdit(WadiumEdit4_1,FH);
        SaveMemo(WadiumMemo4_2,FH);
        SaveMemo(WadiumMemo5,FH);
        SaveMemo(WadiumMemo6,FH);
        SaveMemo(WadiumMemo7_1,FH);
        SaveMemo(WadiumMemo7_2,FH);
        SaveMemo(WadiumMemo8,FH);
    {Zabez}
        SaveBoolean(ZabezRB1_2.Checked,FH);
        SaveMemo(ZabezMemo2_1,FH);
        SaveComboBox(ZabezCB2_2,FH);
        SaveMemo(ZabezMemo3_1,FH);
        SaveBoolean(ZabezCB3_2.Checked,FH);
        SaveBoolean(ZabezCB3_3.Checked,FH);
        SaveBoolean(ZabezCB3_4.Checked,FH);
    {Zwiaz}
        SaveEdit(ZwiazEdit1,FH);
        SaveInteger(ZwiazEdit2.AsInteger,FH);
        SaveEdit(ZwiazEdit3,FH);
    {Sklad}
        SaveMemo(SkladMemo1,FH);
        SaveEdit(SkladEdit2_1,FH);
        SaveMemo(SkladMemo2_3,FH);
        SaveEdit(SkladEdit2_6,FH);
        SaveMaskEdit(SkladMaskEdit2_7,FH);
        SaveEdit(SkladEdit2_11,FH);
        SaveEdit(SkladEdit2_12,FH);
        SaveEdit(SkladEdit2_13,FH);
        SaveEdit(SkladEdit2_14,FH);
        SaveDateTime(SkladDate2_15.EditDate,FH);
        SaveEdit(SkladEdit2_16,FH);
        SaveDateTime(SkladTime2_17.EditTime,FH);
        SaveMemo(SkladMemo3,FH);
        SaveMemo(SkladMemo4,FH);
        SaveMemo(SkladMemo5,FH);
        SaveMemo(SkladMemo6,FH);
    {Wycof}
        SaveMemo(WycofMemo1,FH);
        SaveMemo(WycofMemo2,FH);
        SaveMemo(WycofMemo3,FH);
        SaveMemo(WycofMemo4,FH);
        SaveMemo(WycofMemo5,FH);
    {Otwarcie}
        SaveEdit(OpeningEdit1_1,FH);
        SaveDateTime(OpeningDate1_2.EditDate,FH);
        SaveEdit(OpeningEdit1_2,FH);
        SaveDateTime(OpeningTime1_4.EditTime,FH);
        SaveEdit(OpeningEdit1_3,FH);
        SaveEdit(OpeningEdit1_4,FH);
        SaveEdit(OpeningEdit1_5,FH);
        SaveEdit(OpeningEdit1_6,FH);
        SaveMemo(OpeningMemo2,FH);
        SaveMemo(OpeningMemo3,FH);
        SaveMemo(OpeningMemo4,FH);
        SaveMemo(OpeningMemo5,FH);
    {Zawartosc}
        SaveMemo(ContentMemo1,FH);
        SaveMemo(ContentMemo2,FH);
        SaveMemo(ContentMemo3,FH);
        SaveMemo(ContentMemo4,FH);
        SaveMemo(ContentMemo5,FH);
        SaveMemo(ContentMemo6,FH);
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
        SaveBoolean(OcenaCB1.Checked,FH);
        SaveBoolean(OcenaCB2.Checked,FH);
        SaveBoolean(OcenaCB3.Checked,FH);
        SaveBoolean(OcenaCB4.Checked,FH);
        SaveMemo(OcenaMemo5,FH);
        SaveMemo(OcenaMemo6,FH);
        SaveMemo(OcenaMemo7,FH);
        SaveMemo(OcenaMemo8,FH);
        SaveMemo(OcenaMemo9,FH);
    {Wybor}
        SaveMemo(WyborMemo1,FH);
        SaveMemo(WyborMemo2,FH);
    {Uniewaz}
        SaveMemo(UniewazMemo1,FH);
    {Protesty}
        SaveMemo(ProtMemo1,FH);
        SaveMemo(ProtMemo2,FH);
        SaveMemo(ProtMemo3,FH);
        SaveMemo(ProtMemo4,FH);
        SaveMemo(ProtMemo5,FH);
        SaveMemo(ProtMemo6,FH);
        SaveMemo(ProtMemo7,FH);
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

procedure TPrt4Dlg.LoadFromFile(FileName:String);
var
  i:Integer;
  B:Boolean;
  SP:Array[0..Prt4MaxPages-1] of Boolean;
  T:Integer;
  s:String;
  Event:TNotifyEvent;
  DT:TDateTime;
  FH:File;
  r:Real;
  FileHdr:String;
begin
  AssignFile(FH,FileName);
  try
    Reset(FH,1);
    try
      FileHdr:=NegFileHdr;
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
              for i:=0 to Prt4MaxPages-1 do
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
              LoadInteger(T,FH);
              TerminEdit.Value:=T;
              LoadComboBox(TimeUnitCB,FH);
              LoadComboBox(CB2_5,FH);
    {Warunki}
              LoadEdit(WarunkiEdit1,FH);
              LoadMemo(WarunkiMemo1,FH);
              LoadMemo(WarunkiMemo2,FH);
    {Rodzaj}
              LoadInteger(T,FH);
              OfertaRadioGroup.ItemIndex:=T;
              LoadMemo(OfertaMemo,FH);
              OfertaMemo.Enabled:=(T=1);
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
    {Info}
              LoadMemo(InfoMemo1,FH);
              LoadMemo(InfoMemo2,FH);
              LoadMemo(InfoMemo3,FH);
              LoadMemo(InfoMemo4,FH);
              LoadMemo(InfoMemo5,FH);
              LoadMemo(InfoMemo6,FH);
              LoadBoolean(B,FH);
              InfoCB7.Checked:=B;
              LoadMemo(InfoMemo8,FH);
              LoadMemo(InfoMemo9,FH);
              LoadMemo(InfoMemo10_1,FH);
              LoadMemo(InfoMemo10_2,FH);
    {Wadium}
              LoadBoolean(B,FH);
              WadiumRB1_2.Checked:=B;
              WadiumRB1_3.Checked:= not B;
              LoadEdit(WadiumEdit2_1,FH);
              LoadReal(r,FH);
              WadiumEdit2_2.Value:=r;
              LoadEdit(WadiumEdit2_3,FH);
              LoadEdit(WadiumEdit2_4,FH);
              LoadEdit(WadiumEdit2_5,FH);
              LoadEdit(WadiumEdit2_6,FH);
              LoadMemo(WadiumMemo3_1,FH);
              LoadBoolean(B,FH);
              WadiumCB3_2.Checked:=B;
              LoadBoolean(B,FH);
              WadiumCB3_3.Checked:=B;
              LoadEdit(WadiumEdit4_1,FH);
              LoadMemo(WadiumMemo4_2,FH);
              LoadMemo(WadiumMemo5,FH);
              LoadMemo(WadiumMemo6,FH);
              LoadMemo(WadiumMemo7_1,FH);
              LoadMemo(WadiumMemo7_2,FH);
              LoadMemo(WadiumMemo8,FH);
    {Zabez}
              LoadBoolean(B,FH);
              ZabezRB1_2.Checked:=B;
              ZabezRB1_3.Checked:=not B;
              LoadMemo(ZabezMemo2_1,FH);
              LoadComboBox(ZabezCB2_2,FH);
              LoadMemo(ZabezMemo3_1,FH);
              LoadBoolean(B,FH);
              ZabezCB3_2.Checked:=B;
              LoadBoolean(B,FH);
              ZabezCB3_3.Checked:=B;
              LoadBoolean(B,FH);
              ZabezCB3_4.Checked:=B;
    {Zwiaz}
              LoadEdit(ZwiazEdit1,FH);
              LoadInteger(T,FH);
              ZwiazEdit2.Value:=T;
              LoadEdit(ZwiazEdit3,FH);
    {Sklad}
              LoadMemo(SkladMemo1,FH);
              LoadEdit(SkladEdit2_1,FH);
              LoadMemo(SkladMemo2_3,FH);
              LoadEdit(SkladEdit2_6,FH);
              LoadMaskEdit(SkladMaskEdit2_7,FH);
              LoadEdit(SkladEdit2_11,FH);
              LoadEdit(SkladEdit2_12,FH);
              LoadEdit(SkladEdit2_13,FH);
              LoadEdit(SkladEdit2_14,FH);
              LoadDateTime(DT,FH);
              SkladDate2_15.EditDate:=DT;
              LoadEdit(SkladEdit2_16,FH);
              LoadDateTime(DT,FH);
              SkladTime2_17.EditTime:=DT;
              LoadMemo(SkladMemo3,FH);
              LoadMemo(SkladMemo4,FH);
              LoadMemo(SkladMemo5,FH);
              LoadMemo(SkladMemo6,FH);
    {Wycof}
              LoadMemo(WycofMemo1,FH);
              LoadMemo(WycofMemo2,FH);
              LoadMemo(WycofMemo3,FH);
              LoadMemo(WycofMemo4,FH);
              LoadMemo(WycofMemo5,FH);
    {Otwarcie}
              LoadEdit(OpeningEdit1_1,FH);
              LoadDateTime(DT,FH);
              OpeningDate1_2.EditDate:=DT;
              LoadEdit(OpeningEdit1_2,FH);
              LoadDateTime(DT,FH);
              OpeningTime1_4.EditTime:=DT;
              LoadEdit(OpeningEdit1_3,FH);
              LoadEdit(OpeningEdit1_4,FH);
              LoadEdit(OpeningEdit1_5,FH);
              LoadEdit(OpeningEdit1_6,FH);
              LoadMemo(OpeningMemo2,FH);
              LoadMemo(OpeningMemo3,FH);
              LoadMemo(OpeningMemo4,FH);
              LoadMemo(OpeningMemo5,FH);
    {Zawartosc}
              LoadMemo(ContentMemo1,FH);
              LoadMemo(ContentMemo2,FH);
              LoadMemo(ContentMemo3,FH);
              LoadMemo(ContentMemo4,FH);
              LoadMemo(ContentMemo5,FH);
              LoadMemo(ContentMemo6,FH);
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
              LoadBoolean(B,FH);
              OcenaCB1.Checked:=B;
              LoadBoolean(B,FH);
              OcenaCB2.Checked:=B;
              LoadBoolean(B,FH);
              OcenaCB3.Checked:=B;
              LoadBoolean(B,FH);
              OcenaCB4.Checked:=B;
              LoadMemo(OcenaMemo5,FH);
              LoadMemo(OcenaMemo6,FH);
              LoadMemo(OcenaMemo7,FH);
              LoadMemo(OcenaMemo8,FH);
              LoadMemo(OcenaMemo9,FH);
    {Wybor}
              LoadMemo(WyborMemo1,FH);
              LoadMemo(WyborMemo2,FH);
    {Uniewaz}
              LoadMemo(UniewazMemo1,FH);
    {Protesty}
              LoadMemo(ProtMemo1,FH);
              LoadMemo(ProtMemo2,FH);
              LoadMemo(ProtMemo3,FH);
              LoadMemo(ProtMemo4,FH);
              LoadMemo(ProtMemo5,FH);
              LoadMemo(ProtMemo6,FH);
              LoadMemo(ProtMemo7,FH);
              for i:=0 to Prt4MaxPages-1 do
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

procedure TPrt4Dlg.SiwzClose;
begin
  if Modified
    then begin
       if MessageDlg('Zachowaæ SIWZ ?',mtConfirmation,[mbYes,mbNo],0)=mrYes
         then SaveBtnClick(Self);
    end;
  Close;
end;

procedure TPrt4Dlg.CloseBtnClick(Sender: TObject);
begin
  SiwzClose;
end;

procedure TPrt4Dlg.ZamknijClick(Sender: TObject);
begin
  CloseBtnClick(Sender);
end;

procedure TPrt4Dlg.UstawieniedrukarkiClick(Sender: TObject);
begin
  PrinterSetupDlg.Execute;
end;

procedure TPrt4Dlg.PageConfirmButtonClick(Sender: TObject);
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

procedure TPrt4Dlg.FieldChange(Sender: TObject);
begin
  Modified:=TRUE;
  ClearTabTag;
end;

procedure TPrt4Dlg.OfertaRadioGroupClick(Sender: TObject);
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

procedure TPrt4Dlg.NipRB1Click(Sender: TObject);
begin
  NipMaskEdit1.Enabled:=TRUE;
  NipMaskEdit1.Color:=clAqua;
  NipMaskEdit2.Enabled:=FALSE;
  NipMaskEdit2.Color:=clGray;
  FieldChange(Sender);
end;

procedure TPrt4Dlg.NipRB2Click(Sender: TObject);
begin
  NipMaskEdit1.Enabled:=FALSE;
  NipMaskEdit1.Color:=clGray;
  NipMaskEdit2.Enabled:=TRUE;
  NipMaskEdit2.Color:=clAqua;
  FieldChange(Sender);
end;

procedure TPrt4Dlg.OcenaCBClick(Sender: TObject);
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

procedure TPrt4Dlg.OcenaEdit1DblClick(Sender: TObject);
var
  i,j:LongInt;
begin
  KriteriaDlg:=TKriteriaDlg.Create(Self);
  with KriteriaDlg do
    begin
      KSG.RowCount:=OcenaSG1.RowCount;
      for i:=1 to OcenaSG1.RowCount-1 do
        begin
          KSG.Cells[KCCol,i]:=OcenaSG1.Cells[CCol,i];
          KSG.Cells[KDCol,i]:=OcenaSG1.Cells[DCol,i];
          KSG.Cells[KWCol,i]:=OcenaSG1.Cells[WCol,i];
          KSG.Cells[KECol,i]:=OcenaSG1.Cells[ECol,i];
        end;
      if ShowModal=mrOk
        then begin
          OcenaSG1.RowCount:=KSG.RowCount;
          for i:=1 to KSG.RowCount-1 do
            begin
              OcenaSG1.Cells[CCol,i]:=KSG.Cells[KCCol,i];
              OcenaSG1.Cells[DCol,i]:=KSG.Cells[KDCol,i];
              OcenaSG1.Cells[WCol,i]:=KSG.Cells[KWCol,i];
              OcenaSG1.Cells[ECol,i]:=KSG.Cells[KECol,i];
            end;
          FieldChange(Sender);
        end;
      KriteriaDlg.Free;
    end;
end;

procedure TPrt4Dlg.OcenaSE2Change(Sender: TObject);
begin
  if OcenaSE2.Text=''
    then Exit;
  if StrToInt(OcenaSE2.Text)>OcenaSE2.MaxValue
    then begin
      MessageDlg(wmValueOver32767,mtWarning,[mbOk],0);
      OcenaSE2.Text:='32767'
    end;
end;

procedure TPrt4Dlg.OcenaSE2Exit(Sender: TObject);
begin
  if OcenaSE2.Text=''
    then OcenaSE2.Text:='0';
end;

procedure TPrt4Dlg.SkladDateEdit1_15Change(Sender: TObject);
begin
  OpeningDateEdit1_1Change(Sender);
end;

procedure TPrt4Dlg.OpeningDateEdit1_1Change(Sender: TObject);
var
  by,bm,bd,
  ey,em,ed:Word;
  Ok:Boolean;
begin
  try
    DecodeDate(SkladDate2_15.EditDate,by,bm,bd);
    DecodeDate(OpeningDate1_2.EditDate,ey,em,ed);
    Ok := (JulianDate(ey,em,ed)-JulianDate(by,bm,bd)) >= 0;
    if not Ok
      then begin
        MessageDlg(wmOpenDateBeforeSkladDate,mtWarning,[mbOk],0);
      end;
  finally
  end;
  FieldChange(Sender);
end;

{$IFNDEF DEMO}
procedure TPrt4Dlg.MakeZamawPrint(var LP:Integer);
var
  p1,p2,p3,p4,p5,p6,p7,p8,p9,p10,p11,p12:PChar;
  s:String;
begin
  p1:=Nil;p2:=Nil;p3:=Nil;p4:=Nil;p5:=Nil;p6:=Nil;p7:=Nil;
  p8:=Nil;p9:=Nil;p10:=Nil;p11:=Nil;p12:=Nil;
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
  p10:=StrAlloc(Length(ZwanyEdit.Text)+Length(ZamawEdit.Text)+1);
  StrPCopy(p10,ZwanyEdit.Text+ZamawEdit.Text);
  p11:=StrAlloc(ObjectMemo.GetTextLen + 1);
  ObjectMemo.GetTextBuf(p11, ObjectMemo.GetTextLen+1);
  p12:=StrAlloc(AnnexMemo.GetTextLen + 1);
  AnnexMemo.GetTextBuf(p12, AnnexMemo.GetTextLen+1);
  AddParag(Ry,[p1,p2,p3,p4,p5,p6,p7,p8,p9,p10,p11,p12],[2,1,1,1,1,1,1,1,1,1,1,1,3],PrintSpace,LP);
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
end;

procedure TPrt4Dlg.MakeTerminPrint(var LP:Integer);
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

procedure TPrt4Dlg.MakeWarunkiPrint(var LP:Integer);
var
  p1,p2,p3:PChar;
begin
  if Nagwki1.Checked
    then AddBoldString(Ry,Page3,2,PrintSpace,LP);
  p1:=StrAlloc(Length(WarunkiEdit1.Text)+1);
  StrPCopy(p1,WarunkiEdit1.Text);
  p2:=StrAlloc(WarunkiMemo1.GetTextLen + 1);
  WarunkiMemo1.GetTextBuf(p2, WarunkiMemo1.GetTextLen+1);
  p3:=StrAlloc(WarunkiMemo2.GetTextLen + 1);
  WarunkiMemo2.GetTextBuf(p3, WarunkiMemo2.GetTextLen+1);
  AddParag(Ry,[p1,p2,p3],[1,0,3],PrintSpace,LP);
  StrDispose(p1);
  StrDispose(p2);
  StrDispose(p3);
end;

procedure TPrt4Dlg.MakeRodzajPrint(var LP:Integer);
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

procedure TPrt4Dlg.MakeInfoPrint(var LP:Integer);
var
  p1,p2,p3,p4,p5,p6,p7,p8,p9,p10_1,p10_2:PChar;
begin
  if Nagwki1.Checked
    then AddBoldString(Ry,Page5,2,PrintSpace,LP);
  p1:=Nil;p2:=Nil;p3:=Nil;p4:=Nil;p5:=Nil;p6:=Nil;p7:=Nil;
  p8:=Nil;p9:=Nil;p10_1:=Nil;p10_2:=Nil;
  p1:=StrAlloc(InfoMemo1.GetTextLen + 1);
  InfoMemo1.GetTextBuf(p1, InfoMemo1.GetTextLen+1);
  p2:=StrAlloc(InfoMemo2.GetTextLen + 1);
  InfoMemo2.GetTextBuf(p2, InfoMemo2.GetTextLen+1);
  p3:=StrAlloc(InfoMemo3.GetTextLen + 1);
  InfoMemo3.GetTextBuf(p3, InfoMemo3.GetTextLen+1);
  p4:=StrAlloc(InfoMemo4.GetTextLen + 1);
  InfoMemo4.GetTextBuf(p4, InfoMemo4.GetTextLen+1);
  p5:=StrAlloc(InfoMemo5.GetTextLen + 1);
  InfoMemo5.GetTextBuf(p5, InfoMemo5.GetTextLen+1);
  p6:=StrAlloc(InfoMemo6.GetTextLen + 1);
  InfoMemo6.GetTextBuf(p6, InfoMemo6.GetTextLen+1);
  if InfoCB7.Checked
    then begin
      p7:=StrAlloc(Length(InfoCB7.Caption) + 1);
      StrPCopy(p7,InfoCB7.Caption);
      p8:=StrAlloc(InfoMemo8.GetTextLen + 1);
      InfoMemo8.GetTextBuf(p8, InfoMemo8.GetTextLen+1);
      p9:=StrAlloc(InfoMemo9.GetTextLen + 1);
      InfoMemo9.GetTextBuf(p9, InfoMemo9.GetTextLen+1);
      p10_1:=StrAlloc(InfoMemo10_1.GetTextLen + 1);
      InfoMemo10_1.GetTextBuf(p10_1, InfoMemo10_1.GetTextLen+1);
      p10_2:=StrAlloc(InfoMemo10_2.GetTextLen + 1);
      InfoMemo10_2.GetTextBuf(p10_2, InfoMemo10_2.GetTextLen+1);
    end;
  AddParag(Ry,[p1,p2,p3,p4,p5,p6,p7,p8,p9,p10_1,p10_2],[1,1,1,1,1,1,1,1,1,1,3],PrintSpace,LP);
  StrDispose(p1);
  StrDispose(p2);
  StrDispose(p3);
  StrDispose(p4);
  StrDispose(p5);
  StrDispose(p6);
  StrDispose(p7);
  StrDispose(p8);
  StrDispose(p9);
  StrDispose(p10_1);
  StrDispose(p10_2);
end;

procedure TPrt4Dlg.MakeWadiumPrint(var LP:Integer);
var
  p1,p2,p3,p4,p5,p6,p7,p8,p9,p10:PChar;
begin
  if WadiumRB1_3.Checked
    then Exit;
  if Nagwki1.Checked
    then AddBoldString(Ry,Page6,2,PrintSpace,LP);
  p1:=Nil;p2:=Nil;p3:=Nil;p4:=Nil;p5:=Nil;p6:=Nil;p7:=Nil;
  p8:=Nil;p9:=Nil;p10:=Nil;
  p1:=StrAlloc(Length(WadiumEdit2_1.Text)+Length(WadiumEdit2_2.Text)+Length(WadiumEdit2_3.Text)+1);
  StrPCopy(p1,WadiumEdit2_1.Text+WadiumEdit2_2.Text+WadiumEdit2_3.Text);
  p2:=StrAlloc(Length(WadiumEdit2_4.Text)+Length(WadiumEdit2_5.Text)+Length(WadiumEdit2_6.Text)+1);
  StrPCopy(p2,WadiumEdit2_4.Text+WadiumEdit2_5.Text+WadiumEdit2_6.Text);
  if WadiumCB3_2.Checked
    then WadiumMemo3_1.Lines.Add(WadiumCB3_2.Caption);
  if WadiumCB3_3.Checked
    then WadiumMemo3_1.Lines.Add(WadiumCB3_3.Caption);
  p3:=StrAlloc(WadiumMemo3_1.GetTextLen + 1);
  WadiumMemo3_1.GetTextBuf(p3, WadiumMemo3_1.GetTextLen+1);
  if WadiumCB3_2.Checked
    then WadiumMemo3_1.Lines.Delete(WadiumMemo3_1.Lines.Count-1);
  if WadiumCB3_3.Checked
    then WadiumMemo3_1.Lines.Delete(WadiumMemo3_1.Lines.Count-1);
  if WadiumMemo4_2.Lines.Count>0
    then begin
      p4:=StrAlloc(Length(WadiumEdit4_1.Text)+1);
      StrPCopy(p4,WadiumEdit4_1.Text);
      p5:=StrAlloc(WadiumMemo4_2.GetTextLen + 1);
      WadiumMemo4_2.GetTextBuf(p5, WadiumMemo4_2.GetTextLen+1);
    end;
  p6:=StrAlloc(WadiumMemo5.GetTextLen + 1);
  WadiumMemo5.GetTextBuf(p6, WadiumMemo5.GetTextLen+1);
  p7:=StrAlloc(WadiumMemo6.GetTextLen + 1);
  WadiumMemo6.GetTextBuf(p7, WadiumMemo6.GetTextLen+1);
  p8:=StrAlloc(WadiumMemo7_1.GetTextLen + 1);
  WadiumMemo7_1.GetTextBuf(p8, WadiumMemo7_1.GetTextLen+1);
  p9:=StrAlloc(WadiumMemo7_2.GetTextLen + 1);
  WadiumMemo7_2.GetTextBuf(p9, WadiumMemo7_2.GetTextLen+1);
  p10:=StrAlloc(WadiumMemo8.GetTextLen + 1);
  WadiumMemo8.GetTextBuf(p10, WadiumMemo8.GetTextLen+1);
  AddParag(Ry,[p1,p2,p3,p4,p5,p6,p7,p8,p9,p10],[0,1,1,0,1,1,1,0,1,3],PrintSpace,LP);
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
end;

procedure TPrt4Dlg.MakeZabezPrint(var LP:Integer);
var
  p1,p2:PChar;
begin
  if ZabezRb1_3.Checked
    then Exit;
  if Nagwki1.Checked
    then AddBoldString(Ry,Page7,2,PrintSpace,LP);
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

procedure TPrt4Dlg.MakeZwiazPrint(var LP:Integer);
var
  p1:PChar;
begin
  if Nagwki1.Checked
    then AddBoldString(Ry,Page8,2,PrintSpace,LP);
  p1:=Nil;
  p1:=StrAlloc(Length(ZwiazEdit1.Text)+Length(ZwiazEdit2.Text)+Length(ZwiazEdit3.Text)+1);
  StrPCopy(p1,ZwiazEdit1.Text+ZwiazEdit2.Text+ZwiazEdit3.Text);
  AddParag(Ry,[p1],[3],PrintSpace,LP);
  StrDispose(p1);
end;

procedure TPrt4Dlg.MakeSkladPrint(var LP:Integer);
var
  p1,p2,p3,p4,p5,p6,p7,p8,p9,p10:PChar;
begin
  if Nagwki1.Checked
    then AddBoldString(Ry,Page9,2,PrintSpace,LP);
  p1:=Nil;p2:=Nil;p3:=Nil;p4:=Nil;p5:=Nil;p6:=Nil;p7:=Nil;
  p8:=Nil;p9:=Nil;p10:=Nil;
  p1:=StrAlloc(SkladMemo1.GetTextLen + 1);
  SkladMemo1.GetTextBuf(p1, SkladMemo1.GetTextLen+1);
  p2:=StrAlloc(Length(SkladEdit2_1.Text)+1);
  StrPCopy(p2,SkladEdit2_1.Text);
  p3:=StrAlloc(SkladMemo2_3.GetTextLen + 1);
  SkladMemo2_3.GetTextBuf(p3, SkladMemo2_3.GetTextLen+1);
  p4:=StrAlloc(Length(SkladLabel2_4.Caption)+Length(SkladEdit2_6.Text)+
              Length(SkladLabel2_5.Caption)+Length(SkladMaskEdit2_7.Text)+1);
  StrPCopy(p4,SkladLabel2_4.Caption+SkladEdit2_6.Text+SkladLabel2_5.Caption+SkladMaskEdit2_7.Text);
  p5:=StrAlloc(Length(SkladLabel2_8.Caption)+Length(SkladEdit2_11.Text)+
              Length(SkladLabel2_9.Caption)+Length(SkladEdit2_12.Text)+
              Length(SkladLabel2_10.Caption)+Length(SkladEdit2_13.Text)+1);
  StrPCopy(p5,SkladLabel2_8.Caption+SkladEdit2_11.Text+SkladLabel2_9.Caption+
             SkladEdit2_12.Text+SkladLabel2_10.Caption+SkladEdit2_13.Text);
  p6:=StrAlloc(Length(SkladEdit2_14.Text)+Length(SkladDate2_15.Text)+
              Length(SkladEdit2_16.Text)+Length(SkladTime2_17.Text)+1);
  StrPCopy(p6,SkladEdit2_14.Text+SkladDate2_15.Text+SkladEdit2_16.Text+SkladTime2_17.Text);
  p7:=StrAlloc(SkladMemo3.GetTextLen + 1);
  SkladMemo3.GetTextBuf(p7, SkladMemo3.GetTextLen+1);
  p8:=StrAlloc(SkladMemo4.GetTextLen + 1);
  SkladMemo4.GetTextBuf(p8, SkladMemo4.GetTextLen+1);
  p9:=StrAlloc(SkladMemo5.GetTextLen + 1);
  SkladMemo5.GetTextBuf(p9, SkladMemo5.GetTextLen+1);
  p10:=StrAlloc(SkladMemo6.GetTextLen + 1);
  SkladMemo6.GetTextBuf(p10, SkladMemo6.GetTextLen+1);
  AddParag(Ry,[p1,p2,p3,p4,p5,p6,p7,p8,p9,p10],[1,0,0,0,0,1,1,1,1,3],PrintSpace,LP);
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
end;

procedure TPrt4Dlg.MakeWycofPrint(var LP:Integer);
var
  p1,p2,p3,p4,p5:PChar;
begin
  if Nagwki1.Checked
    then AddBoldString(Ry,Page10,2,PrintSpace,LP);
  p1:=Nil;p2:=Nil;p3:=Nil;p4:=Nil;p5:=Nil;
  p1:=StrAlloc(WycofMemo1.GetTextLen + 1);
  WycofMemo1.GetTextBuf(p1, WycofMemo1.GetTextLen+1);
  p2:=StrAlloc(WycofMemo2.GetTextLen + 1);
  WycofMemo2.GetTextBuf(p2, WycofMemo2.GetTextLen+1);
  p3:=StrAlloc(WycofMemo3.GetTextLen + 1);
  WycofMemo3.GetTextBuf(p3, WycofMemo3.GetTextLen+1);
  p4:=StrAlloc(WycofMemo4.GetTextLen + 1);
  WycofMemo4.GetTextBuf(p4, WycofMemo4.GetTextLen+1);
  p5:=StrAlloc(WycofMemo5.GetTextLen + 1);
  WycofMemo5.GetTextBuf(p5, WycofMemo5.GetTextLen+1);
  AddParag(Ry,[p1,p2,p3,p4,p5],[1,1,1,1,3],PrintSpace,LP);
  StrDispose(p1);
  StrDispose(p2);
  StrDispose(p3);
  StrDispose(p4);
  StrDispose(p5);
end;

procedure TPrt4Dlg.MakeOpenPrint(var LP:Integer);
var
  p1,p2,p3,p4,p5,p6,p7,p8,p9,p10:PChar;
begin
  if Nagwki1.Checked
    then AddBoldString(Ry,Page11,2,PrintSpace,LP);
  p1:=Nil;p2:=Nil;p3:=Nil;p4:=Nil;p5:=Nil;
  p1:=StrAlloc(Length(OpeningEdit1_1.Text)+Length(OpeningDate1_2.Text)+Length(OpeningEdit1_2.Text)+
              Length(OpeningTime1_4.Text)+Length(OpeningEdit1_3.Text)+Length(OpeningEdit1_4.Text)+
              Length(OpeningEdit1_5.Text)+Length(OpeningEdit1_6.Text)+1);
  StrPCopy(p1,OpeningEdit1_1.Text+OpeningDate1_2.Text+OpeningEdit1_2.Text+OpeningTime1_4.Text+
           OpeningEdit1_3.Text+OpeningEdit1_4.Text+OpeningEdit1_5.Text+OpeningEdit1_6.Text);
  p2:=StrAlloc(OpeningMemo2.GetTextLen + 1);
  OpeningMemo2.GetTextBuf(p2, OpeningMemo2.GetTextLen);
  p3:=StrAlloc(OpeningMemo3.GetTextLen + 1);
  OpeningMemo3.GetTextBuf(p3, OpeningMemo3.GetTextLen);
  p4:=StrAlloc(OpeningMemo4.GetTextLen + 1);
  OpeningMemo4.GetTextBuf(p4, OpeningMemo4.GetTextLen);
  p5:=StrAlloc(OpeningMemo5.GetTextLen + 1);
  OpeningMemo5.GetTextBuf(p5, OpeningMemo5.GetTextLen);
  AddParag(Ry,[p1,p2,p3,p4,p5],[1,1,1,1,3],PrintSpace,LP);
  StrDispose(p1);
  StrDispose(p2);
  StrDispose(p3);
  StrDispose(p4);
  StrDispose(p5);
end;

procedure TPrt4Dlg.MakeContentPrint(var LP:Integer);
var
  p1,p2,p3,p4,p5,p6:PChar;
begin
  if Nagwki1.Checked
    then AddBoldString(Ry,Page12,2,PrintSpace,LP);
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

procedure TPrt4Dlg.MakeOcenaPrint(var LP:Integer);
var
  p,p2,p3,p4,p5,p6,p7,p8,p9,p10,p11,p12,p13,p14,p15,p16,p17,p18,p19:PChar;
  X,i:Integer;
  s,s1,s2:String;
  function GetTextHeight(p:PChar):Integer;
  begin
    with Ry do
      Result:=MemoOut(Rect(XLOff+Xmm(2),0,XROff-Xmm(2),10), p, False, True);
  end;
  procedure AddPage(var LP:Integer);
  begin
    LP:=Ry.YTOff;
    Ry.NewPage;
    Ry.Font.Name:='Arial CE';
    Ry.Font.Style:=[];
    Ry.Font.Size:=10;
  end;

begin
  with Ry do
    begin
      if Nagwki1.Checked
        then AddBoldString(Ry,Page13,2,PrintSpace,LP);
      p2:=Nil;p3:=Nil;p4:=Nil;p5:=Nil;p6:=Nil;
      p7:=Nil;p8:=Nil;p9:=Nil;p10:=Nil;p11:=Nil;
      p12:=Nil;p13:=Nil;p14:=Nil;p15:=Nil;p16:=Nil;
      p17:=Nil;p18:=Nil;p19:=Nil;
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
      p2:=StrAlloc(OcenaMemo2.GetTextLen + 1);
      OcenaMemo2.GetTextBuf(p2, OcenaMemo2.GetTextLen+1);
      p3:=StrAlloc(OcenaMemo3_1.GetTextLen+1);
      OcenaMemo3_1.GetTextBuf(p3, OcenaMemo3_1.GetTextLen+1);
      p4:=StrAlloc(Length(OcenaEdit3_2.Text)+Length(OcenaSE2.Text)+Length(OcenaEdit3_3.Text)+1);
      StrPCopy(p4,OcenaEdit3_2.Text+OcenaSE2.Text+OcenaEdit3_3.Text);
      if (OcenaCB1.Checked) or (OcenaCB2.Checked) or (OcenaCB3.Checked) or (OcenaCB4.Checked)
        then begin
          p5:=StrAlloc(OcenaMemo3_4.GetTextLen+1);
          OcenaMemo3_4.GetTextBuf(p5, OcenaMemo3_4.GetTextLen+1);
          if OcenaCB1.Checked
            then begin
              p6:=StrAlloc(Length(OcenaCB1.Caption)+2);
              StrPCopy(p6,OcenaCB1.Caption+':');
              p7:=StrAlloc(OcenaMemo3_5.GetTextLen+1);
              OcenaMemo3_5.GetTextBuf(p7, OcenaMemo3_5.GetTextLen+1);
            end;
          if OcenaCB2.Checked
            then begin
              p8:=StrAlloc(Length(OcenaCB2.Caption)+2);
              StrPCopy(p8,OcenaCB2.Caption+':');
              p9:=StrAlloc(OcenaMemo3_6.GetTextLen+1);
              OcenaMemo3_6.GetTextBuf(p9, OcenaMemo3_6.GetTextLen+1);
            end;
          if OcenaCB3.Checked
            then begin
              p10:=StrAlloc(Length(OcenaCB3.Caption)+2);
              StrPCopy(p10,OcenaCB3.Caption+':');
              p11:=StrAlloc(OcenaMemo3_7.GetTextLen+1);
              OcenaMemo3_7.GetTextBuf(p11, OcenaMemo3_7.GetTextLen+1);
            end;
          if OcenaCB4.Checked
            then begin
              p12:=StrAlloc(Length(OcenaCB4.Caption)+2);
              StrPCopy(p12,OcenaCB4.Caption+':');
              p13:=StrAlloc(OcenaMemo3_8.GetTextLen+1);
              OcenaMemo3_8.GetTextBuf(p13, OcenaMemo3_8.GetTextLen+1);
            end;
        end;
      if OcenaMemo5.Enabled
        then begin
          p14:=StrAlloc(OcenaMemo5.GetTextLen + 1);
          OcenaMemo5.GetTextBuf(p14, OcenaMemo5.GetTextLen+1);
        end;
      p15:=StrAlloc(OcenaMemo6.GetTextLen + 1);
      OcenaMemo6.GetTextBuf(p15, OcenaMemo6.GetTextLen+1);
      p16:=StrAlloc(OcenaMemo7.GetTextLen + 1);
      OcenaMemo7.GetTextBuf(p16, OcenaMemo7.GetTextLen+1);
      p17:=StrAlloc(OcenaMemo8.GetTextLen + 1);
      OcenaMemo8.GetTextBuf(p17, OcenaMemo8.GetTextLen+1);
      p18:=StrAlloc(OcenaMemo9.GetTextLen + 1);
      OcenaMemo9.GetTextBuf(p18, OcenaMemo9.GetTextLen+1);
      AddParag(Ry,[p2,p3,p4,p5,p6,p7,p8,p9,p10,p11,p12,p13,p14,p15,p16,p17,p18,p19],
                  [1,1,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,3],PrintSpace,LP);
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
      StrDispose(p14);
      StrDispose(p15);
      StrDispose(p16);
      StrDispose(p17);
      StrDispose(p18);
      StrDispose(p19);
    end;
end;

procedure TPrt4Dlg.MakeWyborPrint(var LP:Integer);
var
  p1,p2:PChar;
begin
  if Nagwki1.Checked
    then AddBoldString(Ry,Page14,2,PrintSpace,LP);
  p1:=Nil;p2:=Nil;
  p1:=StrAlloc(WyborMemo1.GetTextLen + 1);
  WyborMemo1.GetTextBuf(p1, WyborMemo1.GetTextLen+1);
  p2:=StrAlloc(WyborMemo2.GetTextLen + 1);
  WyborMemo2.GetTextBuf(p2, WyborMemo2.GetTextLen+1);
  AddParag(Ry,[p1,p2],[1,3],PrintSpace,LP);
  StrDispose(p1);
  StrDispose(p2);
end;

procedure TPrt4Dlg.MakeUniewazPrint(var LP:Integer);
var
  p1:PChar;
begin
  if Nagwki1.Checked
    then AddBoldString(Ry,Page15,2,PrintSpace,LP);
  p1:=Nil;
  p1:=StrAlloc(UniewazMemo1.GetTextLen + 1);
  UniewazMemo1.GetTextBuf(p1, UniewazMemo1.GetTextLen+1);
  AddParag(Ry,[p1],[3],PrintSpace,LP);
  StrDispose(p1);
end;

procedure TPrt4Dlg.MakeProtestPrint(var LP:Integer);
var
  p1,p2,p3,p4,p5,p6,p7:PChar;
begin
  if Nagwki1.Checked
    then AddBoldString(Ry,Page16,2,PrintSpace,LP);
  p1:=Nil;p2:=Nil;p3:=Nil;p4:=Nil;p5:=Nil;p6:=Nil;p7:=Nil;
  p1:=StrAlloc(ProtMemo1.GetTextLen + 1);
  ProtMemo1.GetTextBuf(p1, ProtMemo1.GetTextLen+1);
  p2:=StrAlloc(ProtMemo2.GetTextLen + 1);
  ProtMemo2.GetTextBuf(p2, ProtMemo2.GetTextLen+1);
  p3:=StrAlloc(ProtMemo3.GetTextLen + 1);
  ProtMemo3.GetTextBuf(p3, ProtMemo3.GetTextLen+1);
  p4:=StrAlloc(ProtMemo4.GetTextLen + 1);
  ProtMemo4.GetTextBuf(p4, ProtMemo4.GetTextLen+1);
  p5:=StrAlloc(ProtMemo5.GetTextLen + 1);
  ProtMemo5.GetTextBuf(p5, ProtMemo5.GetTextLen+1);
  p6:=StrAlloc(ProtMemo6.GetTextLen + 1);
  ProtMemo6.GetTextBuf(p6, ProtMemo6.GetTextLen+1);
  p7:=StrAlloc(ProtMemo7.GetTextLen + 1);
  ProtMemo7.GetTextBuf(p7, ProtMemo7.GetTextLen+1);
  AddParag(Ry,[p1,p2,p3,p4,p5,p6,p7],[1,1,1,1,1,1,3],PrintSpace,LP);
  StrDispose(p1);
  StrDispose(p2);
  StrDispose(p3);
  StrDispose(p4);
  StrDispose(p5);
  StrDispose(p6);
  StrDispose(p7);
end;

procedure TPrt4Dlg.MakePrint;
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
      X:=MemoOut(Rect(XLOff+Xmm(2),LP,XROff-Xmm(2),10), sSIWZ, False, False);
      LP:=LP+X+Ymm(3);
      Font.Size:=14;
      Font.Style:=[fsBold];
      s:=sNegocjacjeTitle;
      p:=StrAlloc(Length(s)+1);
      StrPCopy(p,s);
      X:=MemoOut(Rect(XLOff+Xmm(2),LP,XROff-Xmm(2),10), p, False, False);
      StrDispose(p);
      LP:=LP+X+Ymm(5);
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
      MakeWarunkiPrint(LP);
      MakeRodzajPrint(LP);
      MakeInfoPrint(LP);
      MakeWadiumPrint(LP);
      MakeZabezPrint(LP);
      MakeZwiazPrint(LP);
      MakeSkladPrint(LP);
      MakeWycofPrint(LP);
      MakeOpenPrint(LP);
      MakeContentPrint(LP);
      MakeOcenaPrint(LP);
      MakeWyborPrint(LP);
      MakeUniewazPrint(LP);
      MakeProtestPrint(LP);
      PutPageNums(((XROff-XLOff) div 2) +XLOff,YBOff-Ymm(10),taCenter);
    end;
end;
{$ENDIF}

procedure TPrt4Dlg.PrintBitBtnClick(Sender: TObject);
var
  Cur:Integer;
begin
{$IFDEF DEMO}
  MessageDlg('Nie dostêpne w wersji DEMO',mtInformation,[mbOk],0);
{$ELSE}
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
{$ENDIF}
end;

procedure TPrt4Dlg.Drukuj1Click(Sender: TObject);
begin
  PrintBitBtnClick(Sender);
end;

procedure TPrt4Dlg.Przegl1Click(Sender: TObject);
var
  Cur:Integer;
begin
{$IFDEF DEMO}
  MessageDlg('Nie dostêpne w wersji DEMO',mtInformation,[mbOk],0);
{$ELSE}
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
{$ENDIF}
end;

{$IFNDEF DEMO}
procedure TPrt4Dlg.ExportToTxt(FileName:String);
var
  FH:TextFile;
  p,q:PChar;
  i:LongInt;
  s,s1,s2:String;
  Scroll:TScrollStyle;
begin
  Scroll:=InfoMemo1.ScrollBars;
  SuwakiClick(Oba1);
  AssignFile(FH,FileName);
  FileMode:=fmOpenReadWrite + fmShareDenyWrite;
  try
    Rewrite(FH);
    try
  { Zamaw. }
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
      ExportEdit(ZwanyEdit,FH);
      ExportEdit(ZamawEdit,FH);
      ExportMemo(ObjectMemo,FH);
      ExportMemo(AnnexMemo,FH);
  {Termin}
{      ExportString(TerminRG1.Items[TerminRG1.ItemIndex]+EndDate.Text,FH);}
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
      if InfoCB7.Checked
        then begin
          ExportString(InfoCB7.Caption,FH);
          ExportMemo(InfoMemo8,FH);
          ExportMemo(InfoMemo9,FH);
          ExportMemo(InfoMemo10_1,FH);
          ExportMemo(InfoMemo10_2,FH);
        end;
  {Wadium}
      if WadiumRB1_2.Checked
        then begin
          ExportString(WadiumEdit2_1.Text+WadiumEdit2_2.Text+WadiumEdit2_3.Text,FH);
          ExportString(WadiumEdit2_4.Text+WadiumEdit2_5.Text+WadiumEdit2_6.Text,FH);
          ExportMemo(WadiumMemo3_1,FH);
          if WadiumCB3_2.Checked
            then ExportString(WadiumCB3_2.Caption,FH);
          if WadiumCB3_3.Checked
            then ExportString(WadiumCB3_3.Caption,FH);
          ExportString(WadiumEdit4_1.Text,FH);
          ExportMemo(WadiumMemo4_2,FH);
          ExportMemo(WadiumMemo5,FH);
          ExportMemo(WadiumMemo6,FH);
          ExportMemo(WadiumMemo7_1,FH);
          ExportMemo(WadiumMemo7_2,FH);
          ExportMemo(WadiumMemo8,FH);
        end;
  {Zabez}
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
  {Zwiaz}
      ExportString(ZwiazEdit1.Text+ZwiazEdit2.Text+ZwiazEdit3.Text,FH);
  {Sklad}
      ExportMemo(SkladMemo1,FH);
      p:=StrAlloc(Length(SkladEdit2_1.Text)+1);
      StrPCopy(p,SkladEdit2_1.Text);
      ExportPChar(p,FH);
      ExportMemo(SkladMemo2_3,FH);
      p:=StrAlloc(Length(SkladLabel2_4.Caption)+Length(SkladEdit2_6.Text)+
                  Length(SkladLabel2_5.Caption)+Length(SkladMaskEdit2_7.Text)+1);
      StrPCopy(p,SkladLabel2_4.Caption+SkladEdit2_6.Text+SkladLabel2_5.Caption+SkladMaskEdit2_7.Text);
      ExportPChar(p,FH);
      p:=StrAlloc(Length(SkladLabel2_8.Caption)+Length(SkladEdit2_11.Text)+
                  Length(SkladLabel2_9.Caption)+Length(SkladEdit2_12.Text)+
                  Length(SkladLabel2_10.Caption)+Length(SkladEdit2_13.Text)+1);
      StrPCopy(p,SkladLabel2_8.Caption+SkladEdit2_11.Text+SkladLabel2_9.Caption+
                 SkladEdit2_12.Text+SkladLabel2_10.Caption+SkladEdit2_13.Text);
      ExportPChar(p,FH);
      p:=StrAlloc(Length(SkladEdit2_14.Text)+Length(SkladDate2_15.Text)+
                  Length(SkladEdit2_16.Text)+Length(SkladTime2_17.Text)+1);
      StrPCopy(p,SkladEdit2_14.Text+SkladDate2_15.Text+SkladEdit2_16.Text+SkladTime2_17.Text);
      ExportPChar(p,FH);
      StrDispose(p);
      ExportMemo(SkladMemo3,FH);
      ExportMemo(SkladMemo4,FH);
      ExportMemo(SkladMemo5,FH);
      ExportMemo(SkladMemo6,FH);
  {Wycof}
      ExportMemo(WycofMemo1,FH);
      ExportMemo(WycofMemo2,FH);
      ExportMemo(WycofMemo3,FH);
      ExportMemo(WycofMemo4,FH);
      ExportMemo(WycofMemo5,FH);
  {Otwarcie}
      p:=StrAlloc(Length(OpeningEdit1_1.Text)+Length(OpeningDate1_2.Text)+Length(OpeningEdit1_2.Text)+
                  Length(OpeningTime1_4.Text)+Length(OpeningEdit1_3.Text)+Length(OpeningEdit1_4.Text)+
                  Length(OpeningEdit1_5.Text)+Length(OpeningEdit1_6.Text)+1);
      StrPCopy(p,OpeningEdit1_1.Text+OpeningDate1_2.Text+OpeningEdit1_2.Text+OpeningTime1_4.Text+
               OpeningEdit1_3.Text+OpeningEdit1_4.Text+OpeningEdit1_5.Text+OpeningEdit1_6.Text);
      ExportPChar(p,FH);
      StrDispose(p);
      ExportMemo(OpeningMemo2,FH);
      ExportMemo(OpeningMemo3,FH);
      ExportMemo(OpeningMemo4,FH);
      ExportMemo(OpeningMemo5,FH);
  {Zawartosc}
      ExportMemo(ContentMemo1,FH);
      ExportMemo(ContentMemo2,FH);
      ExportMemo(ContentMemo3,FH);
      ExportMemo(ContentMemo4,FH);
      ExportMemo(ContentMemo5,FH);
      ExportMemo(ContentMemo6,FH);
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
      p:=StrAlloc(Length(OcenaCB1.Caption)+1);
      StrPCopy(p,OcenaCB1.Caption);
      ExportPChar(p,FH);
      StrDispose(p);
      ExportMemo(OcenaMemo3_5,FH);
      p:=StrAlloc(Length(OcenaCB2.Caption)+1);
      StrPCopy(p,OcenaCB2.Caption);
      ExportPChar(p,FH);
      StrDispose(p);
      ExportMemo(OcenaMemo3_6,FH);
      p:=StrAlloc(Length(OcenaCB3.Caption)+1);
      StrPCopy(p,OcenaCB3.Caption);
      ExportPChar(p,FH);
      StrDispose(p);
      ExportMemo(OcenaMemo3_7,FH);
      p:=StrAlloc(Length(OcenaCB4.Caption)+1);
      StrPCopy(p,OcenaCB4.Caption);
      ExportPChar(p,FH);
      StrDispose(p);
      ExportMemo(OcenaMemo3_8,FH);
      ExportMemo(OcenaMemo5,FH);
      ExportMemo(OcenaMemo6,FH);
      ExportMemo(OcenaMemo7,FH);
      ExportMemo(OcenaMemo8,FH);
      ExportMemo(OcenaMemo9,FH);
  {Wybor}
      ExportMemo(WyborMemo1,FH);
      ExportMemo(WyborMemo2,FH);
  {Uniewaz}
      ExportMemo(UniewazMemo1,FH);
  {Protesty}
      ExportMemo(ProtMemo1,FH);
      ExportMemo(ProtMemo2,FH);
      ExportMemo(ProtMemo3,FH);
      ExportMemo(ProtMemo4,FH);
      ExportMemo(ProtMemo5,FH);
      ExportMemo(ProtMemo6,FH);
      ExportMemo(ProtMemo7,FH);
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
{$ENDIF}

procedure TPrt4Dlg.ExportClick(Sender: TObject);
begin
{$IFDEF DEMO}
  MessageDlg('Nie dostêpne w wersji DEMO',mtInformation,[mbOk],0);
{$ELSE}
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
{$ENDIF}
end;

procedure TPrt4Dlg.IdEditChange(Sender: TObject);
begin
  Modified:=TRUE;
end;

procedure TPrt4Dlg.SuwakiClick(Sender: TObject);
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

procedure TPrt4Dlg.TerminActivate(AGroupBox:Byte);
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

procedure TPrt4Dlg.TerminRb1Click(Sender: TObject);
begin
  TerminActivate(1);
end;

procedure TPrt4Dlg.TerminRB2Click(Sender: TObject);
begin
  TerminActivate(2);
end;

procedure TPrt4Dlg.TabSetClick(Sender: TObject);
begin
  Notebook.PageIndex:=TabSet.TabIndex;
  PrevBitBtn.Enabled:= Notebook.PageIndex>0;
  NextBitBtn.Enabled:= Notebook.PageIndex<Prt4MaxPages-1;
end;

procedure TPrt4Dlg.ClearTabTag;
begin
  with TabSet do
    if SelPages[TabIndex]=TRUE
      then begin
        if Tabs[TabIndex][1]='#'
          then Tabs[TabIndex]:=Copy(Tabs[TabIndex],3,Length(Tabs[TabIndex])-2);
        SelPages[TabIndex]:=FALSE;
      end
end;

procedure TPrt4Dlg.OknaClick(Sender: TObject);
begin
  if not (Sender is TMenuItem)
    then Exit;
  TabSet.TabIndex:=TabSet.Tabs.IndexOf(TMenuItem(Sender).Caption);
end;

procedure TPrt4Dlg.WadiumRB1_2Click(Sender: TObject);
begin
  WadiumActive(TRUE);
end;

procedure TPrt4Dlg.WadiumRB1_3Click(Sender: TObject);
const
  Msg1='Odst¹pienie od obowi¹zku wnoszenia wadium';
  Msg2='przez przystepuj¹cych do postêpowania mo¿e';
  Msg3='byæ udzielona na wniosek zamawiaj¹cego';
  Msg4='przez Prezesa Urzêdu Zamówieñ Publicznych';
begin
  if AmountLevel in [aLevel4 .. aLevel7]
    then MessageDlg(Msg1+^M+Msg2+^M+Msg3+^M+Msg4,mtWarning,[mbOk],0);
  WadiumActive(FALSE);
end;

procedure TPrt4Dlg.WadiumActive(State:Boolean);
var
  Clr:TColor;
begin
  if State
    then Clr:=clWhite
    else Clr:=clGray;
  WadiumEdit2_1.Color:=Clr;
  WadiumEdit2_2.Color:=Clr;
  WadiumEdit2_3.Color:=Clr;
  WadiumEdit2_4.Color:=Clr;
  WadiumEdit2_5.Color:=Clr;
  WadiumEdit2_6.Color:=Clr;
  WadiumMemo3_1.Color:=Clr;
  WadiumEdit4_1.Color:=Clr;
  WadiumMemo4_2.Color:=Clr;
  WadiumMemo5.Color:=Clr;
  WadiumMemo6.Color:=Clr;
  WadiumMemo7_1.Color:=Clr;
  WadiumMemo7_2.Color:=Clr;
  WadiumMemo8.Color:=Clr;
  WadiumEdit2_1.Enabled:=State;
  WadiumEdit2_2.Enabled:=State;
  WadiumEdit2_3.Enabled:=State;
  WadiumEdit2_4.Enabled:=State;
  WadiumEdit2_5.Enabled:=State;
  WadiumEdit2_6.Enabled:=State;
  WadiumMemo3_1.Enabled:=State;
  WadiumCB3_2.Enabled:=State;
  WadiumCB3_3.Enabled:=State;
  WadiumEdit4_1.Enabled:=State;
  WadiumMemo4_2.Enabled:=State;
  WadiumMemo5.Enabled:=State;
  WadiumMemo6.Enabled:=State;
  WadiumMemo7_1.Enabled:=State;
  WadiumMemo7_2.Enabled:=State;
  WadiumMemo8.Enabled:=State;
end;

procedure TPrt4Dlg.WadiumEdit2_2Exit(Sender: TObject);
const
  Msg1='Wadium okreœ³a siê w granicach 1-5% szacunkowej wartoœci zamówienia';
var
  Msg2,Msg3:String;
  Min,Max:Real;
begin
  if AmountLevel in [aLevel4 .. aLevel7]
    then begin
      Min:=AmountPLN / 100;
      Max:=Min*5;
      if (WadiumEdit2_2.Value<Min) or (WadiumEdit2_2.Value>Max)
        then begin
          Msg2:='Wartoœæ zamówienia: '+FloatToStrF(AmountPLN,ffNumber,12,2)+' PLN';
          Msg3:=FloatToStrF(Min,ffNumber,12,2)+' < WADIUM < '+FloatToStrF(Max,ffNumber,12,2);
          MessageDlg(Msg1+^M+Msg2+^M+^M+Msg3,mtWarning,[mbOk],0);
          if (WadiumEdit2_2.Value<Min)
            then WadiumEdit2_2.Value:=Min
            else WadiumEdit2_2.Value:=Max;
        end;
    end;
end;

procedure TPrt4Dlg.InfoCB7Click(Sender: TObject);
var
  x:Boolean;
  cl:TColor;
begin
  x:=InfoCB7.Checked;
  if x
    then cl:=clWhite
    else cl:=clGray;
  InfoMemo8.Enabled:=x;
  InfoMemo9.Enabled:=x;
  InfoMemo10_1.Enabled:=x;
  InfoMemo10_2.Enabled:=x;
  InfoMemo8.Color:=cl;
  InfoMemo9.Color:=cl;
  InfoMemo10_1.Color:=cl;
  InfoMemo10_2.Color:=cl;
  FieldChange(Sender);
end;

procedure TPrt4Dlg.ZabezActive(State:Boolean);
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

procedure TPrt4Dlg.ZabezRB1_2Click(Sender: TObject);
begin
  ZabezActive(TRUE);
end;

procedure TPrt4Dlg.ZabezRb1_3Click(Sender: TObject);
begin
  ZabezActive(FALSE);
end;

procedure TPrt4Dlg.Save1Click(Sender: TObject);
begin
  SaveBtnClick(Sender);
end;

procedure TPrt4Dlg.SaveAs1Click(Sender: TObject);
var
  FN:String;
begin
  FN:=FileName;
  FileName:='';
  SaveBtnClick(Sender);
  FileName:=FN;
end;

procedure TPrt4Dlg.Nagwki1Click(Sender: TObject);
begin
  Nagwki1.Checked:=not Nagwki1.Checked;
end;

procedure TPrt4Dlg.Opis1Click(Sender: TObject);
begin
  Opis1.Checked:=not Opis1.Checked;
end;

procedure TPrt4Dlg.Ident1Click(Sender: TObject);
begin
  Ident1.Checked:=not Ident1.Checked;
end;

procedure TPrt4Dlg.Wartzam1Click(Sender: TObject);
begin
  WartZam1.Checked:=not WartZam1.Checked;
end;

end.


