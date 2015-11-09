unit Zp1;

interface

uses WinTypes, WinProcs, Classes, Graphics, Forms, Controls, Buttons,
  StdCtrls, ExtCtrls, Mask, TabNotBk, Grids, Spin, SysUtils,
  Messages, Dialogs, Printers,
  Utils,
  SiwzIni,
  PrtRecIo,
  UserUnit,
  ZpBoxes,
  Zp1Prnt,
  SkOk,
  RPrev, IntDate, NumInp, Esgrid, Timeedit, Sk;

const
  Grid7bNameCol=0;
  Grid7bDateCol=1;

type
  TGrid7bInput=Class(TForm)
    L1:TLabel;
    L2:TLabel;
    OKBtn: TBitBtn;
    CancelBtn: TBitBtn;
    Edit:TEdit;
    DEdit:TIntDate;
  end;

  TZp1Dlg = class(TForm)
    TabNotebook1: TTabbedNotebook;
    ScrollBox1: TScrollBox;
    Panel1: TPanel;
    Memo1_27: TMemo;
    GroupBox1_21: TGroupBox;
    RB1_22: TRadioButton;
    RB1_23: TRadioButton;
    MaskEdit1_25: TMaskEdit;
    MaskEdit1_24: TMaskEdit;
    MaskEdit1_20: TMaskEdit;
    Edit1_16: TEdit;
    Edit1_17: TEdit;
    Edit1_18: TEdit;
    Edit1_11: TEdit;
    MaskEdit1_12: TMaskEdit;
    Edit1_6: TEdit;
    Memo1_2: TMemo;
{    NameLabel: TLabel;}
    Bevel1: TBevel;
    Edit1_8: TEdit;
    Label1_5: TLabel;
    Panel2: TPanel;
    Bevel2: TBevel;
    Label2: TLabel;
    Panel2a: TPanel;
    Bevel3: TBevel;
{    Label2a: TLabel;}
    Label2_1: TLabel;
    Memo2_1: TMemo;
    Label2_2: TLabel;
    Label2_3: TLabel;
    Label2_4: TLabel;
    Label2_5: TLabel;
    Label2_6: TLabel;
    Edit2_2: TEdit;
    Label2_7: TLabel;
    Panel3: TPanel;
    Bevel4: TBevel;
{    Label3: TLabel;}
    Panel4: TPanel;
    Bevel5: TBevel;
{    Label4: TLabel;}
    Panel5: TPanel;
    Bevel6: TBevel;
{    Label5: TLabel;}
    Panel6: TPanel;
    Bevel7: TBevel;
{    Label6: TLabel;}
    Panel6a: TPanel;
    Bevel8: TBevel;
    Label6a: TLabel;
    Label2a_1: TLabel;
    Label2a_2: TLabel;
    Memo2a_2: TMemo;
    Label3_1: TLabel;
    Label3_2: TLabel;
    Label3_3: TLabel;
    Memo3_2: TMemo;
    Label4_1: TLabel;
    Label4_2: TLabel;
    Label4_3: TLabel;
    Memo4_2: TMemo;
    Label5_1: TLabel;
    Label5_2: TLabel;
    Memo5_1: TMemo;
    Label6_1: TLabel;
    Panel6b: TPanel;
    Bevel9: TBevel;
    Label6b: TLabel;
    Panel6c: TPanel;
    Bevel10: TBevel;
    Label6c: TLabel;
    Panel6d: TPanel;
    Bevel11: TBevel;
    Label6d: TLabel;
    Label6a_1: TLabel;
    Label6a_2: TLabel;
    Label6a_3: TLabel;
    Edit6a_2: TEdit;
    Label6a_4: TLabel;
    Edit6a_3: TEdit;
    Label6b_1: TLabel;
    Label6b_2: TLabel;
    Label6c_1: TLabel;
    Label6c_2: TLabel;
    Label6c_3: TLabel;
    Label6d_1: TLabel;
    Label6d_2: TLabel;
    ScrollBox2: TScrollBox;
    Panel7: TPanel;
    Bevel12: TBevel;
{    Label7: TLabel;}
    Label7_1: TLabel;
    Label7_2: TLabel;
    Panel7a: TPanel;
    Bevel13: TBevel;
{    Label7a: TLabel;}
    Label7a_1: TLabel;
    Label7a_2: TLabel;
    Panel7b: TPanel;
    Bevel14: TBevel;
{    Label7b: TLabel; }
    Label7b_1: TLabel;
    Label7b_3: TLabel;
    Label7_3: TLabel;
    ComboBox7_4: TComboBox;
    Label7_5: TLabel;
    Label7_7: TLabel;
    Edit7_8: TEdit;
    Label7_9: TLabel;
    Edit7_10: TEdit;
    Label7_11: TLabel;
    ComboBox7_12: TComboBox;
    Label7_13: TLabel;
    Panel8: TPanel;
    Bevel15: TBevel;
{    Label8: TLabel;}
    Label8_1: TLabel;
    Label8_3: TLabel;
    Panel9: TPanel;
    Bevel16: TBevel;
{    Label9: TLabel; }
    Label9_1: TLabel;
    Label9_3: TLabel;
    Panel10: TPanel;
    Bevel17: TBevel;
{    Label10: TLabel;}
    Label10_1: TLabel;
    Label10_3: TLabel;
    Memo10_4: TMemo;
    Panel10a: TPanel;
    Bevel18: TBevel;
{    Label10a: TLabel;}
    Label10a_1: TLabel;
    Label10a_2: TLabel;
    Edit7b_4: TEdit;
    Label7b_5: TLabel;
    Label7b_7: TLabel;
    ComboBox8_2: TComboBox;
    Label8_4: TLabel;
    Label8_5: TLabel;
    Label8_6: TLabel;
    Memo8_7: TMemo;
    Label9_5: TLabel;
    Label9_7: TLabel;
    Label9_9: TLabel;
    Label9_11: TLabel;
    Label10_5: TLabel;
    Panel11: TPanel;
    Bevel19: TBevel;
    Label11: TLabel;
    Label11_1: TLabel;
    Label11_3: TLabel;
    Label11_6: TLabel;
    Memo11_5: TMemo;
    Label10a_3: TLabel;
    Label10a_4: TLabel;
    Label10a_5: TLabel;
    Label11_4: TLabel;
    Edit11_8: TEdit;
    Label11_7: TLabel;
    MaskEdit11_9: TMaskEdit;
    Label11_10: TLabel;
    Label11_11: TLabel;
    Label11_12: TLabel;
    Edit11_13: TEdit;
    Edit11_14: TEdit;
    Edit11_15: TEdit;
    ScrollBox3: TScrollBox;
    Panel12: TPanel;
    Bevel20: TBevel;
    Label12: TLabel;
    Label12_1: TLabel;
    Label12_3: TLabel;
    ComboBox12_2: TComboBox;
    Panel13: TPanel;
    Bevel21: TBevel;
    Label13: TLabel;
    Label13_1: TLabel;
    Label13_5: TLabel;
    Panel14: TPanel;
    Bevel22: TBevel;
    Label14: TLabel;
    Label14_1: TLabel;
    Label14_5: TLabel;
    Label13_2: TLabel;
    YesRb13_3: TRadioButton;
    NoRB13_4: TRadioButton;
    Label14_2: TLabel;
    YesRB14_3: TRadioButton;
    NoRB14_4: TRadioButton;
    Panel15: TPanel;
    Bevel28: TBevel;
    Label15: TLabel;
    Label15_1: TLabel;
    Label15_4: TLabel;
    YesRb15_2: TRadioButton;
    NoRb15_3: TRadioButton;
    Panel16: TPanel;
    Bevel29: TBevel;
    Label16: TLabel;
    Label16_1: TLabel;
    Label16_4: TLabel;
    YesRB16_2: TRadioButton;
    NoRb16_3: TRadioButton;
    Panel17: TPanel;
    Bevel23: TBevel;
    Label17: TLabel;
    Label17_1: TLabel;
    Label17_3: TLabel;
    Label17_2: TLabel;
    Panel18: TPanel;
    Bevel24: TBevel;
    Label18: TLabel;
    Label18_1: TLabel;
    Label18_8: TLabel;
    Label18_2: TLabel;
    Label18_4: TLabel;
    Label18_5: TLabel;
    Label18_7: TLabel;
    Label18_9: TLabel;
    Panel19: TPanel;
    Bevel26: TBevel;
    Label19: TLabel;
    Label19_1: TLabel;
    Label19_3: TLabel;
    Label19_2: TLabel;
    Panel20: TPanel;
    Bevel25: TBevel;
    Label20: TLabel;
    Label20_1: TLabel;
    Label20_2: TLabel;
    Label20_4: TLabel;
    Panel21: TPanel;
    Bevel27: TBevel;
    Label21: TLabel;
    Label21_1: TLabel;
    Label21_4: TLabel;
    YesRB21_2: TRadioButton;
    NoRB21_3: TRadioButton;
    Label21_5: TLabel;
    ScrollBox4: TScrollBox;
    Panel22: TPanel;
    Bevel30: TBevel;
    Label22: TLabel;
    Label22_1: TLabel;
    Label22_4: TLabel;
    YesRB22_2: TRadioButton;
    NoRB22_3: TRadioButton;
    Panel22a: TPanel;
    Bevel31: TBevel;
    Label22a: TLabel;
    Label22a_1: TLabel;
    Label22a_3: TLabel;
    Memo22a_8: TMemo;
    ComboBox22a_2: TComboBox;
    Label22a_5: TLabel;
    Label22a_6: TLabel;
    Label22a_7: TLabel;
    Panel22b: TPanel;
    Bevel32: TBevel;
    Label22b: TLabel;
    Label22b_1: TLabel;
    Label22b_3: TLabel;
    Label22b_4: TLabel;
    Memo22b_5: TMemo;
    Panel23: TPanel;
    Bevel33: TBevel;
    Label23: TLabel;
    Label23_1: TLabel;
    YesRB23_3: TRadioButton;
    NoRB23_4: TRadioButton;
    Panel24: TPanel;
    Bevel34: TBevel;
    Label24: TLabel;
    Label24_1: TLabel;
    Label24_5: TLabel;
    YesRB24_3: TRadioButton;
    NoRB24_4: TRadioButton;
    Label23_2: TLabel;
    Label24_2: TLabel;
    Panel25: TPanel;
    Bevel35: TBevel;
    Label25: TLabel;
    Label25_1: TLabel;
    Label25_2: TLabel;
    Label25_4: TLabel;
    Memo25_17: TMemo;
    Edit25_3: TEdit;
    Edit25_5: TEdit;
    Label25_6: TLabel;
    Edit25_7: TEdit;
    MaskEdit25_9: TMaskEdit;
    Label25_8: TLabel;
    Label25_10: TLabel;
    Edit25_11: TEdit;
    Label25_12: TLabel;
    Edit25_13: TEdit;
    Label25_14: TLabel;
    Edit25_15: TEdit;
    Label25_16: TLabel;
    Panel26: TPanel;
    Bevel36: TBevel;
    Label26: TLabel;
    Label26_1: TLabel;
    Memo26_2: TMemo;
    Panel27: TPanel;
    Bevel37: TBevel;
    Label27: TLabel;
    Label27_1: TLabel;
    Label27_3: TLabel;
    Label27_5: TLabel;
    Label27_7: TLabel;
    Panel28: TPanel;
    Bevel38: TBevel;
    Label28: TLabel;
    Label28_1: TLabel;
    Label28_2: TLabel;
    Label28_4: TLabel;
    ComboBox4_1: TComboBox;
    Panel29: TPanel;
    OKBtn: TBitBtn;
    CancelBtn: TBitBtn;
    PrintBtn: TBitBtn;
    PreviewBtn: TBitBtn;
    OpenBtn: TBitBtn;
    SaveBtn: TBitBtn;
    HelpBtn: TBitBtn;
    SiwzBtn: TBitBtn;
    Label1_3: TLabel;
    Label1_4: TLabel;
    Label1_8: TLabel;
    Label1_9: TLabel;
    Label1_13: TLabel;
    Label1_14: TLabel;
    Label1_15: TLabel;
    Label1_19: TLabel;
    Label1_26: TLabel;
    OpenDialog: TOpenDialog;
    SaveDialog: TSaveDialog;
    Edit1_7: TEdit;
    Label29: TLabel;
    NumEdit: TEdit;
    DateEdit3_1: TIntDate;
    DateEdit6a_1: TIntDate;
    DateEdit6c_1: TIntDate;
    DateEdit7_6: TIntDate;
    DateEdit7_14: TIntDate;
    DateEdit7b_6: TIntDate;
    DateEdit7b_8: TIntDate;
    DateEdit9_2: TIntDate;
    DateEdit9_6: TIntDate;
    DateEdit10_2: TIntDate;
    DateEdit11_2: TIntDate;
    DateEdit22b_2: TIntDate;
    DateEdit27_2: TIntDate;
    DateEdit28_3: TIntDate;
    NumEdit22a_4: TNumInp;
    NumEdit27_6: TNumInp;
    NumEdit2a_1: TNumInp;
    Grid7b_2: TEnhStringGrid;
    InsertBtn: TButton;
    AddBtn: TButton;
    DelBtn: TButton;
    TimeEdit9_4: TTimeEdit;
    TimeEdit9_8: TTimeEdit;
    Grid20_3: TEnhStringGrid;
    G20InsBtn: TButton;
    G20AddBtn: TButton;
    G20DelBtn: TButton;
    TimeEdit27_4: TTimeEdit;
    Edit9_10: TEdit;
    YesRb6_2: TRadioButton;
    NoRB6_3: TRadioButton;
    ResetBtn6: TButton;
    ResetBtn13: TButton;
    ResetRB14: TButton;
    ResetRB15: TButton;
    ResetRB16: TButton;
    ResetRB21: TButton;
    ResetBtn22: TButton;
    ResetBtn23: TButton;
    ResetBtn24: TButton;
    NumEdit18_3: TNumInp;
    NumEdit18_6: TNumInp;
    CB2_3: TComboBox;
    Sk: TSmartKey;
    procedure TimeEditExit(Sender: TObject);
    procedure NumEditKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure NumEdit18_3Exit(Sender: TObject);
    procedure Grid7b_2DblClick(Sender: TObject);
    procedure PreviewBtnClick(Sender: TObject);
    procedure RB1_22Click(Sender: TObject);
    procedure RB1_23Click(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormDestroy(Sender: TObject);
    procedure OKBtnClick(Sender: TObject);
    procedure PrintBtnClick(Sender: TObject);
    procedure OpenBtnClick(Sender: TObject);
    procedure SaveBtnClick(Sender: TObject);
    procedure SiwzBtnClick(Sender: TObject);
    procedure HelpBtnClick(Sender: TObject);
    procedure NoRB6Click(Sender: TObject);
    procedure YesRB6Click(Sender: TObject);
    procedure NoRB22_3Click(Sender: TObject);
    procedure YesRB22_2Click(Sender: TObject);
    procedure AddBtnClick(Sender: TObject);
    procedure InsertBtnClick(Sender: TObject);
    procedure DelBtnClick(Sender: TObject);
    procedure G20AddBtnClick(Sender: TObject);
    procedure G20InsBtnClick(Sender: TObject);
    procedure G20DelBtnClick(Sender: TObject);
    procedure Edit9_10KeyPress(Sender: TObject; var Key: Char);
    procedure ResetBtn6Click(Sender: TObject);
    procedure ResetBtn13Click(Sender: TObject);
    procedure ResetRB21Click(Sender: TObject);
    procedure ResetRB14Click(Sender: TObject);
    procedure ResetRB15Click(Sender: TObject);
    procedure ResetRB16Click(Sender: TObject);
    procedure ResetBtn22Click(Sender: TObject);
    procedure ResetBtn23Click(Sender: TObject);
    procedure ResetBtn24Click(Sender: TObject);
  private
    { Private declarations }
    Grid7bDERow:LongInt;
    Grid7bDECol:LongInt;
    PPos:Integer;
    PrintSpace:Integer;
    Ry:TRyPrinter;
    FileName:String;
    FilePwd:String;
    FileIsOpen:Boolean;
    FHandle:File;
    procedure LoadFile;
    procedure SaveFile;
    procedure MakePrint;
    procedure SetGrid7b_2Field;
    procedure SetStringGrid20_3Titles;
    function GetBox6Len(Ry:TRyPrinter):Integer;
    function GetBox7bLen(Ry:TRyPrinter):Integer;
    procedure MakeBox1(Ry:TRyPrinter; var PPos:Integer);
    procedure MakeBox2(Ry:TRyPrinter; var PPos:Integer);
    procedure MakeBox2a(Ry:TRyPrinter; var PPos:Integer);
    procedure MakeBox3(Ry:TRyPrinter; var PPos:Integer);
    procedure MakeBox4(Ry:TRyPrinter; var PPos:Integer);
    procedure MakeBox5(Ry:TRyPrinter; var PPos:Integer);
    procedure MakeBox6(Ry:TRyPrinter; var PPos:Integer);
    procedure MakeBox6a(Ry:TRyPrinter; var PPos:Integer);
    procedure MakeBox6b(Ry:TRyPrinter; var PPos:Integer);
    procedure MakeBox6c(Ry:TRyPrinter; var PPos:Integer);
    procedure MakeBox6d(Ry:TRyPrinter; var PPos:Integer);
    procedure MakeBox7(Ry:TRyPrinter; var PPos:Integer);
    procedure MakeBox7a(Ry:TRyPrinter; var PPos:Integer);
    procedure MakeBox7b(Ry:TRyPrinter; var PPos:Integer);
    procedure MakeBox8(Ry:TRyPrinter; var PPos:Integer);
    procedure MakeBox9(Ry:TRyPrinter; var PPos:Integer);
    procedure MakeBox10(Ry:TRyPrinter; var PPos:Integer);
    procedure MakeBox10a(Ry:TRyPrinter; var PPos:Integer);
    procedure AddBox11;
    procedure AddBox12;
    procedure AddBox13;
    procedure AddBox14;
    procedure AddBox15;
    procedure AddBox16;
    procedure AddBox17;
    procedure AddBox18;
    procedure AddBox19;
    procedure AddBox20;
    procedure AddBox21;
    procedure AddBox22;
    procedure AddBox22a;
    procedure AddBox22b;
    procedure AddBox23;
    procedure AddBox24;
    procedure AddBox25;
    procedure AddBox26;
    procedure AddBox27;
    procedure AddBox28;
  public
    { Public declarations }
  end;

var
  Zp1Dlg: TZp1Dlg;

procedure DrukZp1; export;

implementation

{$R *.DFM}

uses
  DrMsg,
  DateUtil;

procedure DrukZp1;
var
  Cur:Integer;
begin
  Cur:=Screen.Cursor;
  Screen.Cursor:=crHourGlass;
  ZP1Dlg:=TZp1Dlg.Create(Nil);
  Screen.Cursor:=Cur;
  ZP1Dlg.ShowModal;
  ZP1Dlg.Free;
end;

procedure TZp1Dlg.TimeEditExit(Sender: TObject);
var
  s:String[5];
  Err:Boolean;
begin
  if ActiveControl=CancelBtn
    then Exit;
  s:=TMaskEdit(Sender).Text;
  if s='  :  '
    then Exit;
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

procedure TZp1Dlg.NumEditKeyPress(Sender: TObject; var Key: Char);
begin
  if not (Key in ['0'..'9',#8])
    then begin
      Key:=#0;
      MessageBeep(0);
    end;
end;

procedure TZp1Dlg.FormCreate(Sender: TObject);
begin
  SetStringGrid20_3Titles;
  Grid7b_2.Cells[Grid7bNameCol,0]:='Tytu³';
  Grid7b_2.Cells[Grid7bDateCol,0]:='Data';
  RB1_22.Checked:=TRUE;
  RB1_22Click(Sender);
  Application.HelpFile:=DruZpHelpFile;
  FilePwd:=LoadFilePwd(AddBackSlash(ProgramDir)+SecurityFileName);
end;

procedure TZp1Dlg.SetStringGrid20_3Titles;
var
  i:Word;
begin
  with Grid20_3 do
    begin
      ColWidths[0]:=92;
      Cells[0,0]:='nr oferty';
      Cells[0,1]:='liczba punktów';
      for i:=1 to ColCount-1 do
        if Cells[i,0]=''
          then Cells[i,0]:='  '+IntToStr(i);
    end;
end;

procedure TZp1Dlg.NumEdit18_3Exit(Sender: TObject);
begin
  if NumEdit18_3.Value>0
    then begin
      Grid20_3.ColCount:=NumEdit18_3.AsInteger+1;
      SetStringGrid20_3Titles;
    end;
end;

procedure TZp1Dlg.SetGrid7b_2Field;
var
  GF:TGrid7bInput;
  Row:LongInt;
begin
  Row:=Grid7b_2.Row;
  GF:=TGrid7bInput.CreateNew(Application);
  with GF do
    begin
      Position:=poScreenCenter;
      Height:=170;
      Width:=380;
      Caption:='Prasa';
      BorderStyle:=bsDialog;
      Font.Assign(Zp1Dlg.Font);
      BorderIcons:=[];
      L1:=TLabel.Create(GF);
      with L1 do
        begin
          Parent:=GF;
          Font.Assign(Zp1Dlg.Font);
          Top:=8;
          Left:=8;
          Height:=13;
          Width:=39;
          Caption:='Tytu³';
        end;
      L2:=TLabel.Create(GF);
      with L2 do
        begin
          Parent:=GF;
          Font.Assign(Zp1Dlg.Font);
          Top:=56;
          Left:=8;
          Height:=13;
          Width:=39;
          Caption:='Data';
        end;
      OkBtn:=TBitBtn.Create(GF);
      with OkBtn do
        begin
          Parent:=GF;
          Font.Assign(Zp1Dlg.Font);
          Top:=108;
          Left:=8;
          Height:=27;
          Width:=69;
          Kind:=bkOk;
          TabOrder:=2;
        end;
      CancelBtn:=TBitBtn.Create(GF);
      with CancelBtn do
        begin
          Parent:=GF;
          Font.Assign(Zp1Dlg.Font);
          Top:=108;
          Left:=92;
          Height:=27;
          Width:=69;
          Kind:=bkCancel;
          TabOrder:=69;
        end;
      Edit:=TEdit.Create(GF);
      with Edit do
        begin
          Parent:=GF;
          Font.Assign(Zp1Dlg.Font);
          Top:=24;
          Left:=8;
          Height:=20;
          Width:=353;
          TabOrder:=0;
          Edit.Text:=Grid7b_2.Cells[Grid7bNameCol,Row]
        end;
      DEdit:=TIntDate.Create(GF);
      with DEdit do
        begin
          Parent:=GF;
          Font.Assign(Zp1Dlg.Font);
          Top:=72;
          Left:=8;
          Height:=20;
          Width:=121;
          TabOrder:=1;
          if Grid7b_2.Cells[Grid7bDateCol,Row]<>''
            then DEdit.EditDate:=(StrToDate(Grid7b_2.Cells[Grid7bDateCol,Row]))
            else DEdit.EditDate:=Now;
        end;
      if ShowModal=mrOk
        then begin
          Grid7b_2.Cells[Grid7bNameCol,Row]:=Edit.Text;
          Grid7b_2.Cells[Grid7bDateCol,Row]:=DEdit.Text;
        end;
    end;
  GF.Free;
end;

procedure TZp1Dlg.Grid7b_2DblClick(Sender: TObject);
begin
  SetGrid7b_2Field;
end;

procedure TZp1Dlg.RB1_22Click(Sender: TObject);
begin
  MaskEdit1_24.Enabled:=TRUE;
  MaskEdit1_24.Color:=clWhite;
  MaskEdit1_25.Enabled:=FALSE;
  MaskEdit1_25.Color:=clGray;
end;

procedure TZp1Dlg.RB1_23Click(Sender: TObject);
begin
  MaskEdit1_24.Enabled:=FALSE;
  MaskEdit1_24.Color:=clGray;
  MaskEdit1_25.Enabled:=TRUE;
  MaskEdit1_25.Color:=clWhite;
end;

procedure TZp1Dlg.MakeBox1(Ry:TRyPrinter; var PPos:Integer);
var
  p1,p2,p3,p4,p5,p6,p7,p8,p9,p10:PChar;
  s:String;
begin
  with Ry do
    begin
      s:='Pe³na nazwa zamawiaj¹cego:';
      p1:=StrAlloc(Length(s)+1);
      StrPCopy(p1,s);
      p2:=StrAlloc(Memo1_2.GetTextLen + 1);
      Memo1_2.GetTextBuf(p2, Memo1_2.GetTextLen+1);
      s:='w '+Edit1_11.Text+'  kod '+MaskEdit1_12.Text;
      p3:=StrAlloc(Length(s)+1);
      StrPCopy(p3,s);
      s:=Edit1_6.Text+'  numer domu '+Edit1_7.Text+'  numer pokoju '+Edit1_8.Text;
      p4:=StrAlloc(Length(s)+1);
      StrPCopy(p4,s);
      s:='REGON: '+MaskEdit1_20.Text+'  NIP: ';
      if RB1_22.Checked
        then s:=s+MaskEdit1_24.Text
      else if RB1_23.Checked
        then s:=s+MaskEdit1_25.Text;
      p5:=StrAlloc(Length(s)+1);
      StrPCopy(p5,s);
      s:='Wydzia³ prowadz¹cy sprawê:';
      p6:=StrAlloc(Length(s)+1);
      StrPCopy(p6,s);
      p7:=StrAlloc(Memo1_27.GetTextLen + 1);
      Memo1_27.GetTextBuf(p7, Memo1_27.GetTextLen+1);
      s:='Telefon: '+Edit1_16.Text;
      p8:=StrAlloc(Length(s)+1);
      StrPCopy(p8,s);
      s:='Telefaks: '+Edit1_17.Text;
      p9:=StrAlloc(Length(s)+1);
      StrPCopy(p9,s);
      s:='Teleks: '+Edit1_18.Text;
      p10:=StrAlloc(Length(s)+1);
      StrPCopy(p10,s);
      AddZp1Box(Ry,'1',[p1,p2,p3,p4,p5,p6,p7,p8,p9,p10],[1,1,1,1,2,1,2,1,1,1],ZP1Tit,'1',NumEdit.Text,PrintSpace,PPos);
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
end;

procedure TZp1Dlg.MakeBox2(Ry:TRyPrinter; var PPos:Integer);
var
  q,p1,p2,p3,p4,p5:PChar;
  s:String;
begin
  with Ry do
    begin
      p1:=StrAlloc(Length(Label2_1.Caption)+1);
      StrPCopy(p1, Label2_1.Caption);
      s:=Label2_2.Caption+Label2_3.Caption+Label2_4.Caption+Label2_5.Caption;
      p2:=StrAlloc(Length(s)+Length(Label2_4.Caption)+Length(Label2_5.Caption)+1);
      StrPCopy(p2,s);
      q:=StrAlloc(Length(Label2_4.Caption)+Length(Label2_5.Caption)+1);
      StrPCopy(q,Label2_4.Caption+Label2_5.Caption);
      StrCat(p2,q);
      p3:=StrAlloc(Memo2_1.GetTextLen + 1);
      Memo2_1.GetTextBuf(p3, Memo2_1.GetTextLen+1);
      s:=Label2_6.Caption+Edit2_2.Text;
      p4:=StrAlloc(Length(s)+1);
      StrPCopy(p4,s);
      s:=Label2_7.Caption+CB2_3.Text;
      p5:=StrAlloc(Length(s)+1);
      StrPCopy(p5,s);
      AddZp1Box(Ry,'2',[p1,p2,p3,p4,p5],[1,1,1,1,1],ZP1Tit,'1',NumEdit.Text,PrintSpace,PPos);
      StrDispose(q);
      StrDispose(p1);
      StrDispose(p2);
      StrDispose(p3);
      StrDispose(p4);
      StrDispose(p5);
    end;
end;

procedure TZp1Dlg.MakeBox2a(Ry:TRyPrinter; var PPos:Integer);
var
  q,p1,p2:PChar;
begin
  with Ry do
    begin
      p1:=StrAlloc(Length(Label2a_1.Caption)+Length(NumEdit2a_1.Text)+ 1);
      StrPCopy(p1,Label2a_1.Caption+NumEdit2a_1.Text);
      p2:=StrAlloc(Length(Label2a_2.Caption)+Memo2a_2.GetTextLen + 1);
      q:=StrAlloc(Memo2a_2.GetTextLen + 1);
      Memo2a_2.GetTextBuf(q, Memo2a_2.GetTextLen+1);
      StrPCopy(p2,Label2a_2.Caption);
      StrCat(p2,q);
      AddZp1Box(Ry,'2a',[p1,p2],[1,1],ZP1Tit,'1',NumEdit.Text,PrintSpace,PPos);
      StrDispose(q);
      StrDispose(p1);
      StrDispose(p2);
    end;
end;

procedure TZp1Dlg.MakeBox3(Ry:TRyPrinter; var PPos:Integer);
var
  q,p1,p2:PChar;
  s:String[20];
begin
  with Ry do
    begin
      s:=DateEdit3_1.Text;
      if s=''
        then s:=EmptyDateStr;
      p1:=StrAlloc(Length(Label3_1.Caption)+Length(s) + 1);
      StrPCopy(p1,Label3_1.Caption+s);
      p2:=StrAlloc(Length(Label3_2.Caption)+Memo3_2.GetTextLen + 1);
      q:=StrAlloc(Memo3_2.GetTextLen + 1);
      Memo3_2.GetTextBuf(q, Memo3_2.GetTextLen+1);
      StrPCopy(p2,Label3_2.Caption);
      StrCat(p2,q);
      AddZp1Box(Ry,'3',[p1,p2],[1,1],ZP1Tit,'1',NumEdit.Text,PrintSpace,PPos);
      StrDispose(q);
      StrDispose(p1);
      StrDispose(p2);
    end;
end;

procedure TZp1Dlg.MakeBox4(Ry:TRyPrinter; var PPos:Integer);
var
  p1,p2:PChar;
begin
  with Ry do
    begin
      p1:=StrAlloc(Length(Label4_2.Caption)+Length(ComboBox4_1.Text)+Length(Label4_3.Caption)+1);
      StrPCopy(p1,Label4_2.Caption+ComboBox4_1.Text+Label4_3.Caption);
      p2:=StrAlloc(Memo4_2.GetTextLen + 1);
      Memo4_2.GetTextBuf(p2, Memo4_2.GetTextLen+1);
      AddZp1Box(Ry,'4',[p1,p2],[1,1],ZP1Tit,'1',NumEdit.Text,PrintSpace,PPos);
      StrDispose(p1);
      StrDispose(p2);
    end;
end;

procedure TZp1Dlg.MakeBox5(Ry:TRyPrinter; var PPos:Integer);
var
  p1,p2:PChar;
begin
  with Ry do
    begin
      p1:=StrAlloc(Length(Label5_1.Caption)+Length(Label5_2.Caption)+1);
      StrPCopy(p1,Label5_1.Caption+Label5_2.Caption);
      p2:=StrAlloc(Memo5_1.GetTextLen + 1);
      Memo5_1.GetTextBuf(p2, Memo5_1.GetTextLen+1);
      AddZp1Box(Ry,'5',[p1,p2],[1,1],ZP1Tit,'1',NumEdit.Text,PrintSpace,PPos);
      StrDispose(p1);
      StrDispose(p2);
    end;
end;

function TZp1Dlg.GetBox6Len(Ry:TRyPrinter):Integer;
var
  Rct:TRect;
  Tx:Integer;
  LH:Integer; {Line height}
  LP:Integer; {Line position}
begin
  with Ry do
    begin
      Rct.Right:=XROff;
      Tx:=XLOff+Xmm(15);
      Font.Size:=10;
      LH:=TextHeight+Ymm(1);
      LP:=Ymm(2);
      LP:=LP+LH;
      LP:=LP+LH;
      LP:=LP+Ymm(3);
      Result:=LP+Ymm(1);
    end;
end;

procedure TZp1Dlg.MakeBox6(Ry:TRyPrinter; var PPos:Integer);
var
  Rct,r:TRect;
  Tx:Integer;
  LH:Integer; {Line height}
  LP:Integer; {Line position}
  X:Integer;
begin
  with Ry do
    begin
      Rct.Left:=XLOff;
      Rct.Right:=XROff;
      Rct.Top:=PPos+Ymm(3);
      Tx:=Rct.Left+Xmm(15);
      Font.Size:=10;
      LH:=TextHeight+Ymm(1);
      LP:=Rct.Top+Ymm(2);
      TextOut(Tx,LP,Label6_1.Caption);
      LP:=LP+LH;
      TextOut(Tx+Xmm(10),LP,'TAK');
      TextOutRight(Rct.Right-Xmm(10),LP,'NIE');
      LP:=LP+LH;
      Rectangle(Rect(Tx+Xmm(15),LP,Tx+Xmm(20),LP+Ymm(3)));
      Rectangle(Rect(Rct.Right-Xmm(20),LP,Rct.Right-Xmm(15),LP+Ymm(3)));
      if YesRB6_2.Checked
        then begin
          Line(Point(Tx+Xmm(15),LP),Point(Tx+Xmm(20),LP+Ymm(3)));
          Line(Point(Tx+Xmm(15),LP+Ymm(3)),Point(Tx+Xmm(20),LP));
        end
      else if NoRB6_3.Checked
        then begin
          Line(Point(Rct.Right-Xmm(20),LP),Point(Rct.Right-Xmm(15),LP+Ymm(3)));
          Line(Point(Rct.Right-Xmm(20),LP+Ymm(3)),Point(Rct.Right-Xmm(15),LP));
        end;
      LP:=LP+Ymm(3);
      Rct.Bottom:=LP+Ymm(1);
      RoundRectangle(Rct);
      Line(Point(Tx-Xmm(3),Rct.Top),Point(Tx-Xmm(3),Rct.Bottom));
      TextOutCenter(((Tx-Xmm(3)-Rct.Left) div 2)+Rct.Left,Rct.Top+Ymm(4),'6');
      PPos:=Rct.Bottom;
    end;
end;

procedure TZp1Dlg.MakeBox6a(Ry:TRyPrinter; var PPos:Integer);
var
  p:PChar;
  s,s2,s3:String[20];
begin
  with Ry do
    begin
      s:=DateEdit6a_1.Text;
      if s=''
        then s:=EmptyDateStr;
      s2:=Edit6a_2.Text;
      if s2=''
        then s2:=EmptyStr2cm;
      s3:=Edit6a_3.Text;
      if s3=''
        then s3:=EmptyStr2cm;
      p:=StrAlloc(Length(Label6a_1.Caption)+Length(Label6a_2.Caption)+Length(s)+
                  Length(Label6a_3.Caption)+Length(s2)+Length(Label6a_4.Caption)+Length(s3)+3);
      StrPCopy(p,Label6a_1.Caption+Label6a_2.Caption+s+Label6a_3.Caption+
               ', '+s2+Label6a_4.Caption+s3);
      AddZp1Box(Ry,'6a',[p],[1],ZP1Tit,'1',NumEdit.Text,PrintSpace,PPos);
      StrDispose(p);
    end;
end;

procedure TZp1Dlg.MakeBox6b(Ry:TRyPrinter; var PPos:Integer);
var
  p:PChar;
begin
  with Ry do
    begin
      p:=StrAlloc(Length(Label6b_1.Caption)+Length(Label6b_2.Caption)+1);
      StrPCopy(p,Label6b_1.Caption+Label6b_2.Caption);
      AddZp1Box(Ry,'6b',[p],[1],ZP1Tit,'1',NumEdit.Text,PrintSpace,PPos);
      StrDispose(p);
    end;
end;

procedure TZp1Dlg.MakeBox6c(Ry:TRyPrinter; var PPos:Integer);
var
  p:PChar;
  s:String[20];
begin
  with Ry do
    begin
      s:=DateEdit6c_1.Text;
      if s=''
        then s:=EmptyDateStr;
      p:=StrAlloc(Length(Label6c_1.Caption)+Length(s)+Length(Label6c_2.Caption)+Length(Label6c_3.Caption)+2);
      StrPCopy(p,Label6c_1.Caption+s+' '+Label6c_2.Caption+Label6c_3.Caption);
      AddZp1Box(Ry,'6c',[p],[1],ZP1Tit,'1',NumEdit.Text,PrintSpace,PPos);
      StrDispose(p);
    end;
end;

procedure TZp1Dlg.MakeBox6d(Ry:TRyPrinter; var PPos:Integer);
var
  p:PChar;
begin
  with Ry do
    begin
      p:=StrAlloc(Length(Label6d_1.Caption)+Length(Label6d_2.Caption)+1);
      StrPCopy(p,Label6d_1.Caption+Label6d_2.Caption);
      AddZp1Box(Ry,'6d',[p],[1],ZP1Tit,'1',NumEdit.Text,PrintSpace,PPos);
      StrDispose(p);
    end;
end;

procedure TZp1Dlg.MakeBox7(Ry:TRyPrinter; var PPos:Integer);
var
  p1,p2,p3:PChar;
  s,s2,s3:String[20];
begin
  with Ry do
    begin
      s:=DateEdit7_6.Text;
      if s=''
        then s:=EmptyDateStr;
      s2:=Edit7_8.Text;
      if s2=''
        then s2:=EmptyStr2cm;
      s3:=Edit7_10.Text;
      if s3=''
        then s3:=EmptyStr2cm;
      p1:=Nil; p2:=Nil; p3:=Nil;
{      if ComboBox7_4.Text='nieograniczonym'
        then PrintFlag:=PrintA
      else if ComboBox7_4.Text='dwustopniowym'
        then PrintFlag:=PrintA
      else if ComboBox7_4.Text='' and ComboBox7_12.Text<>''
        then PrintFlag:=PrintB
}
      p1:=StrAlloc(Length(Label7_1.Caption)+1);
      StrPCopy(p1,Label7_1.Caption);
      if ComboBox7_4.Text<>''
        then begin
          p2:=StrAlloc(Length(Label7_2.Caption)+Length(Label7_3.Caption)+Length(ComboBox7_4.Text)+Length(Label7_5.Caption)+
                      Length(s)+Length(Label7_7.Caption)+Length(s2)+
                      Length(Label7_9.Caption)+Length(s3)+1);
          StrPCopy(p2,Label7_2.Caption+Label7_3.Caption+ComboBox7_4.Text+Label7_5.Caption+
                      s+Label7_7.Caption+s2+Label7_9.Caption+s3);
        end
      else if ComboBox7_12.Text<>''
        then begin
      s:=DateEdit7_14.Text;
      if s=''
        then s:=EmptyDateStr;
          p3:=StrAlloc(Length(Label7_11.Caption)+Length(ComboBox7_12.Text)+Length(Label7_13.Caption)+
                      Length(s)+1);
          StrPCopy(p3,Label7_11.Caption+ComboBox7_12.Text+Label7_13.Caption+s);
        end;
      AddZp1Box(Ry,'7',[p1,p2,p3],[1,1,1],ZP1Tit,'1',NumEdit.Text,PrintSpace,PPos);
      StrDispose(p1);
      StrDispose(p2);
      StrDispose(p3);
    end;
end;

procedure TZp1Dlg.MakeBox7a(Ry:TRyPrinter; var PPos:Integer);
var
  p:PChar;
begin
  if ComboBox7_4.Text='nieograniczonym'
    then Exit;
  with Ry do
    begin
      p:=StrAlloc(Length(Label7a_1.Caption)+Length(Label7a_2.Caption)+1);
      StrPCopy(p,Label7a_1.Caption+Label7a_2.Caption);
      AddZp1Box(Ry,'7a',[p],[1],ZP1Tit,'1',NumEdit.Text,PrintSpace,PPos);
      StrDispose(p);
    end;
end;


function TZp1Dlg.GetBox7bLen(Ry:TRyPrinter):Integer;
var
  p:PChar;
  Rct:TRect;
  Tx:Integer;
  LH:Integer;
  LP:Integer; {Line position}
  X,Y,Z,i:Integer;
begin
  with Ry do
    begin
      Rct.Right:=XROff;
      Tx:=XLOff+Xmm(15);
      Font.Size:=10;
      LH:=TextHeight+Ymm(1);
      LP:=Ymm(2);
      p:=StrAlloc(Length(Label7b_1.Caption)+1);
      StrPCopy(p,Label7b_1.Caption);
      X:=MemoOut(Rect(Tx,LP,Rct.Right-Xmm(3),100), p, False, TRUE);
      StrDispose(p);
      LP:=LP+X+Ymm(1);
      Y:=Rct.Right-Xmm(7)-TextWidth(Grid7b_2.Cells[1,0]);
      Z:=LP;
      LP:=LP+LH;
      i:=1;
      while (i<Grid7b_2.RowCount) do
        begin
          if (Grid7b_2.Cells[0,i]<>'')
            then begin
              p:=StrAlloc(Length(Grid7b_2.Cells[0,i])+1);
              StrPCopy(p,Grid7b_2.Cells[0,i]);
              X:=MemoOut(Rect(Tx,LP,Y-Xmm(3),100), p, False, TRUE);
              StrDispose(p);
              LP:=LP+X+Ymm(1);
            end;
          Inc(i);
        end;
      p:=StrAlloc(Length(Label7b_3.Caption)+Length(Edit7b_4.Text)+
                  Length(Label7b_5.Caption)+Length(DateEdit7b_6.Text)+
                  Length(Label7b_7.Caption)+Length(DateEdit7b_8.Text)+1);
      StrPCopy(p,Label7b_3.Caption+Edit7b_4.Text+Label7b_5.Caption+
                 DateEdit7b_6.Text+Label7b_7.Caption+DateEdit7b_8.Text);
      X:=MemoOut(Rect(Tx,LP,Rct.Right-Xmm(3),100), p, False, TRUE);
      StrDispose(p);
      LP:=LP+X+Ymm(1);
      Result:=LP+Ymm(1);
    end;
end;

procedure TZp1Dlg.MakeBox7b(Ry:TRyPrinter; var PPos:Integer);
var
  p:PChar;
  Rct:TRect;
  Tx:Integer;
  LH:Integer;
  LP:Integer; {Line position}
  X,Y,Z,i:Integer;
begin
  with Ry do
    begin
      Rct.Left:=XLOff;
      Rct.Right:=XROff;
      Rct.Top:=PPos+Ymm(3);
      Tx:=Rct.Left+Xmm(15);
      Font.Size:=10;
      LH:=TextHeight+Ymm(1);
      LP:=Rct.Top+Ymm(2);
      p:=StrAlloc(Length(Label7b_1.Caption)+1);
      StrPCopy(p,Label7b_1.Caption);
      X:=MemoOut(Rect(Tx,LP,Rct.Right-Xmm(3),100), p, False, False);
      StrDispose(p);
      LP:=LP+X+Ymm(1);
      TextOut(Tx,LP,Grid7b_2.Cells[0,0]);
      Y:=Rct.Right-Xmm(18)-TextWidth(Grid7b_2.Cells[1,0]);
      TextOut(Y+Xmm(2),LP,Grid7b_2.Cells[1,0]);
      Z:=LP;
      LP:=LP+LH;
      i:=1;
      while (i<Grid7b_2.RowCount) do
        begin
          if (Grid7b_2.Cells[0,i]<>'')
            then begin
              Line(Point(Tx,LP),Point(Rct.Right,LP));
              p:=StrAlloc(Length(Grid7b_2.Cells[0,i])+1);
              StrPCopy(p,Grid7b_2.Cells[0,i]);
              X:=MemoOut(Rect(Tx,LP,Y-Xmm(3),100), p, False, False);
              StrDispose(p);
              TextOut(Y+Xmm(2),LP,Grid7b_2.Cells[1,i]);
              LP:=LP+X+Ymm(1);
            end;
          Inc(i);
        end;
      Line(Point(Y,Z),Point(Y,LP));
      p:=StrAlloc(Length(Label7b_3.Caption)+Length(Edit7b_4.Text)+
                  Length(Label7b_5.Caption)+Length(DateEdit7b_6.Text)+
                  Length(Label7b_7.Caption)+Length(DateEdit7b_8.Text)+1);
      StrPCopy(p,Label7b_3.Caption+Edit7b_4.Text+Label7b_5.Caption+
                 DateEdit7b_6.Text+Label7b_7.Caption+DateEdit7b_8.Text);
      X:=MemoOut(Rect(Tx,LP,Rct.Right-Xmm(3),100), p, False, False);
      StrDispose(p);
      LP:=LP+X+Ymm(1);
      Rct.Bottom:=LP+Ymm(1);
      RoundRectangle(Rct);
      Line(Point(Tx-Xmm(3),Rct.Top),Point(Tx-Xmm(3),Rct.Bottom));
      TextOutCenter(((Tx-Xmm(3)-Rct.Left) div 2)+Rct.Left,Rct.Top+Ymm(4),'7b');
      PPos:=Rct.Bottom;
    end;
end;

procedure TZp1Dlg.MakeBox8(Ry:TRyPrinter; var PPos:Integer);
var
  p1,p2,p3:PChar;
begin
  with Ry do
    begin
      p1:=StrAlloc(Length(Label8_1.Caption)+Length(ComboBox8_2.Text)+
                  Length(Label8_3.Caption)+Length(Label8_4.Caption)+1);
      StrPCopy(p1,Label8_1.Caption+ComboBox8_2.Text+Label8_3.Caption+Label8_4.Caption);
      p2:=StrAlloc(Length(Label8_5.Caption)+Length(Label8_6.Caption)+1);
      StrPCopy(p2,Label8_5.Caption+Label8_6.Caption);
      p3:=StrAlloc(Memo8_7.GetTextLen + 1);
      Memo8_7.GetTextBuf(p3, Memo8_7.GetTextLen+1);
      AddZp1Box(Ry,'8',[p1,p2,p3],[1,1,1],ZP1Tit,'1',NumEdit.Text,PrintSpace,PPos);
      StrDispose(p1);
      StrDispose(p2);
      StrDispose(p3);
    end;
end;

procedure TZp1Dlg.MakeBox9(Ry:TRyPrinter; var PPos:Integer);
var
  p,q:PChar;
  s,s2,s3:String;
begin
  with Ry do
    begin
      s:=DateEdit9_2.Text;
      if s=''
        then s:=EmptyDateStr;
      s2:=TimeEdit9_4.Text;
      if s2=''
        then s2:=EmptyDateStr;
      p:=StrAlloc(Length(Label9_1.Caption)+Length(s)+Length(Label9_3.Caption)+Length(s2)+2);
      StrPCopy(p,Label9_1.Caption+s+Label9_3.Caption+s2+'.');
      s:=DateEdit9_6.Text;
      if s=''
        then s:=EmptyDateStr;
      s2:=TimeEdit9_8.Text;
      if s2=''
        then s2:=EmptyDateStr;
      s3:=Edit9_10.Text;
      if s3=''
        then s3:=EmptyStr2cm;
      q:=StrAlloc(Length(Label9_5.Caption)+Length(s)+Length(Label9_7.Caption)+
                  Length(s2)+Length(Label9_9.Caption)+Length(s3)+Length(Label9_11.Caption)+1);
      StrPCopy(q,Label9_5.Caption+s+Label9_7.Caption+s2+
                 Label9_9.Caption+s3+Label9_11.Caption);
      AddZp1Box(Ry,'9',[p,q],[1,1],ZP1Tit,'1',NumEdit.Text,PrintSpace,PPos);
      StrDispose(p);
      StrDispose(q);
    end;
end;

procedure TZp1Dlg.MakeBox10(Ry:TRyPrinter; var PPos:Integer);
var
  p,q,r:PChar;
  s:String;
begin
  with Ry do
    begin
      s:=DateEdit10_2.Text;
      if s=''
        then s:=EmptyDateStr;
      p:=StrAlloc(Length(Label10_1.Caption)+Length(s)+Length(Label10_3.Caption)+3);
      StrPCopy(p,Label10_1.Caption+s+', '+Label10_3.Caption);
      q:=StrAlloc(Memo10_4.GetTextLen + 1);
      Memo10_4.GetTextBuf(q, Memo10_4.GetTextLen+1);
      r:=StrAlloc(Length(Label10_5.Caption)+1);
      StrPCopy(r,Label10_5.Caption);
      AddZp1Box(Ry,'10',[p,q,r],[1,1,1],ZP1Tit,'1',NumEdit.Text,PrintSpace,PPos);
      StrDispose(p);
      StrDispose(q);
      StrDispose(r);
    end;
end;

procedure TZp1Dlg.MakeBox10a(Ry:TRyPrinter; var PPos:Integer);
var
  p,q,r,v:PChar;
begin
  with Ry do
    begin
      p:=StrAlloc(Length(Label10a_1.Caption)+1);
      StrPCopy(p,Label10a_1.Caption);
      q:=StrAlloc(Length(Label10a_2.Caption)+Length(Label10a_3.Caption)+1);
      StrPCopy(q,Label10a_2.Caption+Label10a_3.Caption);
      r:=StrAlloc(Length(Label10a_4.Caption)+1);
      StrPCopy(r,Label10a_4.Caption);
      v:=StrAlloc(Length(Label10a_5.Caption)+1);
      StrPCopy(v,Label10a_5.Caption);
      AddZp1Box(Ry,'10a',[p,q,r,v],[1,1,1,1],ZP1Tit,'1',NumEdit.Text,PrintSpace,PPos);
      StrDispose(p);
      StrDispose(q);
      StrDispose(r);
      StrDispose(v);
    end;
end;

procedure TZp1Dlg.AddBox11;
var
  p,q,r,v:PChar;
  s:String;
begin
  with Ry do
    begin
      s:=DateEdit11_2.Text;
      if s=''
        then s:=EmptyDateStr;
      p:=StrAlloc(Length(Label11_1.Caption)+Length(s)+Length(Label11_3.Caption)+1);
      StrPCopy(p,Label11_1.Caption+s+Label11_3.Caption);
      q:=StrAlloc(Length(Label11_4.Caption)+Memo11_5.GetTextLen+1);
      r:=StrAlloc(Memo11_5.GetTextLen + 1);
      Memo11_5.GetTextBuf(r, Memo11_5.GetTextLen+1);
      StrPCopy(q,Label11_4.Caption);
      StrCat(q,r);
      StrDispose(r);
      r:=StrAlloc(Length(Label11_6.Caption)+Length(Label11_7.Caption)+
                  Length(Edit11_8.Text)+Length(MaskEdit11_9.Text)+3);
      StrPCopy(r,Label11_6.Caption+Edit11_8.Text+', '+Label11_7.Caption+MaskEdit11_9.Text);
      v:=StrAlloc(Length(Label11_10.Caption)+Length(Label11_11.Caption)+Length(Label11_12.Caption)+
                  Length(Edit11_13.Text)+Length(Edit11_14.Text)+Length(Edit11_15.Text)+3);
      StrPCopy(v,Label11_10.Caption+Edit11_13.Text+' '+Label11_11.Caption+Edit11_14.Text+' '+
                 Label11_12.Caption+Edit11_15.Text);
      AddZp1Box(Ry,'11',[p,q,r,v],[1,1,1,1],ZP1Tit,'1',NumEdit.Text,PrintSpace,PPos);
      StrDispose(p);
      StrDispose(q);
      StrDispose(r);
      StrDispose(v);
    end;
end;

procedure TZp1Dlg.AddBox12;
var
  p,q,r:PChar;
begin
  with Ry do
    begin
      p:=StrAlloc(Length(Label12_1.Caption)+1);
      StrPCopy(p,Label12_1.Caption);
      q:=StrAlloc(Length(ComboBox12_2.Text)+1);
      StrPCopy(q,ComboBox12_2.Text);
      r:=StrAlloc(Length(Label12_3.Caption)+1);
      StrPCopy(r,Label12_3.Caption);
      AddZp1Box(Ry,'12',[p,q,r],[1,1,1],ZP1Tit,'1',NumEdit.Text,PrintSpace,PPos);
      StrDispose(p);
      StrDispose(q);
      StrDispose(r);
    end;
end;

procedure TZp1Dlg.AddBox13;
var
  p,q:PChar;
begin
  with Ry do
    begin
      p:=StrAlloc(Length(Label13_1.Caption)+Length(Label13_2.Caption)+1);
      StrPCopy(p,Label13_1.Caption+Label13_2.Caption);
      q:=StrAlloc(Length(Label13_5.Caption)+1);
      StrPCopy(q,Label13_5.Caption);
      if GetBox13Len(Ry,p,q)+PPos+Ymm(3)>PrintSpace
        then MakeNewPage(Ry,Zp1Tit,'1',NumEdit.Text,PPos,PrintSpace);
      MakeBox13(Ry,p,q,YesRB13_3.Checked,NoRB13_4.Checked,PPos);
      StrDispose(p);
      StrDispose(q);
    end;
end;

procedure TZp1Dlg.AddBox14;
var
  p,q:PChar;
begin
  with Ry do
    begin
      p:=StrAlloc(Length(Label14_1.Caption)+Length(Label14_1.Caption)+1);
      StrPCopy(p,Label14_1.Caption+Label14_2.Caption);
      q:=StrAlloc(Length(Label14_5.Caption)+1);
      StrPCopy(q,Label14_5.Caption);
      if GetBox14Len(Ry,p,q)+PPos+Ymm(3)>PrintSpace
        then MakeNewPage(Ry,Zp1Tit,'1',NumEdit.Text,PPos,PrintSpace);
      MakeBox14(Ry,p,q,YesRB14_3.Checked,NoRB14_4.Checked,PPos);
      StrDispose(p);
      StrDispose(q);
    end;
end;

procedure TZp1Dlg.AddBox15;
var
  p,q:PChar;
begin
  with Ry do
    begin
      p:=StrAlloc(Length(Label15_1.Caption)+1);
      StrPCopy(p,Label15_1.Caption);
      q:=StrAlloc(Length(Label15_4.Caption)+1);
      StrPCopy(q,Label15_4.Caption);
      if GetBox15Len(Ry,p,q)+PPos+Ymm(3)>PrintSpace
        then MakeNewPage(Ry,Zp1Tit,'1',NumEdit.Text,PPos,PrintSpace);
      MakeBox15(Ry,p,q,YesRB15_2.Checked,NoRB15_3.Checked,PPos);
      StrDispose(p);
      StrDispose(q);
    end;
end;

procedure TZp1Dlg.AddBox16;
var
  p,q:PChar;
begin
  with Ry do
    begin
      p:=StrAlloc(Length(Label16_1.Caption)+1);
      StrPCopy(p,Label16_1.Caption);
      q:=StrAlloc(Length(Label16_4.Caption)+1);
      StrPCopy(q,Label16_4.Caption);
      if GetBox16Len(Ry,p,q)+PPos+Ymm(3)>PrintSpace
        then MakeNewPage(Ry,Zp1Tit,'1',NumEdit.Text,PPos,PrintSpace);
      MakeBox16(Ry,p,q,YesRB16_2.Checked,NoRB16_3.Checked,PPos);
      StrDispose(p);
      StrDispose(q);
    end;
end;

procedure TZp1Dlg.AddBox17;
var
  p,q:PChar;
begin
  with Ry do
    begin
      p:=StrAlloc(Length(Label17_1.Caption)+Length(Label17_2.Caption)+1);
      StrPCopy(p,Label17_1.Caption+Label17_2.Caption);
      q:=StrAlloc(Length(Label17_3.Caption)+1);
      StrPCopy(q,Label17_3.Caption);
      AddZp1Box(Ry,'17',[p,q],[1,1],ZP1Tit,'1',NumEdit.Text,PrintSpace,PPos);
      StrDispose(p);
      StrDispose(q);
    end;
end;

procedure TZp1Dlg.AddBox18;
var
  p,q,r:PChar;
  a,b:String;
begin
  with Ry do
    begin
      p:=StrAlloc(Length(Label18_1.Caption)+1);
      StrPCopy(p,Label18_1.Caption);
      a:=NumEdit18_3.Text;
      if a=''
        then a:=EmptyStr2cm;
      b:=NumEdit18_6.Text;
      if b=''
        then b:=EmptyStr2cm;
      q:=StrAlloc(Length(Label18_2.Caption)+Length(a)+Length(Label18_4.Caption)+
                  Length(Label18_5.Caption)+Length(b)+Length(Label18_7.Caption)+11);
      StrPCopy(q,Label18_2.Caption+a+Label18_4.Caption+'          '+Label18_5.Caption+b+Label18_7.Caption);
      r:=StrAlloc(Length(Label18_8.Caption)+Length(Label18_9.Caption)+1);
      StrPCopy(r,Label18_8.Caption+Label18_9.Caption);
      AddZp1Box(Ry,'18',[p,q,r],[1,1,1],ZP1Tit,'1',NumEdit.Text,PrintSpace,PPos);
      StrDispose(p);
      StrDispose(q);
      StrDispose(r);
    end;
end;

procedure TZp1Dlg.AddBox19;
var
  p,q:PChar;
begin
  with Ry do
    begin
      p:=StrAlloc(Length(Label19_1.Caption)+Length(Label19_2.Caption)+1);
      StrPCopy(p,Label19_1.Caption+Label19_2.Caption);
      q:=StrAlloc(Length(Label19_3.Caption)+1);
      StrPCopy(q,Label19_3.Caption);
      AddZp1Box(Ry,'19',[p,q],[1,1],ZP1Tit,'1',NumEdit.Text,PrintSpace,PPos);
      StrDispose(p);
      StrDispose(q);
    end;
end;

procedure TZp1Dlg.AddBox20;
var
  p,q:PChar;
begin
  with Ry do
    begin
      p:=StrAlloc(Length(Label20_1.Caption)+Length(Label20_2.Caption)+1);
      StrPCopy(p,Label20_1.Caption+Label20_2.Caption);
      q:=StrAlloc(Length(Label20_4.Caption)+1);
      StrPCopy(q,Label20_4.Caption);
      if GetBox20Len(Ry,p,q,Grid20_3)+PPos+Ymm(3)>PrintSpace
        then MakeNewPage(Ry,Zp1Tit,'1',NumEdit.Text,PPos,PrintSpace);
      MakeBox20(Ry,p,q,Grid20_3,PPos);
      StrDispose(p);
      StrDispose(q);
    end;
end;

procedure TZp1Dlg.AddBox21;
var
  p,q:PChar;
begin
  with Ry do
    begin
      p:=StrAlloc(Length(Label21_1.Caption)+1);
      StrPCopy(p,Label21_1.Caption);
      q:=StrAlloc(Length(Label21_4.Caption)+Length(Label21_5.Caption)+1);
      StrPCopy(q,Label21_4.Caption+Label21_5.Caption);
      if GetBox21Len(Ry,p,q)+PPos+Ymm(3)>PrintSpace
        then MakeNewPage(Ry,Zp1Tit,'1',NumEdit.Text,PPos,PrintSpace);
      MakeBox21(Ry,p,q,YesRB21_2.Checked,NoRB21_3.Checked,PPos);
      StrDispose(p);
      StrDispose(q);
    end;
end;

procedure TZp1Dlg.AddBox22;
var
  p,q:PChar;
begin
  with Ry do
    begin
      p:=StrAlloc(Length(Label22_1.Caption)+1);
      StrPCopy(p,Label22_1.Caption);
      q:=StrAlloc(Length(Label22_4.Caption)+1);
      StrPCopy(q,Label22_4.Caption);
      if GetBox22Len(Ry,p,q)+PPos+Ymm(3)>PrintSpace
        then MakeNewPage(Ry,Zp1Tit,'1',NumEdit.Text,PPos,PrintSpace);
      MakeBox22(Ry,p,q,YesRB22_2.Checked,NoRB22_3.Checked,PPos);
      StrDispose(p);
      StrDispose(q);
    end;
end;

procedure TZp1Dlg.AddBox22a;
var
  p,q,r:PChar;
  s:String;
begin
  with Ry do
    begin
      s:=NumEdit22a_4.Text;
      if s=''
        then s:=EmptyStr2cm;
      p:=StrAlloc(Length(Label22a_1.Caption)+Length(ComboBox22a_2.Text)+Length(Label22a_3.Caption)+
                  Length(s)+Length(Label22a_5.Caption)+1);
      StrPCopy(p,Label22a_1.Caption+ComboBox22a_2.Text+Label22a_3.Caption+s+Label22a_5.Caption);
      q:=StrAlloc(Length(Label22a_6.Caption)+Length(Label22a_7.Caption)+1);
      StrPCopy(q,Label22a_6.Caption+Label22a_7.Caption);
      r:=StrAlloc(Memo22a_8.GetTextLen + 1);
      Memo22a_8.GetTextBuf(r, Memo22a_8.GetTextLen+1);
      AddZp1Box(Ry,'22a',[p,q,r],[1,1,1],ZP1Tit,'1',NumEdit.Text,PrintSpace,PPos);
      StrDispose(p);
      StrDispose(q);
      StrDispose(r);
    end;
end;

procedure TZp1Dlg.AddBox22b;
var
  p,q:PChar;
  s:String;
begin
  with Ry do
    begin
      s:=DateEdit22b_2.Text;
      if s=''
        then s:=EmptyDateStr;
      p:=StrAlloc(Length(Label22b_1.Caption)+Length(s)+Length(Label22b_3.Caption)+
                  Length(Label22b_4.Caption)+1);
      StrPCopy(p,Label22b_1.Caption+s+Label22b_3.Caption+Label22b_4.Caption);
      q:=StrAlloc(Memo22b_5.GetTextLen + 1);
      Memo22b_5.GetTextBuf(q, Memo22b_5.GetTextLen+1);
      AddZp1Box(Ry,'22b',[p,q],[1,1],ZP1Tit,'1',NumEdit.Text,PrintSpace,PPos);
      StrDispose(p);
      StrDispose(q);
    end;
end;

procedure TZp1Dlg.AddBox23;
var
  p,q:PChar;
begin
  with Ry do
    begin
      p:=StrAlloc(Length(Label23_1.Caption)+Length(Label23_2.Caption)+1);
      StrPCopy(p,Label23_1.Caption+Label23_2.Caption);
      if GetBox23Len(Ry,p)+PPos+Ymm(3)>PrintSpace
        then MakeNewPage(Ry,Zp1Tit,'1',NumEdit.Text,PPos,PrintSpace);
      MakeBox23(Ry,p,YesRB23_3.Checked,NoRB23_4.Checked,PPos);
      StrDispose(p);
    end;
end;

procedure TZp1Dlg.AddBox24;
var
  p,q:PChar;
begin
  with Ry do
    begin
      p:=StrAlloc(Length(Label24_1.Caption)+Length(Label24_2.Caption)+1);
      StrPCopy(p,Label24_1.Caption+Label24_2.Caption);
      q:=StrAlloc(Length(Label24_5.Caption)+1);
      StrPCopy(q,Label24_5.Caption);
      if GetBox24Len(Ry,p,q)+PPos+Ymm(3)>PrintSpace
        then MakeNewPage(Ry,Zp1Tit,'1',NumEdit.Text,PPos,PrintSpace);
      MakeBox24(Ry,p,q,YesRB24_3.Checked,NoRB24_4.Checked,PPos);
      StrDispose(p);
      StrDispose(q);
    end;
end;

procedure TZp1Dlg.AddBox25;
var
  a,b:String;
  p,q,r,s,t,u,v:PChar;
begin
  with Ry do
    begin
      p:=StrAlloc(Length(Label25_1.Caption)+1);
      StrPCopy(p,Label25_1.Caption);
      q:=StrAlloc(Length(Label25_2.Caption)+Length(Edit25_3.Text)+1);
      StrPCopy(q,Label25_2.Caption+Edit25_3.Text);
      r:=StrAlloc(Length(Label25_4.Caption)+Length(Edit25_5.Text)+1);
      StrPCopy(r,Label25_4.Caption+Edit25_5.Text);
      a:=Edit25_7.Text;
      if a=''
        then a:=EmptyStr2cm+EmptyStr2cm+EmptyStr2cm+EmptyStr2cm+EmptyStr2cm;
      s:=StrAlloc(Length(Label25_6.Caption)+Length(a)+Length(Label25_8.Caption)+Length(MaskEdit25_9.Text)+1);
      StrPCopy(s,Label25_6.Caption+a+Label25_8.Caption+MaskEdit25_9.Text);
      a:=Edit25_11.Text;
      if a=''
        then a:=EmptyStr2cm+EmptyStr2cm+EmptyStr2cm+EmptyStr2cm+EmptyStr2cm;
      b:=Edit25_13.Text;
      if b=''
        then b:=EmptyStr2cm;
      t:=StrAlloc(Length(Label25_10.Caption)+Length(a)+Length(Label25_12.Caption)+Length(b)+
                  Length(Label25_14.Caption)+Length(Edit25_15.Text)+1);
      StrPCopy(t,Label25_10.Caption+a+Label25_12.Caption+b+Label25_14.Caption+Edit25_15.Text);
      u:=StrAlloc(Length(Label25_16.Caption)+1);
      StrPCopy(u,Label25_16.Caption);
      v:=StrAlloc(Memo25_17.GetTextLen + 1);
      Memo25_17.GetTextBuf(v, Memo25_17.GetTextLen+1);
      AddZp1Box(Ry,'25',[p,q,r,s,t,u,v],[1,1,1,1,1,1,1],ZP1Tit,'1',NumEdit.Text,PrintSpace,PPos);
      StrDispose(p);
      StrDispose(q);
      StrDispose(r);
      StrDispose(s);
      StrDispose(t);
      StrDispose(u);
      StrDispose(v);
    end;
end;

procedure TZp1Dlg.AddBox26;
var
  p,q:PChar;
begin
  with Ry do
    begin
      p:=StrAlloc(Length(Label26_1.Caption)+1);
      StrPCopy(p,Label26_1.Caption);
      q:=StrAlloc(Memo26_2.GetTextLen + 1);
      Memo26_2.GetTextBuf(q, Memo26_2.GetTextLen+1);
      AddZp1Box(Ry,'26',[p,q],[1,1],ZP1Tit,'1',NumEdit.Text,PrintSpace,PPos);
      StrDispose(p);
      StrDispose(q);
    end;
end;

procedure TZp1Dlg.AddBox27;
const
  Txt='(podpisy Przewodnicz¹cego i cz³onków komisji)';
var
  p,q:PChar;
  x:Integer;
begin
  with Ry do
    begin
      p:=StrAlloc(Length(Label27_1.Caption)+Length(DateEdit27_2.Text)+Length(Label27_3.Caption)+Length(TimeEdit27_4.Text)+1);
      StrPCopy(p,Label27_1.Caption+DateEdit27_2.Text+Label27_3.Caption+TimeEdit27_4.Text);
      q:=StrAlloc(Length(Txt)+1);
      StrPCopy(q,Txt);
      AddZp1Box(Ry,'27',[p,q],[1,45],ZP1Tit,'1',NumEdit.Text,PrintSpace,PPos);
      StrDispose(p);
      StrDispose(q);
    end;
end;

procedure TZp1Dlg.AddBox28;
const
  Txt='(podpis kierownika jednostki zamawiaj¹cej)';
var
  p,q:PChar;
begin
  with Ry do
    begin
      p:=StrAlloc(Length(Label28_1.Caption)+Length(Label28_2.Caption)+Length(DateEdit28_3.Text)+Length(Label28_4.Caption)+1);
      StrPCopy(p,Label28_1.Caption+Label28_2.Caption+DateEdit28_3.Text+Label28_4.Caption);
      q:=StrAlloc(Length(Txt)+1);
      StrPCopy(q,Txt);
      AddZp1Box(Ry,'28',[p,q],[12,3],ZP1Tit,'1',NumEdit.Text,PrintSpace,PPos);
      StrDispose(p);
      StrDispose(q);
    end;
end;

procedure TZp1Dlg.MakePrint;
begin
    with Ry do
      begin
        NewJob;
        SetMinMargins(Xmm(20),Ymm(10),Xmm(20),Ymm(10));
        MakeHeader(Ry,Zp1Tit,'1',NumEdit.Text,'',PPos);
        PrintSpace:=YBOff-Ymm(PageBottomSpace);
        MakeFooter(Ry,PrintSpace);{YBOff-Ymm(20));}
        MakeBox1(Ry,PPos);
        MakeBox2(Ry,PPos);
        MakeBox2a(Ry,PPos);
        MakeBox3(Ry,PPos);
        MakeBox4(Ry,PPos);
        MakeBox5(Ry,PPos);
        if GetBox6Len(Ry)+PPos+Ymm(3)>PrintSpace
          then MakeNewPage(Ry,Zp1Tit,'1',NumEdit.Text,PPos,PrintSpace);
        MakeBox6(Ry,PPos);
        if YesRB6_2.Checked
          then begin
            MakeBox6a(Ry,PPos);
            MakeBox6b(Ry,PPos);
            MakeBox6c(Ry,PPos);
            MakeBox6d(Ry,PPos);
          end;
        MakeBox7(Ry,PPos);
        MakeBox7a(Ry,PPos);
        if GetBox7bLen(Ry)+PPos+Ymm(3)>PrintSpace
          then MakeNewPage(Ry,Zp1Tit,'1',NumEdit.Text,PPos,PrintSpace);
        MakeBox7b(Ry,PPos);
        MakeBox8(Ry,PPos);
        MakeBox9(Ry,PPos);
        MakeBox10(Ry,PPos);
        MakeBox10a(Ry,PPos);
        AddBox11;
        AddBox12;
        AddBox13;
        AddBox14;
        AddBox15;
        AddBox16;
        AddBox17;
        AddBox18;
        AddBox19;
        AddBox20;
        AddBox21;
        AddBox22;
        if YesRB22_2.Checked
           then begin
             AddBox22a;
             AddBox22b;
           end;
        AddBox23;
        AddBox24;
        AddBox25;
        AddBox26;
        AddBox27;
        AddBox28;
      end;
end;

procedure TZp1Dlg.PreviewBtnClick(Sender: TObject);
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

procedure TZp1Dlg.PrintBtnClick(Sender: TObject);
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

procedure TZp1Dlg.SaveFile;
var
  s:String;
  FO:Boolean;
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
      SaveString(Zp1FileHdr,FHandle);
      SaveString(FilePwd,FHandle);
      MakeCodeKey(FilePwd);
      SaveEdit(NumEdit,FHandle);
      SaveMemo(Memo1_2,FHandle);
      SaveEdit(Edit1_6,FHandle);
      SaveEdit(Edit1_7,FHandle);
      SaveEdit(Edit1_8,FHandle);
      SaveEdit(Edit1_11,FHandle);
      SaveMaskEdit(MaskEdit1_12,FHandle);
      SaveEdit(Edit1_16,FHandle);
      SaveEdit(Edit1_17,FHandle);
      SaveEdit(Edit1_18,FHandle);
      SaveMaskEdit(MaskEdit1_20,FHandle);
      SaveBoolean(RB1_22.Checked,FHandle);
      SaveBoolean(RB1_23.Checked,FHandle);
      SaveMaskEdit(MaskEdit1_24,FHandle);
      SaveMaskEdit(MaskEdit1_25,FHandle);
      SaveMemo(Memo1_27,FHandle);

      SaveMemo(Memo2_1,FHandle);
      SaveEdit(Edit2_2,FHandle);
      SaveComboBox(CB2_3,FHandle);

      SaveReal(NumEdit2a_1.Value,FHandle);
      SaveMemo(Memo2a_2,FHandle);

      SaveDateTime(DateEdit3_1.EditDate,FHandle);
      SaveMemo(Memo3_2,FHandle);

      SaveInteger(ComboBox4_1.ItemIndex,FHandle);
      SaveMemo(Memo4_2,FHandle);

      SaveMemo(Memo5_1,FHandle);

      SaveBoolean(YesRB6_2.Checked,FHandle);
      SaveBoolean(NoRB6_3.Checked,FHandle);

      SaveDateTime(DateEdit6a_1.EditDate,FHandle);
      SaveEdit(Edit6a_2,FHandle);
      SaveEdit(Edit6a_3,FHandle);

      SaveDateTime(DateEdit6c_1.EditDate,FHandle);

      SaveInteger(ComboBox7_4.ItemIndex,FHandle);
      SaveDateTime(DateEdit7_6.EditDate,FHandle);
      SaveEdit(Edit7_8,FHandle);
      SaveEdit(Edit7_10,FHandle);
      SaveInteger(ComboBox7_12.ItemIndex,FHandle);
      SaveDateTime(DateEdit7_14.EditDate,FHandle);

      SaveStringGrid(Grid7b_2,FHandle);
      SaveEdit(Edit7b_4,FHandle);
      SaveDateTime(DateEdit7b_6.EditDate,FHandle);
      SaveDateTime(DateEdit7b_8.EditDate,FHandle);

      SaveInteger(ComboBox8_2.ItemIndex,FHandle);
      SaveMemo(Memo8_7,FHandle);

      SaveDateTime(DateEdit9_2.EditDate,FHandle);
      SaveDateTime(TimeEdit9_4.EditTime,FHandle);
      SaveDateTime(DateEdit9_6.EditDate,FHandle);
      SaveDateTime(TimeEdit9_8.EditTime,FHandle);
      SaveEdit(Edit9_10,FHandle);

      SaveDateTime(DateEdit10_2.EditDate,FHandle);
      SaveMemo(Memo10_4,FHandle);

      SaveDateTime(DateEdit11_2.EditDate,FHandle);
      SaveMemo(Memo11_5,FHandle);
      SaveEdit(Edit11_8,FHandle);
      SaveMaskEdit(MaskEdit11_9,FHandle);
      SaveEdit(Edit11_13,FHandle);
      SaveEdit(Edit11_14,FHandle);
      SaveEdit(Edit11_15,FHandle);

      SaveInteger(ComboBox12_2.ItemIndex,FHandle);

      SaveBoolean(YesRB13_3.Checked,FHandle);
      SaveBoolean(NoRB13_4.Checked,FHandle);

      SaveBoolean(YesRB14_3.Checked,FHandle);
      SaveBoolean(NoRB14_4.Checked,FHandle);

      SaveBoolean(YesRB15_2.Checked,FHandle);
      SaveBoolean(NoRB15_3.Checked,FHandle);

      SaveBoolean(YesRB16_2.Checked,FHandle);
      SaveBoolean(NoRB16_3.Checked,FHandle);

      SaveInteger(NumEdit18_3.AsInteger,FHandle);
      SaveInteger(NumEdit18_6.AsInteger,FHandle);

      SaveStringGrid(TStringGrid(Grid20_3),FHandle);

      SaveBoolean(YesRB21_2.Checked,FHandle);
      SaveBoolean(NoRB21_3.Checked,FHandle);

      SaveBoolean(YesRB22_2.Checked,FHandle);
      SaveBoolean(NoRB22_3.Checked,FHandle);

      SaveInteger(ComboBox22a_2.ItemIndex,FHandle);
      SaveReal(NumEdit22a_4.Value,FHandle);
      SaveMemo(Memo22a_8,FHandle);

      SaveDateTime(DateEdit22b_2.EditDate,FHandle);
      SaveMemo(Memo22b_5,FHandle);

      SaveBoolean(YesRB23_3.Checked,FHandle);
      SaveBoolean(NoRB23_4.Checked,FHandle);

      SaveBoolean(YesRB24_3.Checked,FHandle);
      SaveBoolean(NoRB24_4.Checked,FHandle);

      SaveEdit(Edit25_3,FHandle);
      SaveEdit(Edit25_5,FHandle);
      SaveEdit(Edit25_7,FHandle);
      SaveMaskEdit(MaskEdit25_9,FHandle);
      SaveEdit(Edit25_11,FHandle);
      SaveEdit(Edit25_13,FHandle);
      SaveEdit(Edit25_15,FHandle);
      SaveMemo(Memo25_17,FHandle);

      SaveMemo(Memo26_2,FHandle);

      SaveDateTime(DateEdit27_2.EditDate,FHandle);
      SaveDateTime(TimeEdit27_4.EditTime,FHandle);
      SaveReal(NumEdit27_6.Value,FHandle);

      SaveDateTime(DateEdit28_3.EditDate,FHandle);
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

procedure TZp1Dlg.LoadFile;
var
  s:String;
  i:Integer;
  b:Boolean;
  r:Real;
  DT:TDateTime;
  FPwd:String;
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
        if s=Zp1FileHdr
          then begin
            LoadString(FPwd,FHandle);
            if (FPwd=FilePwd)
              then begin
                MakeCodeKey(FPwd);
                LoadEdit(NumEdit,FHandle);
                LoadMemo(Memo1_2,FHandle);
                LoadEdit(Edit1_6,FHandle);
                LoadEdit(Edit1_7,FHandle);
                LoadEdit(Edit1_8,FHandle);
                LoadEdit(Edit1_11,FHandle);
                LoadMaskEdit(MaskEdit1_12,FHandle);
                LoadEdit(Edit1_16,FHandle);
                LoadEdit(Edit1_17,FHandle);
                LoadEdit(Edit1_18,FHandle);
                LoadMaskEdit(MaskEdit1_20,FHandle);
                LoadBoolean(b,FHandle);
                RB1_22.Checked:=b;
                LoadBoolean(b,FHandle);
                RB1_23.Checked:=b;
                LoadMaskEdit(MaskEdit1_24,FHandle);
                LoadMaskEdit(MaskEdit1_25,FHandle);
                LoadMemo(Memo1_27,FHandle);

                LoadMemo(Memo2_1,FHandle);
                LoadEdit(Edit2_2,FHandle);
                LoadComboBox(CB2_3,FHandle);

                LoadReal(r,FHandle);
                NumEdit2a_1.Value:=r;
                LoadMemo(Memo2a_2,FHandle);

                LoadDateTime(DT,FHandle);
                DateEdit3_1.EditDate:=DT;
                LoadMemo(Memo3_2,FHandle);

                LoadInteger(i,FHandle);
                ComboBox4_1.ItemIndex:=i;
                LoadMemo(Memo4_2,FHandle);

                LoadMemo(Memo5_1,FHandle);

                LoadBoolean(b,FHandle);
                YesRB6_2.Checked:=b;
                LoadBoolean(b,FHandle);
                NoRB6_3.Checked:=b;

                LoadDateTime(DT,FHandle);
                DateEdit6a_1.EditDate:=DT;
                LoadEdit(Edit6a_2,FHandle);
                LoadEdit(Edit6a_3,FHandle);

                LoadDateTime(DT,FHandle);
                DateEdit6c_1.EditDate:=DT;

                LoadInteger(i,FHandle);
                ComboBox7_4.ItemIndex:=i;
                LoadDateTime(DT,FHandle);
                DateEdit7_6.EditDate:=DT;
                LoadEdit(Edit7_8,FHandle);
                LoadEdit(Edit7_10,FHandle);
                LoadInteger(i,FHandle);
                ComboBox7_12.ItemIndex:=i;
                LoadDateTime(DT,FHandle);
                DateEdit7_14.EditDate:=DT;

                LoadStringGrid(TStringGrid(Grid7b_2),FHandle);
                LoadEdit(Edit7b_4,FHandle);
                LoadDateTime(DT,FHandle);
                DateEdit7b_6.EditDate:=DT;
                LoadDateTime(DT,FHandle);
                DateEdit7b_8.EditDate:=DT;

                LoadInteger(i,FHandle);
                ComboBox8_2.ItemIndex:=i;
                LoadMemo(Memo8_7,FHandle);

                LoadDateTime(DT,FHandle);
                DateEdit9_2.EditDate:=DT;
                LoadDateTime(DT,FHandle);
                TimeEdit9_4.EditTime:=DT;
                LoadDateTime(DT,FHandle);
                DateEdit9_6.EditDate:=DT;
                LoadDateTime(DT,FHandle);
                TimeEdit9_8.EditTime:=DT;
                LoadEdit(Edit9_10,FHandle);

                LoadDateTime(DT,FHandle);
                DateEdit10_2.EditDate:=DT;
                LoadMemo(Memo10_4,FHandle);

                LoadDateTime(DT,FHandle);
                DateEdit11_2.EditDate:=DT;
                LoadMemo(Memo11_5,FHandle);
                LoadEdit(Edit11_8,FHandle);
                LoadMaskEdit(MaskEdit11_9,FHandle);
                LoadEdit(Edit11_13,FHandle);
                LoadEdit(Edit11_14,FHandle);
                LoadEdit(Edit11_15,FHandle);

                LoadInteger(i,FHandle);
                ComboBox12_2.ItemIndex:=i;

                LoadBoolean(b,FHandle);
                YesRB13_3.Checked:=b;
                LoadBoolean(b,FHandle);
                NoRB13_4.Checked:=b;

                LoadBoolean(b,FHandle);
                YesRB14_3.Checked:=b;
                LoadBoolean(b,FHandle);
                NoRB14_4.Checked:=b;

                LoadBoolean(b,FHandle);
                YesRB15_2.Checked:=b;
                LoadBoolean(b,FHandle);
                NoRB15_3.Checked:=b;

                LoadBoolean(b,FHandle);
                YesRB16_2.Checked:=b;
                LoadBoolean(b,FHandle);
                NoRB16_3.Checked:=b;

                LoadInteger(i,FHandle);
                NumEdit18_3.Value:=i;
                LoadInteger(i,FHandle);
                NumEdit18_6.Value:=i;

                LoadStringGrid(TStringGrid(Grid20_3),FHandle);

                LoadBoolean(b,FHandle);
                YesRB21_2.Checked:=b;
                LoadBoolean(b,FHandle);
                NoRB21_3.Checked:=b;

                LoadBoolean(b,FHandle);
                YesRB22_2.Checked:=b;
                LoadBoolean(b,FHandle);
                NoRB22_3.Checked:=b;

                LoadInteger(i,FHandle);
                ComboBox22a_2.ItemIndex:=i;
                LoadReal(r,FHandle);
                NumEdit22a_4.Value:=r;
                LoadMemo(Memo22a_8,FHandle);

                LoadDateTime(DT,FHandle);
                DateEdit22b_2.EditDate:=DT;
                LoadMemo(Memo22b_5,FHandle);

                LoadBoolean(b,FHandle);
                YesRB23_3.Checked:=b;
                LoadBoolean(b,FHandle);
                NoRB23_4.Checked:=b;

                LoadBoolean(b,FHandle);
                YesRB24_3.Checked:=b;
                LoadBoolean(b,FHandle);
                NoRB24_4.Checked:=b;

                LoadEdit(Edit25_3,FHandle);
                LoadEdit(Edit25_5,FHandle);
                LoadEdit(Edit25_7,FHandle);
                LoadMaskEdit(MaskEdit25_9,FHandle);
                LoadEdit(Edit25_11,FHandle);
                LoadEdit(Edit25_13,FHandle);
                LoadEdit(Edit25_15,FHandle);
                LoadMemo(Memo25_17,FHandle);

                LoadMemo(Memo26_2,FHandle);

                LoadDateTime(DT,FHandle);
                DateEdit27_2.EditDate:=DT;
                LoadDateTime(DT,FHandle);
                TimeEdit27_4.EditTime:=DT;
                LoadReal(r,FHandle);
                NumEdit27_6.Value:=r;

                LoadDateTime(DT,FHandle);
                DateEdit28_3.EditDate:=DT;
              end
              else begin
                MessageDlg(wmSecurityCode,mtWarning,[mbOk],0);
                CloseFile(FHandle);
                FileIsOpen:=FALSE;
              end;
          end
          else begin
            MessageDlg(wmNotAZP,mtWarning,[mbOk],0);
            CloseFile(FHandle);
            FileIsOpen:=FALSE;
          end;
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

procedure TZp1Dlg.OpenBtnClick(Sender: TObject);
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

procedure TZp1Dlg.SaveBtnClick(Sender: TObject);
begin
  if SaveDialog.Execute
    then begin
      if FileName<>SaveDialog.FileName
        then if FileIsOpen
          then begin
            CloseFile(FHandle);
            FileIsOpen:=FALSE;
          end;
      FileName:=SaveDialog.FileName;
      SaveFile;
    end;
end;

procedure TZp1Dlg.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Sender is TMemo
    then Exit;
  if Key=#13
    then begin
      Key:=#0;
      Perform(wm_NextDlgCtl,0,0);
    end;
end;

procedure TZp1Dlg.FormDestroy(Sender: TObject);
begin
  if FileIsOpen
    then begin
      CloseFile(FHandle);
      FileIsOpen:=FALSE;
    end;
end;

procedure TZp1Dlg.OKBtnClick(Sender: TObject);
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

procedure TZp1Dlg.SiwzBtnClick(Sender: TObject);
var
  s:String;
  i:LongInt;
  FileName:String;
  x:Byte;
begin
{$IFDEF DEMO}
  MessageDlg('Nie dostêpne w wersji DEMO',mtWarning,[mbOk],0);
{$ELSE}
    OpenDialog.DefaultExt:=NieExt;
    OpenDialog.Filter:=AllFilter;
    if OpenDialog.Execute
      then begin
        LoadPrtRec(Self,OpenDialog.FileName);
        with PrtRec do
          begin
            Memo1_2.SetTextBuf(NameMemo);
            Edit1_6.Text:=StreetEdit;
            Edit1_7.Text:=BldgEdit;
            Edit1_8.Text:=RoomEdit;
            Edit1_11.Text:=TownEdit;
            MaskEdit1_12.Text:=ZipMaskEdit;
            Edit1_16.Text:=TelEdit;
            Edit1_17.Text:=FaxEdit;
            Edit1_18.Text:=TelexEdit;
            MaskEdit1_20.Text:=RegonMaskEdit;
            RB1_22.Checked:=NipRB1;
            RB1_23.Checked:=NipRB2;
            MaskEdit1_24.Text:=NipMaskEdit1;
            MaskEdit1_25.Text:=NipMaskEdit2;
            Memo2_1.SetTextBuf(ObjectMemo);
            NumEdit2a_1.Value:=Amount;
            if PrefKrajowe
              then ComboBox8_2.ItemIndex:=0
              else ComboBox8_2.ItemIndex:=1;
            DateEdit9_2.EditDate:=SkladDateEdit2_15;
            TimeEdit9_4.EditTime:=SkladTime2_17;
            DateEdit9_6.EditDate:=SkladDateEdit2_15;
            TimeEdit9_8.EditTime:=SkladTime2_17;
            DateEdit11_2.EditDate:=OpeningDateEdit1_2;
            Memo11_5.SetTextBuf(NameMemo);
            Edit11_8.Text:=TownEdit;
            MaskEdit11_9.Text:=ZipMaskEdit;
            Edit11_13.Text:=StreetEdit;
            Edit11_14.Text:=BldgEdit;
            Edit11_15.Text:=RoomEdit;
          end;
        FreePrtRec;
      end;
    OpenDialog.DefaultExt:='001';
    OpenDialog.Filter:='Druki ZP1|*.001';
{$ENDIF}
end;

procedure TZp1Dlg.HelpBtnClick(Sender: TObject);
begin
  Application.HelpContext(1);
end;

procedure TZp1Dlg.NoRB6Click(Sender: TObject);
begin
  Label6a.Font.Color:=clGray;
  Label6a_1.Font.Color:=clGray;
  Label6a_2.Font.Color:=clGray;
  Label6a_3.Font.Color:=clGray;
  Label6a_4.Font.Color:=clGray;
  DateEdit6a_1.Enabled:=FALSE;
  DateEdit6a_1.Font.Color:=clGray;
  Edit6a_2.Enabled:=FALSE;
  Edit6a_3.Enabled:=FALSE;
  Label6b.Font.Color:=clGray;
  Label6b_1.Font.Color:=clGray;
  Label6b_2.Font.Color:=clGray;
  Label6c.Font.Color:=clGray;
  Label6c_1.Font.Color:=clGray;
  Label6c_2.Font.Color:=clGray;
  Label6c_3.Font.Color:=clGray;
  DateEdit6c_1.Enabled:=FALSE;
  DateEdit6c_1.Font.Color:=clGray;
  Label6d.Font.Color:=clGray;
  Label6d_1.Font.Color:=clGray;
  Label6d_2.Font.Color:=clGray;
end;

procedure TZp1Dlg.YesRB6Click(Sender: TObject);
begin
      Label6a.Font.Color:=clBlack;
      Label6a_1.Font.Color:=clBlack;
      Label6a_2.Font.Color:=clBlack;
      Label6a_3.Font.Color:=clBlack;
      Label6a_4.Font.Color:=clBlack;
      DateEdit6a_1.Enabled:=TRUE;
      DateEdit6a_1.Font.Color:=clBlack;
      Edit6a_2.Enabled:=TRUE;
      Edit6a_3.Enabled:=TRUE;
      Label6b.Font.Color:=clBlack;
      Label6b_1.Font.Color:=clBlack;
      Label6b_2.Font.Color:=clBlack;
      Label6c.Font.Color:=clBlack;
      Label6c_1.Font.Color:=clBlack;
      Label6c_2.Font.Color:=clBlack;
      Label6c_3.Font.Color:=clBlack;
      DateEdit6c_1.Enabled:=TRUE;
      DateEdit6c_1.Font.Color:=clBlack;
      Label6d.Font.Color:=clBlack;
      Label6d_1.Font.Color:=clBlack;
      Label6d_2.Font.Color:=clBlack;
end;

procedure TZp1Dlg.NoRB22_3Click(Sender: TObject);
begin
      Label22a.Font.Color:=clGray;
      Label22a_1.Font.Color:=clGray;
      ComboBox22a_2.Enabled:=FALSE;
      Label22a_3.Font.Color:=clGray;
      NumEdit22a_4.Enabled:=FALSE;
      Label22a_5.Font.Color:=clGray;
      Label22a_6.Font.Color:=clGray;
      Label22a_7.Font.Color:=clGray;
      Memo22a_8.Enabled:=FALSE;
      Label22b.Font.Color:=clGray;
      Label22b_1.Font.Color:=clGray;
      DateEdit22b_2.Enabled:=FALSE;
      Label22b_3.Font.Color:=clGray;
      Label22b_4.Font.Color:=clGray;
      Memo22b_5.Enabled:=FALSE;
end;

procedure TZp1Dlg.YesRB22_2Click(Sender: TObject);
begin
  Label22a.Font.Color:=clBlack;
  Label22a_1.Font.Color:=clBlack;
  ComboBox22a_2.Enabled:=TRUE;
  Label22a_3.Font.Color:=clBlack;
  NumEdit22a_4.Enabled:=TRUE;
  Label22a_5.Font.Color:=clBlack;
  Label22a_6.Font.Color:=clBlack;
  Label22a_7.Font.Color:=clBlack;
  Memo22a_8.Enabled:=TRUE;
  Label22b.Font.Color:=clBlack;
  Label22b_1.Font.Color:=clBlack;
  DateEdit22b_2.Enabled:=TRUE;
  Label22b_3.Font.Color:=clBlack;
  Label22b_4.Font.Color:=clBlack;
  Memo22b_5.Enabled:=TRUE;
end;

procedure TZp1Dlg.AddBtnClick(Sender: TObject);
begin
  Grid7b_2.InsertRow(Grid7b_2.RowCount);
end;

procedure TZp1Dlg.InsertBtnClick(Sender: TObject);
begin
  Grid7b_2.InsertRow(Grid7b_2.Row);
end;

procedure TZp1Dlg.DelBtnClick(Sender: TObject);
begin
  Grid7b_2.DeleteRow(Grid7b_2.Row);
  if Grid7b_2.RowCount<2
    then Grid7b_2.InsertRow(Grid7b_2.RowCount);
end;

procedure TZp1Dlg.G20AddBtnClick(Sender: TObject);
begin
  Grid20_3.InsertCol(Grid20_3.ColCount);
end;

procedure TZp1Dlg.G20InsBtnClick(Sender: TObject);
begin
  Grid20_3.InsertCol(Grid20_3.Col);
end;

procedure TZp1Dlg.G20DelBtnClick(Sender: TObject);
begin
  Grid20_3.DeleteCol(Grid20_3.Col);
  if Grid20_3.ColCount<2
    then Grid20_3.InsertCol(Grid20_3.ColCount);
end;

procedure TZp1Dlg.Edit9_10KeyPress(Sender: TObject; var Key: Char);
begin
  if not (Key in [' ','0'..'9',Chr(VK_BACK)])
    then Key:=#0; 
end;

procedure TZp1Dlg.ResetBtn6Click(Sender: TObject);
begin
  YesRB6Click(Sender);
  YesRB6_2.Checked:=FALSE;
  NoRB6_3.Checked:=FALSE;
end;

procedure TZp1Dlg.ResetBtn13Click(Sender: TObject);
begin
  YesRb13_3.Checked:=FALSE;
  NoRb13_4.Checked:=FALSE;
end;

procedure TZp1Dlg.ResetRB14Click(Sender: TObject);
begin
  YesRb14_3.Checked:=FALSE;
  NoRb14_4.Checked:=FALSE;
end;

procedure TZp1Dlg.ResetRB15Click(Sender: TObject);
begin
  YesRb15_2.Checked:=FALSE;
  NoRb15_3.Checked:=FALSE;
end;

procedure TZp1Dlg.ResetRB16Click(Sender: TObject);
begin
  YesRb16_2.Checked:=FALSE;
  NoRb16_3.Checked:=FALSE;
end;

procedure TZp1Dlg.ResetRB21Click(Sender: TObject);
begin
  YesRb21_2.Checked:=FALSE;
  NoRb21_3.Checked:=FALSE;
end;

procedure TZp1Dlg.ResetBtn22Click(Sender: TObject);
begin
  YesRb22_2Click(Sender);
  YesRb22_2.Checked:=FALSE;
  NoRb22_3.Checked:=FALSE;
end;

procedure TZp1Dlg.ResetBtn23Click(Sender: TObject);
begin
  YesRb23_3.Checked:=FALSE;
  NoRb23_4.Checked:=FALSE;
end;

procedure TZp1Dlg.ResetBtn24Click(Sender: TObject);
begin
  YesRb24_3.Checked:=FALSE;
  NoRb24_4.Checked:=FALSE;
end;

end.

