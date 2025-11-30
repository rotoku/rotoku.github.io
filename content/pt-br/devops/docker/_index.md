---
title: "Docker"
linkTitle: "Docker"
date: 2023-07-16
weight: 2
---

---------------
---------------
---------------

# Docker

```
docker image build -t example:0.0.1 .
docker container run -d example:0.0.1
docker container ls
docker logs -f 073825ff688a
docker container stats 073825ff688a
docker container update --cpus 0.5 --memory 128M 073825ff688a
```

## Volumes tipo bind
```
mkdir /opt/apl/volumes
docker container run -it --mount type=bind,src=/opt/apl/volumes,dst=/volumes debian
### readonly
docker container run -it --mount type=bind,src=/opt/apl/volumes,dst=/volumes,ro debian
```

## Volumes tipo volume
```
docker volume ls
docker volume create volumes
docker volume inspect volumes
docker volume inspect 0b1481d77fad642a8fc01f9c2b237ee4a76f0c8295d2d240edf5c78efcd906eb
docker container run -it --mount type=volume,src=volumes,dst=/volumes debian
```

## remover todos os volumes parados (grande chance de perda de dados)
```
docker volume prune
```

## remover todos as imagens paradas
```
docker image prune
```


```
docker container create -v /data --name dbdados centos
### sintaxe antiga
docker container run -d -p 5432:5432 --volumes-from dbdados --name pgsql1
docker container run -d -p 5434:5432 --volumes-from dbdados --name pgsql2
```


```
### criar um volume
docker volume create postgresql-volume

### subir 2 postgre utilizando um volume compartilhado
docker run --name postgresql1 -e "POSTGRES_PASSWORD=postgres" -e "TZ=America/Sao_Paulo" -p 5432:5432 --mount source=postgresql-volume,target=/var/lib/postgresql/data -d postgres
docker run --name postgresql2 -e "POSTGRES_PASSWORD=postgres" -e "TZ=America/Sao_Paulo" -p 5434:5432 --mount source=postgresql-volume,target=/var/lib/postgresql/data -d postgres
```

```
src = source
dst = destination
docker container run -ti --mount type=bind,src=/volume,dst=/volume ubuntu
docker container run -ti --mount type=bind,src=/root/primeiro_container,dst=/volume ubuntu
docker container run -ti --mount type=bind,src=/root/primeiro_container,dst=/volume,ro ubuntu
docker volume create giropops
docker volume rm giropops
docker volume inspect giropops
docker volume prune
docker container run -d --mount type=volume,source=giropops,destination=/var/opa  nginx
docker container create -v /data --name dbdados centos
docker run -d -p 5432:5432 --name pgsql1 --volumes-from dbdados -e POSTGRESQL_USER=docker -e POSTGRESQL_PASS=docker -e POSTGRESQL_DB=docker kamui/postgresql
docker run -d -p 5433:5432 --name pgsql2 --volumes-from dbdados -e  POSTGRESQL_USER=docker -e POSTGRESQL_PASS=docker -e POSTGRESQL_DB=docker kamui/postgresql
docker run -ti --volumes-from dbdados -v $(pwd):/backup debian tar -cvf /backup/backup.tar /data
```

### Backup de Docker
```
mkdir /opt/backup
docker container run -ti \
    --mount type=volume,src=dbdados,dst=/data \
    --mount type=bind,src=/opt/backup,dst=/backup debian \
    tar -cvf /backup/bkp-banco.tar /data
```

#### Dockerfile
```
mkdir dockerfiles
cd dockerfiles
touch Dockerfile

FROM debian
RUN apt-get update && apt-get install -y apache2 && apt-get clean
ENV APACHE_LOCK_DIR="/var/lock"
ENV APACHE_PID_FILE="/var/run/apache2.pid"
ENV APACHE_RUN_USER="www-data"
ENV APACHE_RUN_GROUP="www-data"
ENV APACHE_LOG_DIR="/var/log/apache2"
LABEL description="WebServer"
VOLUME /var/www/html/
EXPOSE 80
ENTRYPOINT ["/usr/sbin/apachectl"]
CMD ["-D","FOREGROUND"]
#OR
#CMD ["/usr/sbin/apachectl", "-D","FOREGROUND"]
```

### fazendo a construção da imagem
```
docker build -t meu_apache:1.0.0 .
docker image build -t meu_apache:1.0.0 .
```


### exemplo com distro baseada em RH
#### CENTOS
```
FROM centos
MAINTAINER Naohisa Orita

RUN rpm -ivh http://ftp.jaist.ac.jp/pub/Linux/Fedora/epel/6/i386/epel-release-6-8.noarch.rpm \
  ;yum -y install redis \
  ;yum clean all
```  

#### DEBIAN
```
FROM ubuntu

RUN apt-get update && \
  apt-get install -yq --no-install-recommends \
  git curl wget \
  && apt-get clean && rm -rf /var/lib/apt/list/*
```  
#### FEDORA
```
FROM feadora
RUN dnf makecache && \
  dnf install -y \
  git curl wget \
  && dnf clean all && rm -rf /var/cache/dnf/*
```  

#### aplicações
```  
ENV MRAVERSION v1.3.0
run git clone https://github.com/rotoku/example.git && \
  cd example && \
  git checkout -b build ${MRAVERSION} && \
  mvn clean install make install && \ && rm -rf /root/example

```  

## tamanhos dos binários
```  
du -sh *
```  

> se tiver uma porta exposta no container é feito um bind com o parâmetro -P, porém do lado do host é aleatória.

### Plugins
floker = plugin docker fs


```  
CMD:
  CMD ["git", "clone", "https://github.com/rotoku/example.git"]
  CMD git clone https://github.com/rotoku/example.git

ENTRYPOINT:
  ENTRYPOINT ["/app/python.py"]
  ENTRYPOINT /app/python.py

OR  
ENTRYPOINT ["/app/calculadora.py"]
CMD ["sum", "2", "2"]
```  

### Build com no-cache
```  
docker image build --no-cache -t opa:1.0.0 .
```  

### Argumentos
```  
FROM ubuntu
ARG VERSION
ENV VERSION $VERSION
RUN echo $VERSION

docker build --build-arg VERSION=2.4.7 Dockerfile
```  

```  
HEALTHCHECK --interval=5m --timeout=3s \
  CMD curl -f http://localhost/ || exit 1
```  



#### docker commit (atualizar uma imagem existente)
```  
docker commit -m "atualização da imagem" <CONTAINER_ID>
docker image tag <CONTAINER_ID> ubuntu_vim_curl:1.0.0
```  



### Docker Hub - Registry (https://index.docker.io/v1/)
```
#### Imagem local
meugo:2.0.0 (48939a57f848)
#### Tagueando para o remote
docker image tag 48939a57f848 rotoku/meugo:1.0.0
#### empurrando para o remote
docker push rotoku/meugo:1.0.0
```

### Registre dedicado
```
docker container run -d -p 5000:5000 --restart=always --name registry registry:2

docker image tag 48939a57f848 localhost:5000/meugo:1.0.0
OR
docker tag 48939a57f848 localhost:5000/meugo:1.0.0

docker image push localhost:5000/meugo:1.0.0
```

curl localhost:5000/v2/_catalog
curl localhost:5000/v2/meu_apache/tags/list