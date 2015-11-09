unit Pm;

interface

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, DdeMan;

type
  EProgManError = class(Exception);

  TProgMan = class(TComponent)
  private
    FDdeClientConv: TDdeClientConv;
    procedure InitDDEConversation;
    function ExecMacroString(Macro: String): Boolean;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure CreateGroup(GroupName: String);
    procedure DeleteGroup(GroupName: String);
    procedure DeleteItem(ItemName: String);
    procedure AddItem(CmdLine, ItemName: String);
  end;

implementation

uses Utils;

const
  { Program Manager DDE macro strings }
  SDDECreateGroup     = '[CreateGroup(%s)]';
  SDDEShowGroup       = '[ShowGroup(%s, 1)]';
  SDDEDeleteGroup     = '[DeleteGroup(%s)]';
  SDDEDeleteItem      = '[DeleteItem(%s)]';
  SDDEAddItem {: PChar} = '[AddItem(%s, "%s", %s)]';  { likely to be > 255 chars }
  SDDEExitProgman     = '[ExitProgman(TRUE)]';

constructor TProgMan.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  InitDDEConversation;          { establish DDE link with ProgMan }
end;

destructor TProgMan.Destroy;
begin
  ExecMacroString(SDDEExitProgMan);
  if Assigned(FDdeClientConv) then
    FDdeClientConv.CloseLink;     { terminate DDE link to ProgMan }
  inherited Destroy;              { inherited clean up }
end;

function TProgMan.ExecMacroString(Macro: String): Boolean;
begin
  Result := FDdeClientConv.ExecuteMacro(StringAsPChar(Macro), False);
end;

procedure TProgMan.InitDDEConversation;
{ Establishes a DDE link with Program Manager }
begin
  { create DDE component }
  FDdeClientConv := TDdeClientConv.Create(Self);
  { attempt to establish DDE link with ProgMan }
  if not FDdeClientConv.SetLink('PROGMAN', 'PROGMAN') then
    raise EProgManError.Create('Failed to establish DDE Link');
end;

procedure TProgMan.CreateGroup(GroupName: String);
{ Creates a Program Manager group with name given by GroupName }
begin
  { attempt to create group }
  if not ExecMacroString(Format(SDDECreateGroup, [GroupName])) then
    raise EProgManError.Create('Could not create group. Group name: ' +
                                 GroupName);
  { attempt to show group }
  if not ExecMacroString(Format(SDDEShowGroup, [GroupName])) then
    raise EProgManError.Create('Could not show group. Group name: ' +
                                GroupName);
end;

procedure TProgMan.DeleteGroup(GroupName: String);
begin
  if not ExecMacroString(Format(SDDEDeleteGroup, [GroupName])) then
    raise EProgManError.Create('Could not delete group. Group name: ' +
                                GroupName);
end;

procedure TProgMan.DeleteItem(ItemName: String);
begin
  if not ExecMacroString(Format(SDDEDeleteItem, [ItemName])) then
    raise EProgManError.Create('Could not delete item. Item name: ' +
                                ItemName);
end;

procedure TProgMan.AddItem(CmdLine, ItemName: String);
{ Adds an item to the active Program Manager group.  CmdLine is the path name }
{ of the item, and ItemName is the name as it will appear in Program Manager. }
var
  P: PChar;
  A:PChar;
  PSize: Word;
  s:String;
begin
  { determine amount of memory needed for AddItem DDE string }
  PSize := {StrLen}1+Length(SDDEAddItem) + (Length(CmdLine) * 2) + Length(ItemName) + 1;
  GetMem(P, PSize);               { allocate memory }
  s:=SDDEAddItem;
  A:=StringAsPChar(s);
  try
    { format AddItem DDE macro string }
    StrFmt(P, {SDDEAddItem}A, [CmdLine, ItemName, CmdLine]);
    { attempt to add item to group }
    if not FDdeClientConv.ExecuteMacro(P, False) then
      raise EProgManError.Create('Could not add item. Item: ' + ItemName);
  finally
    FreeMem(P, PSize);              { clean up }
  end;
end;

end.
