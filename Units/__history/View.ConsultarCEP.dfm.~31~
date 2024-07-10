inherited frmConsultarCEP: TfrmConsultarCEP
  Caption = 'Consultar CEP'
  ClientHeight = 583
  ClientWidth = 733
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  ExplicitWidth = 749
  ExplicitHeight = 622
  PixelsPerInch = 96
  TextHeight = 15
  object lblCep: TLabel [0]
    Left = 66
    Top = 19
    Width = 20
    Height = 15
    Caption = 'CEP'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lblComplemento: TLabel [1]
    Left = 8
    Top = 77
    Width = 79
    Height = 15
    Caption = 'Complemento'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lblLogradouro: TLabel [2]
    Left = 23
    Top = 48
    Width = 64
    Height = 15
    Caption = 'Logradouro'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lblBairro: TLabel [3]
    Left = 53
    Top = 108
    Width = 34
    Height = 15
    Caption = 'Bairro'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lblCidade: TLabel [4]
    Left = 49
    Top = 137
    Width = 37
    Height = 15
    Caption = 'Cidade'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lblUf: TLabel [5]
    Left = 72
    Top = 171
    Width = 15
    Height = 15
    Caption = 'UF'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ParentFont = False
  end
  inherited stbHora: TStatusBar
    Top = 564
    Width = 733
    ExplicitTop = 564
    ExplicitWidth = 733
  end
  object edtCEP: TEdit [7]
    Left = 97
    Top = 16
    Width = 217
    Height = 23
    TabOrder = 0
    Text = '07131320'
    OnEnter = edtCEPEnter
  end
  object edtComplemento: TEdit [8]
    Left = 97
    Top = 74
    Width = 217
    Height = 23
    TabOrder = 2
  end
  object edtLogradouro: TEdit [9]
    Left = 97
    Top = 45
    Width = 217
    Height = 23
    TabOrder = 1
    OnEnter = edtLogradouroEnter
  end
  object edtBairro: TEdit [10]
    Left = 97
    Top = 105
    Width = 217
    Height = 23
    TabOrder = 3
  end
  object edtLocalidade: TEdit [11]
    Left = 97
    Top = 134
    Width = 217
    Height = 23
    TabOrder = 4
  end
  object edtUf: TEdit [12]
    Left = 96
    Top = 163
    Width = 218
    Height = 23
    TabOrder = 5
  end
  object btnConsultaCEP: TButton [13]
    Left = 320
    Top = 134
    Width = 113
    Height = 25
    Caption = ' Consultar por CEP'
    TabOrder = 7
    OnClick = btnConsultaCEPClick
  end
  object rdgMetodo: TRadioGroup [14]
    Left = 320
    Top = 23
    Width = 145
    Height = 105
    Caption = 'M'#233'todo de Consulta'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    Items.Strings = (
      'JSON'
      'XML')
    ParentFont = False
    TabOrder = 8
  end
  object GroupBox1: TGroupBox [15]
    Left = 0
    Top = 371
    Width = 733
    Height = 193
    Align = alBottom
    Caption = 'Cep Cadastrados'
    TabOrder = 9
    object dbgCepCadastrado: TDBGrid
      Left = 2
      Top = 17
      Width = 729
      Height = 174
      Align = alClient
      DataSource = dsCEPCadastrado
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -12
      TitleFont.Name = 'Segoe UI'
      TitleFont.Style = []
      OnCellClick = dbgCepCadastradoCellClick
      OnDblClick = dbgCepCadastradoDblClick
    end
  end
  object GroupBox2: TGroupBox [16]
    Left = 0
    Top = 197
    Width = 733
    Height = 174
    Align = alBottom
    Anchors = [akLeft, akTop, akRight, akBottom]
    Caption = 'Retorno Consulta Cep'
    TabOrder = 10
    object dbgRetornoConsulta: TDBGrid
      Left = 2
      Top = 17
      Width = 729
      Height = 155
      Align = alClient
      DataSource = dsRetornoConsulta
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -12
      TitleFont.Name = 'Segoe UI'
      TitleFont.Style = []
      OnDblClick = dbgRetornoConsultaDblClick
      Columns = <
        item
          Expanded = False
          FieldName = 'cep'
          Title.Caption = 'Cep'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'logradouro'
          Title.Caption = 'Logradouro'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'complemento'
          Title.Caption = 'Complemento'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'unidade'
          Title.Caption = 'Unidade'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'bairro'
          Title.Caption = 'Bairro'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'localidade'
          Title.Caption = 'Localidade'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'uf'
          Title.Caption = 'UF'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'ibge'
          Title.Caption = 'IBGE'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'gia'
          Title.Caption = 'Gia'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'ddd'
          Title.Caption = 'DDD'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'siafi'
          Title.Caption = 'Siafi'
          Visible = True
        end>
    end
  end
  object btnConsultaLogradouro: TButton [17]
    Left = 320
    Top = 165
    Width = 154
    Height = 25
    Caption = ' Consultar por Logradouro'
    TabOrder = 11
    OnClick = btnConsultaLogradouroClick
  end
  inherited Timer1: TTimer
    Left = 0
    Top = 160
  end
  object dsCEPCadastrado: TDataSource
    DataSet = fdCepCadastrado
    Left = 440
    Top = 448
  end
  object RESTClient1: TRESTClient
    Accept = 'application/json, text/plain; q=0.9, text/html;q=0.8,'
    AcceptCharset = 'utf-8, *;q=0.8'
    BaseURL = 'https://viacep.com.br/ws'
    Params = <>
    Left = 680
    Top = 64
  end
  object RESTRequest1: TRESTRequest
    AssignedValues = [rvConnectTimeout, rvReadTimeout]
    Client = RESTClient1
    Params = <>
    Resource = '07131320/json'
    Response = RESTResponse1
    Left = 584
    Top = 11
  end
  object RESTResponse1: TRESTResponse
    ContentType = 'application/json'
    Left = 672
    Top = 13
  end
  object RESTResponseDataSetAdapter1: TRESTResponseDataSetAdapter
    Dataset = fdRetornoConsulta
    FieldDefs = <>
    Response = RESTResponse1
    TypesMode = Rich
    Left = 585
    Top = 65
  end
  object fdRetornoConsulta: TFDMemTable
    FieldDefs = <>
    IndexDefs = <>
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvUpdateChngFields, uvUpdateMode, uvLockMode, uvLockPoint, uvLockWait, uvRefreshMode, uvFetchGeneratorsPoint, uvCheckRequired, uvCheckReadOnly, uvCheckUpdatable]
    UpdateOptions.LockWait = True
    UpdateOptions.FetchGeneratorsPoint = gpNone
    UpdateOptions.CheckRequired = False
    StoreDefs = True
    Left = 528
    Top = 248
    object fdRetornoConsultacep: TWideStringField
      FieldName = 'cep'
      Size = 9
    end
    object fdRetornoConsultalogradouro: TWideStringField
      FieldName = 'logradouro'
      Size = 100
    end
    object fdRetornoConsultacomplemento: TWideStringField
      FieldName = 'complemento'
      Size = 50
    end
    object fdRetornoConsultaunidade: TWideStringField
      FieldName = 'unidade'
      Size = 0
    end
    object fdRetornoConsultabairro: TWideStringField
      FieldName = 'bairro'
      Size = 50
    end
    object fdRetornoConsultalocalidade: TWideStringField
      FieldName = 'localidade'
      Size = 50
    end
    object fdRetornoConsultauf: TWideStringField
      FieldName = 'uf'
      Size = 2
    end
    object fdRetornoConsultaibge: TIntegerField
      FieldName = 'ibge'
    end
    object fdRetornoConsultagia: TIntegerField
      FieldName = 'gia'
    end
    object fdRetornoConsultaddd: TIntegerField
      FieldName = 'ddd'
    end
    object fdRetornoConsultasiafi: TIntegerField
      FieldName = 'siafi'
    end
  end
  object fdCepCadastrado: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvUpdateChngFields, uvUpdateMode, uvLockMode, uvLockPoint, uvLockWait, uvRefreshMode, uvFetchGeneratorsPoint, uvCheckRequired, uvCheckReadOnly, uvCheckUpdatable]
    UpdateOptions.LockWait = True
    UpdateOptions.FetchGeneratorsPoint = gpNone
    UpdateOptions.CheckRequired = False
    Left = 296
    Top = 448
  end
  object dsRetornoConsulta: TDataSource
    DataSet = fdRetornoConsulta
    Left = 632
    Top = 242
  end
  object XMLDocument1: TXMLDocument
    Left = 672
    Top = 128
    DOMVendorDesc = 'MSXML'
  end
  object SSLIO: TIdSSLIOHandlerSocketOpenSSL
    MaxLineAction = maException
    Port = 0
    DefaultPort = 0
    SSLOptions.Mode = sslmUnassigned
    SSLOptions.VerifyMode = []
    SSLOptions.VerifyDepth = 0
    Left = 584
    Top = 128
  end
end
