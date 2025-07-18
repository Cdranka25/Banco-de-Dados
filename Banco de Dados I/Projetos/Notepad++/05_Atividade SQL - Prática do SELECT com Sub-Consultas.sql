
 -- DROP TABLE filme_ator;
 -- DROP TABLE filme;
 -- DROP TABLE ator;
 -- DROP TABLE censura;
 -- DROP TABLE genero;

-- 1. (3,0 Pontos) Criação das tabelas com as respectivas colunas e restrições (chave primária - PK e chave estrangeira - FK). Atenção, a identificação da PK 
-- é indicada com a figura de uma chave no lado esquerdo da coluna; 

CREATE TABLE Genero
(cd_genero INTEGER,
 ds_genero VARCHAR(30),
 PRIMARY KEY(cd_genero)
 );
 
 CREATE TABLE Censura
 (cd_censura INTEGER,
 ds_censura VARCHAR (30),
 PRIMARY KEY (cd_censura)
 );
 
 CREATE TABLE Ator
 (cd_ator INTEGER,
 nm_ator VARCHAR(50),
 PRIMARY KEY(cd_ator)
 );
 
 CREATE TABLE Filme
 (cd_filme INTEGER, 
 cd_censura INTEGER,
 cd_genero INTEGER,
 nm_filme VARCHAR(50),
 ds_sinopse VARCHAR(250),
 nr_duracao VARCHAR(20),
 dt_lancamento DATE,
 fl_dublado CHAR(1),
 PRIMARY KEY (cd_filme),
 FOREIGN KEY (cd_censura) REFERENCES Censura (cd_censura),
 FOREIGN KEY (cd_genero) REFERENCES Genero (cd_genero)
 );
 
 CREATE TABLE Filme_Ator
 (cd_filme INTEGER,
 cd_ator INTEGER,
 FOREIGN KEY(cd_filme) REFERENCES Filme (cd_filme),
 FOREIGN KEY(cd_ator) REFERENCES Ator (cd_ator)
 );
 
 -- 2. (1,0 Ponto) Criação de sentenças SQL para garantir que unicidade (que seja único) a descrição do gênero e a descrição da censura;
 ALTER TABLE Genero
 ADD CONSTRAINT unique_ds_genero UNIQUE (ds_genero);
 
 ALTER TABLE Censura
 ADD CONSTRAINT unique_ds_censura UNIQUE (ds_censura);
 
 
 
-- 3. (1,0 Ponto) Inclusão de, no mínimo, 05 (cinco) filmes, 10 (dez) atores associados aos filmes, 03 (três) gêneros distintos e 03 (três) censuras distintas.

-- Atores
INSERT INTO Ator (cd_ator, nm_ator)
VALUES
	(1, 'ator1'),
	(2, 'ator2'),
	(3, 'ator3'),
	(4, 'ator4'),
	(5, 'ator5'),
	(6, 'ator6'),
	(7, 'ator7'),
	(8, 'ator8'),
	(9, 'ator9'),
	(10, 'ator10');
	
-- Genero
INSERT INTO Genero (cd_genero, ds_genero)
VALUES
	(1, 'Suspense'),
	(2, 'Drama'),
	(3, 'Terror'),
	(4, 'Romance'),
	(5, 'infantil');
	
-- Censura
INSERT INTO Censura (cd_censura, ds_censura)
VALUES
   (1, 'Para maiores de 10 anos'),
	(2, 'Para maiores de 12 anos'),
	(3, 'Para maiores de 14 anos'),
	(4, 'Para maiores de 16 anos'),
	(5, 'Para maiores de 18 anos');
	
-- Filme
INSERT INTO filme (cd_filme, cd_censura, cd_genero, nm_filme, ds_sinopse, nr_duracao,dt_lancamento,fl_dublado)
VALUES
	(1,2,3, 'Casa Monstro', 'Uma casa que tem vida própria e ataca pessoas próximas', '120', '2008-01-01', 'S'),
	(2,3,1, 'A viagem de chihiro', 'Uma viagem do Chihiro', '120', '2020-01-01', 'N'),
	(3,1,3, 'Divertida mente', 'Emoções loucas fazendo loucuras', '140', '2016-01-01', 'S'),
	(4,4,3, 'Jumanji', 'Transportados para dentro de um jogo com muitos desafios', '160', '1999-01-01', 'S'),
	(5,4,3, 'Jogador n° 1', 'Não sei o que acontece, mas imagino que tenha um jogador e ele seja o número 1', '1370', '2018-01-01', 'S');
	
-- Filme_Ator
INSERT INTO filme_ator (cd_filme, cd_ator) VALUES  (1,1);
INSERT INTO filme_ator (cd_filme, cd_ator) VALUES  (1,4);
INSERT INTO filme_ator (cd_filme, cd_ator) VALUES	(1,8);
INSERT INTO filme_ator (cd_filme, cd_ator) VALUES	(2,7);
INSERT INTO filme_ator (cd_filme, cd_ator) VALUES	(3,9);
INSERT INTO filme_ator (cd_filme, cd_ator) VALUES	(3,2);
INSERT INTO filme_ator (cd_filme, cd_ator) VALUES	(4,3);
INSERT INTO filme_ator (cd_filme, cd_ator) VALUES	(4,5);
INSERT INTO filme_ator (cd_filme, cd_ator) VALUES	(4,6);
INSERT INTO filme_ator (cd_filme, cd_ator) VALUES	(5,10);
	

-- ******* 4. (1,0 Ponto) Exibir os nomes de filmes, a descrição da censura, a descrição do gênero e o nome do(s) atores aaociado(s) a cada filme. O resultado desta questão poderá apresentar linhas repeditas caso apresente mais de um ator associado (diferenciando apenas o nome do ator).
SELECT f.nm_filme, c.ds_censura, g.ds_genero, a.nm_ator
FROM filme f
JOIN 
	censura c ON f.cd_censura = c.cd_censura
JOIN 
	genero g ON f.cd_genero = g.cd_genero
JOIN 
	filme_ator fa ON f.cd_filme = fa.cd_filme
JOIN 
   ator a ON fa.cd_ator = a.cd_ator;
   

-- 5. (1,0 Ponto) Listagem dos nomes dos filmes onde a descrição da censura for igual a “livre”, que sejam dublados, e a descrição do gênero seja “infantil”, ordenados pela data de lançamento decrescente;
SELECT 
FROM Filme f

JOIN 	
	censura c
JOIN
	genero g

	
	
-- 6. (1,5 Pontos) Listagem dos filmes que apresentam (03) três ou mais atores associados;

-- 7. (1,5 Pontos) Recuperação da quantidade de filme agrupada por cada descrição de censura, ou seja, mostrar a descrição da censura e quantos filmes cada uma apresenta;
 