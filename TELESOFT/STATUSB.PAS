{$A+,B-,D+,F-,G+,I+,K+,L+,N+,P+,Q-,R-,S-,T-,V+,W-,X+,Y+}
{$M 16384,8192}
{*****************************************************************************}
{                                                                             }
{ TStatusBar - a VCL component that is provides time-of-date, NUM, CAPS, and }
{   Scroll Key Statuses. When you click on this component (at run-time), it   }
{   will switch to showing free GDI, System, and User Resources. Source code  }
{   documentation is rather limited, with the exception of the rather arcane  }
{   properties which as described below. This component (such as it is) is    }
{   hereby given to the public domain. Should you find it useful at some      }
{   point in your programming career, please feel obligated to donate one of  }
{   your own equally useful components to the public domain. If you have any  }
{   suggestions for improvements, or if you find any bugs, please notify the  }
{   author (but please be gentle - this is my first component). Thank-you.    }
{  Properties                                                                 }
{    I haven't created an on-line help file for this component, because I     }
{    don't really have the time, or possibly because I am just lazy. Perhaps  }
{    I'll create one if enough people download this file as it is! Anyways,   }
{    here are my notes on the properties which were not inherited (in no      }
{    particular order):                                                       }
{                                                                             }
{    StatusMode - can be pmClock or pmResources. When it's pmClock, the        }
{      component shows the time-of-day, and the status of NUM, CAPS, and      }
{      SCRL. When it's pmResources, it will show the percentage of free       }
{      GDI, USER and System Resources.                                        }
{    AllowClick - when this is true, the user can click on the component      }
{      to switch back and forth between the clock and the resource monitor.   }
{    AlertLevel - if any of the resources fall below this level, they will    }
{      be shown using the AlertFont.                                          }
{    Spaces - the number of pixels of space between sections of the panel.    }
{                                                                             }
{*****************************************************************************}

unit Statusb;

interface

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, ExtCtrls;

const
  {Key statuses}
  ksNumLock = 1;
  ksCapsLock = 2;
  ksScrollLock = 4;

  {Resource Monitors}
  rmNumberOfMonitors = 3;
  rmGDIResources = 1;
  rmSystemResources = 2;
  rmUserResources = 3;

  {Strings and sizes}
  sbNumStr='NUM';
  sbCapsStr='CAPS';
  sbScrollStr='SCROLL';
  sbDateTimeStr='0000/00/00 00:00:00';
  sbModifyStr='Zmodyfikowany';
  sbPageStr='00 z 00';

type
  TResourceMonitor = array[rmGDIResources..rmUserResources] of integer;
  TStatusMode = (pmClock,pmResources);
  TStatusBar = class(TCustomControl)
  private
    { Private declarations }
    FAlertColor: TColor;
    FAlertLevel: Integer;
    FAllowClick: Boolean;
    FBevel: TPanelBevel;
    FBevelWidth: Integer;
    FCurPage:Integer;
    FGaugeColor: TColor;
    FHelpStr:String;
    FKeyState: Integer;
    FLastHelp:String;
    FLastPaint: String[20];
    FModified:Boolean;
    FModifyStr:String;
    FStatusMode: TStatusMode;
    FResources: TResourceMonitor;
    FSpace: Integer;
    FTotPages:Integer;
  protected
    { Protected declarations }
    procedure Click; override;
    procedure Paint; override;
    procedure SetAlertLevel(Value: Integer);
    procedure SetBevel(Value: TPanelBevel);
    procedure SetBevelWidth(Value: Integer);
    procedure SetBounds(ALeft, ATop, AWidth, AHeight: Integer); override;
    procedure SetCurPage(Value:Integer);
    procedure SetStatusMode(Value: TStatusMode);
    procedure SetSpace(Value: Integer);
    procedure WMDestroy(var Msg: TMsg); message WM_Destroy;
    procedure WMCreate(var Msg: TMsg); message WM_Create;
    procedure WMTimer(var Msg: TMsg); message WM_Timer;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
  published
    { Published declarations }
    property AlertColor:TColor read FAlertColor write FAlertColor default clRed;
    property AlertLevel: Integer read FAlertLevel write SetAlertLevel default 20;
    property Align;
    property AllowClick: Boolean read FAllowClick write FAllowClick default TRUE;
    property Bevel: TPanelBevel read FBevel write SetBevel default bvLowered;
    property BevelWidth: Integer read FBevelWidth write SetBevelWidth default 1;
    property Color;
    property CurPage:Integer read FCurPage write SetCurPage default 0;
    property Enabled;
    property Font;
    property GaugeColor:TColor read FGaugeColor write FGaugeColor default $0040FF00;
    property Height default 16;
    property HelpStr: String read FHelpStr write FHelpStr;
    property Hint;
    property Modified:Boolean read FModified write FModified default FALSE;
    property ModifyStr: String read FModifyStr write FModifyStr;
    property StatusMode: TStatusMode read FStatusMode write SetStatusMode default pmClock;
    property ParentColor;
    property ParentFont;
    property ParentShowHint;
    property ShowHint;
    property Space: Integer read FSpace write SetSpace default 1;
    property TotPages:Integer read FTotPages write FTotPages default 0;
    property Width default 219;
  end;

procedure Register;

implementation

function IntFindMin(X,Y: Integer): Integer;
begin
  if (X < Y)
    then Result := X
    else Result := Y;
end;

function IntFindMax(X,Y: Integer): Integer;
begin
  if (X > Y)
    then Result := X
    else Result := Y;
end;

procedure Register;
begin
  RegisterComponents('Telesoft', [TStatusBar]);
end;

constructor TStatusBar.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  SetBounds(0,0,219,16);
  Hint := 'Kliknij ¿eby zobaczyæ zasoby systemu';
  ModifyStr:=sbModifyStr;
  FAlertColor:=clRed;
  FAlertLevel := 20;
  FAllowClick := TRUE;
  FBevel := bvLowered;
  FBevelWidth := 1;
  FGaugeColor:=$0040FF00;
  FSpace := 1;
end;

procedure TStatusBar.SetCurPage(Value:Integer);
begin
  FCurPage:=Value;
  if TotPages<Value
    then TotPages:=Value;
end;

procedure TStatusBar.Click;
begin
  if (AllowClick)
    then begin
      if (StatusMode = pmClock)
        then StatusMode := pmResources
        else StatusMode := pmClock;
      end;
  inherited Click;
end;

procedure TStatusBar.Paint;
var
  ClientRect: TRect;
  StatusRect: TRect;
  TextMetric: TTextMetric;
  TopColor, BottomColor: TColorRef;
  OldColor: TColorRef;
  X: Integer;
  RWidth: Integer;
  FieldWidth:Integer;
  s:String;
const
  ResMonitors: array[1..rmNumberOfMonitors] of String[4] = ('GDI:','SYS:','USR:');
  procedure PaintRect(ARect: TRect; S: String; Alignment:TAlignment);
  var
    X,Y: Integer;
    FRect: TRect;
  begin
    FRect := ARect;
    if (Bevel <> bvNone)
      then Frame3D(Canvas,ARect,TopColor,BottomColor,BevelWidth);
    WinProcs.GetTextMetrics(Canvas.Handle,TextMetric);
    if Alignment=taLeftJustify
      then X:=ARect.Left+1
      else X := ARect.Left + IntFindMax((ARect.Right - ARect.Left - Canvas.TextWidth(S)) div 2,1);
    Y := ARect.Top + IntFindMax((ARect.Bottom - ARect.Top - TextMetric.tmHeight) div 2,1);
    Canvas.TextRect(ARect,X,Y,S);
    {Fill up the spacer}
    if (Space > 0) and (FRect.Right + Space <= ClientRect.Right)
      then begin
        FRect.Left := FRect.Right;
        FRect.Right := FRect.Left + Space;
        Canvas.Brush.Color := Self.Color;
        Canvas.FillRect(FRect);
      end;
  end;
  procedure PaintGaugeRect(ARect:TRect; S:String; Prog:Integer);
  var
    X,Y: Integer;
    SRect:TRect;
    GRect:TRect;
  begin
    SRect:=ARect;
    if (Bevel <> bvNone)
      then Frame3D(Canvas,ARect,TopColor,BottomColor,BevelWidth);
    {paint the gauge}
    GRect:=ARect;
    GRect.Right:=GRect.Left+Round((ARect.Right-ARect.Left-1)*Prog*0.01);
    {paint Background}
    Canvas.FillRect(ARect);
    if Prog<AlertLevel
      then Canvas.Brush.Color := AlertColor
      else Canvas.Brush.Color := GaugeColor;
    Canvas.FillRect(GRect);
    {write the text}
    WinProcs.GetTextMetrics(Canvas.Handle,TextMetric);
    X := ARect.Left + IntFindMax((ARect.Right - ARect.Left - Canvas.TextWidth(S)) div 2,1);
    Y := ARect.Top + IntFindMax((ARect.Bottom - ARect.Top - TextMetric.tmHeight) div 2,1);
    SetBkMode(Canvas.Handle,Transparent);
    Canvas.TextOut{Rect}({ARect,}X,Y,S);
    SetBkMode(Canvas.Handle,Opaque);
    {add the spacer}
    if (Space > 0) and (SRect.Right + Space <= ClientRect.Right)
      then begin
        SRect.Left := SRect.Right;
        SRect.Right := SRect.Left + Space;
        Canvas.Brush.Color := Self.Color;
        Canvas.FillRect(SRect);
      end;
  end;
begin
  inherited Paint;
  ClientRect := GetClientRect;
  if (Bevel = bvLowered)
    then begin
      TopColor := clBtnShadow;
      BottomColor := clBtnHighlight;
    end
    else begin
      TopColor := clBtnHighlight;
      BottomColor := clBtnShadow;
    end;
  Canvas.Font:=Self.Font;
  FLastPaint:=TimeToStr(Now);
  FLastHelp:=HelpStr;
  OldColor := SetBkColor(Canvas.Handle,ColorToRGB(Color));
  StatusRect := ClientRect;
  if (StatusMode = pmClock)
    then begin
      FieldWidth:=Canvas.TextWidth(ModifyStr)+10;
      StatusRect.Right := IntFindMin(ClientRect.Right,FieldWidth);
      PaintRect(StatusRect,ModifyStr,taCenter);
      Inc(StatusRect.Left,FieldWidth+Space);
      s:=IntToStr(FCurPage)+' z '+IntToStr(FTotPages);
      FieldWidth:=Canvas.TextWidth(s)+10;
      StatusRect.Right := IntFindMin(ClientRect.Right,StatusRect.Left+FieldWidth);
      PaintRect(StatusRect,s,taCenter);
      Inc(StatusRect.Left,FieldWidth+Space);
      X:=StatusRect.Left;
      FieldWidth:=Canvas.TextWidth(sbDateTimeStr)+10;
      StatusRect.Left:=IntFindMax(ClientRect.Right-FieldWidth,X);
      StatusRect.Right:=ClientRect.Right-Space;
      PaintRect(StatusRect,DateTimeToStr(Now),taCenter);
      StatusRect.Right:=StatusRect.Left-Space;
      StatusRect.Left:=X;
      PaintRect(StatusRect,HelpStr,taLeftJustify);
    end
    else begin
      FieldWidth:=Canvas.TextWidth(sbNumStr)+10;
      StatusRect.Right := IntFindMin(ClientRect.Right,FieldWidth);
      if (FKeyState and ksNumLock) <> 0
        then PaintRect(StatusRect,sbNumStr,taCenter)
        else PaintRect(StatusRect,'',taCenter);
      Inc(StatusRect.Left,FieldWidth+Space);
      FieldWidth:=Canvas.TextWidth(sbCapsStr)+10;
      StatusRect.Right := IntFindMin(ClientRect.Right,StatusRect.Left+FieldWidth);
      if (FKeyState and ksCapsLock) <> 0
        then PaintRect(StatusRect,sbCapsStr,taCenter)
        else PaintRect(StatusRect,'',taCenter);
      Inc(StatusRect.Left,FieldWidth+Space);
      FieldWidth:=Canvas.TextWidth(sbScrollStr)+10;
      StatusRect.Right := IntFindMin(ClientRect.Right,StatusRect.Left+FieldWidth);
      if (FKeyState and ksScrollLock) <> 0
        then PaintRect(StatusRect,sbScrollStr,taCenter)
        else PaintRect(StatusRect,'',taCenter);
      Inc(StatusRect.Left,FieldWidth+Space);
      RWidth:=(ClientRect.Right-StatusRect.Left- (Space * rmNumberOfMonitors)) div rmNumberOfMonitors;
      for x:=1 to rmNumberOfMonitors do
        begin
          if (x=rmNumberOfMonitors)
            then RWidth := ClientRect.Right;
              StatusRect.Right := IntFindMin(StatusRect.Left + RWidth,ClientRect.Right-Space);
              PaintGaugeRect(StatusRect,ResMonitors[x]+IntToStr(FResources[x])+'%',FResources[x]);
              StatusRect.Left := StatusRect.Right + Space;
        end;
    end;
  SetBkColor(Canvas.Handle,OldColor);
end;

procedure TStatusBar.SetAlertLevel(Value: Integer);
begin
  if (FAlertLevel <> Value)
    then begin
      FAlertLevel := IntFindMax(IntFindMin(Value,100),0);
      Invalidate;
    end;
end;

procedure TStatusBar.SetBevel(Value: TPanelBevel);
begin
  FBevel := Value;
  Invalidate;
end;

procedure TStatusBar.SetBevelWidth(Value: Integer);
begin
  FBevelWidth := Value;
  Invalidate;
end;

procedure TStatusBar.SetBounds(ALeft, ATop, AWidth, AHeight: Integer);
begin
  inherited SetBounds(ALeft, ATop, AWidth, AHeight);
end;

procedure TStatusBar.SetStatusMode(Value: TStatusMode);
var
  Msg: TMsg;
begin
  FillChar(FResources,SizeOf(FResources),0);
  FLastPaint:='';
  FLastHelp:='';
  if (FStatusMode <> Value)
    then begin
      FStatusMode := Value;
      WMTimer(Msg);
    end;
end;

procedure TStatusBar.SetSpace(Value: Integer);
begin
  FSpace := Value;
  Invalidate;
end;


procedure TStatusBar.WMDestroy(var Msg: TMsg);
begin
  KillTimer(Handle,1);
  inherited
end;

procedure TStatusBar.WMCreate(var Msg: TMsg);
begin
  SetTimer(Handle,1,200,NIL);
  inherited;
end;

procedure TStatusBar.WMTimer(var Msg: TMsg);
var
  NewKeyState: Integer;
  NewResources: TResourceMonitor;
  X: Integer;
  Change:Boolean;
begin
  Change:=FALSE;
  NewKeyState := 0;
  if (StatusMode = pmResources)
    then begin
      NewResources[rmGDIResources] := GetFreeSystemResources(GFSR_GDIResources);
      NewResources[rmSystemResources] := GetFreeSystemResources(GFSR_SystemResources);
      NewResources[rmUserResources] := GetFreeSystemResources(GFSR_UserResources);
      if (GetKeyState(VK_NUMLOCK) and $01) <> 0
        then Inc(NewKeyState,ksNumLock);
      if (GetKeyState(VK_CAPITAL) and $01) <> 0
        then Inc(NewKeyState,ksCapsLock);
      if (GetKeyState(VK_SCROLL) and $01) <> 0
        then Inc(NewKeyState,ksScrollLock);
      if  (FKeyState <> NewKeyState)
        then begin
          FKeyState := NewKeyState;
          Change:=TRUE;
        end;
      for x := 1 to rmNumberOfMonitors do
        if (NewResources[x] <> FResources[x])
          then begin
            Move(NewResources,FResources,SizeOf(FResources));
            Change:=TRUE;
            Break;
          end;
      if Change
        then Paint;
    end
   else if (FLastPaint <> TimeToStr(Now)) or (FLastHelp<>HelpStr)
     then Paint;
  inherited;
end;

end.
