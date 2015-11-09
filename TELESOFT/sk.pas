unit Sk;

interface

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Forms, Dialogs;

const
  MAX_LENGTH_LABEL = 16;
  MAX_LENGTH_PW    = 16;
  MAX_LENGTH_DATA  = 64;
  MAX_LENGTH_EXT_DATA =352;
  LPT1	     =	1;

type
TDataArray=array[1 .. MAX_LENGTH_DATA+MAX_LENGTH_EXT_DATA]  of Char;

TKey = record
  FNetCommand  : array [0..1] of Char;
  FNetPassword : array [0..3] of Char;
  FLpt	       : integer;
  FCommand     : array[0..1] of Char;
  FLabel       : array[0 .. MAX_LENGTH_LABEL-1] of Char;
  FPassword    : array[0 .. MAX_LENGTH_PW-1]    of Char;
  FData	       : array[0 .. MAX_LENGTH_DATA-1]  of Char;
  FFailCounter : integer;
  FStatus      : integer;
  FExtData     : array[0 .. MAX_LENGTH_EXT_DATA-1]  of Char;
end;

TSmartKey=class(TComponent)
private
  FKey:TKey;
protected
  procedure FillParam (Field:Integer; DataField:string);
  function GetData:String;
  procedure SetData(Value:String);
  function GetLabel:String;
  procedure SetLabel(Value:String);
  function GetPwd:String;
  procedure SetPwd(Value:String);
  function GetDataArray:TDataArray;
  procedure SetDataArray(Value:TDataArray);
  function GetMsg:String;
public
{  DataArray:TDataArray;}
  constructor Create(AOwner:TComponent);override;
  destructor Destroy;override;
  procedure Open(AppNumber:Byte);
  procedure Close;
  procedure Read;
  procedure Users(AppNumber:Byte);
  procedure Write;
  procedure ResetDataArray;
  property DataArray:TDataArray read GetDataArray write SetDataArray;
published
  property DataString:String read GetData write SetData;
  property Lpt:Integer read FKey.FLpt write FKey.FLpt;
  property SkLabel:String read GetLabel write SetLabel;
  property SkPassword:String read GetPwd write SetPwd;
  property Status:Integer read FKey.FStatus;
  property StatusMessage:String read GetMsg;
end;

procedure Register;

implementation

  {$F+} 				     { Force Far Call controls	    }
  {$L paslink.obj}			     { Include interface module     }
  {$L skeylink.obj}			     { Include driver module	    }

procedure Register;
begin
  RegisterComponents('Telesoft',[TSmartKey]);
end;

procedure pas_link (key: TKey); external;

constructor TSmartKey.Create(AOwner:TComponent);
begin
  inherited Create(AOwner);
end;

destructor TSmartKey.Destroy;
begin
  inherited Destroy;
end;

procedure TSmartKey.FillParam (Field:Integer; DataField:string);
var
  k: integer;
  buff_data: string[MAX_LENGTH_DATA*2];
begin
{  buff_data := copy (DataField, 1, Length (DataField));
  case field of
    1:begin
        FillChar (buff_data[Length(buff_data)+1], (MAX_LENGTH_LABEL*2-(Length(buff_data))), Chr (0));
        for k := 1 to (MAX_LENGTH_LABEL) do
          FKey.Flabel[k] := ((integer (buff_data[k*2])) * 256) + integer (buff_data[(k*2)-1]);
      end;
    2:begin
        FillChar (buff_data[Length(buff_data)+1], (MAX_LENGTH_PW*2-(Length(buff_data))), Chr (0));
        for k := 1 to (MAX_LENGTH_PW) do
          FKey.Fpassword[k] := ((integer (buff_data[k*2])) * 256) + integer (buff_data[(k*2)-1]);
      end;
    3:
      begin
        FillChar (buff_data[Length(buff_data)+1], (MAX_LENGTH_DATA*2-(Length(buff_data))), Chr (0));
        for k := 1 to (MAX_LENGTH_DATA) do
          FKey.Fdata[k] := ((integer (buff_data[k*2])) * 256) + integer (buff_data[(k*2)-1]);
      end;
  end;}
end;

procedure TSmartKey.SetData(Value:String);
var
  Buffer: string[MAX_LENGTH_DATA];
  k:Byte;
begin
  Buffer := Copy (Value, 1, Length (Value));
  FillChar (Buffer[Length(Buffer)+1], (MAX_LENGTH_DATA-(Length(Buffer))), Chr (0));
  for k := 1 to (MAX_LENGTH_DATA) do
    FKey.FData[k-1]:=Buffer[k];
end;

function TSmartKey.GetData:String;
begin
  Result:=StrPas(@FKey.FData[0]);
end;

function TSmartKey.GetDataArray:TDataArray;
var
  k:Word;
begin
  for k := 1 to (MAX_LENGTH_DATA) do
    Result[k]:=FKey.FData[k-1];
  for k := 1 to (MAX_LENGTH_EXT_DATA) do
    Result[k+MAX_LENGTH_DATA]:=FKey.FExtData[k-1];
end;

procedure TSmartKey.SetDataArray(Value:TDataArray);
var
  k:Word;
begin
  for k := 1 to (MAX_LENGTH_DATA) do
    FKey.FData[k-1]:=Value[k];
  for k := 1 to (MAX_LENGTH_EXT_DATA) do
    FKey.FExtData[k-1]:=Value[k+MAX_LENGTH_DATA];
end;

procedure TSmartKey.ResetDataArray;
var
  k:Word;
begin
  for k := 1 to (MAX_LENGTH_DATA) do
    FKey.FData[k-1]:=Chr(0);
  for k := 1 to (MAX_LENGTH_EXT_DATA) do
    FKey.FExtData[k-1]:=chr(0);
end;

procedure TSmartKey.SetLabel(Value:String);
var
  Buffer: string[MAX_LENGTH_LABEL];
  k:Byte;
begin
  Buffer := Copy (Value, 1, Length (Value));
  FillChar (Buffer[Length(Buffer)+1], (MAX_LENGTH_LABEL-(Length(Buffer))), Chr (0));
  for k := 1 to (MAX_LENGTH_LABEL) do
    FKey.Flabel[k-1]:=Buffer[k];
end;

function TSmartKey.GetLabel:String;
begin
  Result:=StrPas(@FKey.FLabel[0]);
end;

procedure TSmartKey.SetPwd(Value:String);
var
  Buffer: string[MAX_LENGTH_PW];
  k:Byte;
begin
  Buffer := Copy (Value, 1, Length (Value));
  FillChar (Buffer[Length(Buffer)+1], (MAX_LENGTH_PW-(Length(Buffer))), Chr (0));
  for k := 1 to (MAX_LENGTH_PW) do
    FKey.FPassword[k-1]:=Buffer[k];
end;

function TSmartKey.GetPwd:String;
begin
  Result:=StrPas(@FKey.FPassword[0]);
end;

procedure TSmartKey.Open(AppNumber:Byte);
var
  y:Byte;
begin
  FKey.FNetCommand[0]:='O';
  if AppNumber>0
    then begin
      for y:=1 to MAX_LENGTH_DATA do
        FKey.FData[y]:=Chr(0);
      FKey.FData[0]:=Chr($4d);
      FKey.FData[1]:=Chr($41);
      FKey.FData[2]:=Chr(AppNumber);
    end;
  pas_link (FKey);		   { Driver call pointing to structure }
end;

procedure TSmartKey.Close;
begin
  FKey.FNetCommand[0]:='C';
  pas_link (FKey);		   { Driver call pointing to structure }
end;

procedure TSmartKey.Users(AppNumber:Byte);
var
  y:Byte;
begin
  FKey.FNetCommand[0]:='A';
  FKey.FCommand[0]:='U';
  if AppNumber>0
    then begin
      for y:=1 to MAX_LENGTH_DATA do
        FKey.FData[y]:=Chr(0);
      FKey.FData[0]:=Chr($4d);
      FKey.FData[1]:=Chr($41);
      FKey.FData[2]:=Chr(AppNumber);
    end;
  pas_link (FKey);		   { Driver call pointing to structure }
end;

procedure TSmartKey.Read;
begin
  FKey.FNetCommand[0]:='A';
  FKey.FCommand[0]:='R';
  pas_link (FKey);		   { Driver call pointing to structure }
end;

procedure TSmartKey.Write;
begin
  FKey.FNetCommand[0]:='A';
  FKey.FCommand[0]:='W';
  pas_link (FKey);		   { Driver call pointing to structure }
end;

function TSmartKey.GetMsg:String;
begin
  result:=IntToStr(status)+' <no status info available>';
  case status of
     0 : result:='Ok';
    -1 : result:='No Smartkey found';
    -2 : result:='Syntax error during driver call';
    -3 : result:='Wrong Label';
    -4 : result:='Wrong password or data mismatch';
    -6 : result:='Attempt to close without a prior open command';
    -7 : result:='Access error to the protection device without a prior open command';
    -8 : result:='Problems connected with the network';
   -11 : result:='Insufficient memory on client'; 
   -20 : result:='Write operation error';
  end;
end;

end.
