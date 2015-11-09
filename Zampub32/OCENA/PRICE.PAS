unit Price;

interface

uses WinTypes, WinProcs, Classes, Graphics, Forms, Controls, Buttons,
  StdCtrls, ExtCtrls;

type
  TPriceMarkDlg = class(TForm)
    OKBtn: TBitBtn;
    CancelBtn: TBitBtn;
    HelpBtn: TBitBtn;
    Bevel1: TBevel;
    KritLB: TListBox;
    Label2: TLabel;
    procedure OKBtnClick(Sender: TObject);
    procedure HelpBtnClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  PriceMarkDlg: TPriceMarkDlg;

implementation

{$R *.DFM}

procedure TPriceMarkDlg.OKBtnClick(Sender: TObject);
begin
  if KritLB.Itemindex<0
    then ModalResult:=mrCancel;
end;

procedure TPriceMarkDlg.HelpBtnClick(Sender: TObject);
begin
  Application.HelpContext(150);
end;

end.
