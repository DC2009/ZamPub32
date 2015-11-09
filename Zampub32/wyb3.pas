unit Wyb3;

interface

uses WinTypes, WinProcs, Classes, Graphics, Forms, Controls, Buttons,
  StdCtrls, ExtCtrls, WybTryb;

type
  TWyb3Dlg = class(TForm)
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
  Wyb3Dlg: TWyb3Dlg;

implementation

{$R *.DFM}

end.
