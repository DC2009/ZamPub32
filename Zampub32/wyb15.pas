unit Wyb15;

interface

uses WinTypes, WinProcs, Classes, Graphics, Forms, Controls, Buttons,
  StdCtrls, ExtCtrls, WybTryb;

type
  TWyb15Dlg = class(TForm)
    PanelBottom2: TPanel;
    Panel1: TPanel;
    YesBtn: TBitBtn;
    NoBtn: TBitBtn;
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
  Wyb15Dlg: TWyb15Dlg;

implementation

{$R *.DFM}

end.
