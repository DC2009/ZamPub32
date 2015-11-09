program Siwz;

uses
  Forms,
  WinCrt,
  SysUtils,
  Dialogs,
  WinTypes,
  WinProcs,
  Messages,
  Classes,
  Graphics,
  Controls,
  StdCtrls,
  Buttons,
  Menus,
  ExtCtrls,
  Siwzmain in 'SIWZMAIN.PAS' {MainDlg},
  Siwzini in 'SIWZINI.PAS',
  Art71 in 'ART71.PAS' {Art71Dlg},
  Msg2 in 'MSG2.PAS',
  Utils in '\DELPHI\TELESOFT\UTILS.PAS',
  UserUnit in 'ADMIN\USERUNIT.PAS',
  Infodlg in 'INFODLG.PAS' {UserInfoDlg},
  Prefkraj in 'PREFKRAJ.PAS' {PrefKrajoweDlg},
  Prt1ini in 'PRT1INI.PAS',
  Prt1 in 'PRT1.PAS' {Prt1Dlg},
  Prt2 in 'PRT2.PAS' {Prt2Dlg},
  Prt5 in 'PRT5.PAS' {Prt5Dlg},
  Prt4 in 'PRT4.PAS' {Prt4Dlg},
  Kriteria in 'OCENA\KRITERIA.PAS' {KriteriaDlg},
  About in 'ABOUT.PAS' {AboutBox},
  Password in 'ADMIN\PASSWORD.PAS' {PasswordDlg},
  Chgpwd in 'ADMIN\CHGPWD.PAS' {ChgPwdDlg},
  Oferent in 'OFERENT.PAS' {OferentDlg},
  Amount in 'AMOUNT.PAS' {AmountDlg},
  TypZam in 'TYPZAM.PAS' {TypZamDlg},
  Sk in '\DELPHI\TELESOFT\SK.PAS',
  Wybtryb in 'WYBTRYB.PAS',
  Prt3 in 'PRT3.PAS' {Prt3Dlg};

{$R *.RES}

var
  RunOk:Boolean;
  AName,APwd:String;
  AType:Byte;
  ARights:Byte;
{$IFDEF NET}
  SKey:TSmartKey;
  OkSk:Boolean;
{$ENDIF}

begin
{$IFDEF NET}
  SKey:=TSmartKey.Create(Nil);
  SKey.SkLabel:=SmartKeyLabel;
  SKey.SkPassword:=SmartKeyPwd;
  SKey.Open(SiwzNetNum);
  OkSk:=SKey.Status=0;
  if not OkSk
    then begin
      MessageDlg(SKey.StatusMessage,mtWarning,[mbOk],0);
      SKey.Close;
      SKey.Free;
      Exit;
    end;
{$ENDIF}
  if HPrevInst=0
    then begin
      try
        GetWindowsDir;
        GetAllConfiguration;
{$IFDEF DEMO}
        AName:='TELESOFT';
        AType:=utSupervisor;
        RunOk:=TRUE;
        ARights:=$FF;
{$ELSE}
        RunOk:=UserLogin(AName,APwd,AType,ARights);
{$ENDIF}
        if RunOk
          then begin
            Application.Title := 'SIWZ 3.2';
            Application.CreateForm(TMainDlg, MainDlg);
            MainDlg.UserName:=AName;
            MainDlg.UserPwd:=APwd;
            MainDlg.UserType:=AType;
            MainDlg.UserRights:=ARights;
          end;
      finally
        Screen.Cursor:=0;
      end;
      if RunOk
        then Application.Run;
    end;
{$IFDEF NET}
  if OkSk
    then begin
      SKey.Close;
      SKey.Free;
    end;
{$ENDIF}
end.
