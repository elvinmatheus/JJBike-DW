/* Conectado como usuário datawarehouse */

CREATE TABLE kpi (
    nr_mes INTEGER,
    realizado NUMBER
);

INSERT INTO kpi
SELECT tb_dim_tempo.nr_mes AS nr_mes,
       SUM (tb_fato_vendas.valor_total) AS realizado
FROM tb_fato_vendas
INNER JOIN tb_dim_tempo ON tb_fato_vendas.sk_data = tb_dim_tempo.sk_data
GROUP BY tb_dim_tempo.nr_mes
ORDER BY tb_dim_tempo.nr_mes;

ALTER TABLE kpi ADD (meta NUMBER);

UPDATE kpi SET meta = 220000 WHERE nr_mes = 1;
UPDATE kpi SET meta = 220000 WHERE nr_mes = 2;
UPDATE kpi SET meta = 230000 WHERE nr_mes = 3;
UPDATE kpi SET meta = 235000 WHERE nr_mes = 4;
UPDATE kpi SET meta = 240000 WHERE nr_mes = 5;
UPDATE kpi SET meta = 250000 WHERE nr_mes = 6;
UPDATE kpi SET meta = 255000 WHERE nr_mes = 7;
UPDATE kpi SET meta = 260000 WHERE nr_mes = 8;
UPDATE kpi SET meta = 262500 WHERE nr_mes = 9;
UPDATE kpi SET meta = 265000 WHERE nr_mes = 10;
UPDATE kpi SET meta = 267000 WHERE nr_mes = 11;
UPDATE kpi SET meta = 270000 WHERE nr_mes = 12;