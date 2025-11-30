---
title: "Glue"
linkTitle: "Glue"
date: 2023-07-16
weight: 8
---

---------------
---------------
---------------

# Glue

O que é o AWS Glue?

O AWS Glue é um serviço de extração, transformação e carga (ETL) gerenciado e com pagamento
conforme o uso. O serviço automatiza as etapas demoradas de preparação de dados para análise.
O AWS Glue descobre e cria automaticamente o perfil dos dados usando o Glue Data Catalog,
recomenda e gera código ETL para transformar dados de origem em esquemas de destino, e ainda
executa as tarefas de ETL em um ambiente Apache Spark gerenciado com escalabilidade horizontal
para carregar os dados no destino. O serviço permite configurar, orquestrar e monitorar fluxos
de dados complexos.

Quais são os principais componentes do AWS Glue?

O AWS Glue consiste em um catálogo de dados, que é um repositório central de metadados;
um mecanismo de ETL que pode gerar automaticamente código Scala ou Python; e um programador
flexível que processa a resolução de dependências, o monitoramento de tarefas e as tentativas
de nova execução. Juntos, esses componentes automatizam a maior parte do trabalho pesado
genérico necessário para descobrir, categorizar, limpar, enriquecer e aprimorar dados,
permitindo que você invista mais tempo na análise dos dados.

AWS Glue has three core components:

Data Catalog – Serves as the central metadata repository. Tables and databases are objects in
the AWS Glue Data Catalog. They contain metadata; they don’t contain data from a data store.

Crawler – Discovers your data and associated metadata from various data sources (source or
target) such as S3, Amazon RDS, Amazon Redshift, and so on. Crawlers help automatically build
your Data Catalog and keep it up-to-date as you get new data and as your data evolves.

ETL Job – The business logic that is required to perform data processing. An ETL job is
composed of a transformation script, data sources, and data targets.

Advantages:
	(+) Servless
	(+) Schema-Inference
	(+) Autogen ETL scripts
	
1. Crawlers --> Classifiers --> Add classifier
	Type: CSV
2. Crawlers --> Add crawler 
	Name: CSVCrawler
	Associate classifier
3. Data Store --> Add Data Store
	Choose a data store: S3
	Specified path in my account
	Include path
4.	Choose an IAM
5. Create a schedule for this crawler
	Run by hourly
6. Configure the Crawler's output
	Add Database
7. Configure database connection
	Amazon RDS or Amazon Redshift
	database name
	user
	password
	Choose an IAM
8. Crawlers --> Add crawler 
	Name: RedshiftCrawler
	Data store
	JDBC
	Connection to Redshift
	Path /x/y/z/table_xpto
	IAM
	Hourly

csv to Redshift
create job
job bookmark: enable
ETL Language: Python
s3://script-load.py
data source csv
data target redshift
map the source columns
save job and edit script

Run job