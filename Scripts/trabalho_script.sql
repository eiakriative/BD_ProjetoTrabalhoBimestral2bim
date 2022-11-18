#########################################################
## ALUNO: André Luiz Homan Kanashiro                   ##
## SEDE / Curso: BSI - Osório | Noite                  ##
## DISCIPLINA: BANCO DE DADOS                          ##
## PROFESSORA: Osmary Camila Bortoncello Glober (Mary) ##
## TRABALHO / PROJETO - 2 BIMESTRE                     ##
#########################################################

CREATE DATABASE Trabalho_Projeto_PRODUTOSPEDIDOS;
USE Trabalho_Projeto_PRODUTOSPEDIDOS;

-- -----------------------------------------------------
-- Tabela Cliente
-- -----------------------------------------------------
DROP TABLE Cliente;
CREATE TABLE IF NOT EXISTS Cliente (
  codigo INT NOT NULL AUTO_INCREMENT,
  nome VARCHAR(255) NOT NULL,
  telefone CHAR(11) NOT NULL,
  cpf CHAR(11) NOT NULL,
  PRIMARY KEY (codigo)
);

insert into Cliente (nome, telefone, cpf) values 
("José", "99999999999", "98765888888"),
("Maria", "98765499999", "98765888888"),
("Hugo", "99876349999", "98765888761"),
("Matheus", "99939333999", "98765888333"),
("Joel", "43299999999", "98765882228");

insert into Cliente (nome, telefone, cpf) values 
("Alvaro", "43299999999", "45665882228");

select * from Cliente;


-- -----------------------------------------------------
-- Tabela Pedido
-- -----------------------------------------------------

DROP TABLE Pedido;

CREATE TABLE Pedido (
  codigo INT NOT NULL AUTO_INCREMENT,
  codigo_cliente INT NOT NULL,
  data_hora DATETIME NOT NULL,
  status CHAR(1) NOT NULL,
  PRIMARY KEY (codigo),
  FOREIGN KEY (codigo_cliente) REFERENCES Cliente (codigo)
);

insert into Pedido (codigo_cliente, data_hora, status) values 
(1, "2022-03-22: 17:00", "A"),
(2, "2022-02-07: 15:00", "P"),
(3, "2022-01-01: 10:00", "F"),
(4, "2022-01-01: 9:00", "F"),
(5, "2022-01-01: 10:00", "P");

insert into Pedido (codigo_cliente, data_hora, status) values 
(6, "2022-01-01: 10:00", "A");

select * from Pedido;

-- -----------------------------------------------------
-- Tabela Categoria
-- -----------------------------------------------------
DROP TABLE Categoria;

CREATE TABLE Categoria (
  codigo INT NOT NULL auto_increment,
  nome VARCHAR(255) NOT NULL,	
  descricao VARCHAR(255) NOT NULL,
  PRIMARY KEY (codigo)
);

insert into Categoria (nome, descricao) values 
("Camiseta", "Vestimenta para não ficar com frio ou com calor dependendo do material"),
("Tenis", "Para não ficas descalço em lugares que podemos nos machucar ou até não ficar descalço e cançar os pés"),
("Calça", "Vestimentas para não sentir frio"),
("Chapéu", "Proteger a cuca"),
("Oculus escuro", "Proteger do sol");

select * from Categoria;

-- -----------------------------------------------------
-- Tabela Produto
-- -----------------------------------------------------
DROP TABLE Produto;
CREATE TABLE Produto (
  codigo INT NOT NULL auto_increment,
  codigo_categoria INT NOT NULL,
  preco DOUBLE NOT NULL,
  nome VARCHAR(255) NULL,
  PRIMARY KEY (codigo),
  FOREIGN KEY (codigo_categoria) REFERENCES Categoria (codigo)
);

insert into Produto (codigo_categoria, preco, nome) values 
(1, 129.99, "Camiseta Nike Breathe Masculina"),
(2, 1099.99, "Camiseta Nike Breathe Masculina"),
(3, 499.99, "Calça Nike Sportswear Masculina"),
(4, 199.99, "Chapéu Nike Unissex"),
(5, 799.99, "New Aviator");

insert into Produto (codigo_categoria, preco, nome) values 
(1, 129.99, "Camiseta Nike Breathe Feminina");

select * from Produto;

-- -----------------------------------------------------
-- Tabela Item_Pedido
-- -----------------------------------------------------
DROP TABLE Item_Pedido;
CREATE TABLE Item_Pedido (
  qtde INT NOT NULL,
  codigo_pedido INT NOT NULL,
  codigo_produto INT NOT NULL,
  FOREIGN KEY (codigo_pedido) REFERENCES Pedido (codigo),
  FOREIGN KEY (codigo_produto) REFERENCES Produto (codigo)
);

insert into Item_Pedido (qtde, codigo_pedido, codigo_produto) values 
(15, 1, 1),
(12, 2, 2),
(11, 3, 3),
(8, 4, 4),
(7, 5, 5);

insert into Item_Pedido (qtde, codigo_pedido, codigo_produto) values 
(2, 6, 1);


select * from Item_Pedido;

-- -------------------------------------------------------------
--  Liste os todos os pedidos (todas as colunas) feitos 
--  pelos clientes (cpf e nome) ordenando pelo cpf do cliente.
-- -------------------------------------------------------------

SELECT Cliente.nome, Cliente.cpf, Pedido.codigo, Pedido.data_hora, Pedido.status
FROM Cliente, Pedido
WHERE Cliente.cpf
ORDER BY Cliente.cpf;

-- -------------------------------------------------------------
-- Liste o código, status e data_hora dos pedidos feitos 
-- entre 01/01/2022 e 20/11/2022 (Utilize o comando BETWEEN).pf do cliente.
-- -------------------------------------------------------------

SELECT p.codigo, p.status, p.data_hora
FROM Pedido p
WHERE data_hora between '2022-01-01' and '2024-11-20';
-- -------------------------------------------------------------
-- Liste cpf (cliente), nome(cliente), codigo (pedido), data_hora (pedido), 
-- preco_total de todos os pedidos com status = 'A' (Utilize o GROUP BY 
-- e SUM). Ordenar por nome do cliente.
-- -------------------------------------------------------------

SELECT c.cpf, c.nome, p.codigo, 
        p.data_hora, i.qtde, 
		pro.preco,
	   SUM(i.qtde * pro.preco ) as preco_total
FROM Cliente c, Pedido p, Item_Pedido i, Produto pro
WHERE c.cpf AND p.codigo AND i.codigo_produto = pro.codigo
GROUP BY p.status = "A";
 
-- -------------------------------------------------------------
-- Liste o produto mais caro e mais barato. 
-- -------------------------------------------------------------
select  max(pro.preco) as preco_totalMAX, min((pro.preco)) as preco_totalMIN
from Cliente c, Pedido p, 
     Item_Pedido i, 
	 Produto pro
where p.codigo = c.codigo
and i.codigo_produto = pro.codigo
and p.data_hora between '2022-01-01' and '2022-12-31';

-- -------------------------------------------------------------
-- Liste o preço médio dos pedidos com status = 'F'.
-- -------------------------------------------------------------

SELECT p.status, AVG(pro.preco) AS preco_media 
FROM Produto pro, Pedido p
WHERE p.status="F"
GROUP BY status;

-- -------------------------------------------------------------
-- Liste os pedidos que não tenham status igual a ‘F’.
-- -------------------------------------------------------------

select * from Pedido where status not in ('F');

-- -------------------------------------------------------------
-- – Liste o preço médio dos produtos por categoria (nome).
-- -------------------------------------------------------------

SELECT cat.nome, AVG(pro.preco) AS preco_media 
FROM Categoria cat, Produto pro
GROUP BY cat.nome;

-- -------------------------------------------------------------
-- Lista uma contagem de pedidos de todos os clientes que 
-- pediram mais de 5 produtos em um mesmo pedido e o preço total
-- de seus pedidos. 
-- -------------------------------------------------------------

SELECT p.codigo, i.qtde
FROM Cliente c, Pedido p, Item_Pedido i
WHERE p.codigo
AND i.qtde >= 5 ORDER BY codigo ASC;

-- -------------------------------------------------------------
-- Adicione uma coluna desconto do tipo double e não nula na 
-- tabela produto. Coloque descontos de 0.25, 0.30 e 0.5
-- para alguns produtos.
-- -------------------------------------------------------------

Alter table Produto add column desconto double not null;

insert into () values ();

-- -------------------------------------------------------------
-- – Liste o preço dos produtos com os descontos 
-- Valor do desconto por cada produto e igual ao preço do produto vezes (*) o valor do desconto (0.25, 0.30, etc)
-- Preço do produto com o desconto = (preço do produto – (preço do produto * desconto)).
-- -------------------------------------------------------------

SELECT pro.nome, pro.preco, ( preco * 0.25 ) as desconto
FROM Produto pro 
WHERE pro.codigo = 1;

SELECT pro.nome, pro.preco, ( preco * 0.30 ) as desconto
FROM Produto pro
WHERE pro.codigo = 1;

SELECT pro.nome, pro.preco, ( preco * 0.5 ) as desconto
FROM Produto pro
WHERE pro.codigo = 1;
