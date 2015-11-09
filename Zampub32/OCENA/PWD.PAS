unit Pwd;

interface

uses WinTypes, WinProcs, Classes, Graphics, Forms, Controls, StdCtrls,
  Buttons;

type
  TPwdDlg = class(TForm)
    Label1: TLabel;
    PwdEdit: TEdit;
    OKBtn: TBitBtn;
    CancelBtn: TBitBtn;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  PwdDlg: TPwdDlg;

implementation

{$R *.DFM}

end.
 
