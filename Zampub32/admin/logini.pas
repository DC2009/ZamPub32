unit Logini;

interface

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, StdCtrls, Buttons, Menus, ExtCtrls;

type
  EDLLLoadError = class(Exception);

procedure ChangePwd(AName:String);
function UserLogin(var AName,APwd:String; var AType,ARights:Byte):Boolean;
{returns TRUE if the login is correct}

implementation

uses
  Msg2,
  SiwzIni,
  Utils;

const
  LibName='LOGIN.DLL';

function UserLogin(var AName,APwd:String; var AType,ARights:Byte):Boolean;
var
  LibHandle:THandle;
  fun:function (var AName,APwd:String; var AType,ARights:Byte):Boolean;
  s:String;
  p:PChar;
  OldCursor:Integer;
begin
  OldCursor:=Screen.Cursor;
  Screen.Cursor:=crHourGlass;
  Result:=FALSE;
  try
    s:=AddBackSlash(ProgramDir)+LibName;
    p:=StringAsPChar(s);
    LibHandle:=LoadLibrary(p);
    if LibHandle<32
      then raise EDLLLoadError.Create(mUnableToLoadDll+LibName);
    @Fun:=GetProcAddress(LibHandle, 'UserLogin');
    Result:=Fun(AName,APwd,AType,ARights);
    FreeLibrary(LibHandle);
  except
    on E:EDLLLoadError do
      MessageDlg(E.Message,mtWarning,[mbOk],0);
  end;
  Screen.Cursor:=OldCursor;
end;

procedure ChangePwd(AName:String);
var
  LibHandle:THandle;
  prc:procedure(AName:String);
  s:String;
  p:PChar;
  OldCursor:Integer;
begin
  OldCursor:=Screen.Cursor;
  Screen.Cursor:=crHourGlass;
  try
    s:=AddBackSlash(ProgramDir)+LibName;
    p:=StringAsPChar(s);
    LibHandle:=LoadLibrary(p);
    if LibHandle<32
      then raise EDLLLoadError.Create(mUnableToLoadDll+LibName);
    @Prc:=GetProcAddress(LibHandle, 'ChangePwd');
    Prc(AName);
    FreeLibrary(LibHandle);
  except
    on E:EDLLLoadError do
      MessageDlg(E.Message,mtWarning,[mbOk],0);
  end;
  Screen.Cursor:=OldCursor;
end;

end.
