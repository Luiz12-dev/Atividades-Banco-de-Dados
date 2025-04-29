
CREATE DATABASE IF NOT EXISTS empresa_db;
USE empresa_db;

CREATE TABLE IF NOT EXISTS departamentos (
    id_departamento INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(50) NOT NULL,
    localizacao VARCHAR(100)
);


CREATE TABLE IF NOT EXISTS funcionarios (
    id_funcionario INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    cargo VARCHAR(50),
    salario DECIMAL(10, 2),
    id_departamento INT,
    FOREIGN KEY (id_departamento) REFERENCES departamentos(id_departamento)
);


INSERT INTO departamentos (nome, localizacao) VALUES
('TI', 'Andar 5 - Sala 502'),
('Vendas', 'Andar 3 - Sala 301'),
('RH', 'Andar 2 - Sala 201'),
('Marketing', 'Andar 4 - Sala 401'),
('Financeiro', 'Andar 1 - Sala 101');

INSERT INTO funcionarios (nome, cargo, salario, id_departamento) VALUES
('João Silva', 'Desenvolvedor', 5500.00, 1),
('Maria Souza', 'Analista de Vendas', 4800.00, 2),
('Carlos Oliveira', 'Gerente de RH', 6200.00, 3),
('Ana Pereira', 'Designer', 4200.00, 4),
('Pedro Costa', 'Contador', 5800.00, 5),
('Luiza Mendes', 'Desenvolvedor Sênior', 7500.00, 1),
('Fernando Santos', 'Estagiário', 1800.00, NULL),  -- Sem departamento
('Juliana Lima', 'Analista Financeiro', 5200.00, 5),
('Roberto Alves', 'Coordenador de Marketing', 6000.00, 4),
('Patrícia Gomes', NULL, NULL, NULL);

SELECT 
    f.id_funcionario,
    f.nome AS nome_funcionario,
    f.cargo,
    f.salario,
    d.id_departamento,
    d.nome AS nome_departamento,
    d.localizacao
FROM 
    funcionarios f
LEFT JOIN 
    departamentos d ON f.id_departamento = d.id_departamento
ORDER BY 
    f.nome;