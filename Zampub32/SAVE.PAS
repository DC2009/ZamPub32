unit Save;

interface

uses WinTypes, WinProcs, Classes, Graphics, Forms, Controls, Buttons,
  StdCtrls, ExtCtrls;

type
  TSaveDlg = class(TForm)
    OKBtn: TBitBtn;
    CancelBtn: TBitBtn;
    HelpBtn: TBitBtn;
    Bevel1: TBevel;
    RadioGroup: TRadioGroup;
    procedure HelpBtnClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  SaveDlg: TSaveDlg;

implementation

{$R *.DFM}

procedure TSaveDlg.HelpBtnClick(Sender: TObject);
begin
  Application.HelpContext(2020);
end;

end.
