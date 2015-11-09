unit Rodzaj;

interface

uses WinTypes, WinProcs, Classes, Graphics, Forms, Controls, Buttons,
  StdCtrls, ExtCtrls,
  SiwzIni,
  TypZam;

type
  TRodzajDlg = class(TForm)
    OKBtn: TBitBtn;
    CancelBtn: TBitBtn;
    Bevel1: TBevel;
    Label1: TLabel;
    ChgBtn: TButton;
    Edit: TEdit;
    procedure ChgBtnClick(Sender: TObject);
  private
    { Private declarations }
    TenderType:Integer;
  public
    { Public declarations }
    OKind:Integer;
    procedure SetEdit(TType,i:Integer);
  end;

var
  RodzajDlg: TRodzajDlg;

implementation

{$R *.DFM}

procedure TRodzajDlg.SetEdit(TType,i:Integer);
begin
  TenderType:=TType;
  case i of
    okDostawa:Edit.Text:='Dostawa';
    okUslugi:Edit.Text:='Us³ugi';
    okRobBud:Edit.Text:='Roboty budowlane';
    else Edit.Text:='';
  end;{case}
end;

procedure TRodzajDlg.ChgBtnClick(Sender: TObject);
var
  i:Integer;
begin
  i:=GetTypZamowienia(TenderType<>ttZap);
  if i>-1
    then begin
      OKind:=i;
      SetEdit(TenderType,OKind);
    end;
end;

end.
