unit Useredit;

interface

uses WinTypes, WinProcs, Classes, Graphics, Forms, Controls, Buttons,
  StdCtrls, ExtCtrls;

type
  TUserEditDlg = class(TForm)
    OKBtn: TBitBtn;
    CancelBtn: TBitBtn;
    Bevel1: TBevel;
    Label1: TLabel;
    NameEdit: TEdit;
    Label2: TLabel;
    TypeCB: TComboBox;
    Label3: TLabel;
    GroupBox1: TGroupBox;
    NieCB: TCheckBox;
    OgrCb: TCheckBox;
    DwuCB: TCheckBox;
    NegCB: TCheckBox;
    ZapCB: TCheckBox;
    ZamCB: TCheckBox;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  UserEditDlg: TUserEditDlg;

implementation

{$R *.DFM}

end.
