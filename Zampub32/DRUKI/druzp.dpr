program Druzp;

uses
  Forms,
  Dialogs,
  SysUtils,
  Drkmain in 'DRKMAIN.PAS' {MainDlg},
  Rprev in 'RPREV.PAS' {RyPreviewFrm},
  Siwzini in '\ZAMPUB32\SIWZINI.PAS',
  ZpBoxes in 'ZPBOXES.PAS',
  Password in '\ZAMPUB32\ADMIN\PASSWORD.PAS' {PasswordDlg},
  Sk in '\DELPHI\TELESOFT\SK.PAS';

{$R *.RES}

var
  AName,APwd:String;
  AType,ARights:Byte;
  RunOk:Boolean;
{$IFDEF NET}
  SKey:TSmartKey;
  OkSk:Boolean;
{$ENDIF}

begin
{$IFDEF NET}
  SKey:=TSmartKey.Create(Nil);
  SKey.SkLabel:=SmartKeyLabel;
  SKey.SkPassword:=SmartKeyPwd;
  SKey.Open(DruZpNetNum);
  OkSk:=SKey.Status=0;
  if not OkSk
    then begin
      MessageDlg(SKey.StatusMessage,mtWarning,[mbOk],0);
      SKey.Close;
      SKey.Free;
      Exit;
    end;
{$ENDIF}
  RunOk:=TRUE;
  GetAllConfiguration;
{$IFNDEF DEMO}
  RunOk:=UserLogin(AName,APwd,AType,ARights);
{$ENDIF}
  if RunOk
    then begin
      Application.CreateForm(TMainDlg, MainDlg);
      Application.Run;
    end;
{$IFDEF NET}
  if OkSk
    then begin
      SKey.Close;
      SKey.Free;
    end;
{$ENDIF}
end.
