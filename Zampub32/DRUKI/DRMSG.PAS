unit Drmsg;

interface
const

{warnings}
  wmUserNameEmpty='Pole "U¿ytkownik" nie mo¿e byæ puste';
  wmPasswordEmpty='Pole "Has³o" nie mo¿e byæ puste';
  wmLoginIncorrect='Login nie prawid³owy';
  wmOldPwdIncorrect='Stare has³o nieprawid³owe';
  wmDifferentPwd='B³êdne nowe has³o';

  wmSecurityFileNotFound='Zbiór hase³ nie znaleziony';
  wmCantOpenSecurityFile='Nie mo¿na otwieraæ zbioru hase³';
  wmSecurityCode='Zbiór nie ma w³aœciwego has³a';

  wmFileNotFound='Zbiór nie znaleziony';
  wmFileAccessDenied='Nie ma dostêpu do pliku';
  wmFileAlreadyLoaded='Zbiór juz za³adowany';
  wmReadBeyondEnd='Zbiór niew³aœciwy (b³¹d 100)';
  wmNotAZP='Zbiór niew³aœciwy';
  wmNoDirSelected='Najpierw wybierz katalog';
  wmDeleteWholeDir='Katalog i wszystkie zbiory w nim bêd¹ usuniête!';
  wmTryAgain='Ponów próbê';
  wmFileNotDeleted='Zbiór nie usuniêty';
  wmNoDirsForUser='Nie ma baz danych dla tego u¿ytkownika';
  wmNoUserSelected='Najpierw wybierz u¿ytkownika';
  wmUserEmpty='Pole "Nazwa u¿ytkownika" nie mo¿e byæ puste';
  wmUserAlreadyExists='U¿ytkownik ju¿ istnieje';
  wmEndDateBeforeStartDate='Data zakoñczenia jest wczeœniejsza ni¿ data rozpoczêcia';
  wmIncorrectDate='Data nieprawid³owa';

  wmIdEmpty='Pole "Identyfikator" jest puste';
  wmDescEmpty='Pole "Opis" jest puste';
  wmNewDocument='Nowy identyfikator. Tworzyæ now¹ SIWZ ?';

  wmTimeError='Niew³aœciwa godzina';


  wmConfirmExit='PotwierdŸ wyjœcie';
  wmSaveOnExit='Czy zachowaæ dane ?';
wmValueOver32767='Wartoœæ powy¿ej 32767 (maks.)';

emIncompatibleFile='Zbiór nie jest zgodny z t¹ wersj¹. Zbiór nie mo¿e byæ odczytany';
emIncompatibleDefFile='Zbiór domyœlny nie jest zgodny z t¹ wersj¹. Zbiór nie mo¿e byæ odczytany';
emMemberAlreadyInList='Nazwisko ju¿ podane';

cmDeleteConfirm='Na pewno usun¹æ?';
cmClosePrg='Naciœniêcie OK zakoñczy program';

mUnableToLoadDLL='Nie mo¿na ³adowaæ ';

imAvailableInOcena='Druk dostêpny w module OCOP';

implementation

end.
