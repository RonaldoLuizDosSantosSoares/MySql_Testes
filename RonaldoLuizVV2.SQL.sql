-- FEITO E COMPILADO EM MYSQL

-- TABELAS

CREATE TABLE VENDEDOR (
  cd_vendedor int NOT NULL,
  nm_vendedor varchar(40),
  ds_endereco varchar(40),
  cd_cpf decimal(11),
  nm_cidade varchar(20),
  nm_bairro varchar(20),
  sg_estado char(2),
  cd_telefone varchar(20),
  ds_email varchar(80)
);

CREATE TABLE COMPRADOR (
  cd_comprador int NOT NULL,
  nm_comprador varchar(40),
  ds_endereco varchar(40),
  cd_cpf decimal(11),
  nm_cidade varchar(20),
  nm_bairro varchar(20),
  sg_estado char(2),
  cd_telefone varchar(20),
  ds_email varchar(80)
);

CREATE TABLE OFERTA (
  cd_comprador int,
  cd_imovel int,
  vl_oferta decimal,
  dt_oferta date
);

CREATE TABLE IMOVEL (
  cd_imovel int NOT NULL,
  cd_vendedor int,
  cd_bairro int,
  cd_cidade int,
  sg_estado char(2),
  ds_endereco varchar(40),
  qt_areautil decimal(10,2),
  qt_areatotal decimal(10,2),
  ds_imovel varchar(300),
  vl_preco decimal,
  qt_ofertas int,
  ic_vendido char(1),
  dt_lancto date,
  qt_imovelindicado int
);

CREATE TABLE ESTADO (
  sg_estado char (2) NOT NULL,
  nm_estado varchar(20)
);

CREATE TABLE CIDADE (
  cd_cidade int NOT NULL,
  nm_cidade varchar(20),
  sg_estado char(2) NOT NULL
);

CREATE TABLE BAIRRO (
  cd_bairro int NOT NULL,
  nm_bairro varchar(20),
  cd_cidade int NOT NULL,
  sg_estado char(2) NOT NULL
);

CREATE TABLE FAIXA_IMOVEL (
  cd_faixa int NOT NULL,
  nm_faixa varchar(30),
  vl_maximo decimal,
  vl_minimo decimal
);

-- FUNÇÃO ALTER

-- VENDEDOR
ALTER TABLE VENDEDOR ADD PRIMARY KEY (cd_vendedor);

-- COMPRADOR
ALTER TABLE COMPRADOR ADD PRIMARY KEY (cd_comprador);

-- IMOVEL
ALTER TABLE IMOVEL ADD PRIMARY KEY (cd_imovel);

-- OFERTA
ALTER TABLE OFERTA ADD FOREIGN KEY (cd_comprador) REFERENCES COMPRADOR (cd_comprador);
ALTER TABLE OFERTA ADD FOREIGN KEY (cd_imovel) REFERENCES IMOVEL (cd_imovel);

-- FAIXA_IMOVEL
ALTER TABLE FAIXA_IMOVEL ADD PRIMARY KEY (cd_faixa);

-- ESTADO
ALTER TABLE ESTADO ADD PRIMARY KEY (sg_estado);

-- CIDADE
ALTER TABLE CIDADE ADD PRIMARY KEY (cd_cidade, sg_estado);

-- BAIRRO
ALTER TABLE BAIRRO ADD PRIMARY KEY (cd_bairro, cd_cidade, sg_estado);

-- FUNÇÃO INSERT

-- BAIRRO
INSERT INTO ESTADO VALUES ('SP','SÃO PAULO');
INSERT INTO ESTADO VALUES ('RJ','RIO DE JANEIRO');

-- CIDADE
INSERT INTO CIDADE VALUES (1,'SÃO PAULO','SP');
INSERT INTO CIDADE VALUES (2,'SANTO ANDRÉ','SP');
INSERT INTO CIDADE VALUES (3,'CAMPINAS','SP');
INSERT INTO CIDADE VALUES (1,'RIO DE JANEIRO','RJ');
INSERT INTO CIDADE VALUES (2,'NITEROI','RJ');

-- BAIRRO
INSERT INTO BAIRRO VALUES (1,'JARDINS',1,'SP');
INSERT INTO BAIRRO VALUES (2,'MORUMBI',1,'SP');
INSERT INTO BAIRRO VALUES (3,'AEROPORTO',1,'SP');
INSERT INTO BAIRRO VALUES (1,'AEROPORTO',1,'RJ');
INSERT INTO BAIRRO VALUES (2,'NITEROI',2,'RJ');

-- VENDEDOR
INSERT INTO VENDEDOR (cd_vendedor,nm_vendedor,ds_endereco,ds_email) VALUES (1,'MARIA DA SILVA','RUA DO GRITO, 45', 'msilva@nova.com');
INSERT INTO VENDEDOR (cd_vendedor,nm_vendedor,ds_endereco,ds_email) VALUES (2,'MARCO ANDRADE','AV. DA SAUDADE,325','mandrade@nova.com');
INSERT INTO VENDEDOR (cd_vendedor,nm_vendedor,ds_endereco,ds_email) VALUES (3,'ANDRÉ CARDOSO','AV. BRASIL, 401','acardoso@nova.com');
INSERT INTO VENDEDOR (cd_vendedor,nm_vendedor,ds_endereco,ds_email) VALUES (4,'TATIANA SOUZA','RUA DO IMPERADOR, 778','tsouza@nova.com');

-- IMOVEL
INSERT INTO IMOVEL (cd_imovel,cd_vendedor,cd_bairro,cd_cidade,sg_estado,ds_endereco,qt_areautil,qt_areatotal,vl_preco) VALUES (1,1,1,1,'SP','AL. TIETE, 3304/101',250,400,180000);
INSERT INTO IMOVEL (cd_imovel,cd_vendedor,cd_bairro,cd_cidade,sg_estado,ds_endereco,qt_areautil,qt_areatotal,vl_preco) VALUES (2,1,2,1,'SP','AV. MORUMBI, 2230',150,250,135000);
INSERT INTO IMOVEL (cd_imovel,cd_vendedor,cd_bairro,cd_cidade,sg_estado,ds_endereco,qt_areautil,qt_areatotal,vl_preco) VALUES (3,2,1,1,'RJ','R. GAL. OSORIO, 445/34',250,400,185000);
INSERT INTO IMOVEL (cd_imovel,cd_vendedor,cd_bairro,cd_cidade,sg_estado,ds_endereco,qt_areautil,qt_areatotal,vl_preco) VALUES (4,2,2,2,'RJ','R. D. PEDRO I, 882',120,200,110000);
INSERT INTO IMOVEL (cd_imovel,cd_vendedor,cd_bairro,cd_cidade,sg_estado,ds_endereco,qt_areautil,qt_areatotal,vl_preco) VALUES (5,3,3,1,'SP','AV. RUBEN BERTA, 2355',110,200,95000);
INSERT INTO IMOVEL (cd_imovel,cd_vendedor,cd_bairro,cd_cidade,sg_estado,ds_endereco,qt_areautil,qt_areatotal,vl_preco) VALUES (6,4,1,1,'RJ','R. GETULIO VARGAS, 552',200,300,99000);

-- COMPRADOR
INSERT INTO COMPRADOR (cd_comprador,nm_comprador,ds_endereco,ds_email) VALUES (1,'EMMANUEL ANTUNES', 'R. SARAIVA, 452','eantunes@nova.com');
INSERT INTO COMPRADOR (cd_comprador,nm_comprador,ds_endereco,ds_email) VALUES (2,'JOANA PEREIRA','AV PORTUGAL,52','jpereira@nova.com');
INSERT INTO COMPRADOR (cd_comprador,nm_comprador,ds_endereco,ds_email) VALUES (3,'RONALDO CAMPELO','R. ESTADOS UNIDOS,13','rcampelo@nova.com');
INSERT INTO COMPRADOR (cd_comprador,nm_comprador,ds_endereco,ds_email) VALUES (4,'MANFRED AUGUSTO','AV. BRASIL,351','maugusto@nova.com');

-- OFERTA
INSERT INTO OFERTA VALUES(1,1,170000,'10/01/09');
INSERT INTO OFERTA VALUES(1,3,180000,'10/01/09');
INSERT INTO OFERTA VALUES(2,2,135000,'15/01/09');
INSERT INTO OFERTA VALUES(2,4,100000,'15/02/09');
INSERT INTO OFERTA VALUES(3,1,160000,'05/01/09');
INSERT INTO OFERTA VALUES(3,2,140000,'20/02/09');

-- FUNÇÃO UPDATE

-- 8
UPDATE IMOVEL SET vl_preco = vl_preco + vl_preco * 0.1;

-- 9
UPDATE IMOVEL SET vl_preco = vl_preco - vl_preco * 0.5 WHERE cd_vendedor = 1;

-- 10
UPDATE OFERTA SET vl_oferta = vl_oferta + vl_oferta * 0.05 WHERE cd_comprador = 2;

-- 11
UPDATE COMPRADOR SET ds_endereco = 'R. ANANÁS, 45', sg_estado = 'RJ' WHERE cd_comprador = 3;

-- 12
UPDATE OFERTA SET vl_oferta = 101000 WHERE cd_comprador = 2 AND cd_imovel = 4;

-- 13
DELETE FROM OFERTA WHERE cd_comprador = 3 AND cd_imovel = 1;

-- 14
DELETE FROM CIDADE WHERE cd_cidade = 3 AND sg_estado = 'SP';

-- 15
INSERT INTO FAIXA_IMOVEL VALUES(1,'BAIXO',0,105000);
INSERT INTO FAIXA_IMOVEL VALUES(2,'MÉDIO',105001,180000);
INSERT INTO FAIXA_IMOVEL VALUES(3,'ALTO',180001,999999);


-- FUNÇÃO SELECT

SELECT * FROM FAIXA_IMOVEL;