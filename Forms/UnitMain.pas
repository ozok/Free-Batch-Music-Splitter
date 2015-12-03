unit UnitMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,
  Vcl.ComCtrls, UnitFileInfoExtractor, UnitFileListItem, UnitEncoder, Vcl.Mask,
  JvExMask, JvToolEdit, Vcl.ExtCtrls, JvSpin, Vcl.Menus, ShellAPI, JvExControls,
  JvArrowButton, JvComponentBase, JvSearchFiles, JvBaseDlg, JvBrowseFolder, StrUtils,
  System.Win.TaskbarCore, Vcl.Taskbar, JvComputerInfoEx, IniFiles, JvDragDrop, IdBaseComponent,
  IdThreadComponent, IdComponent, IdTCPConnection, IdTCPClient, IdHTTP, JvUrlListGrabber,
  JvUrlGrabbers, acProgressBar, sLabel, sDialogs, sComboBox, sStatusBar,
  sCheckBox, sPageControl, sBevel, sButton, sListView, sPanel, sSkinManager,
  sSkinProvider, sMaskEdit, sCustomComboEdit, sToolEdit, sEdit, sSpinEdit,
  Vcl.Buttons, sBitBtn, sGauge, DateUtils;

type
  TMainForm = class(TForm)
    FileList: TsListView;
    OpenDialog: TsOpenDialog;
    StartBtn: TsBitBtn;
    NormalPanel: TsPanel;
    ProgressPanel: TsPanel;
    ProgressList: TsListView;
    ProgressTimer: TTimer;
    Label1: TsLabel;
    RemoveSelectedBtn: TsBitBtn;
    ClearBtn: TsBitBtn;
    SplitTypePages: TsPageControl;
    TabSheet1: TsTabSheet;
    TabSheet2: TsTabSheet;
    ApplyToFileBtn: TsButton;
    MainMenu1: TMainMenu;
    F1: TMenuItem;
    E1: TMenuItem;
    S1: TMenuItem;
    OpenOutputBtn: TsButton;
    AddFileMenu: TPopupMenu;
    A1: TMenuItem;
    A2: TMenuItem;
    A3: TMenuItem;
    A4: TMenuItem;
    A5: TMenuItem;
    A6: TMenuItem;
    A7: TMenuItem;
    A8: TMenuItem;
    C1: TMenuItem;
    FileSearch: TJvSearchFiles;
    OpenFolderDlg: TJvBrowseForFolderDialog;
    StatusBar1: TsStatusBar;
    DefaultPartBtn: TsCheckBox;
    DefaultTimeBtn: TsCheckBox;
    Bevel1: TsBevel;
    NumberOfProcessList: TsComboBox;
    CheckUpdatesBtn: TsCheckBox;
    ApplyToAllBtn: TsButton;
    LogsBtn: TsBitBtn;
    OutputFolderOptionsList: TsComboBox;
    Taskbar: TTaskbar;
    Info: TJvComputerInfoEx;
    DragDrop1: TJvDragDrop;
    DonateBtn: TsBitBtn;
    UpdateCheckThread: TIdThreadComponent;
    UpdateDownloader: TJvHttpUrlGrabber;
    OutputFolderEdit: TsDirectoryEdit;
    PartCountEdit: TsSpinEdit;
    MinutesEdit: TsSpinEdit;
    SecondsEdit: TsSpinEdit;
    MiliSecondsEdit: TsSpinEdit;
    AddBtn: TsBitBtn;
    ToolBar: TsPanel;
    RightPanel: TsPanel;
    BottomPanel: TsPanel;
    sPanel1: TsPanel;
    sBitBtn3: TsBitBtn;
    sBitBtn6: TsBitBtn;
    Button2: TsButton;
    StopBtn: TsBitBtn;
    sPanel2: TsPanel;
    ProgressLabel: TsLabel;
    TotalProgressBar: TsGauge;
    NamingOptionList: TsComboBox;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure StartBtnClick(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure ProgressTimerTimer(Sender: TObject);
    procedure FileListClick(Sender: TObject);
    procedure ApplyToFileBtnClick(Sender: TObject);
    procedure S1Click(Sender: TObject);
    procedure ClearBtnClick(Sender: TObject);
    procedure OpenOutputBtnClick(Sender: TObject);
    procedure A1Click(Sender: TObject);
    procedure RemoveSelectedBtnClick(Sender: TObject);
    procedure A3Click(Sender: TObject);
    procedure FileSearchProgress(Sender: TObject);
    procedure FileSearchFindFile(Sender: TObject; const AName: string);
    procedure A2Click(Sender: TObject);
    procedure DefaultPartBtnClick(Sender: TObject);
    procedure DefaultTimeBtnClick(Sender: TObject);
    procedure ApplyToAllBtnClick(Sender: TObject);
    procedure StopBtnClick(Sender: TObject);
    procedure LogsBtnClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure DragDrop1Drop(Sender: TObject; Pos: TPoint; Value: TStrings);
    procedure A8Click(Sender: TObject);
    procedure DonateBtnClick(Sender: TObject);
    procedure C1Click(Sender: TObject);
    procedure UpdateCheckThreadRun(Sender: TIdThreadComponent);
    procedure UpdateDownloaderDoneStream(Sender: TObject; Stream: TStream; StreamSize: Integer; Url: string);
    procedure AddBtnClick(Sender: TObject);
  private
    { Private declarations }
    FFileInfo: TFileInfoExtractor;
    FFiles: TFileListItems;
    FProcesses: array [0 .. 15] of TMyProcess;
    FFmpegPath: string;
    FCMDCount: integer;
    FLastDirectory: string;
    FStartDateTime: TDateTime;

    procedure AddFile(const FileName: string);

    function SplitTimesToStr(const Min: integer; const Sec: integer; const MSec: integer): string;
    function SplitTimesToInt(const Min: integer; const Sec: integer; const MSec: integer): string;
    function SplitTimesToInt2(const Min: integer; const Sec: integer; const MSec: integer): Integer;

    procedure DisableUI;
    procedure EnableUI;

    procedure LoadSettings;
    procedure SaveSettings;

    function CreateFolder(const SourceFilePath: string): string;
    function DecodeTime(const Time: integer): string;
  public
    { Public declarations }
    StopAddingFiles: Boolean;
    AppDataFolder: string;
    DefaultOutputFolder: string;

    procedure AddToLog(const Msg: string);
  end;

var
  MainForm: TMainForm;

const
  VERSION_FILE_URL = 'http://downloads.sourceforge.net/project/free-batch-music-splitter/version.txt?r=&ts=1442779171&use_mirror=netcologne';
  PROGRAM_VERSION = 3;
  PORTABLE = False;

implementation

{$R *.dfm}

uses UnitBusy, UnitLogs, UnitAbout;

procedure TMainForm.A1Click(Sender: TObject);
var
  I: Integer;
begin
  if DirectoryExists(FLastDirectory) then
  begin
    OpenDialog.InitialDir := FLastDirectory;
  end;

  if OpenDialog.Execute then
  begin
    StopAddingFiles := False;
    Self.Enabled := False;
    BusyForm.Show;
    StopAddingFiles := False;
    FileList.Items.BeginUpdate;
    Taskbar.ProgressState := TTaskBarProgressState.Indeterminate;
    BusyForm.ProgressLabel.Caption := 'Adding files...';
    try
      for I := 0 to OpenDialog.Files.Count - 1 do
      begin
        Application.ProcessMessages;

        if not StopAddingFiles then
        begin
          AddFile(OpenDialog.Files[i]);
        end
        else
        begin
          Break;
        end;
      end;
    finally
      Self.Enabled := True;
      BusyForm.Close;
      Self.BringToFront;
      FileList.Items.EndUpdate;
      StatusBar1.Panels[1].Text := Format('%d files', [FileList.Items.Count]);
      Taskbar.ProgressState := TTaskBarProgressState.None;
    end;
  end;
end;

procedure TMainForm.A2Click(Sender: TObject);
var
  LSR: TSearchRec;
  LFileExt: string;
  LFileName: string;
begin
  if DirectoryExists(FLastDirectory) then
  begin
    OpenFolderDlg.Directory := FLastDirectory;
  end;

  if OpenFolderDlg.Execute then
  begin
    Self.Enabled := False;
    BusyForm.Show;
    StopAddingFiles := False;
    BusyForm.ProgressLabel.Caption := 'Adding files...';
    Taskbar.ProgressState := TTaskBarProgressState.Indeterminate;
    FileList.Items.BeginUpdate;
    try
      if (FindFirst(OpenFolderDlg.Directory + '\*.*', faAnyFile, LSR) = 0) then
      begin
        repeat
          Application.ProcessMessages;

          LFileName := ExcludeTrailingBackslash(OpenFolderDlg.Directory) + '\' + LSR.Name;
          LFileExt := ExtractFileExt(LFileName).ToLower;

          if (LFileExt = '.mp3') or (LFileExt = '.aac') or (LFileExt = '.ogg') or (LFileExt = '.opus') or (LFileExt = '.flac') or (LFileExt = '.alac') or (LFileExt = '.wv') or (LFileExt = '.wav') or
            (LFileExt = '.m4b') or (LFileExt = '.m4a') then
          begin
            AddFile(LFileName);
          end;
        until (FindNext(LSR) <> 0) and (not StopAddingFiles);
      end;
    finally
      Self.Enabled := True;
      BusyForm.Close;
      Self.BringToFront;
      FileList.Items.EndUpdate;
      StatusBar1.Panels[1].Text := Format('%d files', [FileList.Items.Count]);
      Taskbar.ProgressState := TTaskBarProgressState.None;
    end;

  end;
end;

procedure TMainForm.A3Click(Sender: TObject);
begin
  if DirectoryExists(FLastDirectory) then
  begin
    OpenFolderDlg.Directory := FLastDirectory;
  end;

  if OpenFolderDlg.Execute then
  begin
    Self.Enabled := False;
    BusyForm.Show;
    BusyForm.ProgressLabel.Caption := 'Adding files...';
    Taskbar.ProgressState := TTaskBarProgressState.Indeterminate;
    FileList.Items.BeginUpdate;
    try
      FileSearch.RootDirectory := OpenFolderDlg.Directory;
      FileSearch.Search;
    finally
      Self.Enabled := True;
      BusyForm.Close;
      Self.BringToFront;
      FileList.Items.EndUpdate;
      StatusBar1.Panels[1].Text := Format('%d files', [FileList.Items.Count]);
      Taskbar.ProgressState := TTaskBarProgressState.None;
    end;
  end;
end;

procedure TMainForm.A8Click(Sender: TObject);
begin
  Self.Enabled := False;
  AboutForm.Show;
end;

procedure TMainForm.AddBtnClick(Sender: TObject);
var
  P: TPoint;
begin
  P := AddBtn.ClientToScreen(Point(0, 0));

  AddFileMenu.Popup(P.X, P.Y + AddBtn.Height)
end;

procedure TMainForm.AddFile(const FileName: string);
var
  LItem: TListItem;
  LFileItem: TFileListItem;
begin
  if not StopAddingFiles then
  begin
    FFileInfo.Start(FileName);
    while FFileInfo.IsBusy and (not StopAddingFiles) do
    begin
      Application.ProcessMessages;
      Sleep(50);
    end;

    if (FFileInfo.DurationStr.Length > 0) and (not StopAddingFiles) then
    begin
      LFileItem := TFileListItem.Create;
      LFileItem.FullFilePath := FileName;
      if DefaultPartBtn.Checked then
      begin
        LFileItem.SplitType := stIntoParts;
        LFileItem.PartsCount := Round(PartCountEdit.Value);
        LFileItem.SplitMinute := Round(MinutesEdit.Value);
        LFileItem.SplitSecond := Round(SecondsEdit.Value);
        LFileItem.SplitMiliSeconds := Round(MiliSecondsEdit.Value);
      end
      else
      begin
        LFileItem.SplitType := stAccordingToDuration;
        LFileItem.PartsCount := Round(PartCountEdit.Value);
        LFileItem.SplitMinute := Round(MinutesEdit.Value);
        LFileItem.SplitSecond := Round(SecondsEdit.Value);
        LFileItem.SplitMiliSeconds := Round(MiliSecondsEdit.Value);
      end;
      LFileItem.DurationLength := 0;
      LFileItem.DurationAsString := FFileInfo.DurationStr;
      LFileItem.DurationAsInt := FFileInfo.DurationStr.ToInteger();
      FFiles.Add(LFileItem);

      LItem := FileList.Items.Add;
      LItem.Caption := FileName;
      LItem.SubItems.Add(DecodeTime(FFileInfo.DurationStr.ToInteger()));
      if DefaultPartBtn.Checked then
      begin
        LItem.SubItems.Add(Format('%d equal parts', [LFileItem.PartsCount]));
      end
      else
      begin
        LItem.SubItems.Add('Parts with ' + SplitTimesToStr(Round(MinutesEdit.Value), Round(SecondsEdit.Value), Round(MiliSecondsEdit.Value)) + ' length');
      end;

      FLastDirectory := ExtractFileDir(FileName);
    end;
  end;
end;

procedure TMainForm.AddToLog(const Msg: string);
begin
  if Msg.Length > 0 then
  begin
    LogsForm.Logs[0].Add('[' + DateTimeToStr(Now) + '] ' + Msg);
  end
  else
  begin
    LogsForm.Logs[0].Add('');
  end;
end;

procedure TMainForm.ApplyToAllBtnClick(Sender: TObject);
var
  I: Integer;
begin
  for I := 0 to FileList.Items.Count - 1 do
  begin
    Application.ProcessMessages;
    case SplitTypePages.ActivePageIndex of
      0:
        begin
          with FFiles[i] do
          begin
            SplitType := stIntoParts;
            PartsCount := Round(PartCountEdit.Value);
            SplitMinute := 1;
            SplitSecond := 0;
            SplitMiliSeconds := 0;
            FileList.Items[i].SubItems[1] := FloatToStr(PartsCount) + ' equal parts';
          end;
        end;
      1:
        begin
          with FFiles[i] do
          begin
            SplitType := stAccordingToDuration;
            PartsCount := 2;
            SplitMinute := Round(MinutesEdit.Value);
            SplitSecond := Round(SecondsEdit.Value);
            SplitMiliSeconds := Round(MiliSecondsEdit.Value);
            FileList.Items[i].SubItems[1] := 'Parts with ' + SplitTimesToStr(SplitMinute, SplitSecond, SplitMiliSeconds) + ' length';
          end;
        end;
    end;
  end;
end;

procedure TMainForm.ApplyToFileBtnClick(Sender: TObject);
var
  I: Integer;
begin
  for I := 0 to FileList.Items.Count - 1 do
  begin
    Application.ProcessMessages;
    if FileList.Items[i].Selected then
    begin
      case SplitTypePages.ActivePageIndex of
        0:
          begin
            with FFiles[i] do
            begin
              SplitType := stIntoParts;
              PartsCount := Round(PartCountEdit.Value);
              SplitMinute := 1;
              SplitSecond := 0;
              SplitMiliSeconds := 0;
              FileList.Items[i].SubItems[1] := FloatToStr(PartsCount) + ' equal parts';
            end;
          end;
        1:
          begin
            with FFiles[i] do
            begin
              SplitType := stAccordingToDuration;
              PartsCount := 2;
              SplitMinute := Round(MinutesEdit.Value);
              SplitSecond := Round(SecondsEdit.Value);
              SplitMiliSeconds := Round(MiliSecondsEdit.Value);
              FileList.Items[i].SubItems[1] := 'Parts with ' + SplitTimesToStr(SplitMinute, SplitSecond, SplitMiliSeconds) + ' length';
            end;
          end;
      end;
    end;
  end;
end;

procedure TMainForm.C1Click(Sender: TObject);
begin
  ShellExecute(0, 'open', PWideChar(ExtractFileDir(Application.ExeName) + '\changelog.txt'), nil, nil, SW_SHOWNORMAL);
end;

procedure TMainForm.ClearBtnClick(Sender: TObject);
begin
  if FileList.Items.Count < 1 then
    Exit;

  if ID_YES = Application.MessageBox('Clear file list?', 'Question', MB_YESNO) then
  begin
    FileList.Items.Clear;
    FFiles.Clear;
  end;
  StatusBar1.Panels[1].Text := Format('%d files', [FileList.Items.Count]);
end;

function TMainForm.CreateFolder(const SourceFilePath: string): string;
var
  LTmpStr: string;
  LFolderPath: string;
  C: Char;
begin
  case OutputFolderOptionsList.ItemIndex of
    0:
      LFolderPath := '';
    1:
      begin
        // one parent
        LTmpStr := ReverseString(ExcludeTrailingPathDelimiter(ExtractFileDir(SourceFilePath)));
        for C in LTmpStr do
        begin
          if C <> '\' then
          begin
            LFolderPath := LFolderPath + C;
          end
          else
          begin
            Break;
          end;
        end;
        LFolderPath := ReverseString(LFolderPath);
      end;
    2:
      begin
        // all folder structure
        if Copy(SourceFilePath, 1, 1) = '\' then
        begin
          LTmpStr := ExcludeTrailingPathDelimiter(ExtractFileDir(SourceFilePath));
          LFolderPath := (LTmpStr);
        end
        else
        begin
          // delete driver char
          LTmpStr := ExcludeTrailingPathDelimiter(ExtractFileDir(SourceFilePath));
          Delete(LTmpStr, 1, 3);
          LFolderPath := (LTmpStr);
        end;
      end;
  end;
  Result := IncludeTrailingBackslash(LFolderPath);
end;

function TMainForm.DecodeTime(const Time: integer): string;
var
  LHourInt: Integer;
  LSecondInt: Integer;
  LMinInt: Integer;
  LHourStr: string;
  LMinStr: string;
  LSecondStr: String;
  LTime: integer;
  LMiliSecInt: integer;
  LMiliSecStr: string;
begin
  if (Time > 0) then
  begin
    LTime := Time div 1000;
    LMiliSecInt := Time mod 1000;
    LHourInt := LTime div 3600;
    LMinInt := (LTime div 60) - (LHourInt * 60);
    LSecondInt := (LTime mod 60);

    if LMiliSecInt < 10 then
    begin
      LMiliSecStr := '00' + FloatToStr(LMiliSecInt)
    end
    else if LMiliSecInt < 100 then
    begin
      LMiliSecStr := '0' + FloatToStr(LMiliSecInt)
    end
    else
    begin
      LMiliSecStr := FloatToStr(LMiliSecInt)
    end;

    if (LSecondInt < 10) then
    begin
      LSecondStr := '0' + FloatToStr(LSecondInt);
    end
    else
    begin
      LSecondStr := FloatToStr(LSecondInt);
    end;

    if (LMinInt < 10) then
    begin
      LMinStr := '0' + FloatToStr(LMinInt);
    end
    else
    begin
      LMinStr := FloatToStr(LMinInt);
    end;

    if (LHourInt < 10) then
    begin
      LHourStr := '0' + FloatToStr(LHourInt);
    end
    else
    begin
      LHourStr := FloatToStr(LHourInt);
    end;

    Result := LHourStr + ':' + LMinStr + ':' + LSecondStr + '.' + LMiliSecStr;
  end
  else
  begin
    Result := '00:00:00.000';
  end;
end;

procedure TMainForm.DefaultPartBtnClick(Sender: TObject);
begin
  DefaultTimeBtn.Checked := not DefaultPartBtn.Checked;
end;

procedure TMainForm.DefaultTimeBtnClick(Sender: TObject);
begin
  DefaultPartBtn.Checked := not DefaultTimeBtn.Checked;
end;

procedure TMainForm.DisableUI;
var
  I: Integer;
begin
  ProgressList.Items.Clear;
  ProgressPanel.Visible := True;
  ProgressPanel.BringToFront;
  for I := 0 to MainMenu1.Items.Count - 1 do
  begin
    MainMenu1.Items[i].Enabled := False;
  end;
end;

procedure TMainForm.DonateBtnClick(Sender: TObject);
begin
  ShellExecute(0, 'open', 'https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=WRHMQXUPKWVTU', nil, nil, SW_SHOWNORMAL);
end;

procedure TMainForm.DragDrop1Drop(Sender: TObject; Pos: TPoint; Value: TStrings);
var
  i: Integer;
  LFileExt: string;
  LDirectoriesToSearch: TStringList;
begin

  Self.Enabled := False;
  BusyForm.Show;
  StopAddingFiles := False;
  BusyForm.ProgressLabel.Caption := 'Adding files...';
  LDirectoriesToSearch := TStringList.Create;
  Taskbar.ProgressState := TTaskBarProgressState.Indeterminate;
  FileList.Items.BeginUpdate;
  try
    for i := 0 to Value.Count - 1 do
    begin
      Application.ProcessMessages;

      LFileExt := LowerCase(ExtractFileExt(Value[i]));
      if StopAddingFiles then
      begin
        Break;
      end
      else
      begin
        // decide if file or directory
        if DirectoryExists(Value[i]) then
        begin
          LDirectoriesToSearch.Add(Value[i]);
        end
        else
        begin
          if (LFileExt = '.mp3') or (LFileExt = '.aac') or (LFileExt = '.ogg') or (LFileExt = '.opus') or (LFileExt = '.flac') or (LFileExt = '.alac') or (LFileExt = '.wv') or (LFileExt = '.wav') or
            (LFileExt = '.m4b') or (LFileExt = '.m4a') then
          begin
            AddFile(Value[i]);
          end;
        end;
      end;
    end;

    FileList.Items.BeginUpdate;
    try
      // add directory content
      if LDirectoriesToSearch.Count > 0 then
      begin
        for I := 0 to LDirectoriesToSearch.Count - 1 do
        begin
          Application.ProcessMessages;

          FileSearch.RootDirectory := LDirectoriesToSearch[i];
          FileSearch.Search;

          FLastDirectory := LDirectoriesToSearch[i];
        end;
      end;
    finally
      FileList.Items.EndUpdate;
    end;

  finally
    Self.Enabled := True;
    BusyForm.Close;
    Self.BringToFront;
    FreeAndNil(LDirectoriesToSearch);
    StatusBar1.Panels[1].Text := Format('%d files', [FileList.Items.Count]);
    FileList.Items.EndUpdate;
    Taskbar.ProgressState := TTaskBarProgressState.None;
  end;
end;

procedure TMainForm.EnableUI;
var
  I: Integer;
begin
  ProgressList.Items.Clear;
  ProgressPanel.Visible := False;
  ProgressPanel.SendToBack;
  for I := 0 to MainMenu1.Items.Count - 1 do
  begin
    MainMenu1.Items[i].Enabled := True;
  end;
  Self.Caption := 'Free Batch Music Splitter';
  Taskbar.ProgressValue := 0;
  Taskbar.ProgressState := TTaskBarProgressState.None;

end;

procedure TMainForm.S1Click(Sender: TObject);
var
  I: Integer;
begin
  if not FileList.Focused then
    Exit;

  for I := 0 to FileList.Items.Count - 1 do
  begin
    FileList.Items[i].Selected := True;
  end;
end;

procedure TMainForm.SaveSettings;
var
  LSettingsFile: TIniFile;
begin
  LSettingsFile := TIniFile.Create(AppDataFolder + '\settings.ini');
  try
    with LSettingsFile do
    begin
      WriteString('general', 'outputfolder', OutputFolderEdit.Text);
      WriteInteger('general', 'activemethod', SplitTypePages.ActivePageIndex);
      WriteString('general', 'partcount', PartCountEdit.Text);
      WriteString('general', 'min', MinutesEdit.Text);
      WriteString('general', 'sec', SecondsEdit.Text);
      WriteString('general', 'milisec', MiliSecondsEdit.Text);
      WriteBool('general', 'defmethod', DefaultPartBtn.Checked);
      WriteInteger('general', 'numofprocess', NumberOfProcessList.ItemIndex);
      WriteBool('general', 'update', CheckUpdatesBtn.Checked);
      WriteInteger('general', 'foldermethod', OutputFolderOptionsList.ItemIndex);
      WriteString('general', 'lastdir', FLastDirectory);
    end;
  finally
    LSettingsFile.Free;
  end;
end;

function TMainForm.SplitTimesToInt(const Min, Sec, MSec: integer): string;
var
  LSec: integer;
  LMSecStr: string;
begin
  LSec := (Min * 60 + Sec) * 1000;

  if MSec < 10 then
  begin
    LMSecStr := '00' + MSec.ToString();
  end
  else if MSec < 100 then
  begin
    LMSecStr := '0' + MSec.ToString();
  end
  else
  begin
    LMSecStr := MSec.ToString();
  end;
  Result := FloatToStr(LSec) + '.' + LMSecStr;
end;

function TMainForm.SplitTimesToInt2(const Min, Sec, MSec: integer): Integer;
begin
  Result := MSec + (Min * 60 + Sec) * 1000;
end;

function TMainForm.SplitTimesToStr(const Min, Sec, MSec: integer): string;
var
  LStr1, LStr2, LStr3: string;
begin
  if Min < 10 then
  begin
    LStr1 := '0' + Min.ToString();
  end
  else
  begin
    LStr1 := Min.ToString();
  end;
  if Sec < 10 then
  begin
    LStr2 := '0' + Sec.ToString();
  end
  else
  begin
    LStr2 := Sec.ToString();
  end;
  if MSec < 10 then
  begin
    LStr3 := '00' + MSec.ToString();
  end
  else if MSec < 100 then
  begin
    LStr3 := '0' + MSec.ToString();
  end
  else
  begin
    LStr3 := MSec.ToString();
  end;
  Result := LStr1 + ':' + LStr2 + '.' + LStr3;
end;

procedure TMainForm.StartBtnClick(Sender: TObject);
var
  I: Integer;
  LJob: TEncodeJob;
  LFile: TFileListItem;
  j: Integer;
  // a chunk's duration
  LChunkLength: integer;
  LLastChunkDuration: integer;
  LCurrentPosition: integer;
  LOutputFileName: string;
  LFileExt: string;
  LChunkLengthStr: string;
  LCurrentPositionStr: string;
  LNumberOfProcesses: integer;

  LNumberOfChunks: integer;
  LSplitChunkLength: integer;
begin
  if FFiles.Count < 1 then
  begin
    Application.MessageBox('Please add files first.', 'Error', MB_ICONERROR);
    Exit;
  end;

  FCMDCount := 0;
  for I := Low(FProcesses) to High(FProcesses) do
  begin
    FProcesses[i].ResetValues;
  end;

  // number of parallel processes
  LNumberOfProcesses := NumberOfProcessList.ItemIndex + 1;
  AddToLog('Number of parallel process: ' + FloatToStr(LNumberOfProcesses));

  Self.Enabled := False;
  BusyForm.Show;
  try
    for I := 0 to FFiles.Count - 1 do
    begin
      Application.ProcessMessages;

      // file info
      LFile := FFiles[i];

      // file split type
      // todo: convert this if to case as there can be more options in the future
      if LFile.SplitType = stIntoParts then
      begin
        // length of a chunk
        LChunkLength := LFile.DurationAsInt div LFile.PartsCount;
        // calculate last chunks duration
        if (LChunkLength * LFile.PartsCount) < LFile.DurationAsInt then
        begin
          LLastChunkDuration := LFile.DurationAsInt - (LChunkLength * (LFile.PartsCount - 1));
        end
        else
        begin
          LLastChunkDuration := LChunkLength;
        end;

        // generate code for each part
        for j := 1 to LFile.PartsCount do
        begin
          Application.ProcessMessages;

          LCurrentPosition := (j - 1) * LChunkLength;
          // Turkish uses "," instead of "."
          // see http://www.moserware.com/2008/02/does-your-code-pass-turkey-test.html
          LCurrentPositionStr := FloatToStr(LCurrentPosition / 1000).Replace(',', '.');

          // create output file name
          LFileExt := ExtractFileExt(LFile.FullFilePath);
          case NamingOptionList.ItemIndex of
            0:
              begin
                LOutputFileName := ChangeFileExt(OutputFolderEdit.Text + '\' + CreateFolder(LFile.FullFilePath) + ExtractFileName(LFile.FullFilePath), '_' + FloatToStr(j) + LFileExt);
              end;
            1:
              begin
                LOutputFileName := ChangeFileExt(OutputFolderEdit.Text + '\' + CreateFolder(LFile.FullFilePath) + FloatToStr(j) + '_' + ExtractFileName(LFile.FullFilePath), LFileExt);
              end;
            2:
              begin
                LOutputFileName := ChangeFileExt(OutputFolderEdit.Text + '\' + CreateFolder(LFile.FullFilePath), FloatToStr(j) + LFileExt);
              end;
            3:
              begin
                LOutputFileName := ChangeFileExt(OutputFolderEdit.Text + '\' + CreateFolder(LFile.FullFilePath), FloatToStr(j) + '_' + FloatToStr(i + 1) + LFileExt);
              end;
            4:
              begin
                LOutputFileName := ChangeFileExt(OutputFolderEdit.Text + '\' + CreateFolder(LFile.FullFilePath), FloatToStr(i + 1) + '_' + FloatToStr(j) + LFileExt);
              end;
          end;

          if j = LFile.PartsCount then
          begin
            // last chunk is a bit different
            LChunkLengthStr := FloatToStr(LLastChunkDuration / 1000).Replace(',', '.');
            LJob.CommandLine := ' -v 9 -loglevel 99 -ss ' + LCurrentPositionStr + ' -y -i "' + LFile.FullFilePath + '" -vn -c:a copy -t ' + LChunkLengthStr + ' "' + LOutputFileName + '"';
          end
          else
          begin
            // a normal chunk
            LChunkLengthStr := FloatToStr(LChunkLength / 1000).Replace(',', '.');
            LJob.CommandLine := ' -v 9 -loglevel 99 -ss ' + LCurrentPositionStr + ' -y -i "' + LFile.FullFilePath + '" -vn -c:a copy -t ' + LChunkLengthStr + ' "' + LOutputFileName + '"';
          end;

          LJob.ProcessPath := FFmpegPath;
          LJob.ProcessType := ffmpeg;
          LJob.SourceFileName := LFile.FullFilePath;
          LJob.SourceDuration := 1;
          LJob.FileListIndex := i;
          LJob.FinalFilePath := LOutputFileName;
          LJob.EncodingInformation := j.ToString() + ' of ' + LFile.PartsCount.ToString() + ' parts';
          // add job to the queue
          FProcesses[i mod LNumberOfProcesses].EncodeJobs.Add(LJob);
          Inc(FCMDCount);
        end;
      end
      else if LFile.SplitType = stAccordingToDuration then
      begin
        // chunk duration is predefined so we calculate the number of chunks
        LSplitChunkLength := SplitTimesToInt2(LFile.SplitMinute, LFile.SplitSecond, LFile.SplitMiliSeconds);
        if LFile.DurationAsInt > SplitTimesToInt2(LFile.SplitMinute, LFile.SplitSecond, LFile.SplitMiliSeconds) then
        begin
          LNumberOfChunks := LFile.DurationAsInt div LSplitChunkLength;
          // last chunk's duraion
          if (LSplitChunkLength * LNumberOfChunks) < LFile.DurationAsInt then
          begin
            LLastChunkDuration := LFile.DurationAsInt - (LSplitChunkLength * (LNumberOfChunks - 1));
            Inc(LNumberOfChunks);
          end
          else
          begin
            LLastChunkDuration := LSplitChunkLength;
          end;

          // generate code for each part
          for j := 1 to LNumberOfChunks do
          begin
            Application.ProcessMessages;

            LCurrentPosition := (j - 1) * LSplitChunkLength;
            // Turkish uses "," instead of "."
            // see http://www.moserware.com/2008/02/does-your-code-pass-turkey-test.html
            LCurrentPositionStr := FloatToStr(LCurrentPosition / 1000).Replace(',', '.');
            // create output file name
            LFileExt := ExtractFileExt(LFile.FullFilePath);
            case NamingOptionList.ItemIndex of
              0:
                begin
                  LOutputFileName := ChangeFileExt(OutputFolderEdit.Text + '\' + CreateFolder(LFile.FullFilePath) + ExtractFileName(LFile.FullFilePath), '_' + FloatToStr(j) + LFileExt);
                end;
              1:
                begin
                  LOutputFileName := ChangeFileExt(OutputFolderEdit.Text + '\' + CreateFolder(LFile.FullFilePath) + FloatToStr(j) + '_' + ExtractFileName(LFile.FullFilePath), LFileExt);
                end;
              2:
                begin
                  LOutputFileName := ChangeFileExt(OutputFolderEdit.Text + '\' + CreateFolder(LFile.FullFilePath), FloatToStr(j) + LFileExt);
                end;
              3:
                begin
                  LOutputFileName := ChangeFileExt(OutputFolderEdit.Text + '\' + CreateFolder(LFile.FullFilePath), FloatToStr(j) + '_' + FloatToStr(i + 1) + LFileExt);
                end;
              4:
                begin
                  LOutputFileName := ChangeFileExt(OutputFolderEdit.Text + '\' + CreateFolder(LFile.FullFilePath), FloatToStr(i + 1) + '_' + FloatToStr(j) + LFileExt);
                end;
            end;

            if j = LNumberOfChunks then
            begin
              // last chunk is a bit different
              LChunkLengthStr := FloatToStr(LLastChunkDuration / 1000).Replace(',', '.');
              LJob.CommandLine := ' -v 9 -loglevel 99 -ss ' + LCurrentPositionStr + ' -y -i "' + LFile.FullFilePath + '" -vn -c:a copy -t ' + LChunkLengthStr + ' "' + LOutputFileName + '"';
            end
            else
            begin
              // a normal chunk
              LChunkLengthStr := FloatToStr(LSplitChunkLength / 1000).Replace(',', '.');
              LJob.CommandLine := ' -v 9 -loglevel 99 -ss ' + LCurrentPositionStr + ' -y -i "' + LFile.FullFilePath + '" -vn -c:a copy -t ' + LChunkLengthStr + ' "' + LOutputFileName + '"';
            end;

            LJob.ProcessPath := FFmpegPath;
            LJob.ProcessType := ffmpeg;
            LJob.SourceFileName := LFile.FullFilePath;
            LJob.SourceDuration := 1;
            LJob.FileListIndex := i;
            LJob.FinalFilePath := LOutputFileName;
            LJob.EncodingInformation := j.ToString() + ' of ' + LNumberOfChunks.ToString() + ' parts';
            // add job to the queue
            FProcesses[i mod LNumberOfProcesses].EncodeJobs.Add(LJob);
            Inc(FCMDCount);
          end;

        end;
      end;

    end;
  finally
    Self.Enabled := True;
    BusyForm.Close;
    Self.BringToFront;

    // prepare to show progress
    DisableUI;

    AddToLog('Number of jobs to run: ' + FloatToStr(FCMDCount));
    AddToLog('Starting to split.');
    // launch processes
    for I := Low(FProcesses) to High(FProcesses) do
    begin
      Application.ProcessMessages;
      FProcesses[i].FolderCreateOption := OutputFolderOptionsList.ItemIndex;

      if FProcesses[i].EncodeJobs.Count > 0 then
      begin
        FProcesses[i].Start;
      end;
    end;

    FStartDateTime := Now;

    TotalProgressBar.MaxValue := FCMDCount;
    Taskbar.ProgressState := TTaskBarProgressState.Normal;
    Taskbar.ProgressMaxValue := FCMDCount;
    Self.Caption := '[0%] Free Batch Music Splitter';
    ProgressTimer.Enabled := True;
  end;
end;

procedure TMainForm.StopBtnClick(Sender: TObject);
var
  I: Integer;
begin
  if ID_YES = Application.MessageBox('Stop splitting?', 'Question', MB_ICONQUESTION or MB_YESNO) then
  begin
    for I := Low(FProcesses) to High(FProcesses) do
    begin
      if FProcesses[i].ProcessID > 0 then
      begin
        FProcesses[i].Stop;
      end;
    end;
    EnableUI;
    ProgressTimer.Enabled := False;
    AddToLog('Stopped by user.');
    AddToLog('');
  end;
end;

procedure TMainForm.UpdateCheckThreadRun(Sender: TIdThreadComponent);
begin
  UpdateDownloader.Url := VERSION_FILE_URL;
  UpdateDownloader.Start;

  UpdateCheckThread.Terminate;
end;

procedure TMainForm.UpdateDownloaderDoneStream(Sender: TObject; Stream: TStream; StreamSize: Integer; Url: string);
var
  LVersionFileContent: string;
  LVersionInt: integer;
  LTmpList: TStringList;
begin
  LTmpList := TStringList.Create;
  try
    LTmpList.LoadFromStream(Stream);
    if LTmpList.Count = 1 then
    begin
      LVersionFileContent := LTmpList[0].Trim;

      if TryStrToInt(LVersionFileContent, LVersionInt) then
      begin
        if LVersionInt > PROGRAM_VERSION then
        begin
          if ID_YES = Application.MessageBox('There is a new version. Would you like to download it?', 'New Version', MB_ICONQUESTION or MB_YESNO) then
          begin
            ShellExecute(0, 'open', 'http://www.ozok26.com/free-batch-musc-spltter-2', nil, nil, SW_SHOWNORMAL);
          end;
        end;
      end;
    end;
  finally
    LTmpList.Free;
  end;
end;

procedure TMainForm.FileListClick(Sender: TObject);
var
  LItem: TFileListItem;
begin
  // update options according to selected item
  if FileList.ItemIndex > -1 then
  begin
    LItem := FFiles[FileList.ItemIndex];
    case LItem.SplitType of
      stIntoParts:
        begin
          SplitTypePages.ActivePageIndex := 0;
          PartCountEdit.Value := LItem.PartsCount;
          MiliSecondsEdit.Value := 0;
          MinutesEdit.Value := 1;
          SecondsEdit.Value := 0;
        end;
      stAccordingToDuration:
        begin
          SplitTypePages.ActivePageIndex := 1;
          PartCountEdit.Value := 2;
          MiliSecondsEdit.Value := LItem.SplitMiliSeconds;
          MinutesEdit.Value := LItem.SplitMinute;
          SecondsEdit.Value := LItem.SplitSecond;
        end;
    end;
  end;
end;

procedure TMainForm.FileSearchFindFile(Sender: TObject; const AName: string);
begin
  AddFile(AName);
end;

procedure TMainForm.FileSearchProgress(Sender: TObject);
begin
  Application.ProcessMessages;
end;

procedure TMainForm.FormClose(Sender: TObject; var Action: TCloseAction);
var
  i: Integer;
begin
  SaveSettings;
  // stop processes in case user terminates the program in mid-split
  for I := Low(FProcesses) to High(FProcesses) do
  begin
    if FProcesses[i].ProcessID > 0 then
    begin
      FProcesses[i].Stop;
    end;
  end;
end;

procedure TMainForm.FormCreate(Sender: TObject);
var
  I: Integer;
begin
  FFileInfo := TFileInfoExtractor.Create(ExtractFileDir(Application.ExeName) + '\FFmpeg\ffprobe.exe', '');
  FFmpegPath := ExtractFileDir(Application.ExeName) + '\FFmpeg\ffmpeg.exe';
  FFiles := TFileListItems.Create;
  for I := Low(FProcesses) to High(FProcesses) do
  begin
    FProcesses[i] := TMyProcess.Create;
    FProcesses[i].ProcessIndex := i + 1;
  end;
  FileSearch.RecurseDepth := MaxInt;

  // output and appdata folders
  if not PORTABLE then
  begin
    AppDataFolder := Info.Folders.AppData + '\FreeBatchMusicSplitter';
    DefaultOutputFolder := Info.Folders.Personal + '\FreeBatchMusicSplitter';
  end
  else
  begin
    AppDataFolder := ExtractFileDir(Application.ExeName);
    DefaultOutputFolder := AppDataFolder;
  end;

  ForceDirectories(AppDataFolder);
end;

procedure TMainForm.FormDestroy(Sender: TObject);
var
  I: Integer;
begin
  FFileInfo.Free;
  for I := 0 to FFiles.Count - 1 do
  begin
    FFiles[i].Free;
  end;
  for I := Low(FProcesses) to High(FProcesses) do
  begin
    FProcesses[i].Free;
  end;
end;

procedure TMainForm.FormResize(Sender: TObject);
begin
  FileList.Columns[0].Width := FileList.ClientWidth - FileList.Columns[1].Width - FileList.Columns[2].Width - 20;
  ProgressList.Columns[0].Width := ProgressList.ClientWidth - ProgressList.Columns[1].Width - ProgressList.Columns[2].Width - 20;
end;

procedure TMainForm.FormShow(Sender: TObject);
begin
  LoadSettings;
  if CheckUpdatesBtn.Checked then
  begin
    UpdateCheckThread.Start;
  end;
end;

procedure TMainForm.LoadSettings;
var
  LSettingsFile: TIniFile;
begin
  LSettingsFile := TIniFile.Create(AppDataFolder + '\settings.ini');
  try
    with LSettingsFile do
    begin
      OutputFolderEdit.Text := ReadString('general', 'outputfolder', DefaultOutputFolder);
      SplitTypePages.ActivePageIndex := ReadInteger('general', 'activemethod', 0);
      PartCountEdit.Text := ReadString('general', 'partcount', '2');
      MinutesEdit.Text := ReadString('general', 'min', '3');
      SecondsEdit.Text := ReadString('general', 'sec', '0');
      MiliSecondsEdit.Text := ReadString('general', 'milisec', '0');
      DefaultPartBtn.Checked := ReadBool('general', 'defmethod', True);
      DefaultTimeBtn.Checked := not DefaultPartBtn.Checked;
      NumberOfProcessList.ItemIndex := ReadInteger('general', 'numofprocess', 0);
      CheckUpdatesBtn.Checked := ReadBool('general', 'update', True);
      OutputFolderOptionsList.ItemIndex := ReadInteger('general', 'foldermethod', 0);
      FLastDirectory := ReadString('general', 'lastdir', Info.Folders.Personal);
    end;
  finally
    LSettingsFile.Free;
  end;
end;

procedure TMainForm.LogsBtnClick(Sender: TObject);
begin
  LogsForm.Show;
end;

procedure TMainForm.OpenOutputBtnClick(Sender: TObject);
begin
  if DirectoryExists(OutputFolderEdit.Text) then
  begin
    ShellExecute(Handle, 'open', PWideChar(OutputFolderEdit.Text), nil, nil, SW_NORMAL);
  end;
end;

procedure TMainForm.ProgressTimerTimer(Sender: TObject);
var
  LProgress: integer;
  I: Integer;
  LDiffAsSec: int64;
begin
  // calculate progress
  LProgress := 0;
  for I := Low(FProcesses) to High(FProcesses) do
  begin
    if FProcesses[i].EncodeJobs.Count > 0 then
    begin
      Inc(LProgress, FProcesses[i].FilesDone);
    end;
  end;

  if LProgress = FCMDCount then
  begin
    // done
    EnableUI;
    ProgressTimer.Enabled := False;
    AddToLog('Finished splitting.');
    LDiffAsSec := SecondsBetween(Now, FStartDateTime);
    AddToLog(Format('Took %2.2d:%2.2d.', [LDiffAsSec div 60, LDiffAsSec mod 60]));
    AddToLog('');
  end
  else
  begin
    // still working
    TotalProgressBar.Progress := LProgress;
    ProgressLabel.Caption := FloatToStr(LProgress) + '/' + FloatToStr(FCMDCount);
    Self.Caption := '[' + FloatToStr((100 * LProgress) div FCMDCount) + '%] Free Batch Music Splitter';
    Taskbar.ProgressValue := LProgress;
  end;
end;

procedure TMainForm.RemoveSelectedBtnClick(Sender: TObject);
var
  I: Integer;
begin
  for I := FileList.Items.Count - 1 downto 0 do
  begin
    if FileList.Items[i].Selected then
    begin
      FileList.Items.Delete(i);
      FFiles.Delete(i);
    end;
  end;
  StatusBar1.Panels[1].Text := Format('%d files', [FileList.Items.Count]);
end;

end.
