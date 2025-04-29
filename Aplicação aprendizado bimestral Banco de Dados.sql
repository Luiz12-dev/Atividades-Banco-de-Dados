CREATE DATABASE IF NOT EXISTS mercadoOnline;
USE mercadoOnline;

CREATE TABLE IF NOT EXISTS categorias (
    id INT PRIMARY KEY,
    nome VARCHAR(50)
);

CREATE TABLE IF NOT EXISTS produtos (
    id INT PRIMARY KEY,
    nome VARCHAR(50),
    preco DECIMAL(10,2),
    categoria_id INT,
    FOREIGN KEY (categoria_id) REFERENCES categorias(id)
);

CREATE TABLE IF NOT EXISTS clientes (
    id INT PRIMARY KEY,
    nome VARCHAR(50)
);

CREATE TABLE IF NOT EXISTS pedidos (
    id INT PRIMARY KEY,
    cliente_id INT,
    FOREIGN KEY (cliente_id) REFERENCES clientes(id)
);

CREATE TABLE IF NOT EXISTS vendedores (
    id INT PRIMARY KEY,
    nome VARCHAR(50)
);

CREATE TABLE IF NOT EXISTS vendas (
    id INT PRIMARY KEY,
    produto_id INT,
    vendedor_id INT,
    quantidade INT,
    FOREIGN KEY (produto_id) REFERENCES produtos(id),
    FOREIGN KEY (vendedor_id) REFERENCES vendedores(id)
);
CREATE TABLE IF NOT EXISTS itens_pedido (
    id INT PRIMARY KEY,
    pedido_id INT,
    produto_id INT,
    quantidade INT,
    FOREIGN KEY (pedido_id) REFERENCES pedidos(id),
    FOREIGN KEY (produto_id) REFERENCES produtos(id)
);

SET FOREIGN_KEY_CHECKS = 0;


TRUNCATE TABLE itens_pedido;
TRUNCATE TABLE vendas;
TRUNCATE TABLE pedidos;
TRUNCATE TABLE produtos;
TRUNCATE TABLE categorias;
TRUNCATE TABLE clientes;
TRUNCATE TABLE vendedores;


SET FOREIGN_KEY_CHECKS = 1;


INSERT INTO categorias (id, nome) VALUES
(1, 'Periféricos'),
(2, 'Vídeo');

INSERT INTO clientes (id, nome) VALUES
(1, 'Ana'),
(2, 'Bruno'),
(3, 'Carla'),
(4, 'Daniel'),
(5, 'Elisa');


INSERT INTO pedidos (id, cliente_id) VALUES
(1, 1),
(2, 2),
(3, 1),
(4, 4),
(5, 2);


INSERT INTO vendedores (id, nome) VALUES
(1, 'Fernanda'),
(2, 'Gustavo'),
(3, 'Henrique'),
(4, 'Iara'),
(5, 'João');


INSERT INTO produtos (id, nome, preco, categoria_id) VALUES
(1, 'Teclado', 100.00, 1),
(2, 'Mouse', 50.00, 1),
(3, 'Monitor', 500.00, 2),
(4, 'Webcam', 200.00, 2),
(5, 'Headset', 150.00, 1);





INSERT INTO vendas (id, produto_id, vendedor_id, quantidade) VALUES
(1, 1, 1, 2),
(2, 2, 3, 1),
(3, 3, NULL, 5),
(4, 1, 2, 3),
(5, 5, NULL, 4);


INSERT INTO itens_pedido (id, pedido_id, produto_id, quantidade) VALUES
(1, 1, 1, 1),
(2, 1, 2, 2),
(3, 2, 5, 1),
(4, 3, 3, 1),
(5, 4, 4, 1);

SELECT * FROM categorias;

SELECT c.nome AS NomeCLiente, p.id AS PedidoID 
FROM clientes c
INNER JOIN pedidos p ON c.id = p.cliente_id;

SELECT pr.nome AS Produto, v.id AS VendaID 
From produtos pr 
LEFT JOIN vendas v ON pr.id = produto_id;

SELECT v.id AS VendaID, vd.nome AS Nome_Vendedor
FROM vendedores vd
RIGHT JOIN vendas V on vd.id = v.vendedor_id;

SELECT COUNT(*) AS TotalClientesCadastrados
FROM clientes;

SELECT SUM(quantidade) AS Total_Produtos_Vendidos 
FROM vendas;

SELECT ROUND(AVG(preco),2) AS PrecoMedioProdutos
FROM produtos;

SELECT 
	c.nome AS Cliente, ROUND(SUM(pr.preco * ip.quantidade),2) AS TotalGasto
FROM 
	clientes c
JOIN
	pedidos p ON c.id = p.cliente_id
JOIN
	itens_pedido ip ON p.id = ip.pedido_id
JOIN 
	produtos pr ON ip.produto_id = pr.id
GROUP BY 
	c.id,c.nome
ORDER BY 
	TotalGasto DESC;
    
    SELECT 
    c.nome AS Categoria, COUNT(v.id) AS Quantidade_Vendida
    FROM
    categorias c
    LEFT JOIN 
    produtos p ON c.id = p.categoria_id
    LEFT JOIN 
    vendas v ON p.id = v.produto_id
    GROUP BY 
     c.id, c.nome
     ORDER BY 
     Quantidade_Vendida DESC;
    
