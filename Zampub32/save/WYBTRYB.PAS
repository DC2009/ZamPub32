unit WybTryb;

interface

uses WinTypes, WinProcs, Classes, Graphics, Forms, Controls, Buttons,
  StdCtrls, ExtCtrls, Dialogs;


const
  War_1='- Zamawiaj¹cy potrafi jednoznacznie okreœliæ przedmiot zamówienia;';
  War_2='- mo¿liwe jest sprecyzowanie wszystkich warunków zwi¹zanych z prowadzonym postêpowaniem i realizacj¹ zamówienia;';
  War_3='- istnieje szeroki (nieograniczony iloœciowo) rynek oferentów (dostawców/wykonawców);';
  War_4='- wybór oferenta bêdzie dokonywany w oparciu o z góry okreœlone kryteria.';

  A14:Array[1..2] of String=
  ('Art. 14 Przetarg nieograniczony jako tryb podstawowy',
   'Podstawowym trybem udzielania zamówienia publicznego jest przetarg nieograniczony.');

  A28:Array[1..5] of String=
  ('Art 28. Cel organizacji przetargów',
   '1. Przetarg jest organizowany przez zamawiaj¹cego w celu wyboru najkorzystniejszej oferty na wykonanie zamówienia ',
   'publicznego.',
   '2. W przetargu nieograniczonym oferty mog¹ z³o¿yæ wszyscy dostawcy lub wykonawcy, którzy chc¹ wzi¹æ udzia³ w przetargu,',
   ' z zastrze¿eniem art. 23');

  A32:Array[1..4] of String=
  ('Zamawiaj¹cy mo¿e zorganizowaæ PRZETARG OGRANICZONY w przypadku, gdy:',
   '1) ze wzglêdu na specjalistyczny charakter zamówienia istnieje ograniczona liczba dostawców lub wykonawców mog¹cych ',
   'wykonaæ dane zamówienie,',
   '2) koszty przeprowadzenia przetargu nieograniczonego by³by niewspó³miernie wysokie w stosunku do wartoœci zamówienia.');

  A54:Array[1..8] of String=
  ('PRZETARG DWUSTOPNIOWY stosuje siê w przypadku, gdy zachodzi jedna z nastêpuj¹cych okolicznoœci:',
   '1) nie mo¿na z góry okreœliæ szczegó³owych cech technicznych i jakoœciowych zamawianych dostaw, us³ug lub robót ',
   'budowlanych,',
   '2) z powodu specjalistycznego charakteru dostaw, us³ug lub robót budowlanych konieczne s¹ negocjacje z dostawcami ',
   'lub wykonawcami,',
   '3) przedmiotem zamówienia jest przeprowadzenie badañ, sporz¹dzenie opinii naukowej albo œwiadczenie innych ',
   'wyspecjalizowanych us³ug.',
   '4) przedmiotem zamówienia jest zaprojektowanie i wykonanie robót budowlanych.');

  A64:Array[1..6] of String=
  ('NEGOCJACJE Z ZACHOWANIEM KONKURENCJI stosowaæ mo¿na, gdy zachodzi jedna z nastêpuj¹cych okolicznoœci:',
   '1) [skreœlony],',
   '2) zachodzi pilna potrzeba udzielenia zamówienia w sytuacji, której wczeœniej nie mo¿na by³o przewidzieæ, a nie ',
   'wynika³a ona z winy zamawiaj¹cego,',
   '3) wszczêto postêpowanie przetargowe i nie wp³yne³a wymagana liczba wa¿nych ofert lub wszystkie oferty odrzucono, a mo¿',
   'na w sposób uzasadniony przypuszczaæ, ¿e powtórny przebieg przetargu nie doprowadzi do zawarcia umowy.');

  A68:Array[1..2] of String=
  ('ZAPYTANIE O CENÊ mo¿e byæ stosowane, gdy przedmiotem zamówienia s¹ dostawy rzeczy lub us³ugi powszechnie dostêpne o ',
   'ustalonych standardach jakoœciowych.');

  A71:Array[1..14] of String=
  ('Zamawiaj¹cy mo¿e udzieliæ ZAMÓWIENIA Z WOLNEJ RÊKI tylko wtedy, gdy zachodzi jedna z nastêpuj¹cych okolicznoœci:',
   '1) dokonuje zamówieñ dodatkowych, nie przekraczaj¹cych 20% wartoœci uprzedniego zamówienia, a zachodzi koniecznoœæ ',
   'zachowania tych samych norm, parametrów i standardów,',
   '2) zawiera umowê o przeprowadzenie badañ, eksperymentu lub sporz¹dzenie opinii naukowej,',
   '3) ze wzglêdu na szczególny rodzaj dostaw, us³ug lub robót budowlanych mo¿na je uzyskaæ tylko od jednego dostawcy lub ',
   'wykonawcy,',
   '4) dokonuje zamówienia publicznego na twórcze prace projektowe oraz na prace z zakresu dzia³alnoœci twórczej w ',
   'dziedzinie kultury i sztuki,',
   '5) mo¿na skorzystaæ tylko z jednego dostawcy lub wykonawcy w wyniku zastosowania dozwolonego zakresu preferencji ',
   'krajowych,',
   '6) ze wzglêdu na szczególne okolicznoœci gospodarcze lub spo³eczne, których zamawiaj¹cy nie móg³ przewidzieæ wymagane ',
   'jest natychmiastowe wykonanie zamówienia,',
   '7) wartoœæ zamówienia nie przekracza równowartoœci 3.000 ECU lub udzia³ œrodków publicznych w finansowaniu zamówienia ',
   'nie przekracza równowartoœci 3.000 ECU.');

  wt1_1='Czy istniej¹ warunki umo¿liwiaj¹ce przeprowadzenie';
  wt1_2='przetargu nieograniczonego ?';

  wt2_1='Organizujê';
  wt2_2='PRZETARG NIEOGRANICZONY';
  wt2_3='(art. 14, art.28 ust. 1 i 2)';

  wt3_1='Ze wzglêdu na specjalistyczny charakter zamówienia';
  wt3_2='istnieje ograniczona liczba oferentów ?';

  wt4_1='Organizujê';
  wt4_2='PRZETARG OGRANICZONY';
  wt4_3='(art. 32)';

  wt5_1='Dotycz¹ce tylko ';
  wt5_2='PRZEDMIOTU ZAMÓWIENIA ?';

  wt6_1='Niezbêdne s¹ negocjacje z oferentami ?';

  wt7_1='Organizujê';
  wt7_2='PRZETARG DWUSTOPNIOWY';
  wt7_3='(zachodzi jedna z okolicznoœci okreœlonych w art. 54)';

  wt8_1='Przeprowadzono przetarg i nie wp³ynê³a wymagana liczba';
  wt8_2='ofert lub wszystkie oferty odrzucono ?';

{  wt9_1='Dotycz¹ce ';
  wt9_2='PRZEDMIOTU ZAMÓWIENIA i';
  wt9_3='WARUNKÓW UMOWY ?';
  wt9_4='(zachodzi jedna z okolicznoœci okreœlonych w art. 54)';}

  wt10_1='Przeprowadzam postêpowanie w trybie';
  wt10_2='NEGOCJACJI Z ZACHOWANIEM KONKURENCJI';
  wt10_3='(zachodzi jedna z okolicznoœci okreœlonych w art. 64)';

  wt11_1='Zachodzi pilna potrzeba udzielenia zamówienia,';
  wt11_2='w sytuacji której nie mo¿na by³o wczeœniej przewidzieæ,';
  wt11_3='a która nie wynikne³a z winy zamawiaj¹cego ?';

  wt12_1='Przeprowadzam procedurê w trybie';
  wt12_2='ZAPYTANIA O CENÊ';
  wt12_3='(art. 68)';

  wt13_1='Przedmiotem zamówienia s¹ dostawy, rzeczy lub us³ugi';
  wt13_2='powszechnie dostêpne o ustalonych standardach jakoœciowych';
  wt13_3='i jedynym kryterium wyboru jest CENA ?';

  wt14_1='Dokonujê';
  wt14_2='ZAMÓWIENIA Z WOLNEJ RÊKI';

  wt15_1='Spe³nione s¹ okolicznoœci okreœlone w artykule 71 ?';

  wt16_1='Sprawdzam poprawnoœæ odpowiedzi';
  wt16_2='i powtarzam procedurê wyboru trybu.';

  acWarunki='Warunki';
  acArticle='Artyku³';

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
  L1='Wartoœæ zamówienia nie przekracza równowartoœci 3.000 ECU.';
  L2='Mo¿esz zastosowaæ tryb "ZAMÓWIENIE Z WOLNEJ RÊKI" ';
  L3='(art. 71 ust.1 pkt 7)';
  L4='Czy zastosowaæ taki tryb ?';
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
      MessageDlg('B³¹d '+E.ClassName+' w S2WYBTRB.DLL', mtWarning, [mbOk],0);
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
  L1='Kwota powy¿ej 200000 ECU.';
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
            Caption:='Artyku³y 14 i 28'
          end;
    4 : with ArticleDlg do
          begin
            Memo.Lines.Clear;
            Memo.Lines.Add(A32[1]);
            Memo.Lines.Add(A32[2]+A32[3]);
            Memo.Lines.Add(A32[4]);
            Caption:='Artyku³ 32'
          end;
    7 : with ArticleDlg do
          begin
            Memo.Lines.Clear;
            Memo.Lines.Add(A54[1]);
            Memo.Lines.Add(A54[2]+A54[3]);
            Memo.Lines.Add(A54[4]+A54[5]);
            Memo.Lines.Add(A54[6]+A54[7]);
            Memo.Lines.Add(A54[8]);
            Caption:='Artyku³ 54'
          end;
    10 : with ArticleDlg do
          begin
            Memo.Lines.Clear;
            Memo.Lines.Add(A64[1]);
            Memo.Lines.Add(A64[2]);
            Memo.Lines.Add(A64[3]+A64[4]);
            Memo.Lines.Add(A64[5]+A64[6]);
            Caption:='Artyku³ 64'
          end;
    12 : with ArticleDlg do
           begin
             Memo.Lines.Clear;
             Memo.Lines.Add(A68[1]);
             Memo.Lines.Add(A68[2]);
             Caption:='Artyku³ 68'
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
             Caption:='Artyku³ 71'
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
