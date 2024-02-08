---
title: "Linux"
linkTitle: "Linux"
date: 2023-07-16
weight: 8
---

---------------
---------------
---------------

# Linux

Linux é um termo popularmente empregado para se referir a sistemas operativos ou sistemas operacionais que utilizam o núcleo Linux. O núcleo foi desenvolvido pelo programador finlandês Linus Torvalds, inspirado no sistema Minix.

## Distribuições
- debian
    - ubuntu
    - lint
    - kali
- red hat
    - centos
- slack

## Licenças
- GPL v2
- GPL v3
- BSD
- Apache
- MIT
- Creative Commons

## GNU e Software Livre
GNU é um sistema operacional que é 100% software livre. Foi lançado em 1983 por Richard Stallman (rms) e foi desenvolvido por muitas pessoas trabalhando juntas em prol da liberdade de todos os usuários de software para controlar sua computação. Tecnicamente, o GNU geralmente é como o Unix. Mas ao contrário do Unix, o GNU dá liberdade aos seus usuários.

Liberdade != Gratuito
Debian Free Software Guidelines (DFSG):
1. Redistribuição livre
2. Código fonte
3. Trabalho derivados
4. Integridade do código fonte do autor
5. Não à discriminação contra pessoas e grupos
6. Não à discriminação contra a fins de utilização
7. Distribuição de licença
8. A licença não pode ser especifica para o Debian
9. A licença não deve contaminar outros softwares
10. Licenças exemplo

BSD é a sigla para "Berkeley Software Distribution". É o nome do código fonte distribuído pela Universidade da Califórnia, Berkeley, que era originalmente uma extensão do UNIX® desenvolvido pela área de pesquisa da AT&T. Diversos projetos de sistemas operacionais de código aberto foram baseados em uma versão deste código, conhecido como 4.4BSD-Lite. Além disso, eles incluem vários pacotes de outros projetos de código aberto, com destaque para os do projeto GNU. O sistema operacional geralmente abrange:
- O kernel BSD, que lida com o agendamento de processos, gerenciamento de memória, multi processamento simétrico (symmetric multi-processing ou SMP), drivers de dispositivos, etc.
- A biblioteca C, a API base do sistema.
- A biblioteca C do BSD é baseada no código de Berkeley, não no projeto GNU.
- Utilitários como shells, gerenciadores de arquivos, compiladores e linkers (conversores de arquivos compilados em executáveis).
- Alguns utilitários são derivados do projeto GNU, outros não são.
- O sistema X Window, que gerencia a interface gráfica.
O sistema X Window usado na maioria das versões do BSD é mantido pelo Projeto X.Org. O FreeBSD permite ao usuário escolher a partir de uma variedade de ambientes de desktop, tais como o Gnome, KDE ou Xfce; e gerenciadores gráficos (gerenciadores de janelas) mais leves, como Openbox, Fluxbox ou Awesome.
- Diversos outros programas e utilitários.

## Instalação do virtual box
```
wget -q https://www.virtualbox.org/download/oracle_vbox_2016.asc -O- | sudo apt-key add -
wget -q https://www.virtualbox.org/download/oracle_vbox.asc -O- | sudo apt-key add -

# Se for Ubuntu, substituir 'buster' pela release do Ubuntu
echo "deb [arch=amd64] https://download.virtualbox.org/virtualbox/debian buster contrib" > /etc/apt/sources.list.d/virtualbox.list

# Se for linux mint utilizar o comando abaixo
echo "deb [arch=amd64] http://download.virtualbox.org/virtualbox/debian focal contrib" > /etc/apt/sources.list.d/virtualbox.list

apt-get update
apt-get install make gcc libncurses5-dev linux-headers-$(uname -r)
apt-get install virtualbox-6.1
```

## Instalando Debian no VirtualBox
```
sudo su -
apt install tree coreutils bsdutils bsdmainutils net-tools man-db openssh-server -y 
```

## Clear Cache on Ubuntu and Linux Mint
```
sudo su -
/etc/init.d/dns-clean restart
/etc/init.d/networking force-reload
```

## Find All Extensions
```
find /home/${USER} -type f | sed -rn 's|.*/[^/]+\.([^/.]+)$|\1|p' | sort | uniq
```

## Find only directories non-case-sensitive and send error to /dev/null
```
find / -type d -iname "aws" 2>/dev/null
```


## get process by username
```sh
top -b -n 1 -u oracle
```

## configure alias for short keys
```sh
alias l.='ls -d .* --color=auto'
alias ll='ls -l --color=auto'
alias ls='ls --color=auto'
alias vi='vim'
alias which='alias | /usr/bin/which --tty-only --read-alias --show-dot --show-tilde'
```

## find and 1st occur quit
```sh
find . -name teste.xml -print -quit
```

## Extracting .tar.gz files
```sh
tar xvzf file.tar.gz
```

## Compress .tar.gz files
```sh
tar zcvf file.tar.gz file/
```


## Postman
```
$ wget https://dl.pstmn.io/download/latest/linux64 -O postman.tar.gz
Extract archive

$ sudo tar -xzf postman.tar.gz -C /opt
Make symlink

$ sudo ln -s /opt/Postman/Postman /usr/bin/postman
Optional: Remove downloaded file

$ rm postman.tar.gz
```

## List installed packages
```
sudo dpkg -l
or
apt list
```

## Command Line
```
# Listar arquivos ocultos
ls -a

# Listar arquivos backup
ls -B

# Listar apenas arquivos correntes
ls -A

# Listar os arquivos identificando os tipos de arquivos
ls -F
Pasta/
executavel*
linkSimbolico@
arquivo

# Listagem longa
ls -l

# Listar com o usuário
ls -o

# Listar sem o grupo
ls -G

# Listar com o grupo numerico
ls -ln

# Ordenação
ls -f

## Data de criação
ls -lat

## Data de criação inversa
ls -latr


## listar por extensão
ls -lhtax

## Diretório do usuário corrente
cd ~/

## volta para pasta anterior
cd -

## Diretório atual
pwd

## Voltar uma estrutura de diretório
cd ..

## cria um diretório
mkdir

## cria um diretório recursivo
mkdir -p /home/rkumabe/emptyDir1/emptyDir2

## Arvore de diretório
tree 
tree -a

## remover diretório
rmdir Pasta1

rmdir -p Pasta1/Pasta1_1/Pasta1_1_1

## Exibindo conteúdo de um arquivo
cat teste.txt
cat -n teste.txt
cat -s teste.txt
cat -b teste.txt
cat -e teste.txt
## tab ^I
cat -T teste.txt

## cat de forma invertida
tac teste.txt


rm teste.txt
rm -r dir
rm -rf dir

## Copia de forma recursiva
cp -r origin destin

## Copia também arquivos especiais, como por exemplo socket
cp -R origin destin

## copia somente se os arquivos da origem for mais novo que o do destino
cp -vru origin destin

## não cópia arquivos que esteja em uma partição diferente
cp -vrx origin destin

cp -a origin destin = cp -dpR origin destin

mv origin destin

mv -i origin destin

mv -uv origin destin
```

## Editores
- nano
- mcedit (sudo apt install mc -y)
- vim

## Escrevendo conteúdo como root
```
cat <<EOF | sudo tee /var/www/html/index.html
<h1>Hello World, Kumabe!</h1>
EOF

echo -e "<h1>Hello World, Kumabe\u0021</h1>" | sudo tee /var/www/html/index.html
```