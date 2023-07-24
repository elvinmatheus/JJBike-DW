/* Conectado como usuário stagearea */

-- Cria a tabela sta_dim_cliente
CREATE TABLE sta_dim_cliente (
    nk_id_cliente   NUMBER(20) NOT NULL,
    nm_cliente      VARCHAR2(50),
    nm_estado       VARCHAR2(2),
    nm_sexo         CHAR(1),
    nm_status       VARCHAR2(50),
    data_inicio     DATE,
    data_fim        DATE,
    flag_ativo      CHAR(1)
);

UPDATE sta_dim_cliente sdc 
SET data_fim = CURRENT_DATE,
    flag_ativo = 0
WHERE sdc.nk_id_cliente IN 
(
    WITH S AS 
    (
        SELECT * FROM sta_cliente ORDER BY id_cliente
    ),
    TO_UPD AS 
    (
        SELECT sdc.nk_id_cliente
        FROM sta_dim_cliente sdc
        INNER JOIN S ON sdc.nk_id_cliente = S.id_cliente
        WHERE sdc.data_fim IS NULL
        AND (sdc.nm_cliente <> S.cliente OR sdc.nm_estado <> S.estado OR sdc.nm_sexo <> S.sexo OR sdc.nm_status <> S.status)
    ) 
SELECT nk_id_cliente FROM TO_UPD);

INSERT INTO sta_dim_cliente (nk_id_cliente, nm_cliente, nm_estado, nm_sexo, nm_status, data_inicio, data_fim, flag_ativo)
SELECT 
    id_cliente,
    cliente,
    estado,
    sexo,
    status,
    CURRENT_DATE,
    NULL,
    1
FROM sta_cliente s
WHERE s.id_cliente IN 
(
    WITH S AS 
    (
        SELECT * FROM sta_cliente ORDER BY id_cliente
    ),
    TO_UPD AS 
    (
        SELECT sdc.nk_id_cliente
        FROM sta_dim_cliente sdc
        INNER JOIN S ON sdc.nk_id_cliente = S.id_cliente
        WHERE sdc.data_fim IS NULL
        AND (sdc.nm_cliente <> S.cliente OR sdc.nm_estado <> S.estado OR sdc.nm_sexo <> S.sexo OR sdc.nm_status <> S.status)
    ) 
SELECT nk_id_cliente FROM TO_UPD)
OR s.id_cliente NOT IN (SELECT nk_id_cliente FROM sta_dim_cliente);
commit;


-- Cria a tabela sta_dim_produto
CREATE TABLE sta_dim_produto (
    nk_id_produto   INTEGER,
    nm_produto      VARCHAR2(100),
    data_inicio     DATE,
    data_fim        DATE,
    flag_ativo      CHAR(1)
);

UPDATE sta_dim_produto sdp
SET data_fim = CURRENT_DATE, flag_ativo = 0
WHERE sdp.nk_id_produto IN 
(
    WITH S AS
    (
        SELECT * FROM sta_produto ORDER BY id_produto
    ),
    TO_UPD AS
    (
        SELECT sdp.nk_id_produto
        FROM sta_dim_produto sdp
        INNER JOIN S ON sdp.nk_id_produto = S.id_produto
        WHERE sdp.data_fim IS NULL
        AND (sdp.nm_produto <> S.produto)
    )
SELECT nk_id_produto FROM TO_UPD);

INSERT INTO sta_dim_produto (nk_id_produto, nm_produto, data_inicio, data_fim, flag_ativo)
SELECT
    id_produto,
    produto,
    CURRENT_DATE,
    NULL,
    1
FROM sta_produto sp
WHERE sp.id_produto IN 
(    
    WITH S AS
    (
        SELECT * FROM sta_produto ORDER BY id_produto
    ),
    TO_UPD AS
    (
        SELECT sdp.nk_id_produto
        FROM sta_dim_produto sdp
        INNER JOIN S ON sdp.nk_id_produto = S.id_produto
        WHERE sdp.data_fim IS NULL
        AND (sdp.nm_produto <> S.produto)
    )
    SELECT nk_id_produto FROM TO_UPD) 
OR sp.id_produto NOT IN (SELECT nk_id_produto FROM sta_dim_produto);
commit;

-- Cria a tabela sta_dim_vendedor
CREATE TABLE sta_dim_vendedor (
    nk_id_vendedor  INTEGER,
    nm_vendedor     VARCHAR2(50),
    data_inicio     DATE,
    data_fim        DATE,
    flag_ativo      CHAR(1)
);

UPDATE sta_dim_vendedor sdv
SET data_fim = CURRENT_DATE, flag_ativo = 0
WHERE sdv.nk_id_vendedor IN 
(    
    WITH S AS 
    (
        SELECT * FROM sta_vendedor ORDER BY id_vendedor
    ),
    TO_UPD AS
    (
        SELECT sdv.nk_id_vendedor
        FROM sta_dim_vendedor sdv
        INNER JOIN S ON sdv.nk_id_vendedor = S.id_vendedor
        WHERE sdv.data_fim IS NULL
        AND (sdv.nm_vendedor <> S.nome)
    )
SELECT nk_id_vendedor FROM TO_UPD);

INSERT INTO sta_dim_vendedor (nk_id_vendedor, nm_vendedor, data_inicio, data_fim, flag_ativo)
SELECT
    id_vendedor,
    nome,
    CURRENT_DATE,
    NULL,
    1
FROM sta_vendedor sv
WHERE sv.id_vendedor IN 
(
    WITH S AS 
    (
        SELECT * FROM sta_vendedor ORDER BY id_vendedor
    ),
    TO_UPD AS
    (
        SELECT sdv.nk_id_vendedor
        FROM sta_dim_vendedor sdv
        INNER JOIN S ON sdv.nk_id_vendedor = S.id_vendedor
        WHERE sdv.data_fim IS NULL
        AND (sdv.nm_vendedor <> S.nome)
    )
SELECT NK_id_vendedor FROM TO_UPD)
OR sv.id_vendedor NOT IN (SELECT nk_id_vendedor FROM sta_dim_vendedor);
commit;

-- Cria a tabela sta_fato_venda
CREATE TABLE sta_vendas (
    data_venda      DATE,
    id_vendedor     INTEGER,
    id_cliente      INTEGER,
    id_produto      INTEGER,
    quantidade      DECIMAL(10, 2),
    valor_unitario  DECIMAL(10, 2),
    valor_total     DECIMAL(10, 2),
    desconto        DECIMAL(10, 2)
);

-- Carga dos dados na tabela sta_fato_venda
INSERT INTO sta_vendas 
SELECT 
    v.data,
    v.id_vendedor,
    v.id_cliente,
    i.id_produto,
    i.quantidade,
    i.valor_unitario,
    i.valor_total,
    i.desconto
FROM sta_venda v, sta_itens_venda i
WHERE v.id_venda = i.id_venda;
commit;

GRANT SELECT ON stagearea.sta_dim_cliente   TO datawarehouse;
GRANT SELECT ON stagearea.sta_dim_produto   TO datawarehouse;
GRANT SELECT ON stagearea.sta_dim_vendedor  TO datawarehouse;
GRANT SELECT ON stagearea.sta_vendas        TO datawarehouse;