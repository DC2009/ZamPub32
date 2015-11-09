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
  usUser='U¿ytkownik';

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
  DefaultDesc ='Zbiór domyœlny';

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
            '|Zap. o cenê|*.'+ZapExt+
            '|Zam. z wolnej rêki|*.'+ZamExt;
  NieFilter='Prz. nieograniczony|*.'+NieExt;
  OgrFilter='|Prz. ograniczony|*.'+OgrExt;
  DwuFilter='|Prz. dwustopniowy|*.'+DwuExt;
  NegFilter='|Neg z zach. konk.|*.'+NegExt;
  ZapFilter='|Zap. o cenê|*.'+ZapExt;
  ZamFilter='|Zam. z wolnej rêki|*.'+ZamExt;
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

  sSIWZ='SPECYFIKACJA ISTOTNYCH WARUNKÓW ZAMÓWIENIA';
  sDOKUM='DOKUMENTACJA Z POSTÊPOWANIA PRZETARGOWEGO PROWADZONEGO W TRYBIE ';
  sNieograniczony = 'przetarg nieograniczony ';
  sOgraniczony    = 'przetarg ograniczony ';
  sDwustopniowy   = 'przetarg dwustopniowy ';
  sNegocjacje     = 'negocjacje z zachowaniem konkurencji ';
  sZapytanieOCene = 'zamówienie publiczne w trybie zapytania o cenê ';
  sZamowienieWR   = 'zamówienie z wolnej rêki ';
  sNieograniczonyTitle = 'PRZETARG NIEOGRANICZONY';
  sOgraniczonyTitle = 'PRZETARG OGRANICZONY';
  sDwustopniowyTitle = 'PRZETARG DWUSTOPNIOWY';
  sNegocjacjeTitle = 'NEGOCJACJE Z ZACHOWANIEM KONKURENCJI';
  sZapytanieOCeneTitle = 'ZAPYTANIE O CENÊ';
  sZamowienieWRTitle   = 'ZAMÓWIENIE Z WOLNEJ RÊKI';

  sNamePost ='Nazwa postêpowania';
  sNamePrze ='Nazwa przetargu';

  sNieograniczonych = 'nieograniczonych ';
  sOgraniczonych    = 'ograniczonych ';
  sDwustopniowych   = 'dwustopniowych ';
  sZapytaniaOCene   = 'zamówieñ publicznych w trybie zapytania o cenê ';
  sZamowieniaWR     = 'zamówieñ z wolnej rêki ';

  sListaPrze = 'Lista przetargów ';
  sListaNeg  = 'Lista postêpowañ w trybie negociacji z zachowaniem konkurencji';
  sListaPostZamWR='Lista postêpowañ o zamówieniach publicznych';
  sListaPostZapOCene='Lista postêpowañ w trybie zapytania o cenê';

  sDostawy='dostawy: ';
  sUslugi='us³ugi: ';
  sRobotyBud='roboty budowlane: ';

  sOferenci='oferenci';
  sDostawcy='dostawcy';
  sWykonawcy='wykonawcy';

  sWarunkiEdit1='O zamówienie mog¹ ubiegaæ siê ';
  sWarunkiEdit2=', którzy spe³niaj¹ nastêpuj¹ce warunki :';

  sOfertaCala='Oferta musi obejmowaæ ca³oœæ zamówienia';
  sOfertaCzesc='Dopuszcza siê sk³adanie ofert czêœciowych na nastêpuj¹ce ';

  sZamawiajacy='Zamawiaj¹cy:';
  sAdres='Adres: ';
  sId='Identyfikator: ';
  sDesc='Opis: ';
  sRoom=' pok. ';
  sTel='Telefon: ';
  sFax='Telefaks: ';
  sTelex='Teleks: ';
  sRegon='REGON: ';
  sNip='NIP: ';
  sWartZam='Wartoœæ zamówienia: ';

  mIncorrectFilePwd='Zbiór nie ma w³aœciwego has³a';

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
