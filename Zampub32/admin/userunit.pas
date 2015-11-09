unit UserUnit;

interface

uses
  WinTypes, SysUtils, Classes, Dialogs, Controls,
  SiwzIni, Utils;

const
{tenders}
  tNie=1;
  tOgr=2;
  tDwu=4;
  tNeg=8;
  tZap=16;
  tZam=32;

  utSupervisor=1;
  utUser=2;

  PwdReservedChars=['[',']','=',',',' '];

  SaveLen=20;  {userlist data}
  SecSaveLen=15; {other data}

  NameLen=10;
  PwdLen=10;

type
  TPUserNode=^TUserNode;
  TUserNode=class(TObject)
              FPwd:String;
              FKind:Byte;
              FRights:Byte;
            end;

  TUserList=class(TComponent)
            private
              FList:TStringList;
              FFileName:String;
              FPassword:String;
            public
              constructor Create;
              destructor Free;
              procedure Load;
              procedure Save;
              procedure Clear;
              procedure AddUser(UName,UPwd:String; UKind:Byte; URights:Byte);
              procedure EditUser(UName,NewName,NewPwd:string; NewKind:Byte; NewRights:Byte);
              procedure DeleteUser(UName:String);
              procedure SetPwd(UName,Pwd:String);
              function AlreadyExists(UName:String):Boolean;
              function GetName(Index:LongInt):String;
              function GetPwd(UName:String):String;
              function GetKind(UName:String):Byte;
              function GetRights(UName:String):Byte;
              function Count:LongInt;
              function NamePwdOk(AName,APwd:String):Boolean;
            published
              property FileName:String read FFileName write FFileName;
              property Password:String read FPassword write FPassword;
            end;

var
  UserList:TUserList;

function LoadFilePwd(AFileName:String):String;

implementation

constructor TUserList.Create;
begin
  FList:=TStringList.Create;
  FFileName:='';
  FPassword:='';
end;

destructor TUserList.Free;
begin
  FList.Free;
end;

function TUserList.GetRights(UName:String):Byte;
var
  p:TUserNode;
  x:LongInt;
begin
  Result:=0;
  if UName=SuperUserName
    then Result:= tNie and tOgr and tDwu and tNeg and tZap and tZam
    else begin
      x:=FList.IndexOf(UName);
      if x>-1
        then begin
          p:=TUserNode(FList.Objects[x]);
          Result:=p.FRights;
        end;
    end;
end;

function TUserList.AlreadyExists(UName:String):Boolean;
begin
  Result:=FList.IndexOf(UName)>=0;
end;

procedure TUserList.AddUser(UName,UPwd:String; UKind:Byte; URights:Byte);
var
  p:TUserNode;
begin
  if not AlreadyExists(UName)
    then begin
      p:=TUserNode.Create;
      p.FPwd:=UPwd;
      p.FKind:=UKind;
      p.FRights:=URights;
      FList.AddObject(UName,p);
    end;

end;

procedure TUserList.EditUser(UName,NewName,NewPwd:string; NewKind:Byte; NewRights:Byte);
var
  p:TUserNode;
  x:LongInt;
begin
  x:=FList.IndexOf(UName);
  if x>=0
    then begin
      p:=TUserNode(FList.Objects[x]);
      p.FPwd:=NewPwd;
      p.FKind:=NewKind;
      p.FRights:=NewRights;
      FList[x]:=NewName;
    end;
end;

procedure TUserList.DeleteUser(UName:String);
var
  x:LongInt;
begin
  x:=FList.IndexOf(UName);
  if x>=0
    then FList.Delete(x);
end;

function TUserList.GetName(Index:LongInt):String;
begin
  Result:=FList[Index];
end;

procedure TUserList.SetPwd(UName,Pwd:String);
var
  p:TUserNode;
  x:LongInt;
begin
  x:=FList.IndexOf(UName);
  if x>=0
    then begin
      p:=TUserNode(FList.Objects[x]);
      p.FPwd:=Pwd;
    end;
end;

function TUserList.GetPwd(UName:String):String;
var
  p:TUserNode;
  x:LongInt;
begin
  Result:='';
  x:=FList.IndexOf(UName);
  if x>=0
    then begin
      p:=TUserNode(FList.Objects[x]);
      Result:=p.FPwd;
    end;
end;

function TUserList.GetKind(UName:String):Byte;
var
  p:TUserNode;
  x:LongInt;
begin
  Result:=0;
  x:=FList.IndexOf(UName);
  if x>=0
    then begin
      p:=TUserNode(FList.Objects[x]);
      Result:=p.FKind;
    end;
end;

procedure TUserList.Load;
var
  f:File;
  Name:String;
  Pwd:String;
  Kind:Byte;
  Rights:Byte;
  i:Word;
  MaxUsers:Word;
  s:String;
begin
  if FFileName=''
    then Exit;
  AssignFile(f,FFileName);
  try
    Reset(f,1);
    try
      BlockRead(f,s,SecSaveLen+1);
      s:=RightTrim(Decrypt(s,SKey));
      if s=VersionString
        then begin
          BlockRead(f,s,SecSaveLen+1);
          FPassword:=RightTrim(Decrypt(s,SKey));
          BlockRead(f,s,SaveLen+1);
          MaxUsers:=StrToInt(RightTrim(Decrypt(s,SKey)));
          i:=0;
          while not EOF(f)  and (i<MaxUsers) do
            begin
              BlockRead(f,Name,SaveLen+1);
              Name:=RightTrim(Decrypt(Name,SKey));
              BlockRead(f,Pwd,SaveLen+1);
              Pwd:=RightTrim(Decrypt(Pwd,SKey));
              BlockRead(f,s,SaveLen+1);
              s:=RightTrim(Decrypt(s,SKey));
              Kind:=Ord(s[1]);
              BlockRead(f,s,SaveLen+1);
              s:=RightTrim(Decrypt(s,SKey));
              Rights:=Ord(s[1]);
              AddUser(Name,Pwd,Kind,Rights);
              Inc(i);
            end;
        end
        else MessageDlg('Wersja pliku u¿ytkowników nie prawid³owa',mtError,[mbOk],0);
    finally
      CloseFile(F);
    end;
  except
    on EInOutError do
      begin
        MessageDlg('Plik u¿ytkowników nie znaleziono',mtError,[mbOk],0);
      end;
  end;
end;

procedure TUserList.Save;
var
  f:File;
  p:TUserNode;
  i:LongInt;
  s:String;
begin
  if FFileName=''
    then Exit;
  AssignFile(f,FFileName);
  try
    Rewrite(f,1);
    try
      s:=Encrypt(RightPad(VersionString,SecSaveLen),SKey);
      BlockWrite(f,s,SecSaveLen+1);
      s:=Encrypt(RightPad(FPassword,SecSaveLen),SKey);
      BlockWrite(f,s,SecSaveLen+1);
      s:=Encrypt(RightPad(IntToStr(FList.Count),SaveLen),SKey);
      BlockWrite(f,s,SaveLen+1);
      for i:=0 to FList.Count-1 do
        begin
          s:=Encrypt(RightPad(FList[i],SaveLen),SKey);
          BlockWrite(f,s,SaveLen+1);
          p:=TUserNode(FList.Objects[i]);
          s:=Encrypt(RightPad(p.FPwd,SaveLen),SKey);
          BlockWrite(f,s,SaveLen+1);
          s:=Encrypt(RightPad(Chr(p.FKind),SaveLen),SKey);
          BlockWrite(f,s,SaveLen+1);
          s:=Encrypt(RightPad(Chr(p.FRights),SaveLen),SKey);
          BlockWrite(f,s,SaveLen+1);
        end;
    finally
      CloseFile(F);
    end;
  finally
  end;
end;

procedure TUserList.Clear;
begin
  FList.Clear;
end;

function TUserList.Count:LongInt;
begin
  Result:=FList.Count;
end;

function TUserList.NamePwdOk(AName,APwd:String):Boolean;
var
  s:String;
begin
  if AlreadyExists(AName)
    then begin
      s:=GetPwd(AName);
      if s=APwd
        then Result:=TRUE
        else Result:=FALSE;
    end
  else Result:=FALSE;
end;

function LoadFilePwd(AFileName:String):String;
var
  f:File;
  s:String;
begin
  Result:='';
  if AFileName=''
    then Exit;
  AssignFile(f,AFileName);
  try
    Reset(f,1);
    try
      BlockRead(f,s,SecSaveLen+1);
      s:=RightTrim(Decrypt(s,SKey));
      if s=VersionString
        then begin
          BlockRead(f,s,SecSaveLen+1);
          Result:=RightTrim(Decrypt(s,SKey));
        end
        else MessageDlg('Wersja pliku u¿ytkowników nie prawid³owa',mtError,[mbOk],0);
    finally
      CloseFile(F);
    end;
  except
    on EInOutError do
      begin
        Result:='';
      end;
  end;
end;

end.
