unit Esgrid;

interface

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, Grids;

type
  TCaption2Placement = (cpTop,cpBottom);

  TEnhStringGrid = class(TStringGrid)
  private
    { Private declarations }
(*    FCellDelimiter: char;
    FAutoBackup: Boolean;
    FAutoSave: Boolean;   { If TRUE, saves grid info before destroying self }
    FCaption1: string;    { Top title used for top of HTML tables }
    FCaption2: string;    { Second HTML table title; its position can be either
                            underneath Caption1 at the top of the HTML table,
                            or underneath the entire HTML table as a footer.
                            This placement is what the Caption2Placement
                            property is for. }
    FPlacement: TCaption2Placement;
    FInitialFile: string; { when the component is loaded, it will try to read
                            its contents from this file.  If the file is empty,
                            the grid will come up empty. }
    procedure SetFileName(F: string);*)
  protected
    { Protected declarations }
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Loaded; override;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
{    procedure SaveToFile(FileName: string);
    procedure LoadFromFile(FileName: string);
    procedure Load;
    procedure Save;
    procedure WriteHTML(SList: TStrings);}
    procedure SetColumnTitle(C: Integer; Title: string);
    procedure RowMoved(FromIndex, ToIndex: Longint); override;
    procedure ColumnMoved(FromIndex, ToIndex: Longint); override;
    procedure InsertCol(ToIndex: LongInt);
    procedure DeleteCol(DIndex: LongInt);
    procedure InsertRow(ToIndex: LongInt);
    procedure DeleteRow(DIndex: LongInt);
    function GetColumnTitle(C: Integer): string;
  published
    { Published declarations }
    property DefaultRowHeight default 24;
{    property AutoBackup: Boolean read FAutoBackup write FAutoBackup
             default True;
    property CellDelimiter: char read FCellDelimiter write FCellDelimiter
             default '|';
    property FileName: string read FInitialFile write SetFileName;
    property Caption1: string read FCaption1 write FCaption1;
    property Caption2: string read FCaption2 write FCaption2;
    property Caption2Placement: TCaption2Placement read FPlacement
             write FPlacement default cpTop;
    property AutoSave: Boolean read FAutoSave write FAutoSave default True;}
end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('Telesoft', [TEnhStringGrid]);
end;

constructor TEnhStringGrid.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
{  FPlacement := cpTop;
  FAutoSave := True;
  FAutoBackup := True;}
  Options := Options + [goEditing, goRowMoving, goColMoving, goTabs];
  Options := Options + [goRowSizing, goColSizing];
  DefaultRowHeight := 24;
{  FCellDelimiter := '|';}
  ColWidths[0] := 16;
end;

destructor TEnhStringGrid.Destroy;
begin
{  if FAutoSave then
    Save;}
  inherited Destroy;
end;

procedure TEnhStringGrid.Loaded;
begin
  inherited Loaded;
{  if FInitialFile > '' then
    Load;}
end;

procedure TEnhStringGrid.KeyDown(var Key: Word; Shift: TShiftState);
begin
  case Key of
    VK_DOWN: begin
      if (Row = RowCount - 1) then
        RowCount := RowCount + 1;
    end;
    VK_INSERT: InsertRow(Row);
    VK_DELETE: begin
      if ssCtrl in Shift then
        if RowCount > 2 then
          if MessageDlg('Are you sure you want to delete this row?',
                        mtConfirmation, mbOKCancel, 0) = mrOK then
            DeleteRow(Row)
    end;
  end; { case }
  inherited KeyDown(Key, Shift);
end;

procedure TEnhStringGrid.SetColumnTitle(C: Integer; Title: string);
begin
  Cells[C,0] := Title;
end;

function TEnhStringGrid.GetColumnTitle(C: Integer): string;
begin
  Result := Cells[C,0];
end;
(*
procedure TEnhStringGrid.SaveToFile(FileName: string);
var
  SaveFile:    TextFile;
  r,c,rc,cc:   Integer;
  dr,dc:       Integer;
  NPart,Epart: string;
  PPart:       string;
begin
  rc := RowCount;
  cc := ColCount;
  dr := DefaultRowHeight;
  dc := DefaultColWidth;
  if FAutoBackup then
    if FileExists(FileName) then begin
      PPart := ExtractFilePath(FileName);
      NPart := ExtractFileName(FileName);
      EPart := 'BAK';
      RenameFile(FileName, PPart + NPart + EPart);
    end; { if }
  if FileCreate(FileName) < 0 then begin
    MessageDlg(FileName + ' is not a valid file name.', mtError, [mbOK], 0);
    Exit;
  end;
  AssignFile(SaveFile, FileName);
  ReWrite(SaveFile);
  try
    WriteLn(saveFile, FCellDelimiter);
    WriteLn(SaveFile, rc, FCellDelimiter, cc);
    WriteLn(SaveFile, DefaultRowHeight);
    WriteLn(SaveFile, FCaption1);
    WriteLn(SaveFile, FCaption2);
    if FPlacement = cpTop then
      WriteLn(SaveFile, 'Top')
    else
      WriteLn(SaveFile, 'Bottom');
    for r := 0 to rc-1 do
      if RowHeights[r] <> dr then
        WriteLn(SaveFile, 'Row ', r, ' Height: ', RowHeights[r]);
    for c := 0 to cc-1 do
      if ColWidths[c] <> dc then
        WriteLn(SaveFile, 'Column ', c, ' Width: ', ColWidths[c]);
    for r := 0 to rc-1 do
      for c := 1 to cc-1 do
        if Cells[c,r] > '' then
          WriteLn(SaveFile, c, FCellDelimiter, r, FCellDelimiter, Cells[c,r]);
    WriteLn(SaveFile);
  finally
    CloseFile(SaveFile);
  end;
end;

procedure TEnhStringGrid.LoadFromFile(FileName: string);
var
  LoadFile:   TextFile;
  R:          string;
  P:          Byte;
  RecNo:      LongInt;
  t,v,i:      Integer;
begin
  if not FileExists(FileName) then begin
{    MessageDlg('File ' + FileName + ' does not exist.', mtError, [mbOK], 0); }
    Exit;
  end;
  AssignFile(LoadFile, FileName);
  Reset(LoadFile);
  if EOF(LoadFile) then begin
    CloseFile(LoadFile);
    Exit;
  end;
  RecNo := 0;
  try
    while not EOF(LoadFile) do begin
      ReadLn(LoadFile, R);
      Inc(RecNo);
      if RecNo = 1 then
        FCellDelimiter := R[1]
      else if RecNo = 2 then begin
        P := Pos('|',R);
        RowCount := StrToInt(Copy(R,1,P-1));
        ColCount := StrToInt(Copy(R,P+1,Length(R)-P));
      end else if RecNo = 3 then
        DefaultRowHeight := StrToInt(R)
      else if RecNo = 4 then
        FCaption1 := R
      else if RecNo = 5 then
        FCaption2 := R
      else if RecNo = 6 then begin
        if R='Top' then
          FPlacement := cpTop
        else
          FPlacement := cpBottom
      end else if Copy(R, 1, 3) = 'Row' then begin
        i := Pos('Height: ', R);
        t := StrToInt(Copy(R, 5, i-6));
        v := StrToInt(Copy(R, i+8, Length(R)-(i+5)));
        RowHeights[t] := v;
      end else if Copy(R, 1, 6) = 'Column' then begin
        i := Pos('Width: ', R);
        t := StrToInt(Copy(R, 8, i-9));
        v := StrToInt(Copy(R, i+7, Length(R)-(i+6)));
        ColWidths[t] := v;
      end else begin
        i := Pos('|', R);
        if i = 0 then
          continue;
        t := StrToInt(Copy(R, 1, i-1)); { Column number }
        R := Copy(R, i+1, Length(R)-i);
        i := Pos('|',R);
        v := StrToInt(Copy(R, 1, i-1)); { Row Number }
        R := Copy(R, i+1, Length(R)-i);
        Cells[t,v] := R;
      end; { if-else-if-else-if }
    end; { while not EOF }
  finally
    CloseFile(LoadFile);
  end; { try }
end;

procedure TEnhStringGrid.Load;
begin
  if FInitialFile > '' then
    LoadFromFile(FInitialFile);
end;

procedure TEnhStringGrid.Save;
begin
  if FInitialFile > '' then
    SaveToFile(FInitialFile);
end;

procedure TEnhStringGrid.SetFileName(F: string);
begin
  FInitialFile := F;
  Load;
end;

procedure TEnhStringGrid.WriteHTML(SList: TStrings);
var
  i,j: Integer;
  s:   string;

  procedure AddSecondCaption;
  begin
    if FCaption2 > '' then
      with SList do begin
        Add('<tr><th nowrap colspan=' + IntToStr(ColCount-1) + '>' + FCaption2 +
            '</th></tr>');
      end;
  end;

begin
  with SList do begin
    Add('<table border=1>');        { begin the table }
    if FCaption1 > '' then begin     { Add the first (top) caption, if exists }
      Add('<tr><th nowrap colspan=' + IntToStr(ColCount-1) + '>' + FCaption1 +
          '</th></tr>');
    end; { if }
    if FPlacement = cpTop then      { Add the second caption if it goes on top }
      AddSecondCaption;

    Add('<tr>');                    { Add titles as HTML table column headers }
    for i := 1 to ColCount-1 do begin
      s := Cells[i,0];
      if s = '' then
        s := '<br>';
      Add('<th nowrap>' + s + '</th>');
    end;
    Add('</tr>');

    for i := 1 to RowCount-1 do begin
      Add('<tr>');
      for j := 1 to ColCount-1 do begin
        s := Cells[j,i];
        if s = '' then
          s := '<br>';
        Add('<td nowrap>' + s + '</td>');
      end; { for }
      Add('</tr>');
    end;
    if FPlacement = cpBottom then
      AddSecondCaption;

    Add('</table><p>');
  end; { with SList }
end;
*)
procedure TEnhStringGrid.RowMoved(FromIndex, ToIndex: Longint);
begin
  inherited RowMoved(FromIndex, ToIndex);
end;

procedure TEnhStringGrid.ColumnMoved(FromIndex, ToIndex: Longint);
begin
  inherited ColumnMoved(FromIndex, ToIndex);
end;

procedure TEnhStringGrid.InsertRow(ToIndex: LongInt);
begin
  HideEditor;
  RowCount := RowCount + 1;
  RowMoved(RowCount, ToIndex);
end;

procedure TEnhStringGrid.DeleteRow(DIndex: LongInt);
begin
  HideEditor;
  RowMoved(DIndex, RowCount);
  Rows[RowCount].Clear;
  if FixedRows=RowCount-1
    then exit;
  RowCount := RowCount - 1;
end;

procedure TEnhStringGrid.InsertCol(ToIndex: LongInt);
begin
  HideEditor;
  ColCount := ColCount + 1;
  ColumnMoved(ColCount, ToIndex);
end;

procedure TEnhStringGrid.DeleteCol(DIndex: LongInt);
begin
  HideEditor;
  ColumnMoved(DIndex, ColCount);
  Cols[ColCount].Clear;
  if FixedCols=ColCount-1
    then exit;
  ColCount := ColCount - 1;
end;


end.
