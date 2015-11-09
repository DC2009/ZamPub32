unit DrDllI;

interface

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, StdCtrls, Buttons, Menus, ExtCtrls;

type
  EDLLLoadError = class(Exception);

procedure OboDrukZp(ZpNum:Integer);
procedure ZalDrukZp(ZpNum:Integer);
procedure PomDruk(S:String);

implementation

uses
  Utils,
  SiwzIni,
  DrMsg;

procedure OboDrukZp(ZpNum:Integer);
var
  LibHandle:THandle;
  PM:Procedure;
  s:String;
begin
  try
    GetAllConfiguration;
    s:=AddBackSlash(ProgramDir)+'DROBO.DLL ';
    LibHandle:=LoadLibrary(StringAsPChar(s));
    if LibHandle<32
      then raise EDLLLoadError.Create(mUnableToLoadDLL+s+' (B³¹d '+IntToStr(LibHandle)+').');
    s:='DRUKZP'+IntToStr(ZpNum);
    @PM:=GetProcAddress(LibHandle,StringAsPChar(s));
    PM;
    FreeLibrary(LibHandle);
  except
    on E:EDLLLoadError do
      MessageDlg(E.Message,mtInformation,[mbOk],0);
  end;
end;

procedure ZalDrukZp(ZpNum:Integer);
var
  LibHandle:THandle;
  PM:Procedure;
  s:String;
begin
  try
    GetAllConfiguration;
    s:=AddBackSlash(ProgramDir)+'DRZAL.DLL';
    LibHandle:=LoadLibrary(StringAsPChar(s));
    if LibHandle<32
      then raise EDLLLoadError.Create(mUnableToLoadDLL+s+' (B³¹d '+IntToStr(LibHandle)+').');
    s:='DRUKZP'+IntToStr(ZpNum);
    @PM:=GetProcAddress(LibHandle,StringAsPChar(s));
    PM;
    FreeLibrary(LibHandle);
  except
    on E:EDLLLoadError do
      MessageDlg(E.Message,mtInformation,[mbOk],0);
  end;
end;

procedure PomDruk(S:String);
var
  LibHandle:THandle;
  PM:Procedure;
begin
  try
    LibHandle:=LoadLibrary('DRPOM.DLL');
    if LibHandle<32
      then raise EDLLLoadError.Create(mUnableToLoadDLL+'DRPOM.DLL');
    @PM:=GetProcAddress(LibHandle,StringAsPChar(s));
    PM;
    FreeLibrary(LibHandle);
  except
    on E:EDLLLoadError do
      MessageDlg(E.Message,mtInformation,[mbOk],0);
  end;
end;

end.
