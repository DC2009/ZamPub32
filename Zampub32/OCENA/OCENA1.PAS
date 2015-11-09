unit Ocena1;

interface

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, StdCtrls, ExtCtrls, Buttons,
  OfrtDta,
  UserUnit,
  SiwzIni,
  PrtRecIo,
  Pwd,
  NewPwd,
  Classify,
  Points,
  Kriteria,
  PrefKraj,
  MaxPts,
  TenderNr,
  Members,
  Menus,
  SkOk,
  Sk;

type
  TOcenaMainDlg = class(TForm)
    SaveDialog: TSaveDialog;
    OpenDialog: TOpenDialog;
    Sk: TSmartKey;
    Panel1: TPanel;
    EndBtn: TBitBtn;
    HelpBtn: TBitBtn;
    Panel2: TPanel;
    AdmBtn: TBitBtn;
    ImportBtn: TBitBtn;
    LoadBtn: TBitBtn;
    SaveBtn: TBitBtn;
    Panel3: TPanel;
    CountBtn: TButton;
    TenderNrBtn: TButton;
    MaxPtsBtn: TButton;
    MembersBtn: TButton;
    KriteriaBtn: TButton;
    PrefKrajBtn: TButton;
    MainMenu1: TMainMenu;
    Plik1: TMenuItem;
    Open1: TMenuItem;
    Save1: TMenuItem;
    ImportSIWZ1: TMenuItem;
    N1: TMenuItem;
    Close1: TMenuItem;
    Pomoc1: TMenuItem;
    procedure MembersBtnClick(Sender: TObject);
    procedure KriteriaBtnClick(Sender: TObject);
    procedure CountBtnClick(Sender: TObject);
    procedure TenderNrBtnClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure MaxPtsBtnClick(Sender: TObject);
    procedure EndBtnClick(Sender: TObject);
    procedure SaveBtnClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure LoadBtnClick(Sender: TObject);
    procedure AdmBtnClick(Sender: TObject);
    procedure ImportBtnClick(Sender: TObject);
    procedure HelpBtnClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure PrefKrajBtnClick(Sender: TObject);
  private
    { Private declarations }
    FKey:Integer;
    OcenaModified:Boolean;
    function CheckValues:Boolean;
    procedure DestroyOfferTables;
    procedure LoadFromFile(FileName:String);
    procedure MakeOfferTables;
    procedure SaveToFile(FileName:String);
  public
    { Public declarations }
  end;

var
  OcenaMainDlg: TOcenaMainDlg;

implementation

{$R *.DFM}
uses
  Utils,
  Msg;

procedure TOcenaMainDlg.FormCreate(Sender: TObject);
var i:LongInt;
begin
  GetAllConfiguration;
  Application.HelpFile:=OcOfHelpFile;
  PrefKrajowe:=TRUE;
  MaxPoints:=0;
  TendersTot:=0;
  SuperPwd:='';
  ValueIndex:=-1; {first element is 0}
  MNames:=TStringList.Create;
  MSurnames:=TStringList.Create;
  MPwds:=TStringList.Create;
  KDescs:=TStringList.Create;
  KEvalModes:=TStringList.Create;
  KWeights:=TStringList.Create;
  Offers:=TList.Create;
end;

procedure TOcenaMainDlg.FormDestroy(Sender: TObject);
begin
  DestroyOfferTables;
  Offers.Free;
  MNames.Free;
  MSurnames.Free;
  MPwds.Free;
  KDescs.Free;
  KEvalModes.Free;
  KWeights.Free;
end;

procedure TOcenaMainDlg.MakeOfferTables;
var
  POI:TPOfferItem;
  i,j,k:Integer;
begin
  if (MNames.Count=0) or (KDescs.Count=0) or (TendersTot=0)
    then Exit;
  for i:=0 to TendersTot-1 do
    for j:=0 to MNames.Count-1 do
      for k:=0 to KDescs.Count-1 do
        begin
          New(POI);
          POI^.ONum:=i;
          POI^.MNum:=j;
          POI^.KNum:=k;
          POI^.Pts:=0;
          POI^.Eval:=0;
          POI^.Memo:=#0;
          POI^.PreKra:=FALSE;
          Offers.Add(POI);
        end;
end;

procedure TOcenaMainDlg.DestroyOfferTables;
var
  i:LongInt;
  j,k:Integer;
  POI:TPOfferItem;
begin
  if Offers.Count=0
    then Exit;
  for i:=0 to Offers.Count-1 do
    begin
      POI:=(Offers.Items[i]);
         if StrLen(TOfferItem(POI^).Memo)>0
            then begin
              StrDispose(TOfferItem(POI^).Memo);
              TOfferItem(POI^).Memo:=#0;
            end;
    end;
  Offers.Clear;
end;

procedure TOcenaMainDlg.MembersBtnClick(Sender: TObject);
var
  i:LongInt;
begin
  MembersDlg:=TMembersDlg.Create(Self);
  with MembersDlg do
    begin
      if ShowModal=mrOk
        then begin
          DestroyOfferTables;
          MNames.Clear;
          MSurnames.Clear;
          MPwds.Clear;
          for i:=1 to MSG.RowCount-1 do
            begin
              if (MSG.Cells[NCol,i]<>'') and
                 (MSG.Cells[SCol,i]<>'')
                then begin
                  MNames.Add(MSG.Cells[NCol,i]);
                  Msurnames.Add(MSG.Cells[SCol,i]);
                  MPwds.Add('');
                end;
            end;
          MakeOfferTables;
          OcenaModified:=TRUE;
          PrefKrajBtn.Enabled:=TRUE;
        end;
      Free;
    end;
end;

procedure TOcenaMainDlg.KriteriaBtnClick(Sender: TObject);
var
  i:LongInt;
  s:String;
  OldPrefKrajowe:Boolean;
x,y:integer;
begin
  KriteriaDlg:=TKriteriaDlg.Create(Self);
  with KriteriaDlg do
    begin
      for i:=0 to KDescs.Count-1 do
        begin
          if i=KSG.RowCount-1
            then KSG.RowCount:=KSG.RowCount+1;
          KSG.Cells[KDCol,i+1]:=KDescs.Strings[i];
          KSG.Cells[KWCol,i+1]:=KWeights.Strings[i];
          KSG.Cells[KECol,i+1]:=KEvalModes.Strings[i];
        end;
      if ValueIndex>-1
        then KSG.Cells[KCCol,ValueIndex]:=' +';
      if KriteriaDlg.ShowModal=mrOk
        then begin
          DestroyOfferTables;
          OldPrefKrajowe:=PrefKrajowe;
          KDescs.Clear;
          KWeights.Clear;
          KEvalModes.Clear;
          ValueIndex:=-1;
          for i:=1 to KSG.RowCount-1 do
            begin
              if (KSG.Cells[KDCol,i]<>'') and
                 (KSG.Cells[KWCol,i]<>'') and
                 (KSG.Cells[KECol,i]<>'')
                then begin
                  s:=KSG.Cells[KDCol,i];
                  KDescs.Add(s);
                  s:=KSG.Cells[KWCol,i];
                  KWeights.Add(s);
                  s:=KSG.Cells[KECol,i];
                  KEvalModes.Add(s);
                  if (KSG.Cells[KCCol,i]=' +') and (KSG.Cells[KECol,i]=evArray[evMin])
                    then ValueIndex:=KDescs.Count;
                end;
            end;
          MakeOfferTables;
          OcenaModified:=TRUE;
          CountBtn.Enabled:=TRUE;
        end;
      KriteriaDlg.Free;
    end;
end;

function TOcenaMainDlg.CheckValues:Boolean;
begin
  Result:=TRUE;
  if TendersTot<=0
    then begin
      MessageDlg(mUnknownQuantity,mtWarning,[mbOk],0);
      Result:=FALSE;
      Exit;
    end;
  if MSurnames.Count<=0
    then begin
      MessageDlg(mEmptyMembersList,mtWarning,[mbOk],0);
      Result:=FALSE;
      Exit;
    end;
  if KDescs.Count<=0
    then begin
      MessageDlg(mEmptyKriteriumsList,mtWarning,[mbOk],0);
      Result:=FALSE;
      Exit;
    end;
  if MaxPoints<=0
    then begin
      MessageDlg(mNoMaxPoints,mtWarning,[mbOk],0);
      Result:=FALSE;
      Exit;
    end;
end;

procedure TOcenaMainDlg.CountBtnClick(Sender: TObject);
begin
  if not CheckValues
    then Exit;
  PointsDlg:=TPointsDlg.Create(OcenaMainDlg);
  if PointsDlg.ShowModal=mrOk
    then begin
      ClassifyDlg:=TClassifyDlg.Create(OcenaMainDlg);
      ClassifyDlg.ShowModal;
      ClassifyDlg.Free;
    end;
  if PointsDlg.PointModified
    then OcenaModified:=TRUE;
  PointsDlg.Free;
end;

procedure TOcenaMainDlg.TenderNrBtnClick(Sender: TObject);
var x,y:Integer;
begin
  TenderNumDlg:=TTenderNumDlg.Create(OcenaMainDlg);
  TenderNumDlg.SpinEdit.Text:=IntToStr(TendersTot);
  if TenderNumDlg.ShowModal=mrOk
    then begin
      DestroyOfferTables;
      TendersTot:=StrToInt(TenderNumDlg.SpinEdit.Text);
      MakeOfferTables;
      OcenaModified:=TRUE;
      MaxPtsBtn.Enabled:=TRUE;
    end;
  TenderNumDlg.Free;
end;

procedure TOcenaMainDlg.MaxPtsBtnClick(Sender: TObject);
begin
  MaxPtsDlg:=TMaxPtsDlg.Create(Self);
  MaxPtsDlg.SpinEdit.Text:=IntToStr(MaxPoints);
  if MaxPtsDlg.ShowModal=mrOk
    then begin
      MaxPoints:=StrToInt(MaxPtsDlg.SpinEdit.Text);
      OcenaModified:=TRUE;
      MembersBtn.Enabled:=TRUE;
    end;
  MaxPtsDlg.Free;
end;

procedure TOcenaMainDlg.PrefKrajBtnClick(Sender: TObject);
begin
  PrefKrajoweDlg:=TPrefKrajoweDlg.Create(Self);
  if PrefKrajowe
    then PrefKrajoweDlg.PKGroup.ItemIndex:=0
    else PrefKrajoweDlg.PKGroup.ItemIndex:=1;
  if PrefKrajoweDlg.ShowModal=mrOk
    then begin
      PrefKrajowe:=PrefKrajoweDlg.PKGroup.ItemIndex=0;
      OcenaModified:=TRUE;
      KriteriaBtn.Enabled:=TRUE;
    end;
  PrefKrajoweDlg.Free;
end;

procedure TOcenaMainDlg.EndBtnClick(Sender: TObject);
begin
  if OcenaModified
    then case MessageDlg(wmSaveData,mtWarning,[mbYes,mbNo,mbCancel],0) of
      mrYes: begin
               SaveBtnClick(Sender);
               Close;
             end;
      mrNo: Close;
      mrCancel: ModalResult:=0;
    end{case}
    else Close;
end;

procedure TOcenaMainDlg.SaveBtnClick(Sender: TObject);
begin
  if not SmartKeyOk(Sk,SkData)
    then Exit;
  if SaveDialog.Execute
    then SaveToFile(SaveDialog.FileName);
end;

procedure TOcenaMainDlg.LoadBtnClick(Sender: TObject);
begin
  OpenDialog.DefaultExt:='ofr';
  OpenDialog.Filter:='ocena oferty|*.ofr';
  OpenDialog.FileName:='';
  if OpenDialog.Execute
    then LoadFromFile(OpenDialog.FileName);
end;

procedure TOcenaMainDlg.SaveToFile(FileName:String);
var
  i,j,k:LongInt;
  F:File;
  M:TMemo;
  OI:TOfferItem;
begin
  AssignFile(F,FileName);
  FileMode:=fmOpenReadWrite + fmShareDenyWrite;
  try
    Rewrite(F,1);
    try
      FKey:=8264;
      SaveString(OcenaFileHdr+VersionString,F);
      SaveInteger(FKey,F);
      SaveBoolean(TenderNrBtn.Enabled,F);
      SaveBoolean(MaxPtsBtn.Enabled,F);
      SaveBoolean(MembersBtn.Enabled,F);
      SaveBoolean(PrefKrajBtn.Enabled,F);
      SaveBoolean(KriteriaBtn.Enabled,F);
      SaveBoolean(CountBtn.Enabled,F);
      SaveInteger(ValueIndex,F);
      SaveBoolean(PrefKrajowe,F);
      SaveLongInt(MaxPoints,F);
      SaveLongInt(TendersTot,F);
      SaveStringList(MNames,F);
      SaveStringList(MSurnames,F);
      SaveStringList(MPwds,F);
      SaveStringList(KDescs,F);
      SaveStringList(KWeights,F);
      SaveStringList(KEvalModes,F);
      if Offers.Count>0
        then begin
          SaveLongInt(Offers.Count,F);
          M:=TMemo.Create(Self);
          M.Parent:=Self;
          for i:=0 to Offers.Count-1 do
            begin
              OI:=TOfferItem(Offers.Items[i]^);
              SaveInteger(OI.MNum,F);
              SaveInteger(OI.KNum,F);
              SaveInteger(OI.ONum,F);
              SaveReal(OI.Eval,F);
              SaveReal(OI.Pts,F);
              M.Clear;
              M.SetTextBuf(OI.Memo);
              SaveMemo(M,F);
              SaveBoolean(OI.PreKra,F);
            end;
          M.Free;
        end;
      OcenaModified:=FALSE;
    finally
      CloseFile(F);
    end;
  except
    on E:EInOutError do
      case E.ErrorCode of
        5: MessageDlg(wmFileAccessDenied ,mtWarning ,[mbOk] ,0);
        100: MessageDlg(wmReadBeyondEnd ,mtWarning ,[mbOk] ,0);
        else MessageDlg(IntToStr(E.ErrorCode),mtWarning,[mbOk],0);
      end;
  end;
end;

procedure TOcenaMainDlg.LoadFromFile(FileName:String);
var
  j,k:LongInt;
  i:Integer;
  s:String;
  b:Boolean;
  F:File;
  Cnt:LongInt;
  M:TMemo;
  OI:TOfferItem;
  l:Integer;
begin
  AssignFile(F,FileName);
  FileMode:=fmOpenReadWrite + fmShareDenyWrite;
  try
    Reset(F,1);
    FKey:=8264;
    try
      LoadString(s,F);
      if s=OcenaFileHdr+VersionString
        then begin
          LoadInteger(i,F);
          if i=FKey
            then begin
              DestroyOfferTables;
              LoadBoolean(b,F);
              TenderNrBtn.Enabled:=b;
              LoadBoolean(b,F);
              MaxPtsBtn.Enabled:=b;
              LoadBoolean(b,F);
              MembersBtn.Enabled:=b;
              LoadBoolean(b,F);
              PrefKrajBtn.Enabled:=b;
              LoadBoolean(b,F);
              KriteriaBtn.Enabled:=b;
              LoadBoolean(b,F);
              CountBtn.Enabled:=b;
              LoadInteger(ValueIndex,F);
              LoadBoolean(PrefKrajowe,F);
              LoadLongInt(MaxPoints,F);
              LoadLongInt(TendersTot,F);
              LoadStringList(MNames,F);
              LoadStringList(MSurnames,F);
              LoadStringList(MPwds,F);
              LoadStringList(KDescs,F);
              LoadStringList(KWeights,F);
              LoadStringList(KEvalModes,F);
              MakeOfferTables;
              if Offers.Count>0
                then begin
                  LoadLongInt(Cnt,F);
                  M:=TMemo.Create(Self);
                  M.Parent:=Self;
                  for i:=0 to Offers.Count-1 do
                    begin
                      LoadInteger(OI.MNum,F);
                      LoadInteger(OI.KNum,F);
                      LoadInteger(OI.ONum,F);
                      LoadReal(OI.Eval,F);
                      LoadReal(OI.Pts,F);
                      M.Clear;
                      LoadMemo(M,F);
                      l:=M.GetTextLen+1;
                      OI.Memo:=StrAlloc(l);
                      M.GetTextBuf(OI.Memo,l);
                      LoadBoolean(OI.PreKra,F);
                      SetOfferItem(OI,i);
                    end;
                  M.Free;
                end;
            end
            else MessageDlg(wmDifferentFileKey,mtWarning,[mbOk],0);
        end
        else MessageDlg(wmIncompatibleFile,mtWarning,[mbOk],0);
    finally
      CloseFile(F);
    end;
  except
    on E:EInOutError do
      begin
        case E.ErrorCode of
          5: MessageDlg(wmFileAccessDenied ,mtWarning ,[mbOk] ,0);
          100: MessageDlg(wmReadBeyondEnd ,mtWarning ,[mbOk] ,0);
          else MessageDlg(IntToStr(E.ErrorCode),mtWarning,[mbOk],0);
        end;
      end;
  end;
end;

procedure TOcenaMainDlg.AdmBtnClick(Sender: TObject);
begin
  if SuperPwd<>''
    then begin
      PwdDlg:=TPwdDlg.Create(OcenaMainDlg);
      PwdDlg.Caption:='Has³o administratora';
      if PwdDlg.ShowModal=mrOk
        then begin
          if PwdDlg.PwdEdit.Text=SuperPwd
            then GetNewPassword(0)
            else MessageDlg(wmIncorrectPwd,mtError,[mbOk],0);
        end;
      PwdDlg.Free;
    end
    else GetNewPassword(0);
end;

procedure TOcenaMainDlg.ImportBtnClick(Sender: TObject);
var
  s:String;
  i:LongInt;
  x:Byte;
begin
{$IFDEF DEMO}
  MessageDlg('Nie dostêpne w wersji DEMO',mtWarning,[mbOk],0);
{$ELSE}
  OpenDialog.DefaultExt:=NieExt;
  OpenDialog.Filter:=AllFilter;
  OpenDialog.FileName:='';
  if OpenDialog.Execute
    then begin
      LoadPrtRec(Self,OpenDialog.FileName);
      DestroyOfferTables;
      KDescs.Clear;
      KWeights.Clear;
      KEvalModes.Clear;
      MaxPoints:=StrToInt(PrtRec.OcenaSE2);
      with PrtRec do
        for i:=1 to SG.RowCount-1 do
          begin
            s:=SG.Cells[3,i];
            KWeights.Add(s);
            s:=SG.Cells[1,i];
            KDescs.Add(s);
            s:=SG.Cells[2,i];
            KEvalModes.Add(s);
            if SG.Cells[0,i]<>''
              then ValueIndex:=i;
{            ValueIndex:=i-1;}
          end;
      PrefKrajowe:=PrtRec.PrefKrajowe;
      FreePrtRec;
      MakeOfferTables;
      MembersBtn.Enabled:=TRUE;
      CountBtn.Enabled:=TRUE;
      PrefKrajBtn.Enabled:=TRUE;
      MaxPtsBtn.Enabled:=TRUE;
      KriteriaBtn.Enabled:=TRUE;
    end;
{$ENDIF}
end;

procedure TOcenaMainDlg.HelpBtnClick(Sender: TObject);
begin
  Application.HelpContext(101);
end;

procedure TOcenaMainDlg.FormActivate(Sender: TObject);
begin
{$IFDEF NONET}
  if not SmartKeyOk(Sk,SkData)
    then EndBtnClick(Sender);
{$ENDIF}
end;

end.


