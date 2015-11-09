unit Zp11;

interface

uses WinTypes, WinProcs, Classes, Graphics, Forms, Controls, Buttons,
  StdCtrls, Tabs, ExtCtrls;

type
  TZp11Dlg = class(TForm)
    OKBtn: TBitBtn;
    CancelBtn: TBitBtn;
    HelpBtn: TBitBtn;
    Notebook: TNotebook;
    TabSet: TTabSet;
    ScrollBox1: TScrollBox;
    procedure TabSetClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Zp11Dlg: TZp11Dlg;

implementation

{$R *.DFM}

procedure TZp11Dlg.TabSetClick(Sender: TObject);
begin
  Notebook.PageIndex:=TabSet.TabIndex;
end;

end.
