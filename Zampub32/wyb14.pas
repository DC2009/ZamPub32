unit Wyb14;

interface

uses WinTypes, WinProcs, Classes, Graphics, Forms, Controls, Buttons,
  StdCtrls, ExtCtrls, WybTryb;

type
  TWyb14Dlg = class(TForm)
    PanelBottom2: TPanel;
    Panel1: TPanel;
    YesBtn: TBitBtn;
    CancelBtn: TBitBtn;
    Label1: TLabel;
    Label2: TLabel;
    BackBtn: TBitBtn;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Wyb14Dlg: TWyb14Dlg;

implementation

{$R *.DFM}

end.
