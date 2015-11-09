unit Chgpwd;

interface

uses WinTypes, WinProcs, Classes, Graphics, Forms, Controls, StdCtrls,
  Buttons, Dialogs, Messages,
  Utils,
  SiwzIni,
  UserUnit;

type
  TChgPwdDlg = class(TForm)
    Label1: TLabel;
    OldPwdEdit: TEdit;
    OKBtn: TBitBtn;
    CancelBtn: TBitBtn;
    Label2: TLabel;
    NewPwdEdit: TEdit;
    Label3: TLabel;
    RepeatPwdEdit: TEdit;
    procedure OKBtnClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    FUList:TUserList;
    function UserOk:Boolean;
  public
    UserName:String;
    { Public declarations }
  end;

var
  ChgPwdDlg: TChgPwdDlg;

procedure ChangePwd(AName:String);export;

implementation

{$R *.DFM}

procedure ChangePwd(AName:String);
var
  PD:TChgPwdDlg;
begin
  PD:=TChgPwdDlg.Create(Nil);
  with PD do
    begin
      UserName:=AName;
      ShowModal;
      Free;
    end;
end;

procedure TChgPwdDlg.OKBtnClick(Sender: TObject);
begin
  ModalResult:=0;
  if not UserOk
    then begin
      MessageDlg('Stare has³o niew³aœciwe',mtWarning,[mbOk],0);
      OldPwdEdit.SetFocus;
    end
  else if (NewPwdEdit.Text<>RepeatPwdEdit.Text)
    then begin
      MessageDlg('Nowe has³o nieprawid³owe',mtWarning,[mbOk],0);
      NewPwdEdit.SetFocus;
    end
  else begin
    ModalResult:=mrOk;
    FUList.EditUser(UserName,UserName,NewPwdEdit.Text,FUList.GetKind(UserName),FUList.GetRights(UserName));
    FUList.Save;
  end;
end;

procedure TChgPwdDlg.FormCreate(Sender: TObject);
begin
  GetAllConfiguration;
  FUList:=TUserList.Create;
  FUList.FileName:=AddBackSlash(ProgramDir)+SecurityFilename;
  FUList.Load;
end;

procedure TChgPwdDlg.FormDestroy(Sender: TObject);
begin
  FUList.Free;
end;

function TChgPwdDlg.UserOk:Boolean;
begin
  Result:=FUList.NamePwdOk(UserName,OldPwdEdit.Text);
end;

procedure TChgPwdDlg.FormActivate(Sender: TObject);
begin
  Caption:='Zmieñ has³o ('+Username+')';
end;

procedure TChgPwdDlg.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key=#13
    then begin
      Key:=#0;
      Perform(wm_NextDlgCtl,0,0);
    end;
end;

end.
 
