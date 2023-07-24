/* Conectado como usuário datawarehouse */

-- Carrega a tabela tb_dim_tempo
INSERT INTO tb_dim_tempo
SELECT
    TO_CHAR(TO_DATE('31/12/2019', 'DD/MM/YYYY')                 + NUMTODSINTERVAL(n, 'day'), 'YYYYMMDD')                                AS sk_data,
    TO_CHAR(TO_DATE('31/12/2019', 'DD/MM/YYYY')                 + NUMTODSINTERVAL(n, 'day'), 'DD/MM/YYYY')                              AS full_date_formatted,
	TO_DATE('31/12/2019', 'DD/MM/YYYY')                         + NUMTODSINTERVAL(n, 'day')                                             AS full_date,
    TO_CHAR(TO_DATE('31/12/2019', 'DD/MM/YYYY')                 + NUMTODSINTERVAL(n, 'day'), 'DDD')                                     AS nr_dia_ano,
    TO_CHAR(TO_DATE('31/12/2019', 'DD/MM/YYYY')                 + NUMTODSINTERVAL(n, 'day'), 'YYYY')                                    AS nr_ano,
    TO_CHAR(TO_DATE('31/12/2019', 'DD/MM/YYYY')                 + NUMTODSINTERVAL(n, 'day'), 'MM')                                      AS nr_mes,
    TO_CHAR(TO_DATE('31/12/2019', 'DD/MM/YYYY')                 + NUMTODSINTERVAL(n, 'day'), 'DD')                                      AS nr_dia_mes,
    TO_CHAR(TO_DATE('31/12/2019', 'DD/MM/YYYY')                 + NUMTODSINTERVAL(n, 'day'), 'MONTH', 'NLS_DATE_LANGUAGE=PORTUGUESE')   AS nm_mes,
    TO_CHAR(TO_DATE('31/12/2019', 'DD/MM/YYYY')                 + NUMTODSINTERVAL(n, 'day'), 'D')                                       AS nr_dia_semana,
    TO_CHAR(TO_DATE('31/12/2019', 'DD/MM/YYYY')                 + NUMTODSINTERVAL(n, 'day'), 'DAY', 'NLS_DATE_LANGUAGE=PORTUGUESE')     AS nm_dia_semana,
    TO_CHAR(TO_DATE('31/12/2019', 'DD/MM/YYYY')                 + NUMTODSINTERVAL(n, 'day'), 'WW')                                      AS nr_semana,
    TO_CHAR(TO_DATE('31/12/2019', 'DD/MM/YYYY')                 + NUMTODSINTERVAL(n, 'day'), 'YYYY') || '/' || 
    TO_CHAR(TO_DATE('31/12/2019', 'DD/MM/YYYY')                 + NUMTODSINTERVAL(n, 'day'), 'WW')                                      AS nm_ano_semana,
    TO_CHAR(TO_DATE('31/12/2019', 'DD/MM/YYYY')                 + NUMTODSINTERVAL(n, 'day'), 'Q')                                       AS nr_trimestre,
    'Trimestre-' || TO_CHAR(TO_DATE('31/12/2019', 'DD/MM/YYYY') + NUMTODSINTERVAL(n, 'day'), 'Q')                                       AS nm_trimestre,
    'T'          || TO_CHAR(TO_DATE('31/12/2019', 'DD/MM/YYYY') + NUMTODSINTERVAL(n, 'day'), 'Q')                                       AS nm_trimestre_abv,

    CASE 
        WHEN TO_CHAR(TO_DATE('31/12/2019', 'DD/MM/YYYY') + NUMTODSINTERVAL(n, 'day'), 'D') IN (1,7) THEN 'FIM DE SEMANA' 
    ELSE 'DIA DE SEMANA' 
    END AS flag_fim_semana,

    CASE 
        WHEN TO_CHAR(TO_DATE('31/12/2019', 'DD/MM/YYYY') + NUMTODSINTERVAL(n, 'day'), 'MMDD') 
        IN (0101, 0212, 0213, 0330, 0421, 0501, 0531, 0907, 1012, 1102, 1115, 1225) THEN 'SIM'
    ELSE 'NAO'
    END AS flag_feriado_brasil,

    CASE 
        WHEN TO_CHAR(TO_DATE('31/12/2019', 'DD/MM/YYYY') + NUMTODSINTERVAL(n, 'day'), 'MMDD') = '0101' THEN 'ANO NOVO'
        WHEN TO_CHAR(TO_DATE('31/12/2019', 'DD/MM/YYYY') + NUMTODSINTERVAL(n, 'day'), 'MMDD') = '0212' THEN 'CARNAVAL'
        WHEN TO_CHAR(TO_DATE('31/12/2019', 'DD/MM/YYYY') + NUMTODSINTERVAL(n, 'day'), 'MMDD') = '0213' THEN 'CARNAVAL'
        WHEN TO_CHAR(TO_DATE('31/12/2019', 'DD/MM/YYYY') + NUMTODSINTERVAL(n, 'day'), 'MMDD') = '0330' THEN 'SEXTA-FEIRA SANTA'
        WHEN TO_CHAR(TO_DATE('31/12/2019', 'DD/MM/YYYY') + NUMTODSINTERVAL(n, 'day'), 'MMDD') = '0421' THEN 'TIRADENTES'
        WHEN TO_CHAR(TO_DATE('31/12/2019', 'DD/MM/YYYY') + NUMTODSINTERVAL(n, 'day'), 'MMDD') = '0501' THEN 'DIA DO TRABALHADOR'
        WHEN TO_CHAR(TO_DATE('31/12/2019', 'DD/MM/YYYY') + NUMTODSINTERVAL(n, 'day'), 'MMDD') = '0531' THEN 'CORPUS CHRISTI'
        WHEN TO_CHAR(TO_DATE('31/12/2019', 'DD/MM/YYYY') + NUMTODSINTERVAL(n, 'day'), 'MMDD') = '0907' THEN 'INDEPENDÊNCIA DO BRASIL'
        WHEN TO_CHAR(TO_DATE('31/12/2019', 'DD/MM/YYYY') + NUMTODSINTERVAL(n, 'day'), 'MMDD') = '1012' THEN 'NOSSA SENHORA APARECIDA'
        WHEN TO_CHAR(TO_DATE('31/12/2019', 'DD/MM/YYYY') + NUMTODSINTERVAL(n, 'day'), 'MMDD') = '1102' THEN 'FINADOS'
        WHEN TO_CHAR(TO_DATE('31/12/2019', 'DD/MM/YYYY') + NUMTODSINTERVAL(n, 'day'), 'MMDD') = '1115' THEN 'PROCLAMAÇÃO DA REPÚBLICA'
        WHEN TO_CHAR(TO_DATE('31/12/2019', 'DD/MM/YYYY') + NUMTODSINTERVAL(n, 'day'), 'MMDD') = '1225' THEN 'NATAL'
    ELSE 'DIA COMUM'
    END AS nm_feriado
    
    FROM (
        SELECT LEVEL n 
        FROM dual 
        CONNECT BY LEVEL <= 2000
    )
    ORDER BY SK_DATA DESC;
commit;

-- Carrega a tabela tb_dim_cliente
INSERT INTO tb_dim_cliente
SELECT 
    dim_cliente_id_seq.NEXTVAL,
    nk_id_cliente,
    nm_cliente,
    nm_estado,
    nm_sexo,
    nm_status,
    data_inicio,
    data_fim,
    flag_ativo
FROM stagearea.sta_dim_cliente;
commit;

-- Carrega a tabela tb_dim_produto
INSERT INTO tb_dim_produto
SELECT 
    dim_produto_id_seq.NEXTVAL,
    nk_id_produto,
    nm_produto,
    data_inicio,
    data_fim,
    flag_ativo
FROM stagearea.sta_dim_produto;
commit;

-- Carrega a tabela tb_dim_vendedor
INSERT INTO tb_dim_vendedor
SELECT 
    dim_vendedor_id_seq.NEXTVAL,
    nk_id_vendedor,
    nm_vendedor,
    data_inicio,
    data_fim,
    flag_ativo
FROM stagearea.sta_dim_vendedor;
commit;