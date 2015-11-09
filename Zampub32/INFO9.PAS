unit Info9;

interface

uses WinTypes, WinProcs, Classes, Graphics, Forms, Controls, Buttons,
  StdCtrls, ExtCtrls, Lbtab, TabNotBk, SysUtils, Messages, Dialogs,
  SiwzIni;

const
  Info9MaxPages=20;

  Info9FileHdr='INFO9';

  s9Room='pokój nr.';
  s9Tel='telefon';

type
  TInfo9Dlg = class(TForm)
    Bevel1: TBevel;
    OKBtn: TBitBtn;
    CancelBtn: TBitBtn;
    HelpBtn: TBitBtn;
    DelButton: TButton;
    SaveButton: TButton;
    TabbedNotebook: TTabbedNotebook;
    NameEdit19: TEdit;
    NameLabel19: TLabel;
    PosEdit19: TEdit;
    RoomEdit19: TEdit;
    TelEdit19: TEdit;
    PosLabel19: TLabel;
    RoomLabel19: TLabel;
    TelLabel19: TLabel;
    NameEdit20: TEdit;
    PosEdit20: TEdit;
    RoomEdit20: TEdit;
    TelEdit20: TEdit;
    NameLabel20: TLabel;
    PosLabel20: TLabel;
    RoomLabel20: TLabel;
    TelLabel20: TLabel;
    NameEdit18: TEdit;
    PosEdit18: TEdit;
    RoomEdit18: TEdit;
    TelEdit18: TEdit;
    NameLabel18: TLabel;
    PosLabel18: TLabel;
    RoomLabel18: TLabel;
    TelLabel18: TLabel;
    NameEdit17: TEdit;
    RoomEdit17: TEdit;
    TelEdit17: TEdit;
    NameLabel17: TLabel;
    PosLabel17: TLabel;
    RoomLabel17: TLabel;
    TelLabel17: TLabel;
    PosEdit17: TEdit;
    NameEdit16: TEdit;
    PosEdit16: TEdit;
    RoomEdit16: TEdit;
    TelEdit16: TEdit;
    NameLabel16: TLabel;
    PosLabel16: TLabel;
    RoomLabel16: TLabel;
    TelLabel16: TLabel;
    NameEdit1: TEdit;
    PosEdit1: TEdit;
    RoomEdit1: TEdit;
    TelEdit1: TEdit;
    NameLabel1: TLabel;
    PosLabel1: TLabel;
    RoomLabel: TLabel;
    TelLabel1: TLabel;
    NameEdit2: TEdit;
    PosEdit2: TEdit;
    RoomEdit2: TEdit;
    TelEdit2: TEdit;
    NameLabel2: TLabel;
    PosLabel2: TLabel;
    RoomLabel2: TLabel;
    TelLabel2: TLabel;
    NameEdit3: TEdit;
    PosEdit3: TEdit;
    RoomEdit3: TEdit;
    TelEdit3: TEdit;
    NameLabel3: TLabel;
    Label2: TLabel;
    RoomLabel3: TLabel;
    TelLabel3: TLabel;
    NameEdit4: TEdit;
    PosEdit4: TEdit;
    RoomEdit4: TEdit;
    TelEdit4: TEdit;
    NameLabel: TLabel;
    PosLabel: TLabel;
    Label1: TLabel;
    TelLabel: TLabel;
    NameEdit5: TEdit;
    PosEdit5: TEdit;
    RoomEdit5: TEdit;
    TelEdit5: TEdit;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    NameEdit6: TEdit;
    PosEdit6: TEdit;
    RoomEdit6: TEdit;
    TelEdit6: TEdit;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    NameEdit7: TEdit;
    PosEdit7: TEdit;
    RoomEdit7: TEdit;
    TelEdit7: TEdit;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    NameEdit8: TEdit;
    PosEdit8: TEdit;
    RoomEdit8: TEdit;
    TelEdit8: TEdit;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    NameEdit9: TEdit;
    PosEdit9: TEdit;
    RoomEdit9: TEdit;
    TelEdit9: TEdit;
    Label19: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    NameEdit10: TEdit;
    PosEdit10: TEdit;
    RoomEdit10: TEdit;
    TelEdit10: TEdit;
    Label23: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    Label26: TLabel;
    NameEdit11: TEdit;
    PosEdit11: TEdit;
    RoomEdit11: TEdit;
    TelEdit11: TEdit;
    Label27: TLabel;
    Label28: TLabel;
    Label29: TLabel;
    Label30: TLabel;
    NameEdit12: TEdit;
    PosEdit12: TEdit;
    RoomEdit12: TEdit;
    TelEdit12: TEdit;
    Label31: TLabel;
    Label32: TLabel;
    Label33: TLabel;
    Label34: TLabel;
    NameEdit13: TEdit;
    PosEdit13: TEdit;
    RoomEdit13: TEdit;
    TelEdit13: TEdit;
    Label35: TLabel;
    Label36: TLabel;
    Label37: TLabel;
    Label38: TLabel;
    NameEdit14: TEdit;
    PosEdit14: TEdit;
    RoomEdit14: TEdit;
    TelEdit14: TEdit;
    Label39: TLabel;
    Label40: TLabel;
    Label41: TLabel;
    Label42: TLabel;
    NameEdit15: TEdit;
    PosEdit15: TEdit;
    RoomEdit15: TEdit;
    TelEdit15: TEdit;
    Label43: TLabel;
    Label44: TLabel;
    Label45: TLabel;
    Label46: TLabel;
    DelAllButton: TButton;
    OpenButton: TButton;
    ChooseButton: TButton;
    SaveDialog: TSaveDialog;
    OpenDialog: TOpenDialog;
    procedure DelButtonClick(Sender: TObject);
    procedure SaveButtonClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ChooseButtonClick(Sender: TObject);
    procedure DelAllButtonClick(Sender: TObject);
    procedure HelpBtnClick(Sender: TObject);
    procedure KeyPress(Sender: TObject; var Key: Char);
    procedure OpenButtonClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    procedure SaveFile;
    procedure LoadFile;
    procedure DelPage1;
    procedure DelPage2;
    procedure DelPage3;
    procedure DelPage4;
    procedure DelPage5;
    procedure DelPage6;
    procedure DelPage7;
    procedure DelPage8;
    procedure DelPage9;
    procedure DelPage10;
    procedure DelPage11;
    procedure DelPage12;
    procedure DelPage13;
    procedure DelPage14;
    procedure DelPage15;
    procedure DelPage16;
    procedure DelPage17;
    procedure DelPage18;
    procedure DelPage19;
    procedure DelPage20;
  public
    { Public declarations }
    FileName:String;
    Kind:Integer;
    SelPages:Array[0..Info9MaxPages-1] of Boolean;
    function GetName(Page:Byte):String;
    function GetRoom(Page:Byte):String;
    function GetTel(Page:Byte):String;
  end;

var
  Info9Dlg: TInfo9Dlg;

implementation

{$R *.DFM}

uses
  Utils,
  Msg2;

procedure TInfo9Dlg.FormCreate(Sender: TObject);
begin
  TabbedNotebook.PageIndex:=0;
end;

procedure TInfo9Dlg.SaveButtonClick(Sender: TObject);
begin
  SaveDialog.DefaultExt:=OUExt;
  SaveDialog.InitialDir:=ProgramDir;
  SaveDialog.Filter:='osoby uprawnione|*.'+OUExt;
  if SaveDialog.Execute
    then begin
      FileName:=SaveDialog.FileName;
      SaveFile;
    end;
end;

procedure TInfo9Dlg.OpenButtonClick(Sender: TObject);
begin
  OpenDialog.DefaultExt:=OUExt;
  OpenDialog.InitialDir:=ProgramDir;
  OpenDialog.Filter:='osoby uprawnione|*.'+OUExt;
  if OpenDialog.Execute
    then begin
      FileName:=OpenDialog.FileName;
      LoadFile;
    end;
end;

procedure TInfo9Dlg.SaveFile;
var
  FHandle:File;
begin
  AssignFile(FHandle,FileName);
  FileMode:=fmOpenReadWrite + fmShareDenyWrite;
  try
    Rewrite(FHandle,1);
    try
      SaveString(Info9FileHdr,FHandle);
    {page 1}
      SaveEdit(NameEdit1,FHandle);
      SaveEdit(PosEdit1,FHandle);
      SaveEdit(RoomEdit1,FHandle);
      SaveEdit(TelEdit1,FHandle);
    {page 2}
      SaveEdit(NameEdit2,FHandle);
      SaveEdit(PosEdit2,FHandle);
      SaveEdit(RoomEdit2,FHandle);
      SaveEdit(TelEdit2,FHandle);
    {page 3}
      SaveEdit(NameEdit3,FHandle);
      SaveEdit(PosEdit3,FHandle);
      SaveEdit(RoomEdit3,FHandle);
      SaveEdit(TelEdit3,FHandle);
    {page 4}
      SaveEdit(NameEdit4,FHandle);
      SaveEdit(PosEdit4,FHandle);
      SaveEdit(RoomEdit4,FHandle);
      SaveEdit(TelEdit4,FHandle);
    {page 5}
      SaveEdit(NameEdit5,FHandle);
      SaveEdit(PosEdit5,FHandle);
      SaveEdit(RoomEdit5,FHandle);
      SaveEdit(TelEdit5,FHandle);
    {page 6}
      SaveEdit(NameEdit6,FHandle);
      SaveEdit(PosEdit6,FHandle);
      SaveEdit(RoomEdit6,FHandle);
      SaveEdit(TelEdit6,FHandle);
    {page 7}
      SaveEdit(NameEdit7,FHandle);
      SaveEdit(PosEdit7,FHandle);
      SaveEdit(RoomEdit7,FHandle);
      SaveEdit(TelEdit7,FHandle);
    {page 8}
      SaveEdit(NameEdit8,FHandle);
      SaveEdit(PosEdit8,FHandle);
      SaveEdit(RoomEdit8,FHandle);
      SaveEdit(TelEdit8,FHandle);
    {page 9}
      SaveEdit(NameEdit9,FHandle);
      SaveEdit(PosEdit9,FHandle);
      SaveEdit(RoomEdit9,FHandle);
      SaveEdit(TelEdit9,FHandle);
    {page 10}
      SaveEdit(NameEdit10,FHandle);
      SaveEdit(PosEdit10,FHandle);
      SaveEdit(RoomEdit10,FHandle);
      SaveEdit(TelEdit10,FHandle);
    {page 11}
      SaveEdit(NameEdit11,FHandle);
      SaveEdit(PosEdit11,FHandle);
      SaveEdit(RoomEdit11,FHandle);
      SaveEdit(TelEdit11,FHandle);
    {page 12}
      SaveEdit(NameEdit12,FHandle);
      SaveEdit(PosEdit12,FHandle);
      SaveEdit(RoomEdit12,FHandle);
      SaveEdit(TelEdit12,FHandle);
    {page 13}
      SaveEdit(NameEdit13,FHandle);
      SaveEdit(PosEdit13,FHandle);
      SaveEdit(RoomEdit13,FHandle);
      SaveEdit(TelEdit13,FHandle);
    {page 14}
      SaveEdit(NameEdit14,FHandle);
      SaveEdit(PosEdit14,FHandle);
      SaveEdit(RoomEdit14,FHandle);
      SaveEdit(TelEdit14,FHandle);
    {page 15}
      SaveEdit(NameEdit15,FHandle);
      SaveEdit(PosEdit15,FHandle);
      SaveEdit(RoomEdit15,FHandle);
      SaveEdit(TelEdit15,FHandle);
    {page 16}
      SaveEdit(NameEdit16,FHandle);
      SaveEdit(PosEdit16,FHandle);
      SaveEdit(RoomEdit16,FHandle);
      SaveEdit(TelEdit16,FHandle);
    {page 17}
      SaveEdit(NameEdit17,FHandle);
      SaveEdit(PosEdit17,FHandle);
      SaveEdit(RoomEdit17,FHandle);
      SaveEdit(TelEdit17,FHandle);
    {page 18}
      SaveEdit(NameEdit18,FHandle);
      SaveEdit(PosEdit18,FHandle);
      SaveEdit(RoomEdit18,FHandle);
      SaveEdit(TelEdit18,FHandle);
    {page 19}
      SaveEdit(NameEdit19,FHandle);
      SaveEdit(PosEdit19,FHandle);
      SaveEdit(RoomEdit19,FHandle);
      SaveEdit(TelEdit19,FHandle);
    {page 20}
      SaveEdit(NameEdit20,FHandle);
      SaveEdit(PosEdit20,FHandle);
      SaveEdit(RoomEdit20,FHandle);
      SaveEdit(TelEdit20,FHandle);
    finally
      CloseFile(FHandle);
    end;
  except
    on E:EInOutError do
      case E.ErrorCode of
        5: MessageDlg(wmFileAccessDenied ,mtWarning ,[mbOk] ,0);
        else MessageDlg(IntToStr(E.ErrorCode),mtWarning,[mbOk],0);
      end;
  end;
end;

procedure TInfo9Dlg.LoadFile;
var
  FHandle:File;
  s:String[10];
begin
  AssignFile(FHandle,FileName);
  FileMode:=fmOpenReadWrite + fmShareDenyWrite;
  try
    Reset(FHandle,1);
    try
      LoadString(s,FHandle);
      if s=Info9FileHdr
        then begin
        {page 1}
          LoadEdit(NameEdit1,FHandle);
          LoadEdit(PosEdit1,FHandle);
          LoadEdit(RoomEdit1,FHandle);
          LoadEdit(TelEdit1,FHandle);
        {page 2}
          LoadEdit(NameEdit2,FHandle);
          LoadEdit(PosEdit2,FHandle);
          LoadEdit(RoomEdit2,FHandle);
          LoadEdit(TelEdit2,FHandle);
        {page 3}
          LoadEdit(NameEdit3,FHandle);
          LoadEdit(PosEdit3,FHandle);
          LoadEdit(RoomEdit3,FHandle);
          LoadEdit(TelEdit3,FHandle);
        {page 4}
          LoadEdit(NameEdit4,FHandle);
          LoadEdit(PosEdit4,FHandle);
          LoadEdit(RoomEdit4,FHandle);
          LoadEdit(TelEdit4,FHandle);
        {page 5}
          LoadEdit(NameEdit5,FHandle);
          LoadEdit(PosEdit5,FHandle);
          LoadEdit(RoomEdit5,FHandle);
          LoadEdit(TelEdit5,FHandle);
        {page 6}
          LoadEdit(NameEdit6,FHandle);
          LoadEdit(PosEdit6,FHandle);
          LoadEdit(RoomEdit6,FHandle);
          LoadEdit(TelEdit6,FHandle);
        {page 7}
          LoadEdit(NameEdit7,FHandle);
          LoadEdit(PosEdit7,FHandle);
          LoadEdit(RoomEdit7,FHandle);
          LoadEdit(TelEdit7,FHandle);
        {page 8}
          LoadEdit(NameEdit8,FHandle);
          LoadEdit(PosEdit8,FHandle);
          LoadEdit(RoomEdit8,FHandle);
          LoadEdit(TelEdit8,FHandle);
        {page 9}
          LoadEdit(NameEdit9,FHandle);
          LoadEdit(PosEdit9,FHandle);
          LoadEdit(RoomEdit9,FHandle);
          LoadEdit(TelEdit9,FHandle);
        {page 10}
          LoadEdit(NameEdit10,FHandle);
          LoadEdit(PosEdit10,FHandle);
          LoadEdit(RoomEdit10,FHandle);
          LoadEdit(TelEdit10,FHandle);
        {page 11}
          LoadEdit(NameEdit11,FHandle);
          LoadEdit(PosEdit11,FHandle);
          LoadEdit(RoomEdit11,FHandle);
          LoadEdit(TelEdit11,FHandle);
        {page 12}
          LoadEdit(NameEdit12,FHandle);
          LoadEdit(PosEdit12,FHandle);
          LoadEdit(RoomEdit12,FHandle);
          LoadEdit(TelEdit12,FHandle);
        {page 13}
          LoadEdit(NameEdit13,FHandle);
          LoadEdit(PosEdit13,FHandle);
          LoadEdit(RoomEdit13,FHandle);
          LoadEdit(TelEdit13,FHandle);
        {page 14}
          LoadEdit(NameEdit14,FHandle);
          LoadEdit(PosEdit14,FHandle);
          LoadEdit(RoomEdit14,FHandle);
          LoadEdit(TelEdit14,FHandle);
        {page 15}
          LoadEdit(NameEdit15,FHandle);
          LoadEdit(PosEdit15,FHandle);
          LoadEdit(RoomEdit15,FHandle);
          LoadEdit(TelEdit15,FHandle);
        {page 16}
          LoadEdit(NameEdit16,FHandle);
          LoadEdit(PosEdit16,FHandle);
          LoadEdit(RoomEdit16,FHandle);
          LoadEdit(TelEdit16,FHandle);
        {page 17}
          LoadEdit(NameEdit17,FHandle);
          LoadEdit(PosEdit17,FHandle);
          LoadEdit(RoomEdit17,FHandle);
          LoadEdit(TelEdit17,FHandle);
        {page 18}
          LoadEdit(NameEdit18,FHandle);
          LoadEdit(PosEdit18,FHandle);
          LoadEdit(RoomEdit18,FHandle);
          LoadEdit(TelEdit18,FHandle);
        {page 19}
          LoadEdit(NameEdit19,FHandle);
          LoadEdit(PosEdit19,FHandle);
          LoadEdit(RoomEdit19,FHandle);
          LoadEdit(TelEdit19,FHandle);
        {page 20}
          LoadEdit(NameEdit20,FHandle);
          LoadEdit(PosEdit20,FHandle);
          LoadEdit(RoomEdit20,FHandle);
          LoadEdit(TelEdit20,FHandle);
        end;
    finally
      CloseFile(FHandle);
    end;
  except
    on E:EInOutError do
      begin
        case E.ErrorCode of
          5: MessageDlg(wmFileAccessDenied ,mtWarning ,[mbOk] ,0);
          100: MessageDlg(wmReadBeyondEnd ,mtWarning ,[mbOk] ,0);
          else MessageDlg(IntToStr(E.ErrorCode),mtWarning,[mbOk],0);
        end;{case}
      end;
  end;
end;

procedure TInfo9Dlg.DelPage1;
begin
  NameEdit1.Text:='';
  PosEdit1.Text:='';
  RoomEdit1.Text:='';
  TelEdit1.Text:='';
  TabbedNotebook.Pages[0]:=IntToStr(1);
  SelPages[0]:=FALSE;
end;

procedure TInfo9Dlg.DelPage2;
begin
  NameEdit2.Text:='';
  PosEdit2.Text:='';
  RoomEdit2.Text:='';
  TelEdit2.Text:='';
  TabbedNotebook.Pages[1]:=IntToStr(2);
  SelPages[1]:=FALSE;
end;

procedure TInfo9Dlg.DelPage3;
begin
  NameEdit3.Text:='';
  PosEdit3.Text:='';
  RoomEdit3.Text:='';
  TelEdit3.Text:='';
  TabbedNotebook.Pages[2]:=IntToStr(3);
  SelPages[2]:=FALSE;
end;

procedure TInfo9Dlg.DelPage4;
begin
  NameEdit4.Text:='';
  PosEdit4.Text:='';
  RoomEdit4.Text:='';
  TelEdit4.Text:='';
  TabbedNotebook.Pages[3]:=IntToStr(4);
  SelPages[3]:=FALSE;
end;

procedure TInfo9Dlg.DelPage5;
begin
  NameEdit5.Text:='';
  PosEdit5.Text:='';
  RoomEdit5.Text:='';
  TelEdit5.Text:='';
  TabbedNotebook.Pages[4]:=IntToStr(5);
  SelPages[4]:=FALSE;
end;

procedure TInfo9Dlg.DelPage6;
begin
  NameEdit6.Text:='';
  PosEdit6.Text:='';
  RoomEdit6.Text:='';
  TelEdit6.Text:='';
  TabbedNotebook.Pages[5]:=IntToStr(6);
  SelPages[5]:=FALSE;
end;

procedure TInfo9Dlg.DelPage7;
begin
  NameEdit7.Text:='';
  PosEdit7.Text:='';
  RoomEdit7.Text:='';
  TelEdit7.Text:='';
  TabbedNotebook.Pages[6]:=IntToStr(7);
  SelPages[6]:=FALSE;
end;

procedure TInfo9Dlg.DelPage8;
begin
  NameEdit8.Text:='';
  PosEdit8.Text:='';
  RoomEdit8.Text:='';
  TelEdit8.Text:='';
  TabbedNotebook.Pages[7]:=IntToStr(8);
  SelPages[7]:=FALSE;
end;

procedure TInfo9Dlg.DelPage9;
begin
  NameEdit9.Text:='';
  PosEdit9.Text:='';
  RoomEdit9.Text:='';
  TelEdit9.Text:='';
  TabbedNotebook.Pages[8]:=IntToStr(9);
  SelPages[8]:=FALSE;
end;

procedure TInfo9Dlg.DelPage10;
begin
  NameEdit10.Text:='';
  PosEdit10.Text:='';
  RoomEdit10.Text:='';
  TelEdit10.Text:='';
  TabbedNotebook.Pages[9]:=IntToStr(10);
  SelPages[9]:=FALSE;
end;

procedure TInfo9Dlg.DelPage11;
begin
  NameEdit11.Text:='';
  PosEdit11.Text:='';
  RoomEdit11.Text:='';
  TelEdit11.Text:='';
  TabbedNotebook.Pages[10]:=IntToStr(11);
  SelPages[10]:=FALSE;
end;

procedure TInfo9Dlg.DelPage12;
begin
  NameEdit12.Text:='';
  PosEdit12.Text:='';
  RoomEdit12.Text:='';
  TelEdit12.Text:='';
  TabbedNotebook.Pages[11]:=IntToStr(12);
  SelPages[11]:=FALSE;
end;

procedure TInfo9Dlg.DelPage13;
begin
  NameEdit13.Text:='';
  PosEdit13.Text:='';
  RoomEdit13.Text:='';
  TelEdit13.Text:='';
  TabbedNotebook.Pages[12]:=IntToStr(13);
  SelPages[12]:=FALSE;
end;

procedure TInfo9Dlg.DelPage14;
begin
  NameEdit14.Text:='';
  PosEdit14.Text:='';
  RoomEdit14.Text:='';
  TelEdit14.Text:='';
  TabbedNotebook.Pages[13]:=IntToStr(14);
  SelPages[13]:=FALSE;
end;

procedure TInfo9Dlg.DelPage15;
begin
  NameEdit15.Text:='';
  PosEdit15.Text:='';
  RoomEdit15.Text:='';
  TelEdit15.Text:='';
  TabbedNotebook.Pages[14]:=IntToStr(15);
  SelPages[14]:=FALSE;
end;

procedure TInfo9Dlg.DelPage16;
begin
  NameEdit16.Text:='';
  PosEdit16.Text:='';
  RoomEdit16.Text:='';
  TelEdit16.Text:='';
  TabbedNotebook.Pages[15]:=IntToStr(16);
  SelPages[15]:=FALSE;
end;

procedure TInfo9Dlg.DelPage17;
begin
  NameEdit17.Text:='';
  PosEdit17.Text:='';
  RoomEdit17.Text:='';
  TelEdit17.Text:='';
  TabbedNotebook.Pages[16]:=IntToStr(17);
  SelPages[16]:=FALSE;
end;

procedure TInfo9Dlg.DelPage18;
begin
  NameEdit18.Text:='';
  PosEdit18.Text:='';
  RoomEdit18.Text:='';
  TelEdit18.Text:='';
  TabbedNotebook.Pages[17]:=IntToStr(18);
  SelPages[17]:=FALSE;
end;

procedure TInfo9Dlg.DelPage19;
begin
  NameEdit19.Text:='';
  PosEdit19.Text:='';
  RoomEdit19.Text:='';
  TelEdit19.Text:='';
  TabbedNotebook.Pages[18]:=IntToStr(19);
  SelPages[18]:=FALSE;
end;

procedure TInfo9Dlg.DelPage20;
begin
  NameEdit20.Text:='';
  PosEdit20.Text:='';
  RoomEdit20.Text:='';
  TelEdit20.Text:='';
  TabbedNotebook.Pages[19]:=IntToStr(20);
  SelPages[19]:=FALSE;
end;

procedure TInfo9Dlg.DelButtonClick(Sender: TObject);
begin
  case TabbedNotebook.PageIndex of
    0: DelPage1;
    1: DelPage2;
    2: DelPage3;
    3: DelPage4;
    4: DelPage5;
    5: DelPage6;
    6: DelPage7;
    7: DelPage8;
    8: DelPage9;
    9: DelPage10;
    10: DelPage11;
    11: DelPage12;
    12: DelPage13;
    13: DelPage14;
    14: DelPage15;
    15: DelPage16;
    16: DelPage17;
    17: DelPage18;
    18: DelPage19;
    19: DelPage20;
  end;{case}
end;

procedure TInfo9Dlg.DelAllButtonClick(Sender: TObject);
var
  i:Byte;
begin
  DelPage1;
  DelPage2;
  DelPage3;
  DelPage4;
  DelPage5;
  DelPage6;
  DelPage7;
  DelPage8;
  DelPage9;
  DelPage10;
  DelPage11;
  DelPage12;
  DelPage13;
  DelPage14;
  DelPage15;
  DelPage16;
  DelPage17;
  DelPage18;
  DelPage19;
  DelPage20;
end;

procedure TInfo9Dlg.ChooseButtonClick(Sender: TObject);
begin
  with TabbedNotebook do
    begin
      if SelPages[PageIndex]=TRUE
        then begin
          Pages[PageIndex]:=Copy(ActivePage,3,Length(ActivePage)-2);
          SelPages[PageIndex]:=FALSE;
        end
      else begin
{controllare se la pagina non e` vuota}
          Pages[PageIndex]:=SelectionChar+' '+ActivePage;
          SelPages[PageIndex]:=TRUE;
        end;
    end;
end;

function TInfo9Dlg.GetName(Page:Byte):String;
begin
  case Page of
    0: GetName:=NameEdit1.Text;
    1: GetName:=NameEdit2.Text;
    2: GetName:=NameEdit3.Text;
    3: GetName:=NameEdit4.Text;
    4: GetName:=NameEdit5.Text;
    5: GetName:=NameEdit6.Text;
    6: GetName:=NameEdit7.Text;
    7: GetName:=NameEdit8.Text;
    8: GetName:=NameEdit9.Text;
    9: GetName:=NameEdit10.Text;
    10: GetName:=NameEdit11.Text;
    11: GetName:=NameEdit12.Text;
    12: GetName:=NameEdit13.Text;
    13: GetName:=NameEdit14.Text;
    14: GetName:=NameEdit15.Text;
    15: GetName:=NameEdit16.Text;
    16: GetName:=NameEdit17.Text;
    17: GetName:=NameEdit18.Text;
    18: GetName:=NameEdit19.Text;
    19: GetName:=NameEdit20.Text;
  end; {case}
end;

function TInfo9Dlg.GetRoom(Page:Byte):String;
begin
  case Page of
    0: GetRoom:=RoomEdit1.Text;
    1: GetRoom:=RoomEdit2.Text;
    2: GetRoom:=RoomEdit3.Text;
    3: GetRoom:=RoomEdit4.Text;
    4: GetRoom:=RoomEdit5.Text;
    5: GetRoom:=RoomEdit6.Text;
    6: GetRoom:=RoomEdit7.Text;
    7: GetRoom:=RoomEdit8.Text;
    8: GetRoom:=RoomEdit9.Text;
    9: GetRoom:=RoomEdit10.Text;
    10: GetRoom:=RoomEdit11.Text;
    11: GetRoom:=RoomEdit12.Text;
    12: GetRoom:=RoomEdit13.Text;
    13: GetRoom:=RoomEdit14.Text;
    14: GetRoom:=RoomEdit15.Text;
    15: GetRoom:=RoomEdit16.Text;
    16: GetRoom:=RoomEdit17.Text;
    17: GetRoom:=RoomEdit18.Text;
    18: GetRoom:=RoomEdit19.Text;
    19: GetRoom:=RoomEdit20.Text;
  end; {case}
end;

function TInfo9Dlg.GetTel(Page:Byte):String;
begin
  case Page of
    0: GetTel:=TelEdit1.Text;
    1: GetTel:=TelEdit2.Text;
    2: GetTel:=TelEdit3.Text;
    3: GetTel:=TelEdit4.Text;
    4: GetTel:=TelEdit5.Text;
    5: GetTel:=TelEdit6.Text;
    6: GetTel:=TelEdit7.Text;
    7: GetTel:=TelEdit8.Text;
    8: GetTel:=TelEdit9.Text;
    9: GetTel:=TelEdit10.Text;
    10: GetTel:=TelEdit11.Text;
    11: GetTel:=TelEdit12.Text;
    12: GetTel:=TelEdit13.Text;
    13: GetTel:=TelEdit14.Text;
    14: GetTel:=TelEdit15.Text;
    15: GetTel:=TelEdit16.Text;
    16: GetTel:=TelEdit17.Text;
    17: GetTel:=TelEdit18.Text;
    18: GetTel:=TelEdit19.Text;
    19: GetTel:=TelEdit20.Text;
  end; {case}
end;

procedure TInfo9Dlg.HelpBtnClick(Sender: TObject);
begin
  Application.HelpContext(2009);
end;

procedure TInfo9Dlg.KeyPress(Sender: TObject; var Key: Char);
begin
  if Key=Chr(13)
    then Key:=Chr(0);
end;

procedure TInfo9Dlg.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key=#13
    then begin
      Key:=#0;
      Perform(wm_NextDlgCtl,0,0);
    end;
end;

end.
