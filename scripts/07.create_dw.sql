/* Conectado como usuário datawarehouse */

CREATE SEQUENCE dim_vendedor_id_seq START WITH 1 INCREMENT BY 1;

CREATE SEQUENCE dim_cliente_id_seq  START WITH 1 INCREMENT BY 1;

CREATE SEQUENCE dim_produto_id_seq  START WITH 1 INCREMENT BY 1;

CREATE TABLE tb_dim_cliente (
    sk_cliente      INTEGER DEFAULT dim_cliente_id_seq.NEXTVAL,
    nk_id_cliente   INTEGER,
    nm_cliente      VARCHAR2(50),
    nm_estado       VARCHAR2(2),
    nm_sexo         CHAR(1),
    nm_status       VARCHAR2(50),
    data_inicio     DATE,
    data_fim        DATE,
    flag_ativo      CHAR(1),
    CONSTRAINT tb_dim_cliente_pk PRIMARY KEY (sk_cliente) ENABLE
);

CREATE TABLE tb_dim_produto (
    sk_produto      INTEGER DEFAULT dim_produto_id_seq.NEXTVAL,
    nk_id_produto   INTEGER,
    nm_produto      VARCHAR2(100),
    data_inicio     DATE,
    data_fim        DATE,
    flag_ativo      CHAR(1),
    CONSTRAINT tb_dim_produto_pk PRIMARY KEY (sk_produto) ENABLE
);

CREATE TABLE tb_dim_vendedor (
    sk_vendedor     INTEGER DEFAULT dim_vendedor_id_seq.NEXTVAL,
    nk_id_vendedor  INTEGER,
    nm_vendedor     VARCHAR2(50),
    data_inicio     DATE,
    data_fim        DATE,
    flag_ativo      CHAR(1),
    CONSTRAINT tb_dim_vendedor_pk PRIMARY KEY (sk_vendedor) ENABLE
);

CREATE TABLE tb_dim_tempo (
    sk_data             INTEGER,
    full_date_formatted VARCHAR2(10),
    full_date           DATE,
    nr_dia_ano          INTEGER,
    nr_ano              INTEGER,
    nr_mes              INTEGER,
    nr_dia_mes          INTEGER,
    nm_mes              VARCHAR2(15),
    nr_dia_semana       INTEGER,
    nm_dia_semana       VARCHAR2(15),
    nr_semana           INTEGER,
    nm_ano_semana       VARCHAR2(15),
    nr_trimestre        INTEGER,
    nm_trimestre        VARCHAR2(15),
    nm_trimestre_abv    VARCHAR2(5),
    flag_fim_semana     VARCHAR2(15),
    flag_feriado_brasil VARCHAR2(15),
    nm_feriado          VARCHAR2(50),
    CONSTRAINT tb_dim_tempo_pk PRIMARY KEY (sk_data) ENABLE
);

CREATE TABLE tb_fato_vendas (
    sk_vendedor     INTEGER NOT NULL,
    sk_cliente      INTEGER NOT NULL,
    sk_produto      INTEGER NOT NULL,
    sk_data         INTEGER NOT NULL,
    quantidade      INTEGER,
    valor_unitario  DECIMAL(10, 2),
    valor_total     DECIMAL(10, 2),
    desconto        DECIMAL(10, 2),
    CONSTRAINT tb_fato_vendas_pk PRIMARY KEY (sk_vendedor, sk_cliente, sk_produto, sk_data) ENABLE
)
    PARTITION BY RANGE (sk_data) (
        PARTITION tb_fato_vendas_t1 VALUES LESS THAN ('20220331') TABLESPACE TBS_FATO_PART_T1,
        PARTITION tb_fato_vendas_t2 VALUES LESS THAN ('20220630') TABLESPACE TBS_FATO_PART_T2,
        PARTITION tb_fato_vendas_t3 VALUES LESS THAN ('20220930') TABLESPACE TBS_FATO_PART_T3,
        PARTITION tb_fato_vendas_t4 VALUES LESS THAN ('20221231') TABLESPACE TBS_FATO_PART_T4
    );