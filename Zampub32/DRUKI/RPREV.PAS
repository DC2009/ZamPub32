unit Rprev;
{**********************
This is a quick and small Print Preview object.
  Create it
  call NewJob
  Draw on it (TextOut, Rectangle, etc.)
  call Preview, PrintIt, or PrintPage

This object is based on metafiles. All the pages are open
at one time so you can draw on page 50 at the same time you're
drawing on page 2 (real handy for putting those
"Page 1 of 50" labels).  Since it uses metafiles, it's fast,
real fast at the drawing.  It works great for those small
projects where you need print preview, but don't need a big
report printer.
*********************}

interface

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Forms, StdCtrls, Printers, ExtCtrls, Buttons, Dialogs;

const
     PreviewSizeFull = 144;
     PreviewSizeThreeQuarters = 108;
     PreviewSizeHalf = 72;
     PreviewSizeQuarter = 36;

type
  TRyPrinter = class;
  TRyPreviewFrm = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    sb: TScrollBox;
    PaintBox1: TPaintBox;
    ShwGrdBtn: TSpeedButton;
    PriorBtn: TSpeedButton;
    NextBtn: TSpeedButton;
    FirstBtn: TSpeedButton;
    LastBtn: TSpeedButton;
    PrintBtn: TSpeedButton;
    FullPageBtn: TSpeedButton;
    ZoomInBtn: TSpeedButton;
    ZoomOutBtn: TSpeedButton;
    CloseBtn: TSpeedButton;
    PrintPageBtn: TSpeedButton;
    procedure PrintBtnClick(Sender: TObject);
    procedure FirstBtnClick(Sender: TObject);
    procedure PriorBtnClick(Sender: TObject);
    procedure NextBtnClick(Sender: TObject);
    procedure LastBtnClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FullPageBtnClick(Sender: TObject);
    procedure PaintBox1Paint(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure ShwGrdBtnClick(Sender: TObject);
    procedure PrintPageBtnClick(Sender: TObject);
    procedure PaintBox1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Button3Click(Sender: TObject);
    procedure ZoomOutBtnClick(Sender: TObject);
    procedure ZoomInBtnClick(Sender: TObject);
    procedure CloseBtnClick(Sender: TObject);
  private
    { Private declarations }
    Ry : TRyPrinter;
    PageDisplaying : Integer;
    function ConvX(x : integer) : integer;
    function ConvY(y : integer) : integer;
    function ConvWidth(x : integer) : integer;
    function ConvHeight(y : integer) : integer;
    procedure ResizePaintBox(PPI:Integer);
  public
    { Public declarations }
      twipX, twipY                : double; (* twips per pixel *)
      screenScaleX, screenScaleY  : double;
      maxX, maxY                  : longint;
      screenFont                  : TFont;  (* font used for the screen *)
      pixelsperinchdevice         : longint;
      pixelsperinchprinter        : longint;
      OffsetX, OffsetY            : longint; (* margins for the printer *)
      twipMaxX, twipMaxY          : longint;
      PixelsPerInch:LongInt;
      Orientation:TPrinterOrientation;
      procedure SetFont( font : tFont );

  end;

  TRyPrinter = class(TObject)
  private
    { Private declarations }
      {Current page}
    FCurrentPage : Integer;
      {Raw canvases - with Handles connected to OPEN metafiles}
    FCanvases : TList;
    FDonePrinting : Boolean;
      {Metafiles - with Handles connected to CLOSED metafiles}
    FMetafiles : TList;
      {Pointer to the preview form, which isn't created until Preview is called}
    FRyPreviewForm : TRyPreviewFrm;
    FOrientation : TPrinterOrientation;

    function GetPageCount : Integer;
    procedure SetCurrentPage(Index : Integer);
    function GetCanvas(Index : Integer): TCanvas;
    function GetMetafile(Index : Integer): TMetafile;
    function GetFont : TFont;
    procedure SetFont(Value : TFont);
    function GetPen : TPen;
    procedure SetPen(Value : TPen);
    procedure SetOrientation(Value : TPrinterOrientation);
  protected
    { Protected declarations }
  public
    { Public declarations }
    pXppi : Integer;
    pYppi : Integer;
    PixelsPerInchPrinter : longint;

      {Reports where the Printable area starts}
    XLOff : Integer;
    XROff : Integer;
    YTOff : Integer;
    YBOff : Integer;
      {Assign Title before call to PrintIt or PrintPage (not necessary)}
    Title : String;

      {reports the physical page}
    function PageSize : TPoint;
      {reports the Printable area}
    function PrintSize : TPoint;

     {Here's the gold - when you're done drawing,
     call one or all of these to display or print your work}
    procedure PrintPage(const PageNum : Integer);
    procedure PrintIt;
    procedure Preview;
    procedure WriteDemo(var NewPos:Integer);
       {for some reason this doesn't work - can't figure out why -
        it write the files, but the files are unreadable}
    procedure SaveToFile(const TheFile : String);

     {Routine that is called by the Preview form to display page
      Actually called in PaintBox1.OnPaint - Don't call this (it might be
      best to put this in the preview form)}
    procedure DisplayPage(Page : Integer);

     {Takes Inches and outputs Pixels}
    function XInch(const aSingle : Single): Integer;
    function YInch(const aSingle : Single): Integer;
     {Takes millimetres and outputs Pixels}
    function Xmm(const aSingle : Single): Integer;
    function Ymm(const aSingle : Single): Integer;

    {min margins betwwen what we want and the printer margins}
    procedure SetMinMargins(Left,Top,Right,Bottom:Integer);
    procedure Draw(const X, Y : Integer; const Graphic : TGraphic);
    procedure StretchDraw(const aRect : TRect; const Graphic : TGraphic);
    procedure TextOut(const X, Y : Integer; const Text : String);
    procedure TextOutRight(const X, Y : Integer; const Text : String);
    procedure TextOutCenter(const X, Y : Integer; const Text : String);
    procedure TextRect(const aRect : TRect; const X, Y : Integer;
      const Text : String);
    function TextWidth(const Text : String): Integer;
    function TextHeight: Integer;
    procedure Line(const a, b : TPoint);
    procedure Rectangle(const aRect : TRect);
    procedure RoundRectangle(const aRect : TRect);
      {Spits out a memo between two bounds (bottom is irrelevant)
       includes TabStop functionality - outputs Height of finished text}
    function MemoOut(const aRect : TRect; p : PChar; DisposePChar : Boolean;
      DontPrint : Boolean): Integer;
      {Clips a PChar to a Rect. The part that doesn't fit is returned in Clip)
       includes TabStop functionality - outputs Height of finished text}
    function PCharOut(const aRect: TRect; p: PChar;
      DisposePChar, DontPrint, ClipToRect: Boolean; var Clip:PChar): Integer;
      {steps through the pages and puts the page numbers at the position you
       specify, for ex. "Page 1 of 2" - call after all your drawing for
       best results}
    procedure PutPageNums(const X, Y : Integer; Alignment : TAlignment);

      {Must call before drawing - automatically creates the first page}
    procedure NewJob;
      {Called once before Preview, PrintIt, or PringPage -
       if you don't call it, it will be called automatically}
    procedure DonePrinting;
    function NewPage : Integer;
    constructor Create;
    destructor Destroy; override;

    property PageCount : Integer  read GetPageCount;
    property CurrentPage : Integer read FCurrentPage write
      SetCurrentPage;
      {don't try using canvases after DonePrinting - the handles will be
        invalid}
    property Canvases[Index : Integer] : TCanvas read GetCanvas;
    property Metafiles[Index : Integer] : TMetafile read GetMetafile;
    property Font : TFont read GetFont write SetFont;
    property Pen : TPen read GetPen write SetPen;
      {best to set Orientation before calling NewJob}
    property Orientation : TPrinterOrientation read FOrientation write
      SetOrientation;
  end;


implementation

{$R *.DFM}

function TRyPrinter.GetPageCount : Integer;
begin
  Result := FCanvases.Count;
end;

procedure TRyPrinter.SetCurrentPage(Index : Integer);
begin
  if (Index <= PageCount) AND (Index > 0)
    then FCurrentPage := Index;
end;

function TRyPrinter.GetCanvas(Index : Integer): TCanvas;
begin
  if (Index > 0) AND (Index <= PageCount)
    then Result := TCanvas(FCanvases[Index - 1]);
end;

function TRyPrinter.GetMetafile(Index : Integer): TMetafile;
begin
  if (Index > 0) AND (Index <= PageCount) AND FDonePrinting
    then Result := TMetafile(FMetafiles[Index - 1]);
end;

function TRyPrinter.GetFont : TFont;
begin
  Result := Canvases[CurrentPage].Font;
end;

procedure TRyPrinter.SetFont(Value : TFont);
begin
Canvases[CurrentPage].Font := Value;
end;

function TRyPrinter.GetPen : TPen;
begin
Result := Canvases[CurrentPage].Pen;
end;

procedure TRyPrinter.SetPen(Value : TPen);
begin
Canvases[CurrentPage].Pen := Value;
end;

procedure TRyPrinter.SetOrientation(Value : TPrinterOrientation);
begin
FOrientation := Value;
Printer.Orientation := Value;
{if Orientation=poPortrait
  then begin}
    pXppi := GetDeviceCaps(Printer.Handle, LOGPIXELSX);
    pYppi := GetDeviceCaps(Printer.Handle, LOGPIXELSY);
{  end
  else begin
    pYppi := GetDeviceCaps(Printer.Handle, LOGPIXELSX);
    pXppi := GetDeviceCaps(Printer.Handle, LOGPIXELSY);
  end}
end;

function TRyPrinter.PageSize : TPoint;
begin
Escape(Printer.Handle, GETPHYSPAGESIZE, 0, nil, @Result);
end;

function TRyPrinter.PrintSize : TPoint;
begin
Result.X := Printer.PageWidth;
Result.Y := Printer.PageHeight;
end;

procedure TRyPrinter.PrintPage(const PageNum : Integer);
var
 s : String;
begin
if not FDonePrinting then DonePrinting;
if (PageNum > 0) AND (PageNum <= PageCount) then begin
  Printer.Title := Title;
  Printer.Orientation:=fOrientation;
  Printer.BeginDoc;
  if Assigned(FRyPreviewForm) then s := FRyPreviewForm.Panel2.Caption;
  try
  if Assigned(FRyPreviewForm) then
    FRyPreviewForm.Panel2.Caption := Format('Strona %d z %d',
      [PageNum, PageCount]);
  Printer.Canvas.StretchDraw(
    Rect(0,0,Printer.PageWidth, Printer.PageHeight), Metafiles[PageNum]);
  finally
  Printer.EndDoc;
  if Assigned(FRyPreviewForm) then FRyPreviewForm.Panel2.Caption := s;
  end;
  end;
end;


procedure TRyPrinter.PrintIt;
var
 i : Integer;
 s : String;
begin
if not FDonePrinting then DonePrinting;
if PageCount > 0 then begin
  Printer.Title := Title;
  Printer.Orientation:=fOrientation;
  Printer.BeginDoc;
  i := 1;
  if Assigned(FRyPreviewForm) then
    s := FRyPreviewForm.Panel2.Caption;
  try
  if Assigned(FRyPreviewForm) then
    FRyPreviewForm.Panel2.Caption := Format('Strona %d z %d',
      [1, PageCount]);
  Printer.Canvas.StretchDraw(
    Rect(0,0,Printer.PageWidth, Printer.PageHeight), Metafiles[i]);
  for i := 2 to PageCount do begin
    if Assigned(FRyPreviewForm) then
      FRyPreviewForm.Panel2.Caption := Format('Strona %d z %d',
        [i, PageCount]);
    Printer.NewPage;
    Printer.Canvas.StretchDraw(
      Rect(0,0,Printer.PageWidth, Printer.PageHeight), Metafiles[i]);
    end;
  finally
  Printer.EndDoc;
  if Assigned(FRyPreviewForm) then
    FRyPreviewForm.Panel2.Caption := s;
  end;
  end;
end;

procedure TRyPrinter.Preview;
begin
if not FDonePrinting then DonePrinting;
FRyPreviewForm := TRyPreviewFrm.Create(Application);
FRyPreviewForm.Ry := Self;
{FRyPreviewForm.Orientation:=Orientation;}
FRyPreviewForm.ShowModal;
FRyPreviewForm.Release;
FRyPreviewForm := nil;
end;

procedure TRyPrinter.SaveToFile(const TheFile : String);
var
 i : integer;
begin
if FDonePrinting then
  for i := 1 to PageCount do begin
    Metafiles[i].SaveToFile(Format('%6s%.2d', [TheFile, i]));
    end;
end;


procedure TRyPrinter.DisplayPage(Page : Integer);
var
  p : TPoint;
  Sc : Single;
  r : TRect;
  i : integer;
begin
if (Page > 0) AND (Page <= PageCount) then begin
  FRyPreviewForm.PaintBox1.Canvas.Rectangle(
    0, 0, FRyPreviewForm.PaintBox1.Width,
    FRyPreviewForm.PaintBox1.Height);
  FRyPreviewForm.PaintBox1.Canvas.FillRect(
    Rect(1, 1, FRyPreviewForm.PaintBox1.Width - 2,
    FRyPreviewForm.PaintBox1.Height - 2));

  if FRyPreviewForm.ShwGrdBtn.Down then begin
    with FRyPreviewForm do begin
      PaintBox1.Canvas.Pen.Style := psDash;
      PaintBox1.Canvas.Rectangle( ConvX(0), ConvY(0), maxx - ConvX(0), maxy - ConvY(0) );
      PaintBox1.Canvas.Pen.Style := psSolid;
      end;
    end;

  with FRyPreviewForm do
    begin
      r.Left:=ConvX(0);
      r.Top:=ConvY(0);
      r.Right:=maxX-ConvX(0);
      r.Bottom:=MaxY-ConvY(0);

      PaintBox1.Canvas.StretchDraw(r, Metafiles[Page]);
      Panel2.Caption:=Format('Strona %d z %d', [Page, PageCount]);
      PageDisplaying := Page;
      if Page = 1
        then begin
          FirstBtn.Enabled := False;
          PriorBtn.Enabled := False;
        end
        else begin
          FirstBtn.Enabled := True;
          PriorBtn.Enabled := True;
        end;
      if PageCount > Page
        then begin
          NextBtn.Enabled := True;
          LastBtn.Enabled := True;
        end
        else begin
          NextBtn.Enabled := False;
          LastBtn.Enabled := False;
        end;
    end;
  end;
end;

function TRyPrinter.XInch(const aSingle : Single): Integer;
begin
  Result := Trunc(pXppi * aSingle);
end;


function TRyPrinter.YInch(const aSingle : Single): Integer;
begin
  Result := Trunc(pYppi * aSingle);
end;

function TRyPrinter.Xmm(const aSingle : Single): Integer;
begin
  Result := Round{Trunc}(pXppi * aSingle / 25.4);
end;

function TRyPrinter.Ymm(const aSingle : Single): Integer;
begin
  Result := Round{Trunc}(pYppi * aSingle / 25.4);
end;

procedure TRyPrinter.Draw(const X, Y : Integer; const Graphic : TGraphic);
begin
if (FCurrentPage > 0) AND (not FDonePrinting) then begin
  with Canvases[FCurrentPage] do begin
    Draw(X - XLOff, Y - YTOff, Graphic)
    end;
  end;
end;

procedure TRyPrinter.StretchDraw(const aRect : TRect; const Graphic : TGraphic);
begin
if (FCurrentPage > 0) AND (not FDonePrinting) then begin
  with Canvases[FCurrentPage] do begin
    StretchDraw(aRect{(aRect.Left + XLOff, aRect.Top + YTOff, aRect.Right + XLOff,
                     aRect.Bottom + YTOff)}, Graphic)
    end;
  end;
end;

procedure TRyPrinter.TextOut(const X, Y : Integer; const Text : String);
begin
if (FCurrentPage > 0) AND (not FDonePrinting) then begin
  with Canvases[FCurrentPage] do begin
    TextOut(X {+ XLOff}, Y {+ YTOff}, Text)
    end;
  end;
end;

procedure TRyPrinter.TextOutRight(const X, Y : Integer; const Text : String);
var a:Integer;
begin
if (FCurrentPage > 0) AND (not FDonePrinting) then begin
  with Canvases[FCurrentPage] do begin
{    if not Assigned(FRyPreviewForm)
      then} TextOut(X - Self.TextWidth(Text) {- XLOff}, Y {- YTOff}, Text)
{      else TextOut( FRyPreviewForm.ConvX(x), FRyPreviewForm.ConvY(y), text );}
    end;
  end;
a:=Self.TextWidth(Text);
end;


procedure TRyPrinter.TextOutCenter(const X, Y : Integer; const Text : String);
begin
if (FCurrentPage > 0) AND (not FDonePrinting) then begin
  with Canvases[FCurrentPage] do begin
    TextOut(X - (Self.TextWidth(Text) div 2) {- XLOff}, Y {- YTOff}, Text);
    end;
  end;
end;

procedure TRyPrinter.TextRect(const aRect : TRect; const X, Y : Integer;
  const Text : String);
begin
if (FCurrentPage > 0) AND (not FDonePrinting) then begin
  with Canvases[FCurrentPage] do begin
    TextRect(aRect{(aRect.Left - XOff, aRect.Top - YOff, aRect.Right - XOff,
      aRect.Bottom - YOff), X - XOff, Y - YOff},x,y, Text);
    end;
  end;
end;

function TRyPrinter.TextWidth(const Text : String): Integer;
begin
if (FCurrentPage > 0) AND (not FDonePrinting) then begin
  Printer.Canvas.Font := Canvases[FCurrentPage].Font;
  Result := Printer.Canvas.TextWidth(Text);
  end else Result := -1;
end;

function TRyPrinter.TextHeight: Integer;
begin
if (FCurrentPage > 0) AND (not FDonePrinting) then begin
  Printer.Canvas.Font := Canvases[FCurrentPage].Font;
  Result := Printer.Canvas.TextHeight('X');
  end else Result := -1;
end;

procedure TRyPrinter.Line(const a, b : TPoint);
begin
if (FCurrentPage > 0) AND (not FDonePrinting) then begin
  with Canvases[FCurrentPage] do begin
    MoveTo(a.X {- XLOff}, a.Y {- YTOff});
    LineTo(b.X {- XLOff}, b.Y {- YTOff});
    end;
  end;
end;

procedure TRyPrinter.Rectangle(const aRect : TRect);
begin
if (FCurrentPage > 0) AND (not FDonePrinting) then begin
  with Canvases[FCurrentPage] do begin
    Rectangle(aRect.Left {+ XLOff}, aRect.Top {+ YTOff}, aRect.Right {+ XLOff},
       aRect.Bottom {+ YTOff});
    end;
  end;
end;


procedure TRyPrinter.RoundRectangle(const aRect : TRect);
begin
if (FCurrentPage > 0) AND (not FDonePrinting) then begin
  with Canvases[FCurrentPage] do
    RoundRect(aRect.Left, aRect.Top, aRect.Right, aRect.Bottom, Xmm(3), Ymm(3));
  end;
end;

function TRyPrinter.MemoOut(const aRect : TRect; p : PChar; DisposePChar : Boolean;
  DontPrint : Boolean): Integer;
var
  x, y : Integer;
  l : PChar;
  t : Integer;
  i : Longint;
  InMiddleOfReturn : Boolean;
  InMiddleOfWord : Boolean;
  WordBegin : PChar;

    procedure DoTab;
    var d : Integer;
    begin
    d := aRect.Left;
    repeat
    Inc(d, t);
    until d > x;
    x := d;
    end;

    procedure NextLine;
    begin
    Inc(y, TextHeight);
    x := aRect.Left;
    end;

    function WordLength : Integer;
    var  temp : PChar;
    begin
      temp := StrAlloc(l - WordBegin + 1);
      StrLCopy(temp, l, l - WordBegin);
      Result := TextWidth(StrPas(temp));
      StrDispose(temp);
    end;

    procedure DoWord;
    var  temp : PChar;
    begin
    temp := StrAlloc(l - WordBegin + 1);
    StrLCopy(temp, WordBegin, l - WordBegin);

    if (TextWidth(StrPas(temp)) + x) > (aRect.Right) then NextLine;
    if not DontPrint then TextOut(x, y, StrPas(temp));

    Inc(x, TextWidth(StrPas(temp)));

    StrDispose(temp);

    InMiddleOfWord := False;
    end;

begin
if (FCurrentPage > 0) AND (not FDonePrinting) AND Assigned(p) then begin
  t := TextWidth('        ');
  l := p;
  x := aRect.Left;
  y := aRect.Top;
  InMiddleOfWord := False;
  InMiddleOfReturn := False;

  for i := 0 to StrLen(p) do begin
    case l^ of
      #9 : begin {it's a tab}
        if InMiddleOfWord then DoWord;
        DoTab;
        if x > (aRect.Right) then NextLine;
        InMiddleOfWord := False;
        InMiddleOfReturn := False;
        end;
      #10 : begin
        if InMiddleOfWord then DoWord;
        if not InMiddleOfReturn then NextLine;
        InMiddleOfWord := False;
        InMiddleOfReturn := False;
        end;
      #13 : begin
        if InMiddleOfWord then DoWord;
        if i<StrLen(p)-2  {don't print last CR}
          then NextLine;
        InMiddleOfWord := False;
        InMiddleOfReturn := True;
        end;
      #32 : begin
        if InMiddleOfWord then DoWord;
        Inc(x, TextWidth(' '));
        if (x > (aRect.Right)) then NextLine;
        InMiddleOfWord := False;
        InMiddleOfReturn := False;
        end;
      else
        if not InMiddleOfWord then WordBegin := l;
        InMiddleOfWord := True;
        InMiddleOfReturn := False
      end;
    Inc(l);
    end;
  if InMiddleOfWord then DoWord;
  if DisposePChar then StrDispose(p);
  Result := y + TextHeight - aRect.Top;
  end else Result := 0;
end;


procedure TRyPrinter.PutPageNums(const X, Y : Integer;
  Alignment : TAlignment);
var
  i : Integer;
  s : String;
  o : Integer;
begin
o := CurrentPage;
for i := 1 to PageCount do begin
  s := Format('Strona %d z %d', [i, PageCount]);
  CurrentPage := i;
  case Alignment of
    taLeftJustify : TextOut(X, Y, s);
    taRightJustify : TextOutRight(X, Y, s);
    taCenter : TextOutCenter(X, Y, s);
    end;
  end;
CurrentPage := o;
end;

procedure TRyPrinter.NewJob;
var
 i : Integer;
 p : TPoint;
begin
for i := FCanvases.Count - 1 downto 0 do begin
  TCanvas(FCanvases[i]).Free;
  end;
for i := FMetafiles.Count - 1 downto 0 do begin
  TMetafile(FMetafiles[i]).Free;
  end;
FCanvases.Clear;
FMetafiles.Clear;
FCurrentPage := 0;
FDonePrinting := False;

{Escape( Printer.Handle, GETPHYSPAGESIZE, 0, nil, @p );
    XLOff := ((p.x - printer.pagewidth) div 2);
    YTOff := ((p.y - printer.pageheight) div 2);
    XROff := p.x-XLOff;
    YBOff := p.y-YTOff;}
Escape(Printer.Handle, GETPRINTINGOFFSET, 0, nil, @p);
XLOff := p.X;
YTOff := p.Y;
XROff := Printer.PageWidth;
YBOff := Printer.PageHeight;

NewPage;
end;

procedure TRyPrinter.DonePrinting;
var
  i : integer;
begin
if not FDonePrinting then begin
  for i := 1 to PageCount do begin
    FMetafiles.Add(TMetafile.Create);
    TMetafile(FMetaFiles[i - 1]).Handle := CloseMetaFile(Canvases[i].Handle);
    end;
  FDonePrinting := True;
  end;
end;

function TRyPrinter.NewPage : Integer;
begin
if not FDonePrinting then begin
  Result := FCanvases.Add(TCanvas.Create) + 1;
  FCurrentPage := Result;
  TCanvas(FCanvases[Result - 1]).Handle := CreateMetafile(nil);

  SetMapMode(TCanvas(FCanvases[Result - 1]).Handle, MM_ANISOTROPIC);
  SetWindowExt(TCanvas(FCanvases[Result - 1]).Handle,
    Printer.PageWidth, Printer.PageHeight);
  with Canvases[Result] do begin
    Brush.style := bsClear;
    Font.Name := 'Arial';
    Font.PixelsPerInch := pYppi;
    Font.Size := 10;
    end;
  end;
end;

constructor TRyPrinter.Create;
begin
inherited Create;
FCanvases := TList.Create;
FMetafiles := TList.Create;
FCurrentPage := 0;
FDonePrinting := False;
pXppi := GetDeviceCaps(Printer.Handle, LOGPIXELSX);
pYppi := GetDeviceCaps(Printer.Handle, LOGPIXELSY);
FOrientation := poPortrait;
{Printer.Orientation:=poPortrait;}
end;

destructor TRyPrinter.Destroy;
var
 i : Integer;
begin
for i := FCanvases.Count - 1 downto 0 do begin
  TCanvas(FCanvases[i]).Free;
  end;
for i := FMetafiles.Count - 1 downto 0 do begin
  TMetafile(FMetafiles[i]).Free;
  end;
FCanvases.Free;
FMetafiles.Free;
inherited Destroy;
end;


{***************** this is for the preview form ****************}

procedure TRyPreviewFrm.SetFont( font : tFont );
begin
  screenFont.Assign( font );
end;

procedure TRyPreviewFrm.PrintBtnClick(Sender: TObject);
begin
Ry.PrintIt;
end;

procedure TRyPreviewFrm.FirstBtnClick(Sender: TObject);
begin
Ry.DisplayPage(1);
end;

procedure TRyPreviewFrm.PriorBtnClick(Sender: TObject);
begin
Ry.DisplayPage(PageDisplaying - 1);
end;

procedure TRyPreviewFrm.NextBtnClick(Sender: TObject);
begin
Ry.DisplayPage(PageDisplaying + 1);
end;

procedure TRyPreviewFrm.LastBtnClick(Sender: TObject);
begin
Ry.DisplayPage(Ry.PageCount);
end;

procedure TRyPreviewFrm.FormCreate(Sender: TObject);
begin
PageDisplaying := 1;
FullPageBtnClick(Self);
end;

procedure TRyPreviewFrm.FullPageBtnClick(Sender: TObject);
begin
  ResizePaintBox(PreviewSizeQuarter);
end;


procedure TRyPreviewFrm.ResizePaintBox(PPI:Integer);
var
  PixelsPerInchx  : longint;
  PixelsPerInchy  : longint;
  FullHeight,
  FullWidth       : longint;
  PhysSize        : TPOINT;
begin
  PixelsPerInch:=PPI;
  PaintBox1.Visible := False;
  Escape( Printer.Handle, GETPHYSPAGESIZE, 0, nil, @PhysSize );
  PixelsPerInchX := GetDeviceCaps( Printer.Handle, LOGPIXELSX );
  PixelsPerInchY := GetDeviceCaps( Printer.Handle, LOGPIXELSY );
       (*
       ** offset in pixels, convert to twips (two steps as probs with integers)
       ** We have to do it ourselves, but when printing to the printer, these
       ** are ZERO as the PRINTER object offsets it for us.
       *)
{
Escape(Printer.Handle, GETPRINTINGOFFSET, 0, nil, @p);
OffsetX := p.X;
OffsetY := p.Y;
}
      OffsetX := ((physsize.x - printer.pagewidth) div 2);
      OffsetX := (OffsetX * 1440) div pixelsperinchx;
      OffsetY := ((physsize.y - printer.pageheight) div 2);
      OffsetY := (OffsetY * 1440) div pixelsperinchy;
      fullHeight := Round((PhysSize.y  * PixelsPerInch ) / PixelsPerInchy );
      fullWidth  := Round((PhysSize.x * PixelsPerInch ) / PixelsPerInchx);
      twipMaxX := (Longint(printer.pagewidth) * 1440) div pixelsperinchx;
      twipMaxY := (Longint(printer.pageheight) * 1440) div pixelsperinchy;
           (*
           ** have to figure out how much we are scaling the
           ** screen down in relation to the actual printer
           *)
      screenScaleX := ( fullWidth / physsize.x );
      screenScaleY := ( fullHeight / physsize.y );
  twipX := pixelsperinch / 1440;
  twipY := pixelsperinch / 1440;
  maxX  := fullWidth;
  maxY  := fullHeight;
  PixelsPerInchDevice := pixelsperinch;
  PaintBox1.Width:=fullWidth;
  PaintBox1.Height:=fullHeight;
  if fullWidth < SB.Width
    then PaintBox1.Left := (SB.Width-fullWidth) div 2
    else PaintBox1.Left := 0;
  PaintBox1.Visible := True;
end;

procedure TRyPreviewFrm.PaintBox1Paint(Sender: TObject);
begin
Ry.DisplayPage(PageDisplaying);
end;


procedure TRyPreviewFrm.Button2Click(Sender: TObject);
begin
PaintBox1.Visible := False;
PaintBox1.Top := Panel1.Height + 15;
PaintBox1.Left := 15;
PaintBox1.Width := ClientWidth - 45;
PaintBox1.Height := (Longint(PaintBox1.Width) * Longint(Ry.PageSize.Y)) div
   Longint(Ry.PageSize.X);
PaintBox1.Visible := True;
end;

procedure TRyPreviewFrm.ShwGrdBtnClick(Sender: TObject);
begin
PaintBox1.Refresh;
end;

procedure TRyPreviewFrm.PrintPageBtnClick(Sender: TObject);
var
 s : String;
begin
s := '1';
if InputQuery('Drukuj stronê', 'Podaj numer strony', s) then begin
  StrToInt(s);
  Ry.PrintPage(StrToInt(s));
  end;
end;

procedure TRyPreviewFrm.PaintBox1MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
 i : Integer;
begin
{case Button of
  mbLeft : begin
    PaintBox1.Visible := False;
    PaintBox1.Top := (ClientHeight div 2) - Y;
    PaintBox1.Left := (ClientWidth div 2) - X;
    i := Trunc(PaintBox1.Width * 0.35) div 2;
    PaintBox1.Width := PaintBox1.Width + i;
    PaintBox1.Left := PaintBox1.Left - i;
    i := Trunc(PaintBox1.Height * 0.35) div 2;
    PaintBox1.Height := PaintBox1.Height + i;
    PaintBox1.Top := PaintBox1.Top - i;
    PaintBox1.Visible := True;
    end;
  mbRight : begin
    PaintBox1.Visible := False;
    i := Trunc(PaintBox1.Width * 0.35) div 2;
    PaintBox1.Width := PaintBox1.Width - i;
    PaintBox1.Left := PaintBox1.Left + i;
    i := Trunc(PaintBox1.Height * 0.35) div 2;
    PaintBox1.Height := PaintBox1.Height - i;
    PaintBox1.Top := PaintBox1.Top + i;
    PaintBox1.Top := (ClientHeight div 2) - Y;
    PaintBox1.Left := (ClientWidth div 2) - X;
    PaintBox1.Visible := True;
    end;
  end;}
end;


procedure TRyPreviewFrm.Button3Click(Sender: TObject);
var
  s : String;
begin
s := 'REPORT';
if InputQuery('Save Printout as WMF', 'Enter filename', s) then
  Ry.SaveToFile(s);
end;

function TRyPreviewFrm.ConvX(x : integer) : integer;
var
   a : double;
begin
  Result := Round(twipX * (x+OffsetX));
end;

function TRyPreviewFrm.ConvWidth(x : integer) : integer;
var
   a : double;
begin
  Result := Round(twipX * x);
end;

function TRyPreviewFrm.ConvY(y : integer) : integer;
begin
  Result := Round(twipY * (y+OffsetY));
end;

function TRyPreviewFrm.ConvHeight(y : integer) : integer;
begin
  Result := Round(twipY * y);
end;

procedure TRyPrinter.SetMinMargins(Left,Top,Right,Bottom:Integer);
var
  p:TPoint;
begin
  Escape( Printer.Handle, GETPHYSPAGESIZE, 0, nil, @p );
  if XLOff<Left
    then XLOff:=Left;
  if YTOff<Top
    then YTOff:=Top;
  if XROff>p.x - Right
    then XROff := p.x - Right;
  if YBOff>p.y - Bottom
    then YBOff := p.y - Bottom;
end;

procedure TRyPreviewFrm.ZoomOutBtnClick(Sender: TObject);
begin
{  ModalResult:=mrCancel;
  Close;}
  case PixelsPerInch of
    PreviewSizeFull: ResizePaintBox( PreviewSizeThreeQuarters );
    PreviewSizeThreeQuarters: ResizePaintBox( PreviewSizeHalf );
    PreviewSizeHalf: ResizePaintBox( PreviewSizeQuarter );
  end;{case}
end;


procedure TRyPreviewFrm.ZoomInBtnClick(Sender: TObject);
begin
{  ModalResult:=mrCancel;
  Close;}
  case PixelsPerInch of
    PreviewSizeThreeQuarters: ResizePaintBox( PreviewSizeFull );
    PreviewSizeHalf: ResizePaintBox( PreviewSizeThreeQuarters );
    PreviewSizeQuarter: ResizePaintBox( PreviewSizeHalf );
  end;{case}
end;

procedure TRyPreviewFrm.CloseBtnClick(Sender: TObject);
begin
  ModalResult:=mrCancel;
  Close;
end;

procedure TRyPrinter.WriteDemo(var NewPos:Integer);
var
  Size:Integer;
  Style:TFontStyles;
begin
  Size:=Font.Size;
  Style:=Font.Style;
  Font.Size:=20;
  Font.Style:=[fsBold];
  NewPos:=NewPos+Ymm(1);
  TextOutCenter(((XROff-XLOff) div 2)+XLOff,NewPos,'----- WERSJA DEMO -----');
  NewPos:=NewPos+TextHeight+Ymm(1);
  Font.Size:=Size;
  Font.Style:=Style;
end;

function TRyPrinter.PCharOut(const aRect: TRect; p: PChar;
     DisposePChar, DontPrint, ClipToRect: Boolean; var Clip:PChar): Integer;
     {Clip points to the part of the text not yet printed}
var
  x, y : Integer;
  l : PChar;
  t : Integer;
  i : Longint;
  InMiddleOfReturn : Boolean;
  InMiddleOfWord : Boolean;
  AtRectBottom:Boolean;
  WordBegin : PChar;

    procedure DoTab;
    var d : Integer;
    begin
      d := aRect.Left;
      repeat
        Inc(d, t);
      until d > x;
      x := d;
    end;

    procedure NextLine;
    var ypos:Integer;
    begin
      ypos:=y+TextHeight;
      if {y + TextHeight}ypos>=aRect.Top+aRect.Bottom
        then begin
          AtRectBottom:=TRUE;
          Clip:=WordBegin;
        end
        else begin
          Inc(y, TextHeight);
          x := aRect.Left;
        end;
{      Inc(y, TextHeight);
      x := aRect.Left;
      if y >=aRect.Top+aRect.Bottom
        then AtRectBottom:=TRUE;}
    end;

    function WordLength : Integer;
    var  temp : PChar;
    begin
      temp := StrAlloc(l - WordBegin + 1);
      StrLCopy(temp, l, l - WordBegin);
      Result := TextWidth(StrPas(temp));
      StrDispose(temp);
    end;

    procedure DoWord;
    var  temp : PChar;
    begin
      temp := StrAlloc(l - WordBegin + 1);
      StrLCopy(temp, WordBegin, l - WordBegin);

      if (TextWidth(StrPas(temp)) + x) > (aRect.Right) then NextLine;
      if not AtRectBottom
        then begin
          if not DontPrint then TextOut(x, y, StrPas(temp));
          Inc(x, TextWidth(StrPas(temp)));
          InMiddleOfWord := False;
        end;
      StrDispose(temp);

    end;

begin
  Clip:=Nil;
  AtRectBottom:=FALSE;
  if (FCurrentPage > 0) AND (not FDonePrinting) AND Assigned(p)
    then begin
      t := TextWidth('        ');
      l := p;
      x := aRect.Left;
      y := aRect.Top;
      InMiddleOfWord := False;
      InMiddleOfReturn := False;
      for i := 0 to StrLen(p) do
        begin
          case l^ of
            #9 : begin {it's a tab}
              if InMiddleOfWord then DoWord;
              DoTab;
              if x > (aRect.Right) then NextLine;
              InMiddleOfWord := False;
              InMiddleOfReturn := False;
              end;
            #10 : begin
              if InMiddleOfWord then DoWord;
              if not InMiddleOfReturn
                then NextLine;
              InMiddleOfWord := False;
              InMiddleOfReturn := False;
              end;
            #13 : begin
              if InMiddleOfWord
                then DoWord;
              if i<StrLen(p)-2  {don't print last CR}
                then begin
                  NextLine;
                end;
              InMiddleOfWord := False;
              InMiddleOfReturn := True;
              end;
            #32 : begin
              if InMiddleOfWord
                then DoWord;
              Inc(x, TextWidth(' '));
              if (x > (aRect.Right))
                then NextLine;
              if not AtRectBottom
                then begin
                  InMiddleOfWord := False;
                  InMiddleOfReturn := False;
                end;
              end;
            else
              if not InMiddleOfWord then WordBegin := l;
              InMiddleOfWord := True;
              InMiddleOfReturn := False
          end;{case}
          Inc(l);
          if AtRectBottom
            then Break;
        end;
      if AtRectBottom
        then begin
          if InMiddleOfReturn or (l^=#10)
            then begin
              Inc(l);
              Clip:=l;
            end
          else if InMiddleOfWord
            then begin
              Clip:=WordBegin;
              InMiddleOfWord:=FALSE;
            end
          else Clip:=l;
        end;
      if InMiddleOfWord then DoWord;
      if DisposePChar then StrDispose(p);
      Result := y + TextHeight - aRect.Top;
    end
    else Result := 0;
end;

end.


