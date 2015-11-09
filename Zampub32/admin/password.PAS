unit Password;

interface

uses WinTypes, WinProcs, Classes, Graphics, Forms, Controls, StdCtrls,
  Buttons, Dialogs, SysUtils, Messages,
  Utils,
  SiwzIni,
  UserUnit,
  ExtCtrls;

{Super user}
{ TELESOFT }
{Super password}
{ ##PANDORO## }

const
  wmUserNameEmpty='Pole "U¿ytkownik" nie mo¿e byæ puste';
{  wmPasswordEmpty='Pole "Has³o" nie mo¿e byæ puste';}

type
  TPasswordDlg = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Panel2: TPanel;
    UserLabel: TLabel;
    PasswordLabel: TLabel;
    UserEdit: TEdit;
    PasswordEdit: TEdit;
    OKBtn: TBitBtn;
    CancelBtn: TBitBtn;
    Image1: TImage;
    procedure OKBtnClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
    UserKind:Byte;
  public
    { Public declarations }
  end;

  TPasswordDialog = class(TComponent)
  private
    { Private declarations }
    FPwdDlg:TPasswordDlg;
    FUserName:String;
    FUserPwd:String;
    FUserType:Byte;
    FUserRights:Byte;
    FUList:TUserList;
  protected
    { Protected declarations }
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function Execute:Boolean;
    function UserOk:Boolean;
    function GetType:Byte;
    function GetRights:Byte;
  published
    { Published declarations }
    property UserName:String read FUserName write FUserName;
    property UserPassword:String read FUserPwd write FUserPwd;
    property UserType:Byte read FUserType write FUserType;
    property UserRights:Byte read FUserRights write FUserRights;
  end;

function UserLogin(var AName,APwd:String; var AType,ARights:Byte):Boolean;export;

implementation

{$R *.DFM}

function UserLogin(var AName,APwd:String; var AType,ARights:Byte):Boolean;
var
  PD:TPasswordDialog;
begin
  PD:=TPasswordDialog.Create(Nil);
  with PD do
    begin
      if Execute
        then begin
          AName:=UserName;
          APwd:=UserPassword;
          AType:=UserType;
          ARights:=FUserRights;
          Result:=TRUE;
        end
        else begin
          AName:='';
          APwd:='';
          AType:=0;
          ARights:=0;
          Result:=FALSE;
        end;
      Free;
    end;
end;

constructor TPasswordDialog.Create(AOwner: TComponent);
begin
  GetAllConfiguration;
  FUList:=TUserList.Create;
  FUList.FileName:=AddBackSlash(ProgramDir)+SecurityFilename;
  FUList.Load;
end;

destructor TPasswordDialog.Destroy;
begin
  FUList.Free;
end;

function TPasswordDialog.Execute:Boolean;
var
  Ok:Boolean;
  Cnt:Byte;
  SM:Integer;
begin
  Ok:=FALSE;
  FPwdDlg:=TPasswordDlg.Create(Application);
  try
    Cnt:=1;
    repeat
      SM:=FPwdDlg.ShowModal;
      if SM=mrOk
        then begin
          FUserName:=FPwdDlg.UserEdit.Text;
          FUserPwd:=FPwdDlg.PasswordEdit.Text;
          if (FUserName=SuperUserName) and (FUserPwd=SuperPassword)
            then begin
              Ok:=TRUE;
              FUserType:=utSupervisor;
              FUserRights:=$FF;
            end
            else begin
              Ok:=UserOk;
              if Ok
                then begin
                  FUserType:=GetType;
                  FUserRights:=GetRights;
                end
                else MessageDlg('Nieznany u¿ytkownik',mtWarning,[mbOk],0);
            end;
        end;
      Inc(Cnt);
    until Ok or (Cnt>3) or (SM=mrCancel)
  finally
    FPwdDlg.Free;
  end;
  Result:=OK;
end;

function TPasswordDialog.UserOk:Boolean;
var
  Ok:Boolean;
begin
  Result:=FALSE;
  Ok:=(FUserName=SuperUserName) and (FUserPwd=SuperPassword);
  if not Ok
    then begin
      Ok:=FUList.NamePwdOk(FUserName,FUserPwd);
    end;
  Result:=Ok;
end;

function TPasswordDialog.GetType:Byte;
begin
  Result:=FUList.GetKind(FUserName);
end;

function TPasswordDialog.GetRights:Byte;
begin
  Result:=FUList.GetRights(FUserName);
end;

procedure TPasswordDlg.OKBtnClick(Sender: TObject);
begin
  ModalResult:=0;
  if UserEdit.Text=''
    then MessageDlg(wmUserNameEmpty,mtWarning,[mbOk],0)
  else ModalResult:=mrOk;
end;

procedure TPasswordDlg.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key=#13
    then begin
      Key:=#0;
      Perform(wm_NextDlgCtl,0,0);
    end;
end;

procedure TPasswordDlg.FormActivate(Sender: TObject);
begin
  UserEdit.SetFocus;
end;

end.

