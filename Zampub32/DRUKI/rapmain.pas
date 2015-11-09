unit Rapmain;

interface

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, ExtCtrls, StdCtrls, Buttons,
  ZpBoxes,
  RegPom,
  DecPom,
  OswPom,
  Msw260,
  SkOk,
  SiwzIni, TabNotBk, Sk;

type
  TMainDlg = class(TForm)
    Panel1: TPanel;
    TabbedNotebook1: TTabbedNotebook;
    Panel2: TPanel;
    DecyzjaBtn: TButton;
    RegulaminBtn: TButton;
    OswBtn: TButton;
    CloseBtn: TBitBtn;
    Sk: TSmartKey;
    Msw260Btn: TButton;
    ZArt22Btn: TButton;
    OArt22Btn: TButton;
    procedure FormCreate(Sender: TObject);
    procedure ZpBtnClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
    procedure WMGetMinMaxInfo(var Message: TWMGetMinMaxInfo);
      message WM_GETMINMAXINFO;
  public
    { Public declarations }
  end;

var
  MainDlg: TMainDlg;

implementation

{$R *.DFM}
uses
  DrMsg;

procedure TMainDlg.WMGetMinMaxInfo(var Message: TWMGetMinMaxInfo);
var
  MinMax:PMinMaxInfo;
begin
  inherited;
  MinMax:=Message.MinMaxInfo;
  MinMax^.ptMinTrackSize.X:=640;
  MinMax^.ptMinTrackSize.Y:=480;
end;

procedure TMainDlg.FormCreate(Sender: TObject);
begin
  Application.HelpFile:=RapHelpFile;
end;

procedure TMainDlg.ZpBtnClick(Sender: TObject);
begin
  if not (Sender is TButton)
    then Exit;
  if TButton(Sender).Name='RegulaminBtn'
    then Regulamin
  else if TButton(Sender).Name='DecyzjaBtn'
    then Decyzja
  else if TButton(Sender).Name='OswBtn'
    then Oswiadczenie
  else if TButton(Sender).Name='Msw260Btn'
    then Msw260p;
end;

procedure TMainDlg.FormActivate(Sender: TObject);
begin
{$IFDEF NONET}
  if not SmartKeyOk(Sk,SkData)
    then CloseBtn.Click;
{$ENDIF}
end;

end.
