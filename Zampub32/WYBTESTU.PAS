unit Wybtestu;

interface

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, StdCtrls;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Label1: TLabel;
    Button2: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses
  WybTryb,
  Amount,
  SiwzIni;

{$R *.DFM}

procedure TForm1.Button1Click(Sender: TObject);
var
  i:Integer;
  s:String;
begin
  i:=GetTrybZamowienia(alMin);
  Str(i,s);
  Label1.Caption:=s;
end;

procedure TForm1.Button2Click(Sender: TObject);
var
  PLN:Real;
  Level:Integer;
begin
  GetSiwzAmount(PLN,Level);
  Button2.Caption:=IntToStr(Level);
end;

end.
