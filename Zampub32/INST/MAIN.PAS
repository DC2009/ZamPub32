unit Main;

{$C Moveable Preload Permanent}

interface

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, StdCtrls, IniFiles, ExtCtrls, Buttons, Gauges;

const
  {Ini file for installation}
  IniFileName='INSTALUJ.INI';
  MaxDisks=10;

type
  TSetupForm = class(TForm)
    TitleLabel: TLabel;
    CopyrightLabel: TLabel;
    VersionLabel: TLabel;
    Panel1: TPanel;
    Label1: TLabel;
    FileLabel: TLabel;
    Panel2: TPanel;
    Gauge1: TGauge;
    StartBtn: TBitBtn;
    CloseBtn: TBitBtn;
    TargetPanel: TPanel;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure CloseBtnClick(Sender: TObject);
    procedure StartBtnClick(Sender: TObject);
  private
    IniFile: TIniFile;
    NumDisks: integer;
    TotalFiles: Word;
    function SetTargetPath:Boolean;
    procedure GetNumFiles;
    procedure GetSubDirs;
    function GetSourcePath(DiskNr:Byte):Boolean;
    function CheckDisk(DiskNum: word; S: TStringList): Boolean;
    function GetTarget(Code: Char): String;
    procedure StartInstall;
    procedure CreateGroup;
    procedure UpdateProgramIni;
    procedure Supervisor;
  public
    DiskArray: Array[1..MaxDisks] of TStringList;
    SubDirList:TStringList;
    PrgItemList:TStringList;
    PrgGroupName: String;
    SourceDir: String;
    InstallDir: String;
    WindowsDir: String;
    SystemDir: String;
    ProgIniName:String;
  end;

var
  SetupForm: TSetupForm;

implementation

{$R *.DFM}

uses
  LZExpand,
  FileCtrl,
  Utils,
  Target,
  PM;

const
  { Informational strings }
  SFileNotFound    = 'Plik %s nie znaleziony.';
  SNeedDisk        = 'W³ó¿ dyskietkê %d do drive %s.';
  SDirNotFound     = 'Katalog "%s" nie istnieje. Stworzyæ katalog?';
  SSetupDone       = 'Instalacja zakoñczona pomyœlnie! Wybierz "Ok" aby utworzyæ grupê';
  SSetupPartDone   = 'Instalacja zakoñczona nie pomyœlnie! Wybierz "Ok" aby utworzyæ grupê';
  SSetupInterrupt  = 'Instalacja przerwana! Wybierz "Zamknij" aby skoñczyæ';
  SInstNotFound    = 'Program instalacyjny %s nie znaleziony w katalogu "%s". Wybierz "Ok" aby powtórzyc próbê.';
  SNoTargetPath    = 'Najpierw okreœl katalog docelowy.';
  SWrongDisk       = 'Dyskietka nr. %d nie znaleziona';
  SEnterTargetPath = 'Katalog docelowy:';
  SNextInst        = 'Teraz program instaluje %s. ';
  SPressIfDone     = 'Wciœnij "Ok" po skoñczeniu instalacji %s.';
  SEnterSourcePath = 'Katalog zródlowy dla instalacji %s ';
  SEnterDiskPath   = 'Katalog zródlowy dla dyskietki nr %d ';

procedure TSetupForm.UpdateProgramIni;
var
  IniFile:TIniFile;
begin
  IniFile:=TIniFile.Create(WindowsDir+ProgIniName);
  IniFile.WriteString('General','DefaultDir',InstallDir);
  IniFile.Free;
end;

procedure TSetupForm.GetNumFiles;
{ This procedure iterates over the INI file and counts the number of files to }
{ be installed.  It then initializes the TotalFiles variable. }
var
  i: Byte;
begin
  TotalFiles := 0;
  try
    { count number of files in each Disk group }
    for i := 1 to NumDisks do begin
      DiskArray[i] := TStringList.Create;
      IniFile.ReadSectionValues('Disk' + IntToStr(i), DiskArray[i]);
      Inc(TotalFiles, DiskArray[i].Count);
    end;
  finally
  end;
end;

procedure TSetupForm.GetSubDirs;
{ This procedure gets the list of sub directories from the INI file}
begin
  try
    SubDirList := TStringList.Create;
    IniFile.ReadSectionValues('SubDirs', SubDirList);
  finally
  end;
end;

procedure TSetupForm.FormCreate(Sender: TObject);
{ The OnCreate handler }
begin
  { source path is passed as second parameter to INST.EXE }
  SourceDir := ExtractFilePath(ParamStr(0));
  FileLabel.Caption := '';
  IniFile := TIniFile.Create(SourceDir+IniFileName);
  { read values from INI file }
  with IniFile do begin
    TitleLabel.Caption := ReadString('General', 'Program', '');
    VersionLabel.Caption := ReadString('General', 'Version', '');
    CopyrightLabel.Caption := ReadString('General', 'Copyright', '');
    ProgIniName:=ReadString('General', 'ProgIni', '');
    NumDisks := ReadInteger('General', 'NumDisks', 1);
    if NumDisks>MaxDisks
      then NumDisks:=MaxDisks;
  end;
  GetNumFiles;
  GetSubDirs;
  PrgItemList:=TStringList.Create;
  Gauge1.MaxValue := TotalFiles;                { initialize gauge }
  { Find the Windows directory, and Pass "PChar-String" to API }
  GetWindowsDirectory(@WindowsDir[1], SizeOf(WindowsDir) - 1);
  WindowsDir[0] := Chr(StrLen(@WindowsDir[1])); { Set length byte of string }
  WindowsDir := AddBackSlash(WindowsDir);       { Make sure path ends in '\' }
  { Find the Windows System directory, and Pass "PChar-String" to API }
  GetSystemDirectory(@SystemDir[1], SizeOf(SystemDir) - 1);
  SystemDir[0] := Chr(StrLen(@SystemDir[1]));   { Set length byte of string }
  SystemDir := AddBackSlash(SystemDir);         { Make sure path ends in '\' }
end;

procedure TSetupForm.FormDestroy(Sender: TObject);
{ The OnDestroy handler }
var
  i:Byte;
begin
  for i:=1 to NumDisks do
    DiskArray[i].Free;
  IniFile.Free;
  PrgItemList.Free;
end;

procedure TSetupForm.CloseBtnClick(Sender: TObject);
begin
  Release;
end;

procedure TSetupForm.StartBtnClick(Sender: TObject);
{ This procedure invokes the install in response to the button press }
begin
  if SetTargetPath
    then begin
      if InstallDir <> ''
        then begin
          StartBtn.Enabled := False;
          StartInstall;
        end
        else MessageDlg(SNoTargetPath, mtError, [mbOk], 0);
    end;
end;

function TSetupForm.CheckDisk(DiskNum: word; S: TStringList): Boolean;
{ Returns False if Cancel button is pushed, True if correct disk found. }
var
  FName: String[13];
  FileToFind:String;
begin
  Result := True;
  { get first filename from string list }
  FName :=Copy(S.Strings[0], 1, Pos('=', S.Strings[0]) - 1);
  { keep iterating until file exists or cancel is pressed }
  FileToFind:=AddBackSlash(SourceDir) + Copy(FName,1,Length(FName)-1)+'_';
  while not FileExists(FileToFind) do
    if MessageDlg(Format(SFileNotFound, [FileToFind])+#13#10+
                  Format(SNeedDisk, [DiskNum, SourceDir[1]]),
                  mtWarning, mbOkCancel, 0) = mrCancel
      then begin
        Result := False;
        Break;
      end;
end;

function TSetupForm.GetTarget(Code: Char): String;
{ This procedure returns the target directory based on the INI file setting }
var
  i:LongInt;
begin
  case code of
    'i' : Result := InstallDir;
    'w' : Result := WindowsDir;
    's' : Result := SystemDir;
    else begin
      i:=0;
      while (SubdirList[i][Length(SubDirList[i])]<>Code) and (i<SubDirList.Count) do
        Inc(i);
      if i<SubDirList.Count
        then Result := AddBackSlash(InstallDir) +
                       Copy(SubDirList[i],1,Length(SubDirList[i])-2);
    end;
  end;{case}
end;

function TSetupForm.GetSourcePath(DiskNr:Byte):Boolean;
begin
 { make sure current disk is the install disk, and keep iterating until }
 { correct disk/path or cancel is pressed }
  DirectoryForm.ActiveControl:=DirectoryForm.DirEdit;
  while not FileExists(AddBackSlash(SourceDir) + 'Disk' + IntToStr(DiskNr) + '_') do
    begin
      MessageDlg(Format(SWrongDisk, [DiskNr]), mtError, [mbOk], 0);
      if DirectoryForm.ShowForm(Format(SEnterDiskPath, [DiskNr]), SourceDir) <> mrOk
        then break;
      SourceDir:=DirectoryForm.DirEdit.Text;
    end;
  Result:=DirectoryForm.ModalResult=mrOk;
end;

procedure TSetupForm.StartInstall;
{ This is the meat of the installation.  It copies files from source to }
{ destination. }
var
  i, Disk, Curr: word;
  FName: String[13];
  PName:PChar;
  Interrupted:Boolean;
  File1,
  File2:Integer;
  TOFS:TOFStruct;
  LZResult:LongInt;
  CopyError:Word;
begin
  Interrupted:=FALSE;
  Gauge1.Progress := 0;                  { reset gauge }
  PrgGroupName := IniFile.ReadString('General', 'PMGroup', '');
  IniFile.ReadSectionValues('PMGroup', PrgItemList);
  CopyError:=0;
  try
    for Disk := 1 to NumDisks do begin   { iterate for each disk }
      if not CheckDisk(Disk, DiskArray[Disk]) {if first disk is right don't ask source path}
         and (Disk=1)
        then Interrupted:=not GetSourcePath(Disk);
      if Disk>1
        then Interrupted:=not GetSourcePath(Disk);
      if Interrupted
        then break;
      if CheckDisk(Disk, DiskArray[Disk]) then         { make sure we're on the right disk }
        for Curr := 0 to DiskArray[Disk].Count - 1 do begin  {iterate for each file }
          { get filename from stringlist }
          FName := Copy(DiskArray[Disk].Strings[Curr], 1, Pos('=', DiskArray[Disk].Strings[Curr]) - 1);
          FileLabel.Caption := FName;
          GetMem(PName,256);
          PName:='';
          StrPCopy(PName,AddBackSlash(SourceDir)+Copy(FName,1,Length(FName)-1)+'_');
          { copy file from source to target directory given by code }
          Application.ProcessMessages;   { allow controls to update }
          File1:=LZOpenFile(PName, TOFS, OF_READWRITE);
          if File1>=0
            then begin
              PName:='';
              StrPCopy(PName,AddBackSlash(GetTarget(DiskArray[Disk].Values[FName][1]))+FName);
              File2:=LZOpenFile(PName, TOFS, OF_CREATE);
              if File2>=0
                then begin
                   LZResult:=LZCopy(File1,File2);
                  _LCLOSE(File2);
                end
                else MessageDlg('Zbiór '+FName+' nie otwarty',mtError,[mbOk],0);
              _LCLOSE(File1);
            end
            else begin
              MessageDlg('Zbiór '+FName+' nie znaleziony', mtError,[mbOk],0);
              Inc(CopyError);
            end;
          Gauge1.Progress := Gauge1.Progress + 1;
          Application.ProcessMessages;   { allow controls to update }
        end
        else Interrupted:=TRUE;
    end;
  finally
  end;
  if Interrupted
    then MessageDlg(SSetupInterrupt, mtInformation, [mbOk], 0)
    else begin
      if CopyError=0
        then MessageDlg(SSetupDone, mtInformation, [mbOk], 0)
        else MessageDlg(SSetupPartDone, mtInformation, [mbOk], 0);
      StartBtn.Enabled := FALSE;
      UpdateProgramIni;
      Supervisor;
      CreateGroup;                           { create ProgMan group }
{     StartBtn.Enabled := True;}
    end;
end;

procedure TSetupForm.CreateGroup;
{ Uses the TProgMan component to install Program Manager group }
var
  ItemName: String;
  ItemDescr:String;
  i,j: word;
begin
  { Get the GroupName string from the INI file }
  { If there is one, then install group }
  if PrgGroupName <> '' then begin
    try
      { read items to be installed }
      if PrgItemList.Count>0
        then with TProgMan.Create(Self) do
          try
            CreateGroup(PrgGroupName);
            for i := 0 to PrgItemList.Count - 1 do begin
              { get file name }
              ItemName := Copy(PrgItemList.Strings[i], 1, Pos('=',
                               PrgItemList.Strings[i]) - 1);
              j:=Pos(',',PrgItemList.Strings[i]);
              if j>0
                then ItemDescr := Copy(PrgItemList.Strings[i],j+1,255)
                else ItemDescr := ItemName;
              { append file name to path and add the item }
              AddItem(GetTarget(PrgItemList.Values[ItemName][1]) + ItemName, ItemDescr);
            end;
          finally
            Free;
{            Destroy;}
          end;
    finally
    end;
  end;
end;

function TSetupForm.SetTargetPath:Boolean;
var
  S: TStringList;
  i: word;
  b:Boolean;
begin
  { get directory from dialog }
  B:=TRUE;
  if DirectoryForm.ShowForm(SEnterTargetPath,
                   IniFile.ReadString('General', 'DefaultDir', '')) = mrOk
    then begin
      { if it's not there, prompt for permission to create the directory }
      if not DirectoryExists(DirectoryForm.DirEdit.Text)
        then begin
          if MessageDlg(Format(SDirNotFound, [DirectoryForm.DirEdit.Text]),
                        mtConfirmation, [mbYes, mbNo], 0) = mrYes
            then begin
              { make the directory }
              ForceDirectories(StripBackSlash(DirectoryForm.DirEdit.Text));
              { update InstallDir variable }
              InstallDir := AddBackSlash(DirectoryForm.DirEdit.Text);
              { update panel }
              TargetPanel.Caption := 'Cel: ' + AddBackSlash(DirectoryForm.DirEdit.Text);
            end
            else B:=FALSE;
        end
        else begin
          { if directory exists, then update InstallDir and panel }
          InstallDir := AddBackSlash(DirectoryForm.DirEdit.Text);
          TargetPanel.Caption := 'Cel: ' + AddBackSlash(DirectoryForm.DirEdit.Text);
        end;
        { Create subdirectories }
      if B
        then try
          if SubDirList.Count>0
            then for i := 0 to SubDirList.Count - 1 do
              if not DirectoryExists(InstallDir + Copy(SubDirList[i],1,Length(SubDirList[i])-2)) then
                ForceDirectories(InstallDir +  Copy(SubDirList[i],1,Length(SubDirList[i])-2));
        finally
        end;
    end
    else begin
      MessageDlg(SSetupInterrupt,mtWarning,[mbOk],0);
      B:=FALSE;
    end;
  Result:=B;
end;

procedure TSetupForm.Supervisor;
begin
end;

end.
