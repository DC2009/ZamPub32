program Xscrtest;

uses
  Forms,
  Scrtest in 'SCRTEST.PAS' {Form1},
  Wybtryb in 'WYBTRYB.PAS';


{$R *.RES}

begin
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
