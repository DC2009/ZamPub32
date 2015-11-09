unit Ulogin;

interface

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Forms, Dialogs;

type
  TPasswordDlg = class(TForm)
  private
    { Private declarations }
{    FPassword:String;}
    FCaption:String;
{   procedure Create(Sender: TObject);}
  protected
    { Protected declarations }
  public
    { Public declarations }
{    destructor Destroy; override;}
  published
    { Published declarations }
    property Caption:String read FCaption write FCaption;
{    property Password:String read FPassword write FPassword;}
  end;

  TPasswordDialog = class(TComponent)
  private
    { Private declarations }
    FPwdDlg:TPasswordDlg;
    FPassword:String;
    FCaption:String;
  protected
    { Protected declarations }
  public
    { Public declarations }
{    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;}
    function Execute:Boolean;
  published
    { Published declarations }
{    property Caption:String read FCaption write FCaption;}
    property Password:String read FPassword write FPassword;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('Dialogs', [TPasswordDialog]);
end;

function TPasswordDialog.Execute:Boolean;
begin
  FPwdDlg:=TPasswordDlg.Create(Application);
  try
    Result:=FPwdDlg.ShowModal=mrOk;
  finally
    FPwdDlg.Free;
  end;
end;

{rocedure TPasswordDlg.FormCreate(Sender: TObject);
begin
  inherited Create(AOwner);
  FCaption:='Password';
end;

estructor TPasswordDlg.Destroy;
begin

  inherited Destroy;
end;
}
initialization
  RegisterClasses([TPasswordDlg]);
end.
