unit WybTryb;

interface

uses WinTypes, WinProcs, Classes, Graphics, Forms, Controls, Buttons,
  StdCtrls, ExtCtrls, Dialogs;


const
  War_1='- Zamawiaj�cy potrafi jednoznacznie okre�li� przedmiot zam�wienia;';
  War_2='- mo�liwe jest sprecyzowanie wszystkich warunk�w zwi�zanych z prowadzonym post�powaniem i realizacj� zam�wienia;';
  War_3='- istnieje szeroki (nieograniczony ilo�ciowo) rynek oferent�w (dostawc�w/wykonawc�w);';
  War_4='- wyb�r oferenta b�dzie dokonywany w oparciu o z g�ry okre�lone kryteria.';

  A14:Array[1..2] of String=
  ('Art. 14 Przetarg nieograniczony jako tryb podstawowy',
   'Podstawowym trybem udzielania zam�wienia publicznego jest przetarg nieograniczony.');

  A28:Array[1..5] of String=
  ('Art 28. Cel organizacji przetarg�w',
   '1. Przetarg jest organizowany przez zamawiaj�cego w celu wyboru najkorzystniejszej oferty na wykonanie zam�wienia ',
   'publicznego.',
   '2. W przetargu nieograniczonym oferty mog� z�o�y� wszyscy dostawcy lub wykonawcy, kt�rzy chc� wzi�� udzia� w przetargu,',
   ' z zastrze�eniem art. 23');

  A32:Array[1..4] of String=
  ('Zamawiaj�cy mo�e zorganizowa� PRZETARG OGRANICZONY w przypadku, gdy:',
   '1) ze wzgl�du na specjalistyczny charakter zam�wienia istnieje ograniczona liczba dostawc�w lub wykonawc�w mog�cych ',
   'wykona� dane zam�wienie,',
   '2) koszty przeprowadzenia przetargu nieograniczonego by�by niewsp�miernie wysokie w stosunku do warto�ci zam�wienia.');

  A54:Array[1..8] of String=
  ('PRZETARG DWUSTOPNIOWY stosuje si� w przypadku, gdy zachodzi jedna z nast�puj�cych okoliczno�ci:',
   '1) nie mo�na z g�ry okre�li� szczeg�owych cech technicznych i jako�ciowych zamawianych dostaw, us�ug lub rob�t ',
   'budowlanych,',
   '2) z powodu specjalistycznego charakteru dostaw, us�ug lub rob�t budowlanych konieczne s� negocjacje z dostawcami ',
   'lub wykonawcami,',
   '3) przedmiotem zam�wienia jest przeprowadzenie bada�, sporz�dzenie opinii naukowej albo �wiadczenie innych ',
   'wyspecjalizowanych us�ug.',
   '4) przedmiotem zam�wienia jest zaprojektowanie i wykonanie rob�t budowlanych.');

  A64:Array[1..6] of String=
  ('NEGOCJACJE Z ZACHOWANIEM KONKURENCJI stosowa� mo�na, gdy zachodzi jedna z nast�puj�cych okoliczno�ci:',
   '1) [skre�lony],',
   '2) zachodzi pilna potrzeba udzielenia zam�wienia w sytuacji, kt�rej wcze�niej nie mo�na by�o przewidzie�, a nie ',
   'wynika�a ona z winy zamawiaj�cego,',
   '3) wszcz�to post�powanie przetargowe i nie wp�yne�a wymagana liczba wa�nych ofert lub wszystkie oferty odrzucono, a mo�',
   'na w spos�b uzasadniony przypuszcza�, �e powt�rny przebieg przetargu nie doprowadzi do zawarcia umowy.');

  A68:Array[1..2] of String=
  ('ZAPYTANIE O CEN� mo�e by� stosowane, gdy przedmiotem zam�wienia s� dostawy rzeczy lub us�ugi powszechnie dost�pne o ',
   'ustalonych standardach jako�ciowych.');

  A71:Array[1..14] of String=
  ('Zamawiaj�cy mo�e udzieli� ZAM�WIENIA Z WOLNEJ R�KI tylko wtedy, gdy zachodzi jedna z nast�puj�cych okoliczno�ci:',
   '1) dokonuje zam�wie� dodatkowych, nie przekraczaj�cych 20% warto�ci uprzedniego zam�wienia, a zachodzi konieczno�� ',
   'zachowania tych samych norm, parametr�w i standard�w,',
   '2) zawiera umow� o przeprowadzenie bada�, eksperymentu lub sporz�dzenie opinii naukowej,',
   '3) ze wzgl�du na szczeg�lny rodzaj dostaw, us�ug lub rob�t budowlanych mo�na je uzyska� tylko od jednego dostawcy lub ',
   'wykonawcy,',
   '4) dokonuje zam�wienia publicznego na tw�rcze prace projektowe oraz na prace z zakresu dzia�alno�ci tw�rczej w ',
   'dziedzinie kultury i sztuki,',
   '5) mo�na skorzysta� tylko z jednego dostawcy lub wykonawcy w wyniku zastosowania dozwolonego zakresu preferencji ',
   'krajowych,',
   '6) ze wzgl�du na szczeg�lne okoliczno�ci gospodarcze lub spo�eczne, kt�rych zamawiaj�cy nie m�g� przewidzie� wymagane ',
   'jest natychmiastowe wykonanie zam�wienia,',
   '7) warto�� zam�wienia nie przekracza r�wnowarto�ci 3.000 ECU lub udzia� �rodk�w publicznych w finansowaniu zam�wienia ',
   'nie przekracza r�wnowarto�ci 3.000 ECU.');

  wt1_1='Czy istniej� warunki umo�liwiaj�ce przeprowadzenie';
  wt1_2='przetargu nieograniczonego ?';

  wt2_1='Organizuj�';
  wt2_2='PRZETARG NIEOGRANICZONY';
  wt2_3='(art. 14, art.28 ust. 1 i 2)';

  wt3_1='Ze wzgl�du na specjalistyczny charakter zam�wienia';
  wt3_2='istnieje ograniczona liczba oferent�w ?';

  wt4_1='Organizuj�';
  wt4_2='PRZETARG OGRANICZONY';
  wt4_3='(art. 32)';

  wt5_1='Dotycz�ce tylko ';
  wt5_2='PRZEDMIOTU ZAM�WIENIA ?';

  wt6_1='Niezb�dne s� negocjacje z oferentami ?';

  wt7_1='Organizuj�';
  wt7_2='PRZETARG DWUSTOPNIOWY';
  wt7_3='(zachodzi jedna z okoliczno�ci okre�lonych w art. 54)';

  wt8_1='Przeprowadzono przetarg i nie wp�yn�a wymagana liczba';
  wt8_2='ofert lub wszystkie oferty odrzucono ?';

{  wt9_1='Dotycz�ce ';
  wt9_2='PRZEDMIOTU ZAM�WIENIA i';
  wt9_3='WARUNK�W UMOWY ?';
  wt9_4='(zachodzi jedna z okoliczno�ci okre�lonych w art. 54)';}

  wt10_1='Przeprowadzam post�powanie w trybie';
  wt10_2='NEGOCJACJI Z ZACHOWANIEM KONKURENCJI';
  wt10_3='(zachodzi jedna z okoliczno�ci okre�lonych w art. 64)';

  wt11_1='Zachodzi pilna potrzeba udzielenia zam�wienia,';
  wt11_2='w sytuacji kt�rej nie mo�na by�o wcze�niej przewidzie�,';
  wt11_3='a kt�ra nie wynikne�a z winy zamawiaj�cego ?';

  wt12_1='Przeprowadzam procedur� w trybie';
  wt12_2='ZAPYTANIA O CEN�';
  wt12_3='(art. 68)';

  wt13_1='Przedmiotem zam�wienia s� dostawy, rzeczy lub us�ugi';
  wt13_2='powszechnie dost�pne o ustalonych standardach jako�ciowych';
  wt13_3='i jedynym kryterium wyboru jest CENA ?';

  wt14_1='Dokonuj�';
  wt14_2='ZAM�WIENIA Z WOLNEJ R�KI';

  wt15_1='Spe�nione s� okoliczno�ci okre�lone w artykule 71 ?';

  wt16_1='Sprawdzam poprawno�� odpowiedzi';
  wt16_2='i powtarzam procedur� wyboru trybu.';

  acWarunki='Warunki';
  acArticle='Artyku�';

type
  TWybTrybDlg = class(TForm)
    OKBtn: TBitBtn;
    CancelBtn: TBitBtn;
    HelpBtn: TBitBtn;
    YesBtn: TButton;
    NoBtn: TButton;
    BackBtn: TButton;
    Bevel: TBevel;
    Memo: TMemo;
    ArtBtn: TButton;
    RetryBtn: TBitBtn;
    procedure YesBtnClick(Sender: TObject);
    procedure NoBtnClick(Sender: TObject);
    procedure BackBtnClick(Sender: TObject);
    procedure ArtBtnClick(Sender: TObject);
    procedure RetryBtnClick(Sender: TObject);
    procedure OKBtnClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure HelpBtnClick(Sender: TObject);
    procedure CancelBtnClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    TextNumber:Byte;
    PrevTextNumber:Byte;
  public
    { Public declarations }
    ChosenTryb:Integer;
    AmountLevel:Integer;
    procedure Initialise;
  end;

function GetTrybZamowienia(AmLev:Integer):Integer; export;

implementation

{$R *.DFM}

uses
  Msg2,
  SysUtils,
  Utils,
  SiwzIni,
  ArtDlg;

function GetTrybZamowienia(AmLev:Integer):Integer;
const
  L1='Warto�� zam�wienia nie przekracza r�wnowarto�ci 3.000 ECU.';
  L2='Mo�esz zastosowa� tryb "ZAM�WIENIE Z WOLNEJ R�KI" ';
  L3='(art. 71 ust.1 pkt 7)';
  L4='Czy zastosowa� taki tryb ?';
var
  WybTrybDlg: TWybTrybDlg;
begin
   GetAllConfiguration;
   Application.HelpFile:=SiwzHelpFile;
  try
    if (AmLev=aLevel1) and (MessageDlg(L1+#13#10+L2+L3+#13#10+L4,mtWarning,[mbYes,mbNo],0)=mrYes)
      then Result:=iZamowienieWR   {Zamowienie z wolnej reki}
      else begin
        WybTrybDlg:=TWybTrybDlg.Create(Nil);
        ArticleDlg:=TArticleDlg.Create(Nil);
        WybTrybDlg.AmountLevel:=AmLev;
        WybTrybDlg.ShowModal;
        Result:=WybTrybDlg.ChosenTryb;
        ArticleDlg.Free;
        WybTrybDlg.Free;
      end;
  except
    on E:Exception do
      MessageDlg('B��d '+E.ClassName+' w S2WYBTRB.DLL', mtWarning, [mbOk],0);
  end;
end;

procedure TWybTrybDlg.Initialise;
begin
  TextNumber:=1;
  PrevTextNumber:=0;
  Memo.Clear;
  Memo.Lines.Add(wt1_1);
  Memo.Lines.Add(wt1_2);
  OkBtn.Enabled:=FALSE;
  BackBtn.Enabled:=FALSE;
  RetryBtn.Enabled:=FALSE;
  ArtBtn.Enabled:=TRUE;
  ArtBtn.Caption:=acWarunki;
  YesBtn.Enabled:=TRUE;
  NoBtn.Enabled:=TRUE;
end;

procedure TWybTrybDlg.YesBtnClick(Sender: TObject);
begin
  case TextNumber of
    1: begin
         Memo.Clear;
         Memo.Lines.Add(wt2_1);
         Memo.Lines.Add(wt2_2);
         Memo.Lines.Add(wt2_3);
         TextNumber:=2;
         ArtBtn.Enabled:=TRUE;
         ArtBtn.Caption:=acArticle;
         BackBtn.Enabled:=TRUE;
         YesBtn.Enabled:=FALSE;
         NoBtn.Enabled:=FALSE;
         OkBtn.Enabled:=TRUE;
         RetryBtn.Enabled:=TRUE;
       end;
    3: begin
         Memo.Clear;
         Memo.Lines.Add(wt4_1);
         Memo.Lines.Add(wt4_2);
         Memo.Lines.Add(wt4_3);
         TextNumber:=4;
         ArtBtn.Enabled:=TRUE;
         YesBtn.Enabled:=FALSE;
         NoBtn.Enabled:=FALSE;
         OkBtn.Enabled:=TRUE;
       end;
    5: begin
         Memo.Clear;
         Memo.Lines.Add(wt7_1);
         Memo.Lines.Add(wt7_2);
         Memo.Lines.Add(wt7_3);
         TextNumber:=7;
         ArtBtn.Enabled:=TRUE;
         YesBtn.Enabled:=FALSE;
         NoBtn.Enabled:=FALSE;
         OkBtn.Enabled:=TRUE;
       end;
    6: begin
         Memo.Clear;
         Memo.Lines.Add(wt5_1);
         Memo.Lines.Add(wt5_2);
         TextNumber:=5;
         ArtBtn.Enabled:=FALSE;
         YesBtn.Enabled:=TRUE;
         NoBtn.Enabled:=TRUE;
         OkBtn.Enabled:=FALSE;
       end;
    8,11:
       begin
          Memo.Clear;
          Memo.Lines.Add(wt10_1);
          Memo.Lines.Add(wt10_2);
          Memo.Lines.Add(wt10_3);
          PrevTextNumber:=TextNumber;
          TextNumber:=10;
          ArtBtn.Enabled:=TRUE;
          YesBtn.Enabled:=FALSE;
          NoBtn.Enabled:=FALSE;
          OkBtn.Enabled:=TRUE;
        end;
    13: begin
          Memo.Clear;
          Memo.Lines.Add(wt12_1);
          Memo.Lines.Add(wt12_2);
          Memo.Lines.Add(wt12_3);
          TextNumber:=12;
          ArtBtn.Enabled:=TRUE;
          YesBtn.Enabled:=FALSE;
          NoBtn.Enabled:=FALSE;
          OkBtn.Enabled:=TRUE;
        end;
    15: begin
          Memo.Clear;
          Memo.Lines.Add(wt14_1);
          Memo.Lines.Add(wt14_2);
          TextNumber:=14;
          ArtBtn.Enabled:=FALSE;
          YesBtn.Enabled:=FALSE;
          NoBtn.Enabled:=FALSE;
          OkBtn.Enabled:=TRUE;
        end;
  end;{case}
end;


procedure TWybTrybDlg.NoBtnClick(Sender: TObject);
const
  L1='Kwota powy�ej 200000 ECU.';
begin
  case TextNumber of
    1: begin
         if AmountLevel=aLevel7
           then MessageDlg(L1+#13#10+wmGetPermit,mtWarning,[mbOk],0);
         Memo.Clear;
         Memo.Lines.Add(wt3_1);
         Memo.Lines.Add(wt3_2);
         TextNumber:=3;
         BackBtn.Enabled:=TRUE;
         RetryBtn.Enabled:=TRUE;
         ArtBtn.Enabled:=FALSE;
         ArtBtn.Caption:=acArticle;
       end;
    3: begin
         Memo.Clear;
         Memo.Lines.Add(wt6_1);
         TextNumber:=6;
       end;
    5: begin
         Memo.Clear;
         Memo.Lines.Add(wt10_1);
         Memo.Lines.Add(wt10_2);
         Memo.Lines.Add(wt10_3);
          PrevTextNumber:=TextNumber;
{         Memo.Lines.Add(wt9_4);}
         TextNumber:=10;
         ArtBtn.Enabled:=TRUE;
         YesBtn.Enabled:=FALSE;
         NoBtn.Enabled:=FALSE;
         OkBtn.Enabled:=TRUE;
       end;
    6: begin
         Memo.Clear;
         Memo.Lines.Add(wt8_1);
         Memo.Lines.Add(wt8_2);
         TextNumber:=8;
       end;
    8: begin
         Memo.Clear;
         Memo.Lines.Add(wt11_1);
         Memo.Lines.Add(wt11_2);
         Memo.Lines.Add(wt11_3);
         TextNumber:=11;
       end;
    9,15: begin
          Memo.Clear;
          Memo.Lines.Add(wt16_1);
          Memo.Lines.Add(wt16_2);
          PrevTextNumber:=TextNumber;
          TextNumber:=16;
          RetryBtn.SetFocus;
          ArtBtn.Enabled:=FALSE;
          YesBtn.Enabled:=FALSE;
          NoBtn.Enabled:=FALSE;
          OkBtn.Enabled:=FALSE;
        end;
    11: begin
          Memo.Clear;
          Memo.Lines.Add(wt13_1);
          Memo.Lines.Add(wt13_2);
          Memo.Lines.Add(wt13_3);
          TextNumber:=13;
        end;
    13: begin
          Memo.Clear;
          Memo.Lines.Add(wt15_1);
          TextNumber:=15;
          ArtBtn.Enabled:=TRUE;
        end;
  end;{case}
end;

procedure TWybTrybDlg.BackBtnClick(Sender: TObject);
begin
  case TextNumber of
    2,3:
       begin
         Memo.Clear;
         Memo.Lines.Add(wt1_1);
         Memo.Lines.Add(wt1_2);
         TextNumber:=1;
         OkBtn.Enabled:=FALSE;
         YesBtn.Enabled:=TRUE;
         NoBtn.Enabled:=TRUE;
         BackBtn.Enabled:=FALSE;
         ArtBtn.Enabled:=TRUE;
         ArtBtn.Caption:=acWarunki;
       end;
    4,6:
       begin
         Memo.Clear;
         Memo.Lines.Add(wt3_1);
         Memo.Lines.Add(wt3_2);
         TextNumber:=3;
         OkBtn.Enabled:=FALSE;
         ArtBtn.Enabled:=FALSE;
         YesBtn.Enabled:=TRUE;
         NoBtn.Enabled:=TRUE;
       end;
    5,8:
      begin
        Memo.Clear;
        Memo.Lines.Add(wt6_1);
        TextNumber:=6;
        OkBtn.Enabled:=FALSE;
        YesBtn.Enabled:=TRUE;
        NoBtn.Enabled:=TRUE;
       end;
    7,9:
      begin
        Memo.Clear;
        Memo.Lines.Add(wt5_1);
        Memo.Lines.Add(wt5_2);
        TextNumber:=5;
        OkBtn.Enabled:=FALSE;
        ArtBtn.Enabled:=FALSE;
        YesBtn.Enabled:=TRUE;
        NoBtn.Enabled:=TRUE;
      end;
    10:
      begin
        Memo.Clear;
        case PrevTextNumber of
          5:
            begin
              Memo.Lines.Add(wt5_1);
              Memo.Lines.Add(wt5_2);
            end;
          8:
            begin
              Memo.Lines.Add(wt8_1);
              Memo.Lines.Add(wt8_2);
{              TextNumber:=8;   }
            end;
{          9:
            begin
              Memo.Lines.Add(wt9_1);
              Memo.Lines.Add(wt9_2);
              Memo.Lines.Add(wt9_3);
              Memo.Lines.Add(wt9_4);
              TextNumber:=9;
              ArtBtn.Enabled:=TRUE;
            end;}
         11:
            begin
              Memo.Lines.Add(wt11_1);
              Memo.Lines.Add(wt11_2);
              Memo.Lines.Add(wt11_3);
{              TextNumber:=11;}
            end;
        end;{case}
        TextNumber:=PrevTextNumber;
        OkBtn.Enabled:=FALSE;
        YesBtn.Enabled:=TRUE;
        NoBtn.Enabled:=TRUE;
      end;
     11:
       begin
         Memo.Clear;
         Memo.Lines.Add(wt8_1);
         Memo.Lines.Add(wt8_2);
         TextNumber:=8;
         ArtBtn.Enabled:=FALSE;
         YesBtn.Enabled:=TRUE;
         NoBtn.Enabled:=TRUE;
       end;
    12,15:
       begin
         Memo.Clear;
         Memo.Lines.Add(wt13_1);
         Memo.Lines.Add(wt13_2);
         Memo.Lines.Add(wt13_3);
         TextNumber:=13;
         ArtBtn.Enabled:=FALSE;
         OkBtn.Enabled:=FALSE;
         YesBtn.Enabled:=TRUE;
         NoBtn.Enabled:=TRUE;
       end;
    13:
       begin
         Memo.Lines.Add(wt11_1);
         Memo.Lines.Add(wt11_2);
         Memo.Lines.Add(wt11_3);
         TextNumber:=11;
         YesBtn.Enabled:=TRUE;
         NoBtn.Enabled:=TRUE;
       end;
    14:begin
         Memo.Clear;
         Memo.Lines.Add(wt15_1);
         TextNumber:=15;
         OkBtn.Enabled:=FALSE;
         ArtBtn.Enabled:=TRUE;
         YesBtn.Enabled:=TRUE;
         NoBtn.Enabled:=TRUE;
       end;
    16:begin
         case PrevTextNumber of
{           9: begin
                Memo.Clear;
                Memo.Lines.Add(wt9_1);
                Memo.Lines.Add(wt9_2);
                Memo.Lines.Add(wt9_3);
                Memo.Lines.Add(wt9_4);
                TextNumber:=9;
              end;}
           15: begin
                 Memo.Clear;
                 Memo.Lines.Add(wt15_1);
                 TextNumber:=15;
               end;
         end;{case}
         OkBtn.Enabled:=FALSE;
         ArtBtn.Enabled:=TRUE;
         YesBtn.Enabled:=TRUE;
         NoBtn.Enabled:=TRUE;
       end;
  end;{case}
end;

procedure TWybTrybDlg.ArtBtnClick(Sender: TObject);
begin
  case TextNumber of
    1: with ArticleDlg do
         begin
            Memo.Lines.Clear;
            Memo.Lines.Add(War_1);
            Memo.Lines.Add(War_2);
            Memo.Lines.Add(War_3);
            Memo.Lines.Add(War_4);
            Caption:='Warunki'
         end;
    2 : with ArticleDlg do
          begin
            Memo.Lines.Clear;
            Memo.Lines.Add(A14[1]);
            Memo.Lines.Add(A14[2]);
            Memo.Lines.Add(' ');
            Memo.Lines.Add(A28[1]);
            Memo.Lines.Add(A28[2]+A28[3]);
            Memo.Lines.Add(A28[4]+A28[5]);
            Caption:='Artyku�y 14 i 28'
          end;
    4 : with ArticleDlg do
          begin
            Memo.Lines.Clear;
            Memo.Lines.Add(A32[1]);
            Memo.Lines.Add(A32[2]+A32[3]);
            Memo.Lines.Add(A32[4]);
            Caption:='Artyku� 32'
          end;
    7 : with ArticleDlg do
          begin
            Memo.Lines.Clear;
            Memo.Lines.Add(A54[1]);
            Memo.Lines.Add(A54[2]+A54[3]);
            Memo.Lines.Add(A54[4]+A54[5]);
            Memo.Lines.Add(A54[6]+A54[7]);
            Memo.Lines.Add(A54[8]);
            Caption:='Artyku� 54'
          end;
    10 : with ArticleDlg do
          begin
            Memo.Lines.Clear;
            Memo.Lines.Add(A64[1]);
            Memo.Lines.Add(A64[2]);
            Memo.Lines.Add(A64[3]+A64[4]);
            Memo.Lines.Add(A64[5]+A64[6]);
            Caption:='Artyku� 64'
          end;
    12 : with ArticleDlg do
           begin
             Memo.Lines.Clear;
             Memo.Lines.Add(A68[1]);
             Memo.Lines.Add(A68[2]);
             Caption:='Artyku� 68'
           end;
    15 : with ArticleDlg do
           begin
             Memo.Lines.Clear;
             Memo.Lines.Add(A71[1]);
             Memo.Lines.Add(A71[2]+A71[3]);
             Memo.Lines.Add(A71[4]);
             Memo.Lines.Add(A71[5]+A71[6]);
             Memo.Lines.Add(A71[7]+A71[8]);
             Memo.Lines.Add(A71[9]+A71[10]);
             Memo.Lines.Add(A71[11]+A71[12]);
             Memo.Lines.Add(A71[13]+A71[14]);
             Caption:='Artyku� 71'
           end;
  end;{case}
  ArticleDlg.ShowModal;
end;

procedure TWybTrybDlg.RetryBtnClick(Sender: TObject);
begin
  Initialise;
end;

procedure TWybTrybDlg.OKBtnClick(Sender: TObject);
begin
  case TextNumber of
    2 : ChosenTryb:=iNieOgraniczony; {Przetarg nieograniczony}
    4 : ChosenTryb:=iOgraniczony;    {Przetarg ograniczony}
    7 : ChosenTryb:=iDwustopniowy;   {Przetarg dwustopniowy}
    10: ChosenTryb:=iNegocjacje;     {Negocjacje z zach. konk.}
    12: ChosenTryb:=iZapytanieOCene; {Zapytanie o cene}
    14: ChosenTryb:=iZamowienieWR;   {Zamowienie z wolnej reki}
  end;{case}
end;

procedure TWybTrybDlg.FormActivate(Sender: TObject);
begin
  Initialise;
end;

procedure TWybTrybDlg.HelpBtnClick(Sender: TObject);
begin
  Application.HelpContext(2003);
end;

procedure TWybTrybDlg.CancelBtnClick(Sender: TObject);
begin
  ChosenTryb:=-1;
end;

procedure TWybTrybDlg.FormCreate(Sender: TObject);
begin
  GetAllConfiguration;
  Application.HelpFile:=SiwzHelpFile;
end;

end.
