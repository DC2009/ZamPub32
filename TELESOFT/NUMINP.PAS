unit NumInp;

interface

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, StdCtrls, Menus, MoneyCnv;

type
  TNumericType = (ntGeneral, ntExponent, ntFixed, ntNumber, ntCurrency);
  TDataType = (dtByte, dtDouble, dtExtended, dtInteger,
               dtLongint, dtReal, dtShortint, dtSingle, dtWord);

  TAlignment = (taLeftJustify, taRightJustify);

{ numinp component }
type
  TCustomNumInp = class (TCustomEdit)
  private
    FAlignment: TAlignment;
    FCanvas: TControlCanvas;
    FDecimals : word;
    FDigits : word;
    FFocused: Boolean;
    FMax : extended;
    FMin : extended;
    FNegColor : TColor;
    FNumericType : TNumericType;
    OldColor : TColor;
    OldTNIColor : TColor;
    FDataType : TDataType;
    FTabOnEnterKey : Boolean;
    FTextMargin: Integer;
    FValue : extended;
    FValidate : boolean;
    procedure CMExit(var Message: TCMExit); message CM_EXIT;
    procedure CMEnter(var Message: TCMEnter); message CM_ENTER;
    procedure CMFontChanged(var Message: TMessage); message CM_FONTCHANGED;
    procedure WMPaint(var Message: TWMPaint); message WM_PAINT;
    procedure CalcTextMargin;
    procedure SetAlignment(Value : TAlignment);
    procedure SetDecimals(Value : word);
    procedure SetDigits(Value : word);
    procedure SetMax(Value : extended);
    procedure SetMin(Value : extended);
    procedure SetNegCol(Value:TColor);
    procedure SetNumericType(Value : TNumericType);
    procedure SetDataType(Value : TDataType);
    procedure SetTabOnEnterKey(Value: Boolean);
    procedure SetValue(Value : extended);
    procedure SetValidate(Value : boolean);
  protected
    procedure FormatText; dynamic;
    procedure CheckRange; dynamic;
    procedure KeyPress(var Key: Char); override;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    property Alignment :TAlignment Read FAlignment write SetAlignment;
    property Decimals : word read FDecimals write SetDecimals;
    property Digits : word read FDigits write SetDigits;
    property Max : extended read FMax write SetMax;
    property Min : extended read FMin write SetMin;
    property NegativeColor : Tcolor read FNegColor write SetNegCol;
    property NumericType : TNumericType read FNumericType write SetNumericType default ntGeneral;
    property DataType : TDataType read FDataType write SetDataType default dtExtended;
    property TabOnEnterKey:Boolean read FTabOnEnterKey write SetTabOnEnterKey ;
    property Value : extended read FValue write SetValue;
    property Validate : boolean read FValidate write SetValidate;
  public
    IsValid : Boolean;
    constructor Create(AOwner: TComponent); override;
    function AsByte : Byte; dynamic;
    function AsDouble : double; dynamic;
    function AsInteger : integer; dynamic;
    function AsLongint : longint; dynamic;
    function AsReal : real; dynamic;
    function AsShortInt : ShortInt; dynamic;
    function AsSingle : Single; dynamic;
    function AsWord : Word; dynamic;
    function Valid ( Value : extended ) : boolean; dynamic;
    function AsMoneyStr:String;
  end;

  TNumInp = class (TCustomNumInp)
  published
    property Alignment;
    property AutoSelect;
    property AutoSize;
    property BorderStyle;
    property Color;
    property Ctl3D;
    property Datatype;
    property Decimals;
    property Digits;
    property DragCursor;
    property DragMode;
    property Enabled;
    property Font;
    property HideSelection;
    property Max;
    property Min;
    property NegativeColor;
    property NumericType;
    property ParentColor;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ReadOnly;
    property ShowHint;
    property TabOnEnterKey;
    property TabOrder;
    property Value;
    property Validate;
    property Visible;
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

type
  TSetOfChar = set of char;

const
  MaxByte    : byte     = 255;
  MinByte    : byte     = 0;
  MaxDouble  : double   = 1.7E308;
  MinDouble  : double   = -1.7E308;
  MaxExtended: extended = 1.1E4932;
  MinExtended: extended = -1.1E4932;
  MaxInteger : integer  = 32767;
  MinInteger : integer  = -32768;
  MaxLongint : longint  = 2147483647;
  MinLongint : longint  = -2147483647;
  MaxReal    : real     = 1.7E38;
  MinReal    : real     = -1.7E38;
  MaxShortInt: ShortInt = 127;
  MinShortInt: ShortInt = -128;
  MaxSingle  : Single   = 3.4E38;
  MinSingle  : Single   = -3.4E38;
  MaxWord    : Word     = 65535;
  MinWord    : Word     = 0;

{========================================================================}
{ Custom Numeric Edit                                                    }
{========================================================================}

constructor TCustomNumInp.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Width := 85;
  FNumericType := ntGeneral;
  FDataType := dtExtended;
  FDigits := 12;
  FDecimals := 2;
  FMax := 0.0;
  FMin := 0.0;
  AutoSelect := true;
  FValidate := true;
  IsValid := true;
  FValue := 0.0;
  MaxLength := FDigits;
  CalcTextMargin;
  Text := '0.0';
  OldColor:=Font.Color;
  OldTNIColor := Color;
  FormatText;
  end;

 procedure  TCustomNumInp.SetAlignment(Value : TAlignment);
 begin
  if FAlignment <> Value then
  begin
   FAlignment := Value;
   invalidate; {repaint the control}
  end;
 end;

function TCustomNumInp.AsMoneyStr:String;
var
  XText:string;
begin
  try
    XText:=Text;
    result:=MoneyStr(XText);
  except
    result:='ERROR'
  end;
end;

function TCustomNumInp.AsByte: byte;
begin
  Result := 0;
  if (FValue <= MaxByte) and (FValue >= MinByte) then
     Result := Round(FValue);
end;

function TCustomNumInp.AsDouble: double;
begin
  Result := 0;
  if (FValue <= MaxDouble) and (FValue >= MinDouble) then
     Result := FValue;
end;

function TCustomNumInp.AsInteger: integer;
begin
  Result := 0;
  if (FValue <= MaxInteger) and (FValue >= MinInteger) then
      Result := round(FValue)
end;

function TCustomNumInp.AsLongint: longint;
begin
  Result := 0;
  if (FValue <= MaxLongint) and (FValue >= MinLongint) then
      Result := round(FValue);
end;

function TCustomNumInp.AsReal: real;
begin
  Result := 0;
  if (FValue <= MaxReal) and (FValue >= MinReal) then
     Result := FValue;
end;

function TCustomNumInp.AsShortInt: ShortInt;
begin
  Result := 0;
  if (FValue <= MaxShortInt) and  (FValue >= MinShortInt) then
     Result := Round(FValue);
end;

function TCustomNumInp.AsSingle: Single;
begin
  Result := 0;
  if (FValue <= MaxSingle) and  (FValue >= MinSingle) then
     Result := FValue;
end;

function TCustomNumInp.AsWord: Word;
begin
  Result := 0;
  if (FValue <= MaxWord) and  (FValue >= MinWord) then
     Result := Round(FValue);
end;

procedure TCustomNumInp.SetMin(Value: extended);
begin
  if FMin <> Value then
  begin
    FMin := Value;
    CheckRange;
    if FMin > FMax then FMin := FMax;
    if FValue < FMin then
      FValue := FMin;
    FormatText;
  end;
end;

procedure TCustomNumInp.SetMax(Value: extended);
begin
  if FMax <> Value then
  begin
    FMax := Value;
    CheckRange;
    if FMax < FMin then FMax := FMin;
    if FValue > FMax then
      FValue := FMax;
    FormatText;
  end;
end;

procedure TCustomNumInp.SetValue(Value: extended);
begin
  if (FValue <> Value) and (Valid(Value)) then
  begin
    FValue := Value;
    FormatText;
  end
end;

procedure TCustomNumInp.SetDigits(Value: word);
begin
  if FDigits <> Value then
  begin
    FDigits := Value;
    MaxLength := FDigits;
    FormatText;
  end;
end;

procedure TCustomNumInp.SetDecimals (Value: word);
begin
  if FDecimals <> Value then
  begin
   if FDataType in [dtByte, dtInteger, dtLongint, dtShortint, dtWord] then
     FDecimals := 0 else
    FDecimals := Value;
    FormatText;
  end;
end;

procedure TCustomNumInp.SetDataType(Value: TDataType);
begin
  if FDataType <> Value then
  begin
    FDataType := Value;
    if FDataType in [dtByte, dtInteger, dtLongint, dtShortint, dtWord] then
       begin
         FNumericType := ntGeneral;
         FDecimals:=0;
       end;
    CheckRange;
    FormatText;
  end;
end;

procedure TCustomNumInp.SetNegCol (Value: Tcolor);
begin
  if FNegColor <> Value then
     FNegColor:=Value;
     FormatText;
 end;

procedure TCustomNumInp.SetNumericType(Value: TNumericType);
begin
  if FDataType in [dtDouble, dtExtended, dtReal, dtSingle] then
     if FNumericType <> Value then
     begin
       FNumericType := Value;
       FormatText;
     end
  else FNumericType := ntGeneral;
end;

procedure TCustomNumInp.SetValidate(Value: boolean);
begin
  if FValidate <> Value then
  begin
    FValidate := Value;
    if FValidate and ((FValue < FMin) or (FValue > FMax)) then
    begin
      FValue := FMin;
      FormatText;
    end;
  end;
end;

procedure TCustomNumInp.SetTabOnEnterKey(Value: Boolean);
begin
  if FTabOnEnterKey <> Value then
  begin
    FTabOnEnterKey := Value;
  end;
end;

function TCustomNumInp.Valid(Value: extended): boolean;
var
  S: string[80];
begin
  Result := true;
  if FValidate and ((Value < FMin) or (Value > FMax)) then
  begin
    FmtStr(S, 'Wartoœæ musi byæ pomiêdzy %g a %g', [FMin, FMax]);
    MessageDlg(S, mtError, [mbOk], 0);
    Result := false;
  end
end;

procedure  TCustomNumInp.KeyDown(var Key: Word; Shift: TShiftState);
begin
  if (key = VK_UP) then
     PostMessage(GetparentForm(Self).Handle, WM_NEXTDLGCTL ,1,0);
  if (Key = VK_DOWN) then
     PostMessage(GetparentForm(Self).Handle, WM_NEXTDLGCTL ,0,0);
  inherited KeyDown(Key, Shift);
end;

procedure TCustomNumInp.KeyPress(var Key: Char);
var
i,x,Sel,OldLength:Integer;
TRashText,OldText:String;
begin
  x:=0;
  {if EnterKey and TabOnEnter}
  if (key = #13) and (FTabOnEnterKey) then
   begin
       PostMessage(GetparentForm(Self).Handle, WM_NEXTDLGCTL ,0,0);
       Key := #0;
       Exit;
   end;

{ Restore last entry if ESC}
    if (key = #27) then
      begin
        SendMessage(Self.Handle, WM_UNDO,0,0);
        SelectAll;
        Key := #0;
        exit;
      end;
{if copy or cut selection}
if (Key = ^C) or (Key = ^X) then exit;

{if Paste check if valid else undo}
if (Key = ^V) then
begin
 try
  OldText:=Text;
  SendMessage(Self.Handle, WM_PASTE ,0,0);
  FValue:=StrToFloat(Text);
  Valid(FValue);
  FormatText;
   if Length(Text) > MaxLength then {Check Length}
   begin
     Text:=OldText;
     MessageBeep(0);
   end;
 except
SendMessage(Self.Handle, WM_UNDO ,0,0);
MessageBeep(0);
end;
  Key := #0;
  exit;
end;

{Check for valid Characters}
  if Key in ['0'..'9', '-', '+', 'e', 'E', DecimalSeparator, #8] then
  begin
    if Key in ['e', 'E', DecimalSeparator] then
       if FDataType in [dtDouble, dtExtended, dtReal, dtSingle] then
       else Key := #0;

{    if (Key in ['e', 'E', DecimalSeparator]) and
       not (FDataType in [dtDouble, dtExtended, dtReal, dtSingle])
         then Key := #0
         else begin
           FValue:=StrToFloat(Text);
         end;}

    inherited KeyPress(Key);
  end
  else  Key := #0;

{Check on Exponent }
 if FNumericType = ntExponent then
 begin
  if Key='e' then Key:='E';
 if Key in ['-','+','E', DecimalSeparator,'0'..'9'] then
  begin
   if ((pos(DecimalSeparator,Text) >0)and (Key=DecimalSeparator))
    or ((pos('E',Text) > 0) and (Key = 'E'))
    or ((SelStart > 0) and (Key = '-')and(pos('E',Text) = 0))
    or ((pos('E',Text) = 0) and (Key = '+'))
    or ((pos('E',Text) > 0) and (SelStart <> pos('E',Text)) and (Key = '-')
        and (SelStart>0))
    or ((pos('E',Text) > 0) and (Length(Text)> SelStart) and(Text[SelStart+1] in ['+','-']))
    or ((pos('E',Text) > 0) and (SelStart <> pos('E',Text)) and (Key = '+'))
    or ((Key = 'E') and not(text[SelStart] in ['0'..'9']))then
    begin
        MessageBeep(0);
        Key:=#0;
    end;
   end;
  { Check for backspace on E, if + or - Sign exists after E restrict removal}
   if (Key = #8)
      and (pos('E',Text) > 0)
      and (SelStart = pos('E',Text))
      and (Length(Text)> SelStart)
      and(Text[SelStart+1] in ['+','-']) then
        begin
        MessageBeep(0);
        Key:=#0;
    end;
   exit;
  end;

 {Clear selection in control If selection include DecimalPoint clear
   all numbers from start selection}
  if Sellength > 0 then
  begin
    if (SelStart+1 <= pos(DecimalSeparator,Text))
    and (SelStart+SelLength >= pos(DecimalSeparator,Text))then
    begin
    SelLength:=Length(Text)- SelStart;
    SendMessage(Self.Handle, WM_CLEAR, 0, 0);
    end
    else
    SendMessage(Self.Handle, WM_CLEAR, 0, 0);
   end;

{Take away all non numeric characters and leave the cursor}
   Sel:=SelStart;
   TrashText:='';
   OldLength:=Length(Text);
    for i:=1 to length(Text) do
    if ( Text[i] in ['0'..'9',DecimalSeparator,'-']) then
       TrashText:=TrashText+Text[i] else if i > sel then inc(x);
       Text:=TrashText;
       SelStart:=Sel-(OldLength-Length(Text))+x;

{Check for Back Space on Decimal, if decimal exist restrict removal if it will
 exceed characters before Decimal}
if     (key=#8)
       and (pos(DecimalSeparator,Text) >0)
       and (SelStart = pos(DecimalSeparator,Text))
       and (Length(Text)> pos(DecimalSeparator,Text))
       and (Length(Text)> MaxLength-FDecimals) then
       begin
        MessageBeep(0);
        Key:=#0;
        Exit;
       end;

 {Check for decimal is allowed and if decimal exist}
 if   (key = DecimalSeparator)
      and (Fdecimals = 0)
      or  (pos(DecimalSeparator,Text) >0)
      and (Key=DecimalSeparator)
      or  (SelStart<Length(Text)-FDecimals)
      and (Key=DecimalSeparator)
      and (Length(Text)>FDecimals)then
      begin
        MessageBeep(0);
        Key:=#0;
        Exit;
      end;

{Check for negative sign, only allowed as first character}
  if (key='-') and (SelStart<>0)then
       begin
        MessageBeep(0);
        Key:=#0;
        Exit;
       end;

 {Check max characters before decimal }
        if  (Key<>#8)
             and (pos(DecimalSeparator,Text) >0)
             and (pos(DecimalSeparator,Text) >= MaxLength-FDecimals)
             and (selstart < pos(DecimalSeparator,Text))
             or  (Key in ['0'..'9'])
             and (FDecimals <>0)
             and (selstart <= MaxLength-FDecimals)
             and (Length(Text)>=MaxLength-FDecimals-1)
             and (pos(DecimalSeparator,Text) = 0)
             then
                begin
      {Add Decimal automatically if max characters before Decimal}
                if (Key in ['0'..'9'])
                 and (FDecimals <>0)
                 and (selstart = MaxLength-FDecimals-1)
                 and (pos(DecimalSeparator,Text) = 0) then
                    begin
                         key:=DecimalSeparator;
                         exit
                    end;
                   MessageBeep(0);
                   Key:=#0;
                   Exit;
                end;

 {Check max characters after decimal}
        if  (Key<>#8)
             and (pos(DecimalSeparator,Text) >0)
             and (Length(Text)-pos(DecimalSeparator,Text)>=FDecimals)
             and (selstart >= pos(DecimalSeparator,Text)) then
                begin
                    MessageBeep(0);
                     Key:=#0;
                     Exit;
                end;

end;

procedure TCustomNumInp.CMEnter(var Message: TCMEnter);
begin
{make sure the cursor is at the beginning if AutoSelect = False}
 if   (AutoSelect = False) then
      SelStart := 0;
 FFocused := True; {info for WM_PAINT }
 inherited;
end;

procedure TCustomNumInp.CMExit(var Message: TCMExit);
var
  X: extended;
  TrashText : String;
  i:integer;
begin
  try
    {Using this to remove Currency symbol and Thousand seperator}
    TrashText:='';
    for i:=1 to length(Text) do
    if ( Text[i] in ['0'..'9',DecimalSeparator,'-','E','e','+']) then
         TrashText:=TrashText+Text[i];

    Text := TrashText;
{     if Text='' then Text:='0';}
    if Text='' {linee modificate: prima c'era solo da else (escluso) in poi}
      then X:=0
      else X := StrToFloat(Text);
    if Valid(X) then
    begin
      IsValid := true;
      FValue := X;
      if Text<>'' then {linea aggiunta}
        FormatText;
      FFocused := False;  {info for WM_PAINT }
      invalidate; { This will repaint the control WM_PAINT Message}
      inherited ;
    end
    else
    begin
      IsValid := false;
      SelectAll;
      SetFocus;
    end;
  except
    on E: EConvertError do
    begin
      MessageDlg('''' + Text + ''' nie jest wartoœci¹ liczbow¹.', mtError, [mbOK], 0);
      SelectAll;
      SetFocus;
    end;
  end;
end;

procedure TCustomNumInp.CheckRange;
var
  LMax, LMin: Extended;

  procedure check;
    begin
      if ((FMin < LMin) or (FMin > LMax)) then FMin := LMin;
      if ((FMax > LMax) or (FMax < LMin)) then FMax := LMax;
      if ((FValue < LMin) or (FValue > LMax))
         then FValue := 0;
    end;

begin
  case FDataType of
       dtByte:
         begin
           LMax := MaxByte; LMin := MinByte;
           check;
         end;
       dtDouble:
         begin
           LMax := MaxDouble; LMin := MinDouble;
           check;
         end;
       dtExtended:
         begin
           LMax := MaxExtended; LMin := MinExtended;
           check;
         end;
       dtInteger:
         begin
           LMax := MaxInteger; LMin := MinInteger;
           check;
         end;
       dtLongint:
         begin
           LMax := MaxLongInt; LMin := MinLongInt;
           check;
         end;
       dtReal:
         begin
           LMax := MaxReal; LMin := MinReal;
           check;
         end;
       dtShortint:
         begin
           LMax := MaxShortInt; LMin := MinShortInt;
           check;
         end;
       dtSingle:
         begin
           LMax := MaxSingle; LMin := MinSingle;
           check;
         end;
       dtWord:
         begin
           LMax := MaxWord; LMin := MinWord;
           check;
         end;
  end;
end;

procedure TCustomNumInp.FormatText;
var
  X: Extended;
begin
  if FNumericType = ntExponent
     then MaxLength := FDigits + 3 + FDecimals
     else MaxLength := FDigits;

  if FDataType in [dtDouble, dtExtended, dtReal, dtSingle] then
  begin
    X := FValue;
    case FNumericType of
      ntNumber   : Text := FloatToStrF ( X, ffNumber, FDigits, FDecimals);
      ntGeneral  : Text := FloatToStrF ( X, ffGeneral, FDigits, FDecimals);
      ntExponent : Text := FloatToStrF ( X, ffExponent, FDigits, FDecimals);
      ntFixed    : Text := FloatToStrF ( X, ffFixed, FDigits, FDecimals);
      ntCurrency : Text := FloatToStrF ( X, ffCurrency, FDigits, FDecimals);
    end
  end
  else
  begin
    FValue := Round(FValue);
    X := FValue;
    Text := IntToStr(Round(X));
  end;
  if FValue < 0 then Font.Color:=FNegColor else Font.Color:=OldColor;
end;

procedure TCustomNumInp.CMFontChanged(var Message: TMessage);
begin
  inherited;
  CalcTextMargin;
end;

procedure TCustomNumInp.CalcTextMargin;
var
  DC: HDC;
  SaveFont: HFont;
  I: Integer;
  SysMetrics, Metrics: TTextMetric;
begin
  DC := GetDC(0);
  GetTextMetrics(DC, SysMetrics);
  SaveFont := SelectObject(DC, Font.Handle);
  GetTextMetrics(DC, Metrics);
  SelectObject(DC, SaveFont);
  ReleaseDC(0, DC);
  I := SysMetrics.tmHeight;
  if I > Metrics.tmHeight then I := Metrics.tmHeight;
  FTextMargin := I div 4;
end;

procedure TCustomNumInp.WMPaint(var Message: TWMPaint);
var
  Width, Indent, Left, I: Integer;
  R: TRect;
  DC: HDC;
  PS: TPaintStruct;
  S: string;
begin
{ BugFix? : }
{ CMEnter doesn't execute, when the control is focused by a keystroke }
  if Self.Focused then FFocused := true;

  if (FAlignment = taLeftJustify) or FFocused then
  begin
    inherited;
    Exit;
  end;
{ Since edit controls do not handle justification unless multi-line (and
  then only poorly) we will draw right and center justify manually unless
  the edit has the focus. }
  if FCanvas = nil then
  begin
    FCanvas := TControlCanvas.Create;
    FCanvas.Control := Self;
  end;
  DC := Message.DC;
  if DC = 0 then DC := BeginPaint(Handle, PS);
  FCanvas.Handle := DC;
  try
    FCanvas.Font := Font;
    with FCanvas do
    begin
      R := ClientRect;
      if (BorderStyle = bsSingle) then
      begin
        Brush.Color := clWindowFrame;
        FrameRect(R);
        InflateRect(R, -1, -1);
      end;
      Brush.Color := Color;
      S := Text;
      Width := TextWidth(S);
      if BorderStyle = bsNone then Indent := 0 else Indent := FTextMargin;
      if FAlignment = taRightJustify then
        Left := R.Right - Width - Indent else
        Left := (R.Left + R.Right - Width) div 2;
      TextRect(R, Left, Indent, S);
    end;
  finally
    FCanvas.Handle := 0;
    if Message.DC = 0 then EndPaint(Handle, PS);
  end;
end;

procedure Register;
begin
  RegisterComponents ('Telesoft', [TNumInp]);
end;

end.
