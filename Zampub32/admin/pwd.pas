unit Pwd;

interface

uses WinTypes, WinProcs, Classes, Graphics, Forms, Controls, Buttons,
  StdCtrls, ExtCtrls, Dialogs;

type
  TPwdDlg = class(TForm)
    OKBtn: TBitBtn;
    CancelBtn: TBitBtn;
    Bevel1: TBevel;
    PwdEdit: TEdit;
    Pwd2: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    procedure OKBtnClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  PwdDlg: TPwdDlg;

implementation

{$R *.DFM}

procedure TPwdDlg.OKBtnClick(Sender: TObject);
begin
  if PwdEdit.Text <> Pwd2.Text
    then begin
      ModalResult:=mrNone;
      MessageDlg('Nieprawid³owo prowadzone has³o',mtError,[mbOk],0);
      PwdEdit.SetFocus;
    end;
end;

end.
