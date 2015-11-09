program Instaluj;

uses
  Forms,
  SysUtils,
  Dialogs,
  Main in 'MAIN.PAS' {SetupForm},
  Target in 'TARGET.PAS' {DirectoryForm},
  Pm in 'PM.PAS',
  Utils in '\DELPHI\TELESOFT\UTILS.PAS';

{$R *.RES}

const
  ErrBadParam = 'Uruchom INSTAL.EXE aby zacz¹æ instalacjê.';
  ErrNoIni    = 'Zbiór instalacyjny nie znaleziony';

begin
  if not FileExists(ExtractFilePath(ParamStr(0)) + IniFileName) then
    MessageDlg(ErrNoIni, mtError, [mbOk], 0)
  else begin
    Application.CreateForm(TSetupForm, SetupForm);
  Application.CreateForm(TDirectoryForm, DirectoryForm);
  Application.Run;
  end;
end.
