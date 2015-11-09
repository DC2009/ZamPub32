unit Amount;

interface

uses
  WinTypes, WinProcs, Classes, Graphics, Forms, Controls, Buttons,
  StdCtrls, ExtCtrls, Dialogs, Spin, SiwzIni;

const
  mNoAmountEmpty='Kwota zamówienia nie mo¿e byæ pusta';

type
  TAmountDlg = class(TForm)
    OKBtn: TBitBtn;
    CancelBtn: TBitBtn;
    HelpBtn: TBitBtn;
    Bevel1: TBevel;
    EcuEdit1: TEdit;
    PLNEdit1: TEdit;
    EqualLabel: TLabel;
    EcuLabel1: TLabel;
    PLNLabel1: TLabel;
    EcuEdit2: TEdit;
    Label1: TLabel;
    PLNEdit2: TEdit;
    RateLabel: TLabel;
    PLNLabel3: TLabel;
    SpinButton1: TSpinButton;
    RateEdit: TEdit;
    PLNEdit: TEdit;
    ValueGB: TGroupBox;
    ValLabel7: TLabel;
    CheckIco: TImage;
    ValLabel3: TLabel;
    ValLabel2: TLabel;
    ValLabel1: TLabel;
    ValLabel6: TLabel;
    ValLabel5: TLabel;
    ValLabel4: TLabel;
    EcuEdit3: TEdit;
    Label2: TLabel;
    PLNEdit3: TEdit;
    procedure OKBtnClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure HelpBtnClick(Sender: TObject);
    procedure SpinButton1DownClick(Sender: TObject);
    procedure SpinButton1UpClick(Sender: TObject);
    procedure RateEditKeyPress(Sender: TObject; var Key: Char);
    procedure PLNEditKeyPress(Sender: TObject; var Key: Char);
    procedure RateEditChange(Sender: TObject);
    procedure PLNEditChange(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure RadioGroupClick(Sender: TObject);
    procedure NumInp1Change(Sender: TObject);
  private
    { Private declarations }
    procedure SetCheckIcoPos(Position:Byte);
  public
    { Public declarations }
    AmountLevel:Integer;
  end;


procedure GetPLNAmount(var PLN:Real; var Level:Integer); export;

implementation

{$R *.DFM}

uses
  SysUtils,
  Utils,
  IniFiles;

procedure GetPLNAmount(var PLN:Real; var Level:Integer);
var
  AmountDlg: TAmountDlg;
  l:Real;
  Code:Integer;
begin
  try
    GetAllConfiguration;
    Application.HelpFile:=SiwzHelpFile;
    AmountDlg:=TAmountDlg.Create(Nil);
    if AmountDlg.ShowModal=mrOk
      then begin
        Val(AmountDlg.PLNEdit.Text,l,Code);
        if Code=0
          then begin
            PLN:=l;
            Level:=AmountDlg.AmountLevel;
          end;
      end
      else begin
        PLN:=-1;
        Level:=-1;
      end;
    AmountDlg.Free;
  except
    on E:Exception do
      MessageDlg('B³¹d '+E.ClassName+' w S2XSCR.DLL', mtWarning, [mbOk],0);
  end;
end;



procedure TAmountDlg.SetCheckIcoPos(Position:Byte);
begin
  AmountLevel:=Position;
  ValLabel1.Font.Color:=clBlack;
  ValLabel2.Font.Color:=clBlack;
  ValLabel3.Font.Color:=clBlack;
  ValLabel4.Font.Color:=clBlack;
  ValLabel5.Font.Color:=clBlack;
  ValLabel6.Font.Color:=clBlack;
  ValLabel7.Font.Color:=clBlack;
  case Position of
    aLevel1:
       begin
         CheckIco.Top:=ValLabel1.Top-10;
         ValLabel1.Font.Color:=clRed;
       end;
    aLevel2:
       begin
         CheckIco.Top:=ValLabel2.Top-10;
         ValLabel2.Font.Color:=clRed;
       end;
    aLevel3:
       begin
         CheckIco.Top:=ValLabel3.Top-10;
         ValLabel3.Font.Color:=clRed;
       end;
    aLevel4:
       begin
         CheckIco.Top:=ValLabel4.Top-10;
         ValLabel4.Font.Color:=clRed;
       end;
    aLevel5:
       begin
         CheckIco.Top:=ValLabel5.Top-10;
         ValLabel5.Font.Color:=clRed;
       end;
    aLevel6:
       begin
         CheckIco.Top:=ValLabel6.Top-10;
         ValLabel6.Font.Color:=clRed;
       end;
    aLevel7:
       begin
         CheckIco.Top:=ValLabel7.Top-10;
         ValLabel7.Font.Color:=clRed;
       end;
  end;{case}
end;

procedure TAmountDlg.RateEditChange(Sender: TObject);
var
  x,y:Real;
  Code:Integer;
  s,s1:String;
begin
  if RateEdit.Text=''
    then begin
      SetCheckIcoPos(aLevel1);
      PLNEdit1.Text:='';
      PLNEdit2.Text:='';
    end
    else begin
      s1:=StripAllSpaces(RateEdit.Text);
      if s1[1]='.'
        then s1:='0'+s1;
      if s1[Length(s1)]='.'
        then s1:=s1+'0';
      Val(s1,x,Code);
      Str(x*200000:10:2,s);
      PLNEdit1.Text:=s;
      Str(x*30000:10:2,s);
      PLNEdit2.Text:=s;
      Str(x*3000:10:2,s);
      PLNEdit3.Text:=s;
      s:=StripAllSpaces(PLNEdit.Text);
      if (s<>'') and (x<>0)
        then begin
          if s[1]='.'
            then s:='0'+s;
          if s[Length(s)]='.'
            then s:=s+'0';
          Val(s,y,Code);
          if y<>0
            then y:=y/x;
          if y>200000
            then SetCheckIcoPos(aLevel7)
          else if y>100000
            then SetCheckIcoPos(aLevel6)
          else if y>50000
            then SetCheckIcoPos(aLevel5)
          else if y>30000
            then SetCheckIcoPos(aLevel4)
          else if y>20000
            then SetCheckIcoPos(aLevel3)
          else if y>3000
            then SetCheckIcoPos(aLevel2)
          else SetCheckIcoPos(aLevel1);
        end;
    end;
end;

procedure TAmountDlg.PLNEditChange(Sender: TObject);
var
  x,y:Real;
  Code:Integer;
  s,s1:String;
begin
  s:=StripAllSpaces(PLNEdit.Text);
  s1:=StripAllSpaces(RateEdit.Text);
  if (s='') or (s1='')
    then begin
      SetCheckIcoPos(aLevel1);
      PLNEdit1.Text:='';
      PLNEdit2.Text:='';
    end;
  if (s1<>'') and (s<>'') and (s1<>'.')
    then begin
      if s1[1]='.'
        then s1:='0'+s1;
      if s1[Length(s1)]='.'
        then s1:=s1+'0';
      Val(s1,x,Code);
      if s[1]='.'
        then s:='0'+s;
      if s[Length(s)]='.'
        then s:=s+'0';
      Val(s,y,Code);
      if (x<>0) and (y<>0)
        then begin
          y:=y/x;
          if y>200000
            then SetCheckIcoPos(aLevel7)
          else if y>100000
            then SetCheckIcoPos(aLevel6)
          else if y>50000
            then SetCheckIcoPos(aLevel5)
          else if y>30000
            then SetCheckIcoPos(aLevel4)
          else if y>20000
            then SetCheckIcoPos(aLevel3)
          else if y>3000
            then SetCheckIcoPos(aLevel2)
          else SetCheckIcoPos(aLevel1);
        end;
    end;
end;

procedure TAmountDlg.OKBtnClick(Sender: TObject);
var
  IniFile:TIniFile;
begin
  ModalResult:=0;
  if PLNEdit.Text=''
    then begin
      ShowMessage(mNoAmountEmpty);
      PLNEdit.SetFocus;
    end
    else begin
      ModalResult:=mrOk;
      try
        IniFile:=TIniFile.Create(SiwzIniName);{search in windows dir}
        try
          IniFile.WriteString('Values','ECU',RateEdit.Text);
        finally
          IniFile.Free;
        end;
      except
        on EInOutError do
          ShowMessage('Error opening '+SiwzIniName);
      end;
    end;
end;

procedure TAmountDlg.FormCreate(Sender: TObject);
var
  IniFile:TIniFile;
  s:String[6];
begin
  SetCheckIcoPos(aLevel1);
  try
    IniFile:=TIniFile.Create(SiwzIniName);{search in windows dir}
    try
      s:=IniFile.ReadString('Values','ECU','0');
      RateEdit.Text:=s;
    finally
      IniFile.Free;
    end;
  except
    on EInOutError do
      ShowMessage('Error opening '+SiwzIniName);
  end;
end;

procedure TAmountDlg.HelpBtnClick(Sender: TObject);
begin
  Application.HelpContext(2001);
  PLNEdit.SetFocus;
end;

procedure TAmountDlg.SpinButton1DownClick(Sender: TObject);
var
  r:Real;
  s:String[6];
  i:Integer;
begin
  s:=RateEdit.Text;
  s:=StripAllSpaces(s);
  Val(s,r,i);
  if r>0
    then r:=r-0.01;
  Str(r:5:2,s);
  RateEdit.Text:=s;
end;

procedure TAmountDlg.SpinButton1UpClick(Sender: TObject);
var
  r:Real;
  s:String[6];
  i:Integer;
begin
  s:=RateEdit.Text;
  s:=StripAllSpaces(s);
  Val(s,r,i);
  if r<99.99
    then r:=r+0.01;
  Str(r:5:2,s);
  RateEdit.Text:=s;
end;

procedure TAmountDlg.RateEditKeyPress(Sender: TObject; var Key: Char);
begin
  if not (Key in ['0'..'9','.',#8])
    then Key:=#0;
  if (Key in ['.']) and (Pos(Key,RateEdit.Text)>0)
    then Key:=#0;
end;

procedure TAmountDlg.PLNEditKeyPress(Sender: TObject; var Key: Char);
begin
  if not (Key in ['0'..'9','.',',',#8])
    then Key:=#0;
  if (Key in [','])
    then Key:='.';
  if (Key in ['.']) and (Pos(Key,PLNEdit.Text)>0)
    then Key:=#0;
end;

procedure TAmountDlg.FormActivate(Sender: TObject);
begin
  PLNEdit.SetFocus;
end;

procedure TAmountDlg.RadioGroupClick(Sender: TObject);
begin
  Exit;
end;

procedure TAmountDlg.NumInp1Change(Sender: TObject);
var
  x,y:Real;
  Code:Integer;
  s,s1:String;
begin
{  if RateEdit.Text=''
    then begin
      SetCheckIcoPos(alMin);
      PLNEdit1.Text:='';
      PLNEdit2.Text:='';
    end
    else begin
      x:=NumInp1.AsReal;
      Str(x*200000:10:2,s);
      PLNEdit1.Text:=s;
      Str(x*20000:10:2,s);
      PLNEdit2.Text:=s;
      s:=StripAllSpaces(PLNEdit.Text);
      if (s<>'') and (x<>0)
        then begin
          if s[1]='.'
            then s:='0'+s;
          if s[Length(s)]='.'
            then s:=s+'0';
          Val(s,y,Code);
          if y<>0
            then y:=y/x;
          if y>200000
            then SetCheckIcoPos(alHigh)
          else if y>20000
            then SetCheckIcoPos(alMedium)
          else if y>1000
            then SetCheckIcoPos(alLow)
          else SetCheckIcoPos(alMin);
        end;
    end;}
end;

end.



