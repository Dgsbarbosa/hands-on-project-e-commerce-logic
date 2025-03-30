-- Criação do banco de dados
CREATE DATABASE ecommerce;
USE ecommerce;

-- Tabela Cliente
CREATE TABLE Cliente (
    idCliente INT PRIMARY KEY AUTO_INCREMENT,
    Nome VARCHAR(255) NOT NULL,
    Email VARCHAR(255) UNIQUE NOT NULL,
    Telefone VARCHAR(20),
    Tipo ENUM('PJ', 'PF') NOT NULL,
    CPF_CNPJ VARCHAR(20) UNIQUE NOT NULL
);

-- Tabela Forma de Pagamento
CREATE TABLE FormaPagamento (
    idFormaPagamento INT PRIMARY KEY AUTO_INCREMENT,
    Descricao VARCHAR(100) NOT NULL
);

-- Tabela Cliente_FormaPagamento (Relacionamento N para N entre Cliente e Forma de Pagamento)
CREATE TABLE Cliente_FormaPagamento (
    Cliente_idCliente INT,
    FormaPagamento_idFormaPagamento INT,
    PRIMARY KEY (Cliente_idCliente, FormaPagamento_idFormaPagamento),
    FOREIGN KEY (Cliente_idCliente) REFERENCES Cliente(idCliente),
    FOREIGN KEY (FormaPagamento_idFormaPagamento) REFERENCES FormaPagamento(idFormaPagamento)
);

-- Tabela Pedido
CREATE TABLE Pedido (
    idPedido INT PRIMARY KEY AUTO_INCREMENT,
    Cliente_idCliente INT,
    DataPedido DATETIME DEFAULT CURRENT_TIMESTAMP,
    StatusEntrega ENUM('Pendente', 'Enviado', 'Entregue', 'Cancelado') NOT NULL,
    CodigoRastreamento VARCHAR(50) NULL,
    FOREIGN KEY (Cliente_idCliente) REFERENCES Cliente(idCliente)
);

-- Tabela Vendedor
CREATE TABLE Vendedor (
    idVendedor INT PRIMARY KEY AUTO_INCREMENT,
    RazaoSocial VARCHAR(255) NOT NULL,
    Email VARCHAR(255) UNIQUE NOT NULL,
    Telefone VARCHAR(20)
);

-- Tabela Fornecedor
CREATE TABLE Fornecedor (
    idFornecedor INT PRIMARY KEY AUTO_INCREMENT,
    RazaoSocial VARCHAR(255) NOT NULL,
    Email VARCHAR(255) UNIQUE NOT NULL,
    Telefone VARCHAR(20)
);

-- Tabela Produto
CREATE TABLE Produto (
    idProduto INT PRIMARY KEY AUTO_INCREMENT,
    Descricao VARCHAR(255) NOT NULL,
    Preco DECIMAL(10,2) NOT NULL,
    Estoque INT NOT NULL DEFAULT 0,
    Vendedor_idVendedor INT NOT NULL,
    FOREIGN KEY (Vendedor_idVendedor) REFERENCES Vendedor(idVendedor)
);

-- Tabela Fornecedor disponibiliza Produto (Relacionamento N para N entre Fornecedor e Produto)
CREATE TABLE Fornecedor_Produto (
    Fornecedor_idFornecedor INT,
    Produto_idProduto INT,
    PRIMARY KEY (Fornecedor_idFornecedor, Produto_idProduto),
    FOREIGN KEY (Fornecedor_idFornecedor) REFERENCES Fornecedor(idFornecedor),
    FOREIGN KEY (Produto_idProduto) REFERENCES Produto(idProduto)
);

-- Tabela Estoque
CREATE TABLE Estoque (
    idEstoque INT PRIMARY KEY AUTO_INCREMENT,
    Localizacao VARCHAR(255) NOT NULL,
    Quantidade INT NOT NULL DEFAULT 0
);

-- Tabela Produto_has_Estoque (Relacionamento entre Produto e Estoque)
CREATE TABLE Produto_has_Estoque (
    Produto_idProduto INT,
    Estoque_idEstoque INT,
    PRIMARY KEY (Produto_idProduto, Estoque_idEstoque),
    FOREIGN KEY (Produto_idProduto) REFERENCES Produto(idProduto),
    FOREIGN KEY (Estoque_idEstoque) REFERENCES Estoque(idEstoque)
);

-- Tabela Pedido_Produto (Relacionamento entre Pedido e Produto)
CREATE TABLE Pedido_Produto (
    Pedido_idPedido INT,
    Produto_idProduto INT,
    Quantidade INT NOT NULL,
    PrecoUnitario DECIMAL(10,2) NOT NULL,
    PRIMARY KEY (Pedido_idPedido, Produto_idProduto),
    FOREIGN KEY (Pedido_idPedido) REFERENCES Pedido(idPedido),
    FOREIGN KEY (Produto_idProduto) REFERENCES Produto(idProduto)
);

-- Consultas SQL

-- 1. Quantos pedidos foram feitos por cada cliente?
SELECT c.idCliente, c.Nome, COUNT(p.idPedido) AS total_pedidos
FROM Cliente c
LEFT JOIN Pedido p ON c.idCliente = p.Cliente_idCliente
GROUP BY c.idCliente, c.Nome;

-- 2. Algum vendedor também é fornecedor?
SELECT v.idVendedor, v.RazaoSocial
FROM Vendedor v
INNER JOIN Fornecedor f ON v.RazaoSocial = f.RazaoSocial;

-- 3. Relação de produtos, fornecedores e estoques
SELECT p.idProduto, p.Descricao, f.RazaoSocial AS Fornecedor, e.Quantidade
FROM Produto p
JOIN Fornecedor_Produto fp ON p.idProduto = fp.Produto_idProduto
JOIN Fornecedor f ON fp.Fornecedor_idFornecedor = f.idFornecedor
JOIN Produto_has_Estoque pe ON p.idProduto = pe.Produto_idProduto
JOIN Estoque e ON pe.Estoque_idEstoque = e.idEstoque;

-- 4. Relação de nomes dos fornecedores e nomes dos produtos
SELECT f.RazaoSocial, p.Descricao
FROM Fornecedor f
JOIN Fornecedor_Produto fp ON f.idFornecedor = fp.Fornecedor_idFornecedor
JOIN Produto p ON fp.Produto_idProduto = p.idProduto;
