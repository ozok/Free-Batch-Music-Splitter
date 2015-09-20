program FreeBatchMusicSplitter;

uses
  madExcept,
  madLinkDisAsm,
  madListHardware,
  madListProcesses,
  madListModules,
  Vcl.Forms,
  UnitMain in 'Forms\UnitMain.pas' {MainForm},
  UnitFileInfoExtractor in 'Units\UnitFileInfoExtractor.pas',
  UnitFileListItem in 'Units\UnitFileListItem.pas',
  UnitEncoder in 'Units\UnitEncoder.pas',
  UnitBusy in 'Forms\UnitBusy.pas' {BusyForm},
  UnitLogs in 'Forms\UnitLogs.pas' {LogsForm},
  UnitAbout in 'Forms\UnitAbout.pas' {AboutForm};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(TBusyForm, BusyForm);
  Application.CreateForm(TLogsForm, LogsForm);
  Application.CreateForm(TAboutForm, AboutForm);
  Application.Run;

end.
