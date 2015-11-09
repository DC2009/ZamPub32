unit Wyb5;

interface

uses WinTypes, WinProcs, Classes, Graphics, Forms, Controls, Buttons,
  StdCtrls, ExtCtrls, WybTryb;

type
  TWyb5Dlg = class(TForm)
    PanelBottom2: TPanel;
    Panel1: TPanel;
    YesBtn: TBitBtn;
    NoBtn: TBitBtn;
    CancelBtn: TBitBtn;
    Label4: TLabel;
    Label1: TLabel;
    BackBtn: TBitBtn;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Wyb5Dlg: TWyb5Dlg;

implementation

{$R *.DFM}

end.
