unit About;

interface

uses WinTypes, WinProcs, Classes, Graphics, Forms, Controls, StdCtrls,
  Buttons, ExtCtrls;

type
  TAboutBox = class(TForm)
    Panel1: TPanel;
    OKButton: TBitBtn;
    Image1: TImage;
    CopyrightLabel: TLabel;
    ProductLabel: TLabel;
    VersionLabel: TLabel;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  AboutBox: TAboutBox;

implementation

{$R *.DFM}

uses
  SiwzIni;

procedure TAboutBox.FormCreate(Sender: TObject);
begin
  ProductLabel.Caption:=ProgramIni;
  VersionLabel.Caption:=VersionIni;
  CopyrightLabel.Caption:=CopyrightIni;
end;

end.

