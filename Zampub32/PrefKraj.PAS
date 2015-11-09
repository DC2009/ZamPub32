unit Prefkraj;

interface

uses WinTypes, WinProcs, Classes, Graphics, Forms, Controls, Buttons,
  StdCtrls, ExtCtrls;

type
  TPrefKrajoweDlg = class(TForm)
    OKBtn: TBitBtn;
    CancelBtn: TBitBtn;
    PKGroup: TRadioGroup;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  PrefKrajoweDlg: TPrefKrajoweDlg;

implementation

{$R *.DFM}

end.
