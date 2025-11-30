---
title: "Backstage"
linkTitle: "Backstage"
date: 2025-11-30
weight: 17
---

---------------
---------------
---------------

# Backstage

O framework de código aberto líder para a criação de portais para desenvolvedores, abordando a arquitetura e os recursos (Catalog, Scaffolder, TechDocs e Plugins).

Ao final deste curso, você deverá ser capaz de:

- Explique os benefícios de implementar um Portal do Desenvolvedor na sua organização.
- Explique o que é Backstage.
- Discuta a arquitetura do Backstage.
- Mapeie as necessidades da sua organização com o que o Backstage tem a oferecer.
- Crie um catálogo de bastidores.
- Explique como o Scaffolder do Backstage funciona.
- Explique como o TechDocs do Backstage funciona.
- Personalize o Backstage com plugins.

Um Portal do Desenvolvedor atende a três propósitos: ajuda os desenvolvedores a navegar em seu ecossistema, capacita engenheiros com recursos de autoatendimento e fornece aos líderes e equipes insights sobre a saúde e a maturidade da tecnologia.

Plataforma de desenvolvimento é um conjunto de recursos, documentação e ferramentas que dão suporte ao desenvolvimento, implantação, operação e/ou gerenciamento da entrega de produtos e serviços. Uma plataforma pode incluir portais web, APIs, CLIs, definições de protocolo, documentação, padrões e/ou modelos de caminho dourado. Quando bem implementadas, as plataformas permitem uma entrega mais rápida e confiável dos aplicativos e serviços de uma organização.

O Backstage foi criado pelo Spotify como uma necessidade que surgiu do seu rápido crescimento e da expansão da coleção de microsserviços. A equipe escreveu uma versão de código aberto e a doou para a Cloud Native Computing Foundation (CNCF), após o que seus valores e recursos levaram a uma recepção fantástica da comunidade. O Backstage se vê como um agregador de informações, em vez de uma única fonte de verdade. Ele promove a autonomia e exige propriedade clara. Esses valores significam que o Backstage é considerado uma estrutura, não um produto finalizado. Sua instância do Backstage será um aplicativo React/Node construído sobre as bibliotecas principais, cuja funcionalidade você pode definir instalando plugins.

Backstage layers:
- applications: Este aplicativo é o Portal do Desenvolvedor que você disponibilizará aos seus desenvolvedores. Ao adotar o Backstage, você interagirá mais com este recurso.
- plugins: Para estender a funcionalidade da sua instância, você pode instalar plugins nela. Até mesmo as funcionalidades básicas são abstraídas como plugins, incluindo o Catálogo. Assim, você sempre trabalhará com alguns plugins. Há algumas dezenas de plugins da comunidade disponíveis para integrar serviços populares. E você pode criar os seus próprios.
- core: É isso que a equipe do Backstage mantém e disponibiliza como código aberto. A menos que você queira contribuir com o projeto, talvez não precise se aprofundar neste assunto desde o início.

O Backstage oferece cinco funcionalidades principais: 
1. um catálogo de software
2. modelos de software (Scaffolder)
3. um gerador de documentação
4. um visualizador de cluster do Kubernetes
5. recursos de pesquisa entre ecossistemas.

- Explain what the Catalog is and how it works.
- Discuss what the Scaffolder does.
- Explain what Search does.
- Explain what TechDocs are.
- Discuss how you can use plugins to customize your developer portal.

## Algumas tecnologias utilizadas:
- Node
- React
- Docker
- PostgreSQL
- YARN

## Criando uma instância
```bash
npx @backstage/create-app
```

## Entrando no diretório e instalando as dependências
```bash
cd terroir-portal && yarn dev
yarn install && yarn start
```

## O Catálogo
O Catálogo é o recurso central do Backstage e é versátil o suficiente para que você possa registrar todos os seus ativos de software nele. Neste capítulo, você aprenderá a descrever um componente usando YAML, configurar uma integração com o GitHub e registrar um componente no seu Catálogo.


## Registrando Componentes no Catálogo
A entidade mais comum que você manipulará em sua instância do Backstage são os componentes. Componentes referem-se a componentes de software, como serviços, sites e bibliotecas, que normalmente são vinculados a um repositório cujo código produz instâncias implantadas ou artefatos vinculáveis. No Backstage, os componentes são descritos com metadados em um arquivo YAML armazenado no repositório onde seu código reside.

O Backstage precisa saber onde esses arquivos YAML estão localizados para adicioná-los ao Catálogo. Há duas maneiras de fazer isso: registrando manualmente um componente pela interface do Backstage e configurando um processador de entidades que descobre arquivos YAML no sistema de gerenciamento de código-fonte da sua organização.

Após registrar esses locais no Catálogo, o Backstage buscará os arquivos YAML deles. Portanto, o Backstage precisa de acesso para ler seu repositório e precisará de um token de acesso. O Backstage verificará periodicamente as informações nos arquivos de metadados para manter o Catálogo atualizado.

Neste capítulo, você aprenderá a escrever um arquivo YAML para descrever um componente de software, configurar uma integração com o GitHub para que o Backstage possa ler o arquivo do seu repositório e, finalmente, registrar um componente manualmente por meio da interface do usuário do Backstage.


```component-terroir-tracking-web.yaml
apiVersion: backstage.io/v1alpha1
kind: Component
metadata:
  name: terroir-tracking-web
  description: Find where your juice comes from
spec:
  type: website
  lifecycle: production
  owner: tracking-team
```

## type:
- website
- service
- library

## lifecycle:
- production
- experimental
- deprecated

## Entity Model

## Scaffold

## TechDocs

## Plugins in Backstage

- Feature plugins
- Extension plugins
- Integration plugin
- Entity providers
