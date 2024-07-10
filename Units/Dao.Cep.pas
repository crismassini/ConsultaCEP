unit Dao.Cep;

interface
uses
  FireDAC.Comp.Client, uConexao, Model.Cep, System.SysUtils, Vcl.Dialogs;
type
  TCepDao = class
  private
    FConexao: TConexao;
  public
    constructor Create;
    function Incluir(ACepModel: TCepModel): Boolean;
    function Alterar(ACepModel: TCepModel): Boolean;
    function Excluir(ACepModel: TCepModel): Boolean;
    function Existe(ACep: string): Boolean;
    function GetId(AAutoIncrementar: Integer): Integer;
    function Obter: TFDQuery;
  end;
implementation

{ TCepDao }

uses Control.Sistema;

function TCepDao.Alterar(ACepModel: TCepModel): Boolean;
var
  VQry: TFDQuery;
begin
  VQry := FConexao.CriarQuery();
  try
    VQry.ExecSQL('update cep set logradouro = :logradouro, complemento = :complemento, bairro = :bairro, localidade = :localidade, uf =:uf ' +
                 'where (cep = :cep)', [ACepModel.Logradouro, ACepModel.Complemento, ACepModel.Bairro, ACepModel.Localidade, ACepModel.Uf, ACepModel.Cep]);
    Result := True;
  finally
    VQry.Free;
  end;
end;
constructor TCepDao.Create;
begin
  FConexao := TSistemaControl.GetInstance().Conexao;
end;
function TCepDao.Excluir(ACepModel: TCepModel): Boolean;
var
  VQry: TFDQuery;
begin
  VQry := FConexao.CriarQuery();
  try
    VQry.ExecSQL('delete cep where (codigo = :codigo)', [ACepModel.Codigo]);
    Result := True;
  finally
    VQry.Free;
  end;
end;
function TCepDao.Existe(ACep: string): Boolean;
var
  VQry: TFDQuery;
begin
  Result := False;
  VQry := FConexao.CriarQuery();
  try
    VQry.Open('select cep from cep where (cep = :cep)', [ACep]);

    if VQry.RecordCount > 0 then
      Result := True;
  finally
    VQry.Free;
  end;
end;

function TCepDao.GetId(AAutoIncrementar: Integer): Integer;
var
  VQry: TFDQuery;
begin
  VQry := FConexao.CriarQuery();
  try
    VQry.Open('select gen_id(gen_cep_id, ' + IntToStr(AAutoIncrementar) + ' ) from rdb$database');
    try
      Result := VQry.Fields[0].AsInteger;
    finally
      VQry.Close;
    end;
  finally
    VQry.Free;
  end;
end;
function TCepDao.Incluir(ACepModel: TCepModel): Boolean;
var
  VQry: TFDQuery;
begin
  VQry := FConexao.CriarQuery();
  try
    VQry.ExecSQL('insert into cep (codigo, cep, logradouro, complemento, bairro, localidade, uf) ' +
                 'values (:codigo, :cep, :logradouro, :complemento, :bairro, :localidade, :uf) ',
                 [ACepModel.Codigo, ACepModel.Cep, ACepModel.Logradouro, ACepModel.Complemento, ACepModel.Bairro, ACepModel.Localidade, ACepModel.Uf]);
    Result := True;
  finally
    VQry.Free;
  end;
end;
function TCepDao.Obter: TFDQuery;
var
  VQry: TFDQuery;
begin
  VQry := FConexao.CriarQuery();
  VQry.Open('select codigo, cep, logradouro, complemento, bairro, localidade, uf from cep order by 1');
  Result := VQry;
end;
end.
