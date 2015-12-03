unit UnitLogs;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Generics.Collections,
  sSkinProvider, sButton, sComboBox, sMemo;

type
  TLogsForm = class(TForm)
    LogsList: TsMemo;
    LogIndexList: TsComboBox;
    Button1: TsButton;
    RefreshBtn: TsButton;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure LogIndexListChange(Sender: TObject);
    procedure RefreshBtnClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    Logs: array [0 .. 16] of TStringList;
  end;

var
  LogsForm: TLogsForm;

implementation

{$R *.dfm}

procedure TLogsForm.Button1Click(Sender: TObject);
begin
  Close;
end;

procedure TLogsForm.FormCreate(Sender: TObject);
var
  I: Integer;
begin
  for I := Low(Logs) to High(Logs) do
  begin
    Logs[i] := TStringList.Create;
  end;
end;

procedure TLogsForm.FormDestroy(Sender: TObject);
var
  I: Integer;
begin
  for I := Low(Logs) to High(Logs) do
  begin
    Logs[i].Free;
  end;
end;

procedure TLogsForm.FormShow(Sender: TObject);
begin
  RefreshBtnClick(self);
end;

procedure TLogsForm.LogIndexListChange(Sender: TObject);
begin
  RefreshBtnClick(self);
end;

procedure TLogsForm.RefreshBtnClick(Sender: TObject);
begin
  LogsList.Lines.Clear;
  LogsList.Lines.AddStrings(Logs[LogIndexList.ItemIndex]);
  SendMessage(LogsList.Handle, EM_SCROLLCARET, 0, 0);
end;

end.
