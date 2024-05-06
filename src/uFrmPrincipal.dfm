object FrmPrincipal: TFrmPrincipal
  Left = 0
  Top = 0
  Caption = 'Data Info - Jogos Abertos'
  ClientHeight = 669
  ClientWidth = 1200
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  WindowState = wsMaximized
  TextHeight = 15
  object pnPrincipal: TPanel
    Left = 0
    Top = 0
    Width = 265
    Height = 669
    Align = alLeft
    TabOrder = 0
    ExplicitHeight = 668
    DesignSize = (
      265
      669)
    object btCidades: TButton
      Left = 16
      Top = 24
      Width = 241
      Height = 25
      Caption = 'Resultados por Cidades'
      TabOrder = 0
      OnClick = btCidadesClick
    end
    object btFechar: TButton
      Left = 11
      Top = 624
      Width = 241
      Height = 25
      Anchors = [akLeft, akBottom]
      Caption = 'Fechar Jogos Abertos'
      TabOrder = 1
      OnClick = btFecharClick
      ExplicitTop = 623
    end
    object btResultadoCidades: TButton
      Left = 16
      Top = 72
      Width = 241
      Height = 25
      Caption = 'Resultados por provas'
      TabOrder = 2
      OnClick = btResultadoCidadesClick
    end
    object btSalvarResultadoProvas: TButton
      Left = 18
      Top = 120
      Width = 241
      Height = 25
      Caption = 'Salvar Resultado Todas as Provas  em TXT'
      TabOrder = 3
      OnClick = btSalvarResultadoProvasClick
    end
  end
  object TabSet1: TTabSet
    Left = 265
    Top = 0
    Width = 935
    Height = 669
    Align = alClient
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    ExplicitWidth = 931
    ExplicitHeight = 668
  end
  object pcPrincipal: TPageControl
    Left = 265
    Top = 0
    Width = 935
    Height = 669
    ActivePage = TabSheet1
    Align = alClient
    TabOrder = 2
    object tabProvas: TTabSheet
      Caption = 'Resultado por cidades'
      ImageIndex = 1
      object Button1: TButton
        Left = 16
        Top = 24
        Width = 185
        Height = 25
        Caption = 'Processar resultado'
        TabOrder = 0
        OnClick = Button1Click
      end
      object DBGrid2: TDBGrid
        Left = 16
        Top = 104
        Width = 873
        Height = 297
        DataSource = dm.dsClassificacaoCidades
        TabOrder = 1
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -12
        TitleFont.Name = 'Segoe UI'
        TitleFont.Style = []
        Columns = <
          item
            Expanded = False
            FieldName = 'nome'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'total_medalhas_ouro'
            Width = 180
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'total_medalhas_prata'
            Width = 180
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'total_medalhas_bronze'
            Width = 180
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'posicao'
            Visible = True
          end>
      end
      object ProgressBar: TProgressBar
        Left = 248
        Top = 25
        Width = 361
        Height = 17
        TabOrder = 2
      end
      object Button3: TButton
        Left = 16
        Top = 440
        Width = 193
        Height = 25
        Caption = 'Salvar Resultado em TXT'
        TabOrder = 3
        OnClick = Button3Click
      end
    end
    object TabSheet3: TTabSheet
      Caption = 'Resutados Provas'
      ImageIndex = 2
      object Provas: TLabel
        Left = 16
        Top = 3
        Width = 35
        Height = 15
        Caption = 'Provas'
      end
      object DBLookupComboBox1: TDBLookupComboBox
        Left = 16
        Top = 24
        Width = 353
        Height = 23
        KeyField = 'codigo'
        ListField = 'nome'
        ListSource = dm.dsProvas
        TabOrder = 0
      end
      object btConsultaProva: TButton
        Left = 392
        Top = 22
        Width = 75
        Height = 25
        Caption = 'Consultar'
        DisabledImageName = 'btConsultaProva'
        TabOrder = 1
        OnClick = btConsultaProvaClick
      end
      object DBGrid1: TDBGrid
        Left = 16
        Top = 80
        Width = 913
        Height = 441
        DataSource = dm.dsConsultaMarcas
        TabOrder = 2
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -12
        TitleFont.Name = 'Segoe UI'
        TitleFont.Style = []
        Columns = <
          item
            Expanded = False
            FieldName = 'nome_atleta'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'nome'
            Width = 180
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'marca'
            Width = 150
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'posicao'
            Width = 64
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'classificao'
            Width = 180
            Visible = True
          end>
      end
    end
    object TabSheet1: TTabSheet
      Caption = 'Salvar Resultado Todas Provas em TXT'
      ImageIndex = 2
      object Label1: TLabel
        Left = 24
        Top = 32
        Width = 41
        Height = 15
        Caption = 'Provas: '
      end
      object Label2: TLabel
        Left = 80
        Top = 32
        Width = 3
        Height = 15
      end
      object Label3: TLabel
        Left = 24
        Top = 98
        Width = 99
        Height = 15
        Caption = 'Atletas / Resultado'
      end
      object ProgressBar1: TProgressBar
        Left = 24
        Top = 53
        Width = 609
        Height = 17
        TabOrder = 0
      end
      object ProgressBar2: TProgressBar
        Left = 24
        Top = 119
        Width = 609
        Height = 17
        TabOrder = 1
      end
      object Button2: TButton
        Left = 24
        Top = 160
        Width = 241
        Height = 25
        Caption = 'Salvar Resultado Todas as Provas  em TXT'
        TabOrder = 2
        OnClick = btSalvarResultadoProvasClick
      end
    end
  end
  object SaveDialog1: TSaveDialog
    DefaultExt = '*.txt'
    Filter = 'txt|*.txt'
    Options = [ofOverwritePrompt, ofHideReadOnly, ofEnableSizing]
    Left = 773
    Top = 482
  end
  object SaveDialog2: TSaveDialog
    DefaultExt = '*.txt'
    Filter = 'txt|*.txt'
    Options = [ofOverwritePrompt, ofHideReadOnly, ofEnableSizing]
    Left = 941
    Top = 466
  end
end
