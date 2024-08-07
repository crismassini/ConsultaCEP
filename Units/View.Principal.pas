unit View.Principal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, System.Actions, Vcl.ActnList, Vcl.Menus,
  Vcl.ComCtrls, Vcl.Imaging.pngimage, Vcl.ExtCtrls, Vcl.StdCtrls, Control.Sistema;

type
  TfrmPrincipal = class(TForm)
    StatusBar1: TStatusBar;
    MainMenu1: TMainMenu;
    Cadastros: TMenuItem;
    Confirao1: TMenuItem;
    sobrte1: TMenuItem;
    Consutas1: TMenuItem;
    sair1: TMenuItem;
    ActionList1: TActionList;
    actSair: TAction;
    Image1: TImage;
    actSobre: TAction;
    ConsultaCEP1: TMenuItem;
    N1: TMenuItem;
    actConsultarCEP: TAction;
    procedure actSairExecute(Sender: TObject);
    procedure actSobreExecute(Sender: TObject);
    procedure actConsultarCEPExecute(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

uses
  View.Sobre, View.ConsultarCEP, Control.Conexao;
{$R *.dfm}

procedure TfrmPrincipal.actConsultarCEPExecute(Sender: TObject);
begin
  if not (TfrmConsultarCep = nil) then
  begin
    Application.CreateForm(TfrmConsultarCep, frmConsultarCep);
    frmConsultarCEP.Show;
  end;
end;

procedure TfrmPrincipal.actSairExecute(Sender: TObject);
begin
  Close;
end;

procedure TfrmPrincipal.actSobreExecute(Sender: TObject);
begin
  if not (TfrmSobre = nil) then
  begin
    Application.CreateForm(TfrmSobre, frmSobre);
    frmSobre.Show;
  end;
end;


procedure TfrmPrincipal.FormDestroy(Sender: TObject);
begin
  TSistemaControl.GetInstance().Destroy();
end;

initialization
  ReportMemoryLeaksOnShutdown := True;

end.
