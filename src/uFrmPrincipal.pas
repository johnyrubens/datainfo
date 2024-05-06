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
    Label1: TLabel;
    lbCidade: TLabel;
    Button1: TButton;
    TabSheet3: TTabSheet;
    Provas: TLabel;
    DBLookupComboBox1: TDBLookupComboBox;
    btConsultaProva: TButton;
    DBGrid1: TDBGrid;
    DBGrid2: TDBGrid;
    procedure btFecharClick(Sender: TObject);
    procedure btCidadesClick(Sender: TObject);
    procedure btConsultaProvaClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure btResultadoCidadesClick(Sender: TObject);
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
var
  foo: Integer;
begin
  dm.qrConsultaMarcas.Active := false;
  foo := DBLookupComboBox1.ListSource.DataSet.FieldByName(DBLookupComboBox1.KeyField).Value;
  dm.qrConsultaMarcas.ParamByName('pprova').AsInteger := DBLookupComboBox1.ListSource.DataSet.FieldByName(DBLookupComboBox1.KeyField).Value;
  dm.qrConsultaMarcas.Active := true;
end;

procedure TFrmPrincipal.btFecharClick(Sender: TObject);
begin
    Application.Terminate;
end;

procedure TFrmPrincipal.btResultadoCidadesClick(Sender: TObject);
var foo: Boolean;
begin
   pcPrincipal.ActivePageIndex := 1;
   dm.ProvasTable.Active := true;
end;

procedure TFrmPrincipal.Button1Click(Sender: TObject);
var
  codCidade, posicao: Integer;
begin
  dm.qrClassificacaoCidades.Close;
  dm.qrZerarResultadosCidades.ExecSQL;
  dm.ProvasTable.Open;
  dm.ProvasTable.First;

  while not dm.ProvasTable.Eof do
  begin
     lbCidade.Caption := dm.ProvasTable.FieldByName('nome').AsString;

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

       dm.qrResultadoPorProva.Next;
     end;
     dm.ProvasTable.Next;
  end;
  dm.qrClassificacaoCidades.Open;

end;

end.
