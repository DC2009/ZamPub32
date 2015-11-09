unit Pwdchg;

interface

uses WinTypes, WinProcs, Classes, Graphics, Forms, Controls, StdCtrls,
  Buttons, Dialogs, Messages,
  UserUnit;

const
  wmOldPwdIncorrect='Stare has³o nieprawid³owe';
  wmDifferentPwd='B³êdne nowe has³o';

type
  TChgPwdDlg = class(TForm)
    Label1: TLabel;
    OldPwdEdit: TEdit;
    OKBtn: TBitBtn;
    CancelBtn: TBitBtn;
    NewPwdEdit1: TEdit;
    Label2: TLabel;
    NewPwdEdit2: TEdit;
    Label3: TLabel;
    procedure OKBtnClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
    OldPwd:String;
  end;

  TChangePasswordDialog = class(TComponent)
  private
    { Private declarations }
    FPwdDlg:TChgPwdDlg;
    FUserName:String;
    FUserPwd:String;
    FUserType:Byte;
    FUList:TUserList;
  protected
    { Protected declarations }
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function Execute:Boolean;
  published
    { Published declarations }
    property UserName:String read FUserName write FUserName;
    property UserPassword:String read FUserPwd write FUserPwd;
    property UserType:Byte read FUserType write FUserType;
  end;

procedure Register;

implementation

{$R *.DFM}
uses
  Utils,
  SiwzIni;

procedure Register;
begin
  RegisterComponents('Zampub3', [TChangePasswordDialog]);
end;

constructor TChangePasswordDialog.Create(AOwner: TComponent);
begin
  GetAllConfiguration;
  FUList:=TUserList.Create;
  FUList.FileName:=AddBackSlash(ProgramDir)+SecurityFilename;
  FUList.Load;
end;

destructor TChangePasswordDialog.Destroy;
begin
  FUList.Free;
end;

function TChangePasswordDialog.Execute:Boolean;
var
  Ok:Boolean;
begin
  Ok:=FALSE;
  FPwdDlg:=TChgPwdDlg.Create(Application);
  try
    FPwdDlg.OldPwd:=UserPwd;
    if FPwdDlg.ShowModal=mrOk
      then begin
        FUList.SetPwd(UserName,FPwdDlg.NewPwdedit1.Text);
        FUList.Save;
      end;
  finally
    FPwdDlg.Free;
  end;
  Result:=OK;
end;

procedure TChgPwdDlg.OKBtnClick(Sender: TObject);
begin
  ModalResult:=0;
  if OldPwdEdit.Text<>OldPwd
    then begin
      MessageDlg(wmOldPwdIncorrect,mtWarning,[mbOk],0);
      ActiveControl:=OldPwdEdit;
      Exit;
    end;
  if (NewPwdEdit1.Modified or NewPwdEdit2.Modified) and
     (NewPwdEdit1.Text<>NewPwdEdit2.Text)
    then begin
      MessageDlg(wmDifferentPwd,mtWarning,[mbOk],0);
      ActiveControl:=NewPwdEdit1;
      Exit;
    end;

  if OldPwdEdit.Text<>'' {if no user is given at the beginning}
    then ModalResult:=mrOk;
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

