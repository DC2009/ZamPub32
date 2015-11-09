unit Value;

interface

uses WinTypes, WinProcs, Classes, Graphics, Forms, Controls, Buttons,
  StdCtrls, NumInp, ExtCtrls,
  Amount;

type
  TValueDlg = class(TForm)
    OKBtn: TBitBtn;
    CancelBtn: TBitBtn;
    Bevel1: TBevel;
    Label1: TLabel;
    NEdit: TNumInp;
    ChgBtn: TButton;
    procedure ChgBtnClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    ALevel:Integer;
  end;

var
  ValueDlg: TValueDlg;

implementation

{$R *.DFM}

procedure TValueDlg.ChgBtnClick(Sender: TObject);
var
  y:Real;
begin
  GetPLNAmount(y,ALevel);
  if y>0
    then NEdit.Value:=y;
end;

end.
