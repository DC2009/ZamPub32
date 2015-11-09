unit Wyb10;

interface

uses WinTypes, WinProcs, Classes, Graphics, Forms, Controls, Buttons,
  StdCtrls, ExtCtrls, WybTryb;

type
  TWyb10Dlg = class(TForm)
    PanelBottom2: TPanel;
    Panel1: TPanel;
    YesBtn: TBitBtn;
    NoBtn: TBitBtn;
    CancelBtn: TBitBtn;
    Label1: TLabel;
    BackBtn: TBitBtn;
    Label2: TLabel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Wyb10Dlg: TWyb10Dlg;

implementation

{$R *.DFM}

end.
