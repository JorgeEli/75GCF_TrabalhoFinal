program Git;

uses
  Vcl.Forms,
  Principal in 'Principal.pas' {FPrincipal},
  DataModule in 'DataModule.pas' {DM: TDataModule},
  Produtos in 'Produtos.pas' {FProdutos},
  Fornecedores in 'Fornecedores.pas' {FFornecedor},
  Clientes in 'Clientes.pas' {FClientes},
  Pedidos in 'Pedidos.pas' {FPedidos};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TDM, DM);
  Application.CreateForm(TFPrincipal, FPrincipal);
  Application.CreateForm(TFClientes, FClientes);
  Application.CreateForm(TFPedidos, FPedidos);
  Application.Run;
end.
