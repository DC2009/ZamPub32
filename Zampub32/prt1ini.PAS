unit Prt1ini;

interface

uses
  WinProcs, Classes, Controls, Buttons,
  ExtCtrls, Dialogs, Messages, SysUtils,
  Graphics,
  StdCtrls,
  RPrev,
  SiwzIni,
  Prt1,
{$IFNDEF DEMO}
  Prt2,
  Prt3,
  Prt4,
  Prt5,
{$ENDIF}
  Utils;

procedure ResetPrt1Fields(ATender:TPrt1Dlg; ATenderType, AObjectKind, AAmount:Byte);
procedure ClearPrt1Fields(ATender:TPrt1Dlg);
procedure Prt1ValueKindInit(ATender:TPrt1Dlg; APhase:Byte; AObjectKind,ALevel:Byte);
{$IFNDEF DEMO}
procedure ResetPrt2Fields(ATender:TPrt2Dlg; APhase, ATenderType, AObjectKind, AAmount:Byte);
procedure ClearPrt2Fields(ATender:TPrt2Dlg);
procedure DwuValueKindInit(ATender:TPrt2Dlg; APhase:Byte; AObjectKind,ALevel:Byte);
procedure ClearPrt3Fields(Ver:Byte;ATender:TPrt3Dlg);
procedure ResetPrt4Fields(ATender:TPrt4Dlg; ATenderType, AObjectKind, AAmount:Byte);
procedure ClearPrt4Fields(ATender:TPrt4Dlg);
procedure ClearPrt5Fields(ATender:TPrt5Dlg);
{$ENDIF}
procedure AddMemo2Memo(Src:TMemo; var Dest:TMemo; NewLines:Byte);
procedure AddStr2Memo(Str:String; var Dest:TMemo; NewLines:Byte);
procedure AddBoldString(Ry:TRyPrinter; const Str:String; SpaceUnder:Byte;
                   PageSpace:Integer; var PPos:Integer);
procedure AddParag(Ry:TRyPrinter; const P:Array of PChar; const D:Array of Byte;
                   PageSpace:Integer; var PPos:Integer);

implementation

procedure InitNie(ATender:TPrt1Dlg; AObjectKind,AAmount:Byte);
begin
  with ATender do
    begin
      Caption:=sNieograniczonyTitle;
      ZamawEdit.Text:=ZamawEdit.Text+'przetargu nieograniczonym na ';
      with WarunkiEdit1 do
        case AObjectKind Of
          okDostawa: Text:=sWarunkiEdit1+sDostawcy+sWarunkiEdit2;
          okUslugi: Text:=sWarunkiEdit1+sWykonawcy+sWarunkiEdit2;
          okRobBud: Text:=sWarunkiEdit1+sWykonawcy+sWarunkiEdit2;
        end;{case}
      OfertaRadioGroup.ItemIndex:=0;
      with OfertaRadioGroup do  {initialize Oferta fields}
        begin
          case ObjectKind Of
            okDostawa: Items[1]:=sOfertaCzesc+sDostawy;
            okUslugi: Items[1]:=sOfertaCzesc+sUslugi;
            okRobBud: Items[1]:=sOfertaCzesc+sRobotyBud;
          end;{case}
          OfertaMemo.Enabled:=(ItemIndex=1);
          if OfertaMemo.Enabled
            then OfertaMemo.Color:=clAqua
            else OfertaMemo.Color:=clGray;
        end;
    end;
end;

procedure Prt1ValueKindInit(ATender:TPrt1Dlg; APhase:Byte; AObjectKind,ALevel:Byte);
begin
  with ATender do
    begin {Set the parts depending on the amount of money}
      if ALevel >=aLevel4   {>30000}
        then begin
          WadiumMemo3_1.Color:=clAqua;
          WadiumMemo3_1.ReadOnly:=TRUE;
          WadiumMemo7_1.Color:=clAqua;
          WadiumMemo7_1.ReadOnly:=TRUE;
          WadiumMemo8.Color:=clAqua;
          WadiumMemo8.ReadOnly:=TRUE;
        end
        else begin
          WadiumMemo3_1.Color:=clWhite;
          WadiumMemo3_1.ReadOnly:=FALSE;
          WadiumMemo7_1.Color:=clWhite;
          WadiumMemo7_1.ReadOnly:=FALSE;
          WadiumMemo8.Color:=clWhite;
          WadiumMemo8.ReadOnly:=FALSE;
        end;

      ProtMemo1.Enabled:=ALevel>=ALevel4; {<30000 no protesty}
      ProtMemo2.Enabled:=ALevel>=ALevel4;
      ProtMemo3.Enabled:=ALevel>=ALevel4;
      ProtMemo4.Enabled:=ALevel>=ALevel4;
      ProtMemo5.Enabled:=ALevel>=ALevel4;
      ProtMemo6.Enabled:=ALevel>=ALevel4;
      ProtMemo7.Enabled:=ALevel>=ALevel4;
      if ALevel<ALevel4
        then begin
          ProtMemo1.Color:=clGray;
          ProtMemo2.Color:=clGray;
          ProtMemo3.Color:=clGray;
          ProtMemo4.Color:=clGray;
          ProtMemo5.Color:=clGray;
          ProtMemo6.Color:=clGray;
          ProtMemo7.Color:=clGray;
        end
        else begin
          ProtMemo1.Color:=clWhite;
          ProtMemo2.Color:=clWhite;
          ProtMemo3.Color:=clWhite;
          ProtMemo4.Color:=clWhite;
          ProtMemo5.Color:=clWhite;
          ProtMemo6.Color:=clWhite;
          ProtMemo7.Color:=clWhite;
        end;

      if (AObjectKind=okRobBud) and (ALevel>=aLevel3){>20000}
        then begin
          ZabezRb1_3.Enabled:=FALSE;
          ZabezCB3_2.Enabled:=FALSE;
          ZabezCB3_3.Enabled:=FALSE;
          ZabezCB3_4.Enabled:=FALSE;
          ZabezMemo3_1.Clear;
          ZabezMemo3_1.Lines.Add('Zabezpieczenie mo¿e byæ w nastêpuj¹cej formie :');
          ZabezMemo3_1.Lines.Add('- w pieni¹dzu,');
          ZabezMemo3_1.Lines.Add('- w gwarancjach bankowych,');
          ZabezMemo3_1.Lines.Add('- zastawach na papierach wartoœciowych emitowanych lub gwarantowanych przez Skarb Pañstwa,');
          ZabezMemo3_1.Lines.Add('- wekslach w³asnych in blanco z porêczeniem wekslowym banku krajowego.');
        end
        else begin
          ZabezRb1_3.Enabled:=TRUE;
          ZabezCB3_2.Enabled:=TRUE;
          ZabezCB3_3.Enabled:=TRUE;
          ZabezCB3_4.Enabled:=TRUE;
          ZabezMemo3_1.Clear;
          ZabezMemo3_1.Lines.Add('Zabezpieczenie mo¿e byæ w nastêpuj¹cej formie :');
          ZabezMemo3_1.Lines.Add('- w pieni¹dzu,');
          ZabezMemo3_1.Lines.Add('- w obligacjach pañstwowych,');
          ZabezMemo3_1.Lines.Add('- w porêczeniach bankowych,');
          ZabezMemo3_1.Lines.Add('- w gwarancjach bankowych,');
          ZabezMemo3_1.Lines.Add('- w gwarancjach ubezpieczeniowych,');
          ZabezMemo3_1.Lines.Add('- zastawach na papierach wartoœciowych emitowanych lub gwarantowanych przez Skarb Pañstwa,');
        end;
    end;{with}
end;

procedure InitOgr(ATender:TPrt1Dlg; AObjectKind,AAmount:Byte);
begin
  with ATender do
    begin
      Caption:=sOgraniczonyTitle;
      ZamawEdit.Text:=ZamawEdit.Text+'przetargu ograniczonym na ';
      with WarunkiEdit1 do
        case AObjectKind Of
          okDostawa: Text:=sWarunkiEdit1+sDostawcy+sWarunkiEdit2;
          okUslugi: Text:=sWarunkiEdit1+sWykonawcy+sWarunkiEdit2;
          okRobBud: Text:=sWarunkiEdit1+sWykonawcy+sWarunkiEdit2;
        end;{case}
      OfertaRadioGroup.ItemIndex:=0;
      with OfertaRadioGroup do  {initialize Oferta fields}
        begin
          case ObjectKind Of
            okDostawa: Items[1]:=sOfertaCzesc+sDostawy;
            okUslugi: Items[1]:=sOfertaCzesc+sUslugi;
            okRobBud: Items[1]:=sOfertaCzesc+sRobotyBud;
          end;{case}
          OfertaMemo.Enabled:=(ItemIndex=1);
          if OfertaMemo.Enabled
            then OfertaMemo.Color:=clAqua
            else OfertaMemo.Color:=clGray;
        end;
    end;
end;

{$IFNDEF DEMO}
procedure InitNeg(ATender:TPrt4Dlg; AObjectKind,AAmount:Byte);
begin
  with ATender do
    begin
      Caption:=sNegocjacjeTitle;
      ZamawEdit.Text:=ZamawEdit.Text+'negocjacji z zachowaniem konkurencji na ';
      with WarunkiEdit1 do
        case AObjectKind Of
          okDostawa: Text:=sWarunkiEdit1+sDostawcy+sWarunkiEdit2;
          okUslugi: Text:=sWarunkiEdit1+sWykonawcy+sWarunkiEdit2;
          okRobBud: Text:=sWarunkiEdit1+sWykonawcy+sWarunkiEdit2;
        end;{case}
      OfertaRadioGroup.ItemIndex:=0;
      with OfertaRadioGroup do  {initialize Oferta fields}
        begin
          case ObjectKind Of
            okDostawa: Items[1]:=sOfertaCzesc+sDostawy;
            okUslugi: Items[1]:=sOfertaCzesc+sUslugi;
            okRobBud: Items[1]:=sOfertaCzesc+sRobotyBud;
          end;{case}
          OfertaMemo.Enabled:=(ItemIndex=1);
          if OfertaMemo.Enabled
            then OfertaMemo.Color:=clAqua
            else OfertaMemo.Color:=clGray;
        end;
    end;
end;

procedure InitDwu(ATender:TPrt2Dlg; APhase:Byte);
begin
  with ATender do
    begin
      Caption:=sDwustopniowyTitle;
      if OpenMode=oNew   { initialize new SIWZ kind fields }
        then begin
          SetPhase;
          with WarunkiEdit1 do
            case ObjectKind Of
              okDostawa: Text:=sWarunkiEdit1+sDostawcy+sWarunkiEdit2;
              okUslugi: Text:=sWarunkiEdit1+sWykonawcy+sWarunkiEdit2;
              okRobBud: Text:=sWarunkiEdit1+sWykonawcy+sWarunkiEdit2;
            end;{case}
          OfertaRadioGroup.ItemIndex:=0;
        end;
      with OfertaRadioGroup do  {initialize Oferta fields}
        begin
          case ObjectKind Of
            okDostawa: Items[1]:=sOfertaCzesc+sDostawy;
            okUslugi: Items[1]:=sOfertaCzesc+sUslugi;
            okRobBud: Items[1]:=sOfertaCzesc+sRobotyBud;
          end;{case}
          OfertaMemo.Enabled:=(ItemIndex=1);
          if OfertaMemo.Enabled
            then OfertaMemo.Color:=clAqua
            else OfertaMemo.Color:=clGray;
        end;
    end;
end;

procedure DwuValueKindInit(ATender:TPrt2Dlg; APhase:Byte; AObjectKind,ALevel:Byte);
begin
{Set the parts depending on the amount of money}
  with ATender do
    begin
      ProtMemo1.Enabled:=ALevel>=ALevel4; {<30000 no protesty}
      ProtMemo2.Enabled:=ALevel>=ALevel4;
      ProtMemo3.Enabled:=ALevel>=ALevel4;
      ProtMemo4.Enabled:=ALevel>=ALevel4;
      ProtMemo5.Enabled:=ALevel>=ALevel4;
      ProtMemo6.Enabled:=ALevel>=ALevel4;
      ProtMemo7.Enabled:=ALevel>=ALevel4;
      if ALevel<ALevel4
        then begin
          ProtMemo1.Color:=clGray;
          ProtMemo2.Color:=clGray;
          ProtMemo3.Color:=clGray;
          ProtMemo4.Color:=clGray;
          ProtMemo5.Color:=clGray;
          ProtMemo6.Color:=clGray;
          ProtMemo7.Color:=clGray;
        end
        else begin
          ProtMemo1.Color:=clWhite;
          ProtMemo2.Color:=clWhite;
          ProtMemo3.Color:=clWhite;
          ProtMemo4.Color:=clWhite;
          ProtMemo5.Color:=clWhite;
          ProtMemo6.Color:=clWhite;
          ProtMemo7.Color:=clWhite;
        end;

      if (AObjectKind=okRobBud) and (ALevel>=aLevel3){>20000}
        then begin
          ZabezRb1_3.Enabled:=FALSE;
          ZabezCB3_2.Enabled:=FALSE;
          ZabezCB3_3.Enabled:=FALSE;
          ZabezCB3_4.Enabled:=FALSE;
          ZabezMemo3_1.Clear;
          ZabezMemo3_1.Lines.Add('Zabezpieczenie mo¿e byæ w nastêpuj¹cej formie :');
          ZabezMemo3_1.Lines.Add('- w pieni¹dzu,');
          ZabezMemo3_1.Lines.Add('- w gwarancjach bankowych,');
          ZabezMemo3_1.Lines.Add('- zastawach na papierach wartoœciowych emitowanych lub gwarantowanych przez Skarb Pañstwa,');
          ZabezMemo3_1.Lines.Add('- wekslach w³asnych in blanco z porêczeniem wekslowym banku krajowego.');
        end
        else begin
          ZabezRb1_3.Enabled:=TRUE;
          ZabezCB3_2.Enabled:=TRUE;
          ZabezCB3_3.Enabled:=TRUE;
          ZabezCB3_4.Enabled:=TRUE;
          ZabezMemo3_1.Clear;
          ZabezMemo3_1.Lines.Add('Zabezpieczenie mo¿e byæ w nastêpuj¹cej formie :');
          ZabezMemo3_1.Lines.Add('- w pieni¹dzu,');
          ZabezMemo3_1.Lines.Add('- w obligacjach pañstwowych,');
          ZabezMemo3_1.Lines.Add('- w porêczeniach bankowych,');
          ZabezMemo3_1.Lines.Add('- w gwarancjach bankowych,');
          ZabezMemo3_1.Lines.Add('- w gwarancjach ubezpieczeniowych,');
          ZabezMemo3_1.Lines.Add('- zastawach na papierach wartoœciowych emitowanych lub gwarantowanych przez Skarb Pañstwa,');
        end;
    end;{with}
end;
{$ENDIF}

procedure ResetPrt1Fields(ATender:TPrt1Dlg; ATenderType, AObjectKind, AAmount:Byte);
begin
  with ATender do
    begin
      TerminRB1.Checked:=TRUE;
      TerminRB1_1.Checked:=TRUE;
      TerminRB2.Checked:=FALSE;
      TerminRB2_1.Checked:=TRUE;
      TerminActivate(1);
      NipMaskEdit2.Enabled:=FALSE;
      NipRB1.Checked:=TRUE;
      NipRB2.Checked:=FALSE;
      InfoCB7.Checked:=TRUE;
      WadiumRB1_2.Checked:=TRUE;
      ZabezRB1_2.Checked:=TRUE;
      OcenaCB1.Checked:=FALSE;
      OcenaCB2.Checked:=FALSE;
      OcenaCB3.Checked:=FALSE;
      OcenaCB4.Checked:=FALSE;
      OcenaMemo3_5.Enabled:=FALSE;
      OcenaMemo3_6.Enabled:=FALSE;
      OcenaMemo3_7.Enabled:=FALSE;
      OcenaMemo3_8.Enabled:=FALSE;
      OcenaMemo3_5.Color:=clGray;
      OcenaMemo3_6.Color:=clGray;
      OcenaMemo3_7.Color:=clGray;
      OcenaMemo3_8.Color:=clGray;
      case ATenderType of
        ttNie:InitNie(ATender,AObjectKind, AAmount);
        ttOgr:InitOgr(ATender,AObjectKind, AAmount);
      end;{case}
    end;
end;

{$IFNDEF DEMO}
procedure ResetPrt2Fields(ATender:TPrt2Dlg; APhase, ATenderType, AObjectKind, AAmount:Byte);
begin
  with ATender do
    begin
      TerminRB1.Checked:=TRUE;
      TerminRB1_1.Checked:=TRUE;
      TerminRB2.Checked:=FALSE;
      TerminRB2_1.Checked:=TRUE;
      TerminActivate(1);
      NipMaskEdit2.Enabled:=FALSE;
      NipRB1.Checked:=TRUE;
      NipRB2.Checked:=FALSE;
      WadiumRB1_2.Checked:=TRUE;
      ZabezRB1_2.Checked:=TRUE;
      OcenaCB1.Checked:=FALSE;
      OcenaCB2.Checked:=FALSE;
      OcenaCB3.Checked:=FALSE;
      OcenaCB4.Checked:=FALSE;
      OcenaMemo3_5.Enabled:=FALSE;
      OcenaMemo3_6.Enabled:=FALSE;
      OcenaMemo3_7.Enabled:=FALSE;
      OcenaMemo3_8.Enabled:=FALSE;
      OcenaMemo3_5.Color:=clGray;
      OcenaMemo3_6.Color:=clGray;
      OcenaMemo3_7.Color:=clGray;
      OcenaMemo3_8.Color:=clGray;
      case ATenderType of
        ttDwu:InitDwu(ATender,APhase);
      end;{case}
    end;
end;

procedure ResetPrt4Fields(ATender:TPrt4Dlg; ATenderType, AObjectKind, AAmount:Byte);
begin
  with ATender do
    begin
      TerminRB1.Checked:=TRUE;
      TerminRB1_1.Checked:=TRUE;
      TerminRB2.Checked:=FALSE;
      TerminRB2_1.Checked:=TRUE;
      TerminActivate(1);
      NipMaskEdit2.Enabled:=FALSE;
      NipRB1.Checked:=TRUE;
      NipRB2.Checked:=FALSE;
      InfoCB7.Checked:=TRUE;
      WadiumRB1_2.Checked:=TRUE;
      ZabezRB1_2.Checked:=TRUE;
      OcenaCB1.Checked:=FALSE;
      OcenaCB2.Checked:=FALSE;
      OcenaCB3.Checked:=FALSE;
      OcenaCB4.Checked:=FALSE;
      OcenaMemo3_5.Enabled:=FALSE;
      OcenaMemo3_6.Enabled:=FALSE;
      OcenaMemo3_7.Enabled:=FALSE;
      OcenaMemo3_8.Enabled:=FALSE;
      OcenaMemo3_5.Color:=clGray;
      OcenaMemo3_6.Color:=clGray;
      OcenaMemo3_7.Color:=clGray;
      OcenaMemo3_8.Color:=clGray;
      InitNeg(ATender,AObjectKind, AAmount);
    end;
end;
{$ENDIF}

procedure ClearPrt1Fields(ATender:TPrt1Dlg);
begin
  with ATender do
    begin
    { Zamaw. }
      NameMemo.Clear;
      StreetEdit.Clear;
      TownEdit.Clear;
      BldgEdit.Clear;
      RoomEdit.Clear;
      ZipMaskEdit.Clear;
      TelEdit.Clear;
      FaxEdit.Clear;
      RegonMaskEdit.Clear;
      NipMaskEdit1.Clear;
      NipMaskEdit2.Clear;
      ZwanyEdit.Clear;
      ZamawEdit.Clear;
      ObjectMemo.Clear;
      AnnexMemo.Clear;
    {Termin}
      EndDate.Clear;
      TerminEdit.Clear;
      TimeUnitCB.Clear;
      CB2_5.Clear;
    {Warunki}
      WarunkiEdit1.Clear;
      WarunkiMemo1.Clear;
      WarunkiMemo2.Clear;
    {Rodzaj}
      OfertaMemo.Clear;
    {Info}
      InfoMemo1.Clear;
      InfoMemo2.Clear;
      InfoMemo3.Clear;
      InfoMemo4.Clear;
      InfoMemo5.Clear;
      InfoMemo6.Clear;
      InfoMemo8.Clear;
      InfoMemo9.Clear;
      InfoMemo10_1.Clear;
      InfoMemo10_2.Clear;
    {Wadium}
      WadiumEdit2_1.Clear;
      WadiumEdit2_2.Clear;
      WadiumEdit2_3.Clear;
      WadiumEdit2_4.Clear;
      WadiumEdit2_5.Clear;
      WadiumEdit2_6.Clear;
      WadiumMemo3_1.Clear;
      WadiumEdit4_1.Clear;
      WadiumMemo4_2.Clear;
      WadiumMemo5.Clear;
      WadiumMemo6.Clear;
      WadiumMemo7_1.Clear;
      WadiumMemo7_2.Clear;
      WadiumMemo8.Clear;
    {Zabez}
      ZabezMemo2_1.Clear;
      ZabezMemo3_1.Clear;
    {Zwiaz}
      ZwiazEdit1.Clear;
      ZwiazEdit2.Clear;
      ZwiazEdit3.Clear;
    {Skladanie}
      SkladEdit2_1.Clear;
      SkladMemo2_3.Clear;
      SkladEdit2_6.Clear;
      SkladMaskEdit2_7.Clear;
      SkladEdit2_11.Clear;
      SkladEdit2_12.Clear;
      SkladEdit2_13.Clear;
      SkladEdit2_14.Clear;
      SkladDate2_15.Clear;
      SkladEdit2_16.Clear;
      SkladTime2_17.Clear;
      SkladMemo3.Clear;
      SkladMemo4.Clear;
      SkladMemo5.Clear;
      SkladMemo6.Clear;
    {Wycof}
      WycofMemo1.Clear;
      WycofMemo2.Clear;
      WycofMemo3.Clear;
      WycofMemo4.Clear;
      WycofMemo5.Clear;
    {Otwarcie}
      OpeningEdit1_1.Clear;
      OpeningDate1_2.Clear;
      OpeningEdit1_2.Clear;
      OpeningTime1_4.Clear ;
      OpeningEdit1_3.Clear;
      OpeningEdit1_4.Clear;
      OpeningEdit1_5.Clear;
      OpeningEdit1_6.Clear;
      OpeningMemo2.Clear;
      OpeningMemo3.Clear;
      OpeningMemo4.Clear;
      OpeningMemo5.Clear;
    {Zawartosc}
      ContentMemo1.Clear;
      ContentMemo2.Clear;
      ContentMemo3.Clear;
      ContentMemo4.Clear;
      ContentMemo5.Clear;
      ContentMemo6.Clear;
    {Ocena}
      OcenaEdit1.Clear;
{      OcenaSG1.Clear;}
      OcenaMemo2.Clear;
      OcenaMemo3_1.Clear;
      OcenaEdit3_2.Clear;
      OcenaSE2.Clear;
      OcenaEdit3_3.Clear;
      OcenaMemo3_4.Clear;
      OcenaMemo3_5.Clear;
      OcenaMemo3_6.Clear;
      OcenaMemo3_7.Clear;
      OcenaMemo3_8.Clear;
      OcenaMemo5.Clear;
      OcenaMemo6.Clear;
      OcenaMemo7.Clear;
      OcenaMemo8.Clear;
      OcenaMemo9.Clear;
    {Wybor}
      WyborMemo1.Clear;
      WyborMemo2.Clear;
    {Uniewaz}
      UniewazMemo1.Clear;
    {Protesty}
      ProtMemo1.Clear;
      ProtMemo2.Clear;
      ProtMemo3.Clear;
      ProtMemo4.Clear;
      ProtMemo5.Clear;
      ProtMemo6.Clear;
      ProtMemo7.Clear;
    end;
end;

{$IFNDEF DEMO}
procedure ClearPrt2Fields(ATender:TPrt2Dlg);
begin
  with ATender do
    begin
    { Zamaw. }
      NameMemo.Clear;
      StreetEdit.Clear;
      TownEdit.Clear;
      BldgEdit.Clear;
      RoomEdit.Clear;
      ZipMaskEdit.Clear;
      TelEdit.Clear;
      FaxEdit.Clear;
      RegonMaskEdit.Clear;
      NipMaskEdit1.Clear;
      NipMaskEdit2.Clear;
      ZwanyEdit.Clear;
      ZamawEdit.Clear;
      ObjectMemo.Clear;
      AnnexMemo.Clear;
    {Termin}
      EndDate.Clear;
      TerminEdit.Clear;
      TimeUnitCB.Clear;
      CB2_5.Clear;
    {Warunki}
      WarunkiEdit1.Clear;
      WarunkiMemo1.Clear;
      WarunkiMemo2.Clear;
    {Rodzaj}
      OfertaMemo.Clear;
    {Info}
      InfoMemo1.Clear;
      InfoMemo2.Clear;
      InfoMemo3.Clear;
      InfoMemo4.Clear;
      InfoMemo5.Clear;
      InfoMemo6.Clear;
      InfoMemo8.Clear;
      InfoMemo9.Clear;
      InfoMemo10_1.Clear;
      InfoMemo10_2.Clear;
    {Wadium}
      WadiumEdit2_1.Clear;
      WadiumEdit2_2.Clear;
      WadiumEdit2_3.Clear;
      WadiumEdit2_4.Clear;
      WadiumEdit2_5.Clear;
      WadiumEdit2_6.Clear;
      WadiumMemo3_1.Clear;
      WadiumEdit4_1.Clear;
      WadiumMemo4_2.Clear;
      WadiumMemo5.Clear;
      WadiumMemo6.Clear;
      WadiumMemo7_1.Clear;
      WadiumMemo7_2.Clear;
      WadiumMemo8.Clear;
    {Zabez}
      ZabezMemo2_1.Clear;
      ZabezMemo3_1.Clear;
      ZabezMemo4.Clear;
    {Zwiaz}
      ZwiazEdit1.Clear;
      ZwiazEdit2.Clear;
      ZwiazEdit3.Clear;
    {Skladanie}
      SkladEdit2_1.Clear;
      SkladMemo2_3.Clear;
      SkladEdit2_6.Clear;
      SkladMaskEdit2_7.Clear;
      SkladEdit2_11.Clear;
      SkladEdit2_12.Clear;
      SkladEdit2_13.Clear;
      SkladEdit2_14.Clear;
      SkladDate2_15.Clear;
      SkladEdit2_16.Clear;
      SkladTime2_17.Clear;
      SkladMemo3.Clear;
      SkladMemo4.Clear;
      SkladMemo5.Clear;
      SkladMemo6.Clear;
    {Wycof}
      WycofMemo1.Clear;
      WycofMemo2.Clear;
      WycofMemo3.Clear;
      WycofMemo4.Clear;
      WycofMemo5.Clear;
    {Otwarcie}
      OpeningEdit1_1.Clear;
      OpeningDate1_2.Clear;
      OpeningEdit1_2.Clear;
      OpeningTime1_4.Clear ;
      OpeningEdit1_3.Clear;
      OpeningEdit1_4.Clear;
      OpeningEdit1_5.Clear;
      OpeningEdit1_6.Clear;
      OpeningMemo2.Clear;
      OpeningMemo3.Clear;
      OpeningMemo4.Clear;
      OpeningMemo5.Clear;
    {Zawartosc}
      ContentMemo1.Clear;
      ContentMemo2.Clear;
      ContentMemo3.Clear;
      ContentMemo4.Clear;
      ContentMemo5.Clear;
      ContentMemo6.Clear;
    {Negoc}
      NegocMemo1.Clear;
      NegocMemo2.Clear;
      NegocMemo3.Clear;
    {Ocena}
      OcenaEdit1.Clear;
      OcenaMemo2.Clear;
      OcenaMemo3_1.Clear;
      OcenaEdit3_2.Clear;
      OcenaSE2.Clear;
      OcenaEdit3_3.Clear;
      OcenaMemo3_4.Clear;
      OcenaMemo3_5.Clear;
      OcenaMemo3_6.Clear;
      OcenaMemo3_7.Clear;
      OcenaMemo3_8.Clear;
      OcenaMemo5.Clear;
      OcenaMemo6.Clear;
      OcenaMemo7.Clear;
      OcenaMemo8.Clear;
      OcenaMemo9.Clear;
    {Wybor}
      WyborMemo1.Clear;
      WyborMemo2.Clear;
    {Uniewaz}
      UniewazMemo1.Clear;
    {Protesty}
      ProtMemo1.Clear;
      ProtMemo2.Clear;
      ProtMemo3.Clear;
      ProtMemo4.Clear;
      ProtMemo5.Clear;
      ProtMemo6.Clear;
      ProtMemo7.Clear;
    end;
end;

procedure ClearPrt3Fields(Ver:Byte;ATender:TPrt3Dlg);
begin
  with ATender do
    begin
    { Zamaw. }
      NameMemo.Clear;
      StreetEdit.Clear;
      TownEdit.Clear;
      BldgEdit.Clear;
      RoomEdit.Clear;
      ZipMaskEdit.Clear;
      TelEdit.Clear;
      FaxEdit.Clear;
      RegonMaskEdit.Clear;
      NipMaskEdit1.Clear;
      NipMaskEdit2.Clear;
      ProwadMemo.Clear;
    {Termin}
      EndDate.Clear;
      TerminEdit.Clear;
      TimeUnitCB.Clear;
      CB2_5.Clear;
    {Przedmiot}
      ObjectMemo.Clear;
      if Ver>30
        then begin
    {Rodzaj}
          OfertaMemo.Clear;
    {Zawartosc}
          ContentMemo1.Clear;
          ContentMemo2.Clear;
          ContentMemo3.Clear;
          ContentMemo4.Clear;
          ContentMemo5.Clear;
          ContentMemo6.Clear;
        {Zabez}
          ZabezMemo2_1.Clear;
          ZabezMemo3_1.Clear;
        end;
    {Oferent}
      OferentMemo.Clear;
      ChoiceMemo.Clear;
    end;
end;

procedure ClearPrt4Fields(ATender:TPrt4Dlg);
begin
  with ATender do
    begin
    { Zamaw. }
      NameMemo.Clear;
      StreetEdit.Clear;
      TownEdit.Clear;
      BldgEdit.Clear;
      RoomEdit.Clear;
      ZipMaskEdit.Clear;
      TelEdit.Clear;
      FaxEdit.Clear;
      RegonMaskEdit.Clear;
      NipMaskEdit1.Clear;
      NipMaskEdit2.Clear;
      ZwanyEdit.Clear;
      ZamawEdit.Clear;
      ObjectMemo.Clear;
      AnnexMemo.Clear;
    {Termin}
      EndDate.Clear;
      TerminEdit.Clear;
      TimeUnitCB.Clear;
      CB2_5.Clear;
    {Warunki}
      WarunkiEdit1.Clear;
      WarunkiMemo1.Clear;
      WarunkiMemo2.Clear;
    {Rodzaj}
      OfertaMemo.Clear;
    {Info}
      InfoMemo1.Clear;
      InfoMemo2.Clear;
      InfoMemo3.Clear;
      InfoMemo4.Clear;
      InfoMemo5.Clear;
      InfoMemo6.Clear;
      InfoMemo8.Clear;
      InfoMemo9.Clear;
      InfoMemo10_1.Clear;
      InfoMemo10_2.Clear;
    {Wadium}
      WadiumEdit2_1.Clear;
      WadiumEdit2_2.Clear;
      WadiumEdit2_3.Clear;
      WadiumEdit2_4.Clear;
      WadiumEdit2_5.Clear;
      WadiumEdit2_6.Clear;
      WadiumMemo3_1.Clear;
      WadiumEdit4_1.Clear;
      WadiumMemo4_2.Clear;
      WadiumMemo5.Clear;
      WadiumMemo6.Clear;
      WadiumMemo7_1.Clear;
      WadiumMemo7_2.Clear;
      WadiumMemo8.Clear;
    {Zabez}
      ZabezMemo2_1.Clear;
      ZabezMemo3_1.Clear;
    {Zwiaz}
      ZwiazEdit1.Clear;
      ZwiazEdit2.Clear;
      ZwiazEdit3.Clear;
    {Skladanie}
      SkladEdit2_1.Clear;
      SkladMemo2_3.Clear;
      SkladEdit2_6.Clear;
      SkladMaskEdit2_7.Clear;
      SkladEdit2_11.Clear;
      SkladEdit2_12.Clear;
      SkladEdit2_13.Clear;
      SkladEdit2_14.Clear;
      SkladDate2_15.Clear;
      SkladEdit2_16.Clear;
      SkladTime2_17.Clear;
      SkladMemo3.Clear;
      SkladMemo4.Clear;
      SkladMemo5.Clear;
      SkladMemo6.Clear;
    {Wycof}
      WycofMemo1.Clear;
      WycofMemo2.Clear;
      WycofMemo3.Clear;
      WycofMemo4.Clear;
      WycofMemo5.Clear;
    {Otwarcie}
      OpeningEdit1_1.Clear;
      OpeningDate1_2.Clear;
      OpeningEdit1_2.Clear;
      OpeningTime1_4.Clear ;
      OpeningEdit1_3.Clear;
      OpeningEdit1_4.Clear;
      OpeningEdit1_5.Clear;
      OpeningEdit1_6.Clear;
      OpeningMemo2.Clear;
      OpeningMemo3.Clear;
      OpeningMemo4.Clear;
      OpeningMemo5.Clear;
    {Zawartosc}
      ContentMemo1.Clear;
      ContentMemo2.Clear;
      ContentMemo3.Clear;
      ContentMemo4.Clear;
      ContentMemo5.Clear;
      ContentMemo6.Clear;
    {Ocena}
      OcenaEdit1.Clear;
{      OcenaSG1.Clear;}
      OcenaMemo2.Clear;
      OcenaMemo3_1.Clear;
      OcenaEdit3_2.Clear;
      OcenaSE2.Clear;
      OcenaEdit3_3.Clear;
      OcenaMemo3_4.Clear;
      OcenaMemo3_5.Clear;
      OcenaMemo3_6.Clear;
      OcenaMemo3_7.Clear;
      OcenaMemo3_8.Clear;
      OcenaMemo5.Clear;
      OcenaMemo6.Clear;
      OcenaMemo7.Clear;
      OcenaMemo8.Clear;
      OcenaMemo9.Clear;
    {Wybor}
      WyborMemo1.Clear;
      WyborMemo2.Clear;
    {Uniewaz}
      UniewazMemo1.Clear;
    {Protesty}
      ProtMemo1.Clear;
      ProtMemo2.Clear;
      ProtMemo3.Clear;
      ProtMemo4.Clear;
      ProtMemo5.Clear;
      ProtMemo6.Clear;
      ProtMemo7.Clear;
    end;
end;

procedure ClearPrt5Fields(ATender:TPrt5Dlg);
begin
  with ATender do
    begin
    { Zamaw. }
      NameMemo.Clear;
      StreetEdit.Clear;
      TownEdit.Clear;
      BldgEdit.Clear;
      RoomEdit.Clear;
      ZipMaskEdit.Clear;
      TelEdit.Clear;
      FaxEdit.Clear;
      RegonMaskEdit.Clear;
      NipMaskEdit1.Clear;
      NipMaskEdit2.Clear;
      ProwadMemo.Clear;
      Art71Memo1.Clear;
      Art71Memo2.Clear;
    {Termin}
      BeginDate.Clear;
      EndDate.Clear;
    {Przedmiot}
      ObjectMemo.Clear;
      ObjectMemo2.Clear;
    {Oferent}
      OferentMemo1.Clear;
      OferentMemo2.Clear;
    end;
end;
{$ENDIF}

procedure AddMemo2Memo(Src:TMemo; var Dest:TMemo; NewLines:Byte);
var
  i:Longint;
begin
  if Src.Lines.Count<=0
    then Exit;
  for i:=0 to Src.Lines.Count do
    Dest.Lines.Add(Src.Lines[i]);
  for i:=1 to NewLines do
    Dest.Lines.Add('');
end;

procedure AddStr2Memo(Str:String; var Dest:TMemo; NewLines:Byte);
var
  i:Byte;
begin
  if Str=''
    then Exit;
  Dest.Lines.Add(Str);
  for i:=1 to NewLines do
    Dest.Lines.Add('');
end;

procedure MakeNewPage(Ry:TRyPrinter; var PPos:Integer);
begin
  with Ry do
    begin
      NewPage;
    end;
end;

procedure AddParag(Ry:TRyPrinter; const P:Array of PChar; const D:Array of Byte;
                   PageSpace:Integer; var PPos:Integer);
var
  LP:Integer; {Line position}
  X:Integer;
  q,r:PChar;
  i:Integer;
begin
  with Ry do
    begin
      LP:=PPos;
      if LP>PageSpace
        then LP:=PageSpace;
      i:=0;
      while (i<=High(P)) do
        begin
          q:=P[i];
          while (q<>Nil) and (q[0]<>#0) do
            begin
              Font.Name:='Arial CE';
              Font.Size:=10;
              Font.Style:=[];
              X:=PCharOut(Rect(XLOff,LP,XROff-Xmm(3),PageSpace-LP-Ymm(D[i])), q, False, False, TRUE,q);
              if LP+X+Ymm(D[i])>PageSpace
                then begin
                  NewPage;
                  LP:=YTOff+Ymm(1);
                end
                else LP:=LP+X+Ymm(D[i]);
            end;
          Inc(i);
        end;
      PPos:=LP+Ymm(1);
    end;
end;

procedure AddBoldString(Ry:TRyPrinter; const Str:String; SpaceUnder:Byte;
                   PageSpace:Integer; var PPos:Integer);
var
  LP:Integer; {Line position}
  X:Integer;
  p:PChar;
  Style:TFontStyles;
begin
  with Ry do
    begin
      Font.Name:='Arial CE';
      Font.Size:=10;
      LP:=PPos;
      if LP>PageSpace
        then LP:=PageSpace;
      p:=StrAlloc(Length(Str)+1);
      StrPCopy(p,Str);
      Style:=Font.Style;
      Font.Style:=[fsBold];
      X:=PCharOut(Rect(XLOff,LP,XROff-Xmm(3),PageSpace-LP-Ymm(SpaceUnder)), p, False, False, TRUE,p);
      if LP+X+Ymm(SpaceUnder)>PageSpace
        then begin
          NewPage;
          LP:=YTOff+Ymm(1);
        end
        else LP:=LP+X+Ymm(SpaceUnder);
      Font.Style:=Style;
      PPos:=LP;
    end;
end;

end.

