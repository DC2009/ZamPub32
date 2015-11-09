unit Prtrecio;
{$F+}
interface

uses
  Classes,
  Controls,
  Grids,
  SysUtils,
  StdCtrls,
  Dialogs,
  Utils,
  SiwzIni;

type

TPrtRec=Record
            Amount:Real;
            OKind:Integer;
            Phase:Byte;
            PrefKrajowe:Boolean;
            FilePwd:String;
{Zamaw.}
            NameMemo:PChar;
            StreetEdit:String;
            TownEdit:String;
            BldgEdit:String;
            RoomEdit:String;
            ZipMaskEdit:String;
            TelEdit:String;
            FaxEdit:String;
            TelexEdit:String;
            RegonMaskEdit:String;
            NipRB1:Boolean;
            NipRB2:Boolean;
            NipMaskEdit1:String;
            NipMaskEdit2:String;
            ZwanyEdit:String;
            ZamawEdit:String;
            ObjectMemo:PChar;
            AnnexMemo:PChar;
            ProwadMemo:PChar;
            Art71Memo1:PChar;
            Art71Memo2:PChar;
            ObjectMemo2:PChar;
            OferentMemo1:PChar;
            OferentMemo2:PChar;
            OferentMemo:PChar;
            ChoiceMemo:PChar;
{Termin}
            TerminRB1:Boolean;
            TerminRB2:Boolean;
            TerminRB1_1:Boolean;
            TerminRB1_2:Boolean;
            TerminRB2_1:Boolean;
            TerminRB2_2:Boolean;
            BeginDate:TDateTime;
            EndDate:TDateTime;
            TerminEdit:Integer;
            TimeUnitCB:String;
            CB2_5:String;
{Warunki}
            WarunkiEdit1:String;
            WarunkiMemo1:PChar;
            WarunkiMemo2:PChar;
{Rodzaj}
            OfertaRadioGroupItemIndex:Integer;
            OfertaMemo:PChar;
{Info}
            InfoMemo1:PChar;
            InfoMemo2:PChar;
            InfoMemo3:PChar;
            InfoMemo4:PChar;
            InfoMemo5:PChar;
            InfoMemo6:PChar;
            InfoCB7:Boolean;
            InfoMemo7:PChar;
            InfoMemo8:PChar;
            InfoMemo9:PChar;
            InfoMemo10_1:PChar;
            InfoMemo10_2:PChar;
            InfoMemo11:PChar;
{Wadium}
            WadiumRB1_2:Boolean;
            WadiumEdit2_1:String;
            WadiumEdit2_2:Real;
            WadiumEdit2_3:String;
            WadiumEdit2_4:String;
            WadiumEdit2_5:String;
            WadiumEdit2_6:String;
            WadiumMemo3_1:PChar;
            WadiumCB3_2:Boolean;
            WadiumCB3_3:Boolean;
            WadiumEdit4_1:String;
            WadiumMemo4_2:PChar;
            WadiumMemo5:PChar;
            WadiumMemo6:PChar;
            WadiumMemo7_1:PChar;
            WadiumMemo7_2:PChar;
            WadiumMemo8:PChar;
{Zabez}
            ZabezRB1_2:Boolean;
            ZabezMemo2_1:PChar;
            ZabezCB2_2:String;
            ZabezMemo3_1:PChar;
            ZabezCB3_2:Boolean;
            ZabezCB3_3:Boolean;
            ZabezCB3_4:Boolean;
            ZabezMemo4:PChar;
{Zwiaz}
            ZwiazEdit1:String;
            ZwiazEdit2:Integer;
            ZwiazEdit3:String;
{Sklad}
            SkladMemo1:PChar;
            SkladEdit2_1:String;
            SkladMemo2_3:PChar;
            SkladEdit2_6:String;
            SkladMaskEdit2_7:String;
            SkladEdit2_11:String;
            SkladEdit2_12:String;
            SkladEdit2_13:String;
            SkladEdit2_14:String;
            SkladDateEdit2_15:TDateTime;
            SkladEdit2_16:String;
            SkladTime2_17:TDateTime;
            SkladMemo3:PChar;
            SkladMemo4:PChar;
            SkladMemo5:PChar;
            SkladMemo6:PChar;
{Wycof}
            WycofMemo1:PChar;
            WycofMemo2:PChar;
            WycofMemo3:PChar;
            WycofMemo4:PChar;
            WycofMemo5:PChar;
{Otwarcie}
            OpeningEdit1_1:String;
            OpeningDateEdit1_2:TDateTime;
            OpeningEdit1_2:String;
            OpeningTime1_4:TDateTime;
            OpeningEdit1_3:String;
            OpeningEdit1_4:String;
            OpeningEdit1_5:String;
            OpeningEdit1_6:String;
            OpeningMemo2:PChar;
            OpeningMemo3:PChar;
            OpeningMemo4:PChar;
            OpeningMemo5:PChar;
{Zawartosc}
            ContentMemo1:PChar;
            ContentMemo2:PChar;
            ContentMemo3:PChar;
            ContentMemo4:PChar;
            ContentMemo5:PChar;
            ContentMemo6:PChar;
{Negoc}
            NegocMemo1:PChar;
            NegocMemo2:PChar;
            NegocMemo3:PChar;
{Ocena}
            OcenaEdit1:String;
            SG:TStringGrid;
            OcenaMemo2:PChar;
            OcenaMemo3_1:PChar;
            OcenaEdit3_2:String;
            OcenaSE2:String;
            OcenaEdit3_3:String;
            OcenaMemo3_4:PChar;
            OcenaMemo3_5:PChar;
            OcenaMemo3_6:PChar;
            OcenaMemo3_7:PChar;
            OcenaMemo3_8:PChar;
            OcenaCB1:Boolean;
            OcenaCB2:Boolean;
            OcenaCB3:Boolean;
            OcenaCB4:Boolean;
            OcenaMemo5:PChar;
            OcenaMemo6:PChar;
            OcenaMemo7:PChar;
            OcenaMemo8:PChar;
            OcenaMemo9:PChar;
{Wybor}
            WyborMemo1:PChar;
            WyborMemo2:PChar;
{Uniewaz}
            UniewazMemo1:PChar;
{Protesty}
            ProtMemo1:PChar;
            ProtMemo2:PChar;
            ProtMemo3:PChar;
            ProtMemo4:PChar;
            ProtMemo5:PChar;
            ProtMemo6:PChar;
            ProtMemo7:PChar;
  end;

procedure LoadPrtRec(Parent:TComponent; FileName:String);
procedure FreePrtRec;

var
  PrtRec:TPrtRec;
implementation

procedure InitPrtRec(Parent:TComponent);
begin
  with PrtRec do
    begin
{ Zamaw. }
            NameMemo:=Nil;
            ObjectMemo:=Nil;
            AnnexMemo:=Nil;
            OferentMemo:=Nil;
            ChoiceMemo:=Nil;
            ProwadMemo:=Nil;
            Art71Memo1:=Nil;
            Art71Memo2:=Nil;
            ObjectMemo2:=Nil;
            OferentMemo1:=Nil;
            OferentMemo2:=Nil;
{Termin}
{Warunki}
            WarunkiMemo1:=Nil;
            WarunkiMemo2:=Nil;
{Rodzaj}
            OfertaMemo:=Nil;
{Info}
            InfoMemo1:=Nil;
            InfoMemo2:=Nil;
            InfoMemo3:=Nil;
            InfoMemo4:=Nil;
            InfoMemo5:=Nil;
            InfoMemo6:=Nil;
            InfoMemo7:=Nil;
            InfoMemo8:=Nil;
            InfoMemo9:=Nil;
            InfoMemo10_1:=Nil;
            InfoMemo10_2:=Nil;
            InfoMemo11:=Nil;
{Wadium}
            WadiumMemo3_1:=Nil;
            WadiumMemo4_2:=Nil;
            WadiumMemo5:=Nil;
            WadiumMemo6:=Nil;
            WadiumMemo7_1:=Nil;
            WadiumMemo7_2:=Nil;
            WadiumMemo8:=Nil;
{Zabez}
            ZabezMemo4:=Nil;
{Sklad}
            SkladMemo1:=Nil;
            SkladMemo2_3:=Nil;
            SkladMemo3:=Nil;
            SkladMemo4:=Nil;
            SkladMemo5:=Nil;
            SkladMemo6:=Nil;
{Wycof}
            WycofMemo1:=Nil;
            WycofMemo2:=Nil;
            WycofMemo3:=Nil;
            WycofMemo4:=Nil;
            WycofMemo5:=Nil;
{Otwarcie}
            OpeningMemo2:=Nil;
            OpeningMemo3:=Nil;
            OpeningMemo4:=Nil;
            OpeningMemo5:=Nil;
{Zawartosc}
            ContentMemo1:=Nil;
            ContentMemo2:=Nil;
            ContentMemo3:=Nil;
            ContentMemo4:=Nil;
            ContentMemo5:=Nil;
            ContentMemo6:=Nil;
{Negoc}
            NegocMemo1:=Nil;
            NegocMemo2:=Nil;
            NegocMemo3:=Nil;
{Ocena}
            OcenaMemo2:=Nil;
            SG:=TStringGrid.Create(parent);
            SG.Visible:=FALSE;
            SG.Parent:=TWinControl(Parent);
            OcenaMemo3_1:=Nil;
            OcenaMemo3_4:=Nil;
            OcenaMemo3_5:=Nil;
            OcenaMemo3_6:=Nil;
            OcenaMemo3_7:=Nil;
            OcenaMemo3_8:=Nil;
            OcenaMemo5:=Nil;
            OcenaMemo6:=Nil;
            OcenaMemo7:=Nil;
            OcenaMemo8:=Nil;
            OcenaMemo9:=Nil;
{Wybor}
            WyborMemo1:=Nil;
            WyborMemo2:=Nil;
{Uniewaz}
            UniewazMemo1:=Nil;
{Protesty}
            ProtMemo1:=Nil;
            ProtMemo2:=Nil;
            ProtMemo3:=Nil;
            ProtMemo4:=Nil;
            ProtMemo5:=Nil;
            ProtMemo6:=Nil;
            ProtMemo7:=Nil;
    end;
end;

procedure LoadPrtRec(Parent:TComponent; FileName:String);
var
  LId:String;
  LDesc:String;
  Am:Integer;
  i:Integer;
  B:Boolean;
  SP:Array[0..Prt1MaxPages-1] of Boolean;
  T:Integer;
  s:String;
  M:TMemo;
  CB:TComboBox;
  FH:File;
  FileHdr:String[20];
  RecType:Byte;
  FPwd:String;
  procedure GetPChar(var P:PChar);
  begin
    LoadMemo(M,FH);
    P:=StrAlloc(M.GetTextLen+1);
    M.GetTextBuf(P,M.GetTextLen+1);
    M.Clear;
  end;
  procedure LoadPrt1_2_4(var PrtRec:TPrtRec);
  begin
    with PrtRec do
      begin
  { Zamaw. }
        GetPChar(NameMemo);
        LoadString(StreetEdit,FH);
        LoadString(TownEdit,FH);
        LoadString(BldgEdit,FH);
        LoadString(RoomEdit,FH);
        LoadString(ZipMaskEdit,FH);
        LoadString(TelEdit,FH);
        LoadString(FaxEdit,FH);
        LoadString(TelexEdit,FH);
        LoadString(RegonMaskEdit,FH);
        LoadBoolean(NipRB1,FH);
        LoadBoolean(NipRB2,FH);
        LoadString(NipMaskEdit1,FH);
        LoadString(NipMaskEdit2,FH);
        LoadString(ZwanyEdit,FH);
        LoadString(ZamawEdit,FH);
        GetPChar(ObjectMemo);
        GetPChar(AnnexMemo);
    {Termin}
        LoadBoolean(TerminRB1,FH);
        LoadBoolean(TerminRB2,FH);
        LoadBoolean(TerminRB1_1,FH);
        LoadBoolean(TerminRB1_2,FH);
        LoadBoolean(TerminRB2_1,FH);
        LoadBoolean(TerminRB2_2,FH);
        LoadDateTime(EndDate,FH);
        LoadInteger(TerminEdit,FH);
        LoadComboBox(CB,FH);
        TimeUnitCB:=CB.Text;
        LoadComboBox(CB,FH);
        CB2_5:=CB.Text;
    {Warunki}
        LoadString(WarunkiEdit1,FH);
        GetPChar(WarunkiMemo1);
        GetPChar(WarunkiMemo2);
    {Rodzaj}
        LoadInteger(OfertaRadioGroupItemIndex,FH);
        GetPChar(OfertaMemo);
    {Info}
        GetPChar(InfoMemo1);
        GetPChar(InfoMemo2);
        GetPChar(InfoMemo3);
        GetPChar(InfoMemo4);
        GetPChar(InfoMemo5);
        GetPChar(InfoMemo6);
        if RecType in [ttNie,ttOgr,ttNeg]
          then LoadBoolean(InfoCB7,FH);
        GetPChar(InfoMemo8);
        GetPChar(InfoMemo9);
        GetPChar(InfoMemo10_1);
        GetPChar(InfoMemo10_2);
        if RecType=ttDwu
          then GetPChar(InfoMemo11);
    {Wadium}
        LoadBoolean(WadiumRB1_2,FH);
        LoadString(WadiumEdit2_1,FH);
        LoadReal(WadiumEdit2_2,FH);
        LoadString(WadiumEdit2_3,FH);
        LoadString(WadiumEdit2_4,FH);
        LoadString(WadiumEdit2_5,FH);
        LoadString(WadiumEdit2_6,FH);
        GetPChar(WadiumMemo3_1);
        LoadBoolean(WadiumCB3_2,FH);
        LoadBoolean(WadiumCB3_3,FH);
        LoadString(WadiumEdit4_1,FH);
        GetPChar(WadiumMemo4_2);
        GetPChar(WadiumMemo5);
        GetPChar(WadiumMemo6);
        GetPChar(WadiumMemo7_1);
        GetPChar(WadiumMemo7_2);
        GetPChar(WadiumMemo8);
    {Zabez}
        LoadBoolean(ZabezRB1_2,FH);
        GetPChar(ZabezMemo2_1);
        LoadComboBox(CB,FH);
        ZabezCB2_2:=CB.Text;
        GetPChar(ZabezMemo3_1);
        LoadBoolean(ZabezCB3_2,FH);
        LoadBoolean(ZabezCB3_3,FH);
        LoadBoolean(ZabezCB3_4,FH);
        if RecType=ttDwu
          then GetPChar(ZabezMemo4);
    {Zwiaz}
        LoadString(ZwiazEdit1,FH);
        LoadInteger(ZwiazEdit2,FH);
        LoadString(ZwiazEdit3,FH);
    {Sklad}
        GetPChar(SkladMemo1);
        LoadString(SkladEdit2_1,FH);
        GetPChar(SkladMemo2_3);
        LoadString(SkladEdit2_6,FH);
        LoadString(SkladMaskEdit2_7,FH);
        LoadString(SkladEdit2_11,FH);
        LoadString(SkladEdit2_12,FH);
        LoadString(SkladEdit2_13,FH);
        LoadString(SkladEdit2_14,FH);
        LoadDateTime(SkladDateEdit2_15,FH);
        LoadString(SkladEdit2_16,FH);
        LoadDateTime(SkladTime2_17,FH);
        GetPChar(SkladMemo3);
        GetPChar(SkladMemo4);
        GetPChar(SkladMemo5);
        GetPChar(SkladMemo6);
    {Wycof}
        GetPChar(WycofMemo1);
        GetPChar(WycofMemo2);
        GetPChar(WycofMemo3);
        GetPChar(WycofMemo4);
        GetPChar(WycofMemo5);
    {Otwarcie}
        LoadString(OpeningEdit1_1,FH);
        LoadDateTime(OpeningDateEdit1_2,FH);
        LoadString(OpeningEdit1_2,FH);
        LoadDateTime(OpeningTime1_4,FH);
        LoadString(OpeningEdit1_3,FH);
        LoadString(OpeningEdit1_4,FH);
        LoadString(OpeningEdit1_5,FH);
        LoadString(OpeningEdit1_6,FH);
        GetPChar(OpeningMemo2);
        GetPChar(OpeningMemo3);
        GetPChar(OpeningMemo4);
        GetPChar(OpeningMemo5);
    {Zawartosc}
        GetPChar(ContentMemo1);
        GetPChar(ContentMemo2);
        GetPChar(ContentMemo3);
        GetPChar(ContentMemo4);
        GetPChar(ContentMemo5);
        GetPChar(ContentMemo6);
    {Negoc}
        if RecType=ttDwu
          then begin
            GetPChar(NegocMemo1);
            GetPChar(NegocMemo2);
            GetPChar(NegocMemo3);
          end;
    {Ocena}
        LoadString(OcenaEdit1,FH);
        LoadStringGrid(SG,FH);
        GetPChar(OcenaMemo2);
        GetPChar(OcenaMemo3_1);
        LoadString(OcenaEdit3_2,FH);
        LoadString(OcenaSE2,FH);
        LoadString(OcenaEdit3_3,FH);
        GetPChar(OcenaMemo3_4);
        GetPChar(OcenaMemo3_5);
        GetPChar(OcenaMemo3_6);
        GetPChar(OcenaMemo3_7);
        GetPChar(OcenaMemo3_8);
        LoadBoolean(OcenaCB1,FH);
        LoadBoolean(OcenaCB2,FH);
        LoadBoolean(OcenaCB3,FH);
        LoadBoolean(OcenaCB4,FH);
        GetPChar(OcenaMemo5);
        GetPChar(OcenaMemo6);
        GetPChar(OcenaMemo7);
        GetPChar(OcenaMemo8);
        GetPChar(OcenaMemo9);
    {Wybor}
        GetPChar(WyborMemo1);
        GetPChar(WyborMemo2);
    {Uniewaz}
        GetPChar(UniewazMemo1);
    {Protesty}
        GetPChar(ProtMemo1);
        GetPChar(ProtMemo2);
        GetPChar(ProtMemo3);
        GetPChar(ProtMemo4);
        GetPChar(ProtMemo5);
        GetPChar(ProtMemo6);
        GetPChar(ProtMemo7);
      end;
  end;

  procedure LoadPrt3(var PrtRec:TPrtRec);
  begin
    with PrtRec do
      begin
{ Zamaw. }
        GetPChar(NameMemo);
        LoadString(StreetEdit,FH);
        LoadString(TownEdit,FH);
        LoadString(BldgEdit,FH);
        LoadString(RoomEdit,FH);
        LoadString(ZipMaskEdit,FH);
        LoadString(TelEdit,FH);
        LoadString(FaxEdit,FH);
        LoadString(TelexEdit,FH);
        LoadString(RegonMaskEdit,FH);
        LoadBoolean(NipRB1,FH);
        LoadBoolean(NipRB2,FH);
        LoadString(NipMaskEdit1,FH);
        LoadString(NipMaskEdit2,FH);
        GetPChar(ProwadMemo);
        LoadDateTime(BeginDate,FH);
        LoadDateTime(EndDate,FH);
        GetPChar(ObjectMemo);
        GetPChar(OferentMemo);
        GetPChar(ChoiceMemo);
      end;
  end;

  procedure LoadPrt5(var PrtRec:TPrtRec);
  begin
    with PrtRec do
      begin
{ Zamaw. }
        GetPChar(NameMemo);
        LoadString(StreetEdit,FH);
        LoadString(TownEdit,FH);
        LoadString(BldgEdit,FH);
        LoadString(RoomEdit,FH);
        LoadString(ZipMaskEdit,FH);
        LoadString(TelEdit,FH);
        LoadString(FaxEdit,FH);
        LoadString(TelexEdit,FH);
        LoadString(RegonMaskEdit,FH);
        LoadBoolean(NipRB1,FH);
        LoadBoolean(NipRB2,FH);
        LoadString(NipMaskEdit1,FH);
        LoadString(NipMaskEdit2,FH);
        GetPChar(ProwadMemo);
        GetPChar(Art71Memo1);
        GetPChar(Art71Memo2);
        LoadDateTime(BeginDate,FH);
        LoadDateTime(EndDate,FH);
        GetPChar(ObjectMemo);
        GetPChar(ObjectMemo2);
        GetPChar(OferentMemo1);
        GetPChar(OferentMemo2);
      end;
  end;

begin
  M:=TMemo.Create(Parent);
  M.Visible:=FALSE;
  M.Parent:=TWinControl(Parent);
  CB:=TComboBox.Create(Parent);
  CB.Visible:=FALSE;
  CB.Parent:=TWinControl(Parent);
  InitPrtRec(Parent);
  s:=StripBeginPoint(ExtractFileExt(FileName));
  if s=NieExt
    then RecType:=ttNie
  else if s=OgrExt
    then RecType:=ttOgr
  else if s=DwuExt
    then RecType:=ttDwu
  else if s=NegExt
    then RecType:=ttNeg
  else if s=ZapExt
    then RecType:=ttZap
  else if s=ZamExt
    then RecType:=ttZam
  else Exit;
  case RecType of
    ttNie: FileHdr:=NieFileHdr;
    ttOgr: FileHdr:=OgrFileHdr;
    ttDwu: FileHdr:=DwuFileHdr;
    ttNeg: FileHdr:=NegFileHdr;
    ttZap: FileHdr:=ZapFileHdr;
    ttZam: FileHdr:=ZamFileHdr;
  end;{case}
  AssignFile(FH,FileName);
  FileMode:=fmOpenRead + fmShareDenyNone;
  try
    Reset(FH,1);
    try
      SeedKey:=SKey;
      LoadString(s,FH);
      if s=VersionString+FileHdr
        then begin
          LoadString(FPwd,FH);
          if (FPwd<>PrtRec.FilePwd)
            then MessageDlg(mIncorrectFilePwd,mtWarning,[mbOk],0)
            else begin
              MakeCodeKey(FPwd);
              LoadString(LId,FH);
              LoadString(LDesc,FH);
              LoadInteger(Am,FH);
              LoadInteger(PrtRec.OKind,FH);
              LoadReal(PrtRec.Amount,FH);
              LoadBoolean(PrtRec.PrefKrajowe,FH);
              LoadByte(PrtRec.Phase,FH);
              if RecType in [ttNie,ttOgr]
                then for i:=0 to Prt1MaxPages-1 do
                  LoadBoolean(SP[i],FH)
              else if RecType=ttDwu
                then for i:=0 to Prt2MaxPages-1 do
                  LoadBoolean(SP[i],FH)
              else if RecType=ttNeg
                then for i:=0 to Prt4MaxPages-1 do
                  LoadBoolean(SP[i],FH)
              else if RecType=ttZap
                then for i:=0 to Prt3MaxPages-1 do
                  LoadBoolean(SP[i],FH)
              else if RecType=ttZam
                then for i:=0 to Prt5MaxPages-1 do
                  LoadBoolean(SP[i],FH);
              if RecType in [ttNie,ttOgr,ttNeg, ttDwu]
                then LoadPrt1_2_4(PrtRec)
              else if RecType=ttZap
                 then LoadPrt3(PrtRec)
              else if RecType=ttZam
                 then LoadPrt5(PrtRec);
            end;
        end;

    finally
      CloseFile(FH);
    end;
  except
    on E:EInOutError do
      begin
        MessageDlg('Error '+IntToStr(E.ErrorCode),mtWarning,[mbOk],0);
      end;
  end;
  M.Free;
  CB.Free;
end;

procedure FreePrtRec;
begin
  with PrtRec do
    begin
{ Zamaw. }
            StrDispose(NameMemo);
            StrDispose(ObjectMemo);
            StrDispose(AnnexMemo);
            StrDispose(OferentMemo);
            StrDispose(ChoiceMemo);
            StrDispose(ProwadMemo);
            StrDispose(Art71Memo1);
            StrDispose(Art71Memo2);
            StrDispose(ObjectMemo2);
            StrDispose(OferentMemo1);
            StrDispose(OferentMemo2);
{Termin}
{Warunki}
            StrDispose(WarunkiMemo1);
            StrDispose(WarunkiMemo2);
{Rodzaj}
            StrDispose(OfertaMemo);
{Info}
            StrDispose(InfoMemo1);
            StrDispose(InfoMemo2);
            StrDispose(InfoMemo3);
            StrDispose(InfoMemo4);
            StrDispose(InfoMemo5);
            StrDispose(InfoMemo6);
            StrDispose(InfoMemo7);
            StrDispose(InfoMemo8);
            StrDispose(InfoMemo9);
            StrDispose(InfoMemo10_1);
            StrDispose(InfoMemo10_2);
            StrDispose(InfoMemo11);
{Wadium}
            StrDispose(WadiumMemo3_1);
            StrDispose(WadiumMemo4_2);
            StrDispose(WadiumMemo5);
            StrDispose(WadiumMemo6);
            StrDispose(WadiumMemo7_1);
            StrDispose(WadiumMemo7_2);
            StrDispose(WadiumMemo8);
{Zabez}
            StrDispose(ZabezMemo4);
{Sklad}
            StrDispose(SkladMemo1);
            StrDispose(SkladMemo2_3);
            StrDispose(SkladMemo3);
            StrDispose(SkladMemo4);
            StrDispose(SkladMemo5);
            StrDispose(SkladMemo6);
{Wycof}
            StrDispose(WycofMemo1);
            StrDispose(WycofMemo2);
            StrDispose(WycofMemo3);
            StrDispose(WycofMemo4);
            StrDispose(WycofMemo5);
{Otwarcie}
            StrDispose(OpeningMemo2);
            StrDispose(OpeningMemo3);
            StrDispose(OpeningMemo4);
            StrDispose(OpeningMemo5);
{Zawartosc}
            StrDispose(ContentMemo1);
            StrDispose(ContentMemo2);
            StrDispose(ContentMemo3);
            StrDispose(ContentMemo4);
            StrDispose(ContentMemo5);
            StrDispose(ContentMemo6);
{Negoc}
            StrDispose(NegocMemo1);
            StrDispose(NegocMemo2);
            StrDispose(NegocMemo3);
{Ocena}
            SG.Free;
            StrDispose(OcenaMemo2);
            StrDispose(OcenaMemo3_1);
            StrDispose(OcenaMemo3_4);
            StrDispose(OcenaMemo3_5);
            StrDispose(OcenaMemo3_6);
            StrDispose(OcenaMemo3_7);
            StrDispose(OcenaMemo3_8);
            StrDispose(OcenaMemo5);
            StrDispose(OcenaMemo6);
            StrDispose(OcenaMemo7);
            StrDispose(OcenaMemo8);
            StrDispose(OcenaMemo9);
{Wybor}
            StrDispose(WyborMemo1);
            StrDispose(WyborMemo2);
{Uniewaz}
            StrDispose(UniewazMemo1);
{Protesty}
            StrDispose(ProtMemo1);
            StrDispose(ProtMemo2);
            StrDispose(ProtMemo3);
            StrDispose(ProtMemo4);
            StrDispose(ProtMemo5);
            StrDispose(ProtMemo6);
            StrDispose(ProtMemo7);
    end;
end;

end.
