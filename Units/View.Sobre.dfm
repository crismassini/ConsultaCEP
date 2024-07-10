inherited frmSobre: TfrmSobre
  BorderStyle = bsSingle
  Caption = 'Sobre'
  ClientHeight = 120
  ClientWidth = 533
  ExplicitWidth = 549
  ExplicitHeight = 159
  PixelsPerInch = 96
  TextHeight = 15
  inherited stbHora: TStatusBar
    Top = 101
    Width = 533
    ExplicitTop = 101
    ExplicitWidth = 533
  end
  object Panel1: TPanel [1]
    Left = 0
    Top = 0
    Width = 533
    Height = 101
    Align = alClient
    TabOrder = 1
    object Label1: TLabel
      Left = 176
      Top = 24
      Width = 188
      Height = 15
      Caption = 'Desenvolvido por Cristhian Massini '
    end
    object LinkLabel1: TLinkLabel
      Left = 256
      Top = 64
      Width = 40
      Height = 19
      Caption = '<a href="github.com/crismassini">Github</a>'
      TabOrder = 0
      OnClick = LinkLabel1Click
    end
  end
  inherited Timer1: TTimer
    Left = 8
    Top = 8
  end
end
