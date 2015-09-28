unit UnitAbout;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, 
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, 
  acPNG, Vcl.ExtCtrls, ShellAPI, sSkinProvider, sButton, sLabel, acImage;

type
  TAboutForm = class(TForm)
    Label1: TsLabel;
    Label2: TsLabel;
    Label3: TsLabel;
    Label4: TsLabel;
    Label5: TsLabel;
    Button1: TsButton;
    Button2: TsButton;
    Button3: TsButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Button3Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  AboutForm: TAboutForm;

implementation

{$R *.dfm}

uses UnitMain;

procedure TAboutForm.Button1Click(Sender: TObject);
begin
  ShellExecute(0, 'open', 'https://sourceforge.net/projects/free-batch-music-splitter/', nil, nil, SW_SHOWNORMAL);
end;

procedure TAboutForm.Button2Click(Sender: TObject);
begin
  ShellExecute(0, 'open', 'https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=WRHMQXUPKWVTU', nil, nil, SW_SHOWNORMAL);
end;

procedure TAboutForm.Button3Click(Sender: TObject);
begin
  Close;
end;

procedure TAboutForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  MainForm.Enabled := True;
  MainForm.BringToFront;
end;

procedure TAboutForm.FormCreate(Sender: TObject);
begin
  {$IFDEF WIN64}
    Label2.Caption := Label2.Caption + ' 64bit';
  {$ELSE}
    Label2.Caption := Label2.Caption + ' 32bit';
  {$ENDIF}
end;

end.
