unit Tendernr;

interface

uses WinTypes, WinProcs, Classes, Graphics, Forms, Controls, Buttons,
  StdCtrls, Spin, ExtCtrls, Dialogs, SysUtils;

type
  TTenderNumDlg = class(TForm)
    OKBtn: TBitBtn;
    HelpBtn: TBitBtn;
    Bevel1: TBevel;
    Label1: TLabel;
    BitBtn1: TBitBtn;
    SpinEdit: TSpinEdit;
    procedure OKBtnClick(Sender: TObject);
    procedure HelpBtnClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  TenderNumDlg: TTenderNumDlg;

implementation

{$R *.DFM}

uses
  Msg;

procedure TTenderNumDlg.OKBtnClick(Sender: TObject);
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
      MessageDlg(mTendersNumIs0,mtError,[mbOk],0);
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

procedure TTenderNumDlg.HelpBtnClick(Sender: TObject);
begin
  Application.HelpContext(102);
end;

end.

var
  l:LongInt;
  s:String;
begin
  if not (Key in ['0'..'9',#8])
    then Key:=#0;
{  if (Key<>#0) and (SpinEdit.Text<>'')
    then begin
      if Key=#8
        then s:=Copy(SpinEdit.Text,1,Length(SpinEdit.Text)-1)
        else s:=SpinEdit.Text+Key;
      if s<>''
        then begin
          l:=StrToInt(s);
          if l>$FFFF
            then begin
              MessageDlg('Value big',mtError,[mbOk],0);
              Key:=#0;
            end;
        end;
     end;}


procedure TTenderNumDlg.SpinEditChange(Sender: TObject);
var
  i:Word;
  l:LongInt;
  s:String;
begin
{  if SpinEdit.Text=''
    then Exit;
  try
    s:=SpinEdit.Text;
    i:=StrToInt(s);
  except
    on EConvertError do
      MessageDlg('Convert Error',mtError,[mbOk],0);
    on ERangeError do
      MessageDlg('Range Error',mtError,[mbOk],0);
  end;}
end;


