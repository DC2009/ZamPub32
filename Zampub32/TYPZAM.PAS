unit TypZam;

interface

uses WinTypes, WinProcs, Classes, Graphics, Forms, Controls, Buttons,
  StdCtrls, ExtCtrls, Dialogs;

type
  TTypZamDlg = class(TForm)
    OKBtn: TBitBtn;
    CancelBtn: TBitBtn;
    Bevel1: TBevel;
    RB1: TRadioButton;
    RB2: TRadioButton;
    RB3: TRadioButton;
    procedure FormCreate(Sender: TObject);
    procedure OKBtnClick(Sender: TObject);
    procedure HelpBtnClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

function GetTypZamowienia(RobBudActive:Boolean):Integer; export;

implementation

{$R *.DFM}

uses
  SysUtils,
  SiwzIni,
  Msg2;

function GetTypZamowienia(RobBudActive:Boolean):Integer;
var
  TypZamDlg: TTypZamDlg;
  l:LongInt;
  Code:Integer;
begin
  try
    Result:=-1;
    TypZamDlg:=TTypZamDlg.Create(Nil);
    TypZamDlg.RB3.Enabled:=RobBudActive;
    if TypZamDlg.ShowModal=mrOk
      then begin
        if TypZamDlg.RB1.Checked
          then Result:=okDostawa
        else if TypZamDlg.RB2.Checked
          then Result:=okUslugi
        else if TypZamDlg.RB3.Checked
          then Result:=okRobBud
      end;
    TypZamDlg.Free;
  except
    on E:Exception do
      MessageDlg('B³¹d '+E.ClassName+' w S2XSCR.DLL', mtWarning, [mbOk],0);
  end;
end;

procedure TTypZamDlg.FormCreate(Sender: TObject);
begin
  RB1.Checked:=TRUE;
end;

procedure TTypZamDlg.OKBtnClick(Sender: TObject);
begin
{  if RadioGroup.ItemIndex<0
    then begin
      ShowMessage(mChooseObjectKind);
      ModalResult:=0;
    end
    else ModalResult:=mrOk;}
end;

procedure TTypZamDlg.HelpBtnClick(Sender: TObject);
begin
  Application.HelpContext(2002);
end;

end.
