# JJBike Data Warehouse e Dashboard

## Visão Geral

Este documento descreve o projeto de construção de um Data Warehouse On-Premises para a loja de ciclismo fictícia JJBike. O projeto teve como objetivo coletar dados de um Banco de Dados Relacional, armazená-los em uma Staging Area, transformá-los, carregá-los no Data Warehouse e construir um Dashboard. O Data Warehouse foi construído usando o `Oracle Database 21c` no ambiente `Red Hat Enterprise Linux 8`. O Dashboard foi construído usando o `Tableau` em uma máquina com Windows 11.

## Arquitetura do projeto

![Arquitetura do projeto](https://github.com/elvinmatheus/JJBike-DW/blob/main/images/Arquitetura.png)

1. **Extração dos dados:** Nesta etapa, os dados foram extraídos do banco de dados relacional da empresa JJBike. O método de extração escolhido foi a extração incremental, em que obtemos os dados diretamente da fonte.

2. **Staging Area:** Após a coleta, os dados foram armazenados em um Data Staging remoto.

3. **Transformação dos dados:** Na etapa de transformação ocorreram as rotinas de merging de dados e integração.

4. **Carga de dados:** Após a transformação, os dados foram carregados nas tabelas dimensões e fato do Data Warehouse.

5. **Construção do Dashboard:** O Data Warehouse foi conectado com o Tableau a fim de utilizar seus dados para a construção de Dashboards.

## Configuração e execução do Data Warehouse

1. **Criação dos Schemas:** Execute o script `01.config.sql` no Oracle DB para a criação dos Tablespaces e Schemas RELACIONAL, STAGEAREA e DATAWAREHOUSE;

2. **Criação do Banco de Dados Relacional:** Execute os scripts `02.create_relationalDB.sql` e `03.load_data.sql` para construir o banco de dados relacional. A modelagem relacional do banco de dados é exibida na imagem abaixo:

![Modelagem relacional](https://github.com/elvinmatheus/JJBike-DW/blob/main/images/Modelagem%20Relacional.png)

3. **Construção e carga da Staging Area:** Execute os scripts `04.create_stage.sql` e `05.extract_and_load_to_stage_area.sql` para construir e carregar a Staging Area.

4. **Transformação dos dados:** Execute o script `06.transform.sql` para realizar as rotinas de merge dos dados.

5. **Criação do Data Warehouse:** Execute o script `07.create_dw.sql` para criar as tabelas do Data Warehouse. A modelagem dimensional do DW é exibida na imagem abaixo:

![Modelagem dimensional](https://github.com/elvinmatheus/JJBike-DW/blob/main/images/Modelagem%20Dimensional.png)

6. **Carga nas tabelas dimensões e fato:** Execute os scripts `08.load_dimensions.sql` e `09.load_fact_table.sql` e `10.constraints.sql` para carregar as tabelas dimensões e fato do Data Warehouse, bem como adicionar as constraints na tabela fato. Na carga das tabelas dimensões é implementado o SCD tipo 2, em que é mantido o histórico de modificações realizados no banco de dados.

7. **KPI:** Execute o script `11.kpi.sql` para construir a tabela de KPI.

8. **Configuração do Dashboard:**

    - Baixe o Tableau [https://www.tableau.com/pt-br/products/trial](https://www.tableau.com/pt-br/products/trial). Será necessário prover alguns dados para efetuar o download;
    - Instale o Tableau em sua máquina;
    - Após a instalação, pode ser necessário baixar um driver para se conectar ao servidor com banco de dados Oracle. Baixe-o em [https://www.tableau.com/pt-br/support/drivers?edition](https://www.tableau.com/pt-br/support/drivers?edition). Procure por Oracle e escolha corretamente a versão do Tableau. Recomendo a instalação do driver Oracle OCI.
    - Após o download do driver, instale-o e reinicie o Tableau.
    - Na tela inicial, no lado esquerdo, clique em "Conectar a um servidor Oracle"
    
    ![Tela incial](https://github.com/elvinmatheus/JJBike-DW/blob/main/images/Tela%20Inicial.png)

    - Você deverá ver uma nova aba solicitando informações para efetivar a conexão com o banco de dados Oracle. Forneça o ip do seu servidor, bem como o nome do serviço, porta, nome de usuário e senha.
    
    ![Conexão Oracle](https://github.com/elvinmatheus/JJBike-DW/blob/main/images/Conex%C3%A3o%20Oracle.png)

    - Após efetivar a conexão, você verá o Schema do Data Warehouse e suas respectivas tabelas. A partir daí você poderá construir seus Dashboards. Abaixo seguem alguns exemplos:

    ![Gráfico 1](https://github.com/elvinmatheus/JJBike-DW/blob/main/images/Gr%C3%A1fico%201.png)

    ![Gráfico 2](https://github.com/elvinmatheus/JJBike-DW/blob/main/images/Gr%C3%A1fico%202.png)

    ![Gráfico 3](https://github.com/elvinmatheus/JJBike-DW/blob/main/images/Gr%C3%A1fico%203.png)
