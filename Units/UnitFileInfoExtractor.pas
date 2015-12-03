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
unit UnitFileInfoExtractor;

interface

uses Classes, Windows, SysUtils, JvCreateProcess, Messages, StrUtils, Generics.Collections;

type
  TStatus = (Reading, Done);

type
  TFileInfoExtractor = class(TObject)
  private
    FFFMpegProcess: TJvCreateProcess;
    FFFMpegStatus: TStatus;
    FFileName: string;
    FDurationStr: string;

    procedure ProcessTerminate2(Sender: TObject; ExitCode: Cardinal);
    function CodecToExtension(const AudioCodec: string): string;
    function GetBusy: Boolean;
  public
    property FFMpegStatus: TStatus read FFFMpegStatus;
    property FileName: string read FFileName;
    property IsBusy: Boolean read GetBusy;
    property DurationStr: string read FDurationStr;

    constructor Create(const FFmpegPath: string; const MEncoderPath: string);
    destructor Destroy(); override;

    procedure Start(const FileName: string);
    procedure Stop;
  end;

implementation

uses UnitLogs;

{ TFileInfoExtractor }

function TFileInfoExtractor.CodecToExtension(const AudioCodec: string): string;
var
  TmpStr: string;
begin
  TmpStr := Trim(AudioCodec);
  if ContainsText(TmpStr, 'vorbis') then
  begin
    Result := '.ogg';
  end
  else if ContainsText(TmpStr, 'mp3') or ContainsText(TmpStr, 'lame') or ContainsText(TmpStr, 'mpeg') or ContainsText(TmpStr, 'mpa1l3') then
  begin
    Result := '.mp3';
  end
  else if ContainsText(TmpStr, 'aac') then
  begin
    Result := '.m4a';
  end
  else if ContainsText(TmpStr, 'truehd') then
  begin
    Result := '.thd';
  end
  else if ContainsText(TmpStr, 'ac3') then
  begin
    Result := '.ac3';
  end
  else if ContainsText(TmpStr, 'wav') or ContainsText(TmpStr, 'pcm') then
  begin
    Result := '.wav';
  end
  else if ContainsText(TmpStr, 'mp2') then
  begin
    Result := '.mp2';
  end
  else if ContainsText(TmpStr, 'mpa1l2') then
  begin
    Result := '.mp2';
  end
  else if ContainsText(TmpStr, 'amr') then
  begin
    Result := '.amr';
  end
  else if ContainsText(TmpStr, 'flac') then
  begin
    Result := '.flac';
  end;
end;

constructor TFileInfoExtractor.Create(const FFmpegPath: string; const MEncoderPath: string);
begin
  inherited Create;

  FFFMpegProcess := TJvCreateProcess.Create(nil);
  with FFFMpegProcess do
  begin
    ApplicationName := FFmpegPath;
    OnTerminate := ProcessTerminate2;
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

  FFFMpegStatus := Reading;
  FDurationStr := '0';
end;

destructor TFileInfoExtractor.Destroy;
begin
  inherited Destroy;
  FFFMpegProcess.Free;
end;

function TFileInfoExtractor.GetBusy: Boolean;
begin
  Result := (FFMpegStatus = Reading);
end;

procedure TFileInfoExtractor.ProcessTerminate2(Sender: TObject; ExitCode: Cardinal);
var
  LDotPos: integer;
begin
  FFFMpegStatus := Reading;
  try
    FDurationStr := FFFMpegProcess.ConsoleOutput.Text;
    LDotPos := Pos('.', FDurationStr);
    if LDotPos > 0 then
    begin
      FDurationStr := Copy(FDurationStr, 0, LDotPos+3).Replace('.', '');
    end;
  finally
    FFFMpegStatus := Done;
  end;
end;

procedure TFileInfoExtractor.Start(const FileName: string);
begin
  // reset
  FFFMpegProcess.ConsoleOutput.Clear;
  FDurationStr := '00:00:00.00';

  FFileName := FileName;
  FFFMpegProcess.CommandLine := '-y -i "' + FileName + '" -show_entries format=duration -v quiet -of csv="p=0"';
  LogsForm.Logs[0].Add('"' + FFFMpegProcess.ApplicationName + '" ' + FFFMpegProcess.CommandLine);
  FFFMpegProcess.Run;
  FFFMpegStatus := Reading;
end;

procedure TFileInfoExtractor.Stop;
begin
  if FFFMpegProcess.ProcessInfo.hProcess > 0 then
  begin
    TerminateProcess(FFFMpegProcess.ProcessInfo.hProcess, 0)
  end;
end;

end.

