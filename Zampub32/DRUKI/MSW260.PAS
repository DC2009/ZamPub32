unit Msw260;

interface

uses WinTypes, WinProcs, Classes, Graphics, Forms, Controls, Buttons,
  StdCtrls, ExtCtrls, Mask, TabNotBk, Grids, Spin, SysUtils,
  Messages, Dialogs, Printers,
  Utils,
  SiwzIni,
  ZpBoxes,
  UserUnit,
  SkOk,
  RPrev, IntDate, Sk, NumInp;

const
  Msw260FileHdr='ZP3MSW260';
  PageBottomSpace=35;

type
  TMsw260Dlg = class(TForm)
    ScrollBox1: TScrollBox;
    TitlePanel: TPanel;
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
    LabelT_1: TLabel;
    Panel1: TPanel;
    Bevel1: TBevel;
    Label11: TLabel;
    Label1_1: TLabel;
    Panel22: TPanel;
    Bevel4: TBevel;
    Label22: TLabel;
    Label3_1: TLabel;
    Label3_2: TLabel;
    Label4_1: TLabel;
    Label4_2: TLabel;
    Label5_3: TLabel;
    Label6_1: TLabel;
    LabelT_2: TLabel;
    Label4_3: TLabel;
    Label4_4: TLabel;
    Label4_6: TLabel;
    Label4_8: TLabel;
    Label5_4: TLabel;
    Label5_5: TLabel;
    Label5_6: TLabel;
    NumLabel: TLabel;
    NumEdit: TEdit;
    Sk: TSmartKey;
    NieRB: TRadioButton;
    OgrRb: TRadioButton;
    DwuRB: TRadioButton;
    NegRB: TRadioButton;
    ZamRB: TRadioButton;
    Bevel7: TBevel;
    Label2_1: TLabel;
    Label2_2: TLabel;
    Bevel8: TBevel;
    Label2_3: TLabel;
    Bevel9: TBevel;
    Bevel11: TBevel;
    Label2_5: TLabel;
    Bevel12: TBevel;
    Label2_6: TLabel;
    Label2_7: TLabel;
    Bevel13: TBevel;
    Label2_8: TLabel;
    Label2_9: TLabel;
    Label2_4: TLabel;
    NEdit2_11: TNumInp;
    NEdit2_12: TNumInp;
    CB2_13: TCheckBox;
    NEdit2_15: TNumInp;
    NEdit2_16: TNumInp;
    Label2_14: TLabel;
    CB2_17: TCheckBox;
    Nedit2_18: TNumInp;
    NEdit2_19: TNumInp;
    CB2_20: TCheckBox;
    NEdit2_21: TNumInp;
    NEdit2_22: TNumInp;
    Label3_4: TLabel;
    Date3_3: TIntDate;
    Date3_5: TIntDate;
    Date4_7: TIntDate;
    Edit4_5: TEdit;
    Edit4_9: TEdit;
    NEdit5_2: TNumInp;
    NEdit5_7: TNumInp;
    NEdit5_8: TNumInp;
    NEdit5_9: TNumInp;
    Panel4: TPanel;
    Bevel10: TBevel;
    Label7: TLabel;
    Label7_1: TLabel;
    Panel7: TPanel;
    Bevel14: TBevel;
    Label8: TLabel;
    Label8_1: TLabel;
    RB8_2: TRadioButton;
    RB8_3: TRadioButton;
    NEdit7_3: TNumInp;
    CB7_4: TComboBox;
    Grid6_2: TStringGrid;
    Panel0: TPanel;
    Label0_1: TLabel;
    Memo0_3: TMemo;
    Label0_2: TLabel;
    Label0_4: TLabel;
    Edit0_6: TEdit;
    Label0_5: TLabel;
    MaskEdit0_7: TMaskEdit;
    Label0_8: TLabel;
    Edit0_11: TEdit;
    Label0_9: TLabel;
    Edit0_12: TEdit;
    Label0_10: TLabel;
    Edit0_13: TEdit;
    Label0_14: TLabel;
    MaskEdit0_15: TMaskEdit;
    Label0_21: TLabel;
    NipGB: TGroupBox;
    RB0_17: TRadioButton;
    RB0_18: TRadioButton;
    MaskEdit0_20: TMaskEdit;
    MaskEdit0_19: TMaskEdit;
    Bevel15: TBevel;
    Memo0_22: TMemo;
    Label0_22: TLabel;
    Label7_2: TLabel;
    CB7_5: TCheckBox;
    Memo7_6: TMemo;
    CB2_10: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure PreviewBtnClick(Sender: TObject);
    procedure PrintBtnClick(Sender: TObject);
    procedure OpenBtnClick(Sender: TObject);
    procedure SaveBtnClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure OKBtnClick(Sender: TObject);
    procedure HelpBtnClick(Sender: TObject);
    procedure RB0_17Click(Sender: TObject);
    procedure RB0_18Click(Sender: TObject);
    procedure CB2_10Click(Sender: TObject);
    procedure CB2_13Click(Sender: TObject);
    procedure CB2_17Click(Sender: TObject);
    procedure CB2_20Click(Sender: TObject);
    procedure CB7_5Click(Sender: TObject);
  private
    { Private declarations }
    PPos:Integer;
    PrintSpace:Integer;
    Ry:TRyPrinter;
    FileName:String;
    FileIsOpen:Boolean;
    FilePwd:String;
    FHandle:File;
    procedure LoadFile;
    procedure SaveFile;
    procedure MakeHeader(Ry:TRyPrinter; var PPos:Integer);
    procedure MakeFooter(Ry:TRyPrinter; APSpace:Integer);
    procedure MakeNewPage(Ry:TRyPrinter; var PPos:Integer);
    procedure MakePrint;
    procedure MakeBox0(Ry:TRyPrinter; var PPos:Integer);
    procedure MakeBox1(Ry:TRyPrinter; var PPos:Integer);
    procedure MakeBox2(Ry:TRyPrinter; var PPos:Integer);
    procedure MakeBox3_4(Ry:TRyPrinter; var PPos:Integer);
    procedure MakeBox5(Ry:TRyPrinter; var PPos:Integer);
    procedure MakeBox6(Ry:TRyPrinter; var PPos:Integer);
    procedure MakeBox7(Ry:TRyPrinter; var PPos:Integer);
    procedure MakeBox8(Ry:TRyPrinter; var PPos:Integer);
    function GetBox5Len(Ry:TRyPrinter):Integer;
    function GetBox6Len(Ry:TRyPrinter):Integer;
    function GetBox7Len(Ry:TRyPrinter):Integer;
    function GetBox8Len(Ry:TRyPrinter):Integer;
  public
    { Public declarations }
  end;

var
  Msw260Dlg: TMsw260Dlg;

procedure Msw260p;export;

implementation

{$R *.DFM}

uses
  DrMsg,
  DateUtil;

procedure Msw260p;
var
  Cur:Integer;
begin
  Cur:=Screen.Cursor;
  Screen.Cursor:=crHourGlass;
  Msw260Dlg:=TMsw260Dlg.Create(Nil);
  Screen.Cursor:=Cur;
{  Msw260Dlg.ScrollBox1.ScrollInView(Msw260Dlg.LabelT_1);
  Msw260Dlg.ScrollBox1.VertScrollBar.Position:=0;  }
  Msw260Dlg.ShowModal;
  Msw260Dlg.Free;
end;

procedure TMsw260Dlg.FormCreate(Sender: TObject);
begin
  Application.HelpFile:=RapHelpFile;
  Grid6_2.Cells[0,0]:='Kryteria';
  Grid6_2.Cells[1,0]:='Wagi';
  FilePwd:=LoadFilePwd(AddBackSlash(ProgramDir)+SecurityFileName);
  RB0_17Click(Sender);
  CB2_10Click(Sender);
  CB2_13Click(Sender);
  CB2_17Click(Sender);
  CB2_20Click(Sender);
  CB7_5Click(Sender);
end;

procedure TMsw260Dlg.MakeBox0(Ry:TRyPrinter; var PPos:Integer);
var
  p1:PChar;
  A,X,Y,Z1,Z2:Integer;
  s:String;
begin
  with Ry do
    begin
      Y:=PPos;
      PPos:=PPos+Ymm(1);
      A:=XROff-(XROff-XLOff) div 2 -Xmm(5);
      {left title}
      p1:=StrAlloc(Length(Label0_1.Caption)+1);
      StrPCopy(p1, Label0_1.Caption);
      X:=MemoOut(Rect(XLOff+Xmm(1),PPos,A-Xmm(1),10), p1, False, False);
      Z1:=PPos+X;
      StrDispose(p1);
      {right title}
      p1:=StrAlloc(Length(Label0_21.Caption)+1);
      StrPCopy(p1, Label0_21.Caption);
      X:=MemoOut(Rect(A+Xmm(1),PPos,XROff-Xmm(1),10), p1, False, False);
      Z2:=PPos+X;
      StrDispose(p1);
      {left texts}
      Font.Style:=[];
      p1:=StrAlloc(Memo0_3.GetTextLen + 1);
      Memo0_3.GetTextBuf(p1, Memo0_3.GetTextLen+1);
      X:=MemoOut(Rect(XLOff+Xmm(1),Z1,A-Xmm(1),10), p1, False, False);
      Z1:=Z1+X;
      StrDispose(p1);
      p1:=StrAlloc(Length(Edit0_6.Text)+Length(MaskEdit0_7.Text)+3);
      StrPCopy(p1, Edit0_6.Text+'  '+MaskEdit0_7.Text);
      X:=MemoOut(Rect(XLOff+Xmm(1),Z1,A-Xmm(1),10), p1, False, False);
      Z1:=Z1+X;
      StrDispose(p1);
      p1:=StrAlloc(Length(Edit0_11.Text)+Length(Edit0_12.Text)+Length(Edit0_13.Text)+9);
      StrPCopy(p1, Edit0_11.Text+' '+Edit0_12.Text+' pokój '+Edit0_13.Text);
      X:=MemoOut(Rect(XLOff+Xmm(1),Z1,A-Xmm(1),10), p1, False, False);
      Z1:=Z1+X;
      StrDispose(p1);
      s:='';
      if RB0_17.Checked
        then s:=MaskEdit0_19.Text;
      if RB0_18.Checked
        then s:=MaskEdit0_20.Text;
      p1:=StrAlloc(Length(NipGB.Caption)+Length(s)+Length(Label0_14.Caption)+Length(MaskEdit0_15.Text)+4);
      StrPCopy(p1, NipGB.Caption+s+'  '+Label0_14.Caption+MaskEdit0_15.Text);
      X:=MemoOut(Rect(XLOff+Xmm(1),Z1,A-Xmm(1),10), p1, False, False);
      Z1:=Z1+X;
      StrDispose(p1);
      {right text}
      p1:=StrAlloc(Memo0_22.GetTextLen + 1);
      Memo0_22.GetTextBuf(p1, Memo0_22.GetTextLen+1);
      X:=MemoOut(Rect(A+Xmm(1),Z2,XROff-Xmm(1),10), p1, False, False);
      Z2:=Z2+X;
      StrDispose(p1);
      if Z1>Z2
        then PPos:=Z1+Ymm(1)
        else PPos:=Z2+Ymm(1);
      Line(Point(XLOff,Y),Point(XLOff,PPos));
      Line(Point(XROff,Y),Point(XROff,PPos));
      Line(Point(A,Y),Point(A,PPos));
      Line(Point(XLOff,PPos),Point(XROff,PPos));
{      PPos:=PPos+Ymm(1);}
    end;
end;

procedure TMsw260Dlg.MakeBox1(Ry:TRyPrinter; var PPos:Integer);
var
  p1:PChar;
  s:String;
  X,Y:Integer;
begin
  with Ry do
    begin
      Y:=PPos;
      PPos:=PPos+Ymm(1);
      if NieRB.Checked
        then s:='1.1 '+NieRb.Caption
      else if OgrRB.Checked
        then s:='1.2 '+OgrRb.Caption
      else if DwuRB.Checked
        then s:='1.3 '+DwuRb.Caption
      else if NegRB.Checked
        then s:='1.4 '+NegRb.Caption
      else if ZamRB.Checked
        then s:='1.5 '+ZamRb.Caption
      else s:='';
      Font.Style:=[fsBold];
      p1:=StrAlloc(Length(Label1_1.Caption)+Length(s)+5);
      StrPCopy(p1, '1  '+Label1_1.Caption+s);
      X:=MemoOut(Rect(XLOff+Xmm(1),PPos,XROff-Xmm(1),10), p1, False, False);
      PPos:=PPos+X+Ymm(1);
      StrDispose(p1);
      Line(Point(XLOff,Y),Point(XLOff,PPos));
      Line(Point(XROff,Y),Point(XROff,PPos));
      Line(Point(XLOff,PPos),Point(XROff,PPos));
    end;
end;

procedure TMsw260Dlg.MakeBox2(Ry:TRyPrinter; var PPos:Integer);
var
  p1,p2:PChar;
  A,B,C,X,Y,Y1,Y2,Z1,Z2:Integer;
begin
  with Ry do
    begin
      Y:=PPos;
      PPos:=PPos+Ymm(1);
      A:=XROff-(TextWidth(Label2_5.Caption)+Xmm(5));
      p1:=StrAlloc(Length(Label2_1.Caption)+Length(Label2_2.Caption)+4);
      StrPCopy(p1, '2  '+Label2_1.Caption+Label2_2.Caption);
      p2:=StrAlloc(Length(Label2_5.Caption)+1);
      StrPCopy(p2, Label2_5.Caption);
      {header}
      Z1:=PPos;
      Z2:=PPos;
      {if (PPos+TextHeight*3+Ymm(3))>printSpace then NewPage};
      TextOut(XLOff+Xmm(1),Z1,'2  Rodzaj robót budowlanych wed³ug Europejskiej');
      Z1:=Z1+TextHeight;
      TextOut(XLOff+Xmm(1),Z1,'    Klasyfikacji Dzia³alnoœci');
      Z1:=Z1+TextHeight;
      Line(Point(XLOff,Z1+Ymm(1)),Point(A,Z1+Ymm(1)));
      TextOut(A+Xmm(1),Z2,' Wartoœæ robót budowlanych w tys. z³');
      Z2:=Z2+TextHeight;
      Line(Point(A,Z2+Ymm(1)),Point(XROff,Z2+Ymm(1)));
      Y1:=Z1+Ymm(1);
      Y2:=Z2+Ymm(1);
      Z1:=Z1+Ymm(2);
      Z2:=Z2+Ymm(2);
      TextOut(XLOff+Xmm(1),Z1,Label2_3.Caption);
      B:=XLOff+TextWidth(Label2_3.Caption)+Ymm(2);
      TextOut(B+Xmm(10), Z1,Label2_4.Caption);
      Z1:=Z1+TextHeight+Ymm(1);
      Line(Point(XLOff,Z1+Ymm(1)),Point(XROff,Z1+Ymm(1)));
      C:=A+(XROff-A) div 2;
      TextOut(A+Xmm(1),Z2,'wed³ug kosztorysu');
      TextOut(C+Xmm(1),Z2,'wynikaj¹ca z ');
      Z2:=Z2+TextHeight;
      TextOut(A+Xmm(1),Z2,'inwestorskiego');
      TextOut(C+Xmm(1),Z2,'wybranej oferty');
      Z2:=Z2+TextHeight;
      {Checkboxes}
      Z1:=Z1+Ymm(2);
      Font.Style:=[];
      if CB2_10.Checked
        then begin
          TextOut(XLOff+Xmm(7),Z1,'45.1');
          TextOut(B+Ymm(1),Z1,'Przygotowanie terenu pod budowê');
          TextOutRight(C-Ymm(1),Z1,NEdit2_11.Text);
          TextOutRight(XROff-Ymm(1),Z1,NEdit2_12.Text);
          Z1:=Z1+TextHeight+Ymm(1);
        end;
      if CB2_13.Checked
        then begin
          TextOut(XLOff+Xmm(7),Z1,'45.2');
          TextOutRight(C-Ymm(1),Z1,NEdit2_15.Text);
          TextOutRight(XROff-Ymm(1),Z1,NEdit2_16.Text);
          p1:=StrAlloc(Length('Wznoszenie kompletnych budowli lub ich czêœci; in¿ynieria l¹dowa i wodna')+1);
          StrPCopy(p1, 'Wznoszenie kompletnych budowli lub ich czêœci; in¿ynieria l¹dowa i wodna');
          X:=MemoOut(Rect(B+Xmm(1),Z1,A-Xmm(1),10), p1, False, False);
          StrDispose(p1);
          Z1:=Z1+X+Ymm(1);
        end;
      if CB2_17.Checked
        then begin
          TextOut(XLOff+Xmm(7),Z1,'45.3');
          TextOutRight(C-Ymm(1),Z1,NEdit2_18.Text);
          TextOutRight(XROff-Ymm(1),Z1,NEdit2_19.Text);
          p1:=StrAlloc(Length('Wykonywanie instalacji budowlanych')+1);
          StrPCopy(p1, 'Wykonywanie instalacji budowlanych');
          X:=MemoOut(Rect(B+Xmm(1),Z1,A-Xmm(1),10), p1, False, False);
          StrDispose(p1);
          Z1:=Z1+X+Ymm(1);
        end;
      if CB2_20.Checked
        then begin
          TextOut(XLOff+Xmm(7),Z1,'45.4');
          TextOutRight(C-Ymm(1),Z1,NEdit2_21.Text);
          TextOutRight(XROff-Ymm(1),Z1,NEdit2_22.Text);
          p1:=StrAlloc(Length('Budowlane prace wykoñczeniowe')+1);
          StrPCopy(p1, 'Budowlane prace wykoñczeniowe');
          X:=MemoOut(Rect(B+Xmm(1),Z1,A-Xmm(1),10), p1, False, False);
          StrDispose(p1);
          Z1:=Z1+X+Ymm(1);
        end;
      if not (CB2_10.Checked or CB2_13.Checked or CB2_17.Checked or CB2_20.Checked)
         then Z1:=Z1+Ymm(25);
      PPos:=Z1+Ymm(1);
      Line(Point(XLOff,Y),Point(XLOff,PPos));
      Line(Point(XROff,Y),Point(XROff,PPos));
      Line(Point(A,Y),Point(A,PPos));
      Line(Point(B,Y1),Point(B,PPos));
      Line(Point(C,Y2),Point(C,PPos));
      Line(Point(XLOff,PPos),Point(XROff,PPos));
    end;
end;

procedure TMsw260Dlg.MakeBox3_4(Ry:TRyPrinter; var PPos:Integer);
var
  p1:PChar;
  s:String;
  A,L,X,Y,Z1:Integer;
begin
  with Ry do
    begin
      Y:=PPos;
      PPos:=PPos+Ymm(1);
      Z1:=PPos;
      L:=TextWidth(Label3_2.Caption);
      A:=XLOff+L+TextWidth(Date3_3.Text)+Xmm(10);
      Font.Style:=[fsBold];
      {headers}
      TextOut(XLOff+Xmm(1),PPos,'3  Data');
      TextOut(A+Xmm(1),PPos,'4');
      p1:=StrAlloc(Length(Label4_1.Caption)+1);
      StrPCopy(p1, Label4_1.Caption);
      X:=MemoOut(Rect(A+Xmm(4),PPos,XROff-Xmm(1),10), p1, False, False);
      StrDispose(p1);
      Z1:=Z1+X+Ymm(2);
      PPos:=PPos+TextHeight+Ymm(3);
      {fields of 3}
      Font.Style:=[];
      TextOut(XLOff+Xmm(1),PPos,Label3_2.Caption);
      TextOut(XLOff+L+Xmm(5),PPos,Date3_3.Text);
      PPos:=PPos+TextHeight+Ymm(1);
      TextOut(XLOff+Xmm(1),PPos,Label3_4.Caption);
      TextOut(XLOff+L+Xmm(5),PPos,Date3_5.Text);
      PPos:=PPos+TextHeight+Ymm(1);
      {fields of 4}
      if (Edit4_5.Text<>'') and (Date4_7.Text<>'') and (Edit4_9.Text<>'')
        then begin
          s:='4.1 Numer '+Edit4_5.Text+' z dnia '+Date4_7.Text;
          p1:=StrAlloc(Length(s)+1);
          StrPCopy(p1, s);
          X:=MemoOut(Rect(A+Xmm(1),Z1,XROff-Xmm(1),10), p1, False, False);
          StrDispose(p1);
          Z1:=Z1+X+Ymm(1);
          s:='4.2 Pozycja '+Edit4_9.Text;
          p1:=StrAlloc(Length(s)+1);
          StrPCopy(p1, s);
          X:=MemoOut(Rect(A+Xmm(1),Z1,XROff-Xmm(1),10), p1, False, False);
          StrDispose(p1);
          Z1:=Z1+X+Ymm(1);
        end;
      if PPos<Z1
        then PPos:=Z1;

      Line(Point(XLOff,Y),Point(XLOff,PPos));
      Line(Point(XROff,Y),Point(XROff,PPos));
      Line(Point(A,Y),Point(A,PPos));
      Line(Point(XLOff,PPos),Point(XROff,PPos));
    end;
end;

function TMsw260Dlg.GetBox5Len(Ry:TRyPrinter):Integer;
begin
  with Ry do
    Result:=TextHeight*3+Ymm(5);
end;

procedure TMsw260Dlg.MakeBox5(Ry:TRyPrinter; var PPos:Integer);
var
  p1:PChar;
  A,B,C,L,X,Y,Y1:integer;
begin
  with Ry do
    begin
      Y:=PPos;
      PPos:=PPos+Ymm(1);
      {headers}
      Font.Style:=[fsBold];
      L:=TextWidth(Label5_6.Caption)+Xmm(1);
      C:=XROff-L;
      B:=C-L;
      A:=B-L;
      TextOut(XLOff+Xmm(1),PPos,'5  '+Label5_1.Caption);
      TextOutCenter(A+(XROff-A) div 2,PPos,Label5_3.Caption);
      PPos:=PPos+TextHeight+Ymm(1);
      Y1:=PPos;
      Line(Point(A,Y1),Point(XROff,Y1));
      PPos:=PPos+Ymm(1);
      TextOutCenter(A+(B-A) div 2,PPos,Label5_4.Caption);
      TextOutCenter(B+(C-B) div 2,PPos,Label5_5.Caption);
      TextOutCenter(C+(XROff-C) div 2,PPos,Label5_6.Caption);
      PPos:=PPos+TextHeight+Ymm(1);
      Line(Point(A,PPos),Point(XROff,PPos));
      PPos:=PPos+Ymm(1);
      {fields}
      Font.Style:=[];
      TextOutCenter(XLOff+(A-XLoff) div 2,Y1+Ymm(2),NEdit5_2.Text);
      TextOutRight(B-Xmm(1),PPos,NEdit5_7.Text);
      TextOutRight(C-Xmm(1),PPos,NEdit5_8.Text);
      TextOutRight(XROff-Xmm(1),PPos,NEdit5_9.Text);

      PPos:=PPos+TextHeight+Ymm(1);
      Line(Point(XLOff,Y),Point(XLOff,PPos));
      Line(Point(XROff,Y),Point(XROff,PPos));
      Line(Point(A,Y),Point(A,PPos));
      Line(Point(B,Y1),Point(B,PPos));
      Line(Point(C,Y1),Point(C,PPos));
      Line(Point(XLOff,PPos),Point(XROff,PPos));
    end;
end;

function TMsw260Dlg.GetBox6Len(Ry:TRyPrinter):Integer;
var
  i,X,Y:Integer;
  s:String;
  p1:PChar;
begin
  with Ry do
    begin
      Y:=0;
      for i:=1 to Grid6_2.RowCount-1 do
        if Grid6_2.Cells[0,i]<>''
          then begin
            s:=Grid6_2.Cells[0,i]+' - waga '+Grid6_2.Cells[1,i]+'%';
            p1:=StrAlloc(Length(s)+1);
            StrPCopy(p1, s);
            X:=MemoOut(Rect(XLOff+Xmm(3),PPos,XROff-Xmm(1),10), p1, False, TRUE);
            StrDispose(p1);
            Y:=Y+X+Ymm(1);
          end;
      Result:=Y+TextHeight+Ymm(3);
    end;
end;

procedure TMsw260Dlg.MakeBox6(Ry:TRyPrinter; var PPos:Integer);
var
  p1:PChar;
  i,X,Y:Integer;
  s:String;
begin
  with Ry do
    begin
      Y:=PPos;
      PPos:=PPos+Ymm(1);
      {headers}
      Font.Style:=[fsBold];
      TextOut(XLOff+Xmm(1),PPos,'6  '+Label6_1.Caption);
      PPos:=PPos+TextHeight+Ymm(2);
      {criteria}
      Font.Style:=[];
      for i:=1 to Grid6_2.RowCount-1 do
        if Grid6_2.Cells[0,i]<>''
          then begin
            s:=Grid6_2.Cells[0,i]+' - waga '+Grid6_2.Cells[1,i]+'%';
            p1:=StrAlloc(Length(s)+1);
            StrPCopy(p1, s);
            X:=MemoOut(Rect(XLOff+Xmm(3),PPos,XROff-Xmm(1),10), p1, False, False);
            StrDispose(p1);
            PPos:=PPos+X+Ymm(1);
          end;
      Line(Point(XLOff,Y),Point(XLOff,PPos));
      Line(Point(XROff,Y),Point(XROff,PPos));
      Line(Point(XLOff,PPos),Point(XROff,PPos));
    end;
end;

function TMsw260Dlg.GetBox7Len(Ry:TRyPrinter):Integer;
var
  p1:PChar;
  s:String;
  X:Integer;
begin
  with Ry do
    begin
      s:=Label7_2.Caption+NEdit7_3.Text+' '+CB7_4.Text;
      p1:=StrAlloc(Length(s)+1);
      StrPCopy(p1, s);
      X:=MemoOut(Rect(XLOff+Xmm(3),PPos,XROff-Xmm(1),10), p1, False, True);
      StrDispose(p1);
      if CB7_5.Checked
        then begin
          p1:=StrAlloc(Memo7_6.GetTextLen + 1);
          Memo7_6.GetTextBuf(p1, Memo7_6.GetTextLen+1);
          X:=X+MemoOut(Rect(XLOff+Xmm(7),PPos,XROff-Xmm(1),10), p1, False, True);
          StrDispose(p1);
        end;
      Result:=TextHeight*2+Ymm(4)+X;
    end;
end;

procedure TMsw260Dlg.MakeBox7(Ry:TRyPrinter; var PPos:Integer);
var
  p1:PChar;
  X,Y:Integer;
  s:String;
begin
  with Ry do
    begin
      Y:=PPos;
      PPos:=PPos+Ymm(1);
      {headers}
      Font.Style:=[fsBold];
      TextOut(XLOff+Xmm(1),PPos,'7  '+Label7_1.Caption);
      PPos:=PPos+TextHeight+Ymm(2);
      {fields}
      Font.Style:=[];
      s:=Label7_2.Caption+NEdit7_3.Text+' '+CB7_4.Text;
      p1:=StrAlloc(Length(s)+1);
      StrPCopy(p1, s);
      X:=MemoOut(Rect(XLOff+Xmm(3),PPos,XROff-Xmm(1),10), p1, False, False);
      StrDispose(p1);
      PPos:=PPos+X+Ymm(1);
      if CB7_5.Checked
        then begin
          TextOut(XLOff+Xmm(3),PPos,'7.2 Inne');
          PPos:=PPos+TextHeight;
          p1:=StrAlloc(Memo7_6.GetTextLen + 1);
          Memo7_6.GetTextBuf(p1, Memo7_6.GetTextLen+1);
          X:=MemoOut(Rect(XLOff+Xmm(7),PPos,XROff-Xmm(1),10), p1, False, False);
          PPos:=PPos+X+Ymm(1);
          StrDispose(p1);
        end;
      Line(Point(XLOff,Y),Point(XLOff,PPos));
      Line(Point(XROff,Y),Point(XROff,PPos));
      Line(Point(XLOff,PPos),Point(XROff,PPos));
    end;
end;

function TMsw260Dlg.GetBox8Len(Ry:TRyPrinter):Integer;
begin
  with Ry do
    Result:=TextHeight*2+Ymm(4);
end;

procedure TMsw260Dlg.MakeBox8(Ry:TRyPrinter; var PPos:Integer);
var
  Y:Integer;
begin
  with Ry do
    begin
      Y:=PPos;
      PPos:=PPos+Ymm(1);
      {headers}
      Font.Style:=[fsBold];
      TextOut(XLOff+Xmm(1),PPos,'8  '+Label8_1.Caption);
      PPos:=PPos+TextHeight+Ymm(2);
      {fields}
      Font.Style:=[];
      if RB8_2.Checked
        then begin
          TextOut(XLOff+Xmm(3),PPos,RB8_2.Caption);
          PPos:=PPos+TextHeight+Ymm(1);
        end
      else if RB8_3.Checked
        then begin
          TextOut(XLOff+Xmm(3),PPos,RB8_3.Caption);
          PPos:=PPos+TextHeight+Ymm(1);
        end;
      Line(Point(XLOff,Y),Point(XLOff,PPos));
      Line(Point(XROff,Y),Point(XROff,PPos));
      Line(Point(XLOff,PPos),Point(XROff,PPos));
    end;
end;

procedure TMsw260Dlg.MakeHeader(Ry:TRyPrinter; var PPos:Integer);
var
  x:Integer;
begin
  with Ry do
    begin
      PPos:=YTOff+Ymm(25);
      Font.name:='Arial CE';
      Font.Style:=[];
      TextOut(XLOff,PPos,'(pieczêæ jednostki)');
      if NumEdit.Text<>''
        then TextOutRight(XROff,PPos,NumLabel.Caption+Numedit.Text)
        else TextOutRight(XROff,PPos,NumLabel.Caption+'........................');
      PPos:=PPos+TextHeight+Ymm(1);
      Line(Point(XLOff,PPos),Point(XROff,PPos));
      x:=PPos;
      PPos:=PPos+Ymm(1);
      Font.Style:=[fsBold];
      TextOutCenter(XLoff+(XROff-XLOff) div 2,PPos,LabelT_1.Caption);
      PPos:=PPos+TextHeight+Ymm(1);
      TextOutCenter(XLoff+(XROff-XLOff) div 2,PPos,LabelT_2.Caption);
      PPos:=PPos+TextHeight+Ymm(1);
      Line(Point(XLOff,x),Point(XLOff,PPos));
      Line(Point(XROff,x),Point(XROff,PPos));
      Line(Point(XLOff,PPos),Point(XROff,PPos));
{      PPos:=PPos+Ymm(1);}
    end;
end;

procedure TMsw260Dlg.MakeFooter(Ry:TRyPrinter; APSpace:Integer);
var
  X:Integer;
begin
  with Ry do
    begin
      Font.Size:=10;
      X:=APSpace+Ymm(2);
      TextOut(XLOff,X,'Nazwisko i imiê');
      TextOut(XLOff,X+TextHeight,'osoby sporz¹dzaj¹cej ............................');
      TextOut(XLOff,X+Xmm(10),'Podpis .....................................................');
      TextOut(XLOff,X+Xmm(14),'Numer telefonu .......................................');
      TextOut(XLOff,X+Xmm(18),'Numer faxu .............................................');
      TextOut(XLOff,X+Xmm(22),'Data sporz¹dzenia ..................................');
      TextOut(XROff-Xmm(37),X,'Piecz¹tka imienna');
      TextOut(XROff-Xmm(37),X+TextHeight,'i podpis kierownika');
      TextOut(XROff-Xmm(37),X+TextHeight*2,'jednostki zamawiaj¹cej');
    end;
end;

procedure TMsw260Dlg.MakeNewPage(Ry:TRyPrinter; var PPos:Integer);
begin
  with Ry do
    begin
      NewPage;
      PPos:=YTOff;
      MakeHeader(Ry,PPos);
      MakeFooter(Ry,PrintSpace);
{      PSpace:=YBOff-Ymm(PageBottomSpace);}
    end;
end;

procedure TMsw260Dlg.MakePrint;
var
  p,q,r:PChar;
begin
    with Ry do
      begin
        NewJob;
        SetMinMargins(Xmm(20),Ymm(10),Xmm(20),Ymm(10));
        MakeHeader(Ry,PPos);
        PrintSpace:=YBOff-Ymm(PageBottomSpace);
        MakeFooter(Ry,PrintSpace);
        MakeBox0(Ry,PPos);
        MakeBox1(Ry,PPos);
        MakeBox2(Ry,PPos);
        MakeBox3_4(Ry,PPos);
        if GetBox5Len(Ry)+PPos>PrintSpace
          then MakeNewPage(Ry,PPos);
        MakeBox5(Ry,PPos);
        if GetBox6Len(Ry)+PPos>PrintSpace
          then MakeNewPage(Ry,PPos);
        MakeBox6(Ry,PPos);
        if GetBox7Len(Ry)+PPos>PrintSpace
          then MakeNewPage(Ry,PPos);
        MakeBox7(Ry,PPos);
        if GetBox8Len(Ry)+PPos>PrintSpace
          then MakeNewPage(Ry,PPos);
        MakeBox8(Ry,PPos);
      end;
end;

procedure TMsw260Dlg.PreviewBtnClick(Sender: TObject);
var
  Cur:Integer;
begin
{$IFDEF NONET}
  if not SmartKeyOk(Sk,SkData)
    then Exit;
{$ENDIF}
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

procedure TMsw260Dlg.PrintBtnClick(Sender: TObject);
var
  Cur:Integer;
begin
{$IFDEF NONET}
  if not SmartKeyOk(Sk,SkData)
    then Exit;
{$ENDIF}
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

procedure TMsw260Dlg.SaveFile;
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
      SeedKey:=SKey;
      SaveString(Msw260FileHdr,FHandle);
      SaveString(FilePwd,FHandle);
      MakeCodeKey(FilePwd);
      SaveEdit(NumEdit,FHandle);
      SaveMemo(Memo0_3,FHandle);
      SaveEdit(Edit0_6,FHandle);
      SaveMaskEdit(MaskEdit0_7,FHandle);
      SaveEdit(Edit0_11,FHandle);
      SaveEdit(Edit0_12,FHandle);
      SaveEdit(Edit0_13,FHandle);
      SaveMaskEdit(MaskEdit0_15,FHandle);
      SaveBoolean(RB0_17.Checked,FHandle);
      SaveBoolean(RB0_18.Checked,FHandle);
      SaveMaskEdit(MaskEdit0_19,FHandle);
      SaveMaskEdit(MaskEdit0_20,FHandle);
      SaveMemo(Memo0_22,FHandle);
      SaveBoolean(NieRB.Checked,FHandle);
      SaveBoolean(OgrRB.Checked,FHandle);
      SaveBoolean(DwuRB.Checked,FHandle);
      SaveBoolean(NegRB.Checked,FHandle);
      SaveBoolean(ZamRB.Checked,FHandle);
      SaveBoolean(CB2_10.Checked,FHandle);
      SaveReal(NEdit2_11.Value,FHandle);
      SaveReal(NEdit2_12.Value,FHandle);
      SaveBoolean(CB2_13.Checked,FHandle);
      SaveReal(NEdit2_15.Value,FHandle);
      SaveReal(NEdit2_16.Value,FHandle);
      SaveBoolean(CB2_17.Checked,FHandle);
      SaveReal(NEdit2_18.Value,FHandle);
      SaveReal(NEdit2_19.Value,FHandle);
      SaveBoolean(CB2_20.Checked,FHandle);
      SaveReal(NEdit2_21.Value,FHandle);
      SaveReal(NEdit2_22.Value,FHandle);
      SaveDateTime(Date3_3.EditDate,FHandle);
      SaveDateTime(Date3_5.EditDate,FHandle);
      SaveEdit(Edit4_5,FHandle);
      SaveDateTime(Date4_7.EditDate,FHandle);
      SaveEdit(Edit4_9,FHandle);
      SaveInteger(NEdit5_2.AsInteger,FHandle);
      SaveReal(NEdit5_7.Value,FHandle);
      SaveReal(NEdit5_8.Value,FHandle);
      SaveReal(NEdit5_9.Value,FHandle);
      SaveStringGrid(Grid6_2,FHandle);
      SaveInteger(NEdit7_3.AsInteger,FHandle);
      SaveComboBox(CB7_4,FHandle);
      SaveBoolean(CB7_5.Checked,FHandle);
      SaveMemo(Memo7_6,FHandle);
      SaveBoolean(RB8_2.Checked,FHandle);
      SaveBoolean(RB8_3.Checked,FHandle);
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

procedure TMsw260Dlg.LoadFile;
var
  s:String;
  i:Integer;
  r:Real;
  b:Boolean;
  DT:TDateTime;
  FPwd:String;
begin
  if FileIsOpen
    then MessageDlg(wmFileAlreadyLoaded,mtWarning,[mbOk],0)
    else begin
      AssignFile(FHandle,FileName);
      FileMode:=fmOpenReadWrite + fmShareDenyWrite;
      try
        Reset(FHandle,1);
        FileIsOpen:=TRUE;
        SeedKey:=SKey;
        LoadString(s,FHandle);
        if s=Msw260FileHdr
          then begin
            LoadString(FPwd,FHandle);
            if (FPwd=FilePwd)
              then begin
                MakeCodeKey(FPwd);
                LoadEdit(NumEdit,FHandle);
                LoadMemo(Memo0_3,FHandle);
                LoadEdit(Edit0_6,FHandle);
                LoadMaskEdit(MaskEdit0_7,FHandle);
                LoadEdit(Edit0_11,FHandle);
                LoadEdit(Edit0_12,FHandle);
                LoadEdit(Edit0_13,FHandle);
                LoadMaskEdit(MaskEdit0_15,FHandle);
                LoadBoolean(b,FHandle);
                RB0_17.Checked:=b;
                LoadBoolean(b,FHandle);
                RB0_18.Checked:=b;
                LoadMaskEdit(MaskEdit0_19,FHandle);
                LoadMaskEdit(MaskEdit0_20,FHandle);
                LoadMemo(Memo0_22,FHandle);
                LoadBoolean(b,FHandle);
                NieRB.Checked:=b;
                LoadBoolean(b,FHandle);
                OgrRB.Checked:=b;
                LoadBoolean(b,FHandle);
                DwuRB.Checked:=b;
                LoadBoolean(b,FHandle);
                NegRB.Checked:=b;
                LoadBoolean(b,FHandle);
                ZamRB.Checked:=b;
                LoadBoolean(b,FHandle);
                CB2_10.Checked:=b;
                LoadReal(r,FHandle);
                NEdit2_11.Value:=r;
                LoadReal(r,FHandle);
                NEdit2_12.Value:=r;
                LoadBoolean(b,FHandle);
                CB2_13.Checked:=b;
                LoadReal(r,FHandle);
                NEdit2_15.Value:=r;
                LoadReal(r,FHandle);
                NEdit2_16.Value:=r;
                LoadBoolean(b,FHandle);
                CB2_17.Checked:=b;
                LoadReal(r,FHandle);
                NEdit2_18.Value:=r;
                LoadReal(r,FHandle);
                NEdit2_19.Value:=r;
                LoadBoolean(b,FHandle);
                CB2_20.Checked:=b;
                LoadReal(r,FHandle);
                NEdit2_21.Value:=r;
                LoadReal(r,FHandle);
                NEdit2_22.Value:=r;
                LoadDateTime(DT,FHandle);
                Date3_3.EditDate:=DT;
                LoadDateTime(DT,FHandle);
                Date3_5.EditDate:=DT;
                LoadEdit(Edit4_5,FHandle);
                LoadDateTime(DT,FHandle);
                Date4_7.EditDate:=DT;
                LoadEdit(Edit4_9,FHandle);
                LoadInteger(i,FHandle);
                NEdit5_2.Value:=i;
                LoadReal(r,FHandle);
                NEdit5_7.Value:=r;
                LoadReal(r,FHandle);
                NEdit5_8.Value:=r;
                LoadReal(r,FHandle);
                NEdit5_9.Value:=r;
                LoadStringGrid(Grid6_2,FHandle);
                LoadInteger(i,FHandle);
                NEdit7_3.Value:=i;
                LoadComboBox(CB7_4,FHandle);
                LoadBoolean(b,FHandle);
                CB7_5.Checked:=b;
                LoadMemo(Memo7_6,FHandle);
                LoadBoolean(b,FHandle);
                RB8_2.Checked:=b;
                LoadBoolean(b,FHandle);
                RB8_3.Checked:=b;
              end
              else begin
                MessageDlg(mIncorrectFilePwd,mtWarning,[mbOk],0);
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

procedure TMsw260Dlg.OpenBtnClick(Sender: TObject);
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

procedure TMsw260Dlg.SaveBtnClick(Sender: TObject);
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

procedure TMsw260Dlg.FormDestroy(Sender: TObject);
begin
  if FileIsOpen
    then begin
      CloseFile(FHandle);
      FileIsOpen:=FALSE;
    end;
end;

procedure TMsw260Dlg.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key=#13
    then begin
      Key:=#0;
      Perform(wm_NextDlgCtl,0,0);
    end;
end;

procedure TMsw260Dlg.OKBtnClick(Sender: TObject);
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

procedure TMsw260Dlg.HelpBtnClick(Sender: TObject);
begin
  Application.HelpContext(402);
end;

procedure TMsw260Dlg.RB0_17Click(Sender: TObject);
begin
  MaskEdit0_19.Enabled:=TRUE;
  MaskEdit0_19.Color:=clWhite;
  MaskEdit0_20.Enabled:=FALSE;
  MaskEdit0_20.Color:=clGray;
end;

procedure TMsw260Dlg.RB0_18Click(Sender: TObject);
begin
  MaskEdit0_19.Enabled:=FALSE;
  MaskEdit0_19.Color:=clGray;
  MaskEdit0_20.Enabled:=TRUE;
  MaskEdit0_20.Color:=clWhite;
end;

procedure TMsw260Dlg.CB2_10Click(Sender: TObject);
begin
  if CB2_10.Checked
    then begin
      NEdit2_11.Enabled:=TRUE;
      NEdit2_11.Color:=clWhite;
      NEdit2_12.Enabled:=TRUE;
      NEdit2_12.Color:=clWhite;
    end
    else begin
      NEdit2_11.Enabled:=FALSE;
      NEdit2_11.Color:=clGray;
      NEdit2_12.Enabled:=FALSE;
      NEdit2_12.Color:=clGray;
    end;
end;

procedure TMsw260Dlg.CB2_13Click(Sender: TObject);
begin
  if CB2_13.Checked
    then begin
      NEdit2_15.Enabled:=TRUE;
      NEdit2_15.Color:=clWhite;
      NEdit2_16.Enabled:=TRUE;
      NEdit2_16.Color:=clWhite;
    end
    else begin
      NEdit2_15.Enabled:=FALSE;
      NEdit2_15.Color:=clGray;
      NEdit2_16.Enabled:=FALSE;
      NEdit2_16.Color:=clGray;
    end;
end;

procedure TMsw260Dlg.CB2_17Click(Sender: TObject);
begin
  if CB2_17.Checked
    then begin
      NEdit2_18.Enabled:=TRUE;
      NEdit2_18.Color:=clWhite;
      NEdit2_19.Enabled:=TRUE;
      NEdit2_19.Color:=clWhite;
    end
    else begin
      NEdit2_18.Enabled:=FALSE;
      NEdit2_18.Color:=clGray;
      NEdit2_19.Enabled:=FALSE;
      NEdit2_19.Color:=clGray;
    end;

end;

procedure TMsw260Dlg.CB2_20Click(Sender: TObject);
begin
  if CB2_20.Checked
    then begin
      NEdit2_21.Enabled:=TRUE;
      NEdit2_21.Color:=clWhite;
      NEdit2_22.Enabled:=TRUE;
      NEdit2_22.Color:=clWhite;
    end
    else begin
      NEdit2_21.Enabled:=FALSE;
      NEdit2_21.Color:=clGray;
      NEdit2_22.Enabled:=FALSE;
      NEdit2_22.Color:=clGray;
    end;
end;

procedure TMsw260Dlg.CB7_5Click(Sender: TObject);
begin
  if CB7_5.Checked
    then begin
      Memo7_6.Enabled:=TRUE;
      Memo7_6.Color:=clWhite;
    end
    else begin
      Memo7_6.Enabled:=FALSE;
      Memo7_6.Color:=clGray;
    end;
end;

end.

