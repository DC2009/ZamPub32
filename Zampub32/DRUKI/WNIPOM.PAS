unit Wnipom;

interface

uses WinTypes, WinProcs, Classes, Graphics, Forms, Controls, Buttons,
  StdCtrls, Dateedit, ExtCtrls, Mask, TabNotBk, Grids, Spin, SysUtils,
  Messages, Dialogs, Printers,
  Utils,
  ZpBoxes,
  RPrev, IntDate;

const
  WniosekFileHdr='ZP3WNI';

type
  TWniosekDlg = class(TForm)
    ScrollBox1: TScrollBox;
    Panel3: TPanel;
    Bevel5: TBevel;
    Label4: TLabel;
    Panel5: TPanel;
    Bevel6: TBevel;
    Label5: TLabel;
    Label5_1: TLabel;
    Panel6: TPanel;
    Bevel3: TBevel;
    Label6: TLabel;
    Panel11: TPanel;
    Panel2: TPanel;
    Bevel2: TBevel;
    Label2: TLabel;
    Memo2_6: TMemo;
    Panel12: TPanel;
    OKBtn: TBitBtn;
    CancelBtn: TBitBtn;
    PrintBtn: TBitBtn;
    PreviewBtn: TBitBtn;
    OpenBtn: TBitBtn;
    SaveBtn: TBitBtn;
    HelpBtn: TBitBtn;
    OpenDialog: TOpenDialog;
    SaveDialog: TSaveDialog;
    Panel1: TPanel;
    Bevel1: TBevel;
    Label11: TLabel;
    Label1_1: TLabel;
    Edit1_3: TEdit;
    Label1_4: TLabel;
    Edit1_5: TEdit;
    Label1_6: TLabel;
    Label2_1: TLabel;
    CB2_1: TCheckBox;
    CB2_2: TCheckBox;
    Combo2_1: TComboBox;
    CB2_3: TCheckBox;
    CB2_4: TCheckBox;
    Label2_4: TLabel;
    CB2_5: TCheckBox;
    Label2_5: TLabel;
    Panel22: TPanel;
    Bevel4: TBevel;
    Label22: TLabel;
    Label3_1: TLabel;
    Label3_2: TLabel;
    Label4_1: TLabel;
    Label4_2: TLabel;
    Label5_2: TLabel;
    Label6_1: TLabel;
    Label6_2: TLabel;
    CB1_2: TComboBox;
    Label1_8: TLabel;
    Label1_9: TLabel;
    Label1_10: TLabel;
    Label1_11: TLabel;
    Label4_3: TLabel;
    Label4_4: TLabel;
    Label4_5: TLabel;
    Label4_6: TLabel;
    Memo4_7: TMemo;
    Label4_8: TLabel;
    Label4_9: TLabel;
    Label4_10: TLabel;
    Label4_11: TLabel;
    Memo4_12: TMemo;
    Label4_13: TLabel;
    Label4_14: TLabel;
    Label4_15: TLabel;
    Label4_16: TLabel;
    Label4_17: TLabel;
    Memo5_3: TMemo;
    Label5_4: TLabel;
    Label5_5: TLabel;
    Label5_6: TLabel;
    Label5_7: TLabel;
    Label5_8: TLabel;
    Label5_9: TLabel;
    Label5_10: TLabel;
    Label5_11: TLabel;
    Label5_12: TLabel;
    Label5_13: TLabel;
    Label5_14: TLabel;
    Date1_7: TIntDate;
    procedure TimeEditExit(Sender: TObject);
    procedure NumEditKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure PreviewBtnClick(Sender: TObject);
    procedure PrintBtnClick(Sender: TObject);
    procedure OpenBtnClick(Sender: TObject);
    procedure SaveBtnClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure OKBtnClick(Sender: TObject);
    procedure HelpBtnClick(Sender: TObject);
  private
    { Private declarations }
    PPos:Integer;
    PrintSpace:Integer;
    Ry:TRyPrinter;
    FileName:String;
    FileIsOpen:Boolean;
    FHandle:File;
    procedure LoadFile;
    procedure SaveFile;
    procedure MakePrint;
    procedure MakeTitle(Ry:TRyPrinter; var PPos:Integer);
    function GetBox2Len(Ry:TRyPrinter):Integer;
    function GetBox3Len(Ry:TRyPrinter):Integer;
    function GetBox4Len(Ry:TRyPrinter):Integer;
    function GetBox5Len(Ry:TRyPrinter):Integer;
    function GetBox6Len(Ry:TRyPrinter):Integer;
    procedure MakeNewPage(Ry:TRyPrinter; var PPos,PSpace:Integer);
    procedure MakeBox0(Ry:TRyPrinter; var PPos:Integer);
    procedure MakeBox1(Ry:TRyPrinter; var PPos:Integer);
    procedure MakeBox2(Ry:TRyPrinter; var PPos:Integer);
    procedure MakeBox3(Ry:TRyPrinter; var PPos:Integer);
    procedure MakeBox4(Ry:TRyPrinter; var PPos:Integer);
    procedure MakeBox5(Ry:TRyPrinter; var PPos:Integer);
    procedure MakeBox6(Ry:TRyPrinter; var PPos:Integer);
  public
    { Public declarations }
  end;

var
  WniosekDlg: TWniosekDlg;

procedure Wniosek;export;

implementation

{$R *.DFM}

uses
  DrMsg,
  DateUtil;

procedure Wniosek;
var
  Cur:Integer;
begin
  Cur:=Screen.Cursor;
  Screen.Cursor:=crHourGlass;
  WniosekDlg:=TWniosekDlg.Create(Nil);
  Screen.Cursor:=Cur;
  WniosekDlg.ShowModal;
  WniosekDlg.Free;
end;

procedure TWniosekDlg.TimeEditExit(Sender: TObject);
var
  s:String[5];
  Err:Boolean;
begin
  if ActiveControl=CancelBtn
    then Exit;
  s:=TMaskEdit(Sender).Text;
  if not (s[1] in [' ','0','1','2'])
    then Err:=TRUE
  else begin
    case s[1] of
      ' ','0','1':
        begin
          if not (s[2] in ['0'..'9'])
            then Err:=TRUE;
        end;
      '2':
        begin
          if not (s[2] in ['0'..'3'])
            then Err:=TRUE;
        end;
    end {case}
  end;
  if (not (s[4] in ['0'..'5']))
    then Err:=TRUE;
  if Err
    then begin
      MessageDlg(wmTimeError,mtError,[mbOk],0);
      ActiveControl:=TMaskEdit(Sender);
    end;
end;

procedure TWniosekDlg.NumEditKeyPress(Sender: TObject; var Key: Char);
begin
  if not (Key in ['0'..'9',#8])
    then begin
      Key:=#0;
      MessageBeep(0);
    end;
end;

procedure TWniosekDlg.FormCreate(Sender: TObject);
begin
  Application.HelpFile:=HelpFileName;
  CB2_1.Checked:=TRUE;
  CB2_2.Checked:=TRUE;
  CB2_3.Checked:=TRUE;
  CB2_4.Checked:=TRUE;
  CB2_5.Checked:=TRUE;
end;

procedure TWniosekDlg.MakeBox0(Ry:TRyPrinter; var PPos:Integer);
var
  p:PChar;
  Rct:TRect;
  Tx:Integer;
  LP:Integer; {Line position}
  X:Integer;
begin
  with Ry do
    begin
      Rct.Left:=XLOff;
      Rct.Right:=XROff;
      Rct.Top:=PPos+Ymm(3);
      Tx:=Rct.Left+Xmm(15);
      Font.Size:=10;
      LP:=Rct.Top+Ymm(2);
      p:=StrAlloc(Length(Label0_1.Caption)+Length(Label0_2.Caption)+1);
      StrPCopy(p, Label0_1.Caption+Label0_2.Caption);
      X:=MemoOut(Rect(Tx,LP,Rct.Right-Xmm(3),100), p, False, False);
      LP:=LP+X+Ymm(1);
      StrDispose(p);
      Rct.Bottom:=LP+Ymm(1);
      RoundRectangle(Rct);
      Line(Point(Tx-Xmm(3),Rct.Top),Point(Tx-Xmm(3),Rct.Bottom));
      TextOutCenter(((Tx-Xmm(3)-Rct.Left) div 2)+Rct.Left,Rct.Top+Ymm(4),'1');
      PPos:=Rct.Bottom;;
    end;
end;

procedure TWniosekDlg.MakeBox1(Ry:TRyPrinter; var PPos:Integer);
var
  p:PChar;
  Rct:TRect;
  Tx:Integer;
  LP:Integer; {Line position}
  X:Integer;
begin
  with Ry do
    begin
      Rct.Left:=XLOff;
      Rct.Right:=XROff;
      Rct.Top:=PPos+Ymm(3);
      Tx:=Rct.Left+Xmm(15);
      Font.Size:=10;
      LP:=Rct.Top+Ymm(2);
      p:=StrAlloc(Length(Label1_1.Caption)+Length(CB1_2.Text)+Length(Edit1_3.Text)+Length(Label1_4.Caption)+
                  Length(Edit1_5.Text)+Length(Label1_6.Caption)+Length(DateEdit1_7.Text)+1);
      StrPCopy(p, Label1_1.Caption+CB1_2.Text+Edit1_3.Text+Label1_4.Caption+Edit1_5.Text+Label1_6.Caption+DateEdit1_7.Text);
      X:=MemoOut(Rect(Tx,LP,Rct.Right-Xmm(3),100), p, False, False);
      LP:=LP+X+Ymm(1);
      StrDispose(p);
      p:=StrAlloc(Length(Label1_8.Caption)+1);
      StrPCopy(p, Label1_8.Caption);
      X:=MemoOut(Rect(Tx,LP,Rct.Right-Xmm(3),100), p, False, False);
      LP:=LP+X+Ymm(1);
      StrDispose(p);
      p:=StrAlloc(Length(Label1_9.Caption)+Length(Label1_10.Caption)+1);
      StrPCopy(p, Label1_9.Caption+Label1_10.Caption);
      X:=MemoOut(Rect(Tx,LP,Rct.Right-Xmm(3),100), p, False, False);
      LP:=LP+X+Ymm(1);
      StrDispose(p);
      p:=StrAlloc(Length(Label1_11.Caption)+1);
      StrPCopy(p, Label1_11.Caption);
      X:=MemoOut(Rect(Tx,LP,Rct.Right-Xmm(3),100), p, False, False);
      LP:=LP+X+Ymm(1);
      StrDispose(p);
      Rct.Bottom:=LP+Ymm(1);
      RoundRectangle(Rct);
      Line(Point(Tx-Xmm(3),Rct.Top),Point(Tx-Xmm(3),Rct.Bottom));
      TextOutCenter(((Tx-Xmm(3)-Rct.Left) div 2)+Rct.Left,Rct.Top+Ymm(4),'1');
      PPos:=Rct.Bottom;;
    end;
end;

function TWniosekDlg.GetBox2Len(Ry:TRyPrinter):Integer;
var
  p:PChar;
  Rct:TRect;
  Tx:Integer;
  LP:Integer; {Line position}
  X:Integer;
begin
  with Ry do
    begin
      Rct.Right:=XROff;
      Tx:=XLOff+Xmm(15);
      Font.Size:=10;
      LP:=Ymm(2);
      p:=StrAlloc(Length(Label2_1.Caption)+1);
      StrPCopy(p, Label2_1.Caption);
      X:=MemoOut(Rect(Tx,LP,Rct.Right-Xmm(3),100), p, False, TRUE);
      LP:=LP+X+Ymm(1);
      StrDispose(p);
      if CB2_1.Checked
        then begin
          p:=StrAlloc(Length(CB2_1.Caption)+1);
          StrPCopy(p, CB2_1.Caption);
          X:=MemoOut(Rect(Tx,LP,Rct.Right-Xmm(3),100), p, False, TRUE);
          LP:=LP+X+Ymm(1);
          StrDispose(p);
        end;
      if CB2_2.Checked
        then begin
          p:=StrAlloc(Length(CB2_2.Caption)+Length(Combo2_1.Text)+1);
          StrPCopy(p, CB2_2.Caption+Combo2_1.Text);
          X:=MemoOut(Rect(Tx,LP,Rct.Right-Xmm(3),100), p, False, TRUE);
          LP:=LP+X+Ymm(1);
          StrDispose(p);
        end;
      if CB2_3.Checked
        then begin
          p:=StrAlloc(Length(CB2_3.Caption)+1);
          StrPCopy(p, CB2_3.Caption);
          X:=MemoOut(Rect(Tx,LP,Rct.Right-Xmm(3),100), p, False, TRUE);
          LP:=LP+X+Ymm(1);
          StrDispose(p);
        end;
      if CB2_4.Checked
        then begin
          p:=StrAlloc(Length(CB2_4.Caption)+Length(Label2_4.Caption)+1);
          StrPCopy(p, CB2_4.Caption+Label2_4.Caption);
          X:=MemoOut(Rect(Tx,LP,Rct.Right-Xmm(3),100), p, False, TRUE);
          LP:=LP+X+Ymm(1);
          StrDispose(p);
        end;
      if CB2_5.Checked
        then begin
          p:=StrAlloc(Length(CB2_5.Caption)+Length(Label2_5.Caption)+1);
          StrPCopy(p, CB2_5.Caption+Label2_5.Caption);
          X:=MemoOut(Rect(Tx,LP,Rct.Right-Xmm(3),100), p, False, TRUE);
          LP:=LP+X+Ymm(1);
          StrDispose(p);
        end;
      if Memo2_6.Text<>''
        then begin
          p:=StrAlloc(Memo2_6.GetTextLen + 1);
          Memo2_6.GetTextBuf(p, Memo2_6.GetTextLen+1);
          X:=MemoOut(Rect(Tx,LP,Rct.Right-Xmm(3),100), p, False, TRUE);
          LP:=LP+X+Ymm(1);
          StrDispose(p);
        end;
      LP:=LP+X+Ymm(1);
      Result:=LP+Ymm(1);
    end;
end;

procedure TWniosekDlg.MakeBox2(Ry:TRyPrinter; var PPos:Integer);
var
  p:PChar;
  Rct:TRect;
  Tx:Integer;
  LP:Integer; {Line position}
  X:Integer;
begin
  with Ry do
    begin
      Rct.Left:=XLOff;
      Rct.Right:=XROff;
      Rct.Top:=PPos+Ymm(3);
      Tx:=Rct.Left+Xmm(15);
      Font.Size:=10;
      LP:=Rct.Top+Ymm(2);
      p:=StrAlloc(Length(Label2_1.Caption)+1);
      StrPCopy(p, Label2_1.Caption);
      X:=MemoOut(Rect(Tx,LP,Rct.Right-Xmm(3),100), p, False, False);
      LP:=LP+X+Ymm(1);
      StrDispose(p);
      if CB2_1.Checked
        then begin
          p:=StrAlloc(Length(CB2_1.Caption)+1);
          StrPCopy(p, CB2_1.Caption);
          X:=MemoOut(Rect(Tx,LP,Rct.Right-Xmm(3),100), p, False, False);
          LP:=LP+X+Ymm(1);
          StrDispose(p);
        end;
      if CB2_2.Checked
        then begin
          p:=StrAlloc(Length(CB2_2.Caption)+Length(Combo2_1.Text)+1);
          StrPCopy(p, CB2_2.Caption+Combo2_1.Text);
          X:=MemoOut(Rect(Tx,LP,Rct.Right-Xmm(3),100), p, False, False);
          LP:=LP+X+Ymm(1);
          StrDispose(p);
        end;
      if CB2_3.Checked
        then begin
          p:=StrAlloc(Length(CB2_3.Caption)+1);
          StrPCopy(p, CB2_3.Caption);
          X:=MemoOut(Rect(Tx,LP,Rct.Right-Xmm(3),100), p, False, False);
          LP:=LP+X+Ymm(1);
          StrDispose(p);
        end;
      if CB2_4.Checked
        then begin
          p:=StrAlloc(Length(CB2_4.Caption)+Length(Label2_4.Caption)+1);
          StrPCopy(p, CB2_4.Caption+Label2_4.Caption);
          X:=MemoOut(Rect(Tx,LP,Rct.Right-Xmm(3),100), p, False, False);
          LP:=LP+X+Ymm(1);
          StrDispose(p);
        end;
      if CB2_5.Checked
        then begin
          p:=StrAlloc(Length(CB2_5.Caption)+Length(Label2_5.Caption)+1);
          StrPCopy(p, CB2_5.Caption+Label2_5.Caption);
          X:=MemoOut(Rect(Tx,LP,Rct.Right-Xmm(3),100), p, False, False);
          LP:=LP+X+Ymm(1);
          StrDispose(p);
        end;
      if Memo2_6.Text<>''
        then begin
          p:=StrAlloc(Memo2_6.GetTextLen + 1);
          Memo2_6.GetTextBuf(p, Memo2_6.GetTextLen+1);
          X:=MemoOut(Rect(Tx,LP,Rct.Right-Xmm(3),100), p, False, False);
          LP:=LP+X+Ymm(1);
          StrDispose(p);
        end;
      Rct.Bottom:=LP+Ymm(1);
      RoundRectangle(Rct);
      Line(Point(Tx-Xmm(3),Rct.Top),Point(Tx-Xmm(3),Rct.Bottom));
      TextOutCenter(((Tx-Xmm(3)-Rct.Left) div 2)+Rct.Left,Rct.Top+Ymm(4),'2');
      PPos:=Rct.Bottom;
    end;
end;

function TWniosekDlg.GetBox3Len(Ry:TRyPrinter):Integer;
var
  p:PChar;
  Rct:TRect;
  Tx:Integer;
  LP:Integer; {Line position}
  X:Integer;
begin
  with Ry do
    begin
      Rct.Right:=XROff;
      Tx:=XLOff+Xmm(15);
      Font.Size:=10;
      LP:=Ymm(2);
      p:=StrAlloc(Length(Label3_1.Caption)+Length(Label3_2.Caption)+1);
      StrPCopy(p,Label3_1.Caption+Label3_2.Caption);
      X:=MemoOut(Rect(Tx,LP,Rct.Right-Xmm(3),100), p, False, TRUE);
      LP:=LP+X+Ymm(1);
      StrDispose(p);
      Result:=LP+Ymm(1);
    end;
end;

procedure TWniosekDlg.MakeBox3(Ry:TRyPrinter; var PPos:Integer);
var
  p:PChar;
  Rct:TRect;
  Tx:Integer;
  LP:Integer; {Line position}
  X:Integer;
begin
  with Ry do
    begin
      Rct.Left:=XLOff;
      Rct.Right:=XROff;
      Rct.Top:=PPos+Ymm(3);
      Tx:=Rct.Left+Xmm(15);
      Font.Size:=10;
      LP:=Rct.Top+Ymm(2);
      p:=StrAlloc(Length(Label3_1.Caption)+Length(Label3_2.Caption)+1);
      StrPCopy(p,Label3_1.Caption+Label3_2.Caption);
      X:=MemoOut(Rect(Tx,LP,Rct.Right-Xmm(3),100), p, False, False);
      LP:=LP+X+Ymm(1);
      StrDispose(p);
      Rct.Bottom:=LP+Ymm(1);
      RoundRectangle(Rct);
      Line(Point(Tx-Xmm(3),Rct.Top),Point(Tx-Xmm(3),Rct.Bottom));
      TextOutCenter(((Tx-Xmm(3)-Rct.Left) div 2)+Rct.Left,Rct.Top+Ymm(2),'3');
      PPos:=Rct.Bottom;
    end;
end;

function TWniosekDlg.GetBox4Len(Ry:TRyPrinter):Integer;
var
  p:PChar;
  Rct:TRect;
  Tx:Integer;
  LP:Integer; {Line position}
  X:Integer;
begin
  with Ry do
    begin
      Rct.Right:=XROff;
      Tx:=XLOff+Xmm(15);
      Font.Size:=10;
      LP:=Ymm(2);
      p:=StrAlloc(Length(Label4_1.Caption)+1);
      StrPCopy(p,Label4_1.Caption);
      X:=MemoOut(Rect(Tx,LP,Rct.Right-Xmm(3),100), p, False, TRUE);
      LP:=LP+X+Ymm(1);
      StrDispose(p);
      p:=StrAlloc(Length(Label4_2.Caption)+Length(Label4_3.Caption)+1);
      StrPCopy(p,Label4_2.Caption+Label4_3.Caption);
      X:=MemoOut(Rect(Tx,LP,Rct.Right-Xmm(3),100), p, False, TRUE);
      LP:=LP+X+Ymm(1);
      StrDispose(p);
      p:=StrAlloc(Length(Label4_4.Caption)+Length(Label4_5.Caption)+1);
      StrPCopy(p,Label4_4.Caption+Label4_5.Caption);
      X:=MemoOut(Rect(Tx,LP,Rct.Right-Xmm(3),100), p, False, TRUE);
      LP:=LP+X+Ymm(1);
      StrDispose(p);
      p:=StrAlloc(Length(Label4_6.Caption)+1);
      StrPCopy(p,Label4_6.Caption);
      X:=MemoOut(Rect(Tx,LP,Rct.Right-Xmm(3),100), p, False, TRUE);
      LP:=LP+X;
      StrDispose(p);
      p:=StrAlloc(Memo4_7.GetTextLen+1);
      Memo4_7.GetTextBuf(p,Memo4_7.GetTextLen);
      X:=MemoOut(Rect(Tx,LP,Rct.Right-Xmm(3),100), p, False, TRUE);
      LP:=LP+X+Ymm(1);
      StrDispose(p);
      p:=StrAlloc(Length(Label4_8.Caption)+Length(Label4_9.Caption)+Length(Label4_10.Caption)+1);
      StrPCopy(p,Label4_8.Caption+Label4_9.Caption+Label4_10.Caption);
      X:=MemoOut(Rect(Tx,LP,Rct.Right-Xmm(3),100), p, False, TRUE);
      LP:=LP+X+Ymm(1);
      StrDispose(p);
      p:=StrAlloc(Length(Label4_11.Caption)+1);
      StrPCopy(p,Label4_11.Caption);
      X:=MemoOut(Rect(Tx,LP,Rct.Right-Xmm(3),100), p, False, TRUE);
      LP:=LP+X;
      StrDispose(p);
      p:=StrAlloc(Memo4_12.GetTextLen+1);
      Memo4_12.GetTextBuf(p,Memo4_12.GetTextLen);
      X:=MemoOut(Rect(Tx,LP,Rct.Right-Xmm(3),100), p, False, TRUE);
      LP:=LP+X+Ymm(1);
      StrDispose(p);
      p:=StrAlloc(Length(Label4_13.Caption)+Length(Label4_14.Caption)+Length(Label4_15.Caption)+1);
      StrPCopy(p,Label4_13.Caption+Label4_14.Caption+Label4_15.Caption);
      X:=MemoOut(Rect(Tx,LP,Rct.Right-Xmm(3),100), p, False, TRUE);
      LP:=LP+X+Ymm(1);
      StrDispose(p);
      p:=StrAlloc(Length(Label4_16.Caption)+Length(Label4_17.Caption)+1);
      StrPCopy(p,Label4_16.Caption+Label4_17.Caption);
      X:=MemoOut(Rect(Tx,LP,Rct.Right-Xmm(3),100), p, False, TRUE);
      LP:=LP+X+Ymm(1);
      StrDispose(p);
      Result:=LP+Ymm(1);
    end;
end;

procedure TWniosekDlg.MakeBox4(Ry:TRyPrinter; var PPos:Integer);
var
  p:PChar;
  Rct:TRect;
  Tx:Integer;
  LP:Integer; {Line position}
  X:Integer;
begin
  with Ry do
    begin
      Rct.Left:=XLOff;
      Rct.Right:=XROff;
      Rct.Top:=PPos+Ymm(3);
      Tx:=Rct.Left+Xmm(15);
      Font.Size:=10;
      LP:=Rct.Top+Ymm(2);
      p:=StrAlloc(Length(Label4_1.Caption)+1);
      StrPCopy(p,Label4_1.Caption);
      X:=MemoOut(Rect(Tx,LP,Rct.Right-Xmm(3),100), p, False, False);
      LP:=LP+X+Ymm(1);
      StrDispose(p);
      p:=StrAlloc(Length(Label4_2.Caption)+Length(Label4_3.Caption)+1);
      StrPCopy(p,Label4_2.Caption+Label4_3.Caption);
      X:=MemoOut(Rect(Tx,LP,Rct.Right-Xmm(3),100), p, False, False);
      LP:=LP+X+Ymm(1);
      StrDispose(p);
      p:=StrAlloc(Length(Label4_4.Caption)+Length(Label4_5.Caption)+1);
      StrPCopy(p,Label4_4.Caption+Label4_5.Caption);
      X:=MemoOut(Rect(Tx,LP,Rct.Right-Xmm(3),100), p, False, False);
      LP:=LP+X+Ymm(1);
      StrDispose(p);
      p:=StrAlloc(Length(Label4_6.Caption)+1);
      StrPCopy(p,Label4_6.Caption);
      X:=MemoOut(Rect(Tx,LP,Rct.Right-Xmm(3),100), p, False, False);
      LP:=LP+X;
      StrDispose(p);
      p:=StrAlloc(Memo4_7.GetTextLen+1);
      Memo4_7.GetTextBuf(p,Memo4_7.GetTextLen);
      X:=MemoOut(Rect(Tx,LP,Rct.Right-Xmm(3),100), p, False, False);
      LP:=LP+X+Ymm(1);
      StrDispose(p);
      p:=StrAlloc(Length(Label4_8.Caption)+Length(Label4_9.Caption)+Length(Label4_10.Caption)+1);
      StrPCopy(p,Label4_8.Caption+Label4_9.Caption+Label4_10.Caption);
      X:=MemoOut(Rect(Tx,LP,Rct.Right-Xmm(3),100), p, False, False);
      LP:=LP+X+Ymm(1);
      StrDispose(p);
      p:=StrAlloc(Length(Label4_11.Caption)+1);
      StrPCopy(p,Label4_11.Caption);
      X:=MemoOut(Rect(Tx,LP,Rct.Right-Xmm(3),100), p, False, False);
      LP:=LP+X;
      StrDispose(p);
      p:=StrAlloc(Memo4_12.GetTextLen+1);
      Memo4_12.GetTextBuf(p,Memo4_12.GetTextLen);
      X:=MemoOut(Rect(Tx,LP,Rct.Right-Xmm(3),100), p, False, False);
      LP:=LP+X+Ymm(1);
      StrDispose(p);
      p:=StrAlloc(Length(Label4_13.Caption)+Length(Label4_14.Caption)+Length(Label4_15.Caption)+1);
      StrPCopy(p,Label4_13.Caption+Label4_14.Caption+Label4_15.Caption);
      X:=MemoOut(Rect(Tx,LP,Rct.Right-Xmm(3),100), p, False, False);
      LP:=LP+X+Ymm(1);
      StrDispose(p);
      p:=StrAlloc(Length(Label4_16.Caption)+Length(Label4_17.Caption)+1);
      StrPCopy(p,Label4_16.Caption+Label4_17.Caption);
      X:=MemoOut(Rect(Tx,LP,Rct.Right-Xmm(3),100), p, False, False);
      LP:=LP+X+Ymm(1);
      StrDispose(p);
      Rct.Bottom:=LP+Ymm(1);
      RoundRectangle(Rct);
      Line(Point(Tx-Xmm(3),Rct.Top),Point(Tx-Xmm(3),Rct.Bottom));
      TextOutCenter(((Tx-Xmm(3)-Rct.Left) div 2)+Rct.Left,Rct.Top+Ymm(2),'4');
      PPos:=Rct.Bottom;
    end;
end;

function TWniosekDlg.GetBox5Len(Ry:TRyPrinter):Integer;
var
  p:PChar;
  Rct:TRect;
  Tx:Integer;
  LP:Integer; {Line position}
  X:Integer;
begin
  with Ry do
    begin
      Rct.Right:=XROff;
      Tx:=XLOff+Xmm(15);
      Font.Size:=10;
      LP:=Ymm(2);
      p:=StrAlloc(Length(Label5_1.Caption)+1);
      StrPCopy(p,Label5_1.Caption);
      X:=MemoOut(Rect(Tx,LP,Rct.Right-Xmm(3),100), p, False, TRUE);
      LP:=LP+X+Ymm(1);
      StrDispose(p);
      p:=StrAlloc(Length(Label5_2.Caption)+1);
      StrPCopy(p,Label5_2.Caption);
      X:=MemoOut(Rect(Tx,LP,Rct.Right-Xmm(3),100), p, False, TRUE);
      LP:=LP+X;
      StrDispose(p);
      p:=StrAlloc(Memo5_3.GetTextLen+1);
      Memo5_3.GetTextBuf(p,Memo5_3.GetTextLen);
      X:=MemoOut(Rect(Tx,LP,Rct.Right-Xmm(3),100), p, False, TRUE);
      LP:=LP+X+Ymm(1);
      StrDispose(p);
      p:=StrAlloc(Length(Label5_4.Caption)+Length(Label5_5.Caption)+1);
      StrPCopy(p,Label5_4.Caption+Label5_5.Caption);
      X:=MemoOut(Rect(Tx,LP,Rct.Right-Xmm(3),100), p, False, TRUE);
      LP:=LP+X+Ymm(1);
      StrDispose(p);
      Result:=LP+Ymm(1);
      p:=StrAlloc(Length(Label5_6.Caption)+Length(Label5_7.Caption)+Length(Label5_8.Caption)+Length(Label5_9.Caption)+1);
      StrPCopy(p,Label5_6.Caption+Label5_7.Caption+Label5_8.Caption+Label5_9.Caption);
      X:=MemoOut(Rect(Tx,LP,Rct.Right-Xmm(3),100), p, False, TRUE);
      LP:=LP+X+Ymm(1);
      StrDispose(p);
      p:=StrAlloc(Length(Label5_10.Caption)+Length(Label5_11.Caption)+1);
      StrPCopy(p,Label5_10.Caption+Label5_11.Caption);
      X:=MemoOut(Rect(Tx,LP,Rct.Right-Xmm(3),100), p, False, TRUE);
      LP:=LP+X+Ymm(1);
      StrDispose(p);
      p:=StrAlloc(Length(Label5_12.Caption)+Length(Label5_13.Caption)+Length(Label5_14.Caption)+1);
      StrPCopy(p,Label5_12.Caption+Label5_13.Caption+Label5_14.Caption);
      X:=MemoOut(Rect(Tx,LP,Rct.Right-Xmm(3),100), p, False, TRUE);
      LP:=LP+X+Ymm(1);
      StrDispose(p);
      Result:=LP+Ymm(1);
    end;
end;

procedure TWniosekDlg.MakeBox5(Ry:TRyPrinter; var PPos:Integer);
var
  p:PChar;
  Rct:TRect;
  Tx:Integer;
  LP:Integer; {Line position}
  X:Integer;
begin
  with Ry do
    begin
      Rct.Left:=XLOff;
      Rct.Right:=XROff;
      Rct.Top:=PPos+Ymm(3);
      Tx:=Rct.Left+Xmm(15);
      Font.Size:=10;
      LP:=Rct.Top+Ymm(2);
      p:=StrAlloc(Length(Label5_1.Caption)+1);
      StrPCopy(p,Label5_1.Caption);
      X:=MemoOut(Rect(Tx,LP,Rct.Right-Xmm(3),100), p, False, False);
      LP:=LP+X+Ymm(1);
      StrDispose(p);
      p:=StrAlloc(Length(Label5_2.Caption)+1);
      StrPCopy(p,Label5_2.Caption);
      X:=MemoOut(Rect(Tx,LP,Rct.Right-Xmm(3),100), p, False, False);
      LP:=LP+X;
      StrDispose(p);
      p:=StrAlloc(Memo5_3.GetTextLen+1);
      Memo5_3.GetTextBuf(p,Memo5_3.GetTextLen);
      X:=MemoOut(Rect(Tx,LP,Rct.Right-Xmm(3),100), p, False, False);
      LP:=LP+X+Ymm(1);
      StrDispose(p);
      p:=StrAlloc(Length(Label5_4.Caption)+Length(Label5_5.Caption)+1);
      StrPCopy(p,Label5_4.Caption+Label5_5.Caption);
      X:=MemoOut(Rect(Tx,LP,Rct.Right-Xmm(3),100), p, False, False);
      LP:=LP+X+Ymm(1);
      StrDispose(p);
      p:=StrAlloc(Length(Label5_6.Caption)+Length(Label5_7.Caption)+Length(Label5_8.Caption)+Length(Label5_9.Caption)+1);
      StrPCopy(p,Label5_6.Caption+Label5_7.Caption+Label5_8.Caption+Label5_9.Caption);
      X:=MemoOut(Rect(Tx,LP,Rct.Right-Xmm(3),100), p, False, False);
      LP:=LP+X+Ymm(1);
      StrDispose(p);
      p:=StrAlloc(Length(Label5_10.Caption)+Length(Label5_11.Caption)+1);
      StrPCopy(p,Label5_10.Caption+Label5_11.Caption);
      X:=MemoOut(Rect(Tx,LP,Rct.Right-Xmm(3),100), p, False, False);
      LP:=LP+X+Ymm(1);
      StrDispose(p);
      p:=StrAlloc(Length(Label5_12.Caption)+Length(Label5_13.Caption)+Length(Label5_14.Caption)+1);
      StrPCopy(p,Label5_12.Caption+Label5_13.Caption+Label5_14.Caption);
      X:=MemoOut(Rect(Tx,LP,Rct.Right-Xmm(3),100), p, False, False);
      LP:=LP+X+Ymm(1);
      StrDispose(p);
      Rct.Bottom:=LP+Ymm(1);
      RoundRectangle(Rct);
      Line(Point(Tx-Xmm(3),Rct.Top),Point(Tx-Xmm(3),Rct.Bottom));
      TextOutCenter(((Tx-Xmm(3)-Rct.Left) div 2)+Rct.Left,Rct.Top+Ymm(4),'5');
      PPos:=Rct.Bottom;
    end;
end;

function TWniosekDlg.GetBox6Len(Ry:TRyPrinter):Integer;
var
  p:PChar;
  Rct:TRect;
  Tx:Integer;
  LP:Integer; {Line position}
  X:Integer;
begin
  with Ry do
    begin
      Rct.Right:=XROff;
      Tx:=XLOff+Xmm(15);
      Font.Size:=10;
      LP:=Ymm(2);
      p:=StrAlloc(Length(Label6_1.Caption)+Length(Label6_2.Caption)+1);
      StrPCopy(p,Label6_1.Caption+Label6_2.Caption);
      X:=MemoOut(Rect(Tx,LP,Rct.Right-Xmm(3),100), p, False, TRUE);
      LP:=LP+X+Ymm(1);
      StrDispose(p);
      Result:=LP+Ymm(1);
    end;
end;

procedure TWniosekDlg.MakeBox6(Ry:TRyPrinter; var PPos:Integer);
var
  p,q:PChar;
  Rct:TRect;
  Tx:Integer;
  LP:Integer; {Line position}
  X:Integer;
begin
  with Ry do
    begin
      Rct.Left:=XLOff;
      Rct.Right:=XROff;
      Rct.Top:=PPos+Ymm(3);
      Tx:=Rct.Left+Xmm(15);
      Font.Size:=10;
      LP:=Rct.Top+Ymm(2);
      p:=StrAlloc(Length(Label6_1.Caption)+Length(Label6_2.Caption)+1);
      StrPCopy(p,Label6_1.Caption+Label6_2.Caption);
      X:=MemoOut(Rect(Tx,LP,Rct.Right-Xmm(3),100), p, False, False);
      LP:=LP+X+Ymm(1);
      StrDispose(p);
      Rct.Bottom:=LP+Ymm(1);
      RoundRectangle(Rct);
      Line(Point(Tx-Xmm(3),Rct.Top),Point(Tx-Xmm(3),Rct.Bottom));
      TextOutCenter(((Tx-Xmm(3)-Rct.Left) div 2)+Rct.Left,Rct.Top+Ymm(4),'6');
      PPos:=Rct.Bottom;
    end;
end;

procedure TWniosekDlg.MakeNewPage(Ry:TRyPrinter; var PPos,PSpace:Integer);
begin
  with Ry do
    begin
      NewPage;
      MakeTitle(Ry,PPos);
      PSpace:=YBOff-Ymm(35);
      MakeFooter(Ry,PSpace);
    end;
end;

procedure TWniosekDlg.MakeTitle(Ry:TRyPrinter; var PPos:Integer);
var
  x:Integer;
  s:String;
begin
  with Ry do
    begin
      Font.Name:='Times New Roman CE';
      Font.Size:=8;
      PPos:=YTOff;
      TextOut(XLOff,YTOff,'numer sprawy _________________');
      Font.Size:=14;
      TextOutRight(XROff,PPos,'str. '+IntToStr(CurrentPage));
      PPos:=PPos+TextHeight+Ymm(4);
      Font.Size:=14;
      s:=Self.Caption;
      x:=MemoOut(Rect(XLOff+Xmm(5),PPos+TextHeight+Ymm(2),XROff-Xmm(5),10),StringAsPChar(s),FALSE,FALSE);
      PPos:=PPos+TextHeight+Ymm(5)+x;
    end;
end;

procedure TWniosekDlg.MakePrint;
var
  p,q,r:PChar;
begin
    with Ry do
      begin
        NewJob;
        SetMinMargins(Xmm(20),Ymm(10),Xmm(20),Ymm(10));
        MakeTitle(Ry,PPos);
        PrintSpace:=YBOff-Ymm(35);
        MakeFooter(Ry,PrintSpace);
        MakeBox1(Ry,PPos);
        if GetBox2Len(Ry)+PPos+Ymm(3)>PrintSpace
          then MakeNewPage(Ry,PPos,PrintSpace);
        MakeBox2(Ry,PPos);
        if GetBox3Len(Ry)+PPos+Ymm(3)>PrintSpace
          then MakeNewPage(Ry,PPos,PrintSpace);
        MakeBox3(Ry,PPos);
        if GetBox4Len(Ry)+PPos+Ymm(3)>PrintSpace
          then MakeNewPage(Ry,PPos,PrintSpace);
        MakeBox4(Ry,PPos);
        if GetBox5Len(Ry)+PPos+Ymm(3)>PrintSpace
          then MakeNewPage(Ry,PPos,PrintSpace);
        MakeBox5(Ry,PPos);
        if GetBox6Len(Ry)+PPos+Ymm(3)>PrintSpace
          then MakeNewPage(Ry,PPos,PrintSpace);
        MakeBox6(Ry,PPos);
      end;
end;

procedure TWniosekDlg.PreviewBtnClick(Sender: TObject);
var
  Cur:Integer;
begin
  Cur:=Screen.Cursor;
  Screen.Cursor:=crHourGlass;
  Printer.Free;
  Printer:=TPrinter.Create;
  Printer.Orientation:=poPortrait;
  try
    Ry:=TRyPrinter.Create;
    MakePrint;
    Screen.Cursor:=Cur;
    Ry.Preview;
  finally
    Ry.Free;
    Screen.Cursor:=Cur;
  end;
end;

procedure TWniosekDlg.PrintBtnClick(Sender: TObject);
var
  Cur:Integer;
begin
  Cur:=Screen.Cursor;
  Screen.Cursor:=crHourGlass;
  Printer.Free;
  Printer:=TPrinter.Create;
  Printer.Orientation:=poPortrait;
  try
    Ry:=TRyPrinter.Create;
    MakePrint;
    Ry.PrintIt;
    Screen.Cursor:=Cur;
  finally
    Ry.Free;
    Screen.Cursor:=Cur;
  end;
end;

procedure TWniosekDlg.SaveFile;
var
  s:String;
  FO:Boolean;
begin
  FO:=FileIsOpen;
  if FO
    then CloseFile(FHandle);
  AssignFile(FHandle,FileName);
  FileMode:=fmOpenReadWrite + fmShareDenyWrite;
  try
    Rewrite(FHandle,1);
    try
      MakeFKey(ExtractFilePath(FileName));
      SaveString(WniosekFileHdr,FHandle);
      SaveInteger(FKey,FHandle);
      SaveInteger(CB1_2.ItemIndex,FHandle);
      SaveEdit(Edit1_3,FHandle);
      SaveEdit(Edit1_5,FHandle);
      SaveDateEdit(DateEdit1_7,FHandle);
      SaveBoolean(CB2_1.Checked,FHandle);
      SaveBoolean(CB2_2.Checked,FHandle);
      SaveInteger(Combo2_1.ItemIndex,FHandle);
      SaveBoolean(CB2_3.Checked,FHandle);
      SaveBoolean(CB2_4.Checked,FHandle);
      SaveBoolean(CB2_5.Checked,FHandle);
      SaveMemo(Memo2_6,FHandle);
      SaveMemo(Memo4_7,FHandle);
      SaveMemo(Memo4_12,FHandle);
      SaveMemo(Memo5_3,FHandle);
    finally
      if not FileIsOpen
        then begin
          CloseFile(FHandle);
          FileIsOpen:=FALSE;
        end;
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

procedure TWniosekDlg.LoadFile;
var
  s:String;
  i:Integer;
  b:Boolean;
begin
  if FileIsOpen
    then MessageDlg(wmFileAlreadyLoaded,mtWarning,[mbOk],0)
    else begin
      AssignFile(FHandle,FileName);
      FileMode:=fmOpenReadWrite + fmShareDenyWrite;
      try
        Reset(FHandle,1);
        FileIsOpen:=TRUE;
        MakeFKey(ExtractFilePath(FileName));
        LoadString(s,FHandle);
        if s=WniosekFileHdr
          then begin
            LoadInteger(i,FHandle);
            if i=FKey
              then begin
                LoadInteger(i,FHandle);
                CB1_2.ItemIndex:=i;
                LoadEdit(Edit1_3,FHandle);
                LoadEdit(Edit1_5,FHandle);
                LoadDateEdit(DateEdit1_7,FHandle);
                LoadBoolean(b,FHandle);
                CB2_1.Checked:=b;
                LoadBoolean(b,FHandle);
                CB2_2.Checked:=b;
                LoadInteger(i,FHandle);
                Combo2_1.ItemIndex:=i;
                LoadBoolean(b,FHandle);
                CB2_3.Checked:=b;
                LoadBoolean(b,FHandle);
                CB2_4.Checked:=b;
                LoadBoolean(b,FHandle);
                CB2_5.Checked:=b;
                LoadMemo(Memo2_6,FHandle);
                LoadMemo(Memo4_7,FHandle);
                LoadMemo(Memo4_12,FHandle);
                LoadMemo(Memo5_3,FHandle);
              end
              else begin
                MessageDlg(wmSecurityCode,mtWarning,[mbOk],0);
                CloseFile(FHandle);
                FileIsOpen:=FALSE;
              end;
          end
          else begin
            MessageDlg(wmNotAZP,mtWarning,[mbOk],0);
            CloseFile(FHandle);
            FileIsOpen:=FALSE;
          end;
      except
        on E:EInOutError do
          begin
            case E.ErrorCode of
              5: MessageDlg(wmFileAccessDenied ,mtWarning ,[mbOk] ,0);
              100: MessageDlg(wmReadBeyondEnd ,mtWarning ,[mbOk] ,0);
              else MessageDlg(IntToStr(E.ErrorCode),mtWarning,[mbOk],0);
            end;
            if FileIsOpen
              then begin
                CloseFile(FHandle);
                FileIsOpen:=FALSE;
              end;
          end;
      end;
    end;
end;

procedure TWniosekDlg.OpenBtnClick(Sender: TObject);
begin
  if OpenDialog.Execute
    then begin
      if FileName<>OpenDialog.FileName
        then if FileIsOpen
          then begin
            CloseFile(FHandle);
            FileIsOpen:=FALSE;
          end;
      FileName:=OpenDialog.FileName;
      if FileExists(FileName)
        then LoadFile;
    end;
end;

procedure TWniosekDlg.SaveBtnClick(Sender: TObject);
begin
  if SaveDialog.Execute
    then begin
      if FileName<>SaveDialog.FileName
        then if FileIsOpen
          then begin
            CloseFile(FHandle);
            FileIsOpen:=FALSE;
          end;
      FileName:=SaveDialog.FileName;
      SaveFile;
    end;
end;

procedure TWniosekDlg.FormDestroy(Sender: TObject);
begin
  if FileIsOpen
    then begin
      CloseFile(FHandle);
      FileIsOpen:=FALSE;
    end;
end;

procedure TWniosekDlg.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key=#13
    then begin
      Key:=#0;
      Perform(wm_NextDlgCtl,0,0);
    end;
end;

procedure TWniosekDlg.OKBtnClick(Sender: TObject);
var
  x:Integer;
begin
  x:=MessageDlg(wmSaveOnExit,mtWarning,[mbYes,mbNo,mbCancel],0);
  case x of
    mrYes: begin
             SaveBtnClick(Sender);
             ModalResult:=mrOk;
           end;
    mrNo: ModalResult:=mrCancel;
    mrCancel: ModalResult:=0;
  end;{case}
end;

procedure TWniosekDlg.HelpBtnClick(Sender: TObject);
begin
  Application.HelpContext(401);
end;

end.

