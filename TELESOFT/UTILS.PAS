unit Utils;

interface

uses
  Classes, StdCtrls, Mask, Spin, Grids;

const
  SKey = 21453;

var
  SeedKey:Integer;

procedure ExportString(s:String; var F:TextFile);
procedure ExportEdit(Edit:TEdit; var F:TextFile);
procedure ExportMaskEdit(Edit:TMaskEdit; var F:TextFile);
procedure ExportMemo(Memo:TMemo; var F:TextFile);
procedure ExportPChar(p:PChar; var F:TextFile);

function StripLastToken(S: string; Token: Char): string;
function StripLastTokenPChar(p: PChar; Token: Char): PChar;
function MemoToString(Memo:TMemo):String;
function StringAsPChar(var S: OpenString): PChar;
function AddBackSlash(const S: String): String;
function StripBackSlash(const S: String): String;
function AddBeginPoint(const S: String): String;
function StripBeginPoint(const S: String): String;
function AddEndPoint(const S: String): String;
function StripEndPoint(const S: String): String;
function AddEndSpaceIfNone(const S: String) : String;
function StripBeginSpace(const S:String) : String;
function StripBeginSpaces(const S:String) : String;
function StripEndSpace(const S:String) : String;
function StripAllSpaces(const S:String) : String;
function IsStringInList(const S:String; List:TStrings) : Boolean;
function LowerCaseChar(c:Char):Char;
function UpperCaseChar(c:Char):Char;
function RightPad(s:String; Len:Byte):String;
function RightTrim(const S:String) : String;

procedure SaveByte(B:Byte; var F:File);
procedure LoadByte(var B:Byte; var F:File);
procedure SaveInteger(I:Integer; var F:File);
procedure LoadInteger(var I:Integer; var F:File);
procedure SaveLongInt(I:LongInt; var F:File);
procedure LoadLongInt(var I:LongInt; var F:File);
procedure SaveReal(I:Real; var F:File);
procedure LoadReal(var I:Real; var F:File);
procedure SaveBoolean(B:Boolean; var F:File);
procedure LoadBoolean(var B:Boolean; var F:File);
procedure SaveString(Str:String; var F:File);
procedure LoadString(var Str:String; var F:File);
procedure SaveEdit(Edit:TEdit; var F:File);
procedure LoadEdit(var Edit:TEdit; var F:File);
procedure SaveMaskEdit(Edit:TMaskEdit; var F:File);
procedure LoadMaskEdit(var Edit:TMaskEdit; var F:File);
procedure SaveSpinEdit(Edit:TSpinEdit; var F:File);
procedure LoadSpinEdit(var Edit:TSpinEdit; var F:File);
procedure SaveDateTime(DT:TDateTime; var F:File);
procedure LoadDateTime(var DT:TDateTime; var F:File);
procedure SaveMemo(Memo:TMemo; var F:File);
procedure LoadMemo(var Memo:TMemo; var F:File);
procedure SaveComboBox(Combo:TComboBox; var F:File);
procedure LoadComboBox(var Combo:TComboBox; var F:File);
procedure SaveListBox(List:TListBox; var F:File);
procedure LoadListBox(var List:TListBox; var F:File);
procedure SaveCheckBox(CheckBox:TCheckBox; var F:File);
procedure LoadCheckBox(var CheckBox:TCheckBox; var F:File);
procedure SaveStringGrid(SG:TStringGrid; var F:File);
procedure LoadStringGrid(var SG:TStringGrid; var F:File);
procedure SaveStringList(SL:TStringList; var F:File);
procedure LoadStringList(var SL:TStringList; var F:File);

procedure RealStrToRealMaskEdit(r:String; var ME:TMaskEdit);

procedure SaveByteToStream(B:Byte; Stream:TStream);
procedure LoadByteFromStream(var B:Byte; Stream:TStream);
procedure SaveIntegerToStream(I:Integer; Stream:TStream);
procedure LoadIntegerFromStream(var I:Integer; Stream:TStream);
procedure SaveRealToStream(I:Real; Stream:TStream);
procedure LoadRealFromStream(var I:Real; Stream:TStream);
procedure SaveBooleanToStream(B:Boolean; Stream:TStream);
procedure LoadBooleanFromStream(var B:Boolean; Stream:TStream);
procedure SaveStringToStream(Str:String; Stream:TStream);
procedure LoadStringFromStream(var Str:String; Stream:TStream);
procedure SaveEditToStream(Edit:TEdit; Stream:TStream);
procedure LoadEditFromStream(var Edit:TEdit; Stream:TStream);
procedure SaveMaskEditToStream(Edit:TMaskEdit; Stream:TStream);
procedure LoadMaskEditFromStream(var Edit:TMaskEdit; Stream:TStream);
procedure SaveSpinEditToStream(Edit:TSpinEdit; Stream:TStream);
procedure LoadSpinEditFromStream(var Edit:TSpinEdit; Stream:TStream);
procedure SaveMemoToStream(Memo:TMemo; Stream:TStream);
procedure LoadMemoFromStream(var Memo:TMemo; Stream:TStream);
procedure SaveComboBoxToStream(Combo:TComboBox; Stream:TStream);
procedure LoadComboBoxFromStream(var Combo:TComboBox; Stream:TStream);
procedure SaveCheckBoxToStream(CheckBox:TCheckBox; Stream:TStream);
procedure LoadCheckBoxFromStream(var CheckBox:TCheckBox; Stream:TStream);
procedure SaveStringGridToStream(SG:TStringGrid; Stream:TStream);
procedure LoadStringGridFromStream(var SG:TStringGrid; Stream:TStream);

function WinExecAndWait(Path: String; Visibility: word): word;
function GetEnvVar(EnvVar: String): String;
procedure CopyFile(Source, Dest: String);

procedure WriteStringToText(Str:String; Stream:TFileStream);
procedure WriteEditToText(Edit:TEdit; Stream:TFileStream);
procedure WriteMemoToText(Memo:TMemo; Stream:TFileStream);
procedure WriteComboBoxToText(Combo:TComboBox; Stream:TFileStream);

function GetMemoTotalLength(Memo:TMemo):LongInt;
procedure MemoToPChar(Memo:TMemo; var PStr:PChar);
procedure PCharToMemo(PStr:PChar; var Memo:TMemo);
function GetStringGridTotalLength(SG:TStringGrid):LongInt;
procedure StringGridToPChar(SG:TStringGrid; var PSG:PChar);
procedure PCharToStringGrid(PSG:PChar; var SG:TStringGrid);

const
  SuperUserName='TELESOFT';

function SuperPassword:String;
function Encrypt(const S: String; Key: Word): String;
function Decrypt(const S: String; Key: Word): String;
procedure MakeCodeKey(AKeyStr:String);

implementation

uses
  SysUtils,
  LZExpand,
  WinTypes,
  WinProcs,
  Forms;

const
  Code1 = 47845;
  Code2 = 26739;

function SuperPassword:String;
var
  a:String;
begin
  Result:=Chr(35);
  Result:=Result+Result;
  a:='PA';
  Result:=Result+a;
  Result:=Result+UpperCase(Chr(110))+#68+Chr(79);
  a:='R';
  Result:=Result+a+Copy(Result,7,1);
  Result:=Result+Copy(Result,1,2);
end;

function Encrypt(const S: String; Key: Word): String;
var
  I: byte;
begin
  Result[0] := S[0];
  for I := 1 to Length(S) do begin
    Result[I] := char(byte(S[I]) xor (Key shr 8));
    Key := (byte(Result[I]) + Key) * Code1 + Code2;
  end;
end;

function Decrypt(const S: String; Key: Word): String;
var
  I: byte;
begin
  Result[0] := S[0];
  for I := 1 to Length(S) do begin
    Result[I] := char(byte(S[I]) xor (Key shr 8));
    Key := (byte(S[I]) + Key) * Code1 + Code2;
  end;
end;

function GetStringGridTotalLength(SG:TStringGrid):LongInt;
begin
  Result:=1;
end;

procedure StringGridToPChar(SG:TStringGrid; var PSG:PChar);
begin
  StrPLCopy(PSG,'',1);
end;

procedure PCharToStringGrid(PSG:PChar; var SG:TStringGrid);
begin

end;

function GetMemoTotalLength(Memo:TMemo):LongInt;
var
  i,l:LongInt;
begin
  l:=0;
  if Memo.Lines.Count>0
    then for i:=0 to Memo.Lines.Count-1 do
      l:=l+Length(Memo.Lines[i])+1;
  Result:=l;
end;

procedure MemoToPChar(Memo:TMemo; var PStr:PChar);
var
  i:longInt;
  s:String;
begin
  StrCopy(PStr,'');
  if Memo.Lines.Count>0
    then begin
      for i:=0 to Memo.Lines.Count-1 do
        begin
          s:=Memo.Lines[i]+#13;
          StrCat(PStr,StringAsPChar(s));
        end;
    end
end;

procedure PCharToMemo(PStr:PChar; var Memo:TMemo);
var
  p:PChar;
  x:PChar;
  d:PChar;
  i:Integer;
begin
  p:=PStr;
  Memo.Lines.Clear;
  x:=StrScan(p,#13);
  while x<>Nil do
    begin
      d:=StrAlloc(x-p+1);
      StrLCopy(d,p,x-p);
      Memo.Lines.Add(StrPas(d));
      StrDispose(d);
      p:=x+1;
      x:=StrScan(p,#13);
    end;
end;

function LowerCaseChar(c:Char):Char;
begin
  if c in['A'..'Z']
    then Result:=Chr(Ord(c)+32)
    else Result:=c;
end;

function UpperCaseChar(c:Char):Char;
begin
  if c in['a'..'z']
    then c:=Chr(Ord(c)-32);
end;

function MemoToString(Memo:TMemo):String;
var
  s:String;
  i:Word;
begin
  s:='';
  if Memo.Lines.Count>0
    then begin
      i:=0;
      while (Length(s)<255) and (i<=Memo.Lines.Count-1) do
        begin
          s:=s+Memo.Lines[i];
          Inc(i);
        end;
    end;
  Result:=s;
end;

function StringAsPChar(var S: OpenString): PChar;
{ This function null-terminates a string so that it can be passed to functions }
{ that require PChar types. If string is longer than 254 chars, then it will   }
{ be truncated to 254. }
begin
  if Length(S) = High(S) then Dec(S[0]); { Truncate S if it's too long }
  S[Ord(Length(S)) + 1] := #0;           { Place null at end of string }
  Result := @S[1];                       { Return "PChar'd" string }
end;


function AddBackSlash(const S: String): String;
{ Adds a backslash to string S.  If S is already 255 chars or already has }
{ trailing backslash, then function returns S. }
begin
  if (Length(S) < 255) and (S[Length(S)] <> '\') then
    Result := S + '\'
  else
    Result := S;
end;

function StripBackSlash(const S: String): String;
{ Removes trailing backslash from S, if one exists }
begin
  Result := S;
  if Result[Length(Result)] = '\' then
    Dec(Result[0]);
end;

function AddBeginPoint(const S:String): String;
{Adds a point to the beginning of the string S.}
begin
  if (Length(S) < 255) and (S[1] <> '.') then
    Result := '.' + S
  else
    Result := S;
end;

function StripBeginPoint(const S: String): String;
{ Removes the point from the beginning of S, if one exists }
begin
  Result := S;
  if Result[1] = '.' then
    Result:=Copy(Result,2,Length(Result)-1);
end;

function AddEndPoint(const S:String): String;
{Adds a point to the beginning of the string S.}
begin
  if (Length(S) < 255) and (S[Length(s)] <> '.') then
    Result := S + '.'
  else
    Result := S;
end;

function StripEndPoint(const S: String): String;
{ Removes the point from the beginning of S, if one exists }
begin
  Result := S;
  if Result[Length(Result)] = '.' then
    Result:=Copy(Result,1,Length(Result)-1);
end;

function AddEndSpaceIfNone(const S: String) : String;
begin
  if (Length(S) < 255) and (S[Length(S)] <> ' ') then
    Result := S + ' '
  else
    Result := S;
end;

function StripBeginSpace(const S:String) : String;
begin
  if (Length(S)>0) and (S[1]=' ')
    then Result := Copy(S,2,Length(S)-1)
    else Result := S;
end;

function StripBeginSpaces(const S:String) : String;
var
  Str:String;
begin
  Str:=s;
  while (Length(Str)>0) and (Str[1]=' ') do
    Str:= Copy(Str,2,Length(Str)-1);
  Result:=Str;
end;

function StripEndSpace(const S:String) : String;
begin
  Result := S;
  if Result[Length(Result)] = ' ' then
    Dec(Result[0]);
end;

function StripAllSpaces(const S:String) : String;
var
  s1:String;
  i:Byte;
begin
  if Length(s)>0
    then begin
      s1:=s;
      while s1[1]=' ' do
        s1:=StripBeginSpace(s1);
      while s1[Length(s1)]=' ' do
        s1:=StripEndSpace(s1);
      i:=1;
      while i<Length(s1) do
        if s1[i]=' '
          then s1:=Copy(s1,1,i-1)+Copy(s1,i+1,Length(s1)-i)
          else Inc(i);
      Result:=s1;
    end;
end;

function IsStringInList(const S:String; List:TStrings) : Boolean;
var
  s1:String;
  i:LongInt;
  Res:Boolean;
begin
  i:=1;
  Res:=FALSE;
  s1:=UpperCase(StripAllSpaces(S));
  while (i<=List.Count) and (Res=FALSE) do
    begin
      Res:=s1=UpperCase(StripAllSpaces(List[i]));
      i:=i+1;
    end;
  Result:=Res;
end;

procedure SaveIntegerToStream(I:Integer; Stream:TStream);
begin
  Stream.Write(I,2);
end;

procedure LoadIntegerFromStream(var I:Integer; Stream:TStream);
begin
  Stream.Read(I,2);
end;

procedure SaveByteToStream(B:Byte; Stream:TStream);
begin
  Stream.Write(B,1);
end;

procedure LoadByteFromStream(var B:Byte; Stream:TStream);
begin
  Stream.Read(B,1);
end;

procedure SaveRealToStream(I:Real; Stream:TStream);
begin
  Stream.Write(I,6);
end;

procedure LoadRealFromStream(var I:Real; Stream:TStream);
begin
  Stream.Read(I,6);
end;

procedure SaveBooleanToStream(B:Boolean; Stream:TStream);
begin
  Stream.Write(B,1);
end;

procedure LoadBooleanFromStream(var B:Boolean; Stream:TStream);
begin
  Stream.Read(B,1);
end;

procedure SaveStringToStream(Str:String; Stream:TStream);
begin
  Stream.Write(Str,Length(Str)+1);
end;

procedure LoadStringFromStream(var Str:String; Stream:TStream);
begin
  Stream.Read(Str[0],1);
  Stream.Read(Str[1],Ord(Str[0]));
end;

procedure SaveMaskEditToStream(Edit:TMaskEdit; Stream:TStream);
var
  Line:string;
begin
  Line:=Edit.Text;
  SaveStringToStream(Line,Stream);
end;

procedure LoadMaskEditFromStream(var Edit:TMaskEdit; Stream:TStream);
var
  Line:string;
begin
  LoadStringFromStream(Line,Stream);
  Edit.Text:=Line;
end;

procedure SaveSpinEditToStream(Edit:TSpinEdit; Stream:TStream);
var
  Line:string;
begin
  Line:=Edit.Text;
  SaveStringToStream(Line,Stream);
end;

procedure LoadSpinEditFromStream(var Edit:TSpinEdit; Stream:TStream);
var
  Line:string;
begin
  LoadStringFromStream(Line,Stream);
  Edit.Text:=Line;
end;

procedure SaveEditToStream(Edit:TEdit; Stream:TStream);
var
  Line:string;
begin
  Line:=Edit.Text;
  SaveStringToStream(Line,Stream);
end;

procedure LoadEditFromStream(var Edit:TEdit; Stream:TStream);
var
  Line:string;
begin
  LoadStringFromStream(Line,Stream);
  Edit.Text:=Line;
end;

procedure SaveMemoToStream(Memo:TMemo; Stream:TStream);
var
  i:Integer;
  Tot:Integer;
  Line:string;
begin
  Tot:=Memo.Lines.Count;
  Stream.Write(Tot,sizeof(Integer));
  for i:=0 to Tot-1 do
    begin
      Line:=Memo.Lines[i];
      SaveStringToStream(Line,Stream);
    end;
end;

procedure LoadMemoFromStream(var Memo:TMemo; Stream:TStream);
var
  i:Integer;
  Tot:Integer;
  Line:string;
begin
  Stream.Read(Tot,sizeof(Integer));
  Memo.Clear;
  for i:=0 to Tot-1 do
    begin
      LoadStringFromStream(Line,Stream);
      Memo.Lines.Add(Line);
    end;

end;

procedure SaveComboBoxToStream(Combo:TComboBox; Stream:TStream);
var
  i:Integer;
  Tot:Integer;
  Line:string;
begin
  Tot:=Combo.Items.Count;
  Stream.Write(Tot,sizeof(Integer));
  i:=Combo.Itemindex;
  Stream.Write(i,sizeof(Integer));
  for i:=0 to Tot-1 do
    begin
      Line:=Combo.Items[i];
      SaveStringToStream(Line,Stream);
    end;
end;

procedure LoadComboBoxFromStream(var Combo:TComboBox; Stream:TStream);
var
  i:Integer;
  Index:Integer;
  Tot:Integer;
  Line:string;
begin
  Stream.Read(Tot,sizeof(Integer));
  Stream.read(Index,sizeof(Integer));
  Combo.Clear;
  for i:=0 to Tot-1 do
    begin
      LoadStringFromStream(Line,Stream);
      Combo.Items.Add(Line);
    end;
  Combo.ItemIndex:=Index;
end;

procedure SaveCheckBoxToStream(CheckBox:TCheckBox; Stream:TStream);
var
  Bool:Boolean;
begin
  Bool:=CheckBox.Checked;
  Stream.Write(Bool,1);
end;

procedure LoadCheckBoxFromStream(var CheckBox:TCheckBox; Stream:TStream);
var
  Bool:Boolean;
begin
  Stream.Read(Bool,1);
  CheckBox.Checked:=Bool;
end;

procedure SaveStringGridToStream(SG:TStringGrid; Stream:TStream);
var
  i,j,x,y:LongInt;
  Line:string;
begin
  x:=SG.RowCount;
  y:=SG.ColCount;
  Stream.Write(x,SizeOf(LongInt));
  Stream.Write(y,SizeOf(LongInt));
  for i:=1 to x-1 do
    for j:=0 to y-1 do
      begin
        Line:=SG.Cells[j,i];
        SaveStringToStream(Line,Stream);
      end;
end;

procedure LoadStringGridFromStream(var SG:TStringGrid; Stream:TStream);
var
  i,j,x,y:LongInt;
  Line:string;
begin
  Stream.Read(x,SizeOf(LongInt));
  Stream.Read(y,SizeOf(LongInt));
  SG.RowCount:=x;
  SG.ColCount:=y;
  for i:=1 to x-1 do
    for j:=0 to y-1 do
      begin
        LoadStringFromStream(Line,Stream);
        SG.Cells[j,i]:=Line;
      end;
end;

function WinExecAndWait(Path: String; Visibility: word): word;
var
  InstanceID : THandle;
begin
  { Convert String to PChar, and try to run the application }
  InstanceID := WinExec(StringAsPChar(Path),Visibility);
  if InstanceID < 32 then { a value less than 32 indicates an Exec error }
     WinExecAndWait := InstanceID
  else begin
    repeat
      Application.ProcessMessages;
    until Application.Terminated or (GetModuleUsage(InstanceID) = 0);
    WinExecAndWait := 32;
  end;
end;

function GetEnvVar(EnvVar: String): String;
{ Returns the value of the DOS environment variable passed in EnvVar.       }
{ Note: EnvVar must be 253 chars or less, or it will be truncated to 253.   }
{ Note2: Under Win32, the GetEnvironmentVariable() function should be used. }
var
  P: PChar;
begin
  Result := '';                                { return empty string on fail }
  P := GetDOSEnvironment;                      { retrieve pointer to env vars }
  if EnvVar[0] > #253 then EnvVar[0] := #253;  { truncate if too long }
  EnvVar := EnvVar + '=';                      { append "=" sign to string }
  StringAsPChar(EnvVar);                       { add null-terminator }
  while P^ <> #0 do
    { does first environment variable match EnvVar? }
    if StrLIComp(P, @EnvVar[1], Length(EnvVar)) <> 0 then
      inc(P, StrLen(P) + 1)                    { if not, then go to next }
    else begin
      inc(P, Length(EnvVar));                  { if so, the get value }
      Result := StrPas(P);                     { return a string }
      Break;                                   { get out of loop }
    end;
end;

procedure CopyFile(Source, Dest: String);
var
  SourceHand, DestHand: Integer;
  OpenBuf: TOFStruct;
begin
  { Open source file, and pass our psuedo-PChar as the filename }
  SourceHand := LZOpenFile(StringAsPChar(Source), OpenBuf, of_Share_Deny_Write or of_Read);
  { raise an exception on error }
  if SourceHand = -1 then
    raise EInOutError.Create('Error opening source file "' + Source + '"');
  try
    { Open destination file, and pass our psuedo-PChar as the filename }
    DestHand := LZOpenFile(StringAsPChar(Dest), OpenBuf, of_Share_Exclusive or of_Write
                           or of_Create);
    { Check for error and raise exception }
    if DestHand = -1 then
      raise EInOutError.CreateFmt('Error opening destination file "%s"',[Dest]);
    try
      { copy source to dest, raise exception on error }
      if LZCopy(SourceHand, DestHand) < 0 then
        raise EInOutError.CreateFmt('Error copying file "%s"', [Source]);
    finally
      { whether or not an exception occurs, we need to close the files }
      LZClose(DestHand);
    end;
  finally
    LZClose(SourceHand);
  end;
end;

procedure WriteStringToText(Str:String; Stream:TFileStream);
begin
  Stream.Write(Str,Length(Str)+1);
  Str:=Chr(13);
  Stream.Write(Str,1);
end;

procedure WriteEditToText(Edit:TEdit; Stream:TFileStream);
var
  Line:string;
begin
  Line:=Edit.Text;
  WriteStringToText(Line,Stream);
end;

procedure WriteMemoToText(Memo:TMemo; Stream:TFileStream);
var
  i:Integer;
  Tot:Integer;
  Line:string;
begin
  Tot:=Memo.Lines.Count;
  for i:=0 to Tot-1 do
    begin
      Line:=Memo.Lines[i];
      WriteStringToText(Line,Stream);
    end;
end;

procedure WriteComboBoxToText(Combo:TComboBox; Stream:TFileStream);
var
  i:Integer;
  Tot:Integer;
  Line:string;
begin
  Tot:=Combo.Items.Count;
  for i:=0 to Tot-1 do
    begin
      Line:=Combo.Items[i];
      WriteStringToText(Line,Stream);
    end;
end;

procedure StrToReal(s:String; var r:Real);
var
  Negative:Boolean;
  Decimal:Boolean;
  x:Real;
begin
{  r:=0;
  x:=0.1;
  Decimal:=FALSE;
  Negative:=FALSE;
  if Length(s)>0
    then for i:=1 to Length(s) do
      begin
        case s[i] of
          '0'..'9':
            if Decimal
              then begin
                x:=x/10;
              end
              else begin
                r:=r*10+Ord(s[i])-Ord('0');
              end;
             r
          ' ':
          '.':
            Decimal:=TRUE;
          '-':
            Negative:=TRUE;
          else

      end;}
end;

procedure RealStrToRealMaskEdit(r:String; var ME:TMaskEdit);
var
  m:String;
  empty:Char;
  i,x,y:Byte;
begin
  try
    m:=ME.EditMask;
    empty:=m[Length(m)];
    m:=ME.Text;
    if Length(r)=Length(m)
      then ME.Text:=r
      else begin
        x:=Pos('.',m);
        y:=Pos('.',r);
        if x>y
          then begin
            for i:=1 to y-1 do
              m[x-i]:=r[y-i];
            for i:=1 to (Length(r)-y) do
              m[x+i]:=r[y+i]
          end;
        ME.Text:=m;
      end;
  except
    on EConvertError do
      ME.Text:='';
  end;
end;

function ReverseStr(S: string): string;
var
  Len: Integer;
  Temp: String;
  i,j: Integer;
begin
  Len := Length(S);
  j := Len;
  for i := 1 to Len do begin
    Temp[i] := S[j];
    dec(j);
  end;
  Temp[0] := S[0];
  ReverseStr := Temp;
end;

{----------------------------------------------------
       Name: StripLastToken function
Declaration: function RemoveLastToken(var S: String): String;
       Date: 03/02/94
Description: Given a string like "c:\sam\file.txt"
             This returns: "c:\sam"
             But not specific to files any token will do
-----------------------------------------------------}
function StripLastToken(S: string; Token: Char): string;
var
  Temp: string;
  Index: Integer;
begin
  S := ReverseStr(S);
  Index := Pos(Token, S);
  Inc(Index);
  Move(S[Index], Temp[1], Length(S) - (Index - 1));
  Temp[0] := Chr(Length(S) - (Index - 1));
  StripLastToken := ReverseStr(Temp);
end;

function StripLastTokenPChar(p: PChar; Token: Char): PChar;
begin
  Result:=StrRScan(p, Token);
end;

procedure SaveInteger(I:Integer; var F:File);
begin
  BlockWrite(F,I,2);
end;

procedure LoadInteger(var I:Integer; var F:File);
begin
  BlockRead(F,I,2);
end;

procedure SaveLongInt(I:LongInt; var F:File);
begin
  BlockWrite(F,I,4);
end;

procedure LoadLongInt(var I:LongInt; var F:File);
begin
  BlockRead(F,I,4);
end;

procedure SaveByte(B:Byte; var F:File);
begin
  BlockWrite(F,B,1);
end;

procedure LoadByte(var B:Byte; var F:File);
begin
  BlockRead(F,B,1);
end;

procedure SaveReal(I:Real; var F:File);
begin
  BlockWrite(F,I,6);
end;

procedure LoadReal(var I:Real; var F:File);
begin
  BlockRead(F,I,6);
end;

procedure SaveBoolean(B:Boolean; var F:File);
begin
  BlockWrite(F,B,1);
end;

procedure LoadBoolean(var B:Boolean; var F:File);
begin
  BlockRead(F,B,1);
end;

procedure SaveString(Str:String; var F:File);
begin
  Str:=Encrypt(Str,SeedKey);
  BlockWrite(F,Str,Length(Str)+1);
end;

procedure LoadString(var Str:String; var F:File);
begin
  BlockRead(F,Str[0],1);
  BlockRead(F,Str[1],Ord(Str[0]));
  Str:=Decrypt(Str,SeedKey);
end;

procedure SaveMaskEdit(Edit:TMaskEdit; var F:File);
var
  Line:string;
begin
  Line:=Edit.Text;
  SaveString(Line,F);
end;

procedure LoadMaskEdit(var Edit:TMaskEdit; var F:File);
var
  Line:string;
begin
  LoadString(Line,F);
  Edit.Text:=Line;
end;

procedure SaveSpinEdit(Edit:TSpinEdit; var F:File);
var
  Line:string;
begin
  Line:=Edit.Text;
  SaveString(Line,F);
end;

procedure LoadSpinEdit(var Edit:TSpinEdit; var F:File);
var
  Line:string;
begin
  LoadString(Line,F);
  Edit.Text:=Line;
end;

procedure SaveDateTime(DT:TDateTime; var F:File);
var
  Line:string;
begin
  BlockWrite(F,DT,8);
end;

procedure LoadDateTime(var DT:TDateTime; var F:File);
var
  Line:string;
begin
  BlockRead(F,DT,8);
end;

procedure SaveEdit(Edit:TEdit; var F:File);
var
  Line:string;
begin
  Line:=Edit.Text;
  SaveString(Line,F);
end;

procedure LoadEdit(var Edit:TEdit; var F:File);
var
  Line:string;
begin
  LoadString(Line,F);
  Edit.Text:=Line;
end;

procedure SaveMemo(Memo:TMemo; var F:File);
var
x,  i:Integer;
  Tot:Integer;
  Line:string;
begin
  Tot:=Memo.Lines.Count;
  BlockWrite(F,Tot,sizeof(Integer));
  for i:=0 to Tot-1 do
    begin
x:=FilePos(F);
      Line:=Memo.Lines[i];
      SaveString(Line,F);
    end;
end;

procedure LoadMemo(var Memo:TMemo; var F:File);
var
  i:Integer;
  Tot:Integer;
  Line:string;
begin
  Memo.Clear;
  BlockRead(F,Tot,SizeOf(Integer));
  for i:=0 to Tot-1 do
    begin
      LoadString(Line,F);
      Memo.Lines.Add(Line);
    end;
end;

procedure SaveStringGrid(SG:TStringGrid; var F:File);
var
  i,j,x,y:LongInt;
  Line:string;
begin
  x:=SG.RowCount;
  y:=SG.ColCount;
  BlockWrite(F,x,SizeOf(LongInt));
  BlockWrite(F,y,SizeOf(LongInt));
  for i:=0 to x-1 do
    for j:=0 to y-1 do
      begin
        Line:=SG.Cells[j,i];
        SaveString(Line,F);
      end;
end;

procedure LoadStringGrid(var SG:TStringGrid; var F:File);
var
  i,j,x,y:LongInt;
  Line:string;
begin
  BlockRead(F,x,SizeOf(LongInt));
  BlockRead(F,y,SizeOf(LongInt));
  SG.RowCount:=x;
  SG.ColCount:=y;
  for i:=0 to x-1 do
    for j:=0 to y-1 do
      begin
        LoadString(Line,F);
        SG.Cells[j,i]:=Line;
      end;
end;

procedure SaveComboBox(Combo:TComboBox; var F:File);
var
  i:Integer;
  Tot:Integer;
  Line:string;
begin
  Tot:=Combo.Items.Count;
  BlockWrite(F,Tot,sizeof(Integer));
  i:=Combo.Itemindex;
  BlockWrite(F,i,sizeof(Integer));
  for i:=0 to Tot-1 do
    begin
      Line:=Combo.Items[i];
      SaveString(Line,F);
    end;
end;

procedure LoadComboBox(var Combo:TComboBox; var F:File);
var
  i:Integer;
  Index:Integer;
  Tot:Integer;
  Line:string;
begin
  Combo.Clear;
  BlockRead(F,Tot,sizeof(Integer));
  BlockRead(F,Index,sizeof(Integer));
  for i:=0 to Tot-1 do
    begin
      LoadString(Line,F);
      Combo.Items.Add(Line);
    end;
  Combo.ItemIndex:=Index;
end;

procedure SaveListBox(List:TListBox; var F:File);
var
  i:Integer;
  Tot:Integer;
  Line:string;
begin
  Tot:=List.Items.Count;
  BlockWrite(F,Tot,sizeof(Integer));
  i:=List.ItemIndex;
  BlockWrite(F,i,sizeof(Integer));
  for i:=0 to Tot-1 do
    begin
      Line:=List.Items[i];
      SaveString(Line,F);
    end;
end;

procedure LoadListBox(var List:TListBox; var F:File);
var
  i:Integer;
  Index:Integer;
  Tot:Integer;
  Line:string;
begin
  List.Clear;
  BlockRead(F,Tot,sizeof(Integer));
  BlockRead(F,Index,sizeof(Integer));
  for i:=0 to Tot-1 do
    begin
      LoadString(Line,F);
      List.Items.Add(Line);
    end;
  List.ItemIndex:=Index;
end;

procedure SaveCheckBox(CheckBox:TCheckBox; var F:File);
var
  Bool:Boolean;
begin
  Bool:=CheckBox.Checked;
  BlockWrite(F,Bool,1);
end;

procedure LoadCheckBox(var CheckBox:TCheckBox; var F:File);
var
  Bool:Boolean;
begin
  BlockRead(F,Bool,1);
  CheckBox.Checked:=Bool;
end;

procedure SaveStringList(SL:TStringList; var F:File);
var
  i:Integer;
  Tot:Integer;
  Line:string;
begin
  Tot:=SL.Count;
  BlockWrite(F,Tot,sizeof(Integer));
  for i:=0 to Tot-1 do
    begin
      Line:=SL.Strings[i];
      SaveString(Line,F);
    end;
end;

procedure LoadStringList(var SL:TStringList; var F:File);
var
  i:Integer;
  Tot:Integer;
  Line:string;
begin
  SL.Clear;
  BlockRead(F,Tot,sizeof(Integer));
  for i:=0 to Tot-1 do
    begin
      LoadString(Line,F);
      SL.Add(Line);
    end;
end;
procedure ExportString(s:String; var F:TextFile);
begin
  WriteLn(F,s);
end;

procedure ExportEdit(Edit:TEdit; var F:TextFile);
begin
  WriteLn(F,Edit.Text);
{  Write(F,#13#10);}
end;

procedure ExportMaskEdit(Edit:TMaskEdit; var F:TextFile);
begin
  WriteLn(F,Edit.Text);
{  Write(F,#13#10);}
end;

procedure ExportMemo(Memo:TMemo; var F:TextFile);
var
  i:LongInt;
begin
  for i:=0 to Memo.Lines.Count-1 do
    Write(F,Memo.Lines[i]);
  Write(F,#13#10);
end;

procedure ExportPChar(p:PChar; var F:TextFile);
var
  i:LongInt;
begin
  for i:=0 to StrLen(p) do
    Write(F,p[i]);
  Write(F,#13#10);
end;

function RightPad(s:String; Len:Byte):String;
var
  x:String;
begin
  if Length(s)>=Len
    then Exit;
  x:=s;
  while Length(x)<Len do
    x:=x+' ';
  Result:=x;
end;

function RightTrim(const S:String) : String;
var
  x:String;
begin
  x := S;
  while x[Length(x)]=' ' do
    x:=Copy(x,1,Length(x)-1);
  Result:=x;
end;


procedure MakeCodeKey(AKeyStr:String);
var
  x,t:Integer;
begin
  x:=1;
  t:=0;
  while x<Length(AKeyStr) do
    begin
      t:=t+Ord(AKeyStr[x]);
      if x mod 3=0
        then t:=Trunc((t/x)*4);
      Inc(x);
    end;
  SeedKey:=t;
end;

begin
  SeedKey:=SKey;
end.

procedure SaveTabListBox(TabList:TTabListBox; var F:File);
var
  i:Integer;
  Tot:Integer;
  Line:string;
begin
  Tot:=TabList.Items.Count;
  BlockWrite(F,Tot,sizeof(Integer));
  i:=TabList.ItemIndex;
  BlockWrite(F,i,sizeof(Integer));
  for i:=0 to Tot-1 do
    begin
      Line:=TabList.Items[i];
      SaveString(Line,F);
    end;
end;

procedure LoadTabListBox(var TabList:TTabListBox; var F:File);
var
  i:Integer;
  Index:Integer;
  Tot:Integer;
  Line:string;
begin
  TabList.Clear;
  BlockRead(F,Tot,sizeof(Integer));
  BlockRead(F,Index,sizeof(Integer));
  for i:=0 to Tot-1 do
    begin
      LoadString(Line,F);
      TabList.Items.Add(Line);
    end;
  TabList.ItemIndex:=Index;
end;


