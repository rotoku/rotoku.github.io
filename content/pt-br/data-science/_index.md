---
title: "Data Science"
date: 2023-06-16T16:08:13-03:00
weight: 1
---

---------
---------
---------

# Data Science

## Análise e Modelagem Preditiva
- Engenharia de atributos (Feature engineering)
    - Técnicas:
        - Pré-processamento de dados:
            - **Eliminação de atributos**
                - manual
                - automática
            - Integração de dados
                - dados distribuídos
                - identificação e combinação de dados
                - não remover atributo identificador
            - **Dados desbalanceados**
                - desequilibrio na qualidade
                - gerar novos dados
                - incluir artificialmente novos dados
                - remover objetos da classe majoritaria
            - Limpeza de dados
                - **dados ruidosos**
                - dados inconsistentes
                - dados redundantes
                - dados incompletos
            - Transformação de dados
                - **valor simbolico nominal**
                - valor simbolico ordinal
                - **valor numérico**
        - Estratégias de seleção de atributos:
            - Filtro
            - Wrapper
            - Embutida
- Tarefas:
    - classificação
    - regressão
    - agrupamento
    - mineração de itens frequentes
    - redução de dados

## Avaliação de Modelos Preditivos
- Processo de avaliação e métricas de erro
    - treinamento
        - dados históricos
        - treinamento
        - validação
    - estimação ou classificação
        - modelo preditivo --> teste
    - resultado preditivo

- Medidas de desempenho para classificação
    - matriz de confusão
        * verdadeiros positivos
        * falsos negativos
        * falsos positivos
        * verdadeiros negativos
        * N = vp + fn + fp + vn
    - tecnicas de reamostragem
        * amostragem holdout (dados históricos: 2/3 treinamento e 1/3 teste)
        * amostragem por validação cruzada
            - partições: k
            - repeticação: k
            - treinamento: k - 1
            - teste: 1
- Introdução à otimização de modelos
    - Otimização
    - Atributos
    - Modelo
    - Modelagem
        * overfitting
        * underfitting
    - Problemas
    - Estratégias