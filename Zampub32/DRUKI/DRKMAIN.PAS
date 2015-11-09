unit Drkmain;

interface

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, ExtCtrls, StdCtrls, Buttons,
  ZpBoxes,
  Zp11,
  Zp12,
  Zp13,
  Zp14,
  Zp21,
  Zp31,
  Zp110,
{$IFNDEF DEMO}
  zp1,
  zp41,
  zp42,
  zp43,
  zp44,
  zp45,
  zp46,
  zp54,
  zp61,
  zp71,
  ZP81,
  zp121,
  zp150,
  zp160,
  zp170,
  zp120,
  zp130,
  zp140,
  zp141,
  zp210,
{$ENDIF}
  SkOk,
  ChgPwd,
  SiwzIni, TabNotBk, Sk;

type
  TMainDlg = class(TForm)
    Panel1: TPanel;
    CloseBtn: TBitBtn;
    TabbedNotebook1: TTabbedNotebook;
    Panel2: TPanel;
    Zp1Btn: TButton;
    Zp11Btn: TButton;
    Zp12Btn: TButton;
    Zp13Btn: TButton;
    Zp14Btn: TButton;
    Zp21Btn: TButton;
    Zp31Btn: TButton;
    Zp41Btn: TButton;
    Zp42Btn: TButton;
    Zp43Btn: TButton;
    Zp44Btn: TButton;
    Zp45Btn: TButton;
    Zp46Btn: TButton;
    Zp51Btn: TButton;
    Zp52Btn: TButton;
    Zp53Btn: TButton;
    Zp54Btn: TButton;
    Zp61Btn: TButton;
    Zp71Btn: TButton;
    Zp81Btn: TButton;
    Zp110Btn: TButton;
    Zp121Btn: TButton;
    Zp150Btn: TButton;
    Zp160Btn: TButton;
    Zp170Btn: TButton;
    Panel3: TPanel;
    Zp120Btn: TButton;
    Zp130Btn: TButton;
    Zp140Btn: TButton;
    Zp141Btn: TButton;
    Zp210Btn: TButton;
    Sk: TSmartKey;
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
  Application.HelpFile:=DruZpHelpFile;
  Zp11Btn.Hint:=ZP11Tit;
  Zp12Btn.Hint:=ZP12Tit;
  Zp13Btn.Hint:=ZP13Tit;
  Zp14Btn.Hint:=ZP14Tit;
  Zp21Btn.Hint:=ZP21Tit;
  Zp31Btn.Hint:='Lista oferentów zaproszonych do dalszego udzia³u w postêpowaniu '+
                '(przetarg ograniczony, przetarg dwustopniowy)';
  Zp110Btn.Hint:=ZP110Tit;
  Zp1Btn.Hint:=Zp1Tit;
  Zp41Btn.Hint:='Zbiorcze zestawienie ofert otwartych w dniu...';
  Zp42Btn.Hint:='Oœwiadczenie z³o¿one podczas otwarcia ofert w dniu...';
  Zp43Btn.Hint:=ZP43Tit;
  Zp44Btn.Hint:=ZP44Tit;
  Zp45Btn.Hint:=ZP45Tit1+Zp45Tit2;
  Zp46Btn.Hint:=ZP46Tit;
  Zp51Btn.Hint:=ZP51Tit;
  Zp52Btn.Hint:=ZP52Tit;
  Zp53Btn.Hint:=ZP53Tit;
  Zp54Btn.Hint:=ZP54Tit;
  Zp61Btn.Hint:=ZP61Tit;
  Zp71Btn.Hint:=ZP71Tit;
  Zp81Btn.Hint:=ZP81Tit;

  Zp121Btn.Hint:=ZP121Tit;
  Zp150Btn.Hint:=ZP150Tit;
  Zp160Btn.Hint:=ZP160Tit1+Zp160Tit2;
  Zp170Btn.Hint:=ZP170Tit1+Zp170Tit2;
  Zp120Btn.Hint:=ZP120Tit1+Zp120Tit2;
  Zp130Btn.Hint:=ZP130Tit;
  Zp140Btn.Hint:=ZP140Tit;
  Zp141Btn.Hint:=ZP141Tit;
  Zp210Btn.Hint:=ZP210Tit;
{$IFDEF DEMO}
    Zp1Btn.Enabled:=FALSE;
    Zp41Btn.Enabled:=FALSE;
    Zp42Btn.Enabled:=FALSE;
    Zp43Btn.Enabled:=FALSE;
    Zp44Btn.Enabled:=FALSE;
    Zp45Btn.Enabled:=FALSE;
    Zp46Btn.Enabled:=FALSE;
    Zp51Btn.Enabled:=FALSE;
    Zp52Btn.Enabled:=FALSE;
    Zp53Btn.Enabled:=FALSE;
    Zp54Btn.Enabled:=FALSE;
    Zp61Btn.Enabled:=FALSE;
    Zp71Btn.Enabled:=FALSE;
    Zp81Btn.Enabled:=FALSE;
    Zp121Btn.Enabled:=FALSE;
    Zp150Btn.Enabled:=FALSE;
    Zp160Btn.Enabled:=FALSE;
    Zp170Btn.Enabled:=FALSE;
    Zp120Btn.Enabled:=FALSE;
    Zp130Btn.Enabled:=FALSE;
    Zp140Btn.Enabled:=FALSE;
    Zp141Btn.Enabled:=FALSE;
    Zp210Btn.Enabled:=FALSE;
{$ENDIF}
end;

procedure TMainDlg.ZpBtnClick(Sender: TObject);
begin
  if not (Sender is TButton)
    then Exit;
{$IFDEF DEMO}
{  Zp11Btn.Hint:=ZP11Tit;
  Zp12Btn.Hint:=ZP12Tit;
  Zp13Btn.Hint:=ZP13Tit;
  Zp14Btn.Hint:=ZP14Tit;
  Zp21Btn.Hint:=ZP21Tit;
  Zp31Btn.Hint:='Lista oferentów zaproszonych do dalszego udzia³u w postêpowaniu '+
                '(przetarg ograniczony, przetarg dwustopniowy)';
  Zp110Btn.Hint:=ZP110Tit;}
  if TButton(Sender).Name='Zp11Btn'
    then DrukZP11
  else if TButton(Sender).Name='Zp12Btn'
    then DrukZP12
  else if TButton(Sender).Name='Zp13Btn'
    then DrukZP13
  else if TButton(Sender).Name='Zp14Btn'
    then DrukZP14
  else if TButton(Sender).Name='Zp21Btn'
    then DrukZP21
  else if TButton(Sender).Name='Zp31Btn'
    then DrukZP31
  else if TButton(Sender).Name='Zp110Btn'
    then DrukZP110;
{$ELSE}
  if TButton(Sender).Name='Zp1Btn'
    then DrukZP1
  else if TButton(Sender).Name='Zp11Btn'
    then DrukZP11
  else if TButton(Sender).Name='Zp12Btn'
    then DrukZP12
  else if TButton(Sender).Name='Zp13Btn'
    then DrukZP13
  else if TButton(Sender).Name='Zp14Btn'
    then DrukZP14
  else if TButton(Sender).Name='Zp21Btn'
    then DrukZP21
  else if TButton(Sender).Name='Zp31Btn'
    then DrukZP31
  else if TButton(Sender).Name='Zp41Btn'
    then DrukZP41
  else if TButton(Sender).Name='Zp42Btn'
    then DrukZP42
  else if TButton(Sender).Name='Zp43Btn'
    then DrukZP43
  else if TButton(Sender).Name='Zp44Btn'
    then DrukZP44
  else if TButton(Sender).Name='Zp45Btn'
    then DrukZP45
  else if TButton(Sender).Name='Zp46Btn'
    then DrukZP46
  else if (TButton(Sender).Name='Zp51Btn') or
     (TButton(Sender).Name='Zp52Btn') or
     (TButton(Sender).Name='Zp53Btn')
    then MessageDlg('Druk dostêpny w programie "Ocena ofert".',mtInformation,[mbOk],0)
  else if TButton(Sender).Name='Zp54Btn'
    then DrukZP54
  else if TButton(Sender).Name='Zp61Btn'
    then DrukZP61
  else if TButton(Sender).Name='Zp71Btn'
    then DrukZP71
  else if TButton(Sender).Name='Zp81Btn'
    then DrukZP81
  else if TButton(Sender).Name='Zp110Btn'
    then DrukZP110
  else if TButton(Sender).Name='Zp121Btn'
    then DrukZP121
  else if TButton(Sender).Name='Zp150Btn'
    then DrukZP150
  else if TButton(Sender).Name='Zp160Btn'
    then DrukZP160
  else if TButton(Sender).Name='Zp170Btn'
    then DrukZP170
  else if TButton(Sender).Name='Zp120Btn'
    then DrukZP120
  else if TButton(Sender).Name='Zp130Btn'
    then DrukZP130
  else if TButton(Sender).Name='Zp140Btn'
    then DrukZP140
  else if TButton(Sender).Name='Zp141Btn'
    then DrukZP141
  else if TButton(Sender).Name='Zp210Btn'
    then DrukZP210;
{$ENDIF}
end;

procedure TMainDlg.FormActivate(Sender: TObject);
begin
{$IFDEF NONET}
  if not SmartKeyOk(Sk,SkData)
    then CloseBtn.Click;
{$ENDIF}
end;

end.
