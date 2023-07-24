/* Conectado como usuário datawarehouse */

ALTER TABLE tb_fato_vendas 
    ADD CONSTRAINT fk_tb_fato_vendas_tb_dim_cliente
    FOREIGN KEY (sk_cliente) REFERENCES tb_dim_cliente (sk_cliente)
    ENABLE;

ALTER TABLE tb_fato_vendas
    ADD CONSTRAINT fk_tb_fato_vendas_tb_dim_vendedor
    FOREIGN KEY (sk_vendedor) REFERENCES tb_dim_vendedor (sk_vendedor)
    ENABLE;

ALTER TABLE tb_fato_vendas
    ADD CONSTRAINT fk_tb_fato_vendas_tb_dim_produto
    FOREIGN KEY (sk_produto) REFERENCES tb_dim_produto (sk_produto)
    ENABLE;

ALTER TABLE tb_fato_vendas
    ADD CONSTRAINT fk_tb_fato_vendas_tb_dim_tempo
    FOREIGN KEY (sk_data) REFERENCES tb_dim_tempo (sk_data)
    ENABLE;