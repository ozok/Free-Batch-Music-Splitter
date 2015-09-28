{ *
  * Copyright (C) 2011-2014 ozok <ozok26@gmail.com>
  *
  * This file is part of TEncoder.
  *
  * TEncoder is free software: you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
  * the Free Software Foundation, either version 2 of the License, or
  * (at your option) any later version.
  *
  * TEncoder is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  * GNU General Public License for more details.
  *
  * You should have received a copy of the GNU General Public License
  * along with TEncoder.  If not, see <http://www.gnu.org/licenses/>.
  *
  * }
unit UnitEncoder;

interface

uses Classes, Windows, SysUtils, JvCreateProcess, Messages, StrUtils, ComCtrls, Generics.Collections;

// current state of the process
type
  TEncoderStatus = (esEncoding, esStopped, esDone);

type
  TProcessType = (mencoder, ffmpeg, mp4box, renametool, imagemagick);

type
  TEncodeJob = packed record
    CommandLine: string;
    ProcessPath: string;
    ProcessType: TProcessType;
    SourceFileName: string;
    SourceDuration: integer;
    EncodingInformation: string;
    FileListIndex: integer;
    EncodingOutputFilePath: string;
    FinalFilePath: string;
  end;

type
  TEncodeJobs = TList<TEncodeJob>;

type
  TMyProcess = class(TObject)
  private
    // process
    FProcess: TJvCreateProcess;
    FEncodeJobs: TEncodeJobs;
    // index of current command line. Also progress.
    FCommandIndex: integer;
    // encoder's state
    FEncoderStatus: TEncoderStatus;
    // flag to indicate if encoding is stopped by user
    FStoppedByUser: Boolean;
    FItem: TListItem;
    FProcessIndex: integer;
    FFolderCreateOption: integer;

    // process events
    procedure ProcessRead(Sender: TObject; const S: string; const StartsOnNewLine: Boolean);
    procedure ProcessTerminate(Sender: TObject; ExitCode: Cardinal);

    // field variable read funcs
    function GetProcessID: integer;
    function GetFileName: string;
    function GetCurrentProcessType: TProcessType;
    function GetInfo: string;
    function GetCommandCount: integer;
    function GetExeName: string;
    function GetFileIndex: Integer;
  public
    property EncoderStatus: TEncoderStatus read FEncoderStatus;
    property FilesDone: integer read FCommandIndex;
    property ProcessID: integer read GetProcessID;
    property CurrentFile: string read GetFileName;
    property CurrentProcessType: TProcessType read GetCurrentProcessType;
    property Info: string read GetInfo;
    property CommandCount: integer read GetCommandCount;
    property ExeName: string read GetExeName;
    property FileIndex: Integer read GetFileIndex;
    property EncodeJobs: TEncodeJobs read FEncodeJobs write FEncodeJobs;
    property ProcessIndex: integer read FProcessIndex write FProcessIndex;
    property FolderCreateOption: integer read FFolderCreateOption write FFolderCreateOption;

    constructor Create();
    destructor Destroy(); override;

    procedure Start();
    procedure Stop();
    procedure ResetValues();
    function GetConsoleOutput(): TStrings;
  end;

implementation

{ TMyProcess }

uses UnitMain, UnitLogs;

constructor TMyProcess.Create;
begin
  inherited Create;

  FProcess := TJvCreateProcess.Create(nil);
  with FProcess do
  begin
    OnRead := ProcessRead;
    OnTerminate := ProcessTerminate;
    ConsoleOptions := [coRedirect];
    CreationFlags := [cfUnicode];
    Priority := ppIdle;

    with StartupInfo do
    begin
      DefaultPosition := False;
      DefaultSize := False;
      DefaultWindowState := False;
      ShowWindow := swHide;
    end;

    WaitForTerminate := true;
  end;

  FEncodeJobs := TEncodeJobs.Create;
  FEncoderStatus := esStopped;
  FStoppedByUser := False;
  FCommandIndex := 0;
end;

destructor TMyProcess.Destroy;
begin
  FreeAndNil(FEncodeJobs);
  FProcess.Free;
  inherited Destroy;

end;

function TMyProcess.GetCommandCount: integer;
begin
  Result := FEncodeJobs.Count;
end;

function TMyProcess.GetConsoleOutput: TStrings;
begin
  Result := FProcess.ConsoleOutput;
end;

function TMyProcess.GetCurrentProcessType: TProcessType;
begin
  Result := ffmpeg;
  if FCommandIndex < FEncodeJobs.Count then
    Result := FEncodeJobs[FCommandIndex].ProcessType;
end;

function TMyProcess.GetExeName: string;
begin
  if FCommandIndex < FEncodeJobs.Count then
    Result := FEncodeJobs[FCommandIndex].ProcessPath;
end;

function TMyProcess.GetFileIndex: Integer;
begin
  Result := 0;
  if FCommandIndex < FEncodeJobs.Count then
    Result := FEncodeJobs[FCommandIndex].FileListIndex;
end;

function TMyProcess.GetFileName: string;
begin
  if FCommandIndex < FEncodeJobs.Count then
    Result := FEncodeJobs[FCommandIndex].SourceFileName;
end;

function TMyProcess.GetInfo: string;
begin
  if FCommandIndex < FEncodeJobs.Count then
    Result := FEncodeJobs[FCommandIndex].EncodingInformation;
end;

function TMyProcess.GetProcessID: integer;
begin
  Result := FProcess.ProcessInfo.hProcess;
end;

procedure TMyProcess.ProcessRead(Sender: TObject; const S: string; const StartsOnNewLine: Boolean);
begin

end;

procedure TMyProcess.ProcessTerminate(Sender: TObject; ExitCode: Cardinal);
begin
  // log console output
  LogsForm.Logs[FProcessIndex].Add('Command line: ' + FEncodeJobs[FCommandIndex].CommandLine);
  LogsForm.Logs[FProcessIndex].Add('Exit code: ' + FloatToStr(ExitCode));
  LogsForm.Logs[FProcessIndex].Add('Console output:');
  LogsForm.Logs[FProcessIndex].AddStrings(FProcess.ConsoleOutput);
  LogsForm.Logs[FProcessIndex].Add('');
  FProcess.ConsoleOutput.Clear;

  FEncoderStatus := esStopped;
  if FStoppedByUser then
  begin
    FEncoderStatus := esStopped;
  end
  else
  begin
    // report if process does not exit with 0
    if ExitCode <> 0 then
    begin
      MainForm.AddToLog('Command line: ' + FEncodeJobs[FCommandIndex].CommandLine);
      MainForm.AddToLog('Exit code: ' + FloatToStr(ExitCode));
      FItem.SubItems[1] := 'Error code: ' + FloatToStr(ExitCode);
    end
    else
    begin
      FItem.SubItems[1] := 'Done';
      FItem.StateIndex := 2;
    end;

    // run next command
    inc(FCommandIndex);
    if FCommandIndex < FEncodeJobs.Count then
    begin
      FProcess.CommandLine := FEncodeJobs[FCommandIndex].CommandLine;
      FProcess.ApplicationName := FEncodeJobs[FCommandIndex].ProcessPath;
      if not DirectoryExists(ExtractFileDir(FEncodeJobs[FCommandIndex].FinalFilePath)) then
      begin
        ForceDirectories(ExtractFileDir(FEncodeJobs[FCommandIndex].FinalFilePath))
      end;
      FEncoderStatus := esEncoding;
      FItem := MainForm.ProgressList.Items.Add;
      FItem.Caption := FEncodeJobs[FCommandIndex].SourceFileName;
      FItem.SubItems.Add(FEncodeJobs[FCommandIndex].EncodingInformation);
      FItem.SubItems.Add('Splitting');
      FItem.StateIndex := 0;
      FItem.MakeVisible(False);
      FProcess.Run;
    end
    else
    begin
      // done
      FEncoderStatus := esDone;
    end;
  end;
end;

procedure TMyProcess.ResetValues;
begin
  // reset all lists, indexes etc
  FEncodeJobs.Clear;
  FCommandIndex := 0;
  FProcess.ConsoleOutput.Clear;
  FStoppedByUser := False;
  FItem := nil;
end;

procedure TMyProcess.Start;
begin
  if FProcess.ProcessInfo.hProcess = 0 then
  begin
    if FEncodeJobs.Count > 0 then
    begin
      if FileExists(FEncodeJobs[0].ProcessPath) then
      begin
        FProcess.ApplicationName := FEncodeJobs[0].ProcessPath;
        FProcess.CommandLine := FEncodeJobs[0].CommandLine;
        if not DirectoryExists(ExtractFileDir(FEncodeJobs[0].FinalFilePath)) then
        begin
          ForceDirectories(ExtractFileDir(FEncodeJobs[0].FinalFilePath))
        end;
        FEncoderStatus := esEncoding;
        FItem := MainForm.ProgressList.Items.Add;
        FItem.Caption := GetFileName;
        FItem.SubItems.Add(GetInfo);
        FItem.SubItems.Add('Splitting');
        FItem.StateIndex := 0;
        FItem.MakeVisible(False);
        FProcess.Run;
      end
    end
  end
end;

procedure TMyProcess.Stop;
begin
  if FProcess.ProcessInfo.hProcess > 0 then
  begin
    TerminateProcess(FProcess.ProcessInfo.hProcess, 0);
    FEncoderStatus := esStopped;
    FStoppedByUser := true;
  end;
end;

end.
