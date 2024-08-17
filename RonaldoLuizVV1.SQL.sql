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
  sg_estado char(2),
  nm_cidade varchar(20)
);

CREATE TABLE BAIRRO (
  cd_bairro int NOT NULL,
  cd_cidade int,
  sg_estado char(2),
  nm_bairro varchar(20)
);

CREATE TABLE FAIXA_IMOVEL (
  cd_faixa int NOT NULL,
  nm_faixa varchar(30),
  vl_maximo decimal,
  vl_minimo decimal
);

-- ALTER

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
ALTER TABLE CIDADE ADD PRIMARY KEY (cd_cidade);
ALTER TABLE CIDADE ADD FOREIGN KEY (sg_estado) REFERENCES ESTADO (sg_estado);

-- BAIRRO
ALTER TABLE BAIRRO ADD PRIMARY KEY (cd_bairro);
ALTER TABLE BAIRRO ADD FOREIGN KEY (cd_cidade) REFERENCES CIDADE (cd_cidade);

-- SELECT

SELECT * FROM VENDEDOR;