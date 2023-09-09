-- Desafio 1
-- Nome: Ronaldo Luiz Dos Santos Soares
-- Motivo de fazer sozinho: Teve um número impar de pessoas, o que impossibilitou de realizar dupla, no entanto, fiz o desafio com auxilio de colegas de sala em duvidas e resolução de bug

create table empregado(
cd_empregado varchar(8),
nm_empregado char(30),
dt_nasc_empregado date,
ed_empregado varchar(50),
cid_empregado char(20),
sg_estado char(2),
tl_empregado char(11)
);

create table dependente(
cd_empregado varchar(8),
cd_dependente int NOT NULL,
cd_parentesco int NOT NULL,
nm_dependente char(30),
dt_nasc_dependente date,
grau_parent int NOT NULL
);

create table parentesco(
cd_parentesco int NOT NULL,
nm_parentesco char(25)
);

-- 99 é esposa
-- 1 é filho
-- 2 é filha

# Questão 1

ALTER TABLE empregado
ADD CONSTRAINT PK_empregado PRIMARY KEY (cd_empregado);

ALTER TABLE parentesco
ADD CONSTRAINT PK_parentesco PRIMARY KEY (cd_parentesco);

ALTER TABLE dependente
ADD CONSTRAINT PK_dependente PRIMARY KEY (cd_dependente, cd_parentesco);

# Questão 2

ALTER TABLE dependente
ADD CONSTRAINT FK_dependente_empregado FOREIGN KEY (cd_empregado) references empregado (cd_empregado);

ALTER TABLE dependente
ADD CONSTRAINT FK_dependente_parentesco FOREIGN KEY (cd_parentesco) references parentesco (cd_parentesco);


# Questão 3

-- empregado --
INSERT INTO empregado (cd_empregado, nm_empregado, dt_nasc_empregado, ed_empregado, cid_empregado, sg_estado, tl_empregado) VALUES (1, 'empregado1', '1970-01-01', 'endereço1', 'cidade1', 'SP', '123456789'),(2, 'empregado2', '1965-01-01', 'endereço2', 'cidade2', 'RJ', '123456789'),(3, 'empregado3', '1955-01-01', 'endereço3', 'cidade3', 'SP', '123456789');
INSERT INTO empregado (cd_empregado, nm_empregado, dt_nasc_empregado, ed_empregado, cid_empregado, sg_estado, tl_empregado) VALUES (4, 'empregado4', '1985-01-01', 'endereço4', 'cidade4', 'RJ', '123456789'), (5, 'empregado5', '1975-01-01', 'endereço5', 'cidade5', 'SP', '123456789'), (6, 'empregado6', '1965-01-01', 'endereço6', 'cidade6', 'RJ', '123456789');
INSERT INTO empregado (cd_empregado, nm_empregado, dt_nasc_empregado, ed_empregado, cid_empregado, sg_estado, tl_empregado) VALUES (7, 'empregado7', '1995-01-01', 'endereço7', 'cidade7', 'SP', '1112345678'), (8, 'empregado8', '1990-01-01', 'endereço8', 'cidade8', 'RJ', '2198765432'), (9, 'empregado9', '1988-01-01', 'endereço9', 'cidade9', 'SP', '5198765432');

-- dependente --

INSERT INTO dependente (cd_empregado, cd_dependente, cd_parentesco, nm_dependente, dt_nasc_dependente, grau_parent) VALUES ('1', 1, 99, 'esposa1', '1974-01-01', 99), ('1', 2, 1, 'filho1', '2007-01-01', 1), ('1', 3, 2, 'filha1', '1998-01-01', 2), ('2', 1, 99, 'esposa2', '1973-01-01', 99), ('2', 2, 1, 'filho2', '2010-01-01', 1), ('2', 3, 2, 'filha2', '2001-01-01', 2), ('3', 1, 99, 'esposa3', '1963-01-01', 99), ('3', 2, 1, 'filho3', '2014-01-01', 1), ('3', 3, 2, 'filha3', '1995-01-01', 2);
INSERT INTO dependente (cd_empregado, cd_dependente, cd_parentesco, nm_dependente, dt_nasc_dependente, grau_parent) VALUES ('4', 1, 99, 'esposa4', '1977-01-01', 99), ('4', 2, 1, 'filho4', '2016-01-01', 1), ('4', 3, 2, 'filha4', '2002-01-01', 2), ('5', 1, 99, 'esposa5', '1978-01-01', 99), ('5', 2, 1, 'filho5', '2015-01-01', 1), ('5', 3, 2, 'filha5', '2002-01-01', 2), ('6', 1, 99, 'esposa5', '1975-01-01', 99), ('6', 2, 1, 'filho5', '2014-01-01', 1), ('6', 3, 2, 'filha5', '2003-01-01', 2),
INSERT INTO dependente (cd_empregado, cd_dependente, cd_parentesco, nm_dependente, dt_nasc_dependente, grau_parent) VALUES ('7', 1, 99, 'esposa4', '1996-01-01', 99), ('7', 2, 1, 'filho4', '2021-01-01', 1), ('7', 3, 2, 'filha4', '2001-01-01', 2), ('8', 1, 99, 'esposa5', '1995-01-18', 99), ('8', 2, 1, 'filho5', '2022-01-01', 1), ('8', 3, 2, 'filha5', '2017-01-01', 2), ('9', 1, 99, 'esposa6', '1998-01-01', 99), ('9', 2, 1, 'filho6', '2022-01-01', 1), ('9', 3, 2, 'filha6', '2001-01-01', 2);

# Questão 4

SELECT e.nm_empregado, e.dt_nasc_empregado, d1.nm_dependente AS nm_esposa, 
d2.nm_dependente AS nm_filho, d3.nm_dependente AS nm_filha
FROM empregado e
LEFT JOIN dependente d1 ON e.cd_empregado = d1.cd_empregado AND d1.cd_parentesco = 1
LEFT JOIN dependente d2 ON e.cd_empregado = d2.cd_empregado AND d2.cd_parentesco = 2
LEFT JOIN dependente d3 ON e.cd_empregado = d3.cd_empregado AND d3.cd_parentesco = 3
WHERE e.cd_empregado IN (
   SELECT cd_empregado FROM empregado WHERE dt_nasc_empregado < '1971-01-01' AND cd_empregado BETWEEN '10000000' AND '10000002'
   UNION ALL
   SELECT cd_empregado FROM empregado WHERE dt_nasc_empregado BETWEEN '1971-01-01' AND '1985-12-31' AND cd_empregado BETWEEN '10000003' AND '10000005'
   UNION ALL
   SELECT cd_empregado FROM empregado WHERE dt_nasc_empregado BETWEEN '1986-01-01' AND '2002-12-31' AND cd_empregado BETWEEN '10000006' AND '10000008'
);

# Questão 5

SELECT e.nm_empregado, 
       d1.nm_dependente AS nm_esposa, 
       d2.nm_dependente AS nm_filho, 
       d2.dt_nasc_dependente AS dt_nasc_filho, 
       d3.nm_dependente AS nm_filha,
       d3.dt_nasc_dependente AS dt_nasc_filha
FROM empregado e
LEFT JOIN dependente d1 ON e.cd_empregado = d1.cd_empregado AND d1.cd_parentesco = 1
LEFT JOIN dependente d2 ON e.cd_empregado = d2.cd_empregado AND d2.cd_parentesco = 2
LEFT JOIN dependente d3 ON e.cd_empregado = d3.cd_empregado AND d3.cd_parentesco = 3;

# Questão 6

SELECT e.nm_empregado,
       e.dt_nasc_empregado,
       d1.nm_dependente AS nm_filho,
       d1.dt_nasc_dependente AS dt_nasc_filho,
       d2.nm_dependente AS nm_filha,
       d2.dt_nasc_dependente AS dt_nasc_filha
FROM empregado e
INNER JOIN dependente d1 ON e.cd_empregado = d1.cd_empregado AND d1.grau_parent = 2 AND d1.dt_nasc_dependente > DATEADD(year, -12, GETDATE())
INNER JOIN dependente d2 ON e.cd_empregado = d2.cd_empregado AND d2.grau_parent = 3 AND d2.dt_nasc_dependente > DATEADD(year, -12, GETDATE())
WHERE e.dt_nasc_empregado BETWEEN DATEADD(year, -49, GETDATE()) AND DATEADD(year, -35, GETDATE());

# Questão 7

SELECT e.nm_empregado,
       d_esposa.nm_dependente AS nm_esposa,
       d_esposa.dt_nasc_dependente AS dt_nasc_esposa,
       d1.nm_dependente AS nm_filho,
       d1.dt_nasc_dependente AS dt_nasc_filho,
       d2.nm_dependente AS nm_filha,
       d2.dt_nasc_dependente AS dt_nasc_filha
FROM empregado e
INNER JOIN dependente d_esposa ON e.cd_empregado = d_esposa.cd_empregado AND d_esposa.grau_parent = 1 AND d_esposa.dt_nasc_dependente BETWEEN DATEADD(year, -32, GETDATE()) AND DATEADD(year, -20, GETDATE())
INNER JOIN dependente d1 ON e.cd_empregado = d1.cd_empregado AND d1.grau_parent = 2 AND d1.dt_nasc_dependente < DATEADD(year, -5, GETDATE())
INNER JOIN dependente d2 ON e.cd_empregado = d2.cd_empregado AND d2.grau_parent = 3 AND d2.dt_nasc_dependente > DATEADD(year, -5, GETDATE())
WHERE e.dt_nasc_empregado BETWEEN DATEADD(year, -34, GETDATE()) AND DATEADD(year, -20, GETDATE());

# Questão 8

SELECT 
  e.nm_empregado AS nome_empregado,
  es.nm_dependente AS nome_esposa,
  es.dt_nasc_dependente AS data_nasc_esposa,
  f.nm_dependente AS nome_filho,
  f.dt_nasc_dependente AS data_nasc_filho,
  fi.nm_dependente AS nome_filha,
  fi.dt_nasc_dependente AS data_nasc_filha
FROM empregado e
JOIN dependente es ON es.cd_empregado = e.cd_empregado AND es.cd_parentesco = 1 AND es.dt_nasc_dependente <= '1974-05-07'
JOIN dependente f ON f.cd_empregado = e.cd_empregado AND f.grau_parent = 1 AND f.dt_nasc_dependente > '2005-05-07'
JOIN dependente fi ON fi.cd_empregado = e.cd_empregado AND fi.grau_parent = 2 AND fi.dt_nasc_dependente > '2005-05-07'

# Questão 9 

SELECT 
  e.nm_empregado AS nome_empregado,
  es.nm_dependente AS nome_esposa,
  f.nm_dependente AS nome_filho,
  f.dt_nasc_dependente AS data_nasc_filho,
  fi.nm_dependente AS nome_filha,
  fi.dt_nasc_dependente AS data_nasc_filha,
  e.cid_empregado AS cidade,
  f.sg_estado AS estado
FROM empregado e
JOIN dependente f ON f.cd_empregado = e.cd_empregado AND f.sg_estado = 'SP'
JOIN dependente fi ON fi.cd_empregado = e.cd_empregado AND fi.sg_estado = 'SP'
JOIN dependente es ON es.cd_empregado = e.cd_empregado AND es.cd_parentesco = 1

# Questão 10

SELECT 
  emp.nm_empregado as "Nome do empregado",
  empregado_ed.ed_empregado as "Cidade",
  esposa.nm_dependente as "Nome da Esposa",
  filho.nm_dependente as "Nome do Filho",
  filho.dt_nasc_dependente as "Data de Nascimento do Filho",
  filha.nm_dependente as "Nome da Filha",
  filha.dt_nasc_dependente as "Data de Nascimento da Filha"
FROM 
  empregado emp
  JOIN empregado_ed ON emp.cd_empregado = empregado_ed.cd_empregado
  JOIN dependente esposa ON emp.cd_empregado = esposa.cd_empregado AND esposa.cd_parentesco = 1
  JOIN dependente filho ON emp.cd_empregado = filho.cd_empregado AND filho.grau_parent = 1 AND filho.dt_nasc_dependente <= DATEADD(year, -18, GETDATE()) AND filho.dt_nasc_dependente > DATEADD(year, -24, GETDATE())
  JOIN dependente filha ON emp.cd_empregado = filha.cd_empregado AND filha.grau_parent = 2 AND filha.dt_nasc_dependente > DATEADD(year, -18, GETDATE())
WHERE 
  empregado_ed.sg_estado = 'RJ';
