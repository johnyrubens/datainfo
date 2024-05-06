object dm: Tdm
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 514
  Width = 687
  object qrCriarTabelaCidade: TFDQuery
    Connection = jogosAbertosCon
    SQL.Strings = (
      'CREATE TABLE IF NOT EXISTS cidades ('
      #9'codigo INTEGER NOT NULL,'
      #9'nome TEXT(30) NOT NULL,'
      '        medalhas_ouro INTEGER DEFAULT (0),'
      '        medalhas_prata INTEGER DEFAULT (0),'
      '        medalhas_bronze INTEGER DEFAULT (0),'
      #9'CONSTRAINT cidades_pk PRIMARY KEY (codigo)'
      ');')
    Left = 56
    Top = 120
  end
  object qrCriarTabelaProvas: TFDQuery
    Connection = jogosAbertosCon
    SQL.Strings = (
      'CREATE TABLE IF NOT EXISTS provas ('
      #9'codigo INTEGER NOT NULL,'
      #9'nome TEXT(30) NOT NULL,'
      #9'tipo_prova TEXT(1),'
      #9'CONSTRAINT provas_pk PRIMARY KEY (codigo)'
      ');')
    Left = 200
    Top = 128
  end
  object qrCriarTabelaMarcas: TFDQuery
    Connection = jogosAbertosCon
    SQL.Strings = (
      'CREATE TABLE IF NOT EXISTS marcas ('
      #9'codigo INTEGER NOT NULL,'
      #9'nome_atleta TEXT(40) NOT NULL,'
      #9'cod_cidade INTEGER NOT NULL,'
      #9'cod_prova INTEGER NOT NULL,'
      #9'marca REAL NOT NULL,'
      #9'CONSTRAINT marcas_pk PRIMARY KEY (codigo),'
      
        #9'CONSTRAINT marcas_cidades_FK FOREIGN KEY (cod_cidade) REFERENCE' +
        'S cidades(codigo),'
      
        #9'CONSTRAINT marcas_provas_FK FOREIGN KEY (cod_prova) REFERENCES ' +
        'provas(codigo)'
      ');')
    Left = 344
    Top = 128
  end
  object qrInsertCidade: TFDQuery
    Connection = jogosAbertosCon
    Transaction = FDTransaction1
    SQL.Strings = (
      
        'insert into cidades (codigo, nome) values (:p_codigo, :p_nome); ' +
        '         ')
    Left = 72
    Top = 192
    ParamData = <
      item
        Name = 'P_CODIGO'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'P_NOME'
        DataType = ftString
        ParamType = ptInput
        Value = Null
      end>
  end
  object jogosAbertosCon: TFDConnection
    Params.Strings = (
      'LockingMode=Normal'
      'ConnectionDef=jogoAbertos')
    Connected = True
    LoginPrompt = False
    Left = 68
    Top = 17
  end
  object qrInsertProva: TFDQuery
    Connection = jogosAbertosCon
    Transaction = FDTransaction1
    SQL.Strings = (
      'insert into provas (codigo, nome, tipo_prova)'
      ' values (:p_codigo, :p_nome, :p_tipo_prova)          ')
    Left = 176
    Top = 192
    ParamData = <
      item
        Name = 'P_CODIGO'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'P_NOME'
        DataType = ftString
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'P_TIPO_PROVA'
        DataType = ftString
        ParamType = ptInput
        Value = Null
      end>
  end
  object qrInsertMarca: TFDQuery
    Connection = jogosAbertosCon
    Transaction = FDTransaction1
    SQL.Strings = (
      'insert into marcas '
      ' (id, codigo_atleta, nome_atleta, cod_cidade, cod_prova, marca) '
      'values'
      
        ' (:id, :codigo_atleta, :p_atleta, :p_cod_cidade, :p_cod_prova, :' +
        'p_marca)')
    Left = 288
    Top = 192
    ParamData = <
      item
        Name = 'ID'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'CODIGO_ATLETA'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'P_ATLETA'
        DataType = ftString
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'P_COD_CIDADE'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'P_COD_PROVA'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'P_MARCA'
        DataType = ftFloat
        ParamType = ptInput
        Value = Null
      end>
  end
  object qrTruncaTabCidade: TFDQuery
    Connection = jogosAbertosCon
    Transaction = FDTransaction1
    SQL.Strings = (
      'delete from cidades           ')
    Left = 72
    Top = 288
  end
  object qrTruncaTabProva: TFDQuery
    Connection = jogosAbertosCon
    Transaction = FDTransaction1
    SQL.Strings = (
      'delete from provas      ')
    Left = 200
    Top = 288
  end
  object qrTruncaTabMarcas: TFDQuery
    Connection = jogosAbertosCon
    Transaction = FDTransaction1
    SQL.Strings = (
      'delete from marcas where id > 0')
    Left = 336
    Top = 288
  end
  object ProvasTable: TFDQuery
    ConstraintsEnabled = True
    Connection = jogosAbertosCon
    Transaction = FDTransaction1
    SQL.Strings = (
      'SELECT codigo, nome FROM provas order by nome')
    Left = 63
    Top = 385
    object ProvasTablecodigo: TIntegerField
      FieldName = 'codigo'
      Origin = 'codigo'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object ProvasTablenome: TWideStringField
      FieldName = 'nome'
      Origin = 'nome'
      Required = True
      Size = 30
    end
  end
  object dsProvas: TDataSource
    DataSet = ProvasTable
    Left = 152
    Top = 384
  end
  object FDTransaction1: TFDTransaction
    Connection = jogosAbertosCon
    Left = 208
    Top = 32
  end
  object qrConsultaMarcas: TFDQuery
    Connection = jogosAbertosCon
    SQL.Strings = (
      ''
      
        'select consulta.nome_atleta, consulta.nome, consulta.marca, cons' +
        'ulta.posicao,'
      '       (case when consulta.posicao = 1 then '#39'VENCEDOR'#39
      '             when consulta.posicao = 2 then '#39'2 lugar'#39
      '             when consulta.posicao = 3 then '#39'3 lugar'#39
      '             else '#39#39
      '       end) classificao'
      'from ('
      'select a.nome_atleta, b.nome, a.marca,'
      
        '       (case when c.tipo_prova = '#39'-'#39' then RANK() OVER (ORDER BY ' +
        'marca) '
      
        '            when c.tipo_prova = '#39'+'#39' then RANK() OVER (ORDER BY m' +
        'arca desc) '
      '        end) as posicao'
      'from marcas as a'
      'left join cidades b on (b.codigo = a.cod_cidade)'
      'left join provas c on (c.codigo = a.cod_prova)'
      'where a.cod_prova = :pprova'
      ') consulta'
      'ORDER by consulta.posicao'
      ' ')
    Left = 272
    Top = 384
    ParamData = <
      item
        Name = 'PPROVA'
        DataType = ftInteger
        ParamType = ptInput
        Value = 1
      end>
    object qrConsultaMarcasnome_atleta: TWideStringField
      DisplayLabel = 'Atleta'
      FieldName = 'nome_atleta'
      Origin = 'nome_atleta'
      Required = True
      Size = 40
    end
    object qrConsultaMarcasnome: TWideStringField
      AutoGenerateValue = arDefault
      DisplayLabel = 'Cidade'
      FieldName = 'nome'
      Origin = 'nome'
      ProviderFlags = []
      ReadOnly = True
      Size = 30
    end
    object qrConsultaMarcasmarca: TFloatField
      DisplayLabel = 'Marca'
      FieldName = 'marca'
      Origin = 'marca'
      Required = True
    end
    object qrConsultaMarcasposicao: TLargeintField
      AutoGenerateValue = arDefault
      DisplayLabel = 'Posi'#231#227'o'
      FieldName = 'posicao'
      Origin = 'posicao'
      ProviderFlags = []
      ReadOnly = True
    end
    object qrConsultaMarcasclassificao: TWideStringField
      AutoGenerateValue = arDefault
      DisplayLabel = 'Classifica'#231#227'o'
      FieldName = 'classificao'
      Origin = 'classificao'
      ProviderFlags = []
      ReadOnly = True
      Size = 32767
    end
  end
  object dsConsultaMarcas: TDataSource
    DataSet = qrConsultaMarcas
    Left = 424
    Top = 384
  end
  object qrZerarResultadosCidades: TFDQuery
    Connection = jogosAbertosCon
    SQL.Strings = (
      'update cidades set'
      '     medalhas_ouro = 0,'
      '     medalhas_prata = 0,'
      '     medalhas_bronze = 0'
      'where codigo > -1   ')
    Left = 352
    Top = 24
  end
  object qrResultadoPorProva: TFDQuery
    Connection = jogosAbertosCon
    SQL.Strings = (
      'select consulta.cod_cidade, consulta.posicao '
      'from ('
      'select a.cod_cidade,'
      
        '       (case when c.tipo_prova = '#39'-'#39' then RANK() OVER (ORDER BY ' +
        'marca) '
      
        '            when c.tipo_prova = '#39'+'#39' then RANK() OVER (ORDER BY m' +
        'arca desc) '
      '        end) as posicao'
      'from marcas as a'
      'left join cidades b on (b.codigo = a.cod_cidade)'
      'left join provas c on (c.codigo = a.cod_prova)'
      'where a.cod_prova = :pprova'
      ') consulta'
      'ORDER by consulta.posicao'
      'limit 3')
    Left = 520
    Top = 56
    ParamData = <
      item
        Name = 'PPROVA'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end>
    object qrResultadoPorProvacod_cidade: TIntegerField
      FieldName = 'cod_cidade'
      Origin = 'cod_cidade'
      Required = True
    end
    object qrResultadoPorProvaposicao: TLargeintField
      FieldName = 'posicao'
    end
  end
  object query: TFDQuery
    Connection = jogosAbertosCon
    Left = 400
    Top = 208
  end
  object qrClassificacaoCidades: TFDQuery
    Connection = jogosAbertosCon
    SQL.Strings = (
      
        'select consulta.codcidade, consulta.nome, consulta.total_medalha' +
        's_ouro, consulta.total_medalhas_prata, consulta.total_medalhas_b' +
        'ronze,'
      
        '        RANK() OVER (ORDER BY consulta.total_medalhas_ouro desc,' +
        ' consulta.total_medalhas_prata desc, consulta.total_medalhas_bro' +
        'nze desc) as posicao'
      'from ('
      'select c.codigo AS codcidade, c.nome,  '
      
        '     (select sum(mo.medalhas_ouro) from cidades mo where mo.codi' +
        'go = c.codigo  ) as total_medalhas_ouro,'
      
        '     (select sum(mp.medalhas_prata) from cidades mp where mp.cod' +
        'igo = c.codigo  ) as total_medalhas_prata,'
      
        '     (select sum(mb.medalhas_bronze) from cidades mb where mb.co' +
        'digo = c.codigo  ) as total_medalhas_bronze'
      'from cidades c '
      ') consulta'
      
        'where not (consulta.total_medalhas_ouro = 0 and consulta.total_m' +
        'edalhas_prata = 0 and consulta.total_medalhas_bronze = 0)'
      '')
    Left = 544
    Top = 344
    object qrClassificacaoCidadesnome: TWideStringField
      DisplayLabel = 'Cidade'
      FieldName = 'nome'
      Origin = 'nome'
      Required = True
      Size = 30
    end
    object qrClassificacaoCidadestotal_medalhas_ouro: TLargeintField
      AutoGenerateValue = arDefault
      DisplayLabel = 'Total Medalhas Ouro'
      FieldName = 'total_medalhas_ouro'
      Origin = 'total_medalhas_ouro'
      ProviderFlags = []
      ReadOnly = True
    end
    object qrClassificacaoCidadestotal_medalhas_prata: TLargeintField
      AutoGenerateValue = arDefault
      DisplayLabel = 'Total Medalhas Prata'
      FieldName = 'total_medalhas_prata'
      Origin = 'total_medalhas_prata'
      ProviderFlags = []
      ReadOnly = True
    end
    object qrClassificacaoCidadestotal_medalhas_bronze: TLargeintField
      AutoGenerateValue = arDefault
      DisplayLabel = 'Total Medalhas Bronze'
      FieldName = 'total_medalhas_bronze'
      Origin = 'total_medalhas_bronze'
      ProviderFlags = []
      ReadOnly = True
    end
    object qrClassificacaoCidadescodcidade: TIntegerField
      FieldName = 'codcidade'
      Origin = 'codigo'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object qrClassificacaoCidadesposicao: TLargeintField
      AutoGenerateValue = arDefault
      DisplayLabel = 'Posi'#231#227'o'
      FieldName = 'posicao'
      Origin = 'posicao'
      ProviderFlags = []
      ReadOnly = True
    end
  end
  object dsClassificacaoCidades: TDataSource
    DataSet = qrClassificacaoCidades
    Left = 432
    Top = 456
  end
  object dsResultadoPorProva: TDataSource
    DataSet = qrResultadoPorProva
    Left = 520
    Top = 112
  end
  object qrRestultadProvas: TFDQuery
    Connection = jogosAbertosCon
    SQL.Strings = (
      
        'select consulta.codigo_atleta, consulta.nome_atleta, consulta.no' +
        'me, consulta.marca, consulta.posicao,'
      '       (case when consulta.posicao = 1 then '#39'VENCEDOR'#39
      '             when consulta.posicao = 2 then '#39'2 lugar'#39
      '             when consulta.posicao = 3 then '#39'3 lugar'#39
      '             else '#39#39
      '       end) classificao'
      'from ('
      'select a.codigo_atleta, a.nome_atleta, b.nome, a.marca,'
      
        '       (case when c.tipo_prova = '#39'-'#39' then RANK() OVER (ORDER BY ' +
        'marca) '
      
        '            when c.tipo_prova = '#39'+'#39' then RANK() OVER (ORDER BY m' +
        'arca desc) '
      '        end) as posicao'
      'from marcas as a'
      'left join cidades b on (b.codigo = a.cod_cidade)'
      'left join provas c on (c.codigo = a.cod_prova)'
      'where a.cod_prova = :pprova'
      ') consulta'
      'ORDER by consulta.posicao'
      'limit 3')
    Left = 64
    Top = 448
    ParamData = <
      item
        Name = 'PPROVA'
        DataType = ftInteger
        ParamType = ptInput
        Value = 1
      end>
    object qrRestultadProvascodigo_atleta: TIntegerField
      FieldName = 'codigo_atleta'
      Origin = 'codigo_atleta'
      Required = True
    end
    object qrRestultadProvasnome_atleta: TWideStringField
      FieldName = 'nome_atleta'
      Origin = 'nome_atleta'
      Required = True
      Size = 40
    end
    object qrRestultadProvasnome: TWideStringField
      AutoGenerateValue = arDefault
      FieldName = 'nome'
      Origin = 'nome'
      ProviderFlags = []
      ReadOnly = True
      Size = 30
    end
    object qrRestultadProvasmarca: TFloatField
      FieldName = 'marca'
      Origin = 'marca'
      Required = True
    end
    object qrRestultadProvasposicao: TLargeintField
      AutoGenerateValue = arDefault
      FieldName = 'posicao'
      Origin = 'posicao'
      ProviderFlags = []
      ReadOnly = True
    end
    object qrRestultadProvasclassificao: TWideStringField
      AutoGenerateValue = arDefault
      FieldName = 'classificao'
      Origin = 'classificao'
      ProviderFlags = []
      ReadOnly = True
      Size = 32767
    end
  end
  object dsRestultadProvas: TDataSource
    DataSet = qrRestultadProvas
    Left = 200
    Top = 448
  end
end
