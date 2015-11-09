unit Crypt;

interface

const
  EncryptStrLen=250;
  SectNameLen=40;
  UserNameLen=25;
  PasswordLen=30;

  PwdReservedChars=['[',']','=',',',' '];
  AuthorizedChars=['0'..'9','A'..'Z','a'..'z',#8];

{errors}
  emOpenSecurityFile='Unable to open security file';

type
EncryptStr=String[EncryptStrLen];

function Encrypt(const S: String; Key: Word; StrLen:Byte): String;
function Decrypt(const S: String; Key: Word): String;
function IsUserAuthorized(UN,Pwd:String):Boolean;
function UserExists(UserName:String):Boolean;
procedure AddUser(UserType:Char; UserName,UserPwd:String);
procedure DeleteUser(UserName:String);

var
  AccessMode:Char;

implementation

uses
  SysUtils,
  Classes,
  WinCRT,
  Dialogs,
  IniFiles,
  UserUnit,
  SiwzIni,
  Utils;

const
  C1  = 52845;
  C2  = 22719;
  Key = 23;

  UserSect='USERS';

function Encrypt(const S: String; Key: Word; StrLen:Byte): String;
var
  i,j: byte;
  s1:String;
  c:Char;
begin
  Result:=s;
(*
  s1:=S;
  j:=0;
  if Length(s1)>StrLen
    then s1[0]:=Chr(StrLen)
  else if Length(s1)<StrLen
    then for i:=Length(s1)+1 to StrLen do
      begin
        if j=0
          then s1:=s1+' '
          else s1:=s1+Char(65+j);
        j:=Random(25)+1;
      end;
  Result[0]:=s1[0];
  if Key>62
    then Key:=Key mod 62;
  for i := 1 to Length(s1) do
    begin
      if s1[i] in ['0'..'9']
        then Result[i] := Char(((Byte(s1[i])+5) {xor (Key shr 8)}))
      else if s1[i] in ['A'..'Z']
        then Result[i] := Char(((Byte(s1[i])-38) {xor (Key shr 8)}))
      else if s1[i] in ['a'..'z']
        then Result[i] := Char(((Byte(s1[i])-96) {xor (Key shr 8)}));
      case Ord(Result[i]) of
        1..10 :Result[i]:=Chr(Ord(Result[i])+47);
        11..36:Result[i]:=Chr(Ord(Result[i])+54);
        37..62:Result[i]:=Chr(Ord(Result[i])+60);
      end;{case}
      Key := ((Byte(Result[i]) + Key) * C1 + C2) mod 62;
    end;
*)
end;

function Decrypt(const S: String; Key: Word): String;
var
  I: byte;
  p:Byte;
  c:Char;
begin
  Result:=s;
(*
  if Key>62
    then Key:=Key mod 62;
  Result[0]:=S[0];
  for I := 1 to Byte(Result[0]) do
    begin
      case Ord(S[i]) of
        48..57:Result[i]:=Chr(Ord(S[i])-47);
        65..90:Result[i]:=Chr(Ord(S[i])-54);
        97..122:Result[i]:=Chr(Ord(S[i])-60);
      end;{case}
      if Ord(Result[i]) in [1..26]
        then Result[i] := Char(((Byte(Result[i]){+96}) {xor (Key shr 8)})+96)
      else if Ord(Result[i]) in [27..52]
        then Result[i] := Char(((Byte(Result[i]){+21}) {xor (Key shr 8)})+38)
      else if Ord(Result[i]) in [53..62]
        then Result[i] := Char(((Byte(Result[i]){+28}) {xor (Key shr 8)})-5);
     Key := ((Byte(S[I]) + Key) * C1 + C2) mod 62;
    end;
  p:=Pos(Char(32),Result);
  if p>0
    then Result:=Copy(Result,1,p-1);
*)
end;

function IsUserAuthorized(UN,Pwd:String):Boolean;
var
  F:TIniFile;
  SL:TStringList;
  i:LongInt;
  p:Byte;
  s1,s2:String;
  c:Char;
begin
  Result:=FALSE;
  if FileExists(AddBackSlash(SiwzSystemDir)+SecurityFileName)
    then begin
      F:=TIniFile.Create(AddBackSlash(SiwzSystemDir)+SecurityFileName);
      SL:=TStringList.Create;
      try
        s1:=Encrypt(UserSect,Key,SectNameLen);
        F.ReadSectionValues(s1,SL);
        if SL.Count>0
          then for i:=0 to SL.Count-1 do
            begin
              p:=Pos('=',SL[i]);
              s1:=Copy(SL[i],1,p-1);
              s2:=Copy(SL[i],p+1,Length(SL[i])-p-2);
              if (UpperCase(UN)=s1) and (UpperCase(Pwd)=s2)
                then begin
                  c:=SL[i][Length(SL[i])];
                  if (c=SuperChar) or (c=UserChar)
                    then begin
                      Result:=TRUE;
                      Break;
                    end;
                end;
            end;
      finally
        SL.Free;
        F.Free;
      end;
    end;
end;

function UserExists(UserName:String):Boolean;
var
  F:TIniFile;
  SL:TStringList;
  S:String;
  i:LongInt;
  p:Byte;
  a:String;
begin
  Result:=FALSE;
  if FileExists(AddBackSlash(SiwzSystemDir)+SecurityFileName)
    then begin
      F:=TIniFile.Create(AddBackSlash(SiwzSystemDir)+SecurityFileName);
      SL:=TStringList.Create;
      try
        a:=Encrypt(UserSect,Key,SectNameLen);
        F.ReadSectionValues(a,SL);
        if SL.Count>0
          then for i:=0 to SL.Count-1 do
            begin
              p:=Pos('=',SL[i]);
              S:=Copy(SL[i],1,p-1);
{              S:=SL[i];
              S:=Copy(S,1,UserNameLen);
              S:=Decrypt(S,Key);}
              if UpperCase(UserName)=S
                then begin
                  Result:=TRUE;
                  Break;
                end;
            end;
      finally
        SL.Free;
        F.Free;
      end;
    end;
end;

procedure AddUser(UserType:Char; UserName,UserPwd:String);
var
  F:TIniFile;
a,b,c:String;
begin
  if FileExists(AddBackSlash(SiwzSystemDir)+SecurityFileName)
    then begin
      F:=TIniFile.Create(AddBackSlash(SiwzSystemDir)+SecurityFileName);
      try
{a:=Encrypt(UserSect,Key,SectNameLen);
b:=Encrypt(UpperCase(UserName),Key,UserNameLen);
c:=Encrypt(UpperCase(UserPwd)+','+UserType,Key,PasswordLen);
F.WriteString(a,b,c);
a:=Decrypt(a,Key);
b:=Decrypt(b,Key);
c:=Decrypt(c,Key);}
        F.WriteString(Encrypt(UserSect,Key,SectNameLen),
                      Encrypt(UpperCase(UserName),Key,UserNameLen),
                      Encrypt(UpperCase(UserPwd)+','+UserType,Key,PasswordLen));
      except
        on E:Exception do
          MessageDlg(emOpenSecurityFile,mtError,[mbOk],0);
      end;
      F.Free;
    end;
end;

procedure DeleteUser(UserName:String);
var
  F:TIniFile;
a,b,c:String;
begin
  if FileExists(AddBackSlash(SiwzSystemDir)+SecurityFileName)
    then begin
      F:=TIniFile.Create(AddBackSlash(SiwzSystemDir)+SecurityFileName);
      try

      except
        on E:Exception do
          MessageDlg(emOpenSecurityFile,mtError,[mbOk],0);
      end;
      F.Free;
    end;
end;

end.

