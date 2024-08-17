-- FEITO E COMPILADO EM MYSQL
-- Feito por Ronaldo Luiz

-- TABELAS

create table EMPREGADO(
cd_empregado char(8),
nm_empregado char(30),
dt_nasc_empregado date,
cid_empregado char(20),
end_empregado char(50),
est_empregado char(2),
tel_empregado char(11)
);

create table DEPENDENTE(
cd_empregado char(8),
cd_dependente int,
cd_parentesco int, --
nm_dependente char(30),
dt_nasc_dependente date,
grau_parentesco int
);

create table PARENTESCO(
cd_parentesco int,
nm_parentesco char(25)
);

/*

Os códigos de parentesco são:
99	-> esposa
1	-> filha
2	-> filho


*/

# questao n. 1 - Crie as seguintes chaves primárias usando o comando ALTER:

ALTER TABLE EMPREGADO ADD PRIMARY KEY (cd_empregado);
ALTER TABLE DEPENDENTE ADD PRIMARY KEY (cd_empregado, cd_dependente);
ALTER TABLE PARENTESCO ADD PRIMARY KEY (cd_parentesco);

# questao n. 2 – Crie as seguintes chaves estrangeiras usando o comando ALTER:

ALTER TABLE DEPENDENTE ADD FOREIGN KEY (cd_empregado) REFERENCES EMPREGADO (cd_empregado);
ALTER TABLE DEPENDENTE ADD FOREIGN KEY (cd_parentesco) REFERENCES PARENTESCO (cd_parentesco); --

# questao n. 3 – Insira dados com as seguintes características:

INSERT INTO EMPREGADO (cd_empregado, nm_empregado, dt_nasc_empregado, cid_empregado, est_empregado)
VALUES 
('A','Empregado1','1980/01/01','cidade1','SP'),
('B','Empregado2','1978/01/01','cidade2','RJ'),
('C','Empregado3','1976/01/01','cidade3','SP'),

--

('D','Empregado4','1988/01/01','cidade4','RJ'),
('E','Empregado5','1986/01/01','cidade5','SP'),
('F','Empregado6','1984/01/01','cidade6','RJ'),

--

('G','Empregado7','1991/01/01','cidade7','SP'),
('H','Empregado8','1993/01/01','cidade8','RJ'),
('I','Empregado9','1995/01/01','cidade9','SP');

INSERT INTO PARENTESCO (cd_parentesco, nm_parentesco)
VALUES 
(99,'Esposa'),
(1,'Filho'),
(2,'Filha');

INSERT INTO DEPENDENTE (cd_dependente, cd_parentesco, cd_empregado, nm_dependente, dt_nasc_dependente)
VALUES
(1, 99,'A','Esposa1','1979/01/01'),
(2, 1,'A','Filho1','2020/01/01'),
(3, 2,'A','Filha1','2004/01/01'),

(4, 99,'B','Esposa2','1977/01/01'),
(5, 1,'B','Filho2','2019/01/01'),
(6, 2,'B','Filha2','2003/01/01'),

(7, 99,'C','Esposa3','1975/01/01'),
(8, 1,'C','Filho3','2018/01/01'),
(9, 2,'C','Filha3','2002/01/01'),

--

(10, 99,'D','Esposa4','1987/01/01'),
(11, 1,'D','Filho4','2013/01/01'),
(12, 2,'D','Filha4','2011/01/01'),

(13, 99,'E','Esposa5','1985/01/01'),
(14, 1,'E','Filho5','2014/01/01'),
(15, 2,'E','Filha5','2010/01/01'),

(16, 99,'F','Esposa6','1983/01/01'),
(17, 1,'F','Filho6','2015/01/01'),
(18, 2,'F','Filha6','2009/01/01'),

--

(19, 99,'G','Esposa7','1992/01/01'),
(20, 1,'G','Filho7','2021/01/01'),
(21, 2,'G','Filha7','2019/01/01'),

(22, 99,'H','Esposa8','1994/01/01'),
(23, 1,'H','Filho8','2022/01/01'),
(24, 2,'H','Filha8','2018/01/01'),

(25, 99,'I','Esposa9','1996/01/01'),
(26, 1,'I','Filho9','2023/01/01'),
(27, 2,'I','Filha9','2017/01/01');

-- SELECT * FROM EMPREGADO;

# questao n. 4 - Escreva uma query para mostrar empregados e seus dependentes com as seguintes colunas: colunas -> nome empregado, data de nascimento do empregado, nome da esposa, nome dos filho e nome das filha.

SELECT 
    emp.nm_empregado AS 'Nome Empregado',
    emp.dt_nasc_empregado AS 'Data de Nascimento do Empregado',
    esp.nm_dependente AS 'Nome da Esposa',
    fil.nm_dependente AS 'Nome dos Filhos',
    fih.nm_dependente AS 'Nome das Filhas'
FROM 
    EMPREGADO emp
LEFT JOIN 
    DEPENDENTE esp ON emp.cd_empregado = esp.cd_empregado AND esp.cd_parentesco = 99
LEFT JOIN 
    DEPENDENTE fil ON emp.cd_empregado = fil.cd_empregado AND fil.cd_parentesco = 1
LEFT JOIN 
    DEPENDENTE fih ON emp.cd_empregado = fih.cd_empregado AND fih.cd_parentesco = 2;
    
# questao n. 5 - Escreva uma query para mostrar empregados e seus dependentes com as seguintes colunas: colunas -> nome empregado, nome da esposa, nome do filho, data de nascimento, nome da filha, data de nascimento.

SELECT 
    emp.nm_empregado AS 'Nome Empregado',
    esp.nm_dependente AS 'Nome da Esposa',
    fil.nm_dependente AS 'Nome do Filho',
    fil.dt_nasc_dependente AS 'Data de Nascimento do Filho',
    fih.nm_dependente AS 'Nome da Filha',
    fih.dt_nasc_dependente AS 'Data de Nascimento da Filha'
FROM 
    EMPREGADO emp
LEFT JOIN 
    DEPENDENTE esp ON emp.cd_empregado = esp.cd_empregado AND esp.cd_parentesco = 99
LEFT JOIN 
    DEPENDENTE fil ON emp.cd_empregado = fil.cd_empregado AND fil.cd_parentesco = 1
LEFT JOIN 
    DEPENDENTE fih ON emp.cd_empregado = fih.cd_empregado AND fih.cd_parentesco = 2;

# questao n. 6 - Escreva uma query para mostrar os empregados entre 35 e 49 anos e seus filhos/filhas < de 12 anos com as seguintes colunas: colunas -> nome empregado, data nascimento empregado, nome do filho, data de nascimento do filho, nome da filha, data nascimento da filha.

    SELECT 
    emp.nm_empregado AS 'Nome Empregado',
    emp.dt_nasc_empregado AS 'Data de Nascimento do Empregado',
    filhos.nm_dependente AS 'Nome do Filho',
    filhos.dt_nasc_dependente AS 'Data de Nascimento do Filho',
    filhas.nm_dependente AS 'Nome da Filha',
    filhas.dt_nasc_dependente AS 'Data de Nascimento da Filha'
FROM 
    EMPREGADO emp
LEFT JOIN 
    DEPENDENTE filhos ON emp.cd_empregado = filhos.cd_empregado AND filhos.cd_parentesco = 2
LEFT JOIN 
    DEPENDENTE filhas ON emp.cd_empregado = filhas.cd_empregado AND filhas.cd_parentesco = 1
WHERE 
    TIMESTAMPDIFF(YEAR, emp.dt_nasc_empregado, CURDATE()) BETWEEN 35 AND 49
    AND TIMESTAMPDIFF(YEAR, filhos.dt_nasc_dependente, CURDATE()) < 12
    OR TIMESTAMPDIFF(YEAR, filhas.dt_nasc_dependente, CURDATE()) < 12;
    
# questao n. 7 - Escreva uma query para mostrar os empregados com as esposas entre 20 e 32 anos e seus filhos/filhas > 5 anos numa tabela com as seguintes colunas: colunas -> nome empregado, nome esposa, data nascimento esposa, nome do filho, data de nascimento do filho, nome da filha, data nascimento da filha.

SELECT 
    emp.nm_empregado AS 'Nome Empregado',
    esp.nm_dependente AS 'Nome Esposa',
    esp.dt_nasc_dependente AS 'Data de Nascimento da Esposa',
    filhos.nm_dependente AS 'Nome do Filho',
    filhos.dt_nasc_dependente AS 'Data de Nascimento do Filho',
    filhas.nm_dependente AS 'Nome da Filha',
    filhas.dt_nasc_dependente AS 'Data de Nascimento da Filha'
FROM 
    EMPREGADO emp
JOIN 
    DEPENDENTE esp ON emp.cd_empregado = esp.cd_empregado AND esp.cd_parentesco = 99
JOIN 
    DEPENDENTE filhos ON emp.cd_empregado = filhos.cd_empregado AND filhos.cd_parentesco = 1
JOIN 
    DEPENDENTE filhas ON emp.cd_empregado = filhas.cd_empregado AND filhas.cd_parentesco = 2
WHERE 
    YEAR(CURDATE()) - YEAR(esp.dt_nasc_dependente) BETWEEN 20 AND 32
    AND TIMESTAMPDIFF(YEAR, filhos.dt_nasc_dependente, CURDATE()) < 5
    OR TIMESTAMPDIFF(YEAR, filhas.dt_nasc_dependente, CURDATE()) < 5;
    

# questao n. 8 - Escreva uma query para mostrar os empregados com as esposas > 47 anos e seus filhos/filhas > 17 numa tabela com as seguintes colunas: colunas -> nome empregado, nome esposa, data nascimento esposa, nome do filho, data de nascimento do filho, nome da filha, data nascimento da filha.

SELECT 
    emp.nm_empregado AS 'Nome Empregado',
    esp.nm_dependente AS 'Nome Esposa',
    esp.dt_nasc_dependente AS 'Data de Nascimento da Esposa',
    filhos.nm_dependente AS 'Nome do Filho',
    filhos.dt_nasc_dependente AS 'Data de Nascimento do Filho',
    filhas.nm_dependente AS 'Nome da Filha',
    filhas.dt_nasc_dependente AS 'Data de Nascimento da Filha'
FROM 
    EMPREGADO emp
JOIN 
    DEPENDENTE esp ON emp.cd_empregado = esp.cd_empregado AND esp.cd_parentesco = 99
JOIN 
    DEPENDENTE filhos ON emp.cd_empregado = filhos.cd_empregado AND filhos.cd_parentesco = 1
JOIN 
    DEPENDENTE filhas ON emp.cd_empregado = filhas.cd_empregado AND filhas.cd_parentesco = 2
WHERE 
    YEAR(CURDATE()) - YEAR(esp.dt_nasc_dependente) > 47 
    AND TIMESTAMPDIFF(YEAR, filhos.dt_nasc_dependente, CURDATE()) > 17
    OR TIMESTAMPDIFF(YEAR, filhas.dt_nasc_dependente, CURDATE()) > 17;


# questao n. 9 - Escreva uma query para mostras os filhos que moram no estado de ‘SP’ com as seguintes colunas: colunas -> nome empregado, nome da esposa, nome do filho e data de nascimento do filho, nome da filha, data de nascimento da filha e estado.

SELECT 
    emp.nm_empregado AS 'Nome Empregado',
    esp.nm_dependente AS 'Nome da Esposa',
    filhos.nm_dependente AS 'Nome do Filho',
    filhos.dt_nasc_dependente AS 'Data de Nascimento do Filho',
    filhas.nm_dependente AS 'Nome da Filha',
    filhas.dt_nasc_dependente AS 'Data de Nascimento da Filha',
    emp.cid_empregado AS 'Cidade'
FROM 
    EMPREGADO emp
LEFT JOIN 
    DEPENDENTE esp ON emp.cd_empregado = esp.cd_empregado AND esp.cd_parentesco = 99
LEFT JOIN 
    DEPENDENTE filhos ON emp.cd_empregado = filhos.cd_empregado AND filhos.cd_parentesco = 1
LEFT JOIN 
    DEPENDENTE filhas ON emp.cd_empregado = filhas.cd_empregado AND filhas.cd_parentesco = 2
WHERE 
    emp.est_empregado = 'SP';

# questao n. 10 - Escreva uma query para mostrar as cidades do estado de ‘RJ’ com as seguintes colunas: colunas -> nome empregado, nome da esposa, nome do filho, data de nascimento do filho nome da filha, data de nascimento da filha e cidade.

SELECT 
    emp.nm_empregado AS 'Nome Empregado',
    esp.nm_dependente AS 'Nome da Esposa',
    filhos.nm_dependente AS 'Nome do Filho',
    filhos.dt_nasc_dependente AS 'Data de Nascimento do Filho',
    filhas.nm_dependente AS 'Nome da Filha',
    filhas.dt_nasc_dependente AS 'Data de Nascimento da Filha',
    emp.cid_empregado AS 'Cidade'
FROM 
    EMPREGADO emp
LEFT JOIN 
    DEPENDENTE esp ON emp.cd_empregado = esp.cd_empregado AND esp.cd_parentesco = 99
LEFT JOIN 
    DEPENDENTE filhos ON emp.cd_empregado = filhos.cd_empregado AND filhos.cd_parentesco = 1
LEFT JOIN 
    DEPENDENTE filhas ON emp.cd_empregado = filhas.cd_empregado AND filhas.cd_parentesco = 2
WHERE 
    emp.est_empregado = 'RJ';
