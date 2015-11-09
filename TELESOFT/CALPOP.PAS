unit Calpop;

(*********************************************
This form unit is used by the DateEdit component.
*********************************************)

interface

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, Buttons, StdCtrls, Mask;

const
   m_DaysPerMonth: array[1..12] of Integer = (31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31);
   m_DayTitles : Array[0..6] of string[2] = ('N ','Pn','Wt','Sr','Cz','Pt','So');
   BORDER = 2;
   TEXT_INDENT = 2;
   BUTTON_WIDTH = 16;

const
{Dates}
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
  {////  Calendar Form Type Definition /////}
  TfrmCalPop = class( TForm )
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
    m_CurrentDateSelected: TDateTime;
    m_FontWidth : Integer;
    m_FontHeight : Integer;
    m_DateArray : array[1..42] of string[2];
    m_CurrentDateIndex : Integer;
    m_PreviousDateIndex : Integer;
    m_PreviousDateRect : TRect;
    m_MouseDown : BOOL;
    m_CurrentDay, m_CurrentYear, m_CurrentMonth : Word;
    m_PreviousDay, m_PreviousYear, m_PreviousMonth : Word;
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

var
  frmCalPop: TfrmCalPop;

implementation

{$R *.DFM}

uses
  DateEdit;

function PointInRect( const rectTest: TRect; X, Y: integer ): boolean;
begin
  Result := ( ( X >= rectTest.Left ) and ( X <= rectTest.Right ) and
     ( Y >= rectTest.Top ) and ( Y <= rectTest.Bottom ) );
end;

{************************** Create ************************
 *****  This procedure is used to initialize values   *****
 *****  for control owner, calendar position and      *****
 *****  other resources.                              *****
 **********************************************************}
constructor TfrmCalPop.Create(AOwner: TComponent);
var
   tmTextMetrics : TTextMetric;
   editOwner: TMaskEdit;
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
        m_FontWidth :=  Round(tmTextMetrics.tmAveCharWidth + tmTextMetrics.tmAveCharWidth * 6 / 10);
        m_FontHeight :=  Round(tmTextMetrics.tmHeight + tmTextMetrics.tmHeight / 3);
     end;

  {Initialize form Height & Width based on Font }
  Height := (m_FontHeight * 6) + (m_FontHeight * 2) + BORDER;
  Width := ((m_FontWidth *3) * 7) + (2* BORDER) + (2* TEXT_INDENT);

{ Dynamically set the size and position }
  editOwner := TDateEdit( AOwner );
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
{  if TDateEdit( ctlParent ).Text <> '' then}
  try
     m_CurrentDateSelected := StrToDate( TDateEdit( ctlParent ).Text )
{  else }
  except
     m_CurrentDateSelected := Date;
  end;
  {Extract date Components}
  DecodeDate( m_CurrentDateSelected, m_CurrentYear, m_CurrentMonth, m_CurrentDay );
  m_CurrentDateIndex := m_CurrentDay + GetMonthBegin - 1;
  m_PreviousDateIndex := 0;

  LoadDateArray;
  m_MouseDown := False;
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


{********************** Days In Month *********************
 *****  This function returns the number of days in   *****
 *****  the month specified in nMonth.                *****
 **********************************************************}
function TfrmCalPop.DaysInMonth(nMonth : Integer): Integer;
begin
  Result := m_DaysPerMonth[nMonth];
  if ( nMonth = 2 ) and IsLeapYear then Inc( Result ); { leap-year Feb is special }
end;


{******************** Draw Butttons ***********************
 **********************************************************}
procedure TfrmCalPop.DrawButtons;
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

{*************** Draw Calendar Border *********************
 **********************************************************}
procedure TfrmCalPop.DrawCalendarBorder;
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

{*********************** Draw Dates ***********************
 **********************************************************}
procedure TfrmCalPop.DrawDates;
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
                    StrPCopy( pDate, m_DateArray[nIndex] );
                    if m_DateArray[nIndex] <> '  ' then
                       begin
                          dtTest := EncodeDate( m_CurrentYear, m_CurrentMonth, StrToInt( m_DateArray[nIndex] ) );
                          if ( ctlParent as TDateEdit ).DateInList( dtTest ) then
                             Font.Color := ( ctlParent as TDateEdit ).ValidDateColor
                          else
                             Font.Color := clBlack;
                       end;
                    TempRect := GetCalendarRect;

                    With TempRect Do
                    begin
                       Left := Left + ((m_FontWidth * 3) * (nDay - 1));
                       Top := (m_FontHeight * nWeek ) + m_FontHeight + Border;
                       Bottom := Top +  m_FontHeight ;
                       Right := Left + m_fontWidth * 3;
                    end;

                    DrawText( Handle, pDate, Length( m_DateArray[nIndex] ),
                              TempRect, ( DT_CENTER or DT_VCENTER or DT_TOP or DT_SINGLELINE ) );

                 end;
                 nIndex := nIndex;
           end;
     end;
     StrDispose( pDate );
end;

{*********************** Draw Days ************************
 **********************************************************}
procedure TfrmCalPop.DrawDaysHeader;
var
   i: Integer;
   pDay: PChar;
   TempRect: Trect;
begin
  pDay := StrAlloc( 3 );

  { Calculate Rect Top.  2nd line = FontHeight * 2 }
  TempRect := ClientRect;
  TempRect.Top := m_FontHeight + BORDER;
  TempRect.Bottom := TempRect.Top + m_FontHeight;

  {Calculate each date rect. rect = FontWidth * 3 (width of two chars + space) }
  TempRect.Left := TempRect.Left + BORDER + TEXT_INDENT;
  TempRect.Right := BORDER + TEXT_INDENT + ( m_FontWidth * 3 );

  { Cycle through the days }
  for i := 0 to 6 do
     begin
        StrPCopy( pDay, m_DayTitles[i] );
        DrawText( Canvas.Handle, pDay, 2, TempRect,
                ( DT_CENTER or DT_TOP or DT_SINGLELINE ) );
        TempRect.Left := TempRect.Right;
        TempRect.Right := TempRect.Right + m_FontWidth * 3;
     end;

     { Draw line below days }
     with Canvas do
        begin
           TempRect.Top := TempRect.Bottom - 3;
           TempRect.Bottom := TempRect.Top + 2;
           TempRect.Left := ClientRect.Left + BORDER + TEXT_INDENT;
           TempRect.Right := BORDER + TEXT_INDENT + ( m_FontWidth * 3 * 7 );

           Pen.Color := clGray;
           MoveTo( TempRect.Left , TempRect.Top);
           LineTo( TempRect.Right, TempRect.Top );
           Pen.Color := clWhite;
           MoveTo( TempRect.Left,  TempRect.Top + 1 );
           LineTo( TempRect.Right, TempRect.Top + 1  );
        end;

     StrDispose( pDay );
end;

{******************** Draw Month Header *******************
 **********************************************************}
procedure TfrmCalPop.DrawMonthHeader;
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
        sMonth := FormatDateTime( 'mmmm d, yyyy', m_CurrentDateSelected );

        pMonth := StrAlloc( Length( sMonth ) + 1 );
        StrPCopy( pMonth, sMonth );

        TempRect := ClientRect;
        TempRect.Top := BORDER;
        TempRect.Left := BORDER + TEXT_INDENT + BUTTON_WIDTH;
        TempRect.Right := TempRect.Right - BORDER - TEXT_INDENT - BUTTON_WIDTH;
        TempRect.Bottom := m_FontHeight;

        Brush.Color := clSilver;
        Brush.Style := bsSolid;
        FillRect( TempRect );

        DrawText( Handle, pMonth, Length( sMonth ), TempRect,
                ( DT_CENTER or DT_VCENTER or DT_BOTTOM or DT_SINGLELINE ) );
     end;
     StrDispose( pMonth );
end;

{******************** Draw Focus Frame ********************
 **********************************************************}
procedure TfrmCalPop.DrawFocusFrame( nIndex: Integer);
var
  pDate :PChar;
  TempRect : TRect;
  dtTest: TDateTime;
begin
  pDate := StrAlloc( 3 );
  If ( nIndex > 0 ) and ( nIndex < 42 ) then
     If m_DateArray[nIndex] <> '  ' then
        begin
           { Erase Previous Date Focus}
           If m_PreviousDateIndex > 0 Then
              begin
                 Canvas.Font.Style := [];
                 StrPCopy( pDate, m_DateArray[m_PreviousDateIndex] );
                 Canvas.Brush.Color := clSilver;
                 TempRect := GetRectFromIndex(m_PreviousDateIndex);
                 Canvas.FillRect(TempRect);
                 DrawText( Canvas.Handle, pDate, Length( m_DateArray[m_PreviousDateIndex] ),
                           TempRect, ( DT_CENTER or DT_VCENTER or DT_TOP or DT_SINGLELINE ) );
              end;

           {Draw the Date in Bold font}
           Canvas.Font.Style := [fsBold];
           dtTest := EncodeDate( m_CurrentYear, m_CurrentMonth, StrToInt( m_DateArray[nIndex] ) );
           if ( ctlParent as TDateEdit ).DateInList( dtTest ) then
              Canvas.Font.Color := ( ctlParent as TDateEdit ).ValidDateColor
           else
              Canvas.Font.Color := clBlack;
           TempRect := GetRectFromIndex(nIndex);
           StrPCopy( pDate, m_DateArray[nIndex] );
           DrawText( Canvas.Handle, pDate, Length( m_DateArray[nIndex] ),
                     TempRect, ( DT_CENTER or DT_VCENTER or DT_TOP or DT_SINGLELINE ) );

           { Frame date with Shadow }
           Canvas.Pen.Color := clGray;
           Canvas.MoveTo( TempRect.Left, TempRect.Bottom - 1 );
           Canvas.LineTo( TempRect.Left, TempRect.Top );
           Canvas.LineTo( TempRect.Right - 1, TempRect.Top );

           { Frame date with Highlight }
           Canvas.Pen.Color := clWhite;
           Canvas.LineTo( TempRect.Right - 1, TempRect.Bottom - 1 );
           Canvas.LineTo( TempRect.Left, TempRect.Bottom - 1 );

           { Restore Canvas settings}
           Canvas.Pen.Color := clBlack;
           Canvas.Font.Style := [];

        end;
  StrDispose( pDate );
end;

{********************* Form Cancel ************************
 **********************************************************}
procedure TfrmCalPop.FormCancel;
begin
  m_MouseDown := False;
  ModalResult := -1;
end;

{******************* Form Key Down ************************
 **********************************************************}
procedure TfrmCalPop.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
     Case key of
          VK_Left : begin
                        PrevDay;
                        If (m_CurrentMonth <> m_PreviousMonth) or
                           (m_CurrentYear <> m_PreviousYear) Then
                           Refresh
                        else
                           DrawFocusFrame(m_CurrentDateIndex);
                     end;
          VK_Right : begin
                        NextDay;

                        If (m_CurrentMonth <> m_PreviousMonth) or
                           (m_CurrentYear <> m_PreviousYear) Then
                           Refresh
                        else
                           DrawFocusFrame(m_CurrentDateIndex);
                     end;
          VK_Up : begin
                        PrevWeek;
                        If (m_CurrentMonth <> m_PreviousMonth) or
                           (m_CurrentYear <> m_PreviousYear) Then
                           Refresh
                        else
                           DrawFocusFrame(m_CurrentDateIndex);
                     end;
          VK_Down : begin
                        NextWeek;
                        If (m_CurrentMonth <> m_PreviousMonth) or
                           (m_CurrentYear <> m_PreviousYear) Then
                           Refresh
                        else
                           DrawFocusFrame(m_CurrentDateIndex);
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
                        TDateEdit( ctlParent ).Date := m_CurrentDateSelected;
                        ModalResult := 1;
                     end;
          VK_Escape : FormCancel;
     else

     end;
end;


{********************** Form Mouse Down *******************
 **********************************************************}
procedure TfrmCalPop.FormMouseDown(Sender: TObject; Button: TMouseButton;
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
        m_MouseDown := True;
        nIndex := GetIndexFromPoint( X, Y );

        If (nIndex >= GetMonthBegin) and
           (nIndex < (DaysInMonth(m_CurrentMonth) + GetMonthBegin)) Then
           begin
             SetDate(nIndex - m_CurrentDateIndex);
             DrawFocusFrame(nIndex);
           end
        else
            m_MouseDown := False;

     end;
end;

{******************* Form Mouse Move **********************
 **********************************************************}
procedure TfrmCalPop.FormMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
var
  nIndex : Integer;
begin
    If m_MouseDown = True then
       begin
          if PointInRect(GetCalendarRect, X, Y) then
          begin
               nIndex := GetIndexFromPoint( X, Y );
               If (nIndex >= GetMonthBegin) and
                  (nIndex < (DaysInMonth(m_CurrentMonth) + GetMonthBegin)) and
                  (nIndex <> m_CurrentDateIndex) Then
               begin
                    SetDate(nIndex - m_CurrentDateIndex);
                    DrawFocusFrame(nIndex);
               end;
          end;
       end;
end;


{******************* Form Mouse Up ************************
 **********************************************************}
procedure TfrmCalPop.FormMouseUp( Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer );
var
   TempRect : Trect;
begin
  If m_MouseDown = True Then
     begin
        m_MouseDown := False;
        TDateEdit( ctlParent ).Date := m_CurrentDateSelected;
        ModalResult := 1;
     end;
end;


{********************** Form Paint ************************
 **********************************************************}
procedure TfrmCalPop.FormPaint(Sender: TObject);
begin
  DrawCalendarBorder;
  DrawMonthHeader;
  DrawDaysHeader;
  DrawDates;
  DrawButtons;
  DrawFocusFrame(m_CurrentDateIndex);
end;


{********************* Get Left Button Rectangle ******************
 ***** Get the rectangle used for the left button.            *****
 ******************************************************************}
function TfrmCalPop.GetLeftButtonRect: TRect;
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

{******************** Get Right Button Rectangle ******************
 ***** Get the rectangle used for the right button.           *****
 ******************************************************************}
function TfrmCalPop.GetRightButtonRect: TRect;
var
  TempRect: TRect;
begin
   {Define Right Button Rectangle}
   TempRect.Top := ClientRect.Top + BORDER;
   TempRect.Bottom := TempRect.Top + BUTTON_WIDTH;
   TempRect.Right := BORDER + TEXT_INDENT + (m_FontWidth * 3 * 7);
   TempRect.Left := TempRect.Right - BUTTON_WIDTH;

   Result := TempRect;
end;

{********************** Get Calendar Rectangle ********************
 ***** Get the rectangle used for the calendar section        *****
 ******************************************************************}
function TfrmCalPop.GetCalendarRect: TRect;
var
  TempRect: TRect;
begin
  TempRect := ClientRect;

  with TempRect do
     begin
        Left := BORDER + TEXT_INDENT;
        Top := ( m_FontHeight * 2 ) + BORDER;
        Bottom := Top + ( m_FontHeight * 6 );
        Right := Left + ( 7 * ( m_fontWidth * 3 ) );
     end;

  Result := TempRect;
end;


{******************** Get Rectangle From Index ********************
 ***** Get the rectangle used for the calendar section        *****
 ******************************************************************}
function TfrmCalPop.GetRectFromIndex(nIndex : Integer): TRect;
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

        Left := Left + ((m_FontWidth * 3) * (nDay-1));
        Top := (m_FontHeight * nWeek ) + m_FontHeight + BORDER;
        Bottom := Top +  m_FontHeight ;
        Right := Left + m_fontWidth * 3;
     end;

  Result := TempRect;
end;

{*************************** Get Month Begin **************************
 ***** This function Gets the index value of the first day of the *****
 ***** month.                                                     *****
 ********************************************************************** }
function TfrmCalPop.GetMonthBegin: Integer;
var
  FirstDate: TDateTime;
begin
  FirstDate := EncodeDate( m_CurrentYear, m_CurrentMonth, 1 );
  Result := DayOfWeek( FirstDate ); { day of week for 1st of month }
end;


{********************** Is Leap Year **********************
 **********************************************************}
function TfrmCalPop.IsLeapYear: Boolean;
begin
  Result := ( m_CurrentYear mod 4 = 0 ) and
            ( ( m_CurrentYear mod 100 <> 0 ) or ( m_CurrentYear mod 400 = 0 ) );
end;


{********************** LoadDateArray *********************
 **********************************************************}
procedure TfrmCalPop.LoadDateArray;
var
  nIndex : Integer;
  nBeginIndex, nEndIndex : Integer;
begin
  nBeginIndex := GetMonthBegin;
  nEndIndex := nBeginIndex + DaysInMonth(m_CurrentMonth) - 1;
  for nIndex := 1 to 42 do
  begin
     If ( nIndex < nBeginIndex ) or ( nIndex > nEndIndex ) Then
        m_DateArray[nIndex] := '  '
     else
        m_DateArray[nIndex] := IntToStr( ( nIndex - nBeginIndex ) + 1 );
  end;
end;


{******************** Get Index From Date *****************
 **********************************************************}
function TfrmCalPop.GetIndexFromDate : Integer;
begin
     Result := m_CurrentDay + GetMonthBegin;
end;


{****************** Get Index From Point ******************
 **********************************************************}
function TfrmCalPop.GetIndexFromPoint(nLeft : Integer ; nTop : Integer) : Integer;
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
        nResult := ( nTop - BORDER ) / ( m_FontHeight ) - 1;
        nWeek := Trunc( nResult );

        { Adjust Date Rect }
        TempRect.Top := TempRect.Top + ( ( nWeek - 1 ) * m_FontHeight );
        TempRect.Bottom := TempRect.Top + m_FontHeight;
        TempRect.Left := BORDER + TEXT_INDENT;
        TempRect.Right := TempRect.Left + m_FontWidth * 3;

        { Determine the day number of the selected date }
        for nDay := 1 to 7 do        {Cycle through the days}
           begin
              nIndex := nDay + ( ( nWeek - 1 ) * 7 );
              if ( nLeft >= TempRect.Left ) and ( nLeft <= TempRect.Right ) then
                 break
              else
                 begin
                    TempRect.Left := TempRect.Right;
                    TempRect.Right := TempRect.Left + m_FontWidth * 3;
                 end;
           end;
     end;
  Result := nIndex;
end;


{******************** Get Previous Day ********************
 **********************************************************}
procedure TfrmCalPop.PrevDay;
begin
    SetDate(-1);
end;


{********************* Get Next Day ***********************
 **********************************************************}
procedure TfrmCalPop.NextDay;
begin
     SetDate(1);
end;


{******************** Get Previous Week *******************
 **********************************************************}
procedure TfrmCalPop.PrevWeek;
begin
    SetDate(-7);
end;


{******************** Get Next Week ***********************
 **********************************************************}
procedure TfrmCalPop.NextWeek;
begin
     SetDate(7);
end;


{******************** GetPreviousMonth ********************
 **********************************************************}
procedure TfrmCalPop.PrevMonth;
var
   nDays : Integer;
   nMonth : Integer;
begin
  if m_CurrentMonth > 1 then
     nMonth := m_CurrentMonth - 1
  else
     nMonth := 12;
  nDays := DaysInMonth(nMonth);
  SetDate(-nDays);
end;


{******************** Get Next Nonth **********************
 **********************************************************}
procedure TfrmCalPop.NextMonth;
begin
  SetDate(DaysInMonth(m_CurrentMonth));
end;

{GetNextYear}
procedure TfrmCalPop.NextYear;
begin

  {If the current year is a leap year and the date is
   before February 29, add 1 day}
  If IsLeapYear and (m_CurrentMonth < 3) Then
     SetDate(1);

  SetDate(365);
  {If the current year is a leap year and the date is
   after February 29, add 1 day}
  If IsLeapYear and (m_CurrentMonth > 3) Then
     SetDate(1);
end;


{******************* GetPrevious Year *********************
 **********************************************************}
procedure TfrmCalPop.PrevYear;
begin
  {If the current year is a leap year and the date is
   after February 29, subtract 1 day}
  If IsLeapYear and (m_CurrentMonth > 3) Then
     SetDate(-1);

  SetDate(-365);
  {If the Previous year is a leap year and the date is
   before February 29, subtract 1 day}
  If IsLeapYear and (m_CurrentMonth < 3) Then
     SetDate(-1);
end;


{***************** Set Date **************************
 **** This procedure adjusts the date by nDays    ****
 **** nDays can be possitive or negative.  It     ****
 **** also populates the vars YEAR, MONTH and DAY ****
 *****************************************************}
procedure TfrmCalPop.SetDate(nDays : Integer);
begin
   {Save current date information}
   m_PreviousDateIndex := m_CurrentDateIndex;
   DecodeDate(m_CurrentDateSelected,m_PreviousYear,m_PreviousMonth,m_PreviousDay);

   {Change the date and update member variables}
   m_CurrentDateSelected := m_CurrentDateSelected + nDays;
   DecodeDate(m_CurrentDateSelected,m_CurrentYear,m_CurrentMonth,m_CurrentDay);
   m_CurrentDateIndex := ( m_CurrentDay + GetMonthBegin ) - 1;

   {Reload Date Array if month or year changed}
   If (m_CurrentMonth <> m_PreviousMonth) or (m_CurrentYear <> m_PreviousYear)Then
      LoadDateArray;
end;

end.
