unit uFrmPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.Tabs, Vcl.StdCtrls,
  Vcl.ComCtrls, Vcl.DBCtrls, Data.DB, Vcl.Grids, Vcl.DBGrids, uTipos;

type
  TFrmPrincipal = class(TForm)
    pnPrincipal: TPanel;
    btCidades: TButton;
    TabSet1: TTabSet;
    btFechar: TButton;
    btResultadoCidades: TButton;
    pcPrincipal: TPageControl;
    tabProvas: TTabSheet;
    Button1: TButton;
    TabSheet3: TTabSheet;
    Provas: TLabel;
    DBLookupComboBox1: TDBLookupComboBox;
    btConsultaProva: TButton;
    DBGrid1: TDBGrid;
    DBGrid2: TDBGrid;
    ProgressBar: TProgressBar;
    SaveDialog1: TSaveDialog;
    Button3: TButton;
    SaveDialog2: TSaveDialog;
    btSalvarResultadoProvas: TButton;
    TabSheet1: TTabSheet;
    Label1: TLabel;
    Label2: TLabel;
    ProgressBar1: TProgressBar;
    Label3: TLabel;
    ProgressBar2: TProgressBar;
    Button2: TButton;
    procedure btFecharClick(Sender: TObject);
    procedure btCidadesClick(Sender: TObject);
    procedure btConsultaProvaClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure btResultadoCidadesClick(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure btSalvarResultadoProvasClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmPrincipal: TFrmPrincipal;

implementation

{$R *.dfm}

uses uDataModule;

procedure TFrmPrincipal.btCidadesClick(Sender: TObject);
begin
   pcPrincipal.ActivePageIndex := 0;
end;

procedure TFrmPrincipal.btConsultaProvaClick(Sender: TObject);
begin
  dm.qrConsultaMarcas.Active := false;
  dm.qrConsultaMarcas.ParamByName('pprova').AsInteger := DBLookupComboBox1.ListSource.DataSet.FieldByName(DBLookupComboBox1.KeyField).Value;
  dm.qrConsultaMarcas.Active := true;
end;

procedure TFrmPrincipal.btFecharClick(Sender: TObject);
begin
    Application.Terminate;
end;

procedure TFrmPrincipal.btResultadoCidadesClick(Sender: TObject);
begin
  pcPrincipal.ActivePageIndex := 1;
  dm.ProvasTable.Active := true;
end;

procedure TFrmPrincipal.btSalvarResultadoProvasClick(Sender: TObject);
var
   linha, codAtleta, nomeAtleta, nomeProva, cidade,  posicao : String;
   marca, alinhamento: String;
   diff : Integer;
   arquivo: TStreamWriter;

begin
  pcPrincipal.ActivePageIndex := 2;
  dm.ProvasTable.Active := true;


  if (SaveDialog1.Execute()) then
    begin
      arquivo := TStreamWriter.Create(SaveDialog1.FileName);
      dm.ProvasTable.Open;
      dm.ProvasTable.First;
      ProgressBar1.Position := 0;
      ProgressBar1.Min := 0;
      ProgressBar1.Max := dm.ProvasTable.RecordCount;
      while not dm.ProvasTable.Eof do
      begin
        nomeProva := dm.ProvasTable.FieldByName('nome').AsString;
        label2.Caption := nomeProva;
        ProgressBar1.Position := ProgressBar1.Position + 1;
        ProgressBar1.Refresh;
        Application.ProcessMessages;


       dm.qrRestultadProvas.Active := false;
       dm.qrRestultadProvas.ParamByName('pprova').AsInteger :=  dm.ProvasTable.FieldByName('codigo').AsInteger;
       dm.qrRestultadProvas.Active := true;
       dm.qrRestultadProvas.First;

        ProgressBar2.Position := 0;
        ProgressBar2.Min := 0;
        ProgressBar2.Max := dm.qrRestultadProvas.RecordCount;

       while not dm.qrRestultadProvas.Eof do
       begin

        ProgressBar2.Position := ProgressBar2.Position + 1;
        ProgressBar2.Refresh;
        Application.ProcessMessages;

        try
          codAtleta := dm.qrRestultadProvas.FieldByName('codigo_atleta').AsString;
          nomeAtleta := dm.qrRestultadProvas.FieldByName('nome_atleta').AsString;
          cidade  := dm.qrRestultadProvas.FieldByName('nome').AsString;
          marca := FormatFloat('0.0000',dm.qrRestultadProvas.FieldByName('marca').AsFloat);
          posicao  := dm.qrRestultadProvas.FieldByName('posicao').AsString;

          diff :=  10 - Length(marca);
          alinhamento := StringOfChar(' ',  10 - Length(marca));
          linha := Format('%-*s', [30, nomeProva]);
          linha := linha + Format('%5s', [posicao]);
          linha := linha + Format('%-*s', [40, nomeAtleta]);
          linha := linha + Format('%-*s', [20, cidade]);
          linha := linha + alinhamento + Format('%-10s', [marca]);

          arquivo.WriteLine(linha);
       except
         on E: Exception do
            ShowMessage('Ocorreu um erro ao gravar no arquivo: ' + E.Message);
       end;

        dm.qrRestultadProvas.Next;
       end;



        dm.ProvasTable.Next;
      end;


     arquivo.free;
      ShowMessage('Resultado gravado !!!');

  end;
end;

procedure TFrmPrincipal.Button1Click(Sender: TObject);
var
  codCidade, posicao: Integer;
begin
  dm.qrClassificacaoCidades.Close;
  dm.qrZerarResultadosCidades.ExecSQL;
  dm.ProvasTable.Open;
  dm.ProvasTable.First;

  ProgressBar.Min := 0;
  ProgressBar.Max := dm.ProvasTable.RecordCount;
  ProgressBar.Position := 0;

  while not dm.ProvasTable.Eof do
  begin
     dm.qrResultadoPorProva.Close;
     dm.qrResultadoPorProva.ParamByName('pprova').AsInteger := dm.ProvasTable.FieldByName('codigo').AsLargeInt;
     dm.qrResultadoPorProva.open;

     while not dm.qrResultadoPorProva.Eof do
     begin
       dm.query.Close;
       codCidade := dm.qrResultadoPorProva.FieldByName('cod_cidade').AsInteger;
       posicao := dm.qrResultadoPorProva.FieldByName('posicao').AsInteger;

       case TColocacao(posicao) of
          PrimeiroLugar: dm.GanhouMedalhaOuro(codCidade);
          SegundoLugar: dm.GanhouMedalhaPrata(codCidade);
          TerceiroLugar: dm.GanhouMedalhaBronze(codCidade);
       end;

       ProgressBar.Position := ProgressBar.Position + 1;
       ProgressBar.Refresh;
       dm.qrResultadoPorProva.Next;
     end;
     dm.ProvasTable.Next;
  end;
  dm.qrClassificacaoCidades.Open;

end;

procedure TFrmPrincipal.Button3Click(Sender: TObject);
var
   linha, codCidade, cidade, posicao, medalhasOuro, medalhasPrata,
   medalhasBronze: String;
   arquivo: TStreamWriter;
begin
  if dm.qrClassificacaoCidades.RecordCount = 0 then
  begin
    ShowMessage('Primeiro processo os resultado  !!!');
    Exit;
  end;


  if (SaveDialog1.Execute()) then
  begin
    dm.qrClassificacaoCidades.First;
    arquivo := TStreamWriter.Create(SaveDialog1.FileName);

    while not dm.qrClassificacaoCidades.Eof do
    begin
       try
         codCidade := dm.qrClassificacaoCidades.FieldByName('codCidade').AsString;
         posicao := dm.qrClassificacaoCidades.FieldByName('posicao').AsString;
         medalhasOuro := dm.qrClassificacaoCidades.FieldByName('total_medalhas_ouro').AsString;
         medalhasPrata := dm.qrClassificacaoCidades.FieldByName('total_medalhas_prata').AsString;
         medalhasBronze := dm.qrClassificacaoCidades.FieldByName('total_medalhas_bronze').AsString;
         cidade := dm.qrClassificacaoCidades.FieldByName('nome').AsString;

         linha := Format('%5s', [codCidade]) + Format('%-*s', [20, cidade]);
         linha := linha + Format('%5s', [medalhasOuro]);
         linha := linha + Format('%5s', [medalhasPrata]);
         linha := linha + Format('%5s', [medalhasBronze]);
         linha := linha + Format('%5s', [posicao]);

         arquivo.WriteLine(linha);
       except
         on E: Exception do
            ShowMessage('Ocorreu um erro ao gravar no arquivo: ' + E.Message);
       end;

      dm.qrClassificacaoCidades.Next
    end;

    arquivo.free;
    ShowMessage('Resultado gravado !!!');

  end;
end;

end.
