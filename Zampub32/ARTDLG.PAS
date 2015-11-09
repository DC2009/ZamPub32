unit Artdlg;

interface

uses WinTypes, WinProcs, Classes, Graphics, Forms, Controls, Buttons,
  StdCtrls, ExtCtrls;

type
  TArticleDlg = class(TForm)
    OKBtn: TBitBtn;
    Bevel: TBevel;
    Memo: TMemo;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ArticleDlg: TArticleDlg;

implementation

{$R *.DFM}

end.
