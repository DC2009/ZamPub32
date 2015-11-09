unit Lmain;

interface

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Forms, Dialogs,
  Password, StdCtrls, Buttons;

type
  TPrologForm = class(TForm)
    BitBtn1: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
    PD:TPasswordDialog;
  public
    { Public declarations }
  end;

var
  PrologForm: TPrologForm;

implementation

{$R *.DFM}

procedure TPrologForm.FormCreate(Sender: TObject);
begin
  PD:=TPasswordDialog.Create(Self);
end;

procedure TPrologForm.FormDestroy(Sender: TObject);
begin
  PD.Free;
end;

procedure TPrologForm.FormActivate(Sender: TObject);
begin
  PD.Execute;
end;

end.
