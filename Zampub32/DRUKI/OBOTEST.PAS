unit Obotest;

interface

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, StdCtrls;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    Button7: TButton;
    Button8: TButton;
    Button9: TButton;
    Button10: TButton;
    Button11: TButton;
    Button12: TButton;
    Button13: TButton;
    Button14: TButton;
    Button15: TButton;
    Button16: TButton;
    Button17: TButton;
    Button18: TButton;
    Button19: TButton;
    Button20: TButton;
    Button21: TButton;
    Button22: TButton;
    Button23: TButton;
    Button24: TButton;
    Button25: TButton;
    Button26: TButton;
    Button27: TButton;
    Button28: TButton;
    Button29: TButton;
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure Button9Click(Sender: TObject);
    procedure Button10Click(Sender: TObject);
    procedure Button11Click(Sender: TObject);
    procedure Button12Click(Sender: TObject);
    procedure Button13Click(Sender: TObject);
    procedure Button14Click(Sender: TObject);
    procedure Button15Click(Sender: TObject);
    procedure Button16Click(Sender: TObject);
    procedure Button18Click(Sender: TObject);
    procedure Button19Click(Sender: TObject);
    procedure Button20Click(Sender: TObject);
    procedure Button21Click(Sender: TObject);
    procedure Button22Click(Sender: TObject);
    procedure Button23Click(Sender: TObject);
    procedure Button24Click(Sender: TObject);
    procedure Button25Click(Sender: TObject);
    procedure Button17Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button26Click(Sender: TObject);
    procedure Button27Click(Sender: TObject);
    procedure Button28Click(Sender: TObject);
    procedure Button29Click(Sender: TObject);
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
  SiwzIni,
  UserUnit,
  zp1,
  zp11,
  zp12,
  zp13,
  zp14,
  zp21,
  zp31,
  zp41,
  zp42,
  zp43,
  zp44,
  zp45,
  zp46,
  zp54,
  zp61,
  zp71,
  ZP81,
  zp110,
  zp121,
  zp150,
  zp160,
  zp170,
  zp120,
  zp130,
  zp140,
  zp141,
  zp210,
  decpom,
  regpom;

procedure TForm1.Button2Click(Sender: TObject);
begin
  Zp11Dlg:=TZp11Dlg.Create(nil);
  Zp11Dlg.ShowModal;
  Zp11Dlg.Free;
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  Zp12Dlg:=TZp12Dlg.Create(nil);
  Zp12Dlg.ShowModal;
  Zp12Dlg.Free;
end;

procedure TForm1.Button4Click(Sender: TObject);
begin
  DrukZp13;
end;

procedure TForm1.Button5Click(Sender: TObject);
begin
  DrukZp14;
end;

procedure TForm1.Button6Click(Sender: TObject);
begin
  DrukZp21;
end;

procedure TForm1.Button7Click(Sender: TObject);
begin
  DrukZp31;
end;

procedure TForm1.Button8Click(Sender: TObject);
begin
  DrukZp41;
end;

procedure TForm1.Button9Click(Sender: TObject);
begin
  DrukZp42;
end;

procedure TForm1.Button10Click(Sender: TObject);
begin
  DrukZp43;
end;

procedure TForm1.Button11Click(Sender: TObject);
begin
  DrukZp54;
end;

procedure TForm1.Button12Click(Sender: TObject);
begin
  DrukZp44;
end;

procedure TForm1.Button13Click(Sender: TObject);
begin
  DrukZp45;
end;

procedure TForm1.Button14Click(Sender: TObject);
begin
  DrukZP46;
end;

procedure TForm1.Button15Click(Sender: TObject);
begin
  DrukZp61;
end;

procedure TForm1.Button16Click(Sender: TObject);
begin
  DrukZp71;
end;

procedure TForm1.Button18Click(Sender: TObject);
begin
  DrukZp110;
end;

procedure TForm1.Button19Click(Sender: TObject);
begin
  DrukZP121;
end;

procedure TForm1.Button20Click(Sender: TObject);
begin
  DrukZP150;
end;

procedure TForm1.Button21Click(Sender: TObject);
begin
  DrukZp120;
end;

procedure TForm1.Button22Click(Sender: TObject);
begin
  DrukZp130;
end;

procedure TForm1.Button23Click(Sender: TObject);
begin
  DrukZp140;
end;

procedure TForm1.Button24Click(Sender: TObject);
begin
  DrukZp141;
end;

procedure TForm1.Button25Click(Sender: TObject);
begin
  DrukZp210;
end;

procedure TForm1.Button17Click(Sender: TObject);
begin
  dRUKzP81;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  DrukZP1;
end;

procedure TForm1.Button26Click(Sender: TObject);
begin
  Decyzja;
end;

procedure TForm1.Button27Click(Sender: TObject);
begin
  Regulamin;
end;

procedure TForm1.Button28Click(Sender: TObject);
begin
  DrukZP160;
end;

procedure TForm1.Button29Click(Sender: TObject);
begin
  DrukZP170;
end;

end.
