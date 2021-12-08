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

INSERT INTO aluno(primeiro_nome, ultimo_nome, data_nascimento) VALUES ('Leonardo', 'Siviero', '1989-04-03');
INSERT INTO aluno(primeiro_nome, ultimo_nome, data_nascimento) VALUES ('Rodrigo', 'Siviero', '1992-10-26');
INSERT INTO aluno(primeiro_nome, ultimo_nome, data_nascimento) VALUES ('Ana', 'Rosa', '1958-02-10');
INSERT INTO aluno(primeiro_nome, ultimo_nome, data_nascimento) VALUES ('Guerino', 'Siviero', '1959-12-25');
INSERT INTO aluno(primeiro_nome, ultimo_nome, data_nascimento) VALUES ('Carlos', 'Contreras', '1961-12-05');
INSERT INTO aluno(primeiro_nome, ultimo_nome, data_nascimento) VALUES ('Marilia', 'Araujo', '1962-06-19');
INSERT INTO aluno(primeiro_nome, ultimo_nome, data_nascimento) VALUES ('Pedro', 'Veiga', '1988-09-10');
INSERT INTO aluno(primeiro_nome, ultimo_nome, data_nascimento) VALUES ('Gabriela', 'Contreras', '1990-02-12');
INSERT INTO aluno(primeiro_nome, ultimo_nome, data_nascimento) VALUES ('Ronaldo', 'Silva', '1986-09-17');
INSERT INTO aluno(primeiro_nome, ultimo_nome, data_nascimento) VALUES ('Tiago', 'Martins', '1990-11-12');

INSERT INTO categoria(nome) VALUES ('Engenharia de dados');
INSERT INTO categoria(nome) VALUES ('Ciência de Dados');
INSERT INTO categoria(nome) VALUES ('Back-End');
INSERT INTO categoria(nome) VALUES ('Front-End');
INSERT INTO categoria(nome) VALUES ('Full-Stack');