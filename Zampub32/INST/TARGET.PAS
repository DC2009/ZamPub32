unit Target;

interface

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, StdCtrls, Buttons, ExtCtrls;

type
  TDirectoryForm = class(TForm)
    Panel1: TPanel;
    DirEdit: TEdit;
    DirLabel: TLabel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
  public
    function ShowForm(const LabelCap, DefaultDir: String): integer;
  end;

var
  DirectoryForm: TDirectoryForm;

implementation

{$R *.DFM}

function TDirectoryForm.ShowForm(const LabelCap, DefaultDir: String): integer;
{ this is the interface function for DirectoryForm. It allows the controls }
{ to be initialized before showing form. }
begin
  DirLabel.Caption := LabelCap;
  DirEdit.Text := DefaultDir;
  Result := ShowModal;
end;

end.
