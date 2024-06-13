---
title: "Git"
linkTitle: "Git"
date: 2023-07-16
weight: 3
---

---

---

---

# Git

[Visualização](https://git-school.github.io/visualizing-git/)

## O que é git?

- Git é um software para controle de versão de código (Version Control System)
- Git trabalha com repositórios distribuídos
- Git faz a gestão de repositórios, e cada pessoa na equipe pode ter o seu repositório.

## Outros sistemas

- CVS
- SVN
- Mercurial
- GIT

## Vantagens de utilizar um controle de versão

- Nos ajudam a manter um histórico de alterações;
- Nos ajudam a ter controle sobre cada alteração no código;
- Nos ajudam para que uma alteração de determinada pessoa não influencie na alteração realizada por outra;

## para o Git passar a enxergar determinada pasta como um repositório e a observar as mudanças em seus arquivos

```sh
git init
```

## analisar o estado do nosso repositório

```
git status
```

## adiciona os arquivos criados/alterados na pasta

```
git add .
```

## efetivar as alterações e criar uma mensagem explicativa

```
git commit -m "mensagem"
```

## configurações locais

```
git config --local user.name "Seu nome aqui"
git config --local user.email "seu@email.aqui"
```

## configurações globais

```
git config --global user.name "Seu nome aqui"
git config --global user.email "seu@email.aqui"
```

## verificando o histórico de alterações

```
git log
git log --pretty="%an realizou o commit %h: %s"
git log -l
git log -p
git log --oneline
git log --stat
git log --graph
```

## como fazer com o que o git ignore arquivos

```
touch .gitignore
echo "*.class \n ./target/" > .gitignore
```

## faz uma cópia do repositorio remoto

```
git clone https://github.com/rotoku/git.git
git clone https://github.com/rotoku/git.git O_NOME_QUE_EU_QUISER
```

## só contém as alterações dos arquivos (server side)

```
mkdir -p /home/rotoku/repo/server
cd /home/rotoku/repo/server
git init --bare
```

## adicionando um repositório remoto com o nome de "local"

git remote add local /home/rotoku/repo/server

## lista os repositórios remotos

git remote

## lista os repositórios de entrada e sáida

git remote -v

## Sincronizando os dados

git push local master

## atualizando local com a remota

git pull local master

- No Git Bash, logaremos como Vinicius e colaremos o comando, feito isso, no site do GitHub é indicado
- que devemos enviar os dados do repositório com git push -u origin master, cujo -u define que, sempre
- que usarmos git push e estivermos na master, o envio seja feito para origin. Ou seja, a partir de
- então poderemos executar simplesmente git push.

## branch local sabe qual é a branch remota à qual ela se refere

git push -u origin design

## branches locais

git branch

## branches remotas

git branch -r

## cria uma branch chamada develop

git branch develop

## vai para branch develop

git checkout develop

## criando branch baseado a uma branch remota

git branch -t design origin/design
git checkout --track origin/REMOTE_REPO

## cria e já faz checkout para a nova branch

git checkout -b frontend

## removendo a branch

git branch -d frontend

## removendo a branch mesmo que ela tenha commits à frente do master

git branch -D frontend

## branches remotas e locais

git branch -a

## Criação de uma branch local com o mesmo nome da branch remota,

## mudança para essa nova branch criada e Criação de link entre a branch local e remota

git checkout -t origin/design

## excluindo branch remota

git push -d origin design
git push origin :design

## Como saber se foram criadas branches novas no repositório remoto?

git fetch origin

## verificar as tags de versões

$ git tag
v0.1
v0.2

## mudar de versão

$ git checkout v0.1
Note: checking out 'v0.1'.

You are in 'detached HEAD' state. You can look around, make experimental
changes and commit them, and you can discard any commits you make in this
state without impacting any branches by performing another checkout.

If you want to create a new branch to retain commits you create, you may
do so (now or later) by using -b with the checkout command again. Example:

git checkout -b <new-branch-name>

HEAD is now at c5d6533... versao 0.1 do index.html

## diferença entre versões

$ git diff v0.1 v0.2
diff --git a/index.html b/index.html
index 84ea999..5e0f4ed 100644
--- a/index.html
+++ b/index.html
@@ -7,7 +7,7 @@

<body>
<h1>Git</h1>
<h2>Trabalhando em equipe com controle e seguranca</h2>

-               <h3>Versao 0.1</h3>

*                <ul>
                         <li>Fazer backup do seu projeto nao e o bastante para desfazer
                         alteracoes com seguranca e eficiencia</li>

# ============================================================================================================================================

mkdir curso-git
cd curso-git
$ git init
Initialized empty Git repository in C:/Users/rotoku/Desktop/curso-git/.git/
git ls-files
git status
git add
git commit -m "Mensagem..."
git whatchanged -p
git remote
git remote add origin https://github.com/rotoku/meu-site.git
git push origin master
git clone https://github.com/rotoku/meu-site.git
git branch
git branch design
git checkout design
git push origin design
============================================================================================================================================
============================================================================================================================================

## resolvendo conflito

git pull origin master
git push
git pull
editar manual o arquivo
git push

## fazendo merge do master com o design

git checkout master
git merge design

## atualiza uma branch com base em uma outra branch

git checkout design
git rebase
git checkout master
git push

## rebase coloca todos os commits da branch que esta especificando na atual!

## master é a base

git rebase master desenvolvimento
git rebase --continue

## desfazer alteração no arquivo

git checkout -- pom.xml

## para trazer o arquivo index.html de volta para a HEAD do projeto (remover do stage, que é o que será enviado para o commit);

git reset HEAD index.html

git reset
git reset --soft
git reset --hard
git reset 5fd2458984e02078559371d09c794f25697d2437

Qual é o atalho para referenciarmos o penúltimo commit?
git reset HEAD~2

git reset --hard HEAD~1

git revert 5fd2458984e02078559371d09c794f25697d2437

## Salvando temporariamente

## retomar um desenvolvimento

git stash

## listar os desenvolvimentos salvos na pilha de alterações

git stash list

## Como fazemos para recuperar o último estado salvo sem removê-lo da pilha de alterações?

git stash apply ID

## Como fazemos para recuperar o último estado salvo

git stash drop

## tira da pilha stash e aplica as modificações salvas

git stash pop

## procurar commit

git bisect start
git bisect bad HEAD
git bisect good 5fd2458984e02078559371d09c794f25697d2437
git bisect bad
git bisect good

git fetch original
git merge original/master
https://github.com/rotoku/repositorio/pull/543

## alias no local

git config alias.cm commit

## alias global

git config --global alias.r reset

Agora, ao rodar o comando git publica, todo o processo abaixo será feito, em ordem, e interrompido caso o anterior falhe:

git checkout master: altera o local de trabalho para a branch master
git pull: atualiza o histórico da branch master
git checkout dev: altera o local de trabalho para a branch dev
git rebase master: atualiza o HEAD da branch dev para receber as alterações da branch master
git checkout master: altera o local de trabalho novamente para a branch master
git merge dev: mescla as alterações da branch dev na master
git push: envia suas alterações para o repositório remoto

## enviar para o server a branch local

git push -u origin build_1.1

Delete Remote Branch [Updated on 8-Sep-2017]
As of Git v1.7.0, you can delete a remote branch using

$ git push <remote_name> --delete <branch_name>
which might be easier to remember than

$ git push <remote_name> :<branch_name>

## control + z do git

## Com o git checkout nós desfazemos uma alteração que ainda não foi adicionada ao index ou stage, ou seja, antes do git add.

git checkout -- index.html

## Depois de adicionar com git add, para desfazer uma alteração, precisamos tirá-la deste estado, com git reset.

git reset HEAD index.html

## Agora, se já realizamos o commit, o comando git revert pode nos salvar.

git revert 5fd2458984e02078559371d09c794f25697d2437

## Viajando no tempo

git checkout 3ae8dc3

## check-point (tag) ponto que não pode ser modificado

git tag -a v0.1.0 -m "Lançando a primeira versão (BETA) da aplicação"

git tag
v0.1.0

git push origin master

git push origin v0.1.0 (release no github)

## Issues

## Pull Request

## unir os 3 últimos commits

git rebase HEAD~3
pick
squash (entra no últmo commit)
squash (entra no últmo commit)

## alternativas

- bitbucket
- gitlab
- github corporate

## trás um determinado commit para a branch de trabalho

## Se uma implementação é necessária em sua branch e já foi feita em outra branch, pode fazer sentido trazer um commit específico, utilizando o git cherry-pick.

git cherry-pick HASH

## Quem adicionou uma determinada linha do código?

git blame index.html

## mostra todas as alterações aplicadas pelo commit com o hash informado.

git show {hash}

## git flow

master - hotfixes
release - versions
development - features

## hooks

pre-commit
post-receive

git --git-dir=""
--git-tree=""
checkout -f

##

git update-index --chmod=+x /media/rkumabe/DATA/workspaces/webapp/java/gradlew
git update-index --chmod=+x /media/rkumabe/DATA/workspaces/webapp/java/gradlew.bat
git status
git add .
git commit -m "chore: first commit"
git push
