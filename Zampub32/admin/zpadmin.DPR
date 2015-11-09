program Zpadmin;

uses
  Forms,
  Dialogs,
  Admmain in 'ADMMAIN.PAS' {Main},
  Pwd in 'PWD.PAS' {PwdDlg},
  User in 'USER.PAS' {UserDlg},
  Useredit in 'USEREDIT.PAS' {UserEditDlg},
  Siwzini in '\ZAMPUB32\SIWZINI.PAS',
  UserUnit in 'USERUNIT.PAS',
  Password in 'PASSWORD.PAS' {PasswordDlg},
  Chgpwd in 'CHGPWD.PAS' {ChgPwdDlg},
  Sk in '\DELPHI\TELESOFT\SK.PAS';

{$R *.RES}
var
  AName,APwd:String;
  AType,ARights:Byte;
  s:String;
{$IFDEF NET}
  SKey:TSmartKey;
  OkSk:Boolean;
{$ENDIF}

begin
{$IFDEF NET}
  SKey:=TSmartKey.Create(Nil);
  SKey.SkLabel:=SmartKeyLabel;
  SKey.SkPassword:=SmartKeyPwd;
  SKey.Open(AdminNetNum);
  OkSk:=SKey.Status=0;
  if not OkSk
    then begin
      MessageDlg(SKey.StatusMessage,mtWarning,[mbOk],0);
      SKey.Close;
      SKey.Free;
      Exit;
    end;
{$ENDIF}
  GetAllConfiguration;
  if UserLogin(AName,APwd,AType,ARights) and (AType=utSupervisor)
    then begin
      Application.CreateForm(TMain, Main);
      Application.CreateForm(TPwdDlg, PwdDlg);
      Application.CreateForm(TUserDlg, UserDlg);
      Main.UserName:=AName;
      Application.Run;
    end
  else if (AType=utUser)
    then MessageDlg('U¿ytkownik nie autoryzowany',mtWarning,[mbOk],0);
{$IFDEF NET}
  if OkSk
    then begin
      SKey.Close;
      SKey.Free;
    end;
{$ENDIF}
end.
