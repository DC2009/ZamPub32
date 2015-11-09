unit Oferent;

interface

uses WinTypes, WinProcs, Classes, Graphics, Forms, Controls, Buttons,
  StdCtrls, ExtCtrls, Messages;

type
  TOferentDlg = class(TForm)
    OKBtn: TBitBtn;
    CancelBtn: TBitBtn;
    CompanyEdit: TEdit;
    AddressEdit: TEdit;
    NameEdit: TEdit;
    PriceEdit: TEdit;
    Panel1: TPanel;
    PriceLabel: TLabel;
    NameLabel: TLabel;
    AddressLabel: TLabel;
    CompanyLabel: TLabel;
    procedure FormActivate(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  OferentDlg: TOferentDlg;

implementation

{$R *.DFM}

procedure TOferentDlg.FormActivate(Sender: TObject);
begin
  CompanyEdit.Clear;
  AddressEdit.Clear;
  NameEdit.Clear;
  PriceEdit.Text:=' PLN';
  ActiveControl:=CompanyEdit;
end;

procedure TOferentDlg.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key=#13
    then begin
      Key:=#0;
      Perform(wm_NextDlgCtl,0,0);
    end;
end;

end.
