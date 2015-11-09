unit Addcont;

interface

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, StdCtrls, Buttons, ExtCtrls;

type
  TAddContDlg = class(TForm)
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
    procedure FormCreate(Sender: TObject);
    procedure HelpBitBtnClick(Sender: TObject);
    procedure AllBitBtnClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    constructor Create( AOwner: TComponent ; Tryb,Phase:Integer); 
    procedure InitCB(Tryb,Phase:Integer);
  end;

var
  AddContDlg: TAddContDlg;

implementation

uses
  Utils,
  SiwzIni;

{$R *.DFM}

constructor TAddContDlg.Create( AOwner: TComponent ; Tryb,Phase:Integer);
begin
  inherited Create(AOwner);
  InitCB(Tryb,Phase);
end;

procedure TAddContDlg.FormCreate(Sender: TObject);
begin
  WarSB.ScrollInView(CB1);
end;

procedure TAddContDlg.HelpBitBtnClick(Sender: TObject);
begin
  Application.HelpContext(2011);
end;

procedure TAddContDlg.AllBitBtnClick(Sender: TObject);
var
  i:Integer;
begin
  for i:=0 to ComponentCount-1 do
    if (Components[i] is TCheckBox) and TCheckBox(Components[i]).Enabled
      then TCheckBox(Components[i]).Checked:=TRUE;
end;

procedure TAddContDlg.InitCB(Tryb,Phase:Integer);
begin
  if (Tryb=iDwustopniowy) and (Phase=1)
    then begin
      CB2.Enabled:=FALSE;
      CB3.Enabled:=FALSE;
    end;
  if (Tryb=iNegocjacje) and (Phase=1)
    then begin
      CB2.Enabled:=FALSE;
    end;
end;

end.
