unit UnitBusy;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls,
  JvExControls, JvAnimatedImage, JvGIFCtrl;

type
  TBusyForm = class(TForm)
    ProgressLabel: TLabel;
    AbortBtn: TButton;
    procedure AbortBtnClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  BusyForm: TBusyForm;

implementation

{$R *.dfm}

uses UnitMain;

procedure TBusyForm.AbortBtnClick(Sender: TObject);
begin
  MainForm.StopAddingFiles := True;
  if MainForm.FileSearch.Searching then
  begin
    MainForm.FileSearch.Abort;
  end;
end;

end.
