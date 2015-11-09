unit AdmUtil;

interface

procedure InstallSelectedFIles(Nie,Ogr,Dwu,Neg,Zap,Zam:Boolean; SDir,DDir:String);
procedure DeleteAllFiles(Dir,FMask:String);
procedure DeleteUnselectedFiles(Nie,Ogr,Dwu,Neg,Zap,Zam:Boolean; Dir:String);

implementation

uses
  Msg2,
Controls, Buttons,
  Utils,
  Dialogs,
  SiwzIni,
  SysUtils,
  FileCtrl;

procedure InstallSelectedFIles(Nie,Ogr,Dwu,Neg,Zap,Zam:Boolean; SDir,DDir:String);
begin
  if Nie and
     not FileExists(AddBackSlash(DDir)+'DEFAULT.'+NieExt)
    then CopyFile(AddBackSlash(SDir)+'DEFAULT.'+NieExt,
                  AddBackSlash(DDir)+'DEFAULT.'+NieExt);
  if Ogr and
     not FileExists(AddBackSlash(DDir)+'DEFAULT.'+OgrExt)
    then CopyFile(AddBackSlash(SDir)+'DEFAULT.'+OgrExt,
                  AddBackSlash(DDir)+'DEFAULT.'+OgrExt);
  if Dwu and
     not FileExists(AddBackSlash(DDir)+'DEFAULT.'+DwuExt)
    then CopyFile(AddBackSlash(SDir)+'DEFAULT.'+DwuExt,
                  AddBackSlash(DDir)+'DEFAULT.'+DwuExt);
  if Neg and
     not FileExists(AddBackSlash(DDir)+'DEFAULT.'+NegExt)
    then CopyFile(AddBackSlash(SDir)+'DEFAULT.'+NegExt,
                  AddBackSlash(DDir)+'DEFAULT.'+NegExt);
  if Zap and
     not FileExists(AddBackSlash(DDir)+'DEFAULT.'+ZapExt)
    then CopyFile(AddBackSlash(SDir)+'DEFAULT.'+ZapExt,
                  AddBackSlash(DDir)+'DEFAULT.'+ZapExt);
  if Zam and
     not FileExists(AddBackSlash(DDir)+'DEFAULT.'+ZamExt)
    then CopyFile(AddBackSlash(SDir)+'DEFAULT.'+ZamExt,
                  AddBackSlash(DDir)+'DEFAULT.'+ZamExt);
end;

procedure DeleteAllFiles(Dir,FMask:String);
var
  CD:String;
  DE:Integer;
  SR:TSearchRec;
  TryAgain:Boolean;
begin
 GetDir(0,CD);
 ChDir(Dir);
 DE:=FindFirst(FMask,faArchive,SR);
 while DE=0 do
   begin
     repeat
       TryAgain:= not DeleteFile(AddBackSlash(Dir)+SR.Name);
       if TryAgain
         then begin
           TryAgain:=MessageDlg(wmFileNotDeleted+'^M'+wmTryAgain,
                                mtWarning,[mbYes,mbNo],0)=mrYes;
         end;
     until not TryAgain;
     DE:=FindNext(SR);
   end;
  ChDir(CD);
end;

procedure DeleteUnselectedFiles(Nie,Ogr,Dwu,Neg,Zap,Zam:Boolean; Dir:String);
begin
  if not Nie and
     FileExists(AddBackSlash(Dir)+'DEFAULT.'+NieExt)
    then DeleteAllFiles(Dir,'*.'+NieExt);
  if not Ogr and
     FileExists(AddBackSlash(Dir)+'DEFAULT.'+OgrExt)
    then DeleteAllFiles(Dir,'*.'+OgrExt);
  if not Dwu and
     FileExists(AddBackSlash(Dir)+'DEFAULT.'+DwuExt)
    then DeleteAllFiles(Dir,'*.'+DwuExt);
  if not Neg and
     FileExists(AddBackSlash(Dir)+'DEFAULT.'+NegExt)
    then DeleteAllFiles(Dir,'*.'+NegExt);
  if not Zap and
     FileExists(AddBackSlash(Dir)+'DEFAULT.'+ZapExt)
    then DeleteAllFiles(Dir,'*.'+ZapExt);
  if not Zam and
     FileExists(AddBackSlash(Dir)+'DEFAULT.'+ZamExt)
    then DeleteAllFiles(Dir,'*.'+ZamExt);
end;

end.
