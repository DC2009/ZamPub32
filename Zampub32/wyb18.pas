unit Wyb18;

interface

uses WinTypes, WinProcs, Classes, Graphics, Forms, Controls, Buttons,
  StdCtrls, ExtCtrls;

type
  TWyb18Dlg = class(TForm)
    PanelBottom2: TPanel;
    CancelBtn: TBitBtn;
    OkBtn: TBitBtn;
    BackBtn: TBitBtn;
    Panel2: TPanel;
    Label7: TLabel;
    Label1: TLabel;
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
  Wyb18Dlg: TWyb18Dlg;

implementation

{$R *.DFM}

uses
  WTArt64;

procedure TWyb18Dlg.SetPoint(Value:Byte);
begin
  ArtPoint:=Value;
  case ArtPoint of
    2:ArtLabel.Caption:='Art. 64 pkt 2';
    3:ArtLabel.Caption:='Art. 64 pkt 3';
    else ArtLabel.Caption:='';
  end;
  ArtLabel.Left:=(Panel2.Width -ArtLabel.Width) div 2;
end;

procedure TWyb18Dlg.FormCreate(Sender: TObject);
begin
  ArtPoint:=0;
end;

procedure TWyb18Dlg.ArtBtnClick(Sender: TObject);
var
  WT:TWTArt64Dlg;
begin
  WT:=TWTArt64Dlg.Create(BackBtn);
  WT.ShowModal;
  WT.Free;
end;

end.
