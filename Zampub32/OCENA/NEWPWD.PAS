unit Newpwd;

interface

uses WinTypes, WinProcs, Classes, Graphics, Forms, Controls, StdCtrls,
  Buttons,Dialogs, Messages,
  Msg,
  OfrtDta;

type
  TNewPwdDlg = class(TForm)
    Label1: TLabel;
    PwdEdit1: TEdit;
    OKBtn: TBitBtn;
    CancelBtn: TBitBtn;
    Label2: TLabel;
    PwdEdit2: TEdit;
    procedure OKBtnClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  NewPwdDlg: TNewPwdDlg;

procedure GetNewPassword(Ix:Integer);

implementation

{$R *.DFM}

procedure GetNewPassword(Ix:Integer);
begin
  NewPwdDlg:=TNewPwdDlg.Create(Nil);
  if NewPwdDlg.ShowModal=mrOk
    then begin
      if Ix=0
        then SuperPwd:=NewPwdDlg.PwdEdit1.Text
        else MPwds[Ix-1]:=NewPwdDlg.PwdEdit1.Text;
    end;
  NewPwdDlg.Free;
end;

procedure TNewPwdDlg.OKBtnClick(Sender: TObject);
begin
  ModalResult:=mrOk;
  if PwdEdit1.Text<>PwdEdit2.Text
    then begin
      MessageDlg(wmDifferentPwd,mtWarning,[mbOk],0);
      ModalResult:=0;
    end;
end;

procedure TNewPwdDlg.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key=#13
    then begin
      Key:=#0;
      Perform(wm_NextDlgCtl,0,0);
    end;
end;

end.

