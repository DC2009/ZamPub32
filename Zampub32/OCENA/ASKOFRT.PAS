unit Askofrt;

interface

uses WinTypes, WinProcs, Classes, Graphics, Forms, Controls, Buttons,
  StdCtrls, ExtCtrls, Spin;

type
  TAskOfrtDlg = class(TForm)
    OKBtn: TBitBtn;
    CancelBtn: TBitBtn;
    RG: TRadioGroup;
    Edit1: TEdit;
    Edit2: TEdit;
    procedure Edit1KeyPress(Sender: TObject; var Key: Char);
    procedure OKBtnClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  AskOfrtDlg: TAskOfrtDlg;

implementation

{$R *.DFM}

procedure TAskOfrtDlg.Edit1KeyPress(Sender: TObject; var Key: Char);
begin
  if not (Key in ['0'..'9',#8])
    then Key:=#0;
end;

procedure TAskOfrtDlg.OKBtnClick(Sender: TObject);
begin
  if Edit1.Text=''
    then Edit1.Text:='0';
  if Edit2.Text=''
    then Edit2.Text:='0';
end;

end.
