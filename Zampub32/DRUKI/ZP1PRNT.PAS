unit Zp1prnt;

interface

uses WinTypes, WinProcs, Classes, Graphics, Forms, Controls, Buttons,
  StdCtrls, ExtCtrls, Mask, TabNotBk, Grids, Spin, SysUtils,
  Messages, Dialogs,
  Utils,
  ZpBoxes,
  RPrev;

function GetBox13Len(Ry:TRyPrinter; P1,P2:PChar):Integer;
function GetBox14Len(Ry:TRyPrinter; P1,P2:PChar):Integer;
function GetBox15Len(Ry:TRyPrinter; P1,P2:PChar):Integer;
function GetBox16Len(Ry:TRyPrinter; P1,P2:PChar):Integer;
function GetBox20Len(Ry:TRyPrinter; P1,P2:PChar; SG:TStringgrid):Integer;
function GetBox21Len(Ry:TRyPrinter; P1,P2:PChar):Integer;
function GetBox22Len(Ry:TRyPrinter; P1,P2:PChar):Integer;
function GetBox23Len(Ry:TRyPrinter; P1:PChar):Integer;
function GetBox24Len(Ry:TRyPrinter; P1,P2:PChar):Integer;
procedure MakeBox13(Ry:TRyPrinter; P1,P2:PChar; B1,B2:Boolean; var PPos:Integer);
procedure MakeBox14(Ry:TRyPrinter; P1,P2:PChar; B1,B2:Boolean; var PPos:Integer);
procedure MakeBox15(Ry:TRyPrinter; P1,P2:PChar; B1,B2:Boolean; var PPos:Integer);
procedure MakeBox16(Ry:TRyPrinter; P1,P2:PChar; B1,B2:Boolean; var PPos:Integer);
procedure MakeBox20(Ry:TRyPrinter; P1,P2:PChar; SG:TStringGrid; var PPos:Integer);
procedure MakeBox21(Ry:TRyPrinter; P1,P2:PChar; B1,B2:Boolean; var PPos:Integer);
procedure MakeBox22(Ry:TRyPrinter; P1,P2:PChar; B1,B2:Boolean; var PPos:Integer);
procedure MakeBox23(Ry:TRyPrinter; P1:PChar; B1,B2:Boolean; var PPos:Integer);
procedure MakeBox24(Ry:TRyPrinter; P1,P2:PChar; B1,B2:Boolean; var PPos:Integer);

implementation

function MaxInt(x,y:Integer):Integer;
begin
  if x>=y
    then Result:=x
    else Result:=y;
end;

function GetBox13Len(Ry:TRyPrinter; P1,P2:PChar):Integer;
var
  Rct:TRect;
  Tx:Integer;
  LH:Integer; {Line height}
  LP:Integer; {Line position}
  X:Integer;
begin
  with Ry do
    begin
      Rct.Right:=XROff;
      Tx:=XLOff+Xmm(15);
      Font.Size:=10;
      LH:=TextHeight+Ymm(1);
      LP:=Ymm(2);
      X:=MemoOut(Rect(Tx,LP,Rct.Right-Xmm(3),100), P1, False, TRUE);
      LP:=LP+X+Ymm(1);
      LP:=LP+LH;
      LP:=LP+Ymm(3);
      X:=MemoOut(Rect(Tx,LP,Rct.Right-Xmm(3),100), P2, False, TRUE);
      LP:=LP+X+Ymm(1);
      Result:=LP+Ymm(1);
    end;
end;

procedure MakeBox13(Ry:TRyPrinter; P1,P2:PChar; B1,B2:Boolean; var PPos:Integer);
var
  Rct:TRect;
  Tx:Integer;
  LH:Integer; {Line height}
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
      LH:=TextHeight+Ymm(1);
      LP:=Rct.Top+Ymm(2);
      X:=MemoOut(Rect(Tx,LP,Rct.Right-Xmm(3),100), P1, False, False);
      LP:=LP+X+Ymm(1);
      TextOut(Tx+Xmm(10),LP,'TAK');
      TextOutRight(Rct.Right-Xmm(10),LP,'NIE');
      LP:=LP+LH;
      Rectangle(Rect(Tx+Xmm(15),LP,Tx+Xmm(20),LP+Ymm(3)));
      Rectangle(Rect(Rct.Right-Xmm(20),LP,Rct.Right-Xmm(15),LP+Ymm(3)));
      if B1
        then begin
          Line(Point(Tx+Xmm(15),LP),Point(Tx+Xmm(20),LP+Ymm(3)));
          Line(Point(Tx+Xmm(15),LP+Ymm(3)),Point(Tx+Xmm(20),LP));
        end
      else if B2
        then begin
          Line(Point(Rct.Right-Xmm(20),LP),Point(Rct.Right-Xmm(15),LP+Ymm(3)));
          Line(Point(Rct.Right-Xmm(20),LP+Ymm(3)),Point(Rct.Right-Xmm(15),LP));
        end;
      LP:=LP+Ymm(4);
      X:=MemoOut(Rect(Tx,LP,Rct.Right-Xmm(3),100), P2, False, False);
      LP:=LP+X+Ymm(1);
      Rct.Bottom:=LP+Ymm(1);
      RoundRectangle(Rct);
      Line(Point(Tx-Xmm(3),Rct.Top),Point(Tx-Xmm(3),Rct.Bottom));
      TextOutCenter(((Tx-Xmm(3)-Rct.Left) div 2)+Rct.Left,Rct.Top+Ymm(4),'13');
      PPos:=Rct.Bottom;
    end;
end;

function GetBox14Len(Ry:TRyPrinter; P1,P2:PChar):Integer;
var
  Rct:TRect;
  Tx:Integer;
  LH:Integer; {Line height}
  LP:Integer; {Line position}
  X:Integer;
begin
  with Ry do
    begin
      Rct.Right:=XROff;
      Tx:=XLOff+Xmm(15);
      Font.Size:=10;
      LH:=TextHeight+Ymm(1);
      LP:=Ymm(2);
      X:=MemoOut(Rect(Tx,LP,Rct.Right-Xmm(3),100), P1, False, TRUE);
      LP:=LP+X+Ymm(1);
      LP:=LP+LH;
      LP:=LP+Ymm(3);
      X:=MemoOut(Rect(Tx,LP,Rct.Right-Xmm(3),100), P2, False, TRUE);
      LP:=LP+X+Ymm(1);
      Result:=LP+Ymm(1);
    end;
end;

procedure MakeBox14(Ry:TRyPrinter; P1,P2:PChar; B1,B2:Boolean; var PPos:Integer);
var
  Rct:TRect;
  Tx:Integer;
  LH:Integer; {Line height}
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
      LH:=TextHeight+Ymm(1);
      LP:=Rct.Top+Ymm(2);
      X:=MemoOut(Rect(Tx,LP,Rct.Right-Xmm(3),100), P1, False, False);
      LP:=LP+X+Ymm(1);
      TextOut(Tx+Xmm(10),LP,'TAK');
      TextOutRight(Rct.Right-Xmm(10),LP,'NIE');
      LP:=LP+LH;
      Rectangle(Rect(Tx+Xmm(15),LP,Tx+Xmm(20),LP+Ymm(3)));
      Rectangle(Rect(Rct.Right-Xmm(20),LP,Rct.Right-Xmm(15),LP+Ymm(3)));
      if B1
        then begin
          Line(Point(Tx+Xmm(15),LP),Point(Tx+Xmm(20),LP+Ymm(3)));
          Line(Point(Tx+Xmm(15),LP+Ymm(3)),Point(Tx+Xmm(20),LP));
        end
      else if B2
        then begin
          Line(Point(Rct.Right-Xmm(20),LP),Point(Rct.Right-Xmm(15),LP+Ymm(3)));
          Line(Point(Rct.Right-Xmm(20),LP+Ymm(3)),Point(Rct.Right-Xmm(15),LP));
        end;
      LP:=LP+Ymm(4);
      X:=MemoOut(Rect(Tx,LP,Rct.Right-Xmm(3),100), P2, False, False);
      LP:=LP+X+Ymm(1);
      Rct.Bottom:=LP+Ymm(1);
      RoundRectangle(Rct);
      Line(Point(Tx-Xmm(3),Rct.Top),Point(Tx-Xmm(3),Rct.Bottom));
      TextOutCenter(((Tx-Xmm(3)-Rct.Left) div 2)+Rct.Left,Rct.Top+Ymm(4),'14');
      PPos:=Rct.Bottom;
    end;
end;

function GetBox15Len(Ry:TRyPrinter; P1,P2:PChar):Integer;
var
  Rct:TRect;
  Tx:Integer;
  LH:Integer; {Line height}
  LP:Integer; {Line position}
  X:Integer;
begin
  with Ry do
    begin
      Rct.Right:=XROff;
      Tx:=XLOff+Xmm(15);
      Font.Size:=10;
      LH:=TextHeight+Ymm(1);
      LP:=Ymm(2);
      X:=MemoOut(Rect(Tx,LP,Rct.Right-Xmm(3),100), P1, False, TRUE);
      LP:=LP+X+Ymm(1);
      LP:=LP+LH;
      LP:=LP+Ymm(3);
      X:=MemoOut(Rect(Tx,LP,Rct.Right-Xmm(3),100), P2, False, TRUE);
      LP:=LP+X+Ymm(1);
      Result:=LP+Ymm(1);
    end;
end;

procedure MakeBox15(Ry:TRyPrinter; P1,P2:PChar; B1,B2:Boolean; var PPos:Integer);
var
  Rct:TRect;
  Tx:Integer;
  LH:Integer; {Line height}
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
      LH:=TextHeight+Ymm(1);
      LP:=Rct.Top+Ymm(2);
      X:=MemoOut(Rect(Tx,LP,Rct.Right-Xmm(3),100), P1, False, False);
      LP:=LP+X+Ymm(1);
      TextOut(Tx+Xmm(10),LP,'TAK');
      TextOutRight(Rct.Right-Xmm(10),LP,'NIE');
      LP:=LP+LH;
      Rectangle(Rect(Tx+Xmm(15),LP,Tx+Xmm(20),LP+Ymm(3)));
      Rectangle(Rect(Rct.Right-Xmm(20),LP,Rct.Right-Xmm(15),LP+Ymm(3)));
      if B1
        then begin
          Line(Point(Tx+Xmm(15),LP),Point(Tx+Xmm(20),LP+Ymm(3)));
          Line(Point(Tx+Xmm(15),LP+Ymm(3)),Point(Tx+Xmm(20),LP));
        end
      else if B2
        then begin
          Line(Point(Rct.Right-Xmm(20),LP),Point(Rct.Right-Xmm(15),LP+Ymm(3)));
          Line(Point(Rct.Right-Xmm(20),LP+Ymm(3)),Point(Rct.Right-Xmm(15),LP));
        end;
      LP:=LP+Ymm(4);
      X:=MemoOut(Rect(Tx,LP,Rct.Right-Xmm(3),100), P2, False, False);
      LP:=LP+X+Ymm(1);
      Rct.Bottom:=LP+Ymm(1);
      RoundRectangle(Rct);
      Line(Point(Tx-Xmm(3),Rct.Top),Point(Tx-Xmm(3),Rct.Bottom));
      TextOutCenter(((Tx-Xmm(3)-Rct.Left) div 2)+Rct.Left,Rct.Top+Ymm(4),'15');
      PPos:=Rct.Bottom;
    end;
end;

function GetBox16Len(Ry:TRyPrinter; P1,P2:PChar):Integer;
var
  Rct:TRect;
  Tx:Integer;
  LH:Integer; {Line height}
  LP:Integer; {Line position}
  X:Integer;
begin
  with Ry do
    begin
      Rct.Right:=XROff;
      Tx:=XLOff+Xmm(15);
      Font.Size:=10;
      LH:=TextHeight+Ymm(1);
      LP:=Ymm(2);
      X:=MemoOut(Rect(Tx,LP,Rct.Right-Xmm(3),100), P1, False, TRUE);
      LP:=LP+X+Ymm(1);
      LP:=LP+LH;
      LP:=LP+Ymm(3);
      X:=MemoOut(Rect(Tx,LP,Rct.Right-Xmm(3),100), P2, False, TRUE);
      LP:=LP+X+Ymm(1);
      Result:=LP+Ymm(1);
    end;
end;

procedure MakeBox16(Ry:TRyPrinter; P1,P2:PChar; B1,B2:Boolean; var PPos:Integer);
var
  Rct:TRect;
  Tx:Integer;
  LH:Integer; {Line height}
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
      LH:=TextHeight+Ymm(1);
      LP:=Rct.Top+Ymm(2);
      X:=MemoOut(Rect(Tx,LP,Rct.Right-Xmm(3),100), P1, False, False);
      LP:=LP+X+Ymm(1);
      TextOut(Tx+Xmm(10),LP,'TAK');
      TextOutRight(Rct.Right-Xmm(10),LP,'NIE');
      LP:=LP+LH;
      Rectangle(Rect(Tx+Xmm(15),LP,Tx+Xmm(20),LP+Ymm(3)));
      Rectangle(Rect(Rct.Right-Xmm(20),LP,Rct.Right-Xmm(15),LP+Ymm(3)));
      if B1
        then begin
          Line(Point(Tx+Xmm(15),LP),Point(Tx+Xmm(20),LP+Ymm(3)));
          Line(Point(Tx+Xmm(15),LP+Ymm(3)),Point(Tx+Xmm(20),LP));
        end
      else if B2
        then begin
          Line(Point(Rct.Right-Xmm(20),LP),Point(Rct.Right-Xmm(15),LP+Ymm(3)));
          Line(Point(Rct.Right-Xmm(20),LP+Ymm(3)),Point(Rct.Right-Xmm(15),LP));
        end;
      LP:=LP+Ymm(4);
      X:=MemoOut(Rect(Tx,LP,Rct.Right-Xmm(3),100), P2, False, False);
      LP:=LP+X+Ymm(1);
      Rct.Bottom:=LP+Ymm(1);
      RoundRectangle(Rct);
      Line(Point(Tx-Xmm(3),Rct.Top),Point(Tx-Xmm(3),Rct.Bottom));
      TextOutCenter(((Tx-Xmm(3)-Rct.Left) div 2)+Rct.Left,Rct.Top+Ymm(4),'16');
      PPos:=Rct.Bottom;
    end;
end;

function GetBox20Len(Ry:TRyPrinter; P1,P2:PChar; SG:TStringgrid):Integer;
var
  Rct:TRect;
  Pt2,Pt3:TPoint;
  Tx:Integer;
  LP:Integer; {Line position}
  X:Integer;
  XPos:Integer;
  Cnt:LongInt;
begin
  with Ry do
    begin
      Rct.Right:=XROff;
      Tx:=XLOff+Xmm(15);
      Font.Size:=10;
      LP:=Ymm(2);
      X:=MemoOut(Rect(Tx,LP,Rct.Right-Xmm(3),100), P1, False, TRUE);
      LP:=LP+X+Ymm(1);
      Cnt:=1;
      with SG do
        repeat
          Pt2.Y:=LP+TextHeight+Ymm(2);
          Pt3.Y:=Pt2.Y+TextHeight+Ymm(2);
          XPos:=Tx+Xmm(2)+TextWidth(Cells[0,1]);
          while (Cnt<ColCount) and (XPos+MaxInt(TextWidth(Cells[Cnt,1]),Xmm(10))+Xmm(2)<XROff) do
            begin
              XPos:=XPos+MaxInt(TextWidth(Cells[Cnt,1]),Xmm(10))+Xmm(2);
              Inc(Cnt);
            end;
          LP:=Pt3.Y+Ymm(2);
        until Cnt>=ColCount;
      X:=MemoOut(Rect(Tx,LP,Rct.Right-Xmm(3),100), P2, False, TRUE);
      LP:=LP+X+Ymm(1);
      Result:=LP+Ymm(1);
    end;
end;

procedure MakeBox20(Ry:TRyPrinter; P1,P2:PChar; SG:TStringGrid; var PPos:Integer);
var
  Rct:TRect;
  Pt1,Pt2,Pt3:TPoint;
  Tx:Integer;
  LH:Integer;
  LP:Integer; {Line position}
  X:Integer;
  XPos:Integer;
  Cnt:LongInt;
begin
  with Ry do
    begin
      Rct.Left:=XLOff;
      Rct.Right:=XROff;
      Rct.Top:=PPos+Ymm(3);
      Tx:=Rct.Left+Xmm(15);
      Font.Size:=10;
      LH:=TextHeight+Ymm(1);
      LP:=Rct.Top+Ymm(2);
      X:=MemoOut(Rect(Tx,LP,Rct.Right-Xmm(3),100), P1, False, False);
      LP:=LP+X+Ymm(1);
      Cnt:=1;
      with SG do
        repeat
          Pt1.X:=Tx;
          Pt1.Y:=LP;
          Pt2.X:=Tx;
          Pt2.Y:=Pt1.Y+TextHeight+Ymm(2);
          Pt3.X:=Tx;
          Pt3.Y:=Pt2.Y+TextHeight+Ymm(2);
          Line(Pt1,Pt3);
          TextOut(Pt1.X+Xmm(1),Pt1.Y+Ymm(1),Cells[0,0]);
          TextOut(Pt2.X+Xmm(1),Pt2.Y+Ymm(1),Cells[0,1]);
          XPos:=Pt1.X+Xmm(2)+TextWidth(Cells[0,1]);
          Line(Point(XPos,Pt1.Y),Point(XPos,Pt3.Y));
          while (Cnt<ColCount) and (XPos+MaxInt(TextWidth(Cells[Cnt,1]),Xmm(10))+Xmm(2)<XROff) do
            begin
              TextOut(XPos+Ymm(1),Pt1.y+Ymm(1),Cells[Cnt,0]);
              TextOut(XPos+Ymm(1),Pt2.y+Ymm(1),Cells[Cnt,1]);
              XPos:=XPos+MaxInt(TextWidth(Cells[Cnt,1]),Xmm(10))+Xmm(2);
              Line(Point(XPos,Pt1.Y),Point(XPos,Pt3.Y));
              Inc(Cnt);
            end;
          Line(Point(Pt1.X,Pt1.Y),Point(XPos,Pt1.Y));
          Line(Point(Pt2.X,Pt2.Y),Point(XPos,Pt2.Y));
          Line(Point(Pt3.X,Pt3.Y),Point(XPos,Pt3.Y));
          LP:=Pt3.Y+Ymm(2);
        until Cnt>=ColCount;
      X:=MemoOut(Rect(Tx,LP,Rct.Right-Xmm(3),100), P2, False, False);
      LP:=LP+X+Ymm(1);
      Rct.Bottom:=LP+Ymm(1);
      RoundRectangle(Rct);
      Line(Point(Tx-Xmm(3),Rct.Top),Point(Tx-Xmm(3),Rct.Bottom));
      TextOutCenter(((Tx-Xmm(3)-Rct.Left) div 2)+Rct.Left,Rct.Top+Ymm(4),'20');
      PPos:=Rct.Bottom;
    end;
end;



function GetBox21Len(Ry:TRyPrinter; P1,P2:PChar):Integer;
var
  Rct:TRect;
  Tx:Integer;
  LH:Integer; {Line height}
  LP:Integer; {Line position}
  X:Integer;
begin
  with Ry do
    begin
      Rct.Right:=XROff;
      Tx:=XLOff+Xmm(15);
      Font.Size:=10;
      LH:=TextHeight+Ymm(1);
      LP:=Ymm(2);
      X:=MemoOut(Rect(Tx,LP,Rct.Right-Xmm(3),100), P1, False, TRUE);
      LP:=LP+X+Ymm(1);
      LP:=LP+LH;
      LP:=LP+Ymm(4);
      X:=MemoOut(Rect(Tx,LP,Rct.Right-Xmm(3),100), P2, False, TRUE);
      LP:=LP+X+Ymm(1);
      Result:=LP+Ymm(1);
    end;
end;

procedure MakeBox21(Ry:TRyPrinter; P1,P2:PChar; B1,B2:Boolean; var PPos:Integer);
var
  Rct:TRect;
  Tx:Integer;
  LH:Integer; {Line height}
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
      LH:=TextHeight+Ymm(1);
      LP:=Rct.Top+Ymm(2);
      X:=MemoOut(Rect(Tx,LP,Rct.Right-Xmm(3),100), P1, False, False);
      LP:=LP+X+Ymm(1);
      TextOut(Tx+Xmm(10),LP,'TAK');
      TextOutRight(Rct.Right-Xmm(10),LP,'NIE');
      LP:=LP+LH;
      Rectangle(Rect(Tx+Xmm(15),LP,Tx+Xmm(20),LP+Ymm(3)));
      Rectangle(Rect(Rct.Right-Xmm(20),LP,Rct.Right-Xmm(15),LP+Ymm(3)));
      if B1
        then begin
          Line(Point(Tx+Xmm(15),LP),Point(Tx+Xmm(20),LP+Ymm(3)));
          Line(Point(Tx+Xmm(15),LP+Ymm(3)),Point(Tx+Xmm(20),LP));
        end
      else if B2
        then begin
          Line(Point(Rct.Right-Xmm(20),LP),Point(Rct.Right-Xmm(15),LP+Ymm(3)));
          Line(Point(Rct.Right-Xmm(20),LP+Ymm(3)),Point(Rct.Right-Xmm(15),LP));
        end;
      LP:=LP+Ymm(4);
      X:=MemoOut(Rect(Tx,LP,Rct.Right-Xmm(3),100), P2, False, False);
      LP:=LP+X+Ymm(1);
      Rct.Bottom:=LP+Ymm(1);
      RoundRectangle(Rct);
      Line(Point(Tx-Xmm(3),Rct.Top),Point(Tx-Xmm(3),Rct.Bottom));
      TextOutCenter(((Tx-Xmm(3)-Rct.Left) div 2)+Rct.Left,Rct.Top+Ymm(4),'21');
      PPos:=Rct.Bottom;
    end;
end;

function GetBox22Len(Ry:TRyPrinter; P1,P2:PChar):Integer;
var
  Rct:TRect;
  Tx:Integer;
  LH:Integer; {Line height}
  LP:Integer; {Line position}
  X:Integer;
begin
  with Ry do
    begin
      Rct.Right:=XROff;
      Tx:=XLOff+Xmm(15);
      Font.Size:=10;
      LH:=TextHeight+Ymm(1);
      LP:=Ymm(2);
      X:=MemoOut(Rect(Tx,LP,Rct.Right-Xmm(3),100), P1, False, TRUE);
      LP:=LP+X+Ymm(1);
      LP:=LP+LH;
      LP:=LP+Ymm(4);
      X:=MemoOut(Rect(Tx,LP,Rct.Right-Xmm(3),100), P2, False, TRUE);
      LP:=LP+X+Ymm(1);
      Result:=LP+Ymm(1);
    end;
end;

procedure MakeBox22(Ry:TRyPrinter; P1,P2:PChar; B1,B2:Boolean; var PPos:Integer);
var
  Rct:TRect;
  Tx:Integer;
  LH:Integer; {Line height}
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
      LH:=TextHeight+Ymm(1);
      LP:=Rct.Top+Ymm(2);
      X:=MemoOut(Rect(Tx,LP,Rct.Right-Xmm(3),100), P1, False, False);
      LP:=LP+X+Ymm(1);
      TextOut(Tx+Xmm(10),LP,'TAK');
      TextOutRight(Rct.Right-Xmm(10),LP,'NIE');
      LP:=LP+LH;
      Rectangle(Rect(Tx+Xmm(15),LP,Tx+Xmm(20),LP+Ymm(3)));
      Rectangle(Rect(Rct.Right-Xmm(20),LP,Rct.Right-Xmm(15),LP+Ymm(3)));
      if B1
        then begin
          Line(Point(Tx+Xmm(15),LP),Point(Tx+Xmm(20),LP+Ymm(3)));
          Line(Point(Tx+Xmm(15),LP+Ymm(3)),Point(Tx+Xmm(20),LP));
        end
      else if B2
        then begin
          Line(Point(Rct.Right-Xmm(20),LP),Point(Rct.Right-Xmm(15),LP+Ymm(3)));
          Line(Point(Rct.Right-Xmm(20),LP+Ymm(3)),Point(Rct.Right-Xmm(15),LP));
        end;
      LP:=LP+Ymm(4);
      X:=MemoOut(Rect(Tx,LP,Rct.Right-Xmm(3),100), P2, False, False);
      LP:=LP+X+Ymm(1);
      Rct.Bottom:=LP+Ymm(1);
      RoundRectangle(Rct);
      Line(Point(Tx-Xmm(3),Rct.Top),Point(Tx-Xmm(3),Rct.Bottom));
      TextOutCenter(((Tx-Xmm(3)-Rct.Left) div 2)+Rct.Left,Rct.Top+Ymm(4),'22');
      PPos:=Rct.Bottom;
    end;
end;

function GetBox23Len(Ry:TRyPrinter; P1:PChar):Integer;
var
  Rct:TRect;
  Tx:Integer;
  LH:Integer; {Line height}
  LP:Integer; {Line position}
  X:Integer;
begin
  with Ry do
    begin
      Rct.Right:=XROff;
      Tx:=XLOff+Xmm(15);
      Font.Size:=10;
      LH:=TextHeight+Ymm(1);
      LP:=Ymm(2);
      X:=MemoOut(Rect(Tx,LP,Rct.Right-Xmm(3),100), P1, False, TRUE);
      LP:=LP+X+Ymm(1);
      LP:=LP+LH;
      LP:=LP+Ymm(4);
      Result:=LP+Ymm(1);
    end;
end;

procedure MakeBox23(Ry:TRyPrinter; P1:PChar; B1,B2:Boolean; var PPos:Integer);
var
  Rct:TRect;
  Tx:Integer;
  LH:Integer; {Line height}
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
      LH:=TextHeight+Ymm(1);
      LP:=Rct.Top+Ymm(2);
      X:=MemoOut(Rect(Tx,LP,Rct.Right-Xmm(3),100), P1, False, False);
      LP:=LP+X+Ymm(1);
      TextOut(Tx+Xmm(10),LP,'TAK');
      TextOutRight(Rct.Right-Xmm(10),LP,'NIE');
      LP:=LP+LH;
      Rectangle(Rect(Tx+Xmm(15),LP,Tx+Xmm(20),LP+Ymm(3)));
      Rectangle(Rect(Rct.Right-Xmm(20),LP,Rct.Right-Xmm(15),LP+Ymm(3)));
      if B1
        then begin
          Line(Point(Tx+Xmm(15),LP),Point(Tx+Xmm(20),LP+Ymm(3)));
          Line(Point(Tx+Xmm(15),LP+Ymm(3)),Point(Tx+Xmm(20),LP));
        end
      else if B2
        then begin
          Line(Point(Rct.Right-Xmm(20),LP),Point(Rct.Right-Xmm(15),LP+Ymm(3)));
          Line(Point(Rct.Right-Xmm(20),LP+Ymm(3)),Point(Rct.Right-Xmm(15),LP));
        end;
      LP:=LP+Ymm(4);
      Rct.Bottom:=LP+Ymm(1);
      RoundRectangle(Rct);
      Line(Point(Tx-Xmm(3),Rct.Top),Point(Tx-Xmm(3),Rct.Bottom));
      TextOutCenter(((Tx-Xmm(3)-Rct.Left) div 2)+Rct.Left,Rct.Top+Ymm(4),'23');
      PPos:=Rct.Bottom;
    end;
end;

function GetBox24Len(Ry:TRyPrinter; P1,P2:PChar):Integer;
var
  Rct:TRect;
  Tx:Integer;
  LH:Integer; {Line height}
  LP:Integer; {Line position}
  X:Integer;
begin
  with Ry do
    begin
      Rct.Right:=XROff;
      Tx:=XLOff+Xmm(15);
      Font.Size:=10;
      LH:=TextHeight+Ymm(1);
      LP:=Ymm(2);
      X:=MemoOut(Rect(Tx,LP,Rct.Right-Xmm(3),100), P1, False, TRUE);
      LP:=LP+X+Ymm(1);
      LP:=LP+LH;
      LP:=LP+Ymm(4);
      X:=MemoOut(Rect(Tx,LP,Rct.Right-Xmm(3),100), P2, False, TRUE);
      LP:=LP+X+Ymm(1);
      Result:=LP+Ymm(1);
    end;
end;

procedure MakeBox24(Ry:TRyPrinter; P1,P2:PChar; B1,B2:Boolean; var PPos:Integer);
var
  Rct:TRect;
  Tx:Integer;
  LH:Integer; {Line height}
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
      LH:=TextHeight+Ymm(1);
      LP:=Rct.Top+Ymm(2);
      X:=MemoOut(Rect(Tx,LP,Rct.Right-Xmm(3),100), P1, False, False);
      LP:=LP+X+Ymm(1);
      TextOut(Tx+Xmm(10),LP,'TAK');
      TextOutRight(Rct.Right-Xmm(10),LP,'NIE');
      LP:=LP+LH;
      Rectangle(Rect(Tx+Xmm(15),LP,Tx+Xmm(20),LP+Ymm(3)));
      Rectangle(Rect(Rct.Right-Xmm(20),LP,Rct.Right-Xmm(15),LP+Ymm(3)));
      if B1
        then begin
          Line(Point(Tx+Xmm(15),LP),Point(Tx+Xmm(20),LP+Ymm(3)));
          Line(Point(Tx+Xmm(15),LP+Ymm(3)),Point(Tx+Xmm(20),LP));
        end
      else if B2
        then begin
          Line(Point(Rct.Right-Xmm(20),LP),Point(Rct.Right-Xmm(15),LP+Ymm(3)));
          Line(Point(Rct.Right-Xmm(20),LP+Ymm(3)),Point(Rct.Right-Xmm(15),LP));
        end;
      LP:=LP+Ymm(4);
      X:=MemoOut(Rect(Tx,LP,Rct.Right-Xmm(3),100), P2, False, False);
      LP:=LP+X+Ymm(1);
      Rct.Bottom:=LP+Ymm(1);
      RoundRectangle(Rct);
      Line(Point(Tx-Xmm(3),Rct.Top),Point(Tx-Xmm(3),Rct.Bottom));
      TextOutCenter(((Tx-Xmm(3)-Rct.Left) div 2)+Rct.Left,Rct.Top+Ymm(4),'24');
      PPos:=Rct.Bottom;
    end;
end;

end.
