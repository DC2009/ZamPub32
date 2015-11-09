program Ocof;

uses
  Forms,
  Dialogs,
  Ocena1 in 'OCENA1.PAS' {OcenaMainDlg},
  Members in 'MEMBERS.PAS' {MembersDlg},
  Kriteria in 'KRITERIA.PAS' {KriteriaDlg},
  Msg in 'MSG.PAS',
  Subj in 'SUBJ.PAS' {SubjDlg},
  Tendernr in 'TENDERNR.PAS' {TenderNumDlg},
  Classify in 'CLASSIFY.PAS' {ClassifyDlg},
  Maxpts in 'MAXPTS.PAS' {MaxPtsDlg},
  Points in 'POINTS.PAS' {PointsDlg},
  Ofrtdta in 'OFRTDTA.PAS',
  Pwd in 'PWD.PAS' {PwdDlg},
  Newpwd in 'NEWPWD.PAS' {NewPwdDlg},
  Rprev in '\ZAMPUB32\DRUKI\RPREV.PAS' {RyPreviewFrm},
  Askofrt in 'ASKOFRT.PAS' {AskOfrtDlg},
  UserUnit in '\ZAMPUB32\ADMIN\USERUNIT.PAS',
  Siwzini in '\ZAMPUB32\SIWZINI.PAS',
  Price in 'PRICE.PAS' {PriceMarkDlg},
  Prefkraj in '\ZAMPUB32\PREFKRAJ.PAS' {PrefKrajoweDlg},
  Skok in '\ZAMPUB32\SKOK.PAS',
  Password in '\ZAMPUB32\ADMIN\PASSWORD.PAS' {PasswordDlg},
  Sk in '\DELPHI\TELESOFT\SK.PAS';

{$R *.RES}

var
{$IFNDEF DEMO}
  AName,APwd:String;
  AType,ARights:Byte;
{$ENDIF}
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
  SKey.Open(OcenaNetNum);
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
{$IFNDEF DEMO}
  RunOk:=UserLogin(AName,APwd,AType,ARights);
{$ENDIF}
  if RunOk
    then begin
      Application.Title := 'Ocena ofert';
      Application.CreateForm(TOcenaMainDlg, OcenaMainDlg);
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
