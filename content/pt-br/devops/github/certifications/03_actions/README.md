# Actions

- https://learn.microsoft.com/en-us/collections/n5p4a5z7keznp5

## Automate development tasks by using GitHub Actions
## Build continuous integration (CI) workflows by using GitHub Actions
## Leverage GitHub Actions to publish to GitHub Packages
## Create and publish custom GitHub actions
## Build and deploy applications to Azure by using GitHub Actions
    - Introduction

    - Create a custom GitHub action
```docker
runs:
  using: 'docker'
  image: 'Dockerfile'
```

```nodejs
runs:
  using: 'node20'
  image: 'main.js'
```

```composite
runs:
  using: 'composite'
  steps:
    - run: ${{ github.action_path }}/test/script.sh
      shell: bash
```


Documentar a ação
Pode ser muito frustrante usar uma nova ferramenta ou aplicativo quando não existe documentação ou ela é vaga. É importante incluir uma boa documentação com a ação para que outras pessoas possam ver como ela funciona, independentemente de você planejar deixá-la pública ou privada. A primeira coisa a fazer é criar um arquivo README.md válido para sua ação.

O arquivo README.md é geralmente o primeiro item que os desenvolvedores examinarão para ver como a ação funciona. Esse é um ótimo lugar para incluir todas as informações importantes sobre a ação. Veja abaixo uma lista não exaustiva de coisas a serem incluídas:

Descrição detalhada do que a ação faz;
Argumentos obrigatórios de entrada e saída;
Argumentos opcionais de entrada e saída;
Segredos usados pela ação;
Variáveis de ambiente usadas pela ação;
Um exemplo de uso da ação no fluxo de trabalho.
Como regra geral, o arquivo README.md deve incluir tudo o que um usuário deve saber para usar a ação. Se você considera uma informação útil, inclua-a no README.md.

    - Publish a custom GitHub action

    - Exercise - Create a custom JavaScript GitHub action

    - Knowledge check
    
    - Summary
## Manage GitHub Actions in the enterprise