unit Count;

interface

uses WinTypes, WinProcs, Classes, Graphics, Forms, Controls, Buttons,
  StdCtrls, ExtCtrls, Tabs, SysUtils, Spin,
  Kriteria,
  Members;

const
  KrLineLen=57;

  MaxMembers=100;
  MaxTenders=150;
  MaxKriteriums=100;

  TitleMaxMin='Podaj wartoœæ podlegaj¹c¹ ocenie kryterium';
  TitleYesNo='Czy oferta wype³nia wymogi oceniane kryterium';
  EvalModeStr='Sposób ocena kryterium: ';
  TenderS='Oferta nr ';
type
  TKrArray=Array[1..5] of String[KrLineLen];

  TPTenderItem=^TTenderItem;
  TTenderItem=Record
    KDesc:String;
    KWeight:Byte;
    KEvalMode:Byte;
  end;

  TPPointsTable=^TPointsTable;
  TPointsTable=Array[1..MaxTenders,1..MaxKriteriums] of Integer;

  TPMemberItem=^TMemberItem;
  TMemberItem=Record
    Name:String[NameMaxLen];
    Surname:String[SurnameMaxLen];
    PointsTable:TPointsTable;
    CurTender:LongInt;
    CurKrit:LongInt;
  end;

  TPMemberTable=^TMemberTable;
  TMemberTable=Array[1..MaxMembers] of TPMemberItem;

  TPTenderTable=^TTenderTable;
  TTenderTable=Array[1..MaxTenders,1..MaxKriteriums] of TPTenderItem;

  TOcenaDlg = class(TForm)
    OKBtn: TBitBtn;
    CancelBtn: TBitBtn;
    HelpBtn: TBitBtn;
    TabSet: TTabSet;
    Notebook: TNotebook;
    Label1: TLabel;
    Panel1: TPanel;
    Label2: TLabel;
    Label3: TLabel;
    Panel2: TPanel;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    Button3: TButton;
    Button4: TButton;
    ScrollBar1: TScrollBar;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    SpinEdit1: TSpinEdit;
    Label12: TLabel;
    Button1: TButton;
    Button2: TButton;
    ConfirmBtn: TButton;
    Label13: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure TabSetClick(Sender: TObject);
    procedure KriteriaSBChange(Sender: TObject);
    procedure ScrollBar1Scroll(Sender: TObject; ScrollCode: TScrollCode;
      var ScrollPos: Integer);
    procedure ConfirmBtnClick(Sender: TObject);
  private
    { Private declarations }
  Key:Char;
  Cnt:LongInt;
    MaxPoints:Word;
    TenderTot:LongInt;
    MembersTot:LongInt;
    KriteriumsTot:LongInt;
    MTable:TPMemberTable;
    TTable:TPTenderTable;
    procedure BuildTables;
    procedure DestroyTables;
    procedure InitTabs;
    procedure SetPanel;
    procedure StrTo5Str(S:String; var SA:TKrArray);
  public
    { Public declarations }
  end;

var
  OcenaDlg: TOcenaDlg;

implementation

{$R *.DFM}
uses
  Ocena1;

procedure TOcenaDlg.FormCreate(Sender: TObject);
var
  i,j:Integer;
  cur:Integer;
begin
  cur:=Screen.Cursor;
  Screen.Cursor:=crHourGlass;
  MaxPoints:=0;
  TenderTot:=0;
  MembersTot:=0;
  KriteriumsTot:=0;
  New(MTable);
  New(TTable);
  for i:=1 to MaxMembers do
    MTable^[i] := Nil;
  for i:=1 to MaxTenders do
    for j:=1 to MaxKriteriums do
      TTable^[i,j] := Nil;
  BuildTables;
  InitTabs;
  for i:=1 to Notebook.Pages.Count do
    begin
      Notebook.PageIndex:=i-1;
      SetPanel;
    end;
  Notebook.PageIndex:=0;
  Screen.Cursor:=cur;
end;

procedure TOcenaDlg.FormDestroy(Sender: TObject);
begin
  DestroyTables;
  Dispose(MTable);
  Dispose(TTable);
end;

procedure TOcenaDlg.BuildTables;
var
  x:LongInt;
  i,j:LongInt;
  p:Byte;
  s:String;
  mp:TPMemberItem;
  tp:TPTenderItem;
begin
  MembersTot:=MembersDlg.MembersLB.Items.Count;
  if MembersTot>MaxMembers
    then MembersTot:=MaxMembers;
  for i:=1 to MembersTot do
    begin
      New(mp);
      MTable^[i]:=mp;
      s:=MembersDlg.MembersLB.Items[i-1];
      p:=Pos(' ',s);
      MTable^[i]^.Name:=Copy(s,1,p-1);
      MTable^[i]^.SurName:=Copy(s,p+1,Length(s)-p);
      MTable^[i]^.CurTender:=1;
      MTable^[i]^.CurKrit:=1;
    end;
  TenderTot:=OcenaMainDlg.TenderNum;
  MaxPoints:=OcenaMainDlg.MaxPoints;
  KriteriumsTot:=KriteriaDlg.GridIndex;
  if KriteriumsTot>MaxKriteriums
    then KriteriumsTot:=MaxKriteriums;
  for i:=1 to KriteriumsTot do
    begin
      New(tp);
      TTable^[1,i]:=tp;
      s:=KriteriaDlg.KrytSG.Cells[DCol,i];
      TTable^[1,i]^.KDesc:=s;
      s:=KriteriaDlg.KrytSG.Cells[WCol,i];
      TTable^[1,i]^.KWeight:=StrToInt(s);
      s:=KriteriaDlg.KrytSG.Cells[ECol,i];
      if s=evMaxS
        then TTable^[1,i]^.KEvalMode:=evMax
      else if s=evMinS
        then TTable^[1,i]^.KEvalMode:=evMin
      else if s=evYesNoS
        then TTable^[1,i]^.KEvalMode:=evYesNo
      else if s=evSubjS
        then TTable^[1,i]^.KEvalMode:=evSubj;
      if TenderTot>1
        then for j:=2 to TenderTot do
          begin
            New(tp);
            tp^.KDesc:=TTable^[1,i]^.KDesc;
            tp^.KWeight:=TTable^[1,i]^.KWeight;
            tp^.KEvalMode:=TTable^[1,i]^.KEvalMode;
            TTable^[j,i]:=tp;
          end;
    end;
end;

procedure TOcenaDlg.DestroyTables;
var
  i,j:Integer;
begin
  for i:=1 to MaxMembers do
    if MTable^[i] <> Nil
      then begin
        Dispose(MTable^[i]);
        MTable^[i]:=Nil;
      end;
  for i:=1 to MaxTenders do
    for j:=1 to MaxKriteriums do
      if TTable^[i,j] <> Nil
        then begin
          Dispose(TTable^[i,j]);
          TTable^[i,j]:=Nil;
        end;
end;

procedure TOcenaDlg.InitTabs;
var
  i:LongInt;
  La:TLabel;
  Pa:TPanel;
  SE:TSpinEdit;
  Bt:TButton;
SB:TScrollBar;
GB:TGroupBox;
begin
  for i:=1 to MembersTot do
    begin
      Notebook.Pages.Add('  '+MTable^[i]^.Name[1]+'. '+MTable^[i]^.Surname);
      Notebook.PageIndex:=i;
      TWinControl(Notebook.Pages.Objects[Notebook.PageIndex]).Name:='NP'+IntToStr(Notebook.PageIndex);
{Member}
      La:=TLabel.Create(Notebook);
      La.Parent:=TWinControl(Notebook.Pages.Objects[Notebook.PageIndex]);
      La.Name:='Mbm'+IntToStr(Notebook.PageIndex-1);
      La.Top:=10;
      La.Left:=10;
      La.Font:=Notebook.Font;
      La.Font.Size:=12;
      La.Caption:=MTable^[i]^.Name+' '+MTable^[i]^.Surname;
{Tender}
      La:=TLabel.Create(Notebook);
      La.Parent:=TWinControl(Notebook.Pages.Objects[Notebook.PageIndex]);
      La.Name:='Tnd'+IntToStr(Notebook.PageIndex-1);
      La.Top:=32;
      La.Left:=242;
      La.Font:=Notebook.Font;
      La.Font.Size:=12;
      La.Font.Style:=[fsUnderLine, fsBold];
{Panel}
      Pa:=TPanel.Create(Notebook);
      Pa.Parent:=TWinControl(Notebook.Pages.Objects[Notebook.PageIndex]);
      Pa.Name:='NPanel'+IntToStr(Notebook.PageIndex-1);
      Pa.Top:=56;
      Pa.Left:=8;
      Pa.Height:=241;
      Pa.Width:=585;
      Pa.Caption:='';
      Pa.BevelInner:=bvLowered;
      Pa.BevelOuter:=bvLowered;
{Krit. title}
      La:=TLabel.Create(Pa);
      La.Parent:=TWinControl(Pa);
      La.Name:='LT_'+IntToStr(Notebook.PageIndex-1);
      La.Top:=16;
      La.Left:=8;
      La.Font.Size:=10;
      La.Caption:='Title';
{Krit. line 1}
      La:=TLabel.Create(Pa);
      La.Parent:=TWinControl(Pa);
      La.Name:='L1_'+IntToStr(Notebook.PageIndex-1);
      La.Top:=40;
      La.Left:=8;
      La.Caption:='Line 1';
{Krit. line 2}
      La:=TLabel.Create(Pa);
      La.Parent:=TWinControl(Pa);
      La.Name:='L2_'+IntToStr(Notebook.PageIndex-1);
      La.Top:=64;
      La.Left:=8;
      La.Caption:='Line 2';
{Krit. line 3}
      La:=TLabel.Create(Pa);
      La.Parent:=TWinControl(Pa);
      La.Name:='L3_'+IntToStr(Notebook.PageIndex-1);
      La.Top:=88;
      La.Left:=8;
      La.Caption:='Line 3';
{Krit. line 4}
      La:=TLabel.Create(Pa);
      La.Parent:=TWinControl(Pa);
      La.Name:='L4_'+IntToStr(Notebook.PageIndex-1);
      La.Top:=112;
      La.Left:=8;
      La.Caption:='Line 4';
{Krit. line 5}
      La:=TLabel.Create(Pa);
      La.Parent:=TWinControl(Pa);
      La.Name:='L5_'+IntToStr(Notebook.PageIndex-1);
      La.Top:=136;
      La.Left:=8;
      La.Caption:='Line 5';
{Krit. eval mode}
      La:=TLabel.Create(Pa);
      La.Parent:=TWinControl(Pa);
      La.Name:='EM_'+IntToStr(Notebook.PageIndex-1);
      La.Top:=160;
      La.Left:=8;
{SpinEdit}
      SE:=TSpinEdit.Create(Pa);
      SE.Parent:=TWinControl(Pa);
      SE.Name:='SE_'+IntToStr(Notebook.PageIndex-1);
      SE.Top:=184;
      SE.Left:=256;
      SE.Height:=33;
      SE.Width:=65;
      SE.MaxValue:=MaxPoints;
      SE.Font.Size:=12;
{Btn Tak}
      Bt:=TButton.Create(Pa);
      Bt.Parent:=TWinControl(Pa);
      Bt.Name:='Yes_'+IntToStr(Notebook.PageIndex-1);
      Bt.Top:=184;
      Bt.Left:=152;
      Bt.Height:=33;
      Bt.Width:=73;
      Bt.Caption:='Yes';
{Btn Nie}
      Bt:=TButton.Create(Pa);
      Bt.Parent:=TWinControl(Pa);
      Bt.Name:='No_'+IntToStr(Notebook.PageIndex-1);
      Bt.Top:=184;
      Bt.Left:=352;
      Bt.Height:=33;
      Bt.Width:=73;
      Bt.Caption:='Nie';
{Btn Confirm}
      Bt:=TButton.Create(Pa);
      Bt.Parent:=TWinControl(Pa);
      Bt.Name:='Cnf_'+IntToStr(Notebook.PageIndex-1);
      Bt.Top:=200;
      Bt.Left:=488;
      Bt.Height:=33;
      Bt.Width:=89;
      Bt.Caption:='PotwierdŸ';
      Bt.OnClick:=ConfirmBtnClick;
{
      GB:=TGroupBox.Create(Notebook);
      GB.Parent:=TWinControl(Notebook.Pages.Objects[Notebook.PageIndex]);
      GB.Top:=304;
      GB.Left:=16;
      GB.Height:=65;
      GB.Width:=185;
      GB.Caption:='Kryteria';
      SB:=TScrollBar.Create(GB);
      SB.Parent:=TWinControl(GB);
      SB.Top:=32;
      SB.Left:=24;
      SB.Height:=17;
      SB.Width:=121;
      SB.Min:=1;
      SB.Max:=KriteriumsTot;}
    end;
  Notebook.Pages.Delete(0);
  Notebook.PageIndex:=0;
  TabSet.Tabs:=Notebook.Pages;
Cnt:=0;
end;

procedure TOcenaDlg.KriteriaSBChange(Sender: TObject);
var
  L:TLabel;
begin
  L:=TLabel(Notebook.FindComponent('KLabel'+IntToStr(Notebook.PageIndex)));
  L.Caption:=IntToStr(12);
end;

procedure TOcenaDlg.TabSetClick(Sender: TObject);
begin
  Notebook.PageIndex:=TabSet.TabIndex;
end;

procedure TOcenaDlg.ScrollBar1Scroll(Sender: TObject;
  ScrollCode: TScrollCode; var ScrollPos: Integer);
var
  L:TLabel;
begin
  L:=TLabel(Notebook.FindComponent('KLabel'+IntToStr(Notebook.PageIndex)));
  L.Caption:=IntToStr(12);
end;

procedure TOcenaDlg.StrTo5Str(S:String; var SA:TKrArray);
var
  a:String;
  p:Byte;
  i:Byte;
begin
  for i:=1 to 5 do
    SA[i]:='';
  i:=1;
  while (Length(s)>0) and (i<6) do
    begin
      while (Length(SA[i])<KrLineLen) and (Length(s)>0) do
        begin
          p:=Pos(' ',s);
          if p>0
            then begin
              if Length(SA[i])+p>KrLineLen
                then Inc(i);
              SA[i]:=SA[i]+Copy(s,1,p);
              s:=Copy(s,p+1,Length(s)-p);
            end
            else begin
              if Length(SA[i])+Length(s)<=KrLineLen
                then SA[i]:=SA[i]+s
                else SA[i+1]:=s;
              s:='';
            end;
        end;
      Inc(i);
    end;
end;

procedure TOcenaDlg.SetPanel;
var
  i:Byte;
  Dsc:String;
  Wt:Byte;
  EM:Byte;
  PIS:String[8];
  KL:TKrArray;
  Comp:TComponent;
  Pnl:TPanel;
  La:TLabel;
  Bt:TButton;
  SE:TSpinEdit;
  CurTender:LongInt;
  CurKrit:LongInt;
begin
  PIS:=IntToStr(Notebook.PageIndex);
  CurTender:=MTable^[Notebook.PageIndex+1]^.CurTender;
  CurKrit:=MTable^[Notebook.PageIndex+1]^.CurKrit;
  Dsc:=TTable^[CurTender,CurKrit]^.KDesc;
  Wt:=TTable^[CurTender,CurKrit]^.KWeight;
  La:=TLabel(Notebook.FindComponent('Tnd'+PIS));
  La.Caption:=TenderS+IntToStr(CurTender);
  Comp:=Notebook.FindComponent('NPanel'+PIS);
  EM:=TTable^[CurTender,CurKrit]^.KEvalMode;
        La:=TLabel(Comp.FindComponent('LT_'+PIS));
        La.Caption:=TitleMaxMin;
        StrTo5Str(Dsc,KL);
        for i:=1 to 5 do
          begin
            La:=TLabel(Comp.FindComponent('L'+IntToStr(i)+'_'+PIS));
            La.Caption:=KL[i];
          end;
  case EM of
    evMin,
    evMax,
    evSubj:
      begin
        La:=TLabel(Comp.FindComponent('EM_'+PIS));
        case EM of
          evMax: La.Caption:=EvalModeStr+evMaxS;
          evMin: La.Caption:=EvalModeStr+evMinS;
          evSubj: La.Caption:=EvalModeStr+evSubjS;
        end;
        SE:=TSpinEdit(Comp.FindComponent('SE_'+PIS));
        SE.Visible:=TRUE;
        Bt:=TButton(Comp.FindComponent('Yes_'+PIS));
        Bt.Visible:=FALSE;
        Bt:=TButton(Comp.FindComponent('No_'+PIS));
        Bt.Visible:=FALSE;
      end;
    evYesNo:
      begin
        La:=TLabel(Comp.FindComponent('EM_'+PIS));
        La.Caption:=EvalModeStr+evYesNoS;
        SE:=TSpinEdit(Comp.FindComponent('SE_'+PIS));
        SE.Visible:=FALSE;
        Bt:=TButton(Comp.FindComponent('Yes_'+PIS));
        Bt.Visible:=TRUE;
        Bt:=TButton(Comp.FindComponent('No_'+PIS));
        Bt.Visible:=TRUE;
      end;
  end;{case}
end;

procedure TOcenaDlg.ConfirmBtnClick(Sender: TObject);
var
  CurTender:LongInt;
  CurKrit:LongInt;
begin
  CurTender:=MTable^[Notebook.PageIndex+1]^.CurTender;
  CurKrit:=MTable^[Notebook.PageIndex+1]^.CurKrit;
  Inc(CurKrit);
  if CurKrit>KriteriumsTot
    then begin
      CurKrit:=1;
      Inc(CurTender);

    end;
  MTable^[Notebook.PageIndex+1]^.CurTender:=CurTender;
  MTable^[Notebook.PageIndex+1]^.CurKrit:=CurKrit;
  if CurTender<=TenderTot
    then SetPanel;
end;

end.
