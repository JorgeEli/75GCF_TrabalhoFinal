unit Clientes;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.DBCtrls, Vcl.Mask,
  Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls, Vcl.Grids, Vcl.DBGrids, Vcl.ComCtrls,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TFClientes = class(TForm)
    PageClientes: TPageControl;
    TabListagem: TTabSheet;
    DBGrid1: TDBGrid;
    Panel2: TPanel;
    Label4: TLabel;
    EdPesquisa: TEdit;
    BtPesquisar: TBitBtn;
    BtLimparPesquisa: TBitBtn;
    BtListagemNovo: TBitBtn;
    BtAtualizarListagem: TBitBtn;
    Panel3: TPanel;
    TabCadastro: TTabSheet;
    Panel1: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    EdCodigo: TDBEdit;
    EdNome: TDBEdit;
    BtExcluir: TBitBtn;
    BtCancelar: TBitBtn;
    BtEditar: TBitBtn;
    BtSalvar: TBitBtn;
    BtNovo: TBitBtn;
    BtAtualizar: TBitBtn;
    Panel4: TPanel;
    QryListagem: TFDQuery;
    DsListagem: TDataSource;
    GroupBox1: TGroupBox;
    Label5: TLabel;
    EdLogradouro: TDBEdit;
    Label6: TLabel;
    EdNumero: TDBEdit;
    Label7: TLabel;
    EdBairro: TDBEdit;
    Label8: TLabel;
    EdCidade: TDBEdit;
    Label9: TLabel;
    EdCep: TDBEdit;
    Label10: TLabel;
    EdUf: TDBEdit;
    QryClientes: TFDQuery;
    DsClientes: TDataSource;
    EdCpf: TDBEdit;
    Label3: TLabel;
    QryClientesCLIENTE_CODIGO: TIntegerField;
    QryClientesCLIENTE_NOME: TStringField;
    QryClientesCLIENTE_CPF: TStringField;
    QryClientesCLIENTE_LOGRADOURO: TStringField;
    QryClientesCLIENTE_ENDERECO_NUMERO: TStringField;
    QryClientesCLIENTE_BAIRRO: TStringField;
    QryClientesCLIENTE_CIDADE: TStringField;
    QryClientesCLIENTE_CEP: TStringField;
    QryClientesCLIENTE_UF: TStringField;
    QryClientesCLIENTE_DESCONTO_PADRAO: TFMTBCDField;
    GroupBox2: TGroupBox;
    Label11: TLabel;
    DescontoPadrao: TDBEdit;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure BtLimparPesquisaClick(Sender: TObject);
    procedure BtEditarClick(Sender: TObject);
    procedure TabCadastroShow(Sender: TObject);
    procedure DsClientesStateChange(Sender: TObject);
    procedure BtSalvarClick(Sender: TObject);
    procedure BtNovoClick(Sender: TObject);
    procedure BtExcluirClick(Sender: TObject);
    procedure BtCancelarClick(Sender: TObject);
    procedure BtAtualizarClick(Sender: TObject);
    procedure EdNomeEnter(Sender: TObject);
    procedure EdNomeExit(Sender: TObject);
    procedure EdCpfEnter(Sender: TObject);
    procedure EdCpfExit(Sender: TObject);
    procedure EdLogradouroEnter(Sender: TObject);
    procedure EdLogradouroExit(Sender: TObject);
    procedure EdNumeroEnter(Sender: TObject);
    procedure EdNumeroExit(Sender: TObject);
    procedure EdBairroEnter(Sender: TObject);
    procedure EdBairroExit(Sender: TObject);
    procedure EdCepEnter(Sender: TObject);
    procedure EdCepExit(Sender: TObject);
    procedure EdCidadeEnter(Sender: TObject);
    procedure EdCidadeExit(Sender: TObject);
    procedure EdUfEnter(Sender: TObject);
    procedure EdUfExit(Sender: TObject);
    procedure EdPesquisaEnter(Sender: TObject);
    procedure EdPesquisaExit(Sender: TObject);
    procedure BtListagemNovoClick(Sender: TObject);
    procedure BtAtualizarListagemClick(Sender: TObject);
    procedure TabListagemShow(Sender: TObject);
    procedure BtPesquisarClick(Sender: TObject);
    procedure DescontoPadraoKeyPress(Sender: TObject; var Key: Char);
    procedure DescontoPadraoEnter(Sender: TObject);
    procedure DescontoPadraoExit(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure PesquisaCliente;
  end;

var
  FClientes: TFClientes;
  SqlListagem: string;

implementation

{$R *.dfm}

uses DataModule, Principal;

procedure TFClientes.BtAtualizarClick(Sender: TObject);
begin
  if (QryClientes.State in [dsInactive]) then
    QryClientes.Open;
  QryClientes.Refresh;
end;

procedure TFClientes.BtAtualizarListagemClick(Sender: TObject);
begin
  if (QryListagem.State in [dsInactive]) then
    QryListagem.Open();
  QryListagem.Refresh;
end;

procedure TFClientes.BtCancelarClick(Sender: TObject);
begin
  if (QryClientes.State in [dsEdit]) then
    QryClientes.Cancel;
  if (QryClientes.State in [dsInsert]) then
  begin
    QryClientes.Cancel;
    PageClientes.ActivePage := TabListagem;
  end;
end;

procedure TFClientes.BtEditarClick(Sender: TObject);
begin
  if QryClientes.RecordCount > 0 then
    QryClientes.Edit;
end;

procedure TFClientes.BtExcluirClick(Sender: TObject);
begin
  if QryClientes.RecordCount > 0 then
  begin
    if (Application.MessageBox('Excluir o registro?', 'Aten��o...', MB_YESNO+MB_ICONQUESTION) = mrYes) then
    begin
      QryClientes.Delete;
      PageClientes.ActivePage := TabListagem;
    end;
  end;
end;

procedure TFClientes.BtLimparPesquisaClick(Sender: TObject);
begin
  EdPesquisa.Text := '';
  PesquisaCliente;
  EdPesquisa.SetFocus;
end;

procedure TFClientes.BtListagemNovoClick(Sender: TObject);
begin
  PageClientes.ActivePage := TabCadastro;
  BtNovo.Click;
end;

procedure TFClientes.BtNovoClick(Sender: TObject);
begin
  QryClientes.Append;
end;

procedure TFClientes.BtPesquisarClick(Sender: TObject);
begin
  PesquisaCliente;
end;

procedure TFClientes.BtSalvarClick(Sender: TObject);
  var
    QryLocal: TFDQuery;
    Codigo: Integer;
begin
  if EdNome.Text = '' then
  begin
    EdNome.SetFocus;
    Application.MessageBox('Insira um nome para o cliente.', 'Aten��o...', MB_ICONERROR);
    Abort;
  end;
  if EdCpf.Text = '' then
  begin
    EdCpf.SetFocus;
    Application.MessageBox('Insira um CPF para o cliente.', 'Aten��o...', MB_ICONERROR);
    Abort;
  end;
  if EdLogradouro.Text = '' then
  begin
    EdLogradouro.SetFocus;
    Application.MessageBox('Insira um logradouro no endere�o do cliente.', 'Aten��o...', MB_ICONERROR);
    Abort;
  end;
  if EdNumero.Text = '' then
  begin
    EdNumero.SetFocus;
    Application.MessageBox('Insira um n�mero no endere�o do cliente.', 'Aten��o...', MB_ICONERROR);
    Abort;
  end;
  if EdBairro.Text = '' then
  begin
    EdBairro.SetFocus;
    Application.MessageBox('Insira um bairro no endere�o do cliente.', 'Aten��o...', MB_ICONERROR);
    Abort;
  end;
  if EdCep.Text = '' then
  begin
    EdCep.SetFocus;
    Application.MessageBox('Insira um CEP no endere�o do cliente.', 'Aten��o...', MB_ICONERROR);
    Abort;
  end;
  if EdCidade.Text = '' then
  begin
    EdCidade.SetFocus;
    Application.MessageBox('Insira uma cidade no endere�o do cliente.', 'Aten��o...', MB_ICONERROR);
    Abort;
  end;
  if EdUF.Text = '' then
  begin
    EdUF.SetFocus;
    Application.MessageBox('Insira a sigla da UF no endere�o do cliente.', 'Aten��o...', MB_ICONERROR);
    Abort;
  end;
  if (QryClientes.State in [dsEdit]) then
    QryClientes.Post
  else
    if (QryClientes.State in [dsInsert]) then
    begin
      QryLocal := TFDQuery.Create(nil);
      with QryLocal do
      begin
        Connection  := DM.Connection;
        Transaction := DM.Transaction;
        Sql.Add('SELECT COALESCE(MAX(CLIENTE_CODIGO),0) + 1 AS CODIGO FROM CLIENTES');
        Open;
        Codigo := FindField('CODIGO').AsInteger;
        Close;
      end;
      FreeAndNil(QryLocal);
      QryClientes.FindField('CLIENTE_CODIGO').AsInteger := Codigo;
      QryClientes.Post;
    end;
end;

procedure TFClientes.DescontoPadraoEnter(Sender: TObject);
begin
  DescontoPadrao.Color := clYellow;
end;

procedure TFClientes.DescontoPadraoExit(Sender: TObject);
begin
  DescontoPadrao.Color := clWhite;
end;

procedure TFClientes.DescontoPadraoKeyPress(Sender: TObject; var Key: Char);
begin
  if not (Key in ['0'..'9']) then
    key := #0;
end;

procedure TFClientes.DBGrid1DblClick(Sender: TObject);
begin
  PageClientes.ActivePage := TabCadastro;
end;

procedure TFClientes.DsClientesStateChange(Sender: TObject);
begin
  BtSalvar.Enabled    := (QryClientes.State in [dsEdit, dsInsert]);
  BtCancelar.Enabled  := (QryClientes.State in [dsEdit, dsInsert]);
  BtNovo.Enabled      := not (QryClientes.State in [dsEdit, dsInsert]);
  BtEditar.Enabled    := not (QryClientes.State in [dsEdit, dsInsert]);
  BtExcluir.Enabled   := not (QryClientes.State in [dsEdit, dsInsert]);
  BtAtualizar.Enabled := not (QryClientes.State in [dsEdit, dsInsert]);
end;

procedure TFClientes.EdBairroEnter(Sender: TObject);
begin
  EdBairro.Color := clYellow;
end;

procedure TFClientes.EdBairroExit(Sender: TObject);
begin
  EdBairro.Color := clWhite;
end;

procedure TFClientes.EdCepEnter(Sender: TObject);
begin
  EdCep.Color := clYellow;
end;

procedure TFClientes.EdCepExit(Sender: TObject);
begin
  EdCep.Color := clWhite;
end;

procedure TFClientes.EdCidadeEnter(Sender: TObject);
begin
  EdCidade.Color := clYellow;
end;

procedure TFClientes.EdCidadeExit(Sender: TObject);
begin
  EdCidade.Color := clWhite;
end;

procedure TFClientes.EdCpfEnter(Sender: TObject);
begin
  EdCpf.Color := clYellow;
end;

procedure TFClientes.EdCpfExit(Sender: TObject);
begin
  EdCpf.Color := clWhite;
end;

procedure TFClientes.EdLogradouroEnter(Sender: TObject);
begin
  EdLogradouro.Color := clYellow;
end;

procedure TFClientes.EdLogradouroExit(Sender: TObject);
begin
  EdLogradouro.Color := clWhite;
end;

procedure TFClientes.EdNomeEnter(Sender: TObject);
begin
  EdNome.Color := clYellow;
end;

procedure TFClientes.EdNomeExit(Sender: TObject);
begin
  EdNome.Color := clWhite;
end;

procedure TFClientes.EdNumeroEnter(Sender: TObject);
begin
  EdNumero.Color := clYellow;
end;

procedure TFClientes.EdNumeroExit(Sender: TObject);
begin
  EdNumero.Color := clWhite;
end;

procedure TFClientes.EdPesquisaEnter(Sender: TObject);
begin
  EdPesquisa.Color := clYellow;
end;

procedure TFClientes.EdPesquisaExit(Sender: TObject);
begin
  EdPesquisa.Color := clWhite;
end;

procedure TFClientes.EdUfEnter(Sender: TObject);
begin
  EdUf.Color := clYellow;
end;

procedure TFClientes.EdUfExit(Sender: TObject);
begin
  EdUf.Color := clWhite;
end;

procedure TFClientes.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  QryListagem.Close;
  QryClientes.Close;
  action := caFree;
  FClientes := nil;
end;

procedure TFClientes.FormCreate(Sender: TObject);
begin
  PageClientes.ActivePage := TabListagem;
  SqlListagem := 'SELECT c.* FROM CLIENTES c ';
end;

procedure TFClientes.FormShow(Sender: TObject);
begin
  EdPesquisa.SetFocus;
  QryListagem.Open();
end;

procedure TFClientes.PesquisaCliente;
  procedure Pesquisa(Tipo: SmallInt);
  begin
    QryListagem.Close;
    QryListagem.SQL.Clear;
    case Tipo of
      0: QryListagem.SQL.Add(SqlListagem + ' WHERE c.CLIENTE_CODIGO = ' + EdPesquisa.Text + ' ORDER BY c.CLIENTE_CODIGO, c.CLIENTE_NOME');
      1: QryListagem.SQL.Add(SqlListagem + ' WHERE c.CLIENTE_NOME LIKE ' + QuotedStr('%' + EdPesquisa.Text + '%') + ' ORDER BY c.CLIENTE_CODIGO, c.CLIENTE_NOME');
      2: QryListagem.SQL.Add(SqlListagem + ' ORDER BY c.CLIENTE_CODIGO, c.CLIENTE_NOME');
    end;
    QryListagem.Open();
  end;
begin
  if EdPesquisa.Text <> '' then
  begin
      try
        Pesquisa(StrToInt(EdPesquisa.Text) * 0);
       except
        Pesquisa(1);
      end;
  end
  else
    Pesquisa(2);
end;

procedure TFClientes.TabCadastroShow(Sender: TObject);
begin
  QryClientes.Close;
  QryClientes.ParamByName('CODIGO').AsInteger := QryListagem.FindField('CLIENTE_CODIGO').AsInteger;
  QryClientes.Open;
  EdNome.SetFocus;
end;

procedure TFClientes.TabListagemShow(Sender: TObject);
begin
  if (QryListagem.State in [dsInactive]) then
    QryListagem.Open();
  QryListagem.Refresh;
  EdPesquisa.SetFocus;
end;

end.
