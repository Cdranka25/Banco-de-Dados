-- comentário de linha
/*
Comentário de bloco 
*/

-- Criando uma tabela
CREATE TABLE usuario
(cd_usuario INT, 
 nm_usuario VARCHAR(50),
 ds_email VARCHAR(50),
 fl_genero CHAR(1)
 );
 
-- descrevendo uma tabela, isso também inicializa a tabela 
DESC usuario

-- adicionando uma PK na tabela (PK = PRIMARY KEY)
ALTER TABLE usuario
ADD PRIMARY KEY (cd_usuario);

-- ou no momento momento da criação da tabela, podemos indicar a pk
CREATE TABLE usuario
(cd_usuario INT, 
 nm_usuario VARCHAR(50),
 ds_email VARCHAR(50),
 fl_genero CHAR(1),
PRIMARY KEY (cd_usuario)
 );
 
 -- ou ainda, desta forma
 CREATE TABLE usuario
(cd_usuario INT PRIMARY KEY,
 nm_usuario VARCHAR(50),
 ds_email VARCHAR(50),
 fl_genero CHAR(1)
 );
 
-- descrevendo uma tabela
DESC usuario

-- criando uma tabela de "tipo usuario"
CREATE TABLE tipo_usuario
(tp_usuario INT,
ds_tipo VARCHAR(30) NOT NULL,
PRIMARY KEY (tp_usuario)
);
-----------------------------------------------------------------------------
-- adicionando nova coluna à tabela
ALTER TABLE usuario
ADD COLUMN dt_nascimento DATE;
-- adicionando coluna à tabela com propriedade DEFAULT
ALTER TABLE usuario
ADD COLUMN fl_genero CHAR(1) DEFAULT "F";

ALTER TABLE usuario
ADD COLUMN vl_peso DECIMAL(4,1) DEFAULT 50.5;

ALTER TABLE usuario
MODIFY COLUMN ds_email VARCHAR(50) DEFAULT "@furb.br";

-- removendo uma coluna da tabela
ALTER TABLE usuario
DROP COLUMN fl_genero;

--para corrigir o erro da PK, você primeiro elimina ela
ALTER TABLE tipo_usuario
DROP PRIMARY KEY;
-- e então você cria ela novamente
ALTER TABLE tipo_usuario
ADD PRIMARY KEY (tp_usuario);

-- removendo a tabela
DROP TABLE tipo_usuario


------------------------------------------------------------------------------

-- adicionando a coluna tp_usuario na tabela usuario
ALTER TABLE usuario
ADD COLUMN tp_usuario INT;

-- alterando a regra da coluna tp_usuario para torna-la FK
ALTER TABLE usuario
ADD FOREIGN KEY (tp_usuario) REFERENCES tipo_usuario (tp_usuario);

-- ou alterando a regra da coluna tp_usuario para torna-la FK
ALTER TABLE usuario
ADD constraint usuario_tipo_fk
	FOREIGN KEY (tp_usuario) REFERENCES tipo_usuario(tp_usuario);
	
	DESC usuario


-- adicionando a regra de unico para a coluna ds_email
-- esta regra não permite que sejam cadastrados usuarios com o mesmo ds_email
	ALTER TABLE usuario
	ADD constraint usuario_ds_email_uk UNIQUE KEY (ds_email);
	
	
-- Atualizar uma informação já inserida ou null 
UPDATE pessoa
	SET dt_nascimento = '2001-02-27',
		 ds_email = 'teste@gmail.com;'
WHERE cd_pessoa = 3;