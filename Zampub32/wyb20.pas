unit Wyb20;

interface

uses WinTypes, WinProcs, Classes, Graphics, Forms, Controls, Buttons,
  StdCtrls, ExtCtrls;

type
  TWyb20Dlg = class(TForm)
    PanelBottom2: TPanel;
    CancelBtn: TBitBtn;
    OkBtn: TBitBtn;
    BackBtn: TBitBtn;
    Panel2: TPanel;
    Label7: TLabel;
    ArtLabel: TLabel;
    ArtBtn: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure ArtBtnClick(Sender: TObject);
  private
    { Private declarations }
    ArtPoint:Byte;
  public
    { Public declarations }
    procedure SetPoint(Value:Byte);
  end;

var
  Wyb20Dlg: TWyb20Dlg;

implementation

{$R *.DFM}

uses
  WTArt71;

procedure TWyb20Dlg.FormCreate(Sender: TObject);
begin
  ArtPoint:=0;
end;

procedure TWyb20Dlg.SetPoint(Value:Byte);
begin
  ArtPoint:=Value;
  case ArtPoint of
    1:ArtLabel.Caption:='Art. 71 ust.1 pkt 1';
    2:ArtLabel.Caption:='Art. 71 ust.1 pkt 2';
    3:ArtLabel.Caption:='Art. 71 ust.1 pkt 3 lub 5';
    4:ArtLabel.Caption:='Art. 71 ust.1 pkt 4';
    5:ArtLabel.Caption:='Art. 71 ust.1 pkt 3 lub 5';
    6:ArtLabel.Caption:='Art. 71 ust.1 pkt 6';
    7:ArtLabel.Caption:='Art. 71 ust.1 pkt 7';
    else ArtLabel.Caption:='';
  end;
  ArtLabel.Left:=(Panel2.Width -ArtLabel.Width) div 2;
end;

procedure TWyb20Dlg.ArtBtnClick(Sender: TObject);
var
  WT:TWTArt71Dlg;
begin
  WT:=TWTArt71Dlg.Create(BackBtn);
  WT.ShowModal;
  WT.Free;
end;

end.
