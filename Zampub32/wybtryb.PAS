unit Wybtryb;

interface

uses
  Controls, Forms, Dialogs, StdCtrls,
  SiwzIni;

const
{
 102 nie
 117 ogr
 119 dwu
 111 neg3
 118 neg2
 106 zam7
 108 zam1
 120 zam2
 121 zam4
 122 zam6
 116 zam3 zam5
 113 zap1
 }
  mr1=101;
  mr2=102;
  mr3=103;
  mr4=104;
  mr5=105;
  mrBack=106;

  wtNone=0;
  wtNie=10;
  wtOgr=20;
  wtDwu=30;
  wtNeg=40;
  wtNeg2=41;
  wtNeg3=42;
  wtZam=50;
  wtZam1=51;
  wtZam2=52;
  wtZam3=53;
  wtZam4=54;
  wtZam5=55;
  wtZam6=56;
  wtZam7=57;
  wtZap=60;
  wtZap1=61;

function WybTrybu(AmLev:Integer):Integer;

implementation

uses
  Wyb1,
  Wyb2,
  Wyb3,
  Wyb4,
  Wyb5,
  Wyb7,
  Wyb9,
  Wyb10,
  Wyb12,
  Wyb13,
  Wyb14,
  Wyb15,
  Wyb17,
  Wyb18,
  Wyb19,
  Wyb20;

function WybTrybu(AmLev:Integer):Integer;
const
  L1='Wartoœæ zamówienia nie przekracza równowartoœci 3.000 ECU.';
  L2='Mo¿esz zastosowaæ tryb "ZAMÓWIENIE Z WOLNEJ RÊKI" ';
  L3='(art. 71 ust.1 pkt 7)';
  L4='Czy zastosowaæ taki tryb ?';
  JumpTable:Array[1..9,1..22] of Byte=
  ((3,102,5,0,6,106,8,108,11,15,111,13,113,1,16,116,117,118,119,120,121,122),
   (2,0,4,0,7,0,9,0,10,12,0,14,0,0,17,0,0,0,0,0,0,0),
   (0,0,0,18,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),
   (0,0,0,19,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),
   (0,0,0,20,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),
   (0,0,0,21,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),
   (0,0,0,22,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),
   (0,1,1,3,3,5,5,7,7,9,9,10,12,12,10,15,15,4,4,4,4,4),
   (255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255));
var
  Answer:Byte;
  Current:Byte;
  Prev:Byte;
  ExitValues: Set of Byte;{(255,102,117,119,111,118,106,108,120,121,122);}

  function DisplayDlg(Num:Byte):Byte;
  var
    WF:TForm;
    x:Integer;
  begin
    Result:=0;
    case Num of
       1:  WF:=TWyb1Dlg.Create(Application);
       2:  WF:=TWyb2Dlg.Create(Application);
       3:  WF:=TWyb3Dlg.Create(Application);
       4:  WF:=TWyb4Dlg.Create(Application);
       5:  WF:=TWyb5Dlg.Create(Application);
       6:  begin
             WF:=TWyb20Dlg.Create(Application);
             TWyb20Dlg(WF).SetPoint(7);
           end;
       7:  WF:=TWyb7Dlg.Create(Application);
       8:  begin
             WF:=TWyb20Dlg.Create(Application);
             TWyb20Dlg(WF).SetPoint(1);
           end;
       9:  WF:=TWyb9Dlg.Create(Application);
      10:  WF:=TWyb10Dlg.Create(Application);
      11:  begin
             WF:=TWyb18Dlg.Create(Application);
             TWyb18Dlg(WF).SetPoint(3);
           end;
      12:  WF:=TWyb12Dlg.Create(Application);
      13:  WF:=TWyb13Dlg.Create(Application);
      14:  WF:=TWyb14Dlg.Create(Application);
      15:  WF:=TWyb15Dlg.Create(Application);
      16:  begin
             WF:=TWyb20Dlg.Create(Application);
             TWyb20Dlg(WF).SetPoint(3);
           end;
      17:  WF:=TWyb17Dlg.Create(Application);
      18:  begin
             WF:=TWyb18Dlg.Create(Application);
             TWyb18Dlg(WF).SetPoint(2);
           end;
      19:  WF:=TWyb19Dlg.Create(Application);
      20:  begin
             WF:=TWyb20Dlg.Create(Application);
             TWyb20Dlg(WF).SetPoint(2);
           end;
      21:  begin
             WF:=TWyb20Dlg.Create(Application);
             TWyb20Dlg(WF).SetPoint(4);
           end;
      22:  begin
             WF:=TWyb20Dlg.Create(Application);
             TWyb20Dlg(WF).SetPoint(6);
           end;
      else WF:=Nil;
    end;
    if WF=nil
      then Exit;
    x:=WF.ShowModal;
    WF.Free;
    case x of
      mrYes:Result:=1;
      mrNo:Result:=2;
      mr1:Result:=3;
      mr2:Result:=4;
      mr3:Result:=5;
      mr4:Result:=6;
      mr5:Result:=7;
      mrBack:Result:=8;
      mrCancel:Result:=9;
      else Result:=0;
    end;
  end;

begin
  if (AmLev=aLevel1) and (MessageDlg(L1+#13#10+L2+L3+#13#10+L4,mtWarning,[mbYes,mbNo],0)=mrYes)
    then Result:=wtZam7   {Zamowienie z wolnej reki}
    else begin
      ExitValues:=[255,102,117,119,111,118,106,108,120,121,122];
      Current:=1;
      Prev:=1;
      repeat
        Answer:=DisplayDlg(Current);
        if Answer<>0
          then Current:=JumpTable[Answer,Current]
          else Current:=255;
      until (Current in ExitValues);
      case current of
        102: Result:=wtNie;
        117: Result:=wtOgr;
        119: Result:=wtDwu;
        111: Result:=wtNeg;
        118: Result:=wtNeg;
        106: Result:=wtZam;
        108: Result:=wtZam;
        120: Result:=wtZam;
        121: Result:=wtZam;
        122: Result:=wtZam;
        116: Result:=wtZam;
        113: Result:=wtZap;
        255: Result:=wtNone;
{        102: Result:=wtNie;
        117: Result:=wtOgr;
        119: Result:=wtDwu;
        111: Result:=wtNeg3;
        118: Result:=wtNeg2;
        106: Result:=wtZam7;
        108: Result:=wtZam1;
        120: Result:=wtZam2;
        121: Result:=wtZam4;
        122: Result:=wtZam6;
        116: Result:=wtZam3;
        113: Result:=wtZap;}
      end;
    end;
end;

end.
