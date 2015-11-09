unit Mainmenu;

interface

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, StdCtrls, Buttons, Menus, SiwzIni, ExtCtrls;

type
  EDLLLoadError = class(Exception);

  TMainDlg = class(TForm)
    TrbZamBtn: TBitBtn;
    PrzNieOgrBtn: TBitBtn;
    PrzOgrBtn: TBitBtn;
    PrzDwuBtn: TBitBtn;
    NegKonBtn: TBitBtn;
    ZapCeneBtn: TBitBtn;
    ZamWlnRekiBtn: TBitBtn;
    MainMenu: TMainMenu;
    HelpMenu: TMenuItem;
    About: TMenuItem;
    Ustawa1: TMenuItem;
    Zbir1: TMenuItem;
    Koniec1: TMenuItem;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Opcje1: TMenuItem;
    Administrator1: TMenuItem;
    Bazydanych1: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure AboutClick(Sender: TObject);
    procedure Ustawa1Click(Sender: TObject);
    procedure Koniec1Click(Sender: TObject);
    procedure Administrator1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    PLNAmount:Real;
    OrderKind:Integer;
    Tryb:Integer;
  end;

var
  MainDlg: TMainDlg;

implementation

{$R *.DFM}

uses
  Msg2,
  Utils,
  About,
  S2xScri;

procedure TMainDlg.FormCreate(Sender: TObject);
begin
  GetWindowsDir;
  GetAllConfiguration;
  Application.HelpFile:=HelpFileIni;
end;

procedure TMainDlg.Ustawa1Click(Sender: TObject);
begin
  Application.HelpJump('SIWZ');
end;

procedure TMainDlg.Koniec1Click(Sender: TObject);
begin
  Close;
end;

procedure TMainDlg.AboutClick(Sender: TObject);
begin
  AboutBox.ShowModal;
end;

procedure TMainDlg.Administrator1Click(Sender: TObject);
begin
  {}
end;

end.
