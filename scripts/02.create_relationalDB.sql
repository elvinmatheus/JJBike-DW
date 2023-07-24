/* Conectado como usuário relacional */

CREATE SEQUENCE tb_vendedor_id_seq  START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE tb_produto_id_seq   START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE tb_cliente_id_seq   START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE tb_venda_id_seq     START WITH 1 INCREMENT BY 1;

CREATE TABLE tb_vendedor(
    id_vendedor INTEGER DEFAULT tb_vendedor_id_seq.NEXTVAL,
    nome        VARCHAR2(50),
    CONSTRAINT tb_vendedor_pk PRIMARY KEY (id_vendedor) ENABLE
);

CREATE TABLE tb_produto (
    id_produto  INTEGER DEFAULT tb_produto_id_seq.NEXTVAL,
    produto     VARCHAR2(100),
    preco       NUMBER(10,2),
    CONSTRAINT tb_produto_pk PRIMARY KEY (id_produto) ENABLE
);

CREATE TABLE tb_cliente (
    id_cliente  INTEGER DEFAULT tb_cliente_id_seq.NEXTVAL,
    cliente     VARCHAR2(50),
    estado      VARCHAR2(2),
    sexo        CHAR(1),
    status      VARCHAR2(50),
    CONSTRAINT tb_cliente_pk PRIMARY KEY (id_cliente) ENABLE
);

CREATE TABLE tb_venda (
    id_venda    INTEGER DEFAULT tb_venda_id_seq.NEXTVAL,
    id_vendedor INTEGER,
    id_cliente  INTEGER,
    data        DATE,
    total       DECIMAL(10,2),
    CONSTRAINT tb_venda_pk              PRIMARY KEY (id_venda) ENABLE,
    CONSTRAINT tb_venda_tb_vendedor_fk  FOREIGN KEY (id_vendedor)   REFERENCES tb_vendedor (id_vendedor)    ENABLE,
    CONSTRAINT tb_venda_tb_cliente_fk   FOREIGN KEY (id_cliente)    REFERENCES tb_cliente (id_cliente)      ENABLE
);

CREATE TABLE tb_itens_venda (
    id_produto      INTEGER,
    id_venda        INTEGER,
    quantidade      INTEGER,
    valor_unitario  DECIMAL(10, 2),
    valor_total     DECIMAL(10, 2),
    desconto        DECIMAL(10, 2),
    CONSTRAINT tb_itens_venda_pk            PRIMARY KEY (id_produto, id_venda) ENABLE,
    CONSTRAINT tb_itens_venda_tb_produto_fk FOREIGN KEY (id_produto)    REFERENCES tb_produto (id_produto)  ENABLE,
    CONSTRAINT tb_itens_venda_tb_venda_fk   FOREIGN KEY (id_venda)      REFERENCES tb_venda (id_venda)      ENABLE
);

GRANT SELECT ON relacional.tb_vendedor TO stagearea;
GRANT SELECT ON relacional.tb_produto TO stagearea;
GRANT SELECT ON relacional.tb_cliente TO stagearea;
GRANT SELECT ON relacional.tb_venda TO stagearea;
GRANT SELECT ON relacional.tb_itens_venda TO stagearea;