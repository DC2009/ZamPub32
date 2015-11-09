program Rap;

uses
  Forms,
  Dialogs,
  SysUtils,
  Rapmain in 'RAPMAIN.PAS' {MainDlg},
  Rprev in 'RPREV.PAS' {RyPreviewFrm},
  Password in '\ZAMPUB2\ADMIN\PASSWORD.PAS' {PasswordDlg},
  Siwzini in '\ZAMPUB2\SIWZINI.PAS',
  Regpom in 'REGPOM.PAS' {RegulaminDlg},
  Oswpom in 'OSWPOM.PAS' {OswDlg},
  UserUnit in '\ZAMPUB2\ADMIN\USERUNIT.PAS',
  Decpom in 'DECPOM.PAS' {DecyzjaDlg},
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
  SKey.Open(RapNetNum);
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
