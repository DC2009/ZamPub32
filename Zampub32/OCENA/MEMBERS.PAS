unit Members;

interface

uses WinTypes, WinProcs, Classes, Graphics, Forms, Controls, Buttons,
  StdCtrls, ExtCtrls, Dialogs, Messages,
  Msg,
  Pwd,
  OfrtDta, Grids;

const
  NCol=0;
  SCol=1;

type
  TMembersDlg = class(TForm)
    HelpBtn: TBitBtn;
    AddBtn: TButton;
    DeleteBtn: TButton;
    Bevel2: TBevel;
    OkBtn: TBitBtn;
    MSG: TStringGrid;
    CancelBtn: TBitBtn;
    procedure DeleteBtnClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure AddBtnClick(Sender: TObject);
    procedure MSGSetEditText(Sender: TObject; ACol, ARow: Longint;
      const Value: String);
    procedure OkBnClick(Sender: TObject);
    procedure HelpBtnClick(Sender: TObject);
    procedure MSGKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    Position:LongInt;  {Add or Edit member}
    MemberModified:Boolean;
    procedure SGRemoveLine;
  public
    { Public declarations }
  end;

var
  MembersDlg: TMembersDlg;

implementation

{$R *.DFM}

procedure TMembersDlg.FormCreate(Sender: TObject);
var
  i:LongInt;
begin
  MSG.Cells[NCol,0]:='Imiona';
  MSG.Cells[SCol,0]:='Nazwisko';
  MSG.RowCount:=2;
  if MNames.Count>0
    then for i:=0 to MNames.Count-1 do
      begin
        if i=MSG.RowCount-1
          then MSG.RowCount:=MSG.RowCount+1;
        MSG.Cells[NCol,i+1]:=MNames.Strings[i];
        MSG.Cells[SCol,i+1]:=MSurnames.Strings[i];
      end
    else begin
      MNames.Add('');
      MSurnames.Add('');
      MPwds.Add('');
    end;
  MemberModified:=FALSE;
end;

procedure TMembersDlg.SGRemoveLine;
var
  i:LongInt;
  GR:TGridRect;
begin
  if MSG.Selection.Top>0
    then begin
      for i:=MSG.Selection.Top to MSG.RowCount-1 do
        MSG.Rows[i]:=MSG.Rows[i+1];
      if MSG.RowCount>2
        then MSG.RowCount:=MSG.RowCount-1;
    end;
  GR.Top:=-1;
  GR.Bottom:=-1;
  GR.Left:=-1;
  GR.Right:=-1;
  MSG.Selection:=GR;
  MemberModified:=TRUE;
end;

procedure TMembersDlg.DeleteBtnClick(Sender: TObject);
begin
  if SuperPwd<>''
    then begin
      PwdDlg:=TPwdDlg.Create(Nil);
      if PwdDlg.ShowModal=mrOk
        then begin
          if PwdDlg.PwdEdit.Text=SuperPwd
            then SGRemoveLine
            else MessageDlg(wmIncorrectPwd,mtError,[mbOk],0);
        end;
      PwdDlg.Free;
    end
    else SGRemoveLine;
end;

procedure TMembersDlg.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key=#13
    then begin
      Key:=#0;
      Perform(wm_NextDlgCtl,0,0);
    end;
end;

procedure TMembersDlg.AddBtnClick(Sender: TObject);
begin
  MSG.RowCount:=MSG.RowCount+1;
end;

procedure TMembersDlg.MSGSetEditText(Sender: TObject; ACol, ARow: Longint;
  const Value: String);
begin
{  if ACol=NCol
    then MNames.Strings[ARow-1]:=Value
  else if ACol=SCol
    then MSurnames.Strings[ARow-1]:=Value;
  MPwds.Strings[ARow-1]:='';}
end;

procedure TMembersDlg.OkBnClick(Sender: TObject);
begin
  if not MemberModified
    then ModalResult:=mrCancel;
end;

procedure TMembersDlg.HelpBtnClick(Sender: TObject);
begin
  Application.HelpContext(110);
end;

procedure TMembersDlg.MSGKeyPress(Sender: TObject; var Key: Char);
begin
  MemberModified:=TRUE;
end;

end.
