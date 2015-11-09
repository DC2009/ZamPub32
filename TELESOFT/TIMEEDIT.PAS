unit Timeedit;

interface

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Menus, Forms, StdCtrls, Dialogs;

const
  mBadTime='Godzina niew³aœciwa';

type
  TErrorSignal = (esBeep, esVisual, esBeepVisual); {how to show an error}

  TTimeEdit = class(TCustomEdit)
  private
    TOList: TList;
    FSelText: PChar;
    FEditTime: TDateTime;
    FEmptyChar: Char;
    FErrorSignal:TErrorSignal;
    FLeadingZero: Boolean;
    FSeparator: Char;
    FUseCurrentTime: Boolean;
    FEmptyTime: Boolean; {Time field may be empty}
    procedure SetEditTime(Value: TDateTime);
    function GetDateElement(Index: integer): integer;
    procedure SetDateElement(Index: integer; Value: integer);
    procedure SetEmptyChar(Value: char);
    procedure SetInternational;
    procedure SetUseCurrentTime(Value: boolean);
    function IsValidChar(Pos: word; Key: char): boolean;
  protected
    procedure CreateParams(var Params: TCreateParams); override;
    procedure CreateWnd; override;
    procedure DoEnter; override;
    procedure DoExit; override;
    procedure KeyPress(var Key: Char); override;
    function ValidateTime: TDateTime; virtual;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure UpdateEdit; virtual;
    property EditTime: TDateTime read FEditTime write SetEditTime;
  published
    property AcceptEmptyTime: Boolean read FEmptyTime write FEmptyTime default TRUE;
    property AutoSelect default false;
    property AutoSize;
    property BorderStyle;
    property Color;
    property Ctl3D;
    property DragCursor;
    property DragMode;
    property EmptyChar: char read FEmptyChar write SetEmptyChar default ' ';
    property Enabled;
    property ErrorSignal: TErrorSignal read FErrorSignal write FErrorSignal default esBeep;
    property Font;
    property Hours: integer index 1 read GetDateElement write SetDateElement
        stored False;
    property Minutes: integer index 2 read GetDateElement write SetDateElement
        stored False;
    property ParentColor;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ReadOnly;
    property Separator: Char read FSeparator {write SetSeparator};
    property ShowHint;
    property TabOrder;
    property TabStop;
    property UseCurrentTime: Boolean read FUseCurrentTime
        write SetUseCurrentTime default True;
    property Visible;
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

procedure Register;
begin
  RegisterComponents('Telesoft', [TTimeEdit]);
end;

type
TSelected = record
    Start: word;
    Stop: word;
end;
TSelectedPtr = ^TSelected;

constructor TTimeEdit.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  TOList:=TList.Create;
  FSelText:=StrAlloc(6);
  AutoSelect:=FALSE ;
  MaxLength:=5;
  FEmptyChar:=' ';
  FEmptyTime:=TRUE;
  FEditTime:=Time;
  FUseCurrentTime:=TRUE;
  SetInternational;
  Width:=41;
end;

destructor TTimeEdit.Destroy;
begin
  TOList.Free;
  StrDispose(FSelText);
  inherited Destroy
end;

procedure TTimeEdit.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  Params.Style := Params.Style or ES_MULTILINE or WS_CLIPCHILDREN;
end;

procedure TTimeEdit.CreateWnd;
var
  Loc: TRect;
begin
  inherited CreateWnd;
  SendMessage(Handle, EM_GETRECT, 0, LongInt(@Loc));
  Loc.Bottom := ClientHeight + 1;  {+1 is workaround for windows paint bug}
  Loc.Right := ClientWidth - 1;
  Loc.Top := 0;
  Loc.Left := 0;
  SendMessage(Handle, EM_SETRECTNP, 0, LongInt(@Loc));
end;

procedure TTimeEdit.DoEnter;
var
  sel: TSelectedPtr;
  ret: longint;
begin
  inherited DoEnter;
  sel := TSelectedPtr(@ret);
  sel^.Start := 0;
  if AutoSelect
    then sel^.Stop := MaxLength
    else sel^.Stop := 0;
  SendMessage(Handle, EM_SETSEL, 0, ret);
end;

procedure TTimeEdit.DoExit;
var
  DT: TDateTime;
begin
  dt := ValidateTime;
  if dt < -1
    then begin
      case FErrorSignal of
        esBeep:
          MessageBeep(0);
        esVisual:
          MessageDlg(mBadTime,mtError,[mbOk],0);
        esBeepVisual:
          begin
            MessageBeep(0);
            MessageDlg(mBadTime,mtError,[mbOk],0);
          end;
      end;{case}
      UpdateEdit;
      SetFocus
    end
    else begin
      if dt=-1
        then begin
          FEditTime:=Now;
          Text:='';
        end
        else FEditTime := dt;
      inherited DoExit
    end;
end;

procedure TTimeEdit.KeyPress(var Key: Char);
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
            dt := ValidateTime;
            if dt >= 0 then
              begin
                FEditTime := dt;
                db.Click
              end
            else if dt=-1
              then FEditTime:=Now
            else if dt=-2
              then begin
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
                    if Sel^.Start = 2 then
                        Sel^.Start := Sel^.Start - 1;
                end;
                bs := true;
                Key := FEmptyChar;
            end;
            if sel^.Start = 2 then
                Key := FSeparator;
            if sl = 0 then begin
                sl := 1;
                sel^.Stop := Sel^.Start + sl;
                SendMessage(Handle, EM_SETSEL, 0, ret)
            end;
            if Key = ' ' then
                Key := FEmptyChar;
            FSelText[0] := Key;
            i := 1;
            while i < sl do begin
                if (sel^.Start + i) = 2 then Key := FSeparator
                else Key := FEmptyChar;
                FSelText[i] := Key;
                Inc(i)
            end;
            FSelText[i] := #0;
            SendMessage(Handle, EM_REPLACESEL, 0, longint(FSelText));
            if not bs then begin
                Inc(sel^.Start);
                if sel^.Start = 2 then Inc(sel^.Start);
            end;
            sel^.Stop := sel^.Start;
            SendMessage(Handle, EM_SETSEL, 0, ret);
        end
        else MessageBeep(0);
    end;
    Key := #0;
    inherited KeyPress(Key);
end;


function TTimeEdit.IsValidChar(Pos: word; Key: char): boolean;
begin
  if Key = char(VK_BACK)
    then Result := true
  else if Pos = 0
    then Result := (Key in [' ', '0'..'2'])
  else if Pos in [1, 4]
    then Result := (Key in ['0'..'9'])
  else if Pos = 3
    then Result := (Key in ['0'..'5'])
  else if Pos = 2
    then Result := true
  else Result := false;
end;

procedure TTimeEdit.SetEditTime(Value: TDateTime);
begin
  Value := Value - Int(Value);
  if Value <> FEditTime
    then begin
      FEditTime := Value;
      UpdateEdit
    end
end;

procedure TTimeEdit.UpdateEdit;
var AHours, AMinutes, ASeconds, AMSecs: word;
    AText: TCaption;
begin
  DecodeTime(FEditTime, AHours, AMinutes, ASeconds, AMSecs);
  if AHours >= 10
    then AText:=IntToStr(AHours)+FSeparator
    else begin
      if FLeadingZero
        then AText := '0' + IntToStr(AHours) + FSeparator
        else AText := FEmptyChar + IntToStr(AHours) + FSeparator;
    end;
  if AMinutes >= 10
    then Text := AText + IntToStr(AMinutes)
    else Text := AText + '0' + IntToStr(AMinutes);
end;

procedure TTimeEdit.SetInternational;
begin
  FSeparator := GetProfileChar('Intl'#0, 'sTime'#0, ':');
  FLeadingZero := (GetProfileInt('Intl'#0, 'iTLZero'#0, 0) > 0);
  UpdateEdit
end;

procedure TTimeEdit.SetEmptyChar(Value: char);
begin
  if Value <> FEmptyChar
    then begin
      FEmptyChar := Value;
      UpdateEdit
    end
end;

procedure TTimeEdit.SetUseCurrentTime(Value: boolean);
begin
  if Value <> FUseCurrentTime
    then begin
      FUseCurrentTime := Value;
      if Value
        then SetEditTime(Time);
    end
end;

function TTimeEdit.GetDateElement(Index: Integer): Integer;
var AHours, AMinutes, ASeconds, AMSecs: word;
begin
  DecodeTime(FEditTime, AHours, AMinutes, ASeconds, AMSecs);
  case Index of
    1: Result := AHours;
    2: Result := AMinutes;
    else Result := -1;
  end;
end;

procedure TTimeEdit.SetDateElement(Index: Integer; Value: Integer);
var AHours, AMinutes, ASeconds, AMSecs: word;
    ADate: TDateTime;
begin
  try
    DecodeTime(ADate, AHours, AMinutes, ASeconds, AMSecs);
    case Index of
        1: ADate := EncodeTime(Value, AMinutes, ASeconds, AMSecs);
        2: ADate := EncodeTime(AHours, Value, ASeconds, AMSecs);
        else Exit;
    end;
    FUseCurrentTime := False;
    SetEditTime(ADate)
  except
    on EConvertError do
      begin
        MessageBeep(0);
        SetFocus
      end
    else raise
  end;
end;

function TTimeEdit.ValidateTime: TDateTime;
var AHours, AMinutes: Integer;
begin
  try
    AMinutes := StrToIntDef(Copy(Text, 4, 2), -1);
    if Text[1] = FEmptyChar
      then AHours := StrToIntDef(Copy(Text, 2, 1), -1)
      else AHours := StrToIntDef(Copy(Text, 1, 2), -1);
    if (AMinutes >= 0) and (AHours >= 0) and
       (AHours < 24) and (AMinutes < 60)
      then Result := EncodeTime(AHours, AMinutes, 0, 0)
      else begin
        if FEmptyTime and (AMinutes=-1) and (AHours=-1)
          then Result:=-1
          else Result:=-2;
      end;
  except
    on EConvertError do Result := -2;
    else raise
  end;
end;

end.
