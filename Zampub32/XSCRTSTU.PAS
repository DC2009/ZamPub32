unit Xscrtstu;

interface

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, StdCtrls;

type
  TForm1 = class(TForm)
    Button1: TButton;
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

{$R *.DFM}

uses
  TypZam,
  Amount;

procedure TForm1.Button1Click(Sender: TObject);
var
  l:Real;
  A:Integer;
  s,z:String;
begin
  L:=30;
  GetSiwzAmount(L,A);
  Str(l:10:2,s);
  Str(a,z);
  Button1.Caption:='Amount = '+s+'  Level = '+z;
end;

procedure TForm1.Button2Click(Sender: TObject);
var
  l:LongInt;
  s:String;
begin
  L:=GetTypZamowienia;
  Str(l,s);
  Button2.Caption:=s;
end;

end.
