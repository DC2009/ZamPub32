unit Wyb19;

interface

uses WinTypes, WinProcs, Classes, Graphics, Forms, Controls, Buttons,
  StdCtrls, ExtCtrls;

type
  TWyb19Dlg = class(TForm)
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
  Wyb19Dlg: TWyb19Dlg;

implementation

{$R *.DFM}

uses
  WTArt54;

procedure TWyb19Dlg.ArtBtnClick(Sender: TObject);
var
  WT:TWTArt54Dlg;
begin
  WT:=TWTArt54Dlg.Create(BackBtn);
  WT.ShowModal;
  WT.Free;
end;

end.
