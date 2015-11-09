unit Admmain;

interface

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, StdCtrls, ExtCtrls, Buttons,
  SiwzIni, Pwd, UserUnit, User, Utils,
  ChgPwd,
  SkOk,
  Sk;

type
  TMain = class(TForm)
    Image1: TImage;
    UserBtn: TButton;
    PwdBtn: TButton;
    Label1: TLabel;
    Label2: TLabel;
    BitBtn1: TBitBtn;
    AdmPwdBtn: TButton;
    Sk: TSmartKey;
    procedure PwdBtnClick(Sender: TObject);
    procedure UserBtnClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure AdmPwdBtnClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
    FileNotFound:Boolean;
    Password:String;
    SavePwd:Boolean;
    SaveUsers:Boolean;
    procedure Load;
    procedure Save;
  public
    { Public declarations }
    UserName:String;
  end;

var
  Main: TMain;

implementation

{$R *.DFM}

procedure TMain.FormCreate(Sender: TObject);
begin
  GetAllConfiguration;
  FileNotFound:=FALSE;
  UserList:=TUserList.Create;
  UserList.FileName:=AddBackSlash(ProgramDir)+SecurityFilename;
  Load;
  Password:=UserList.Password;
end;

procedure TMain.FormDestroy(Sender: TObject);
begin
  UserList.Free;
end;

procedure TMain.PwdBtnClick(Sender: TObject);
begin
{  PwdDlg.Pwdedit.Text:=Password;}
  SavePwd:=PwdDlg.ShowModal=mrOk;
  if SavePwd
    then begin
      Password:=PwdDlg.PwdEdit.Text;
      UserList.Password:=Password;
      Save;
    end;
end;

procedure TMain.UserBtnClick(Sender: TObject);
begin
  UserDlg.ShowModal;
  Save;
end;

procedure TMain.Save;
begin
  UserList.Save;
end;

procedure TMain.Load;
begin
  UserList.Load;
end;

procedure TMain.AdmPwdBtnClick(Sender: TObject);
begin
  ChangePwd(UserName);
end;

procedure TMain.FormActivate(Sender: TObject);
begin
{$IFDEF NONET}
  if not SmartKeyOk(Sk,SkData)
    then Close;
{$ENDIF}
end;

end.
