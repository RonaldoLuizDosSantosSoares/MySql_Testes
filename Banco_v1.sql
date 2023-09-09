create table vendedor (
cd_vendedor int NOT NULL,
nm_vendedor varchar(40) DEFAULT NULL,
ds_endereco varchar(40) DEFAULT NULL,
cd_cpf decimal(11),
nm_cidade varchar(20) DEFAULT NULL,
nm_bairro varchar(20) DEFAULT NULL,
sg_estado char(2) DEFAULT NULL,
cd_telefone varchar(20) DEFAULT NULL,
ds_email varchar(80) DEFAULT NULL
);

ALTER TABLE vendedor
ADD CONSTRAINT PK_vendedor PRIMARY KEY (cd_vendedor);

create table estado (
sg_estado char(2) NOT NULL,
nm_estado varchar(20) DEFAULT NULL
);

ALTER TABLE estado
ADD CONSTRAINT PK_estado PRIMARY KEY (sg_estado);

create table cidade (
cd_cidade int NOT NULL,
nm_cidade varchar(20) DEFAULT NULL,
sg_estado char(2) NOT NULL
);

ALTER TABLE cidade
ADD CONSTRAINT PK_cidade PRIMARY KEY (cd_cidade,sg_estado);


create table bairro (
cd_bairro int NOT NULL,
nm_bairro varchar(20) DEFAULT NULL,
cd_cidade int NOT NULL,
sg_estado char(2) NOT NULL
);

ALTER TABLE bairro
ADD CONSTRAINT PK_bairro PRIMARY KEY (cd_bairro,cd_cidade,sg_estado);


create table faixa_imovel (
cd_faixa int NOT NULL,
nm_faixa varchar(30) DEFAULT NULL,
vl_maximo decimal(10,2),
vl_minimo decimal(10,2)
);

ALTER TABLE faixa_imovel
ADD CONSTRAINT PK_faixa_imovel PRIMARY KEY (cd_faixa);

create table comprador (
cd_comprador int NOT NULL,
nm_comprador varchar(40) DEFAULT NULL,
ds_endereco varchar(40) DEFAULT NULL,
nm_cidade varchar(20) DEFAULT NULL,
nm_bairro varchar(20) DEFAULT NULL,
sg_estado varchar(2) DEFAULT NULL,
cd_telefone varchar(20) DEFAULT NULL,
ds_email varchar(80) DEFAULT NULL,
cd_cpf decimal(11)
);

ALTER TABLE comprador
ADD CONSTRAINT PK_comprador PRIMARY KEY (cd_comprador);

create table imovel (
cd_imovel int NOT NULL,
cd_vendedor int NOT NULL,
cd_bairro int NOT NULL,
cd_cidade int NOT NULL,
sg_estado char(2) DEFAULT NULL,
ds_endereco varchar(40) DEFAULT NULL,
qt_areautil decimal(10,2) NOT NULL,
qt_areatotal decimal(10,2) NOT NULL,
ds_imovel varchar(300) DEFAULT NULL,
vl_preco decimal (10,2),
qt_ofertas int,
ic_vendido char(1) DEFAULT NULL,
dt_lancto date DEFAULT NULL,
qt_imovelindicado int
);

ALTER TABLE imovel
ADD CONSTRAINT PK_imovel PRIMARY KEY (cd_imovel);

create table oferta (
cd_comprador int NOT NULL,
cd_imovel int NOT NULL,
vl_oferta decimal (10,2),
dt_oferta date DEFAULT NULL
);

ALTER TABLE cidade
ADD CONSTRAINT FK_sg_estado FOREIGN KEY (sg_estado) REFERENCES estado (sg_estado);

ALTER TABLE bairro
ADD CONSTRAINT FK_cd_cidade FOREIGN KEY(cd_cidade,sg_estado) REFERENCES cidade(cd_cidade,sg_estado);

ALTER TABLE oferta
ADD CONSTRAINT FK_oferta_imovel FOREIGN KEY (cd_imovel) REFERENCES imovel (cd_imovel);

ALTER TABLE oferta
ADD CONSTRAINT FK_oferta_comprador FOREIGN KEY (cd_comprador) REFERENCES comprador (cd_comprador);

insert into estado(sg_estado, nm_estado) values ('SP','SÃO PAULO');
insert into estado(sg_estado, nm_estado) values ('RJ','RIO DE JANEIRO');

insert into cidade(cd_cidade, nm_cidade, sg_estado) values (1,'SÃO PAULO','SP');
insert into cidade(cd_cidade, nm_cidade, sg_estado) values (2,'SANTO ANDRÉ','SP');
insert into cidade(cd_cidade, nm_cidade, sg_estado) values (3,'CAMPINAS','SP');
insert into cidade(cd_cidade, nm_cidade, sg_estado) values (1,'RIO DE JANEIRO','RJ');
insert into cidade(cd_cidade, nm_cidade, sg_estado) values (2,'NITEROI', 'RJ');

insert into bairro(cd_bairro, nm_bairro, cd_cidade, sg_estado) values (1,'JARDINS',1,'SP');
insert into bairro(cd_bairro, nm_bairro, cd_cidade, sg_estado) values (2,'MORUMBI',1,'SP');
insert into bairro(cd_bairro, nm_bairro, cd_cidade, sg_estado) values (3,'AEROPORTO',1,'SP');
insert into bairro(cd_bairro, nm_bairro, cd_cidade, sg_estado) values (1,'AEROPORTO',1,'RJ');
insert into bairro(cd_bairro, nm_bairro, cd_cidade, sg_estado) values (2,'NITEROI',2,'SP');

insert into vendedor(cd_vendedor, nm_vendedor, ds_endereco, ds_email) values (1,'MARIA DA SILVA','RUA DO GRITO,45','msilva@nova.com');
insert into vendedor(cd_vendedor, nm_vendedor, ds_endereco, ds_email) values (2,'MARIA DA SILVA','AV. DA SAUDADE,325','mandrade@nova.com');
insert into vendedor(cd_vendedor, nm_vendedor, ds_endereco, ds_email) values (3,'ANDRÉ CARDOSO','AV. BRASIL,401','acardoso@nova.com');
insert into vendedor(cd_vendedor, nm_vendedor, ds_endereco, ds_email) values (4,'TATIANA SOUZA','RUA DO IMPERADOR,778','tsouza@nova.com');

insert into imovel(cd_imovel, cd_vendedor, cd_bairro, cd_cidade, sg_estado, ds_endereco, qt_areautil, qt_areatotal, vl_preco) values (1, 1, 1, 1,'SP','AL. TIETE, 3304/101', 250, 400, 180000);
insert into imovel(cd_imovel, cd_vendedor, cd_bairro, cd_cidade, sg_estado, ds_endereco, qt_areautil, qt_areatotal, vl_preco) values (2, 1, 2, 1,'SP','AV. MORUMBI, 2230', 150, 250, 135000);
insert into imovel(cd_imovel, cd_vendedor, cd_bairro, cd_cidade, sg_estado, ds_endereco, qt_areautil, qt_areatotal, vl_preco) values (3, 2, 1, 1,'RJ','R. GAL. OSORIO, 445/34', 250, 400, 185000);
insert into imovel(cd_imovel, cd_vendedor, cd_bairro, cd_cidade, sg_estado, ds_endereco, qt_areautil, qt_areatotal, vl_preco) values (4, 2, 2, 2,'RJ','R. D. PEDRO I, 882', 120, 200, 110000);
insert into imovel(cd_imovel, cd_vendedor, cd_bairro, cd_cidade, sg_estado, ds_endereco, qt_areautil, qt_areatotal, vl_preco) values (5, 3, 3, 1,'SP','AV. RUBEN BERTA, 2355', 110, 200, 95000);
insert into imovel(cd_imovel, cd_vendedor, cd_bairro, cd_cidade, sg_estado, ds_endereco, qt_areautil, qt_areatotal, vl_preco) values (6, 4, 1, 1,'RJ','R. GETULIO VARGAS, 552', 200, 300, 99000);

insert into comprador(cd_comprador, nm_comprador, ds_endereco, ds_email) values (1, 'EMMANUEL ANTUNES', 'R. SARAIVA,452','eantunes@nova.com');
insert into comprador(cd_comprador, nm_comprador, ds_endereco, ds_email) values (2, 'JOANA PEREIRA', 'AV. PORTUGAL,52','jpereira@nova.com');
insert into comprador(cd_comprador, nm_comprador, ds_endereco, ds_email) values (3, 'RONALDO CAMPELO', 'R. ESTADOS UNIDOS,13','rcampelo@nova.com');
insert into comprador(cd_comprador, nm_comprador, ds_endereco, ds_email) values (4, 'MANFRED AUGUSTO', 'AV. BRASIL,351','maugusto@nova.com');

insert into oferta(cd_comprador, cd_imovel, vl_oferta, dt_oferta) values (1, 1, 170000, '10/01/09');
insert into oferta(cd_comprador, cd_imovel, vl_oferta, dt_oferta) values (1, 3, 180000, '10/01/09');
insert into oferta(cd_comprador, cd_imovel, vl_oferta, dt_oferta) values (2, 2, 135000, '15/01/09');
insert into oferta(cd_comprador, cd_imovel, vl_oferta, dt_oferta) values (2, 4, 100000, '15/02/09');
insert into oferta(cd_comprador, cd_imovel, vl_oferta, dt_oferta) values (3, 1, 160000, '05/01/09');
insert into oferta(cd_comprador, cd_imovel, vl_oferta, dt_oferta) values (3, 2, 140000, '20/02/09');

UPDATE imovel SET vl_preco = (vl_preco * 0.10 + vl_preco);
UPDATE imovel SET vl_preco = ((vl_preco) - (vl_preco * 0.05)) where cd_vendedor = 1;

UPDATE oferta SET vl_oferta = (vl_oferta * 0.05 + vl_oferta) where cd_comprador = 2;
UPDATE oferta SET vl_oferta = 101000 where cd_comprador = 2 and cd_imovel = 4;

UPDATE comprador SET ds_endereco = 'R. ANANÁS, 45',sg_estado = 'RJ' where cd_comprador = 3;

DELETE FROM oferta where cd_comprador = 3 and cd_imovel = 1;
DELETE FROM cidade where cd_cidade = 3 and sg_estado = 'SP';

insert into faixa_imovel(cd_faixa, nm_faixa, vl_minimo, vl_maximo) values (1,'BAIXO',0,105000);
insert into faixa_imovel(cd_faixa, nm_faixa, vl_minimo, vl_maximo) values (2,'MÉDIO',105001,180000);
insert into faixa_imovel(cd_faixa, nm_faixa, vl_minimo, vl_maximo) values (3,'ALTO',180001,999999);

Select * FROM imovel;
-- Select * FROM comprador;
-- Select * FROM oferta;
-- Select * FROM vendedor;
-- Select * FROM estado;
-- Select * FROM cidade;
-- Select * FROM bairro;
-- Select * FROM faixa_imovel;