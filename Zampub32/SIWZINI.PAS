unit Siwzini;

interface

uses
  SysUtils,WinProcs,IniFiles,Dialogs,Utils;

const
{Key data}
{$IFDEF NONET}
  SmartKeyLabel='TELESOFT';
  SmartKeyPwd='##PANDORO##';
  SkData='TCZP20TCZP30';
{$ENDIF}
{$IFDEF NET}
  SmartKeyLabel='TELESOFTNET';
  SmartKeyPwd='##PANDORO##';
  SkData='MA';
  SiwzNetNum=4;
  DruZpNetNum=5;
  OcenaNetNum=6;
  AdminNetNum=7;
  RapNetNum=8;
{$ENDIF}

{INI file}
  SiwzIniName='ZAMPUB30.INI';

{Files version string}
  VersionString=#3+#2+#0+#3+#0+#0+#2;  {ver. 3.0}
  VersionString32=#3+#2+#0+#3+#0+#2+#2; {ver. 3.2}

{User strings}
  usAdministrator='Administrator';
  usUser='U�ytkownik';

{Files labels}
  NieFileHdr='NIESIWZ';
  OgrFileHdr='OGRSIWZ';
  DwuFileHdr='DWUSIWZ';
  NegFileHdr='NEGSIWZ';
  ZapFileHdr='ZAPSIWZ';
  ZamFileHdr='ZAMSIWZ';

{TenderType}
  ttNie=1;
  ttOgr=2;
  ttDwu=3;
  ttNeg=4;
  ttZap=5;
  ttZam=6;

{Amount levels}
  aLevel1=1;   {<3000}
  aLevel2=2;   {3001 - 20000}
  aLevel3=3;   {20001 - 30000}
  aLevel4=4;   {30001 - 50000}
  aLevel5=5;   {50001 - 100000}
  aLevel6=6;   {100001 - 200000}
  aLevel7=7;   {>200000}
  aLevelUnkown=$FF;

{Order kind}
  okDostawa=0;
  okUslugi=1;
  okRobBud=2;

{OpenMode}
  oNew=1;
  oOpen=2;
  oDefNew=3;

{ModalResult}
  mrNew=10;
  mrOpen=11;
  mrDefNew=12;

  SelectionChar='#';
  Nip1Str='NIP1';
  Nip2Str='NIP2';

{Security file}
  SecurityFileName='users.zp3'; {if changed then change in /install/pwd.pas}

{Default dir}
  DefaultDir='C:\ZAMPUB3';

{Default id and desc}
  DefaultId   ='00000000';
  DefaultDesc ='Zbi�r domy�lny';

  DefaultFileName='DEFAULT';  {da cancellare}

{extensions}
  NieExt='PNO';
  OgrExt='POG';
  DwuExt='PDW';
  NegExt='NZK';
  ZapExt='ZOC';
  ZamExt='ZWR';
  TxtExt='TXT';{Export}
  OuExt='OUP';{Osobe uprawnione}

{filter}
  AllFilter='Prz. nieograniczony|*.'+NieExt+
            '|Prz. ograniczony|*.'+OgrExt+
            '|Prz. dwustopniowy|*.'+DwuExt+
            '|Neg z zach. konk.|*.'+NegExt+
            '|Zap. o cen�|*.'+ZapExt+
            '|Zam. z wolnej r�ki|*.'+ZamExt;
  NieFilter='Prz. nieograniczony|*.'+NieExt;
  OgrFilter='|Prz. ograniczony|*.'+OgrExt;
  DwuFilter='|Prz. dwustopniowy|*.'+DwuExt;
  NegFilter='|Neg z zach. konk.|*.'+NegExt;
  ZapFilter='|Zap. o cen�|*.'+ZapExt;
  ZamFilter='|Zam. z wolnej r�ki|*.'+ZamExt;
  TxtFilter='Plik tekstowy|*.txt';

{Przetarg kind}
  iNieograniczony = 1;
  iOgraniczony    = 2;
  iDwustopniowy   = 3;
  iZapytanieOCene = 4;
  iZamowienieWR   = 5;
  iNegocjacje     = 6;

{Phases dwu}
  mFirstPhase='  Pierwszy etap';
  mSecondPhase='  Drugi etap';

{Notebook pages total}
  Prt1MaxPages= 16;
  Prt2MaxPages= 17;
  Prt3MaxPages30= 4;
  Prt3MaxPages32= 7;
  Prt4MaxPages= 16;
  Prt5MaxPages= 4;

  sSIWZ='SPECYFIKACJA ISTOTNYCH WARUNK�W ZAM�WIENIA';
  sDOKUM='DOKUMENTACJA Z POST�POWANIA PRZETARGOWEGO PROWADZONEGO W TRYBIE ';
  sNieograniczony = 'przetarg nieograniczony ';
  sOgraniczony    = 'przetarg ograniczony ';
  sDwustopniowy   = 'przetarg dwustopniowy ';
  sNegocjacje     = 'negocjacje z zachowaniem konkurencji ';
  sZapytanieOCene = 'zam�wienie publiczne w trybie zapytania o cen� ';
  sZamowienieWR   = 'zam�wienie z wolnej r�ki ';
  sNieograniczonyTitle = 'PRZETARG NIEOGRANICZONY';
  sOgraniczonyTitle = 'PRZETARG OGRANICZONY';
  sDwustopniowyTitle = 'PRZETARG DWUSTOPNIOWY';
  sNegocjacjeTitle = 'NEGOCJACJE Z ZACHOWANIEM KONKURENCJI';
  sZapytanieOCeneTitle = 'ZAPYTANIE O CEN�';
  sZamowienieWRTitle   = 'ZAM�WIENIE Z WOLNEJ R�KI';

  sNamePost ='Nazwa post�powania';
  sNamePrze ='Nazwa przetargu';

  sNieograniczonych = 'nieograniczonych ';
  sOgraniczonych    = 'ograniczonych ';
  sDwustopniowych   = 'dwustopniowych ';
  sZapytaniaOCene   = 'zam�wie� publicznych w trybie zapytania o cen� ';
  sZamowieniaWR     = 'zam�wie� z wolnej r�ki ';

  sListaPrze = 'Lista przetarg�w ';
  sListaNeg  = 'Lista post�powa� w trybie negociacji z zachowaniem konkurencji';
  sListaPostZamWR='Lista post�powa� o zam�wieniach publicznych';
  sListaPostZapOCene='Lista post�powa� w trybie zapytania o cen�';

  sDostawy='dostawy: ';
  sUslugi='us�ugi: ';
  sRobotyBud='roboty budowlane: ';

  sOferenci='oferenci';
  sDostawcy='dostawcy';
  sWykonawcy='wykonawcy';

  sWarunkiEdit1='O zam�wienie mog� ubiega� si� ';
  sWarunkiEdit2=', kt�rzy spe�niaj� nast�puj�ce warunki :';

  sOfertaCala='Oferta musi obejmowa� ca�o�� zam�wienia';
  sOfertaCzesc='Dopuszcza si� sk�adanie ofert cz�ciowych na nast�puj�ce ';

  sZamawiajacy='Zamawiaj�cy:';
  sAdres='Adres: ';
  sId='Identyfikator: ';
  sDesc='Opis: ';
  sRoom=' pok. ';
  sTel='Telefon: ';
  sFax='Telefaks: ';
  sTelex='Teleks: ';
  sRegon='REGON: ';
  sNip='NIP: ';
  sWartZam='Warto�� zam�wienia: ';

  mIncorrectFilePwd='Zbi�r nie ma w�a�ciwego has�a';

var
{directories}
  WindowsDir:string;
  WinSystemDir:string;
  ProgramDir:string;

{help file name}
  SiwzHelpFile:string;
  DruZpHelpFile:string;
  OcOfHelpFile:string;
  RapHelpFile:string;

{data from ini file}
  ProgramIni:string;
  VersionIni:string;
  CopyrightIni:string;

{user data}
  UserName:String;
  UserPwd:String;
  UserType:Byte;

procedure GetWindowsDir;
procedure GetAllConfiguration;
function IsGoodExtension(Ext:String):Boolean;

implementation

function IsGoodExtension(Ext:String):Boolean;
begin
  Result:=(Ext=NieExt) or (Ext=OgrExt) or (Ext=DwuExt) or
         (Ext=NegExt) or (Ext=ZapExt) or (Ext=ZamExt)
end;

procedure GetWindowsDir;
begin
  GetWindowsDirectory(@WindowsDir[1], SizeOf(WindowsDir) - 1 );
  WindowsDir[0]:=Chr(StrLen(@WindowsDir[1]));
  WindowsDir:=AddBackSlash(WindowsDir);

  GetSystemDirectory(@WinSystemDir[1], SizeOf(WinSystemDir) - 1 );
  WinSystemDir[0]:=Chr(StrLen(@WinSystemDir[1]));
  WinSystemDir:=AddBackSlash(WinSystemDir);
end;

procedure GetAllConfiguration;
var
  IniFile:TIniFile;
begin
  try
    IniFile:=TIniFile.Create(SiwzIniName);{search in windows dir}
    try
      ProgramDir:=IniFile.ReadString('General','DefaultDir',DefaultDir);
      SiwzHelpFile:=IniFile.ReadString('General','SiwzHelpFile','');
      SiwzHelpFile:=AddBackSlash(ProgramDir)+SiwzHelpFile;
      DruZpHelpFile:=IniFile.ReadString('General','DruZpHelpFile','');
      DruZpHelpFile:=AddBackSlash(ProgramDir)+DruZpHelpFile;
      OcOfHelpFile:=IniFile.ReadString('General','OcOfHelpFile','');
      OcOfHelpFile:=AddBackSlash(ProgramDir)+OcofHelpFile;
      RapHelpFile:=IniFile.ReadString('General','RapHelpFile','');
      RapHelpFile:=AddBackSlash(ProgramDir)+RapHelpFile;
      ProgramIni:=IniFile.ReadString('General','Program','');
      VersionIni:=IniFile.ReadString('General','Version','');
      CopyrightIni:=IniFile.ReadString('General','Copyright','');
    finally
      IniFile.Free;
    end;
  except
    on EInOutError do
      ShowMessage('Error opening '+SiwzIniName);
  end;
end;

end.
