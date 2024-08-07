unit View.ConsultarCEP;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.ComCtrls,
  View.frmBase, Data.DB, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, Vcl.StdCtrls, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  Vcl.Grids, Vcl.DBGrids, REST.Types, REST.Response.Adapter, REST.Client,
  Data.Bind.Components, Data.Bind.ObjectScope, System.UITypes, Control.Cep, Model.Cep,
  Xml.xmldom, Xml.XMLIntf, Xml.XMLDoc, IdBaseComponent, IdComponent,
  IdIOHandler, IdIOHandlerSocket, IdIOHandlerStack, IdSSL, IdSSLOpenSSL,
  Xml.Win.msxmldom;

type
  TfrmConsultarCEP = class(TfrmBase)
    edtCEP: TEdit;
    edtComplemento: TEdit;
    edtLogradouro: TEdit;
    edtBairro: TEdit;
    edtLocalidade: TEdit;
    edtUf: TEdit;
    lblCep: TLabel;
    lblComplemento: TLabel;
    lblLogradouro: TLabel;
    lblBairro: TLabel;
    lblCidade: TLabel;
    lblUf: TLabel;
    btnConsultaCEP: TButton;
    dsCEPCadastrado: TDataSource;
    rdgMetodo: TRadioGroup;
    RESTClient1: TRESTClient;
    RESTRequest1: TRESTRequest;
    RESTResponse1: TRESTResponse;
    RESTResponseDataSetAdapter1: TRESTResponseDataSetAdapter;
    fdRetornoConsulta: TFDMemTable;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    dbgCepCadastrado: TDBGrid;
    dbgRetornoConsulta: TDBGrid;
    fdCepCadastrado: TFDMemTable;
    dsRetornoConsulta: TDataSource;
    fdRetornoConsultacep: TWideStringField;
    fdRetornoConsultalogradouro: TWideStringField;
    fdRetornoConsultacomplemento: TWideStringField;
    fdRetornoConsultaunidade: TWideStringField;
    fdRetornoConsultabairro: TWideStringField;
    fdRetornoConsultalocalidade: TWideStringField;
    fdRetornoConsultauf: TWideStringField;
    fdRetornoConsultaibge: TIntegerField;
    fdRetornoConsultagia: TIntegerField;
    fdRetornoConsultaddd: TIntegerField;
    fdRetornoConsultasiafi: TIntegerField;
    btnConsultaLogradouro: TButton;
    XMLDocument1: TXMLDocument;
    SSLIO: TIdSSLIOHandlerSocketOpenSSL;
    procedure btnConsultaCEPClick(Sender: TObject);
    procedure edtCEPEnter(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure dbgCepCadastradoDblClick(Sender: TObject);
    procedure dbgCepCadastradoCellClick(Column: TColumn);
    procedure btnConsultaLogradouroClick(Sender: TObject);
    procedure edtLogradouroEnter(Sender: TObject);
    procedure dbgRetornoConsultaDblClick(Sender: TObject);
  private
    { Private declarations }
    FCepControl: TCepControl;
    procedure ConsultaCEP(ACep: string);
    procedure ConsultaCEPporEndereco(AUf, ALocalidade, ALogradouro: string);
    procedure PopulaEdits(AMemtable: TFDMemTable);
    procedure LimpaEdits;
    procedure IncluirCep(AMemtable: TFDMemTable);
    procedure AtualizarCep(AMemtable: TFDMemTable);
    procedure CarregarCeps;
    procedure ConsultaViaJson(AResource: string);
    procedure ConsultaViaXML(AResource: string);
    procedure GravaRetorno;
  public
    { Public declarations }
  end;

const
  _BASE_URL = 'https://viacep.com.br/ws/';

var
  frmConsultarCEP: TfrmConsultarCEP;

implementation

uses
  uAuxiliar;

{$R *.dfm}

{$REGION 'Controles da tela'}
procedure TfrmConsultarCEP.dbgCepCadastradoCellClick(Column: TColumn);
begin
  inherited;
  PopulaEdits(fdCepCadastrado);
end;

procedure TfrmConsultarCEP.dbgCepCadastradoDblClick(Sender: TObject);
begin
  inherited;
  PopulaEdits(fdCepCadastrado);
end;

procedure TfrmConsultarCEP.dbgRetornoConsultaDblClick(Sender: TObject);
begin
  inherited;
  GravaRetorno;
  CarregarCeps;
end;

procedure TfrmConsultarCEP.btnConsultaCEPClick(Sender: TObject);
begin
  inherited;
  ConsultaCep(SoNumero(edtCEP.Text));
end;

procedure TfrmConsultarCEP.btnConsultaLogradouroClick(Sender: TObject);
begin
  inherited;
  ConsultaCEPporEndereco(edtUf.Text, edtLocalidade.Text, edtLogradouro.Text);
end;

procedure TfrmConsultarCEP.edtCEPEnter(Sender: TObject);
begin
  inherited;
  if edtCEP.Text <> EmptyStr then
  begin
    LimpaEdits;
    fdRetornoConsulta.Close;
  end;
end;

procedure TfrmConsultarCEP.edtLogradouroEnter(Sender: TObject);
begin
  inherited;
  if edtCEP.Text <> EmptyStr then
  begin
    LimpaEdits;
    fdRetornoConsulta.Close;
  end;
end;

procedure TfrmConsultarCEP.FormCreate(Sender: TObject);
begin
  inherited;
  FCepControl := TCepControl.Create;
end;

procedure TfrmConsultarCEP.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(FCepControl);
end;

procedure TfrmConsultarCEP.FormShow(Sender: TObject);
begin
  inherited;
  CarregarCeps;
end;

{$ENDREGION}

procedure TfrmConsultarCEP.ConsultaCEP(ACep: string);
begin
  dsRetornoConsulta.DataSet.Close;
  //Valida se o tem 8 digitos
  if ACep.Length <> 8 then
  begin
    MessageDlg('CEP inv�lido!', mtInformation, [mbOk], 0);
    Exit
  end;
  //Valida o m�todo de consulta
  if rdgMetodo.ItemIndex = -1 then
  begin
    MessageDlg('Selecione um m�todo de consulta!', mtInformation, [mbOk], 0);
    rdgMetodo.SetFocus;
    Exit;
  end
  else if rdgMetodo.ItemIndex = 0 then //json
  begin
    ConsultaViaJson(ACep + '/json');
  end
  else                                 //XML  
  begin
    ConsultaViaXML(ACep + '/xml');
  end;

  CarregarCeps;  
end;

procedure TfrmConsultarCEP.ConsultaCEPporEndereco(AUf, ALocalidade,
  ALogradouro: string);
begin
  //Valida parametros para consulta
  if AUf.Length < 2 then
  begin
    MessageDlg('Estado inv�lido!', mtInformation, [mbOk], 0);
    Exit
  end
  else if ALocalidade.Length <= 3 then
  begin
    MessageDlg('Localidade inv�lida!', mtInformation, [mbOk], 0);
    Exit
  end
  else if ALogradouro.Length <= 3 then
  begin
    MessageDlg('Logradouro inv�lido!', mtInformation, [mbOk], 0);
    Exit
  end;

  //Valida o m�todo de consulta
  if rdgMetodo.ItemIndex = -1 then
  begin
    MessageDlg('Selecione um m�todo de consulta!', mtInformation, [mbOk], 0);
    rdgMetodo.SetFocus;
    Exit;
  end
  else if rdgMetodo.ItemIndex = 0 then //json
  begin
    ConsultaViaJson(AUf + '/' + ALocalidade + '/' + ALogradouro + '/json');
  end
  else                                 //XML  
  begin
//    ConsultaViaXML(AUf + '/' + ALocalidade + '/' + ALogradouro + '/xml');;
    MessageDlg('Consulta por Logradouro via XML em constru��o!', mtInformation, [mbOk], 0);
  end;

  CarregarCeps;  
end;

procedure TfrmConsultarCEP.PopulaEdits(AMemtable: TFDMemTable);
begin
  with AMemtable do
  begin
    edtCEP.Text         := FieldByName('cep').AsString;
    edtLogradouro.Text  := FieldByName('logradouro').AsString;
    edtComplemento.Text := FieldByName('complemento').AsString;
    edtBairro.Text      := FieldByName('bairro').AsString;
    edtLocalidade.Text  := FieldByName('localidade').AsString;
    edtUf.Text          := FieldByName('uf').AsString;
  end;
end;

procedure TfrmConsultarCEP.IncluirCep(AMemtable: TFDMemTable);
var
  FCep: TCepModel; 
begin
  FCep := FCepControl.CepModel;

  with AMemtable do
  begin
    FCep.Acao        := uAuxiliar.tacIncluir;
    FCep.Codigo      := FCepControl.GetId(1);
    FCep.Cep         := SoNumero(FieldByName('cep').AsString);
    FCep.Logradouro  := FieldByName('logradouro').AsString;
    FCep.Complemento := FieldByName('complemento').AsString;
    FCep.Bairro      := FieldByName('bairro').AsString;
    FCep.Localidade  := FieldByName('localidade').AsString;
    FCep.Uf          := FieldByName('uf').AsString;

    if FCepControl.CepModel.Salvar then
      MessageDlg('CEP cadastrado com sucesso', mtConfirmation, [mbOk], 0);
  end;
end;

procedure TfrmConsultarCEP.AtualizarCep(AMemtable: TFDMemTable);
var
  FCep: TCepModel; 
begin
  FCep := FCepControl.CepModel;

  with AMemtable do
  begin
    FCep.Acao        := uAuxiliar.tacAlterar;
    FCep.Cep         := SoNumero(FieldByName('cep').AsString);
    FCep.Logradouro  := FieldByName('logradouro').AsString;
    FCep.Complemento := FieldByName('complemento').AsString;
    FCep.Bairro      := FieldByName('bairro').AsString;
    FCep.Localidade  := FieldByName('localidade').AsString;
    FCep.Uf          := FieldByName('uf').AsString;

    if FCep.Salvar then
      MessageDlg('CEP Atualizado com sucesso', mtConfirmation, [mbOk], 0);
  end;
end;

procedure TfrmConsultarCEP.CarregarCeps;
var
  VQry: TFDQuery;
begin
  fdCepCadastrado.Close;

  VQry := FCepControl.Obter;    
  try
    VQry.FetchAll;
    fdCepCadastrado.Data := VQry.Data;
  finally
    VQry.Close;
    FreeAndNil(VQry)
  end;
end;

procedure TfrmConsultarCEP.ConsultaViaJson(AResource: string);
begin
  RESTClient1.BaseURL := _BASE_URL;

  with RESTRequest1 do
  begin
    Resource := AResource;
    Execute;

    if Response.StatusCode = 200 then //Consulta realizada com sucesso
    begin
      if Response.Content.Indexof('erro') > 0 then  //quando nao encontra o cep da base via cep
        MessageDlg('CEP n�o encontrado ou CEP inv�lido!', mtInformation, [mbOk], 0)
      else
      begin
        fdRetornoConsulta.Open;

        if fdRetornoConsulta.RecordCount = 1 then //Se o retornar apenas 1 registro, verifica se existe e grava ou atualiza
        begin
          GravaRetorno;
        end
        else if fdRetornoConsulta.RecordCount > 1 then //Consulta por logradouro pode retornar mais de 1 registro
        begin
          MessageDlg('A consulta retornou mais de 1 registro!' + #10 + #13 +
                     'Selecione no grid de retorno qual registro deseja cadastrar, e de um duplo-clique nele.', mtInformation, [mbok], 0 );
          dbgRetornoConsulta.SetFocus;
        end
        else
          MessageDlg('CEP n�o encontrado ou CEP inv�lido!', mtInformation, [mbOk], 0)
      end;
    end
    else //Se n�o conseguir consultar a base da via cep, mensagem de erro
      MessageDlg('Erro ao consultar CEP. C�digo do erro: ' + IntToStr(Response.StatusCode), mtError, [mbOk], 0);
  end;
end;

procedure TfrmConsultarCEP.ConsultaViaXML(AResource: string);
var
  tempXML :IXMLNode;
  tempNodePAI :IXMLNode;
  tempNodeFilho :IXMLNode;
  I, ICountNodes :Integer;
begin
  XMLDocument1.FileName := _BASE_URL + AResource;
  XMLDocument1.Active := true;
  tempXML := XMLDocument1.DocumentElement;

  with fdRetornoConsulta do
  begin
    Open;

    Append;

    tempNodePAI := tempXML.ChildNodes.FindNode('cep');
    for i := 0 to Pred(tempNodePAI.ChildNodes.Count) do
    begin
      tempNodeFilho := tempNodePAI.ChildNodes[i];
      FieldByName('cep').AsString :=  SoNumero(tempNodeFilho.Text);
    end;

    tempNodePAI := tempXML.ChildNodes.FindNode('logradouro');
    for i := 0 to Pred(tempNodePAI.ChildNodes.Count) do
    begin
      tempNodeFilho := tempNodePAI.ChildNodes[i];
      FieldByName('logradouro').AsString :=  tempNodeFilho.Text;
    end;

    tempNodePAI := tempXML.ChildNodes.FindNode('bairro');
    for i := 0 to Pred(tempNodePAI.ChildNodes.Count) do
    begin
      tempNodeFilho := tempNodePAI.ChildNodes[i];
      FieldByName('bairro').AsString :=  tempNodeFilho.Text;
    end;

    tempNodePAI := tempXML.ChildNodes.FindNode('localidade');
    for i := 0 to Pred(tempNodePAI.ChildNodes.Count) do
    begin
      tempNodeFilho := tempNodePAI.ChildNodes[i];
      FieldByName('localidade').AsString :=  tempNodeFilho.Text;
    end;

    tempNodePAI := tempXML.ChildNodes.FindNode('uf');
    for i := 0 to Pred(tempNodePAI.ChildNodes.Count) do
    begin
      tempNodeFilho := tempNodePAI.ChildNodes[i];
      FieldByName('uf').AsString :=  tempNodeFilho.Text;
    end;

    tempNodePAI := tempXML.ChildNodes.FindNode('ibge');
    for i := 0 to Pred(tempNodePAI.ChildNodes.Count) do
    begin
      tempNodeFilho := tempNodePAI.ChildNodes[i];
      FieldByName('ibge').AsString :=  tempNodeFilho.Text;
    end;

    tempNodePAI := tempXML.ChildNodes.FindNode('gia');
    for i := 0 to Pred(tempNodePAI.ChildNodes.Count) do
    begin
      tempNodeFilho := tempNodePAI.ChildNodes[i];
      FieldByName('gia').AsString :=  tempNodeFilho.Text;
    end;

    tempNodePAI := tempXML.ChildNodes.FindNode('ddd');
    for i := 0 to Pred(tempNodePAI.ChildNodes.Count) do
    begin
      tempNodeFilho := tempNodePAI.ChildNodes[i];
      FieldByName('ddd').AsString :=  tempNodeFilho.Text;
    end;

    tempNodePAI := tempXML.ChildNodes.FindNode('siafi');
    for i := 0 to Pred(tempNodePAI.ChildNodes.Count) do
    begin
      tempNodeFilho := tempNodePAI.ChildNodes[i];
      FieldByName('siafi').AsString :=  tempNodeFilho.Text;
    end;
    Post;

    if RecordCount = 1 then //Se o retornar apenas 1 registro, verifica se existe e grava ou atualiza
    begin
      GravaRetorno;
    end
    else if RecordCount > 1 then
    begin
      MessageDlg('A consulta retornou mais de 1 registro!' + #10 + #13 +
                 'Selecione no grid de retorno qual registro deseja cadastrar, e de um duplo-clique nele.', mtInformation, [mbok], 0 );
      dbgRetornoConsulta.SetFocus;

    end;
  end;
end;

procedure TfrmConsultarCEP.GravaRetorno;
begin
  PopulaEdits(fdRetornoConsulta);
  if FCepControl.Existe(SoNumero(edtCEP.Text)) then
  //verifica se o cep ja existe na base de dados
  begin
    if MessageDlg('Este CEP j� existe na base de dados, deseja atualizar?', mtInformation, [mbYes, mbNo], 0) = mrYes then
    begin
      AtualizarCep(fdRetornoConsulta);
    end;
  end
  else
    //se n�o existe inclui o Cep
    IncluirCep(fdRetornoConsulta);
end;

procedure TfrmConsultarCEP.LimpaEdits;
var
  i: integer;
begin
  for i := Self.ComponentCount -1 downto 0 do
  begin
  if (Self.Components[i] is TEdit) then
     (Self.Components[i] as TEdit).text := '';
  end;
end;

end.
