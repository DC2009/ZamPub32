{
  ---------------------------------------------------------------------------
  PURPOSE:  This control was designed because I wanted a more flexible check
            box.
  ---------------------------------------------------------------------------
  PROPERTIES: This class is inherited from TCustomControl so has all of it's
              properties plus a few redeclarations.  The following are new
              key properties:

              CheckedBitMap - This bitmap will be displayed when the
                              check box is in it's checked state.  Using this
                              field and setting CheckType to ctBitMap you can
                              display any graphic instead of just a check
                              mark.
              UnCheckedBitMap - This bitmap will be displayed if the check box
                                is in it's unchecked state and CheckType is
                                set to ctBitMap.
              TransparentColor - This is the color of the bitmap that you
                                 would like to be transparent.  Just like
                                 a glyph on a button.
              TextIndentSize - This is the space between the check box
                               and the caption beside it.
              CheckBevelStyle - This is determines how the border around
                                the check mark looks. (bvRaised, bvLowered
                                or bvNone).
              CheckBevelWidth - This is the thickness of the border around
                                the check mark.
              CheckBoxWidth - This is the size of the check box
                              (Also See: SizeToBitMap).
              GrayedColor - When the state property is set to csGrayed this
                            is the color the box will become.
              CheckColor - This is the color of the check mark (not used if
                           you are using a bitmap.
              CheckType  - This is what the check mark will look like:
                             ctBitMap - Displays the bitmap set in the
                                        CheckedBitMap property.
                             ctCheckMark - Displays a check mark.
                             ctVCheckMark - Displays a slightly different
                                            check mark.
                             ctCross - Displays an X.
                             ctUserDraw - Not implemented yet.
              CheckWidth - This is the thickness of the check mark.
              SizeToBitMap - If this is set to TRUE the CheckBoxWidth
                             property will be set to the size of the
                             checked bitmaps height plus the size of the
                             CheckBevelWidth. (Note: If the Unchecked bitmap
                             is a different size then the checked bitmap this
                             property will size to the checked bitmap size)
              StretchBitMaps - If this is TRUE then the bitmaps will be resized
                               to fit in the check box.
              State - Same as the default Check box.
              About - Pops up a message box with the VCL credits.

 ---------------------------------------------------------------------------
}

unit BChkBox;

interface

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, StdCtrls, Menus, ExtCtrls, DsgnIntf;

type
  {Types for TBMPCheckBox}
  TCheckType = (ctBitMap, ctCheckMark, ctVCheckMark, ctCross, ctUserDraw);

  TBMPCheckBox = class(TCustomControl)
  private
    FDown                      : Boolean;
    FState                     : TCheckBoxState;
    FFocused                   : Boolean;
    FCheckedBitMap             : TBitMap;
    FUnCheckedBitMap           : TBitMap;
    FTransparentColor          : TColor;
    FTextIndentSize            : WORD;
    FCheckBevelWidth           : WORD;
    FCheckBevelStyle           : TPanelBevel;
    FCheckBoxWidth             : WORD;
    FGrayedColor               : TColor;
    FCheckColor                : TColor;
    FCheckType                 : TCheckType;
    FCheckWidth                : Word;
    FSizeToBitMap              : BOOLEAN;
    FStretchBitMaps            : BOOLEAN;
  protected
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Paint; override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer); override;
    procedure MouseMove(Shift: TShiftState;X, Y: Integer);
      override;
    procedure KeyDown(var Key:Word;Shift:TShiftSTate); override;
    procedure KeyUp(var Key:Word;Shift:TShiftSTate); override;
    procedure SetStretchBitMaps(Value:Boolean);
    procedure SetSizeToBitMap(Value:Boolean);
    procedure SetCheckWidth(Value:Word);
    procedure SetCheckType(Value:TCheckType);
    procedure SetGrayedColor(Value:TColor);
    procedure SetCheckBevelStyle(Value:TPanelBevel);
    procedure SetCheckBoxWidth(Value:Word);
    procedure SetCheckBevelWidth(Value:Word);
    procedure SetTextIndentSize(Value:Word);
    procedure SetTransparentColor(Value:TColor);
    procedure SetCheckedBitMap(Value:TBitMap);
    procedure SetUnCheckedBitMap(Value:TBitMap);
    procedure SetDown(Value:Boolean);
    procedure SetState(Value:TCheckBoxState);
    procedure SetChecked(Value:Boolean);
    function  GetChecked:Boolean;
    procedure SetCheckColor(Value:TColor);
    function  GetCaption: TCaption;
    procedure SetCaption(const Value:TCaption);
    procedure DoEnter; override;
    procedure DoExit; override;
    procedure DrawCheck (BL, BT, BR, BB : WORD);
    procedure DrawVCheck (BL, BT, BR, BB : WORD);
    procedure DrawCross (BL, BT, BR, BB : WORD);
  public
  published
    property StretchBitMaps:BOOLEAN read FStretchBitMaps write SetStretchBitMaps;
    property SizeToBitMap:BOOLEAN read FSizeToBitMap write SetSizeToBitMap;
    property CheckType:TCheckType read FCheckType write SetCheckType;
    property CheckWidth:Word read FCheckWidth write SetCheckWidth;
    property GrayedColor:TColor read FGrayedColor write SetGrayedColor;
    property Color;
    property Enabled;
    property CheckBevelStyle:TPanelBevel read FCheckBevelStyle write SetCheckBevelStyle;
    property CheckBoxWidth:Word read FCheckBoxWidth write SetCheckBoxWidth;
    property CheckBevelWidth:Word read FCheckBevelWidth write SetCheckBevelWidth;
    property TextIndentSize:Word read FTextIndentSize  write SetTextIndentSize;
    property CheckedBitMap:TBitMap read FCheckedBitMap write SetCheckedBitMap;
    property UnCheckedBitMap:TBitMap read FUnCheckedBitMap write SetUnCheckedBitMap;
    property Caption:TCaption read GetCaption write SetCaption;
    property Checked:Boolean read GetChecked write SetChecked
             default False;
    property TransparentColor : TColor read FTransparentColor write SetTransparentColor;
    property Down:Boolean read FDown write SetDown default False;
    property CheckColor:TColor read FCheckColor write SetCheckColor;
    property DragCursor;
    property DragMode;
    property Font;
    property ParentFont;
    property PopupMenu;
    property ShowHint;
    property State:TCheckBoxState read FState write SetState
             default cbUnchecked;
    property TabOrder;
    property TabStop;
    property OnClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDrag;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
  end;

procedure Register;

implementation

{-------------------------------------------------------------------}
{                             BitMap CheckBox                       }
{-------------------------------------------------------------------}

constructor TBMPCheckBox.Create(AOwner: TComponent);

begin
  inherited Create(AOwner);
  FCheckedBitMap := TBitMap.Create;
  FUnCheckedBitMap := TBitMap.Create;
  Width := 98;
  Height := 20;
  ParentColor:=False;
  Color:=clBtnFace;
  Enabled:=TRUE;
  FTransparentColor:=clOlive;
  FTextIndentSize := 5;
  FCheckBevelStyle := bvRaised;
  FCheckBevelWidth := 1;
  FCheckBoxWidth := 12;
  FGrayedColor := clGray;
  FCheckColor := clBlack;
  FCheckType := ctCheckMark;
  FCheckWidth := 1;
  FSizeToBitMap := FALSE;
  FStretchBitMaps := FALSE;
  FDown := FALSE;
  FState := cbUnChecked;
  FFocused := FALSE;
end;

destructor TBMPCheckBox.Destroy;
begin
  FCheckedBitMap.Free;
  FUnCheckedBitMap.Free;
  inherited Destroy;
end;

procedure TBMPCheckBox.DrawCheck (BL, BT, BR, BB : WORD);
begin
  with Canvas do
  begin
    BL := BL + CheckBevelWidth;  {Set the box size to be inside the bevel}
    BR := BR - CheckBevelWidth;
    BT := BT + CheckBevelWidth;
    BB := BB - CheckBevelWidth;
    MoveTo(BL+1,BT+CheckBoxWidth div 2+1);
    LineTo(BL+1, BB-1);
    LineTo(BR-1,BT+1);

  end;
end;

procedure TBMPCheckBox.DrawVCheck (BL, BT, BR, BB : WORD);
begin
  with Canvas do
  begin
    BL := BL + CheckBevelWidth;
    BR := BR - CheckBevelWidth;
    BT := BT + CheckBevelWidth;
    BB := BB - CheckBevelWidth;
    MoveTo(BL+2,BT+CheckBoxWidth div 2+1);
    LineTo(Round(BR*0.30) ,BB-1);
    LineTo(BR-1,BT+1);
  end;
end;

procedure TBMPCheckBox.DrawCross (BL, BT, BR, BB : WORD);
begin
  with Canvas do
  begin
    BL := BL + CheckBevelWidth;
    BR := BR - CheckBevelWidth;
    BT := BT + CheckBevelWidth;
    BB := BB - CheckBevelWidth;
    MoveTo(BL+1,BT+1);
    LineTo(BR-1,BB-1);
    MoveTo(BR-1,BT+1);
    LineTo(BL+1,BB-1);
  end;
end;

procedure TBMPCheckBox.Paint;

var BL,BT,BR,BB:Integer; {Box Left, Box Top, Box Right, Box Bottom}
    TX,TY,TW,TH:Integer; {Text X, Text Y, Text Width, Text Height}
    BW         :Integer; {Box Width}
    CaptionRect, CheckRect:TRect; {Temp Rectangles made from the above points}

begin
     Canvas.Font:=Font;
     with Canvas do
       begin
         BW:=CheckBoxWidth;
         BT:= (Height div 2)-(BW div 2);
         BB:=BT+BW;
         BL:=1;
         BR:=BW+1;
         CheckRect := Rect(BL,BT,BR,BB);
         Brush.Color:=Color;
         if not FDown then
           begin
             Rectangle(BL,BT,BR,BB);  {Erase what was there before}
             case CheckBevelStyle of
               bvNone :
                         Frame3D(Canvas, CheckRect ,
                                 Color, Color, CheckBevelWidth);
               bvLowered:
                         Frame3D(Canvas, CheckRect ,
                                 clBtnShadow, clBtnHighLight, CheckBevelWidth);
               bvRaised:
                         Frame3D(Canvas, CheckRect ,
                                 clBtnHighLight, clBtnShadow, CheckBevelWidth);
             end; {Case}
           end
         else
           begin
             Pen.Color:=clBlack;
             Pen.Width:=2;
             Rectangle(BL+1,BT+1,BR+1,BB+1);
             Pen.Width:=1;
           end;
         TX:=BR+TextIndentSize;
         TY:=(Height div 2)+(Font.Height div 2)-1;
         TW:=TextWidth(Caption);
         TH:=TextHeight(Caption);
         TextOut(TX,TY,Caption);
         case State of
           cbChecked:begin
                       Pen.Color:= CheckColor;
                       Pen.Width:= CheckWidth;
                       case CheckType of
                         ctCheckMark :
                            DrawCheck (BL, BT, BR, BB);
                         ctVCheckMark :
                            DrawVCheck (BL, BT, BR, BB);
                         ctCross :
                            DrawCross (BL, BT, BR, BB);
                         ctBitMap :
                            if (StretchBitMaps) then
                              StretchDraw (Rect(BL+CheckBevelWidth,BT+CheckBevelWidth,
                                           BR-CheckBevelWidth,BB-CheckBevelWidth),
                                           CheckedBitMap)
                            else
                              BrushCopy (Rect(BL+CheckBevelWidth,BT+CheckBevelWidth,
                                         BR-CheckBevelWidth,BB-CheckBevelWidth),
                                         CheckedBitMap,
                                         Rect(0,0,BR-BL-(CheckBevelWidth*2),BB-BT-(CheckBevelWidth*2)), FTransparentColor);
                       end; {Case CheckType}
                     end;
            cbGrayed:begin
                       Brush.Color:=GrayedColor;
                       Rectangle (BL+{CheckBevelWidth}+1,BT+{CheckBevelWidth}+1,BR-{CheckBevelWidth}-1,BB-{CheckBevelWidth}-1);

                     end;
            cbUnChecked:begin
                          if (CheckType = ctBitMap) then
                          begin
                            if (StretchBitMaps) then
                              StretchDraw (Rect(BL+CheckBevelWidth,BT+CheckBevelWidth,
                                           BR-CheckBevelWidth,BB-CheckBevelWidth),
                                           UnCheckedBitMap)
                            else
                              BrushCopy (Rect(BL+CheckBevelWidth,BT+CheckBevelWidth,
                                         BR-CheckBevelWidth,BB-CheckBevelWidth),
                                         UnCheckedBitMap,
                                         Rect(0,0,BR-BL-(CheckBevelWidth*2),BB-BT-(CheckBevelWidth*2)), FTransparentColor);
                          end;

                        end;
         end;
         Brush.Color := Color;
         Pen.Color := Color;
         CaptionRect := Bounds(TX-1,TY,TW+3,TH+1);
         FrameRect(CaptionRect);
         if FFocused then
           DrawFocusRect(CaptionRect);
       end;
end;

function TBMPCheckBox.GetCaption:TCaption;

var Buf:array[0..256] of Char;

begin
     GetTextBuf(Buf,256);
     Result:=StrPas(Buf);
end;


procedure TBMPCheckBox.SetSizeToBitMap (Value : BOOLEAN);
begin
  if (Value <> FSizeToBitMap) then
  begin
    FSizeToBitMap := Value;
    if (FSizeToBitMap) then
    begin
      CheckBoxWidth := CheckedBitMap.Height+(CheckBevelWidth*2);
    end;
  end;
end;

procedure TBMPCheckBox.SetStretchBitMaps (Value : BOOLEAN);
begin
  if (Value <> FStretchBitMaps) then
  begin
    FStretchBitMaps := Value;
    Invalidate;
  end;
end;


procedure TBMPCheckBox.SetCheckWidth(Value : WORD);
begin
  if (Value <> FCheckWidth) then
  begin
    FCheckWidth := Value;
    Invalidate;
  end;
end;


procedure TBMPCheckBox.SetCheckType(Value : TCheckType);
begin
  if (Value <> FCheckType) then
  begin
    FCheckType := Value;
    Invalidate;
  end;
end;


procedure TBMPCheckBox.SetGrayedColor(Value : TColor);
begin
  if (Value <> FGrayedColor) then
  begin
    FGrayedColor := Value;
    Invalidate;
  end;
end;


procedure TBMPCheckBox.SetCheckBoxWidth(Value : Word);
begin
  if (Value <> FCheckBoxWidth) then
  begin
    FCheckBoxWidth := Value;
    Invalidate;
  end;
end;

procedure TBMPCheckBox.SetCheckBevelStyle(Value : TPanelBevel);
begin
  if (Value <> FCheckBevelStyle) then
  begin
    FCheckBevelStyle := Value;
    Invalidate;
  end;
end;


procedure TBMPCheckBox.SetCheckBevelWidth(Value : Word);
begin
  if (Value <> FCheckBevelWidth) then
  begin
    FCheckBevelWidth := Value;
    Invalidate;
  end;
end;

procedure TBMPCheckBox.SetTextIndentSize(Value : Word);
begin
  if (Value <> FTextIndentSize) then
  begin
    FTextIndentSize := Value;
    Invalidate;
  end;
end;

procedure TBMPCheckBox.SetTransparentColor(Value : TColor);
begin
  if (Value <> FTransparentColor) then
  begin
    FTransparentColor := Value;
    Invalidate;
  end;
end;

procedure TBMPCheckBox.SetCheckedBitMap(Value : TBitMap);
begin
  if (FCheckedBitMap <> Value) then
  begin
    FCheckedBitMap.Assign (Value);
    if (SizeToBitMap) then
      CheckBoxWidth := CheckedBitMap.Height+(CheckBevelWidth*2);
  end;
end;

procedure TBMPCheckBox.SetUnCheckedBitMap(Value : TBitMap);
begin
  if (FUnCheckedBitMap <> Value) then
  begin
    FUnCheckedBitMap.Assign (Value);
  end;
end;

procedure TBMPCheckBox.SetCaption(const Value:TCaption);

var Buffer: array[0..255] of Char;

begin
     if GetCaption <> Value then
       SetTextBuf(StrPCopy(Buffer,Value));
     Invalidate;
end;

procedure TBMPCheckBox.SetDown(Value:Boolean);

begin
     if FDown<>Value then
       begin
         FDown:=Value;
         Invalidate;
       end;
end;

procedure TBMPCheckBox.SetState(Value:TCheckBoxState);

begin
     if FState<>Value then
       begin
         FState:=Value;
         Invalidate;
         Click;
       end;
end;

function TBMPCheckBox.GetChecked: Boolean;

begin
     Result:=State=cbChecked;
end;

procedure TBMPCheckBox.SetChecked(Value:Boolean);

begin
     if Value then State := cbChecked
              else State := cbUnchecked;
end;

procedure TBMPCheckBox.SetCheckColor(Value:TColor);

begin
     FCheckColor:=Value;
     Invalidate;
end;

procedure TBMPCheckBox.DoEnter;

begin
     inherited DoEnter;
     FFocused:=True;
     Invalidate;
end;

procedure TBMPCheckBox.DoExit;

begin
     inherited DoExit;
     FFocused:=False;
     Invalidate;
end;

procedure TBMPCheckBox.MouseDown(Button: TMouseButton; Shift: TShiftState;
                                  X, Y: Integer);

begin
     SetFocus;
     FFocused:=True;
     inherited MouseDown(Button, Shift, X, Y);
     MouseCapture:=True;
     Down:=True;
end;

procedure TBMPCheckBox.MouseUp(Button: TMouseButton; Shift: TShiftState;
                                  X, Y: Integer);

begin
     MouseCapture:=False;
     Down:=False;
     if (X>=0) and (X<=Width) and (Y>=0) and (Y<=Height) then
       Checked:=not Checked;
     inherited MouseUp(Button, Shift, X, Y);
end;

procedure TBMPCheckBox.MouseMove(Shift: TShiftState;X, Y: Integer);

begin
     if MouseCapture then
       Down:=(X>=0) and (X<=Width) and (Y>=0) and (Y<=Height);
     inherited MouseMove(Shift,X,Y);
end;

procedure TBMPCheckBox.KeyDown(var Key:Word;Shift:TShiftSTate);

begin
     if Key=vk_Space then Down:=True;
     inherited KeyDown(Key,Shift);
end;

procedure TBMPCheckBox.KeyUp(var Key:Word;Shift:TShiftSTate);

begin
     if Key=vk_Space then
       begin
         Down:=False;
         Checked:=not Checked;
       end;
end;

{----------------------------------------------------------------}

procedure Register;

begin
  {Register BMPCheckBox on the samples page}
  RegisterComponents('Additional',[TBMPCheckBox]);
end;



end.
