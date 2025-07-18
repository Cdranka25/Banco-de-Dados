

-- Documento para revisão e consulta para a prova de SQL em MariaDB. 
-- Realizado por Caio Dalagnoli Dranka

------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------
/* 
01 - Criação e Gerenciamento de Tabelas
	
	Criar ou Excluir tabelas:
		CREATE TABLE para criar uma nova tabela.
		DROP TABLE para remover tabelas do banco 
*/
	CREATE TABLE departamentos (
		id INT PRIMARY KEY AUTO_INCREMENT,
		nome VARCHAR(50) NOT NULL,
		localizacao VARCHAR(50) NOT NULL
	);
	
	DROP TABLE departamentos;
/*
	Consulta de informações técnicas
		DESCRIBE retorna informações da coluna, como nome, tipo de dados e se aceita NULL em uma coluna 
		SHOW COLUMNS similar a DESCRIBE, mas possui mais detalhes
*/
	DESCRIBE departamentos;
	SHOW COLUMNS FROM departamentos;
/*
	Chaves:
		PRIMARY KEY chave primaria das Tabelas
		FOREIGN KEY chave estrangeira em Tabelas
*/
	CREATE TABLE Filme
		(cd_filme INTEGER,
		cd_genero INTEGER,
		PRIMARY KEY (cd_filme),
		FOREIGN KEY (cd_genero) REFERENCES Genero (cd_genero)
	);
 
 /*
	Restrições:
		UNIQUE torna a coluna unica, não podendo haver valores iguais
		CHECK Condições que os dados devem satisfazer antes de serem inseridos ou atualizados.
		NOT NULL Impede que valores nulos sejam inseridos em uma coluna.
*/

	CREATE TABLE produtos (
		cd_produtos INTEGER,
		nr_quantidade INTEGER,
		ds_nome VARCHAR(50) UNIQUE,
		nr_preco DECIMAL(10, 2) NOT NULL,
		CHECK (quantidade > 0),
		PRIMARY KEY(cd_produto)
	);

/*
------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------

02 - Manipulação de Dados (comandos DML (Data Manipulation Language))

	Alterar tabelas:
		ALTER TABLE para alterar as Tabelas, adicionar ou remover colunas de tabelas 
			ADD COLUMN adiciona uma nova coluna
			DROP COLUMN remove uma coluna
			MODIFY COLUMN altera o valor de uma coluna
*/
	ALTER TABLE clientes
		ADD COLUMN telefone VARCHAR(15);
		DROP COLUMN telefone;
		MODIFY COLUMN email VARCHAR(100) NOT NULL;

-- 	UPDATE para alterar os dados existentes em uma tabela, importância da cláusula WHERE para evitar modificações indesejadas em múltiplas linhas.
	UPDATE clientes
		SET email = 'novo_email@exemplo.com'
		WHERE id = 1;
		
-- 	INSERT INTO para adicionar novas linhas a uma tabela
	INSERT INTO clientes (nome, email)
		VALUES ('João Silva', 'joao@exemplo.com');
		
-- 	DELETE para remover linhas de uma tabela. Explicação sobre o impacto da ausência da cláusula WHERE, que resultaria na remoção de todas as linhas de uma tabela.
	DELETE FROM clientes
		WHERE id = 1;
/*
	Transações:
		COMMIT salva todas as alterações feitas
		ROLLBACK reverte as alterações realizadas
*/
	START TRANSACTION;
		UPDATE contas SET saldo = saldo - 100 WHERE id = 1;
		UPDATE contas SET saldo = saldo + 100 WHERE id = 2;
		COMMIT;
		
	START TRANSACTION;
		UPDATE contas SET saldo = saldo - 100 WHERE id = 1;
		UPDATE contas SET saldo = saldo + 100 WHERE id = 2;
		ROLLBACK;
/*
------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------

03 - Agreagações e Funções

	Junções: 
		JOIN
			INNER JOIN retorna as linhas que têm correspondências em ambas as tabelas.
			LEFT JOIN retorna todas as linhas da tabela à esquerda e as linhas correspondentes da tabela à direita.
			RIGHT JOIN retorna todas as linhas da tabela à direita e as linhas correspondentes da tabela à esquerda.
			FULL JOIN retorna todas as linhas quando há correspondência em uma das tabelas
*/
	SELECT funcionarios.nome, departamentos.nome
		FROM funcionarios
		INNER JOIN departamentos ON funcionarios.departamento_id = departamentos.id;
		LEFT JOIN departamentos ON funcionarios.departamento_id = departamentos.id;
		RIGHT JOIN departamentos ON funcionarios.departamento_id = departamentos.id;
		FULL JOIN departamentos ON funcionarios.departamento_id = departamentos.id;
		
/*	
	Funções:
		COUNT  retorna o número de linhas que correspondem a um critério especificado
		SUM retorna a soma total de um campo numérico.
		AVG retorna o valor médio de um campo numérico.
		MIN retorna o menor valor de um campo.
		MAX retorna o maior valor de um campo.
*/
		SELECT COUNT(*)
		FROM pedidos;
		
		SELECT SUM(valor)
		FROM pedidos;

		SELECT AVG(valor)
		FROM pedidos;

		SELECT MIN(valor)
		FROM pedidos;

		SELECT MAX(valor)
		FROM pedidos

/*
	Agregações:
		GROUP BY agrupar o resultado por uma ou mais colunas.
	*/
	SELECT departamento_id, COUNT(*)
	FROM funcionarios
		GROUP BY departamento_id;
		
--	ordenar:
--		ORDER BY ordenar o resultado por uma ou mais colunas.
	SELECT nome, salario
	FROM funcionarios
	ORDER BY salario DESC;

--	Limitar:
--		LIMIT limitar o número de linhas retornadas.
	SELECT nome, salario
	FROM funcionarios
	ORDER BY salario DESC
	LIMIT 10;



-- 04 - Subconsultas

-- 	Operadores:
--		IN: é usado para comparar um valor com uma lista de valores, incluindo os resultados de uma subconsulta.
		SELECT nome, salario
		FROM funcionarios
		WHERE departamento_id IN (SELECT id FROM departamentos WHERE localizacao = 'Nova York');

--		ANY: é usado para comparar um valor com qualquer valor retornado por uma subconsulta.
		SELECT nome, salario
		FROM funcionarios
		WHERE salario > ANY (SELECT salario FROM funcionarios WHERE departamento_id = 10);

--		ALL: é usado para comparar um valor com todos os valores retornados por uma subconsulta.
		SELECT nome, salario
		FROM funcionarios
		WHERE salario > ALL (SELECT salario FROM funcionarios WHERE departamento_id = 10);
		
------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------