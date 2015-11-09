unit Maxpts;

interface

uses WinTypes, WinProcs, Classes, Graphics, Forms, Controls, Buttons,
  StdCtrls, ExtCtrls, Spin, Dialogs, SysUtils;

type
  TMaxPtsDlg = class(TForm)
    OKBtn: TBitBtn;
    CancelBtn: TBitBtn;
    HelpBtn: TBitBtn;
    Bevel1: TBevel;
    Label1: TLabel;
    Label2: TLabel;
    SpinEdit: TSpinEdit;
    procedure OKBtnClick(Sender: TObject);
    procedure HelpBtnClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MaxPtsDlg: TMaxPtsDlg;

implementation

{$R *.DFM}

uses
  Msg;

procedure TMaxPtsDlg.OKBtnClick(Sender: TObject);
var
  l:LongInt;
  c:Integer;
begin
  if SpinEdit.Text=''
    then begin
      MessageBeep(0);
      MessageDlg(mQuantityValueNotSpecified,mtError,[mbOk],0);
      ModalResult:=0;
      ActiveControl:=SpinEdit;
    end
  else if StrToInt(SpinEdit.Text)=0
    then begin
      MessageBeep(0);
      MessageDlg(mMaxPtsNumIs0,mtError,[mbOk],0);
      ModalResult:=0;
      ActiveControl:=SpinEdit;
    end
  else begin
    Val(SpinEdit.Text,l,c);
    if c<>0
      then begin
        MessageBeep(0);
        ModalResult:=0;
        MessageDlg(mUnknownQuantityValue,mtError,[mbOk],0);
        ActiveControl:=SpinEdit;
      end
    else if l>32767
      then begin
        MessageBeep(0);
        ModalResult:=0;
        MessageDlg(mValueOver32767,mtError,[mbOk],0);
        ActiveControl:=SpinEdit;
      end
    else ModalResult:=mrOk;
  end;
end;

procedure TMaxPtsDlg.HelpBtnClick(Sender: TObject);
begin
  Application.HelpContext(103);
end;

end.
