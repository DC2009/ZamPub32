unit Pwd;

interface

uses WinTypes, WinProcs, Classes, Graphics, Forms, Controls, StdCtrls,
  Buttons, Dialogs, IniFiles,
  SiwzIni,
  Utils,
  Main,
  UserUnit;

const
  emEmptyName='Nazwa nie zosta³a podana';
  emEmptyPwd='Has³o nie zosta³o podane';
  emDifferentPwds='Has³a nie s¹ jednakowe';

type
  TPwdDlg = class(TForm)
    Label2: TLabel;
    Edit2: TEdit;
    OKBtn: TBitBtn;
    CancelBtn: TBitBtn;
    Edit1: TEdit;
    Label1: TLabel;
    Label3: TLabel;
    Edit3: TEdit;
    procedure OKBtnClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  PwdDlg: TPwdDlg;

implementation

{$R *.DFM}

procedure TPwdDlg.OKBtnClick(Sender: TObject);
var
  IniFile:TIniFile;
  InstDir:String;
  DbDir:String;
  SysDir:String;
  FN:String;
begin
  ModalResult:=mrOk;
  if Edit1.Text=''
    then begin
      MessageDlg(emEmptyName,mtError,[mbOk],0);
      ActiveControl:=Edit1;
      ModalResult:=0;
    end
  else if (Edit2.Text='') or (Edit3.Text='')
    then begin
      MessageDlg(emEmptyPwd,mtError,[mbOk],0);
      if Edit2.Text=''
        then ActiveControl:=Edit2
        else ActiveControl:=Edit3;
      ModalResult:=0;
    end
  else if (Edit2.Text<>Edit3.Text)
    then begin
      MessageDlg(emDifferentPwds,mtError,[mbOk],0);
      ActiveControl:=Edit2;
      ModalResult:=0;
    end
  else begin
    IniFile:=TIniFile.Create(IniName);
    InstDir:=IniFile.ReadString('General','DefaultDir','');
    DbDir:=IniFile.ReadString('General','DatabaseDir','');
    SysDir:=IniFile.ReadString('General','ZPSystemDir','');
    IniFile.Free;
    UList.Create;
    UList.AddUser(Edit1.Text,Edit2.Text,SuperChar);
    Ulist.AddDb(AddBackSlash(AddBackSlash(InstDir)+DbDir),0);
    FN:=AddBackSlash(AddBackSlash(InstDir)+SysDir)+SecurityFileName;
    UList.SaveToFile(AddBackSlash(AddBackSlash(InstDir)+SysDir)+SecurityFileName);
    UList.Free;
  end;
end;

end.

