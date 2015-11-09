unit Kritedit;

interface

uses WinTypes, WinProcs, Classes, Graphics, Forms, Controls, Buttons,
  StdCtrls, ExtCtrls, Dialogs, SysUtils, WinCrt, 
  OfrtDta, SiwzIni, Utils,
  Msg;

type
  TKritEditDlg = class(TForm)
    OKBtn: TBitBtn;
    CancelBtn: TBitBtn;
    HelpBtn: TBitBtn;
    Panel2: TPanel;
    GB1: TGroupBox;
    DescLabel: TLabel;
    WagaLabel: TLabel;
    WagaEdit: TEdit;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    KritCB: TComboBox;
    EvalRG: TRadioGroup;
    WybGB: TGroupBox;
    Button1: TButton;
    Memo: TMemo;
    YesBtn: TButton;
    NoBtn: TButton;
    RepBtn: TButton;
    procedure DescEditChange(Sender: TObject);
    procedure WagaEditChange(Sender: TObject);
    procedure WagaEditKeyPress(Sender: TObject; var Key: Char);
    procedure YesRBClick(Sender: TObject);
    procedure NoRBClick(Sender: TObject);
    procedure OKBtnClick(Sender: TObject);
    procedure BackBtnClick(Sender: TObject);
    procedure HelpBtnClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure KritCBClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure YesBtnClick(Sender: TObject);
    procedure NoBtnClick(Sender: TObject);
    procedure RepBtnClick(Sender: TObject);
  private
    { Private declarations }
    QuestNum:Byte;
    EvalList:TStringList;
    function WeightsOk:Boolean;
    procedure LoadKritList;
    procedure SaveKritList;
  public
    { Public declarations }
    IsCena:Boolean;
    QNum:Byte;            {question number}
    KritEval:Byte;        {evaluation mode}
    Waga:Integer;         {wheight %}
    procedure SetQuestions(Num:Byte);
    procedure EditCena(Waga:String);
  end;

var
  KritEditDlg: TKritEditDlg;

implementation

{$R *.DFM}

procedure TKritEditDlg.DescEditChange(Sender: TObject);
var
  s:String;
  c:Integer;
begin
  if (QNum<4){not IsCena}
    then SetQuestions(1);
end;

procedure TKritEditDlg.WagaEditChange(Sender: TObject);
var
  s:String;
  c:Integer;
begin
  DescEditChange(Sender);
  s:=WagaEdit.Text;
  if s=''
    then Exit;
  Val(s,Waga,c);
  if c=0
    then begin
      if Waga>100
        then MessageDlg(wmValueOver100,mtWarning,[mbOk],0)
      else if Waga=0
        then MessageDlg(wmValueIs0,mtWarning,[mbOk],0);
    end
    else begin
      MessageDlg(wmValueUnknown,mtWarning,[mbOk],0);
    end;
  DescEditChange(Sender);
end;

procedure TKritEditDlg.SetQuestions(Num:Byte);
begin
{  QNum:=Num;
  case Num of
    1: begin
         Label1.Caption:=T1_1;
         Label2.Caption:=T1_2;
         Label3.Caption:='';
         Label4.Caption:='';
         Label5.Caption:='';
         Label6.Caption:='';
         YesRB.Checked:=FALSE;
         NoRB.Checked:=FALSE;
         KritEval:=0;
         EvalModeEdit.Text:='';
       end;
    2: begin
         Label1.Caption:=T2_1;
         Label2.Caption:=T2_2;
         Label3.Caption:=T2_3;
         Label4.Caption:=T2_4;
         Label5.Caption:=T2_5;
         Label6.Caption:=T2_6;
         YesRB.Checked:=FALSE;
         NoRB.Checked:=FALSE;
       end;
    3: begin
         Label1.Caption:=T3_1;
         Label2.Caption:=T3_2;
         Label3.Caption:='';
         Label4.Caption:='';
         Label5.Caption:='';
         Label6.Caption:='';
         YesRB.Checked:=FALSE;
         NoRB.Checked:=FALSE;
       end;
    4: begin
         if PrefKrajowe
           then Label1.Caption:=T4_1Y
           else Label1.Caption:=T4_1N;
         Label2.Caption:=T4_2;
         Label3.Caption:='';
         Label4.Caption:='';
         Label5.Caption:='';
         Label6.Caption:='';
       end;
    5: begin
         Label1.Caption:=T5_1;
         Label2.Caption:='';
         Label3.Caption:='';
         Label4.Caption:='';
         Label5.Caption:='';
         Label6.Caption:='';
         YesRB.Checked:=PrefKrajowe;
         NoRB.Checked:=not PrefKrajowe;
       end;
  end;}{case}
end;

procedure TKritEditDlg.WagaEditKeyPress(Sender: TObject; var Key: Char);
begin
  if not (Key in ['0'..'9',#8])
    then Key:=#0
end;

procedure TKritEditDlg.EditCena(Waga:String);
begin
  KritEval:=evMin; {must stay before DescEdit}
{  DescEdit.Text:=CenaStr;
  DescEdit.Enabled:=FALSE;
  WagaEdit.Text:=Waga;
  EvalModeEdit.Text:=evMinS;}
  SetQuestions(5);
end;


procedure TKritEditDlg.YesRBClick(Sender: TObject);
begin
  case QNum of
      1: begin
           SetQuestions(2);
           KritEval:=0;
         end;
      2: begin
           KritEval:=evMax;
{           EvalModeEdit.Text:=evMaxS;}
         end;
      3: begin
           KritEval:=evYesNo;
{           EvalModeEdit.Text:=evYesNoS;}
         end;
      4: begin
           SetQuestions(5);
         end;
      5: begin
           PrefKrajowe:=TRUE;
         end;
    end;{case}
end;

procedure TKritEditDlg.NoRBClick(Sender: TObject);
begin
  case QNum of
      1: begin
           SetQuestions(3)
         end;
      2: begin
           KritEval:=evMin;
         end;
      3: begin
           KritEval:=evSubj;
         end;
      5: begin
           PrefKrajowe:=FALSE;
         end;
    end;{case}
end;

function TKritEditDlg.WeightsOk:Boolean;
var
  x:LongInt;
begin
  x:=StrToInt(Label10.Caption);
  x:=x+StrToInt(WagaEdit.Text);
  Result:=x<=100;
end;

procedure TKritEditDlg.OKBtnClick(Sender: TObject);
begin
  if KritCB.Text=''
    then begin
      MessageDlg(wmDescEmpty,mtWarning,[mbOk],0);
      ModalResult:=0;
    end
  else if WagaEdit.Text=''
    then begin
      MessageDlg(wmValueUnknown,mtWarning,[mbOk],0);
      ModalResult:=0;
    end
  else if EvalRG.ItemIndex<0
    then begin
      MessageDlg(wmEvaluationUnknown,mtWarning,[mbOk],0);
      ModalResult:=0;
    end
  else if not WeightsOk
    then begin
      MessageDlg(wmWeightsSumOver100,mtWarning,[mbOk],0);
      ModalResult:=0;
    end
  else SaveKritList;
end;

procedure TKritEditDlg.BackBtnClick(Sender: TObject);
begin
  SetQuestions(1);
end;

procedure TKritEditDlg.HelpBtnClick(Sender: TObject);
begin
  Application.HelpContext(120);
end;

procedure TKritEditDlg.FormCreate(Sender: TObject);
begin
  EvalList:=TStringList.Create;
  LoadKritList;
  WybGB.Visible:=FALSE;
end;

procedure TKritEditDlg.LoadKritList;
var
  F:TextFile;
  s:String;
begin
  EvalList.Clear;
  KritCB.Items.Clear;
  try
    AssignFile(F,AddBackSlash(ProgramDir)+KrytListFile);
    Reset(F);
    try
      while not EOF(F) do
        begin
          ReadLn(F,s);
          if s<>''
            then begin
              EvalList.Add(s[1]);
              s:=Copy(s,2,Length(s)-1);
              KritCB.Items.Add(s);
            end;
        end;
    finally
      CloseFile(F);
    end;
  except
    on EInOutError do
      begin
      end;
  end;
end;

procedure TKritEditDlg.SaveKritList;
var
  F:TextFile;
  s:String;
  i,x:Integer;
begin
  try
    AssignFile(F,AddBackSlash(ProgramDir)+KrytListFile);
    Rewrite(F);
    try
      x:=KritCB.Items.IndexOf(KritCB.Text);
      if (KritCB.Text<>'') and (x>-1) and (EvalList[x]<>IntToStr(EvalRG.ItemIndex))
        then EvalList[x]:=IntToStr(EvalRG.ItemIndex);
      if (KritCB.Items.Count>0)
        then for i:=0 to KritCB.Items.Count-1 do
          WriteLn(F,EvalList[i]+KritCB.Items[i]);
      if (KritCB.Text<>'') and (x=-1)
        then begin
          WriteLn(F,IntToStr(EvalRG.ItemIndex)+KritCB.Text);
        end;
    finally
      CloseFile(F);
    end;
  except
    on EInOutError do
      begin
      end;
  end;
end;

procedure TKritEditDlg.FormDestroy(Sender: TObject);
begin
  EvalList.Free;
end;

procedure TKritEditDlg.KritCBClick(Sender: TObject);
var
  i:Integer;
begin
  i:=KritCB.Items.IndexOf(KritCB.Text);
  if i>-1
    then EvalRG.ItemIndex:=StrToInt(EvalList[i]);
end;

procedure TKritEditDlg.Button1Click(Sender: TObject);
begin
  Memo.Lines.Clear;
  Memo.Lines.Add(T1_1);
  Memo.Lines.Add(T1_2);
  Memo.Lines.Add(T1_3);
  QuestNum:=1;
  WybGB.Visible:=TRUE;
end;

procedure TKritEditDlg.YesBtnClick(Sender: TObject);
begin
  Memo.Lines.Clear;
  Memo.Lines.Add(T4_1+evArray[QuestNum]);
  case QuestNum of
    1: EvalRG.ItemIndex:=0; {max}
    2: EvalRG.ItemIndex:=1; {min}
    3: EvalRG.ItemIndex:=2; {tak-nie}
  end;{case}
end;

procedure TKritEditDlg.NoBtnClick(Sender: TObject);
begin
  EvalRG.ItemIndex:=-1;
  Memo.Lines.Clear;
  case QuestNum of
    1:begin
        Memo.Lines.Add(T2_1);
        Memo.Lines.Add(T2_2);
        Memo.Lines.Add(T2_3);
      end;
    2:begin
        Memo.Lines.Add(T3_1);
        Memo.Lines.Add(T3_2);
      end;
    3: begin
         EvalRG.ItemIndex:=3; {subj}
         Memo.Lines.Add(T4_1+evSubjS);
       end;
  end;{case}
  if QuestNum<3
    then Inc(QuestNum);

end;

procedure TKritEditDlg.RepBtnClick(Sender: TObject);
begin
  Memo.Lines.Clear;
  Memo.Lines.Add(T1_1);
  Memo.Lines.Add(T1_2);
  Memo.Lines.Add(T1_3);
  QuestNum:=1;
end;

end.
