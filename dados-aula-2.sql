CREATE DATABASE alura;

CREATE TABLE aluno (
    id SERIAL PRIMARY KEY,
	primeiro_nome VARCHAR(255) NOT NULL,
	ultimo_nome VARCHAR(255) NOT NULL,
	data_nascimento DATE NOT NULL
);

CREATE TABLE categoria (
    id SERIAL PRIMARY KEY,
	nome VARCHAR(255) NOT NULL UNIQUE
);

CREATE TABLE curso (
    id SERIAL PRIMARY KEY,
	nome VARCHAR(255) NOT NULL,
	categoria_id INTEGER NOT NULL REFERENCES categoria(id)
);

CREATE TABLE aluno_curso (
	aluno_id INTEGER NOT NULL REFERENCES aluno(id),
	curso_id INTEGER NOT NULL REFERENCES curso(id),
	PRIMARY KEY (aluno_id, curso_id)
);

SELECT * FROM aluno;
SELECT * FROM categoria;
SELECT * FROM curso;
SELECT * FROM aluno_curso;

DROP TABLE aluno_curso, aluno, curso, categoria;

INSERT INTO aluno(primeiro_nome, ultimo_nome, data_nascimento) VALUES 
	('Vinicius', 'Dias', '1997-10-15'), 
	('Patricia', 'Freitas', '1986-10-25'), 
	('Diogo', 'Oliveira', '1984-08-27'), 
	('Maria', 'Rosa', '1985-01-01'),
	('Vinicius', 'Dias', '1997-10-15'), 
	('Patricia', 'Freitas', '1986-10-25'), 
	('Diogo', 'Oliveira', '1984-08-27'), 
	('Maria', 'Rosa', '1985-01-01');


INSERT INTO categoria(nome) VALUES 
	('Front-End'),
	('Programação'),
	('Banco de dados'),
	('Data Science');
	
INSERT INTO curso (nome, categoria_id) VALUES
	('HTML', 1),
	('CSS', 1),
	('JS', 1),
	('PHP', 2),
	('Java', 2),
	('C++', 2),
	('PostgreSQL', 3),
	('MySQL', 3),
	('Oracle', 3),
	('SQL Server', 3),
	('SQLite', 3),
	('Pandas', 4),
	('Machine Learning', 4),
	('Power BI', 4);

INSERT INTO aluno_curso VALUES (1, 4), (1, 11), (2, 1), (2, 2), (3, 4), (3, 3), (4, 4), (4, 6), (4, 5);

SELECT * FROM categoria WHERE id=4;
UPDATE categoria SET nome = 'Ciência de Dados' WHERE id=4;

SELECT * FROM aluno
	JOIN aluno_curso ON aluno_curso.aluno_id = aluno.id
	JOIN curso ON curso.id = aluno_curso.curso_id;

-- Pesquisar quantos cursos cada aluno está fazendo:

SELECT aluno.primeiro_nome, aluno.ultimo_nome, COUNT(curso.id) numero_cursos
	FROM aluno
	JOIN aluno_curso ON aluno_curso.aluno_id = aluno.id
	JOIN curso ON curso.id = aluno_curso.curso_id
	GROUP BY aluno.primeiro_nome, aluno.ultimo_nome; --Ou GROUP BY 1,2;

-- Outra maneira de fazer essa pesquisa de quantos cursos cada aluno está fazendo:

SELECT aluno.primeiro_nome, aluno.ultimo_nome, COUNT(aluno_curso.curso_id) numero_cursos
	FROM aluno
	JOIN aluno_curso ON aluno_curso.aluno_id = aluno.id
	GROUP BY 1,2
	ORDER BY numero_cursos ASC;

-- Cursos mais requisitados:

SELECT curso.nome, COUNT (aluno_curso.curso_id) qtd_matriculas
	FROM curso
	JOIN aluno_curso ON aluno_curso.curso_id = curso.id
	GROUP BY 1
	ORDER BY qtd_matriculas DESC
	LIMIT 1;

-- Categoria mais requisitados:

SELECT curso.categoria_id, COUNT (curso.categoria_id) AS qtd_categoria
	FROM curso
	JOIN aluno_curso ON aluno_curso.curso_id = curso.id
	GROUP BY curso.categoria_id
	ORDER BY qtd_categoria DESC
	LIMIT 1;
	
-- Ou então

SELECT categoria.nome, COUNT (aluno_curso.aluno_id) AS qtd_alunos
    FROM categoria
    JOIN curso ON curso.categoria_id = categoria.id
    JOIN aluno_curso ON aluno_curso.curso_id = curso.id
	GROUP BY 1
	ORDER BY qtd_alunos DESC
	LIMIT 1;
	
-- Utilização do Operador IN:

SELECT * FROM curso WHERE categoria_id = 1 OR categoria_id = 2;

-- Usando o operador IN:

SELECT * FROM curso WHERE categoria_id IN (1,2);

SELECT id FROM categoria WHERE nome NOT LIKE '% %';

-- Usando Subquerry:

SELECT * FROM curso WHERE categoria_id 
	IN (SELECT id FROM categoria WHERE nome NOT LIKE '% %');

-- Passo a passo da querry p/ contar quantos cursos tem dentro de cada categoria:

SELECT * FROM categoria;

SELECT *
	FROM categoria
	JOIN curso ON curso.categoria_id = categoria.id;

SELECT categoria.nome AS categoria, COUNT (curso.id) AS numero_cursos
	FROM categoria
	JOIN curso ON curso.categoria_id = categoria.id
	GROUP BY categoria;

-- Querry para ver categorias com mais de 3 cursos:	

SELECT categoria.nome AS categoria, COUNT (curso.id) AS numero_cursos
	FROM categoria
	JOIN curso ON curso.categoria_id = categoria.id
	GROUP BY categoria
	HAVING COUNT(curso.id) > 3;
	
-- Querry usando outra Querry para ver categorias com mais de 3 cursos:	
	
SELECT categoria, numero_cursos 
	FROM (
		SELECT categoria.nome AS categoria, COUNT (curso.id) AS numero_cursos
		FROM categoria
		JOIN curso ON curso.categoria_id = categoria.id
		GROUP BY categoria
	) AS categoria_cursos
	WHERE numero_cursos > 3;

-- Exercicio: Encontrar o número de alunos matriculados em cursos por ordem decrescente.

-- Primeiro passo:

SELECT * FROM curso;

-- Segundo passo:

SELECT * FROM curso
	JOIN aluno_curso ON aluno_curso.curso_id = curso_id;

-- Terceiro passo:

SELECT curso.nome, COUNT (aluno_curso.aluno_id) AS numero_alunos
	FROM curso
	JOIN aluno_curso ON aluno_curso.curso_id = curso.id
	GROUP BY 1;
	
-- Quarto passo:
		
SELECT curso.nome,
    COUNT(aluno_curso.aluno_id) numero_alunos
    FROM curso
    JOIN aluno_curso ON aluno_curso.curso_id = curso.id
	GROUP BY 1
    HAVING COUNT(aluno_curso.aluno_id) > 2
	ORDER BY numero_alunos DESC;
    
-- Quarto passo utilizando sub-querry ao inves de HAVING COUNT

SELECT curso, numero_alunos
	FROM (
		SELECT curso.nome AS curso,
		COUNT(aluno_curso.aluno_id) AS numero_alunos
		FROM curso
		JOIN aluno_curso ON aluno_curso.curso_id = curso.id
		GROUP BY 1
		ORDER BY numero_alunos DESC
	) AS curso_aluno;
	
-- ************************************************************************************* --
-- Até este ponto o conteúdo estudado é genérico e aplicável a qualquer tipo de banco de --
-- dados relacionais (SQL). A partir deste ponto o conteúdo é especifico do PostgreSQL.  --
-- ************************************************************************************* --

-- Funções de strings



	





	