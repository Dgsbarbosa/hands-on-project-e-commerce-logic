# E-commerce Database Project

## Descrição
Este projeto consiste na modelagem e implementação de um banco de dados para um sistema de e-commerce. O objetivo é criar uma estrutura eficiente para armazenar informações sobre clientes, produtos, pedidos, pagamentos, entregas, fornecedores e vendedores. A modelagem inclui a definição de chaves primárias e estrangeiras, bem como a aplicação de constraints adequadas.

## Estrutura do Banco de Dados
O banco de dados foi modelado com as seguintes entidades principais:
- **Cliente**: Representa tanto clientes pessoa física (PF) quanto pessoa jurídica (PJ), garantindo que uma conta não possua ambas as informações simultaneamente.
- **Produto**: Contém detalhes dos produtos disponíveis no sistema, associados aos vendedores.
- **Fornecedor**: Armazena informações sobre fornecedores dos produtos.
- **Pedido**: Registra os pedidos realizados pelos clientes, incluindo status e valor do frete.
- **Estoque**: Mantém o controle de quantidade de produtos disponíveis.
- **Forma de Pagamento**: Permite que clientes cadastrem múltiplas formas de pagamento.
- **Entrega**: Guarda informações sobre status de entrega e código de rastreio.
- **Vendedor**: Representa os vendedores responsáveis pelos produtos na plataforma.
- **Relacionamentos**: Inclui tabelas intermediárias para representar as associações entre produtos, pedidos, fornecedores e estoque.

## Queries Implementadas
Para testar e manipular os dados do banco, foram implementadas diversas consultas SQL, incluindo:
1. Recuperação de dados com `SELECT`.
2. Filtragem de informações com `WHERE`.
3. Geração de atributos derivados.
4. Ordenação de dados com `ORDER BY`.
5. Agrupamento e filtragem de grupos com `HAVING`.
6. Junções entre tabelas para fornecer insights mais complexos.

## Exemplos de Perguntas Respondidas pelas Queries
- Quantos pedidos foram feitos por cada cliente?
- Algum vendedor também é fornecedor?
- Relação de produtos, fornecedores e estoques.
- Relação de nomes dos fornecedores e produtos fornecidos.

## Requisitos Técnicos
- **Banco de Dados:** MySQL
- **Ferramenta de Modelagem:** MySQL Workbench

## Como Executar
1. Clone este repositório.
2. Execute o script SQL fornecido para criar o esquema do banco.
3. Popule as tabelas com dados para testes.
4. Execute as queries fornecidas para análise dos dados.

## Contribuição
Se desejar contribuir com melhorias, sinta-se à vontade para abrir uma issue ou enviar um pull request!

## Autor
Douglas Alexandre Barbosa

