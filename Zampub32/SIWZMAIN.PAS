unit Siwzmain;

interface

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, StdCtrls, Buttons, Menus,  ExtCtrls,
  InfoDlg,
  ChgPwd,
  SkOk,
  PrefKraj,
  SiwzIni, Sk;

const
  sZPrefKraj='z zastosowaniem pref. kraj.';
  sBezPrefKraj='bez zastosowania pref. kraj.';

type
  EDLLLoadError = class(Exception);

  TMainDlg = class(TForm)
    TrbZamBtn: TBitBtn;
    MainMenu: TMainMenu;
    HelpMenu: TMenuItem;
    About: TMenuItem;
    Ustawa1: TMenuItem;
    Zbir1: TMenuItem;
    Opcje1: TMenuItem;
    Haso1: TMenuItem;
    UstawaBtn: TBitBtn;
    GroupBox1: TGroupBox;
    NieRB: TRadioButton;
    OgrRB: TRadioButton;
    DwuRB: TRadioButton;
    NegRb: TRadioButton;
    ZapRB: TRadioButton;
    ZamRB: TRadioButton;
    NewBtn: TBitBtn;
    OpenBtn: TBitBtn;
    Bevel1: TBevel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    OpenDialog: TOpenDialog;
    BitBtn3: TBitBtn;
    Label5: TLabel;
    Label6: TLabel;
    Sufler1: TMenuItem;
    Sk: TSmartKey;
    procedure FormCreate(Sender: TObject);
    procedure AboutClick(Sender: TObject);
    procedure Ustawa1Click(Sender: TObject);
    procedure Koniec1Click(Sender: TObject);
    procedure TrbZamBtnClick(Sender: TObject);
    procedure Zbir1Click(Sender: TObject);
    procedure Haso1Click(Sender: TObject);
    procedure OpenBtnClick(Sender: TObject);
    procedure NewBtnClick(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure TrybClick(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
    procedure ResetValues;
    procedure SetAmount;
    procedure SetKind;
  public
    { Public declarations }
    UserName:String;
    UserPwd:String;
    UserType:Byte;
    UserRights:Byte;
    AmountLevel:Integer;
    PLNAmount:Real;
    OrderKind:Integer;
    Tryb:Integer;
    PrefKraj:Boolean;
  end;

var
  MainDlg: TMainDlg;
  FileName:String;

implementation

{$R *.DFM}

uses
  Msg2,
  Utils,
  About,
  Prt1,
{$IFNDEF DEMO}
  Prt2,
  Prt3,
  Prt4,
  Prt5,
{$ENDIF}
  UserUnit,
  WybTryb,
  Amount,
  TypZam;

procedure TMainDlg.ResetValues;
begin
  AmountLevel:=-1;
  PLNAmount:=-1;
  OrderKind:=-1;
end;

procedure TMainDlg.FormCreate(Sender: TObject);
var
  s:String;
begin
  GetWindowsDir;
  GetAllConfiguration;
  Application.HelpFile:=SiwzHelpFile;
  ResetValues;
  NewBtn.Enabled:=FALSE;
  OpenBtn.Enabled:=FALSE;
  Label2.Caption:='';
  Label4.Caption:='';
  PrefKraj:=TRUE;
  Label6.Caption:=sZPrefKraj;
end;

procedure TMainDlg.Ustawa1Click(Sender: TObject);
begin
{  Application.HelpContext(2100);}
  Application.HelpJump('SIWZ');
end;

procedure TMainDlg.Koniec1Click(Sender: TObject);
begin
  Close;
end;

procedure TMainDlg.AboutClick(Sender: TObject);
begin
  AboutBox:=TAboutBox.Create(MainDlg);
  AboutBox.ShowModal;
  AboutBox.Free;
end;

procedure TMainDlg.TrbZamBtnClick(Sender: TObject);
begin
  if PLNAmount<0
    then GetPLNAmount(PLNAmount,AmountLevel);
  if PLNAmount>-1
    then begin
      if OrderKind<0
        then OrderKind:=GetTypZamowienia(TRUE);
      if OrderKind>-1
        then begin
          Tryb:=WybTrybu(AmountLevel);
          NieRB.Checked:=Tryb=wtNie;
          OgrRB.Checked:=Tryb=wtOgr;
       {$IFNDEF DEMO}
          DwuRB.Checked:=Tryb=wtDwu;
          NegRB.Checked:=Tryb=wtNeg;
          ZapRB.Checked:=Tryb=wtZap;
          ZamRB.Checked:=Tryb=wtZam;
       {$ENDIF}
(*          NieRB.Checked:=Tryb=iNieograniczony;
          OgrRB.Checked:=Tryb=iOgraniczony;
       {$IFNDEF DEMO}
          DwuRB.Checked:=Tryb=iDwustopniowy;
          NegRB.Checked:=Tryb=iNegocjacje;
          ZapRB.Checked:=Tryb=iZapytanieOCene;
          ZamRB.Checked:=Tryb=iZamowienieWR;
       {$ENDIF}*)
        end;
    end;
end;

procedure TMainDlg.Zbir1Click(Sender: TObject);
begin
  if MessageDlg(cmClosePrg,mtConfirmation,[mbOk,mbCancel],0)=mrOk
    then Close;
end;

procedure TMainDlg.Haso1Click(Sender: TObject);
begin
{$IFDEF DEMO}
  MessageDlg('Nie dostêpne w wersji DEMO',mtInformation,[mbOk],0);
{$ELSE}
  ChangePwd(UserName);
{$ENDIF}
end;

procedure TMainDlg.OpenBtnClick(Sender: TObject);
begin
  with OpenDialog do
    begin
      if NieRb.Checked
        then Filter:='Prz. nieograniczony|*.'+NieExt
      else if OgrRb.Checked
        then Filter:='Prz. ograniczony|*.'+OgrExt
      else if DwuRb.Checked
        then Filter:='Prz. duwstopniowy|*.'+DwuExt
      else if NegRb.Checked
        then Filter:='Neg. z zach. konk.|*.'+NegExt
      else if ZapRb.Checked
        then Filter:='Zapytanie o cenê|*.'+ZapExt
      else if ZamRb.Checked
        then Filter:='Zam. z wolnej rêki|*.'+ZamExt;
      if Execute
        then begin
          if NieRB.Checked
            then Przetarg1(FileName,ttNie,PLNAmount,AmountLevel,OrderKind,PrefKraj)
          else if OgrRB.Checked
            then Przetarg1(FileName,ttOgr,PLNAmount,AmountLevel,OrderKind,PrefKraj)
         {$IFNDEF DEMO}
          else if DwuRB.Checked
            then Przetarg2(FileName,ttDwu,PLNAmount,AmountLevel,OrderKind,PrefKraj)
          else if NegRB.Checked
            then Przetarg4(FileName,ttNeg,PLNAmount,AmountLevel,OrderKind,PrefKraj)
          else if ZapRB.Checked
            then Przetarg3(FileName,ttZap,PLNAmount,AmountLevel,OrderKind,PrefKraj)
          else if ZamRB.Checked
            then Przetarg5(FileName,ttZam,PLNAmount,AmountLevel,OrderKind,PrefKraj)
          {$ENDIF}
        end;
    end;

end;

procedure TMainDlg.NewBtnClick(Sender: TObject);
begin
  if PLNAmount=-1
    then SetAmount;
  if PLNAmount>-1
    then begin
      if OrderKind=-1
        then SetKind;
      if OrderKind>-1
        then begin
          if NieRB.Checked
            then Przetarg1('',ttNie,PLNAmount,AmountLevel,OrderKind,PrefKraj)
          else if OgrRB.Checked
            then Przetarg1('',ttOgr,PLNAmount,AmountLevel,OrderKind,PrefKraj)
         {$IFNDEF DEMO}
          else if DwuRB.Checked
            then Przetarg2('',ttDwu,PLNAmount,AmountLevel,OrderKind,PrefKraj)
          else if NegRB.Checked
            then Przetarg4('',ttNeg,PLNAmount,AmountLevel,OrderKind,PrefKraj)
          else if ZapRB.Checked
            then Przetarg3('',ttZap,PLNAmount,AmountLevel,OrderKind,PrefKraj)
          else if ZamRB.Checked
            then Przetarg5('',ttZam,PLNAmount,AmountLevel,OrderKind,PrefKraj)
          {$ENDIF}
        end;
      end;
end;

procedure TMainDlg.BitBtn1Click(Sender: TObject);
begin
  SetAmount;
end;

procedure TMainDlg.BitBtn2Click(Sender: TObject);
begin
  SetKind;
end;

procedure TMainDlg.TrybClick(Sender: TObject);
begin
  NewBtn.Enabled:=TRUE;
  OpenBtn.Enabled:=TRUE;
end;

procedure TMainDlg.SetAmount;
var
  x:Extended;
  y:Real;
begin
  GetPLNAmount(y,AmountLevel);
  if y>0
    then PLNAmount:=y;
  if PLNAmount>=0
    then begin
      x:=PLNAmount;
      Label2.Caption:=FloatToStrF(x,ffCurrency,15,2);
    end
    else Label2.Caption:='';
end;

procedure TMainDlg.SetKind;
var
  x:Extended;
  i:Integer;
begin
  i:=GetTypZamowienia(not ZapRB.Checked);
  if i>-1
    then OrderKind:=i;
  ZapRB.Enabled:=TRUE;
  case OrderKind of
    okDostawa:Label4.Caption:='Dostawa';
    okUslugi:Label4.Caption:='Us³ugi';
    okRobBud:begin
               Label4.Caption:='Roboty budowlane';
               ZapRB.Enabled:=FALSE;
             end;
    else Label4.Caption:='';
  end;{case}
end;

procedure TMainDlg.BitBtn3Click(Sender: TObject);
begin
  PrefKrajoweDlg:=TPrefKrajoweDlg.Create(Self);
  with PrefKrajoweDlg do
    begin
      if PrefKraj
        then PKGroup.ItemIndex:=0
        else PKGroup.ItemIndex:=1;
      if ShowModal=mrOk
        then begin
          PrefKraj:=PKGroup.ItemIndex=0;
          if PrefKraj
            then Label6.Caption:=sZPrefKraj
            else begin
              MessageDlg(wmGetPermit,mtWarning,[mbOk],0);
              Label6.Caption:=sBezPrefKraj;
            end;
        end;
      Free;
    end;

end;

procedure TMainDlg.FormActivate(Sender: TObject);
begin
{$IFDEF DEMO}
  NieRB.Enabled:=TRUE;
  OgrRB.Enabled:=TRUE;
  DwuRB.Enabled:=FALSE;
  NegRB.Enabled:=FALSE;
  ZapRB.Enabled:=FALSE;
  ZamRB.Enabled:=FALSE;
{$ELSE}
{$IFDEF NONET}
  if not SmartKeyOk(Sk,SkData)
    then Close;
{$ENDIF}
  NieRB.Enabled:=(UserRights and tNie)=tNie;
  OgrRB.Enabled:=(UserRights and tOgr)=tOgr;
  DwuRB.Enabled:=(UserRights and tDwu)=tDwu;
  NegRB.Enabled:=(UserRights and tNeg)=tNeg;
  ZapRB.Enabled:=(UserRights and tZap)=tZap;
  ZamRB.Enabled:=(UserRights and tZam)=tZam;
{$ENDIF}

end;

end.
