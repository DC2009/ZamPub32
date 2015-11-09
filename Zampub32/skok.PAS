unit Skok;

interface

uses
  Messages,
  Dialogs,
  Utils,
  Sk;

function SmartKeyOk(SK:TSmartKey; AData:String):Boolean;
function NetSmartKeyOk(SK:TSmartKey; ApplNum:Byte):Boolean;

implementation

function SmartKeyOk(SK:TSmartKey; AData:String):Boolean;
begin
  Result:=TRUE;
  Sk.SkLabel:=SuperUserName;
  Sk.SkPassword:=SuperPassword;
  Sk.Open(0);
  if Sk.Status=0
    then Sk.Read;
  if (Sk.Status<>0)
    then MessageDlg(Sk.StatusMessage,mtWarning,[mbOk],0)
  else  if (Sk.DataString<>AData)
    then MessageDlg('Klucz nie jest przeznaczony do tej wersji',mtWarning,[mbOk],0);
  Result:=(Sk.Status=0) and (Sk.DataString=AData);
  Sk.Close;
end;

function NetSmartKeyOk(SK:TSmartKey; ApplNum:Byte):Boolean;
begin
  Result:=TRUE;
  Sk.SkLabel:=SuperUserName;
  Sk.SkPassword:=SuperPassword;
  Sk.Open(ApplNum);
  if (Sk.Status<>0)
    then MessageDlg(Sk.StatusMessage,mtWarning,[mbOk],0);
  Result:=(Sk.Status=0);
{  Sk.Close;}
end;

end.
