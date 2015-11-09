unit IntDate;

interface

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Menus, Forms, StdCtrls, Buttons, Dialogs;

const
  mBadDate='Data niew³aœciwa';

{CalPop}
  BORDER = 2;
  TEXT_INDENT = 2;
  BUTTON_WIDTH = 16;

{Dates}
  aDaysPerMonth: array[1..12] of Integer = (31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31);
  aDayTitles : Array[0..6] of string[2] = ('N ','Pn','Wt','Sr','Cz','Pt','So');
  plShortDayNames:array[1..7] of string[3]=
                  ('Nie','Pon','Wto','Œro','Czw','Pi¹','Sob');

  plLongDayNames:array[1..7] of string[15]=
                 ('Niedziela','Poniedzia³ek','Wtorek','Œroda','Czwartek','Pi¹tek','Sobota');

  plLongMonthNames:array[1..12] of string[15]=
                   ('Styczeñ','Luty','Marzec','Kwiecieñ','Maj','Czerwiec','Lipiec',
                    'Sierpieñ','Wrzesieñ','PaŸdziernik','Listopad','Grudzieñ');

  plShortMonthNames:array[1..12] of string[3]=
                    ('Sty','Lut','Mar','Kwi','Maj','Cze','Lip','Sie','Wrz','Pa¿','Lis','Gru');



type
  TDateOrder = (doMonthDayYear, doDayMonthYear, doYearMonthDay);
  TErrorSignal = (esBeep, esVisual, esBeepVisual); {how to show an error}
  SelIndex = 0..9;

  TDateButton = class( TBitBtn )
  private
  protected
     procedure Click; override;
  public
  published
  end;

type
  TCalendar = class( TForm )
    procedure FormCancel;
    procedure FormMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormPaint(Sender: TObject);
  private
    FCurrentDateSelected: TDateTime;
    FFontWidth : Integer;
    FFontHeight : Integer;
    FDateArray : array[1..42] of string[2];
    FCurrentDateIndex : Integer;
    FPreviousDateIndex : Integer;
    FPreviousDateRect : TRect;
    FMouseDown : BOOL;
    FCurrentDay, FCurrentYear, FCurrentMonth : Word;
    FPreviousDay, FPreviousYear, FPreviousMonth : Word;
    ctlParent: TComponent;
  protected
    function DaysInMonth(nMonth : Integer): Integer;
    procedure DrawButtons;
    procedure DrawCalendarBorder;
    procedure DrawDates;
    procedure DrawDaysHeader;
    procedure DrawFocusFrame(nIndex : Integer);
    procedure DrawMonthHeader;
    function GetMonthBegin: Integer;
    function GetCalendarRect : TRect;
    function GetLeftButtonRect : TRect;
    function GetRightButtonRect : TRect;
    function GetRectFromIndex(nIndex : Integer): TRect;
    function GetIndexFromDate : Integer;
    function GetIndexFromPoint(nLeft : Integer ; nTop : Integer) : Integer;
    function IsLeapYear: Boolean;
    procedure LoadDateArray ;
    procedure NextDay;
    procedure PrevDay;
    procedure NextWeek;
    procedure PrevWeek;
    procedure NextMonth;
    procedure PrevMonth;
    procedure NextYear;
    procedure PrevYear;
    procedure SetDate(nDays : Integer);
  public
    constructor Create( AOwner: TComponent ); override;
  end;

  TIntDate = class(TCustomEdit)
  private
    FButton: TDateButton;
    AllDigits: set of SelIndex;
    DayDigit: SelIndex;
    MonthDigit: SelIndex;
    YearDigit: SelIndex;
    Separators: set of SelIndex;
    TOList: TList;
    FSelText: PChar;
    FEditDate: TDateTime;
    FCentury: Boolean;
    FDayLeadingZero: Boolean;
    FEmptyChar: Char;
    FMonthLeadingZero: Boolean;
    FOrder: TDateOrder;
    FErrorSignal:TErrorSignal;
    FSeparator: Char;
    FUseCurrentDate: Boolean;
    FEmptyDate: Boolean; {Date field may be empty}
    procedure SetEditDate(Value: TDateTime);
    function GetDateElement(Index: integer): integer;
    procedure SetDateElement(Index: integer; Value: integer);
    procedure SetEmptyChar(Value: char);
    procedure SetInternational;
    procedure SetOrder(Value: TDateOrder);
    procedure SetUseCurrentDate(Value: boolean);
    function IsValidChar(Pos: word; Key: char): boolean;
    function DaysPerMonth(AYear, AMonth: Integer): Integer;
  protected
    procedure WMSize( var Message: TWMSize ); message WM_SIZE;
    procedure CreateParams(var Params: TCreateParams); override;
    procedure CreateWnd; override;
    procedure DoEnter; override;
    procedure DoExit; override;
    procedure KeyPress(var Key: Char); override;
    function ValidateDate: TDateTime; virtual;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure UpdateEdit; virtual;
    property EditDate: TDateTime read FEditDate write SetEditDate;
  published
    property AcceptEmptyDate: Boolean read FEmptyDate write FEmptyDate default TRUE;
    property AutoSelect default false;
    property AutoSize;
    property BorderStyle;
    property Century: Boolean read FCentury  ;
    property Color;
    property Ctl3D;
    property Day: integer index 1 read GetDateElement write SetDateElement
        stored False;
    property DragCursor;
    property DragMode;
    property EmptyChar: char read FEmptyChar write SetEmptyChar default ' ';
    property Enabled;
    property ErrorSignal: TErrorSignal read FErrorSignal write FErrorSignal default esBeep;
    property Font;
    property Month: integer index 2 read GetDateElement write SetDateElement
        stored False;
    property Order: TDateOrder read FOrder;
    property ParentColor;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ReadOnly;
    property Separator: Char read FSeparator;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property UseCurrentDate: Boolean read FUseCurrentDate
        write SetUseCurrentDate default True;
    property Visible;
    property Width default 97;
    property Year: integer index 3 read GetDateElement write SetDateElement
        stored False;
    property OnChange;
    property OnClick;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
  end;

procedure Register;

implementation

{$R INTDATE}
{$R *.DFM}

procedure Register;
begin
  RegisterComponents('Telesoft', [TIntDate]);
end;

type
TSelected = record
    Start: word;
    Stop: word;
end;
TSelectedPtr = ^TSelected;


{--- TDateButton ---}
procedure TDateButton.Click;
var
  dt: TDateTime;
  DateParent: TIntDate;
  Calendar: TCalendar;
begin
  DateParent := TIntDate( Parent );
  dt:=DateParent.ValidateDate;
  if dt < 0
    then DateParent.UpdateEdit
    else DateParent.FEditDate := dt;
  Calendar := TCalendar.Create( DateParent );
  Calendar.ShowModal;
  Calendar.Free;
  inherited Click;
  DateParent.SetFocus;
end;

{ --------------------------- TIntDate-class ------------------------------- }

constructor TIntDate.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  TOList := TList.Create;
  FSelText := StrAlloc(11);
  AutoSelect := false;
  FEmptyChar := ' ';
  FEditDate := Date;
  FUseCurrentDate := true;
  FEmptyDate:=TRUE;
  SetInternational;
  FButton := TDateButton.Create( self );
  FButton.Visible := TRUE;
  FButton.Parent := self;
  FButton.Glyph.Handle := LoadBitmap( hInstance, 'CALENDAR' );
  ControlStyle := ControlStyle - [csSetCaption];
  Width:=97;
end;

destructor TIntDate.Destroy;
begin
    TOList.Free;
    StrDispose(FSelText);
  FButton := nil;
    inherited Destroy
end;

procedure TIntDate.WMSize( var Message: TWMSize );
begin
  FButton.Height := Height;
  FButton.Width := Height;
  FButton.Left := Abs(Width - Height);
  FButton.Refresh;
  {  if FDate = 0.0 then
     Date := Now;}
end;

procedure TIntDate.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  Params.Style := Params.Style or ES_MULTILINE or WS_CLIPCHILDREN;
end;

procedure TIntDate.CreateWnd;
var Loc: TRect;
begin
  inherited CreateWnd;
  SendMessage(Handle, EM_GETRECT, 0, LongInt(@Loc));
  Loc.Bottom := ClientHeight + 1;  {+1 is workaround for windows paint bug}
  Loc.Right := ClientWidth - 1;
  Loc.Top := 0;
  Loc.Left := 0;
  SendMessage(Handle, EM_SETRECTNP, 0, LongInt(@Loc));
end;

procedure TIntDate.DoEnter;
var sel: TSelectedPtr;
    ret: longint;
begin
  inherited DoEnter;
  sel := TSelectedPtr(@ret);
  sel^.Start := 0;
  if AutoSelect then sel^.Stop := MaxLength
  else sel^.Stop := 0;
  SendMessage(Handle, EM_SETSEL, 0, ret);
end;

procedure TIntDate.DoExit;
var dt: TDateTime;
begin
  dt := ValidateDate;
  if dt < 0
    then begin
      case FErrorSignal of
        esBeep:
          MessageBeep(0);
        esVisual:
          MessageDlg(mBadDate,mtError,[mbOk],0);
        esBeepVisual:
          begin
            MessageBeep(0);
            MessageDlg(mBadDate,mtError,[mbOk],0);
          end;
      end;{case}
      UpdateEdit;
      SetFocus;
    end
    else begin
      FEditDate := dt;
      if dt=0
        then Text:='';   
      inherited DoExit
    end;
end;

procedure TIntDate.KeyPress(var Key: Char);
var sel: TSelectedPtr;
    ret: longint;
    dt: TDateTime;
    sl, i: word;
    wc: TWinControl;
    db: TButton;
    bs: boolean;
begin
    if Key = #13 then begin
        wc := self;
        while wc.Parent <> nil do
            wc := wc.Parent;
        wc.GetTabOrderList(TOList);
        db := nil;
        while TOList.Count > 0 do begin
            wc := TWinControl(TOList[0]);
            if (wc is TButton) and ((wc as TButton).Default) then
                db := (wc as TButton);
            TOList.Delete(0)
        end;
        if db <> nil then begin
            dt := ValidateDate;
            if dt >= 0 then begin
                FEditDate := dt;
                db.Click
            end else begin
                MessageBeep(0);
                UpdateEdit;
                SetFocus;
            end
        end
    end
    else begin
        ret := SendMessage(Handle, EM_GETSEL, 0, 0);
        sel := TSelectedPtr(@ret);
        if IsValidChar(sel^.Start, Key) then begin
            sl := sel^.Stop - sel^.Start;
            if Key = char(VK_BACK) then begin
                if sl = 0 then begin
                    Sel^.Start := Sel^.Start - 1;
                    if Sel^.Start in Separators then
                        Sel^.Start := Sel^.Start - 1;
                end;
                bs := true;
                Key := FEmptyChar;
            end;
            if (sel^.Start in Separators) then
                Key := FSeparator;
            if sl = 0 then begin
                sl := 1;
                sel^.Stop := Sel^.Start + sl;
                SendMessage(Handle, EM_SETSEL, 0, ret)
            end;
            if Key=' ' then
              Key:=FEmptyChar;
            FSelText[0]:=Key;
            i:=1;
            while i<sl do
              begin
                if sel^.Start + i in Separators then Key := FSeparator
                else Key := FEmptyChar;
                FSelText[i] := Key;
                Inc(i)
              end;
            FSelText[i] := #0;
            SendMessage(Handle, EM_REPLACESEL, 0, longint(FSelText));
            if not bs then begin
                Inc(sel^.Start);
                if sel^.Start in Separators
                  then Inc(sel^.Start);
            end;
            sel^.Stop := sel^.Start;
            SendMessage(Handle, EM_SETSEL, 0, ret);
        end
        else MessageBeep(0);
    end;
    Key := #0;
    inherited KeyPress(Key);
end;

function TIntDate.IsValidChar(Pos: word; Key: char): boolean;
begin
    if Key = char(VK_BACK) then Result := true
    else if Pos = DayDigit then Result := (Key in [' ', '0'..'3'])
    else if Pos = MonthDigit then Result := (Key in [' ', '0'..'1'])
    else if Pos in AllDigits then Result := (Key in ['0'..'9'])
    else if Pos in Separators then Result := true
    else Result := false;
end;

procedure TIntDate.SetEditDate(Value: TDateTime);
begin
  Value := Value - Frac(Value);
  if Value <> FEditDate
    then begin
      FEditDate := Value;
      UpdateEdit;
    end;
end;

procedure TIntDate.UpdateEdit;
var AYear, AMonth, ADay: word;
    AText, tx: string[10];
    i: integer;
    dt, mt: Char;
begin
    AText := '';
    for i := 1 to MaxLength do
        AText := AText + FEmptyChar;
    if FEditDate<>0
      then begin
        if FDayLeadingZero then dt := '0'
        else dt := EmptyChar;
        if FMonthLeadingZero then mt := '0'
        else mt := EmptyChar;
        DecodeDate(FEditDate, AYear, AMonth, ADay);
        tx := IntToStr(ADay);
        if ADay >= 10 then begin
            AText[DayDigit + 1] := tx[1];
            AText[DayDigit + 2] := tx[2]
        end else begin
            AText[DayDigit + 1] := dt;
            AText[DayDigit + 2] := tx[1]
        end;
        tx := IntToStr(AMonth);
        if AMonth >= 10 then begin
            AText[MonthDigit + 1] := tx[1];
            AText[MonthDigit + 2] := tx[2]
        end else begin
            AText[MonthDigit + 1] := mt;
            AText[MonthDigit + 2] := tx[1]
        end;
        tx := IntToStr(AYear);
        if Length(tx) <> 4 then Exit;
        if FCentury then
            for i := 1 to 4 do AText[YearDigit + i] := tx[i]
        else
            for i := 1 to 2 do AText[YearDigit + i] := tx[i + 2];
        for i := 1 to MaxLength do
            if (i - 1) in Separators then AText[i] := FSeparator;
      end;
    Text := AText;
end;

function TIntDate.GetDateElement(Index: Integer): Integer;
var
  AYear, AMonth, ADay: Word;
begin
  DecodeDate(FEditDate, AYear, AMonth, ADay);
  case Index of
    1: Result := ADay;
    2: Result := AMonth;
    3: Result := AYear;
    else Result := -1;
  end;
end;

procedure TIntDate.SetDateElement(Index: Integer; Value: Integer);
var AYear, AMonth, ADay: Word;
    ADate: TDateTime;
begin
    try
        DecodeDate(ADate, AYear, AMonth, ADay);
        case Index of
            1: ADate := EncodeDate(AYear, AMonth, Value);
            2: ADate := EncodeDate(AYear, Value, ADay);
            3: ADate := EncodeDate(Value, AMonth, ADay);
            else Exit;
        end;
        FUseCurrentDate := False;
        SetEditDate(ADate)
    except
        on EConvertError do begin
            MessageBeep(0);
            SetFocus
        end
        else raise
    end;
end;

procedure TIntDate.SetInternational;
var i, d, m, y: integer;
    st: string[16];
begin
  st := LowerCase(GetProfileStr('Intl'#0, 'sShortDate'#0,
      'mm/dd/yyyy'));
  FSeparator := #0;
  for i := 1 to Length(st) do
      if st[i] = 'y' then y := i
      else if st[i] = 'm' then m := i
      else if st[i] = 'd' then d := i
      else if FSeparator = #0 then FSeparator := st[i];
  FCentury := ((y > 2) and (st[y - 3] = 'y'));
  FDayLeadingZero := ((d > 0) and (st[d - 1] = 'd'));
  FMonthLeadingZero := ((m > 0) and (st[m - 1] = 'm'));
  if (m < d) and (m < y) then SetOrder(doMonthDayYear)
  else if (d < m) and (m < y) then SetOrder(doDayMonthYear)
  else SetOrder(doYearMonthDay);
end;

procedure TIntDate.SetOrder(Value: TDateOrder);
var st: SelIndex;
begin
  if (Value = doMonthDayYear) or (Value = doDayMonthYear)
    then begin
      AllDigits := [1, 4, 6, 7];
      YearDigit := 6;
      if FCentury
        then AllDigits := AllDigits + [8, 9];
      if Value = doMonthDayYear
        then begin
          MonthDigit := 0;
          DayDigit := 3;
        end
        else begin
          MonthDigit := 3;
          DayDigit := 0;
        end;
      Separators := [2, 5];
    end
    else begin
      YearDigit := 0;
      if FCentury
        then begin
          AllDigits := [0, 1, 2, 3, 6, 9];
          MonthDigit := 5;
          DayDigit := 8;
          Separators := [4, 7];
        end
        else begin
          AllDigits := [0, 1, 4, 7];
          MonthDigit := 3;
          DayDigit := 6;
          Separators := [2, 5];
        end
    end;
  if FCentury
    then MaxLength := 10
    else MaxLength := 8;
  FOrder := Value;
  UpdateEdit;
end;

procedure TIntDate.SetEmptyChar(Value: char);
begin
  if Value <> FEmptyChar
    then begin
      FEmptyChar := Value;
      UpdateEdit;
    end
end;

procedure TIntDate.SetUseCurrentDate(Value: boolean);
begin
  if Value <> FUseCurrentDate
    then begin
      FUseCurrentDate := Value;
      if Value
        then SetEditDate(Date);
    end
end;

function TIntDate.ValidateDate: TDateTime;
var AYear, AMonth, ADay: word;
begin
  try
    if FCentury
      then AYear := StrToIntDef(Copy(Text, YearDigit + 1, 4), 0)
      else begin
        DecodeDate(Date, AYear, AMonth, ADay);
        AYear := ((AYear div 100) * 100) +
            StrToIntDef(Copy(Text, YearDigit + 1, 2), 0);
      end;
    if Text[MonthDigit + 1] = FEmptyChar
      then AMonth := StrToIntDef(Copy(Text, MonthDigit + 2, 1), 0)
      else AMonth := StrToIntDef(Copy(Text, MonthDigit + 1, 2), 0);
    if Text[DayDigit + 1] = FEmptyChar
      then ADay := StrToIntDef(Copy(Text, DayDigit + 2, 1), 0)
      else ADay := StrToIntDef(Copy(Text, DayDigit + 1, 2), 0);
    if (AYear > 0) and (AMonth > 0) and (ADay > 0) and
       (AMonth <= 12) and (ADay <= DaysPerMonth(AYear, AMonth))
      then Result := EncodeDate(AYear, AMonth, ADay)
      else begin
        if FEmptyDate and (AYear=0) and (AMonth=0) and (ADay=0)
          then Result:=0
          else Result:=-1;
      end;
  except
    on EConvertError do Result := -1;
    else raise
  end;
end;

function TIntDate.DaysPerMonth(AYear, AMonth: Integer): Integer;
const
  DaysInMonth: array[1..12] of Integer =
    (31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31);
begin
  Result := DaysInMonth[AMonth];
  if (AMonth = 2) and (AYear mod 4 = 0) and ((AYear mod 100 <> 0) or
     (AYear mod 400 = 0))
    then Inc(Result);
end;

{-----------  Calendar Form  ------------}

function PointInRect( const rectTest: TRect; X, Y: integer ): boolean;
begin
  Result := ( ( X >= rectTest.Left ) and ( X <= rectTest.Right ) and
     ( Y >= rectTest.Top ) and ( Y <= rectTest.Bottom ) );
end;

constructor TCalendar.Create(AOwner: TComponent);
var
   tmTextMetrics : TTextMetric;
   editOwner: TCustomEdit;
   rectPlace: TRect;
   ptUpper, ptLower: TPoint;
   i:Byte;
begin
  inherited Create(AOwner);

  {If the FontWidth is not set, determine Font Height and Width for positioning Dates}
  with Canvas do
     begin
        Font.Name := 'MS Sans Serif';
        Font.Size := 6;
        Pen.Color := clBlack;
        GetTextMetrics(Handle, tmTextMetrics);
        FFontWidth :=  Round(tmTextMetrics.tmAveCharWidth + tmTextMetrics.tmAveCharWidth * 6 / 10);
        FFontHeight :=  Round(tmTextMetrics.tmHeight + tmTextMetrics.tmHeight / 3);
     end;

  {Initialize form Height & Width based on Font }
  Height := (FFontHeight * 6) + (FFontHeight * 2) + BORDER;
  Width := ((FFontWidth *3) * 7) + (2* BORDER) + (2* TEXT_INDENT);

{ Dynamically set the size and position }
  editOwner := TIntDate( AOwner );
  ctlParent := editOwner;
  rectPlace := editOwner.ClientRect;
  ptUpper.X := rectPlace.Left;
  ptUpper.Y := rectPlace.Top;
  ptUpper := editOwner.ClientToScreen( ptUpper );
  ptLower.X := rectPlace.Right;
  ptLower.Y := rectPlace.Bottom;
  ptLower := editOwner.ClientToScreen( ptLower );

  { If too far down, pop the calendar above the control }
  if ptUpper.X + 1 + Width > Screen.Width then
     Left := Screen.Width - Width - 1
  else
     Left := ptUpper.X + 1;
  if ptLower.Y + 1 + Height > Screen.Height then
     Top := ptUpper.Y - Height
  else
     Top := ptLower.Y + 1;

  { define initial date }
{  if TIntDate( ctlParent ).Text <> ''
    then} try
      FCurrentDateSelected := TIntDate( ctlParent ).EditDate;
      if FCurrentDateSelected<=0
        then FCurrentDateSelected := Date;
    except
      FCurrentDateSelected := Date;
    end;
  {Extract date Components}
  DecodeDate( FCurrentDateSelected, FCurrentYear, FCurrentMonth, FCurrentDay );
  FCurrentDateIndex := FCurrentDay + GetMonthBegin - 1;
  FPreviousDateIndex := 0;

  LoadDateArray;
  FMouseDown := False;
  for i:=1 to 7 do
    begin
      ShortDayNames[i]:=plShortDayNames[i];
      LongDayNames[i]:=plLongDayNames[i];
    end;
  for i:=1 to 12 do
    begin
      ShortMonthNames[i]:=plShortMonthNames[i];
      LongMonthNames[i]:=plLongMonthNames[i];
    end;

end;

function TCalendar.DaysInMonth(nMonth : Integer): Integer;
begin
  Result := aDaysPerMonth[nMonth];
  if ( nMonth = 2 ) and IsLeapYear then Inc( Result ); { leap-year Feb is special }
end;

procedure TCalendar.DrawButtons;
var
  LeftButtonRect: TRect;
  RightButtonRect : TRect;
  OldStyle : TBrushStyle;
begin
  with Canvas do
    begin
      LeftButtonRect := GetLeftButtonRect;
      RightButtonRect := GetRightButtonRect;

      { Select Black Pen}
      Pen.Style := psSolid;
      Pen.Width := 1;
      Pen.Color := clBlack;

      { Draw Button Outlines }
      Rectangle( LeftButtonRect.Left, LeftButtonRect.Top, LeftButtonRect.Right, LeftButtonRect.Bottom );
      Rectangle( RightButtonRect.Left, RightButtonRect.Top, RightButtonRect.Right, RightButtonRect.Bottom );

      { Create Embossed effect - Outline left & upper in white}
      Pen.Color := clWhite;
      MoveTo( LeftButtonRect.Left + 1, LeftButtonRect.Bottom - 2 );
      LineTo( LeftButtonRect.Left + 1, LeftButtonRect.Top + 1 );
      LineTo( LeftButtonRect.Right - 2, LeftButtonRect.Top + 1 );

      MoveTo( RightButtonRect.Left + 1, RightButtonRect.Bottom - 2 );
      LineTo( RightButtonRect.Left + 1, RightButtonRect.Top + 1 );
      LineTo( RightButtonRect.Right - 2, RightButtonRect.Top + 1 );

      { Create Embossed effect - Outline right & bottom in gray }
      Pen.Color := clGray;
      MoveTo( LeftButtonRect.Right -2, LeftButtonRect.Top +  1 );
      LineTo( LeftButtonRect.Right - 2, LeftButtonRect.Bottom - 2 );
      LineTo( LeftButtonRect.Left + 1, LeftButtonRect.Bottom - 2 );

      MoveTo( RightButtonRect.Right - 2, RightButtonRect.Top + 1 );
      LineTo( RightButtonRect.Right - 2, RightButtonRect.Bottom - 2 );
      LineTo( RightButtonRect.Left + 1, RightButtonRect.Bottom - 2 );

      {Draw Arrow}
      Brush.Color := clBlack;
      OldStyle :=Brush.Style;
      Brush.Style := bsSolid;
      Polygon([Point(LeftButtonRect.Right - 5,LeftButtonRect.Top + 3),
               Point(LeftButtonRect.Right - 5,LeftButtonRect.Bottom - 4),
               Point(LeftButtonRect.Left + 3,LeftButtonRect.Top + 7)]);
      Polygon([Point(RightButtonRect.Left + 4,RightButtonRect.Top + 3),
               Point(RightButtonRect.Left + 4,RightButtonRect.Bottom - 4),
               Point(RightButtonRect.Right - 4,RightButtonRect.Top + 7)]);
      Brush.Color :=clSilver;
      Brush.Style := OldStyle;
      Pen.Color := clBlack;
    end;
end;

procedure TCalendar.DrawCalendarBorder;
var
  rectDraw: TRect;
begin
  rectDraw := ClientRect;
  with Canvas do
     begin
        { Select Black Pen to outline Window }
        Pen.Style := psSolid;
        Pen.Width := 1;
        Pen.Color := clBlack;

        { Outline the window in black }
        Rectangle( rectDraw.Left, rectDraw.Top, rectDraw.Right, rectDraw.Bottom );

        { Create Embossed effect - Outline left & upper in white}
        Pen.Color := clWhite;
        MoveTo( 0, rectDraw.Bottom - 1 );
        LineTo( 0, 0 );
        LineTo( rectDraw.Right - 1, 0 );

        { Create Embossed effect - Outline right & bottom in gray }
        Pen.Color := clGray;
        LineTo( rectDraw.Right - 1, rectDraw.Bottom - 1 );
        LineTo( 0, rectDraw.Bottom - 1 );

        { Reset Pen Color }
        Pen.Color := clBlack;
     end;
end;

procedure TCalendar.DrawDates;
var
   nIndex, nWeek, nDay: Integer;
   pDate: PChar;
   TempRect: Trect;
   dtTest: TDateTime;
begin
  pDate := StrAlloc( 3 );

  With Canvas do
     begin
        { Define normal font }
        Font.Style := [];
        Pen.Color := clBlack;

        { Cycle through the weeks }
        for nWeek := 1 to 6 do
           begin
              { Cycle through the days }
              for nDay := 1 to 7 Do
                 begin
                    nIndex := nDay + ( ( nWeek - 1 ) * 7 );
                    StrPCopy( pDate, FDateArray[nIndex] );
                    if FDateArray[nIndex] <> '  ' then
                       begin
                          dtTest := EncodeDate( FCurrentYear, FCurrentMonth, StrToInt( FDateArray[nIndex] ) );
{                          if ( ctlParent as TIntDate ).DateInList( dtTest ) then
                             Font.Color := ( ctlParent as TDateEdit ).ValidDateColor
                          else}
                             Font.Color := clBlack;
                       end;
                    TempRect := GetCalendarRect;

                    With TempRect Do
                    begin
                       Left := Left + ((FFontWidth * 3) * (nDay - 1));
                       Top := (FFontHeight * nWeek ) + FFontHeight + Border;
                       Bottom := Top +  FFontHeight ;
                       Right := Left + FfontWidth * 3;
                    end;

                    DrawText( Handle, pDate, Length( FDateArray[nIndex] ),
                              TempRect, ( DT_CENTER or DT_VCENTER or DT_TOP or DT_SINGLELINE ) );

                 end;
                 nIndex := nIndex;
           end;
     end;
     StrDispose( pDate );
end;

procedure TCalendar.DrawDaysHeader;
var
   i: Integer;
   pDay: PChar;
   TempRect: Trect;
begin
  pDay := StrAlloc( 3 );

  { Calculate Rect Top.  2nd line = FontHeight * 2 }
  TempRect := ClientRect;
  TempRect.Top := FFontHeight + BORDER;
  TempRect.Bottom := TempRect.Top + FFontHeight;

  {Calculate each date rect. rect = FontWidth * 3 (width of two chars + space) }
  TempRect.Left := TempRect.Left + BORDER + TEXT_INDENT;
  TempRect.Right := BORDER + TEXT_INDENT + ( FFontWidth * 3 );

  { Cycle through the days }
  for i := 0 to 6 do
     begin
        StrPCopy( pDay, aDayTitles[i] );
        DrawText( Canvas.Handle, pDay, 2, TempRect,
                ( DT_CENTER or DT_TOP or DT_SINGLELINE ) );
        TempRect.Left := TempRect.Right;
        TempRect.Right := TempRect.Right + FFontWidth * 3;
     end;

     { Draw line below days }
     with Canvas do
        begin
           TempRect.Top := TempRect.Bottom - 3;
           TempRect.Bottom := TempRect.Top + 2;
           TempRect.Left := ClientRect.Left + BORDER + TEXT_INDENT;
           TempRect.Right := BORDER + TEXT_INDENT + ( FFontWidth * 3 * 7 );

           Pen.Color := clGray;
           MoveTo( TempRect.Left , TempRect.Top);
           LineTo( TempRect.Right, TempRect.Top );
           Pen.Color := clWhite;
           MoveTo( TempRect.Left,  TempRect.Top + 1 );
           LineTo( TempRect.Right, TempRect.Top + 1  );
        end;

     StrDispose( pDay );
end;

procedure TCalendar.DrawMonthHeader;
var
   sMonth : String;
   pMonth : PChar;
   TempRect : Trect;
begin
  pMonth := StrAlloc( 30 );
  with Canvas do
     begin
        Font.Style := [fsBold];
        Font.Color := clBlack;
        sMonth := FormatDateTime( 'd mmmm yyyy', FCurrentDateSelected );

        pMonth := StrAlloc( Length( sMonth ) + 1 );
        StrPCopy( pMonth, sMonth );

        TempRect := ClientRect;
        TempRect.Top := BORDER;
        TempRect.Left := BORDER + TEXT_INDENT + BUTTON_WIDTH;
        TempRect.Right := TempRect.Right - BORDER - TEXT_INDENT - BUTTON_WIDTH;
        TempRect.Bottom := FFontHeight;

        Brush.Color := clSilver;
        Brush.Style := bsSolid;
        FillRect( TempRect );

        DrawText( Handle, pMonth, Length( sMonth ), TempRect,
                ( DT_CENTER or DT_VCENTER or DT_BOTTOM or DT_SINGLELINE ) );
     end;
     StrDispose( pMonth );
end;

procedure TCalendar.DrawFocusFrame( nIndex: Integer);
var
  pDate :PChar;
  TempRect : TRect;
  dtTest: TDateTime;
begin
  pDate := StrAlloc( 3 );
  If ( nIndex > 0 ) and ( nIndex < 42 ) then
     If FDateArray[nIndex] <> '  ' then
        begin
           { Erase Previous Date Focus}
           If FPreviousDateIndex > 0 Then
              begin
                 Canvas.Font.Style := [];
                 StrPCopy( pDate, FDateArray[FPreviousDateIndex] );
                 Canvas.Brush.Color := clSilver;
                 TempRect := GetRectFromIndex(FPreviousDateIndex);
                 Canvas.FillRect(TempRect);
                 DrawText( Canvas.Handle, pDate, Length( FDateArray[FPreviousDateIndex] ),
                           TempRect, ( DT_CENTER or DT_VCENTER or DT_TOP or DT_SINGLELINE ) );
              end;

           {Draw the Date in Bold font}
           Canvas.Font.Style := [fsBold];
           dtTest := EncodeDate( FCurrentYear, FCurrentMonth, StrToInt( FDateArray[nIndex] ) );
{           if ( ctlParent as TIntDate ).DateInList( dtTest ) then
              Canvas.Font.Color := ( ctlParent as TDateEdit ).ValidDateColor
           else}
              Canvas.Font.Color := clBlack;
           TempRect := GetRectFromIndex(nIndex);
           StrPCopy( pDate, FDateArray[nIndex] );
           DrawText( Canvas.Handle, pDate, Length( FDateArray[nIndex] ),
                     TempRect, ( DT_CENTER or DT_VCENTER or DT_TOP or DT_SINGLELINE ) );

           { Frame date with Highlight }
           Canvas.Pen.Color := clWhite;
           Canvas.MoveTo( TempRect.Left, TempRect.Bottom - 1 );
           Canvas.LineTo( TempRect.Left, TempRect.Top );
           Canvas.LineTo( TempRect.Right - 1, TempRect.Top );

           { Frame date with Shadow }
           Canvas.Pen.Color := clGray;
           Canvas.LineTo( TempRect.Right - 1, TempRect.Bottom - 1 );
           Canvas.LineTo( TempRect.Left, TempRect.Bottom - 1 );

           { Restore Canvas settings}
           Canvas.Pen.Color := clBlack;
           Canvas.Font.Style := [];

        end;
  StrDispose( pDate );
end;

procedure TCalendar.FormCancel;
begin
  FMouseDown := False;
  ModalResult := -1;
end;

procedure TCalendar.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
     Case key of
          VK_Left : begin
                        PrevDay;
                        If (FCurrentMonth <> FPreviousMonth) or
                           (FCurrentYear <> FPreviousYear) Then
                           Refresh
                        else
                           DrawFocusFrame(FCurrentDateIndex);
                     end;
          VK_Right : begin
                        NextDay;

                        If (FCurrentMonth <> FPreviousMonth) or
                           (FCurrentYear <> FPreviousYear) Then
                           Refresh
                        else
                           DrawFocusFrame(FCurrentDateIndex);
                     end;
          VK_Up : begin
                        PrevWeek;
                        If (FCurrentMonth <> FPreviousMonth) or
                           (FCurrentYear <> FPreviousYear) Then
                           Refresh
                        else
                           DrawFocusFrame(FCurrentDateIndex);
                     end;
          VK_Down : begin
                        NextWeek;
                        If (FCurrentMonth <> FPreviousMonth) or
                           (FCurrentYear <> FPreviousYear) Then
                           Refresh
                        else
                           DrawFocusFrame(FCurrentDateIndex);
                     end;
          VK_Prior: begin
                        PrevMonth;
                        Refresh;
                     end;
          Vk_Next : begin
                        NextMonth;
                        Refresh;
                     end;

          VK_Home : begin
                        NextYear;
                        Refresh;
                     end;
          VK_End : begin
                        PrevYear;
                        Refresh;
                     end;
          VK_Return: begin
                        TIntDate( ctlParent ).EditDate := FCurrentDateSelected;
                        ModalResult := 1;
                     end;
          VK_Escape : FormCancel;
     else

     end;
end;

procedure TCalendar.FormMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  nIndex : Integer;
  Key: Word;
begin
  {Check if mouse was pressed in Left button area}
  if PointInRect(GetLeftButtonRect, X, Y) then
     begin
        Key := Vk_Prior;
        FormKeyDown(Sender, Key,Shift);
     end;

  {Check if mouse was pressed in Right button area}
  if PointInRect(GetRightButtonRect, X, Y) then
     begin
        Key := Vk_Next;
        FormKeyDown(Sender, Key,Shift);
     end;

  {Check if mouse was pressed in date area}
  if PointInRect(GetCalendarRect, X, Y) then
     begin
        FMouseDown := True;
        nIndex := GetIndexFromPoint( X, Y );

        If (nIndex >= GetMonthBegin) and
           (nIndex < (DaysInMonth(FCurrentMonth) + GetMonthBegin)) Then
           begin
             SetDate(nIndex - FCurrentDateIndex);
             DrawFocusFrame(nIndex);
           end
        else
            FMouseDown := False;

     end;
end;

procedure TCalendar.FormMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
var
  nIndex : Integer;
begin
    If FMouseDown = True then
       begin
          if PointInRect(GetCalendarRect, X, Y) then
          begin
               nIndex := GetIndexFromPoint( X, Y );
               If (nIndex >= GetMonthBegin) and
                  (nIndex < (DaysInMonth(FCurrentMonth) + GetMonthBegin)) and
                  (nIndex <> FCurrentDateIndex) Then
               begin
                    SetDate(nIndex - FCurrentDateIndex);
                    DrawFocusFrame(nIndex);
               end;
          end;
       end;
end;

procedure TCalendar.FormMouseUp( Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer );
var
   TempRect : Trect;
begin
  If FMouseDown = True Then
     begin
        FMouseDown := False;
        TIntDate( ctlParent ).EditDate := FCurrentDateSelected;
        ModalResult := 1;
     end;
end;

procedure TCalendar.FormPaint(Sender: TObject);
begin
  DrawCalendarBorder;
  DrawMonthHeader;
  DrawDaysHeader;
  DrawDates;
  DrawButtons;
  DrawFocusFrame(FCurrentDateIndex);
end;

function TCalendar.GetLeftButtonRect: TRect;
var
  TempRect: TRect;
begin
   {Define Left Button Rectangle}
   TempRect.Top := ClientRect.Top + BORDER;
   TempRect.Bottom := TempRect.Top + BUTTON_WIDTH;
   TempRect.Left := ClientRect.Left + BORDER + TEXT_INDENT;
   TempRect.Right := TempRect.Left + BUTTON_WIDTH;
   Result := TempRect;
end;

function TCalendar.GetRightButtonRect: TRect;
var
  TempRect: TRect;
begin
   {Define Right Button Rectangle}
   TempRect.Top := ClientRect.Top + BORDER;
   TempRect.Bottom := TempRect.Top + BUTTON_WIDTH;
   TempRect.Right := BORDER + TEXT_INDENT + (FFontWidth * 3 * 7);
   TempRect.Left := TempRect.Right - BUTTON_WIDTH;
   Result := TempRect;
end;

function TCalendar.GetCalendarRect: TRect;
var
  TempRect: TRect;
begin
  TempRect := ClientRect;
  with TempRect do
    begin
      Left := BORDER + TEXT_INDENT;
      Top := ( FFontHeight * 2 ) + BORDER;
      Bottom := Top + ( FFontHeight * 6 );
      Right := Left + ( 7 * ( FfontWidth * 3 ) );
    end;
  Result := TempRect;
end;

function TCalendar.GetRectFromIndex(nIndex : Integer): TRect;
var
  TempRect: TRect;
  nWeek : Integer;
  nDay : Integer;
begin
  TempRect := GetCalendarRect;

  with TempRect do
     begin
        case nIndex of
             1..7 :  nWeek := 1;
             8..14:  nWeek := 2;
             15..21: nWeek := 3;
             22..28: nWeek := 4;
             29..35: nWeek := 5;
             36..42: nWeek := 6;
        end;

        nDay := nIndex - ((nWeek-1) *7);

        Left := Left + ((FFontWidth * 3) * (nDay-1));
        Top := (FFontHeight * nWeek ) + FFontHeight + BORDER;
        Bottom := Top +  FFontHeight ;
        Right := Left + FfontWidth * 3;
     end;

  Result := TempRect;
end;

function TCalendar.GetMonthBegin: Integer;
var
  FirstDate: TDateTime;
begin
  FirstDate := EncodeDate( FCurrentYear, FCurrentMonth, 1 );
  Result := DayOfWeek( FirstDate ); { day of week for 1st of month }
end;

function TCalendar.IsLeapYear: Boolean;
begin
  Result := ( FCurrentYear mod 4 = 0 ) and
            ( ( FCurrentYear mod 100 <> 0 ) or ( FCurrentYear mod 400 = 0 ) );
end;

procedure TCalendar.LoadDateArray;
var
  nIndex : Integer;
  nBeginIndex, nEndIndex : Integer;
begin
  nBeginIndex := GetMonthBegin;
  nEndIndex := nBeginIndex + DaysInMonth(FCurrentMonth) - 1;
  for nIndex := 1 to 42 do
  begin
     If ( nIndex < nBeginIndex ) or ( nIndex > nEndIndex ) Then
        FDateArray[nIndex] := '  '
     else
        FDateArray[nIndex] := IntToStr( ( nIndex - nBeginIndex ) + 1 );
  end;
end;

function TCalendar.GetIndexFromDate : Integer;
begin
  Result := FCurrentDay + GetMonthBegin;
end;

function TCalendar.GetIndexFromPoint(nLeft : Integer ; nTop : Integer) : Integer;
var
  nIndex, nWeek, nDay: Integer;
  nResult: Real;
  TempRect: Trect;
begin
  TempRect := GetCalendarRect;

  nIndex := -1;
  {Is point in the calendar rectangle?}
  if ( nLeft > TempRect.Left ) and ( nTop > TempRect.Top ) and
      ( nLeft < TempRect.Right ) and ( nTop < TempRect.Bottom ) then
     begin

        { Determine the week number of the selected date }
        nResult := ( nTop - BORDER ) / ( FFontHeight ) - 1;
        nWeek := Trunc( nResult );

        { Adjust Date Rect }
        TempRect.Top := TempRect.Top + ( ( nWeek - 1 ) * FFontHeight );
        TempRect.Bottom := TempRect.Top + FFontHeight;
        TempRect.Left := BORDER + TEXT_INDENT;
        TempRect.Right := TempRect.Left + FFontWidth * 3;

        { Determine the day number of the selected date }
        for nDay := 1 to 7 do        {Cycle through the days}
           begin
              nIndex := nDay + ( ( nWeek - 1 ) * 7 );
              if ( nLeft >= TempRect.Left ) and ( nLeft <= TempRect.Right ) then
                 break
              else
                 begin
                    TempRect.Left := TempRect.Right;
                    TempRect.Right := TempRect.Left + FFontWidth * 3;
                 end;
           end;
     end;
  Result := nIndex;
end;

procedure TCalendar.PrevDay;
begin
  SetDate(-1);
end;

procedure TCalendar.NextDay;
begin
  SetDate(1);
end;

procedure TCalendar.PrevWeek;
begin
  SetDate(-7);
end;

procedure TCalendar.NextWeek;
begin
  SetDate(7);
end;

procedure TCalendar.PrevMonth;
var
   nDays : Integer;
   nMonth : Integer;
begin
  if FCurrentMonth > 1 then
     nMonth := FCurrentMonth - 1
  else
     nMonth := 12;
  nDays := DaysInMonth(nMonth);
  SetDate(-nDays);
end;

procedure TCalendar.NextMonth;
begin
  SetDate(DaysInMonth(FCurrentMonth));
end;

{GetNextYear}
procedure TCalendar.NextYear;
begin

  {If the current year is a leap year and the date is
   before February 29, add 1 day}
  If IsLeapYear and (FCurrentMonth < 3) Then
     SetDate(1);

  SetDate(365);
  {If the current year is a leap year and the date is
   after February 29, add 1 day}
  If IsLeapYear and (FCurrentMonth > 3) Then
     SetDate(1);
end;

procedure TCalendar.PrevYear;
begin
  {If the current year is a leap year and the date is
   after February 29, subtract 1 day}
  If IsLeapYear and (FCurrentMonth > 3) Then
     SetDate(-1);

  SetDate(-365);
  {If the Previous year is a leap year and the date is
   before February 29, subtract 1 day}
  If IsLeapYear and (FCurrentMonth < 3) Then
     SetDate(-1);
end;

procedure TCalendar.SetDate(nDays : Integer);
begin
   {Save current date information}
   FPreviousDateIndex := FCurrentDateIndex;
   DecodeDate(FCurrentDateSelected,FPreviousYear,FPreviousMonth,FPreviousDay);

   {Change the date and update member variables}
   FCurrentDateSelected := FCurrentDateSelected + nDays;
   DecodeDate(FCurrentDateSelected,FCurrentYear,FCurrentMonth,FCurrentDay);
   FCurrentDateIndex := ( FCurrentDay + GetMonthBegin ) - 1;

   {Reload Date Array if month or year changed}
   If (FCurrentMonth <> FPreviousMonth) or (FCurrentYear <> FPreviousYear)Then
      LoadDateArray;
end;

end.
