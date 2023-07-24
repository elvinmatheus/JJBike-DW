/* Conectado como usuário stagearea */

CREATE TABLE sta_vendedor(
    id_vendedor INTEGER NOT NULL,
    nome        VARCHAR2(50)
);

CREATE TABLE sta_produto (
    id_produto  INTEGER NOT NULL,
    produto     VARCHAR2(100),
    preco       NUMBER(10,2)
);

CREATE TABLE sta_cliente (
    id_cliente  INTEGER NOT NULL,
    cliente     VARCHAR2(50),
    estado      VARCHAR2(2),
    sexo        CHAR(1),
    status      VARCHAR2(50)
);

CREATE TABLE sta_venda (
    id_venda    INTEGER NOT NULL,
    id_vendedor INTEGER,
    id_cliente  INTEGER,
    data        DATE,
    total       DECIMAL(10,2)
);

CREATE TABLE sta_itens_venda (
    id_produto      INTEGER NOT NULL,
    id_venda        INTEGER NOT NULL,
    quantidade      INTEGER NOT NULL,
    valor_unitario  DECIMAL(10, 2),
    valor_total     DECIMAL(10, 2),
    desconto        DECIMAL(10, 2)
);