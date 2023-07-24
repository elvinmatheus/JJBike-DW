/* Conectado como usuário stagearea */

TRUNCATE TABLE sta_cliente;
INSERT INTO sta_cliente 
SELECT * FROM relacional.tb_cliente;
commit;

TRUNCATE TABLE sta_produto;
INSERT INTO sta_produto
SELECT * FROM relacional.tb_produto;
commit;

TRUNCATE TABLE sta_vendedor;
INSERT INTO sta_vendedor
SELECT * FROM relacional.tb_vendedor;
commit;

TRUNCATE TABLE sta_venda;
INSERT INTO sta_venda
SELECT * FROM relacional.tb_venda;
commit;

TRUNCATE TABLE sta_itens_venda;
INSERT INTO sta_itens_venda
SELECT * FROM relacional.tb_itens_venda;
commit;