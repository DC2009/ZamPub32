unit Art71;

interface

uses WinTypes, WinProcs, Classes, Graphics, Forms, Controls, Buttons,
  StdCtrls, ExtCtrls, Dialogs;

type
  TArt71Dlg = class(TForm)
    OKBtn: TBitBtn;
    CancelBtn: TBitBtn;
    HelpBtn: TBitBtn;
    EventsLabel: TLabel;
    CB1: TCheckBox;
    CB2: TCheckBox;
    CB3: TCheckBox;
    CB4: TCheckBox;
    CB5: TCheckBox;
    CB6: TCheckBox;
    CB7: TCheckBox;
    L1_1: TLabel;
    Bevel1: TBevel;
    L1_2: TLabel;
    L1_3: TLabel;
    Bevel2: TBevel;
    L2_1: TLabel;
    L2_2: TLabel;
    Bevel3: TBevel;
    L3_1: TLabel;
    L3_2: TLabel;
    Bevel4: TBevel;
    L4_1: TLabel;
    L4_2: TLabel;
    Bevel5: TBevel;
    L5_1: TLabel;
    L5_2: TLabel;
    Bevel6: TBevel;
    L6_1: TLabel;
    L6_2: TLabel;
    L6_3: TLabel;
    Bevel7: TBevel;
    L7_1: TLabel;
    L7_2: TLabel;
    procedure OKBtnClick(Sender: TObject);
    procedure HelpBtnClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Art71Dlg: TArt71Dlg;

implementation

{$R *.DFM}

uses
  Msg2;

procedure TArt71Dlg.OKBtnClick(Sender: TObject);
begin
  if (CB1.State=cbUnchecked) and
     (CB2.State=cbUnchecked) and
     (CB3.State=cbUnchecked) and
     (CB4.State=cbUnchecked) and
     (CB5.State=cbUnchecked) and
     (CB6.State=cbUnchecked) and
     (CB7.State=cbUnchecked)
    then begin
      ShowMessage(wmNoPointsSelectedArt71);
      ModalResult:=mrNone
    end
    else begin
      ModalResult:=mrOk;
      if  CB4.Checked
        then MessageDlg('Udzielenie zamówienia musi zostaæ poprzedzone konkursem'+^M+
                        'przeprowadzonym na warunkach okreœlonych przypisami'+^M+
                        'rozporz¹dzenia Rady Ministrów z dnia 5 sierpnia 1997.',
                        mtInformation, [mbOk], 0);
    end;
end;

procedure TArt71Dlg.HelpBtnClick(Sender: TObject);
begin
  Application.HelpContext(2010);
end;

procedure TArt71Dlg.FormActivate(Sender: TObject);
begin
  CB1.Checked:=FALSE;
  CB2.Checked:=FALSE;
  CB3.Checked:=FALSE;
  CB4.Checked:=FALSE;
  CB5.Checked:=FALSE;
  CB6.Checked:=FALSE;
  CB7.Checked:=FALSE;
end;

end.
