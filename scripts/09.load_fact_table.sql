/* Conectado como usuário datawarehouse */

INSERT INTO tb_fato_vendas
SELECT 
    vd.sk_vendedor                                           AS sk_vendedor,                                           
    c.sk_cliente                                             AS sk_cliente,                                            
    p.sk_produto                                             AS sk_produto,                                            
    TO_NUMBER(TO_CHAR(v.data_venda, 'yyyymmdd'), '99999999') AS sk_data,
    v.quantidade                                             AS quantidade,
    v.valor_unitario                                         AS valor_unitario,
    v.valor_total                                            AS valor_total,
    v.desconto                                               AS desconto
FROM stagearea.sta_vendas v, tb_dim_cliente c, tb_dim_produto p, tb_dim_vendedor vd
WHERE v.id_cliente = c.nk_id_cliente AND c.data_fim IS NULL
AND v.id_produto = p.nk_id_produto AND p.data_fim IS NULL 
AND v.id_vendedor = vd.nk_id_vendedor AND vd.data_fim IS NULL;
commit;