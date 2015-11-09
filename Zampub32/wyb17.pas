unit Wyb17;

interface

uses WinTypes, WinProcs, Classes, Graphics, Forms, Controls, Buttons,
  StdCtrls, ExtCtrls;

type
  TWyb17Dlg = class(TForm)
    PanelBottom2: TPanel;
    CancelBtn: TBitBtn;
    OkBtn: TBitBtn;
    BackBtn: TBitBtn;
    Panel2: TPanel;
    Label1: TLabel;
    ArtLabel: TLabel;
    Label2: TLabel;
    ArtBtn: TBitBtn;
    procedure ArtBtnClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Wyb17Dlg: TWyb17Dlg;

implementation

{$R *.DFM}

uses
  WTArt32;

procedure TWyb17Dlg.ArtBtnClick(Sender: TObject);
var
  WT:TWTArt32Dlg;
begin
  WT:=TWTArt32Dlg.Create(BackBtn);
  WT.ShowModal;
  WT.Free;
end;

end.
