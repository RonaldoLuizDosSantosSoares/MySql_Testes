-- Create database TR2_2sem_23;

-- Use TR2_2sem_23;

CREATE TABLE Empregado(

Empr_cd_Empregado Char(8) NOT NULL,

Empr_nm_Empregado Char(30),

Empr_dt_Nascimento Date,

Empr_ds_Endereco Char(50),

Empr_nm_Cidade Char(20),

Empr_nm_Estado char(2),

Empr_nm_Telefone char(11));



CREATE TABLE Dependente(

Empr_cd_Empregado Char(8) NOT NULL,

Depe_cd_Dependente Integer NOT NULL,

Depe_nm_Dependente Char(30),

Depe_dt_Nascimento Date,

Pare_cd_Parentesco Integer);


CREATE TABLE Parentesco(

Pare_cd_Parentesco Integer NOT NULL,

Pare_ds_Parentesco char(25));


alter table empregado
add primary key (empr_cd_empregado);

alter table dependente
add primary key (empr_cd_empregado,depe_cd_dependente);

alter table parentesco
add primary key (pare_cd_parentesco);

alter table dependente
add foreign key (empr_cd_empregado) references empregado (empr_cd_empregado);

alter table dependente
add foreign key (pare_cd_parentesco) references parentesco (pare_cd_parentesco);

insert into parentesco values (99, 'Esposa');
insert into parentesco values (1, 'Filho');
insert into parentesco values (2, 'Filha');

insert into empregado values (1,'Empregado 1','1966-01-01','Rua 1','Cidade 1','sp','33642735');
insert into empregado values (2,'Empregado 2','1966-01-01','Rua 2','Cidade 2','rj','33257896');
insert into empregado values (3,'Empregado 3','1966-01-01','Rua 3','Cidade 3','sp','33754127');

insert into empregado values (4,'Empregado 4','1976-01-01','Rua 4','Cidade 4','rj','33675896');
insert into empregado values (5,'Empregado 5','1976-01-01','Rua 5','Cidade 5','sp','33641258');
insert into empregado values (6,'Empregado 6','1976-01-01','Rua 6','Cidade 6','rj','33634185');

insert into empregado values (7,'Empregado 7','1991-01-01','Rua 7','Cidade 7','sp','33675896');
insert into empregado values (8,'Empregado 8','1991-01-01','Rua 8','Cidade 8','rj','33641258');
insert into empregado values (9,'Empregado 9','1991-01-01','Rua 9','Cidade 9','sp','33634185');

insert into dependente values (1,1,'Filho 1','2007-01-01',1);
insert into dependente values (1,2,'Filha 1','2002-01-01',2);
insert into dependente values (1,3,'Esposa 1','1971-01-01',99);

insert into dependente values (2,1,'Filho 2','2007-01-01',1);
insert into dependente values (2,2,'Filha 2','2002-01-01',2);
insert into dependente values (2,3,'Esposa 2','1971-01-01',99);

insert into dependente values (3,1,'Filho 3','2007-01-01',1);
insert into dependente values (3,2,'Filha 3','2002-01-01',2);
insert into dependente values (3,3,'Esposa 3','1971-01-01',99);

insert into dependente values (4,1,'Filho 4','2012-01-01',1);
insert into dependente values (4,2,'Filha 4','2008-01-01',2);
insert into dependente values (4,3,'Esposa 4','1980-01-01',99);

insert into dependente values (5,1,'Filho 5','2012-01-01',1);
insert into dependente values (5,2,'Filha 5','2008-01-01',2);
insert into dependente values (5,3,'Esposa 5','1980-01-01',99);

insert into dependente values (6,1,'Filho 6','2012-01-01',1);
insert into dependente values (6,2,'Filha 6','2008-01-01',2);
insert into dependente values (6,3,'Esposa 6','1980-01-01',99);

insert into dependente values (7,1,'Filho 7','2018-01-01',1);
insert into dependente values (7,2,'Filha 7','2014-01-01',2);
insert into dependente values (7,3,'Esposa 7','1998-01-01',99);

insert into dependente values (8,1,'Filho 8','2018-01-01',1);
insert into dependente values (8,2,'Filha 8','2014-01-01',2);
insert into dependente values (8,3,'Esposa 8','1998-01-01',99);

insert into dependente values (9,1,'Filho 9','2018-01-01',1);
insert into dependente values (9,2,'Filha 9','2014-01-01',2);
insert into dependente values (9,3,'Esposa 9','1998-01-01',99);

-- 1 --
SELECT
    d1.Depe_nm_Dependente AS "Nome da Mãe",
    d1.Depe_dt_Nascimento AS "Data de Nascimento da Mãe",
    GROUP_CONCAT(DISTINCT CONCAT(d2.Depe_nm_Dependente, ' (', d2.Depe_dt_Nascimento, ')') SEPARATOR ', ') AS "Nome(s) do(s) Filho(s)",
    GROUP_CONCAT(DISTINCT CONCAT(d3.Depe_nm_Dependente, ' (', d3.Depe_dt_Nascimento, ')') SEPARATOR ', ') AS "Nome(s) da(s) Filha(s)",
    e.Ende_ds_Endereco AS "Endereço"
FROM
    Empregado e
    JOIN Dependente d1 ON e.Empr_cd_Empregado = d1.Empr_cd_Empregado AND d1.Pare_cd_Parentesco = 99 -- Esposa
    LEFT JOIN Dependente d2 ON e.Empr_cd_Empregado = d2.Empr_cd_Empregado AND d2.Pare_cd_Parentesco = 1 -- Filho
    LEFT JOIN Dependente d3 ON e.Empr_cd_Empregado = d3.Empr_cd_Empregado AND d3.Pare_cd_Parentesco = 2 -- Filha
WHERE
    TIMESTAMPDIFF(YEAR, d1.Depe_dt_Nascimento, CURDATE()) > 47 -- Idade da Mãe > 47 anos
    AND TIMESTAMPDIFF(YEAR, d2.Depe_dt_Nascimento, CURDATE()) > 17 -- Idade do Filho > 17 anos
    AND TIMESTAMPDIFF(YEAR, d3.Depe_dt_Nascimento, CURDATE()) > 17 -- Idade da Filha > 17 anos
GROUP BY
    d1.Depe_cd_Dependente,
    d1.Depe_nm_Dependente,
    d1.Depe_dt_Nascimento,
    e.Ende_ds_Endereco;





/*
-- 2 --
SELECT e1.Empr_nm_Empregado AS 'Nome da Mãe',
       e1.Empr_dt_Nascimento AS 'Data de Nascimento da Mãe',
       d1.Depe_nm_Dependente AS 'Nome do Filho/Filha',
       d1.Depe_dt_Nascimento AS 'Data de Nascimento do Filho/Filha',
       e1.Empr_nm_Cidade AS 'Cidade'
FROM Empregado e1
JOIN Dependente d1 ON e1.Empr_cd_Empregado = d1.Empr_cd_Empregado
WHERE TIMESTAMPDIFF(YEAR, e1.Empr_dt_Nascimento, CURDATE()) BETWEEN 20 AND 34
  AND TIMESTAMPDIFF(YEAR, d1.Depe_dt_Nascimento, CURDATE()) < 5;
*/
-- 3 --
/*
SELECT
    e1.Empr_nm_Empregado AS "Nome do Empregado",
    e1.Empr_dt_Nascimento AS "Data de Nascimento do Empregado",
    d1.Depe_nm_Dependente AS "Nome da Esposa",
    d1.Depe_dt_Nascimento AS "Data de Nascimento da Esposa",
    d2.Depe_nm_Dependente AS "Nome do Filho",
    d2.Depe_dt_Nascimento AS "Data de Nascimento do Filho",
    d3.Depe_nm_Dependente AS "Nome da Filha",
    d3.Depe_dt_Nascimento AS "Data de Nascimento da Filha",
    e1.Empr_nm_Cidade AS "Cidade"
FROM
    Empregado e
    JOIN Dependente d1 ON e.Empr_cd_Empregado = d1.Empr_cd_Empregado AND d1.Pare_cd_Parentesco = 99 -- Esposa
    JOIN Dependente d2 ON e.Empr_cd_Empregado = d2.Empr_cd_Empregado AND d2.Pare_cd_Parentesco = 1 -- Filho
    JOIN Dependente d3 ON e.Empr_cd_Empregado = d3.Empr_cd_Empregado AND d3.Pare_cd_Parentesco = 2 -- Filha
WHERE
    TIMESTAMPDIFF(YEAR, e.Empr_dt_Nascimento, CURDATE()) BETWEEN 35 AND 49 -- Idade do Empregado entre 35 e 49 anos
    AND TIMESTAMPDIFF(YEAR, d1.Depe_dt_Nascimento, CURDATE()) > 12 -- Idade da Esposa > 12 anos
    AND TIMESTAMPDIFF(YEAR, d2.Depe_dt_Nascimento, CURDATE()) > 12 -- Idade do Filho > 12 anos
    AND TIMESTAMPDIFF(YEAR, d3.Depe_dt_Nascimento, CURDATE()) > 12 -- Idade da Filha > 12 anos;

-- 4 --
/*
SELECT
    e.Empr_nm_Empregado AS "Nome do Empregado",
    e.Empr_dt_Nascimento AS "Data de Nascimento do Empregado",
    d1.Depe_nm_Dependente AS "Nome da Esposa",
    d1.Depe_dt_Nascimento AS "Data de Nascimento da Esposa",
    d2.Depe_nm_Dependente AS "Nome do Filho",
    d2.Depe_dt_Nascimento AS "Data de Nascimento do Filho",
    d3.Depe_nm_Dependente AS "Nome da Filha",
    d3.Depe_dt_Nascimento AS "Data de Nascimento da Filha",
    e.Empr_cd_Empregado AS "Código do Empregado"
FROM
    Empregado e
    JOIN Dependente d1 ON e.Empr_cd_Empregado = d1.Empr_cd_Empregado AND d1.Pare_cd_Parentesco = 99 -- Esposa
    JOIN Dependente d2 ON e.Empr_cd_Empregado = d2.Empr_cd_Empregado AND d2.Pare_cd_Parentesco = 1 -- Filho
    JOIN Dependente d3 ON e.Empr_cd_Empregado = d3.Empr_cd_Empregado AND d3.Pare_cd_Parentesco = 2 -- Filha
WHERE
    TIMESTAMPDIFF(YEAR, e.Empr_dt_Nascimento, CURDATE()) > 50 -- Idade do Empregado > 50 anos
    AND TIMESTAMPDIFF(YEAR, d2.Depe_dt_Nascimento, CURDATE()) < 17 -- Idade do Filho < 17 anos
    AND TIMESTAMPDIFF(YEAR, d3.Depe_dt_Nascimento, CURDATE()) < 17; -- Idade da Filha < 17 anos
*/
-- 5 --
/*
SELECT
    e.Empr_nm_Empregado AS "Nome do Empregado",
    e.Empr_dt_Nascimento AS "Data de Nascimento do Empregado",
    d1.Depe_nm_Dependente AS "Nome da Esposa",
    d1.Depe_dt_Nascimento AS "Data de Nascimento da Esposa",
    GROUP_CONCAT(DISTINCT CONCAT(d2.Depe_nm_Dependente, ' (', d2.Depe_dt_Nascimento, ')') SEPARATOR ', ') AS "Nome(s) do(s) Filho(s)",
    GROUP_CONCAT(DISTINCT CONCAT(d3.Depe_nm_Dependente, ' (', d3.Depe_dt_Nascimento, ')') SEPARATOR ', ') AS "Nome(s) da(s) Filha(s)"
FROM
    Empregado e
    JOIN Dependente d1 ON e.Empr_cd_Empregado = d1.Empr_cd_Empregado AND d1.Pare_cd_Parentesco = 99 -- Esposa
    LEFT JOIN Dependente d2 ON e.Empr_cd_Empregado = d2.Empr_cd_Empregado AND d2.Pare_cd_Parentesco = 1 -- Filho
    LEFT JOIN Dependente d3 ON e.Empr_cd_Empregado = d3.Empr_cd_Empregado AND d3.Pare_cd_Parentesco = 2 -- Filha
WHERE
    TIMESTAMPDIFF(YEAR, e.Empr_dt_Nascimento, CURDATE()) BETWEEN 35 AND 49 -- Idade do Empregado entre 35 e 49 anos
    AND (
        TIMESTAMPDIFF(YEAR, d2.Depe_dt_Nascimento, CURDATE()) < 12 -- Idade do Filho < 12 anos
        OR TIMESTAMPDIFF(YEAR, d3.Depe_dt_Nascimento, CURDATE()) < 12 -- Idade da Filha < 12 anos
    )
GROUP BY
    e.Empr_cd_Empregado,
    e.Empr_nm_Empregado,
    e.Empr_dt_Nascimento,
    d1.Depe_nm_Dependente,
    d1.Depe_dt_Nascimento;


-- 6 --
/*
SELECT
    e.Empr_nm_Empregado AS "Nome do Empregado",
    e.Empr_dt_Nascimento AS "Data de Nascimento do Empregado",
    d1.Depe_nm_Dependente AS "Nome da Esposa",
    d1.Depe_dt_Nascimento AS "Data de Nascimento da Esposa",
    GROUP_CONCAT(DISTINCT CONCAT(d2.Depe_nm_Dependente, ' (', d2.Depe_dt_Nascimento, ')') SEPARATOR ', ') AS "Nome(s) do(s) Filho(s)",
    GROUP_CONCAT(DISTINCT CONCAT(d3.Depe_nm_Dependente, ' (', d3.Depe_dt_Nascimento, ')') SEPARATOR ', ') AS "Nome(s) da(s) Filha(s)"
FROM
    Empregado e
    JOIN Dependente d1 ON e.Empr_cd_Empregado = d1.Empr_cd_Empregado AND d1.Pare_cd_Parentesco = 99 -- Esposa
    LEFT JOIN Dependente d2 ON e.Empr_cd_Empregado = d2.Empr_cd_Empregado AND d2.Pare_cd_Parentesco = 1 -- Filho
    LEFT JOIN Dependente d3 ON e.Empr_cd_Empregado = d3.Empr_cd_Empregado AND d3.Pare_cd_Parentesco = 2 -- Filha
WHERE
    TIMESTAMPDIFF(YEAR, e.Empr_dt_Nascimento, CURDATE()) BETWEEN 20 AND 34 -- Idade do Empregado entre 20 e 34 anos
    AND TIMESTAMPDIFF(YEAR, d2.Depe_dt_Nascimento, CURDATE()) > 5 -- Idade do Filho > 5 anos
    AND TIMESTAMPDIFF(YEAR, d3.Depe_dt_Nascimento, CURDATE()) > 5 -- Idade da Filha > 5 anos
GROUP BY
    e.Empr_cd_Empregado,
    e.Empr_nm_Empregado,
    e.Empr_dt_Nascimento,
    d1.Depe_nm_Dependente,
    d1.Depe_dt_Nascimento;

-- 7 --
/*
CREATE PROCEDURE AlterarAnoNascimentoEmpregados(IN ano INT)
BEGIN
    UPDATE Empregado
    SET Empr_dt_Nascimento = DATE(CONCAT(YEAR(Empr_dt_Nascimento), '-', MONTH(Empr_dt_Nascimento), '-', DAY(Empr_dt_Nascimento)))
    WHERE YEAR(Empr_dt_Nascimento) = ano;
END;

CALL AlterarAnoNascimentoEmpregados(1992);
CALL AlterarAnoNascimentoEmpregados(1987);
CALL AlterarAnoNascimentoEmpregados(1982);
CALL AlterarAnoNascimentoEmpregados(1977);
CALL AlterarAnoNascimentoEmpregados(1972);
CALL AlterarAnoNascimentoEmpregados(1967);
CALL AlterarAnoNascimentoEmpregados(1962);
CALL AlterarAnoNascimentoEmpregados(1957);
CALL AlterarAnoNascimentoEmpregados(1952);
*/

-- 8 --
/*
CREATE PROCEDURE AlterarAnoNascimentoEsposas(IN ano INT)
BEGIN
    UPDATE Dependente
    SET Depe_dt_Nascimento = DATE(CONCAT(YEAR(Depe_dt_Nascimento), '-', MONTH(Depe_dt_Nascimento), '-', DAY(Depe_dt_Nascimento)))
    WHERE YEAR(Depe_dt_Nascimento) = ano AND Pare_cd_Parentesco = 99;
END;

CALL AlterarAnoNascimentoEsposas(1953);
CALL AlterarAnoNascimentoEsposas(1956);
CALL AlterarAnoNascimentoEsposas(1959);
CALL AlterarAnoNascimentoEsposas(1973);
CALL AlterarAnoNascimentoEsposas(1976);
CALL AlterarAnoNascimentoEsposas(1979);
CALL AlterarAnoNascimentoEsposas(1983);
CALL AlterarAnoNascimentoEsposas(1986);
CALL AlterarAnoNascimentoEsposas(1989);
*/

-- 9 --
/*
CREATE PROCEDURE AlterarAnoNascimentoFilhosHomens(IN ano INT)
BEGIN
    UPDATE Dependente
    SET Depe_dt_Nascimento = DATE(CONCAT(YEAR(Depe_dt_Nascimento), '-', MONTH(Depe_dt_Nascimento), '-', DAY(Depe_dt_Nascimento)))
    WHERE YEAR(Depe_dt_Nascimento) = ano AND Pare_cd_Parentesco = 1;
END;

CALL AlterarAnoNascimentoFilhosHomens(1994);
CALL AlterarAnoNascimentoFilhosHomens(1994);
CALL AlterarAnoNascimentoFilhosHomens(1994);
CALL AlterarAnoNascimentoFilhosHomens(1996);
CALL AlterarAnoNascimentoFilhosHomens(1996);
CALL AlterarAnoNascimentoFilhosHomens(1996);
CALL AlterarAnoNascimentoFilhosHomens(1998);
CALL AlterarAnoNascimentoFilhosHomens(1998);
CALL AlterarAnoNascimentoFilhosHomens(1998);
*/

-- 10 --
/*
CREATE PROCEDURE AlterarAnoNascimentoFilhasMulheres(IN ano INT)
BEGIN
    UPDATE Dependente
    SET Depe_dt_Nascimento = DATE(CONCAT(YEAR(Depe_dt_Nascimento), '-', MONTH(Depe_dt_Nascimento), '-', DAY(Depe_dt_Nascimento)))
    WHERE YEAR(Depe_dt_Nascimento) = ano AND Pare_cd_Parentesco = 2;
END;

CALL AlterarAnoNascimentoFilhasMulheres(2010);
CALL AlterarAnoNascimentoFilhasMulheres(2010);
CALL AlterarAnoNascimentoFilhasMulheres(2010);
CALL AlterarAnoNascimentoFilhasMulheres(2012);
CALL AlterarAnoNascimentoFilhasMulheres(2012);
CALL AlterarAnoNascimentoFilhasMulheres(2012);
CALL AlterarAnoNascimentoFilhasMulheres(2014);
CALL AlterarAnoNascimentoFilhasMulheres(2014);
CALL AlterarAnoNascimentoFilhasMulheres(2014);

