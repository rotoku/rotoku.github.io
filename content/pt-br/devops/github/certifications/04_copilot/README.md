# Copilot

A Microsoft desenvolveu o GitHub Copilot em colaboração com o OpenAI. O GitHub Copilot é alimentado pelo sistema OpenAI Codex. O OpenAI Codex tem amplo conhecimento de como as pessoas usam código e é mais eficiente do que o GPT-3 na geração de código. Isso se deve, em parte, ao treinamento em um vasto conjunto de dados de código-fonte público.

## Extensões para IDE:
- visual studio
- vscode
- intellij
- neovim

## Módulos:
- [X] IA responsável com GitHub Copilot
- [X] Introdução ao GitHub Copilot
- [X] Introdução à engenharia de prompts com o GitHub Copilot
- [X] Usando recursos avançados do GitHub Copilot
- [X] GitHub Copilot entre ambientes: Técnicas de IDE, chat e linha de comando
- [X] Considerações sobre gerenciamento e personalização com o GitHub Copilot
- [X] Casos de uso do desenvolvedor para IA com o GitHub Copilot
- [X] Desenvolver testes de unidade usando ferramentas do GitHub Copilot
- [X] Introdução ao GitHub Copilot Business
- [X] Introdução ao GitHub Copilot Enterprise
- [X] Usando o GitHub Copilot com JavaScript
- [X] Usar o GitHub Copilot com o Python


```bash
echo 'eval "$(gh copilot alias -- bash)"' >> ~/.bashrc
```

```zsh
echo 'eval "$(gh copilot alias -- zsh)"' >> ~/.zshrc
```

```powershell
gh copilot alias -- powershell | Out-File -Append -FilePath $profile
```

```cmd
gh copilot alias -- cmd >> %USERPROFILE%/alias.cmd
```

## Ignorando Arquivos no GH Copilot

O arquivo .copilotignore é usado para orientar o GitHub Copilot sobre quais arquivos ou diretórios ele deve ignorar ao sugerir código. Ele funciona de maneira semelhante ao .gitignore, mas é específico para o Copilot.

Como usar o .copilotignore:
Criar o arquivo: Crie um arquivo chamado .copilotignore na raiz do seu projeto ou em um diretório específico.
Adicionar padrões: Liste os arquivos ou diretórios que você deseja que o Copilot ignore. Use padrões globais, como *.log, node_modules/, ou caminhos específicos.
Exemplo:
´´´ 
# Ignorar arquivos de log
*.log

# Ignorar diretório de dependências
node_modules/

# Ignorar arquivos específicos
secrets.env
´´´ 

You can use fnmatch pattern matching notation to specify file paths. Patterns are case insensitive. See File in the ruby-doc.org documentation