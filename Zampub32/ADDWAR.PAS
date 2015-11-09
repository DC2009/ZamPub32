unit Addwar;

interface

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, StdCtrls, Buttons, ExtCtrls;

type
  TAddWarDlg = class(TForm)
    OkBitBtn: TBitBtn;
    CancelBitBtn: TBitBtn;
    AllBitBtn: TBitBtn;
    HelpBitBtn: TBitBtn;
    WarSB: TScrollBox;
    CB1: TCheckBox;
    CB2: TCheckBox;
    CB3: TCheckBox;
    CB4: TCheckBox;
    CB5: TCheckBox;
    CB6: TCheckBox;
    CB7: TCheckBox;
    CB8: TCheckBox;
    CB9: TCheckBox;
    CB10: TCheckBox;
    CB11: TCheckBox;
    CB12: TCheckBox;
    CB13: TCheckBox;
    CB14: TCheckBox;
    CB15: TCheckBox;
    CB16: TCheckBox;
    CB17: TCheckBox;
    CB18: TCheckBox;
    CB19: TCheckBox;
    CB20: TCheckBox;
    CB21: TCheckBox;
    CB22: TCheckBox;
    Cb23: TCheckBox;
    CB24: TCheckBox;
    CB25: TCheckBox;
    CB26: TCheckBox;
    CB27: TCheckBox;
    Cb28: TCheckBox;
    Cb29: TCheckBox;
    CB30: TCheckBox;
    CB31: TCheckBox;
    CB32: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure HelpBitBtnClick(Sender: TObject);
    procedure AllBitBtnClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  AddWarDlg: TAddWarDlg;

implementation

uses
  Utils,
  SiwzIni;

{$R *.DFM}

procedure TAddWarDlg.FormCreate(Sender: TObject);
begin
  WarSB.ScrollInView(CB1);
end;

procedure TAddWarDlg.HelpBitBtnClick(Sender: TObject);
begin
  Application.HelpContext(2011);
end;

procedure TAddWarDlg.AllBitBtnClick(Sender: TObject);
var
  i:Integer;
begin
  for i:=0 to ComponentCount-1 do
    if Components[i] is TCheckBox
      then TCheckBox(Components[i]).Checked:=TRUE;
end;

end.
