unit Ofrtdta;

interface

uses
  SysUtils,
  Classes;

const
  OcenaFileHdr='OCOF';
  KrytListFile='CRITERIA.DTA';

  NameMaxLen=100;
  SurNameMaxLen=150;
  PwdMaxLen=20;

  MaxKriteria=100;
  MaxOffers=250;
  MaxMembers=100;

  KrLineLen=57;

  PrefKrajBonus=0.8;

  TitleMaxMin='Podaj wartoœæ podlegaj¹c¹ ocenie kryterium:';
  TitleYesNo='Czy oferta wype³nia wymogi oceniane kryterium:';
  TitleSubj1='Kryterium subiektywne';
  TitleSubj2='Iloœæ punktów przyznana ofercie w zakresie kryterium ';
  EvalModeStr='Sposób oceny kryterium: ';
  TenderS='Oferta nr ';

  OneWinnerText='Przetarg wygra³a oferta nr ';
  ManyWinnersText='Przetarg wygra³y oferty nr ';

  CenaStr='cena ofertowa';

  T1_1='Czy przy ocenie, oferta bêdzie oceniana tym lepiej (wiêksz¹ iloœci¹ punktów) im wy¿sza';
  T1_2='jest wartoœæ liczbowa wielkoœci podlegaj¹cej ocenie w zakresie tego kryterium ?';
  T1_3='np. kubatura, powierzchnia, obrót roczny, termin p³atnoœci, rentownoœæ';
  T2_1='Czy przy ocenie, oferta bêdzie oceniana tym lepiej (mniejsz¹ iloœci¹ punktów) im mniejsza';
  T2_2='jest wartoœæ liczbowa wielkoœci podlegaj¹cej ocenie w zakresie tego kryterium ?';
  T2_3='np. cena, termin realizacji, zu¿ycie paliwa, koszt eksploatacji, energoch³onnoœæ';
  T3_1='Czy w zakresie tego kryterium, oferta oceniana jest podobnie jak przy ocenie warunku tzn. TAK - NIE ?';
  T3_2='np. norma ISO 9002, udzielenie 5-cio letniej gwarancji';
  T4_1='Sposób oceny kryterium: ';
  T5_1Y='Postêpowanie jest prowadzone z zastosowaniem preferencji krajowych.';
  T5_1N='Postêpowanie jest prowadzone bez zastosowania preferencji krajowych.';
  T5_2='Czy zmieniæ ?';
  T6_1='Czy postêpowanie jest prowadzone z zastosowaniem preferencji krajowych ?';


{evaluation modes}
  evMax=1;
  evMin=2;
  evYesNo=3;
  evSubj=4;
  evMaxS='Maksymalizacja';
  evMinS='Minimalizacja';
  evYesNoS='Tak - Nie';
  evSubjS='Indywidualne';
  evArray:Array[evMax..evSubj] of String =
          (evMaxS,evMinS,evYesNoS,evSubjS);

type
  TPKriteriaItem=^TKriteriaItem;
  TKriteriaItem=Record
    KDesc:String;
    KWeight:Byte;
    KEvalMode:Byte;
  end;

  TPOfferItem=^TOfferItem;
  TOfferItem=Record
    MNum:Integer;
    KNum:Integer;
    ONum:Integer;
    Eval:Real;
    Pts:Real;
    Memo:PChar;
    PreKra:Boolean;
  end;

{  TPOfferTable=^TOfferTable;
  TOfferTable=Array[0..MaxKriteria-1,0..MaxMembers-1] of TPOfferItem;}

var
  ValueIndex:Integer; {index of list of the kriterum representing the value}
  MaxPoints:LongInt;
  TendersTot:LongInt;
  PrefKrajowe:Boolean;
  SuperPwd:String;
  MNames:TStringList;
  MSurnames:TStringList;
  MPwds:TStringList;
  KDescs:TStringList;
  KWeights:TStringList;
  KEvalModes:TStringList;
  Offers:TList;

function EMStrToByte(S:String):Byte;
function GetOfferItem(M,O,K:Integer):TOfferItem;
function MinValue(CurKrit:LongInt):Real;
function MaxValue(CurKrit:LongInt):Real;
procedure SetOfferItem(OI:TOfferItem; i:Integer);
procedure EvaluateKriterium(Krit:Integer);
{set offer by offr index}
implementation

function EMStrToByte(S:String):Byte;
begin
  if s=evMaxS
    then Result:=evMax
  else if s=evMinS
    then Result:=evMin
  else if s=evYesNoS
    then Result:=evYesNo
  else if s=evSubjS
    then Result:=evSubj
end;

function EmptyOfferItem:TOfferItem;
var
  OI:TOfferItem;
begin
  with OI do
    begin
      Pts:=0;
      Eval:=0;
      Memo:=Nil;
      MNum:=0;
      KNum:=0;
      ONum:=0;
      PreKra:=FALSE;
    end;
  Result:=OI;
end;

function GetOfferItem(M,O,K:Integer):TOfferItem;
var
  OI:TOfferItem;
  x:LongInt;
begin
  if Offers.Count>0
    then begin
      x:=0;
      repeat
        OI:=TOfferItem(Offers.Items[x]^);
        Inc(x);
      until ((OI.MNum=M) and (OI.KNum=K) and (OI.ONum=O)) or (x>=Offers.Count);
      if ((OI.MNum=M) and (OI.KNum=K) and (OI.ONum=O))
        then Result:=OI
        else Result:=EmptyOfferItem;
    end
    else Result:=EmptyOfferItem;
end;

procedure SetOfferItem(OI:TOfferItem; i:Integer);
var
  l:Integer;
begin
  TOfferItem(Offers.Items[i]^).MNum:=OI.MNum;
  TOfferItem(Offers.Items[i]^).KNum:=OI.KNum;
  TOfferItem(Offers.Items[i]^).ONum:=OI.ONum;
  TOfferItem(Offers.Items[i]^).Eval:=OI.Eval;
  TOfferItem(Offers.Items[i]^).Pts:=OI.Pts;
  l:=StrLen(OI.Memo)+1;
  if l>1
    then begin
      TOfferItem(Offers.Items[i]^).Memo:=StrAlloc(l);
      StrLCopy(TOfferItem(Offers.Items[i]^).Memo,OI.Memo,l);
    end;
  TOfferItem(Offers.Items[i]^).PreKra:=OI.PreKra;
end;

function GetOfferItemPtr(M,O,K:Integer):TPOfferItem;
var
  OI:TPOfferItem;
  x:LongInt;
begin
  if Offers.Count>0
    then begin
      x:=0;
      repeat
        OI:=Offers[x];
        Inc(x);
      until ((OI^.MNum=M) and (OI^.KNum=K) and (OI^.ONum=O)) or (x>=Offers.Count);
      if ((OI^.MNum=M) and (OI^.KNum=K) and (OI^.ONum=O))
        then Result:=OI
        else Result:=Nil;
    end
    else Result:=Nil;
end;

function MinValue(CurKrit:LongInt):Real;
var
  i,j:LongInt;
  x:Real;
  Tot:LongInt;
begin
  Result:=0;
  Tot:=MSurnames.Count*TendersTot;
  if Tot<=0
    then Exit;
  x:=32767;
  for i:=0 to MSurnames.Count-1 do
    for j:=0 to TendersTot-1 do
      if GetOfferItem(i,j,CurKrit).Pts<x
        then x:=GetOfferItem(i,j,CurKrit).Pts;
  Result:=x;
end;

function MaxValue(CurKrit:LongInt):Real;
var
  i,j:LongInt;
  x:Real;
  Tot:LongInt;
begin
  Result:=0;
  Tot:=MSurnames.Count*TendersTot;
  if Tot<=0
    then Exit;
  x:=0;
  for i:=0 to MSurnames.Count-1 do
    for j:=0 to TendersTot-1 do
      if GetOfferItem(i,j,CurKrit).Pts>x
        then x:=GetOfferItem(i,j,CurKrit).Pts;
  Result:=x;
end;

function MinCena(CurKrit:LongInt):Real;
var
  i,j:LongInt;
  x,y:Real;
  Tot:LongInt;
begin
  Result:=0;
  Tot:=MSurnames.Count*TendersTot;
  if Tot<=0
    then Exit;
  x:=999999999.99;
  for i:=0 to MSurnames.Count-1 do
    for j:=0 to TendersTot-1 do
      begin
        y:=GetOfferItem(i,j,CurKrit).Pts;
        if GetOfferItem(i,j,CurKrit).PreKra
          then y:=y*PrefKrajBonus;
        if y<x
          then x:=y;
      end;
  Result:=x;
end;

procedure EvaluateCena(Krit,OfferNum:Integer);
var
  Min:Real;
  x,y:Real;

begin
  Min:=MinCena(Krit);
  x:=Min * MaxPoints;
  y:=TOfferItem(Offers[OfferNum]^).Pts;
  if TOfferItem(Offers[OfferNum]^).PreKra
    then y:=y*PrefKrajBonus;
  if y>0
    then x:=x/y
    else x:=0;
  TOfferItem(Offers[OfferNum]^).Eval:=x{ * StrToInt(KWeights[Krit]) / 100};
end;

procedure EvaluateKriterium(Krit:Integer);
var
  Min,Max:Real;
  x:Double;
  EM:Byte;
  i:LongInt;
begin
  Min:=MinValue(Krit);
  Max:=MaxValue(Krit);
  EM:=EmStrToByte(KEvalModes[Krit]);
  for i:=0 to Offers.Count-1 do
    begin
      if TOfferItem(Offers[i]^).KNum=Krit
        then begin
          case EM of
            evMax:
              begin
                if Max>0
                  then x:=TOfferItem(Offers[i]^).Pts/Max
                  else x:=0;
                TOfferItem(Offers[i]^).Eval:=x * MaxPoints{ * StrToInt(KWeights[Krit]) / 100};
              end;
            evMin:
              begin
                if Krit=ValueIndex-1
                  then begin
                    EvaluateCena(Krit,i);
                  end
                  else begin
                    x:=Min * MaxPoints;
                    if TOfferItem(Offers[i]^).Pts>0
                      then x:=x/TOfferItem(Offers[i]^).Pts
                      else x:=0;
                    TOfferItem(Offers[i]^).Eval:=x{ * StrToInt(KWeights[Krit]) / 100};
                  end;
              end;
            evYesNo:
              begin
                TOfferItem(Offers[i]^).Eval:=TOfferItem(Offers[i]^).Pts{ * StrToInt(KWeights[Krit]) / 100};
              end;
            evSubj:
              begin
                TOfferItem(Offers[i]^).Eval:=TOfferItem(Offers[i]^).Pts{ * StrToInt(KWeights[Krit]) / 100};
              end;
          end;{case}
        end;
    end;
end;

end.
