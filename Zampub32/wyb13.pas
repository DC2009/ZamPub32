unit Wyb13;

interface

uses WinTypes, WinProcs, Classes, Graphics, Forms, Controls, Buttons,
  StdCtrls, ExtCtrls;

type
  TWyb13Dlg = class(TForm)
    PanelBottom2: TPanel;
    CancelBtn: TBitBtn;
    OkBtn: TBitBtn;
    BackBtn: TBitBtn;
    Panel2: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    ArtBtn: TBitBtn;
    procedure ArtBtnClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Wyb13Dlg: TWyb13Dlg;

implementation

{$R *.DFM}

uses
  WTArt68;

procedure TWyb13Dlg.ArtBtnClick(Sender: TObject);
var
  WT:TWTArt68Dlg;
begin
  WT:=TWTArt68Dlg.Create(BackBtn);
  WT.ShowModal;
  WT.Free;
end;

end.
