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
CREATE TABLE IF NOT EXISTS Cliente (
  codigo INT NOT NULL AUTO_INCREMENT,
  nome VARCHAR(255) NOT NULL,
  telefone CHAR(11) NOT NULL,
  cpf CHAR(11) NOT NULL,
  PRIMARY KEY (codigo)
);

-- -----------------------------------------------------
-- Tabela Pedido
-- -----------------------------------------------------
CREATE TABLE Pedido (
  codigo INT NOT NULL AUTO_INCREMENT,
  codigo_cliente INT NOT NULL,
  data_hora DATETIME NOT NULL,
  status CHAR(1) NOT NULL,
  PRIMARY KEY (codigo),
  FOREIGN KEY (codigo_cliente) REFERENCES Cliente (codigo)
);

-- -----------------------------------------------------
-- Tabela Categoria
-- -----------------------------------------------------
CREATE TABLE Categoria (
  codigo INT NOT NULL auto_increment,
  descricao VARCHAR(255) NOT NULL,
  PRIMARY KEY (codigo)
);

-- -----------------------------------------------------
-- Tabela Produto
-- -----------------------------------------------------
CREATE TABLE Produto (
  codigo INT NOT NULL auto_increment,
  codigo_categoria INT NOT NULL,
  preco DOUBLE NOT NULL,
  nome VARCHAR(255) NULL,
  PRIMARY KEY (codigo),
  FOREIGN KEY (codigo_categoria) REFERENCES Categoria (codigo)
);

-- -----------------------------------------------------
-- Tabela Item_Pedido
-- -----------------------------------------------------
CREATE TABLE Item_Pedido (
  qtde INT NOT NULL,
  codigo_pedido INT NOT NULL,
  codigo_produto INT NOT NULL,
  FOREIGN KEY (codigo_pedido) REFERENCES Pedido (codigo),
  FOREIGN KEY (codigo_produto) REFERENCES Produto (codigo)
);

insert into Cliente (nome, telefone, cpf) values 
("José", "99999999999", "98765888888"),
("Maria", "98765499999", "98765888888"),
("Hugo", "99876349999", "98765888761"),
("Matheus", "99939333999", "98765888333"),
("Joel", "43299999999", "98765882228");

insert into Cliente (data_hora, status, codigo_cliente) values 
("", "A", 1);

select * from Cliente;
select * from Produto;
select * from Categoria;
select * from Item_Pedido;
select * from Pedido;