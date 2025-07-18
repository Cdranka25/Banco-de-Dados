
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
INSERT INTO Genero (cd_genero, ds_genero) VALUES
	(1, 'Ação'),
	(2, 'Comédia'),
	(3, 'Drama');
	
INSERT INTO Censura (cd_censura, ds_censura) VALUES
	(1, 'Livre'),
	(2, '12 anos'),
	(3, '18 anos');
	
INSERT INTO Ator (cd_ator, nm_ator) VALUES
	(1, 'Ator 1'),
	(2, 'Ator 2'),
	(3, 'Ator 3'),
	(4, 'Ator 4'),
	(5, 'Ator 5'),
	(6, 'Ator 6'),
	(7, 'Ator 7'),
	(8, 'Ator 8'),
	(9, 'Ator 9'),
	(10, 'Ator 10');
	
INSERT INTO Filme (cd_filme, cd_censura, cd_genero, nm_filme, ds_sinopse, nr_duracao, dt_lancamento, fl_dublado) VALUES
	(1, 1, 2, 'Filme A', 'Sinopse A', '120 min', '2023-01-01', 'S'),
	(2, 2, 1, 'Filme B', 'Sinopse B', '110 min', '2023-02-01', 'N'),
	(3, 3, 3, 'Filme C', 'Sinopse C', '130 min', '2023-03-01', 'S'),
	(4, 1, 2, 'Filme D', 'Sinopse D', '140 min', '2023-04-01', 'S'),
	(5, 2, 1, 'Filme E', 'Sinopse E', '150 min', '2023-05-01', 'N');
	
INSERT INTO Filme_Ator (cd_filme, cd_ator) VALUES
	(1, 1),
	(1, 2),
	(1, 3),
	(2, 4),
	(2, 5),
	(2, 6),
	(3, 7),
	(3, 8),
	(4, 9),
	(4, 10),
	(5, 1),
	(5, 2);
	
-- 4. (1,0 Ponto) Exibir os nomes de filmes, a descrição da censura, a descrição do gênero e o nome do(s) atores aaociado(s) a cada filme. O resultado desta questão poderá apresentar linhas repeditas caso apresente mais de um ator associado (diferenciando apenas o nome do ator).
SELECT f.nm_filme, c.ds_censura, g.ds_genero, a.nm_ator
FROM Filme f
	JOIN Censura c ON f.cd_censura = c.cd_censura
	JOIN Genero g ON f.cd_genero = g.cd_genero
	JOIN Filme_Ator fa ON f.cd_filme = fa.cd_filme
	JOIN Ator a ON fa.cd_ator = a.cd_ator;

-- 5. (1,0 Ponto) Listagem dos nomes dos filmes onde a descrição da censura for igual a “livre”, que sejam dublados, e a descrição do gênero seja “infantil”, ordenados pela data de lançamento decrescente;
INSERT INTO Genero (cd_genero, ds_genero) VALUES (4, 'Infantil');
UPDATE Filme SET cd_genero = 4 WHERE nm_filme = 'Filme A';

SELECT f.nm_filme
FROM Filme f
	JOIN Censura c ON f.cd_censura = c.cd_censura
	JOIN Genero g ON f.cd_genero = g.cd_genero
	WHERE c.ds_censura = 'Livre' AND f.fl_dublado = 'S' AND g.ds_genero = 'Infantil'
	ORDER BY f.dt_lancamento DESC;
	
-- 6. (1,5 Pontos) Listagem dos filmes que apresentam (03) três ou mais atores associados;
	SELECT f.nm_filme
	FROM Filme f
		JOIN Filme_Ator fa ON f.cd_filme = fa.cd_filme
		GROUP BY f.nm_filme
		HAVING COUNT(fa.cd_ator) >= 3;

-- 7. (1,5 Pontos) Recuperação da quantidade de filme agrupada por cada descrição de censura, ou seja, mostrar a descrição da censura e quantos filmes cada uma apresenta;
	SELECT c.ds_censura, COUNT(f.cd_filme) AS quantidade_filmes
	FROM Filme f
		JOIN Censura c ON f.cd_censura = c.cd_censura
		GROUP BY c.ds_censura;