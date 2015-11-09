unit User;

interface

uses WinTypes, WinProcs, Classes, Graphics, Forms, Controls, Buttons,
  StdCtrls, Grids, Esgrid, Dialogs,
  UserUnit,
  UserEdit;

const
{User strings}
  usAdministrator='Administrator';
  usUser='U¿ytkownik';

type
  TUserDlg = class(TForm)
    OKBtn: TBitBtn;
    Grid: TEnhStringGrid;
    AddBtn: TButton;
    EditBtn: TButton;
    DelBtn: TButton;
    procedure FormCreate(Sender: TObject);
    procedure DelBtnClick(Sender: TObject);
    procedure AddBtnClick(Sender: TObject);
    procedure EditBtnClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  UserDlg: TUserDlg;

implementation

{$R *.DFM}

procedure TUserDlg.FormCreate(Sender: TObject);
var
  x:Integer;
  i:LongInt;
  Ut:Byte;
  Prz:Byte;
begin
  with Grid do
    begin
      Cells[0,0]:='Nazwa';
      ColWidths[0]:=100;
      Cells[1,0]:='Rodzaj';
      ColWidths[1]:=100;
      x:=Canvas.TextWidth('Zam')+2;
      Cells[2,0]:='Nie';
      ColWidths[2]:=x;
      Cells[3,0]:='Ogr';
      ColWidths[3]:=x;
      Cells[4,0]:='Dwu';
      ColWidths[4]:=x;
      Cells[5,0]:='Neg';
      ColWidths[5]:=x;
      Cells[6,0]:='Zap';
      ColWidths[6]:=x;
      Cells[7,0]:='Zam';
      ColWidths[7]:=x;
      for i:=0 to UserList.Count-1 do
        begin
          if i>0
            then InsertRow(RowCount); {add lines to grid}
          Cells[0,i+1]:=UserList.GetName(i);
          Ut:=UserList.GetKind(Cells[0,i+1]);
          if Ut=utSupervisor
            then Cells[1,i+1]:=usAdministrator
          else if Ut=utUser
            then Cells[1,i+1]:=usUser;
          Prz:=UserList.GetRights(Cells[0,i+1]);
          if Prz and tNie=tNie
            then Cells[2,i+1]:=' X';
          if Prz and tOgr=tOgr
            then Cells[3,i+1]:=' X';
          if Prz and tDwu=tDwu
            then Cells[4,i+1]:=' X';
          if Prz and tNeg=tNeg
            then Cells[5,i+1]:=' X';
          if Prz and tZap=tZap
            then Cells[6,i+1]:=' X';
          if Prz and tZam=tZam
            then Cells[7,i+1]:=' X';
        end;
    end;
end;

procedure TUserDlg.DelBtnClick(Sender: TObject);
begin
  UserList.DeleteUser(Grid.Cells[0,Grid.Row]);
  Grid.DeleteRow(Grid.Row);
  if Grid.RowCount=1
    then Grid.InsertRow(1);
end;

procedure TUserDlg.AddBtnClick(Sender: TObject);
var
  x:Integer;
  Prz:Byte;
  Ut:Byte;
begin
  UserEditDlg:=TUserEditDlg.Create(Self);
  with UserEditDlg do
    begin
      NameEdit.Text:='';
      TypeCB.ItemIndex:=1;
      NieCB.Checked:=TRUE;
      OgrCB.Checked:=TRUE;
      DwuCB.Checked:=TRUE;
      NegCB.Checked:=TRUE;
      ZapCB.Checked:=TRUE;
      ZamCB.Checked:=TRUE;
      if ShowModal=mrOk
        then begin
          if UserList.AlreadyExists(NameEdit.Text)
            then MessageDlg('U¿ytkownik ju¿ istnieje',mtWarning,[mbOk],0)
            else begin
              x:=Grid.RowCount;
              Prz:=0;
              if (Grid.RowCount>2) or ((Grid.RowCount=2) and (Grid.Cells[0,1]<>''))
                then Grid.InsertRow(x)
                else x:=1;
              Grid.Cells[0,x]:=NameEdit.Text;
              Grid.Cells[1,x]:=TypeCB.Text;
              if TypeCB.Text=usAdministrator
                then ut:=utSupervisor
                else ut:=utUser;
              if NieCB.Checked
                then begin
                  Grid.Cells[2,x]:=' X';
                  Prz:=tNie;
                end;
              if OgrCB.Checked
                then begin
                  Grid.Cells[3,x]:=' X';
                  Prz:=Prz or tOgr;
                end;
              if DwuCB.Checked
                then begin
                  Grid.Cells[4,x]:=' X';
                  Prz:=Prz or tDwu;
                end;
              if NegCB.Checked
                then begin
                  Grid.Cells[5,x]:=' X';
                  Prz:=Prz or tNeg;
                end;
              if ZapCB.Checked
                then begin
                  Grid.Cells[6,x]:=' X';
                  Prz:=Prz or tZap;
                end;
              if ZamCB.Checked
                then begin
                  Grid.Cells[7,x]:=' X';
                  Prz:=Prz or tZam;
                end;
              UserList.AddUser(NameEdit.Text,'#'+NameEdit.Text[1],ut,Prz);
            end;
        end;
      Free;
    end;
end;

procedure TUserDlg.EditBtnClick(Sender: TObject);
var
  x:Integer;
  ut:Byte;
  Prz:Byte;
begin
  UserEditDlg:=TUserEditDlg.Create(Self);
  with UserEditDlg do
    begin
      x:=Grid.Row;
      NameEdit.Text:=Grid.Cells[0,x];
      TypeCB.ItemIndex:=TypeCB.Items.IndexOf(Grid.Cells[1,x]);
      NieCB.Checked:=Grid.Cells[2,x]=' X';
      OgrCB.Checked:=Grid.Cells[3,x]=' X';
      DwuCB.Checked:=Grid.Cells[4,x]=' X';
      NegCB.Checked:=Grid.Cells[5,x]=' X';
      ZapCB.Checked:=Grid.Cells[6,x]=' X';
      ZamCB.Checked:=Grid.Cells[7,x]=' X';
      if ShowModal=mrOk
        then begin
          Prz:=0;
          if NieCB.Checked
            then begin
              Grid.Cells[2,x]:=' X';
              Prz:=tNie;
            end
            else Grid.Cells[2,x]:='';
          if OgrCB.Checked
            then begin
              Grid.Cells[3,x]:=' X';
              Prz:=Prz or tOgr;
            end
            else Grid.Cells[3,x]:='';
          if DwuCB.Checked
            then begin
              Grid.Cells[4,x]:=' X';
              Prz:=Prz or tDwu;
            end
            else Grid.Cells[4,x]:='';
          if NegCB.Checked
            then begin
              Grid.Cells[5,x]:=' X';
              Prz:=Prz or tNeg;
            end
            else Grid.Cells[5,x]:='';
          if ZapCB.Checked
            then begin
              Grid.Cells[6,x]:=' X';
              Prz:=Prz or tZap;
            end
            else Grid.Cells[6,x]:='';
          if ZamCB.Checked
            then begin
              Grid.Cells[7,x]:=' X';
              Prz:=Prz or tZam;
            end
            else Grid.Cells[7,x]:='';
          if TypeCB.Text=usAdministrator
            then ut:=utSupervisor
            else ut:=utUser;
          Grid.Cells[1,x]:=TypeCB.Text;
          UserList.EditUser(Grid.Cells[0,x],NameEdit.Text,'#'+NameEdit.Text[1],ut,Prz);
          Grid.Cells[0,x]:=NameEdit.Text;
        end;
      Free;
    end;
end;

end.
