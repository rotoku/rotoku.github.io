# DAY 08

## Secrets
Tipos de Secrets
Existem vários tipos de Secrets que você pode usar, dependendo de suas necessidades específicas. Abaixo estão alguns dos tipos mais comuns de Secrets:

Opaque Secrets - são os Secrets mais simples e mais comuns. Eles armazenam dados arbitrários, como chaves de API, senhas e tokens. Os Opaque Secrets são codificados em base64 quando são armazenados no Kubernetes, mas não são criptografados. Eles podem ser usados para armazenar dados confidenciais, mas não são seguros o suficiente para armazenar informações altamente sensíveis, como senhas de banco de dados.

kubernetes.io/service-account-token - são usados para armazenar tokens de acesso de conta de serviço. Esses tokens são usados para autenticar Pods com o Kubernetes API. Eles são montados automaticamente em Pods que usam contas de serviço.

kubernetes.io/dockercfg e kubernetes.io/dockerconfigjson - são usados para armazenar credenciais de registro do Docker. Eles são usados para autenticar Pods com um registro do Docker. Eles são montados em Pods que usam imagens de container privadas.

kubernetes.io/tls, kubernetes.io/ssh-auth e kubernetes.io/basic-auth - são usados para armazenar certificados TLS, chaves SSH e credenciais de autenticação básica, respectivamente. Eles são usados para autenticar Pods com outros serviços.

bootstrap.kubernetes.io/token - são usados para armazenar tokens de inicialização de cluster. Eles são usados para autenticar nós com o plano de controle do Kubernetes.


```
## opaque = generic
kubectl create secret generic kumabes-org-secret \
    --from-literal=username=cm90b2t1 \
    --from-literal=password=cGFzc3dvcmQ=
```

### SSL
```
openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout chave-privada.key -out certificado.crt
BR
SP
São Bernardo do Campo
Kumabe's Org
IT

ls -lrth

kubectl create secret tls meu-servico-web-tls-secret \
    --cert=certificado.crt \
    --key=chave-privada.key
```

## ConfigMaps
```
kubectl create configmap nginx-config --from-file=nginx.conf

kubectl get configmap nginx-config

kubectl describe configmap nginx-config

kubectl get configmap nginx-config -o yaml > nginx-config.yaml
```



## Desafio: Criar um nginx com https
```
cat <<EOF > nginx.conf
user  nginx;
worker_processes  auto;

error_log  /var/log/nginx/error.log notice;
pid        /var/run/nginx.pid;


events {
    worker_connections  1024;
}

http {
    server {
        listen 80;

        location / {
            return 200 'Olá terraqueos e extraterrestres!\n';
            add_header Content-Type text/plain;
        }
    }
}
EOF

kubectl create configmap nginx-config --from-file nginx.conf

openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout chave-privada.key -out certificado.crt

kubectl create secret tls nginx-secret \
    --cert=certificado.crt \
    --key=chave-privada.key

cat <<EOF > nginx-https.yaml
apiVersion: v1
kind: Pod
metadata:
  name: nginx
  labels:
    app: nginx
spec:
  containers:
  - name: nginx
    image: nginx:1.25.1
    ports:
    - containerPort: 80
    - containerPort: 443
    volumeMounts:
    - name: nginx-config-volume
      mountPath: /etc/nginx/nginx.conf
      subPath: nginx.conf
    - name: nginx-tls
      mountPath: /etc/nginx/tls
  volumes:
  - name: nginx-config-volume
    configMap:
      name: nginx-config
  - name: nginx-tls
    secret:
      secretName: meu-servico-web-tls-secret
      items:
        - key: tls.crt
          path: certificado.crt
        - key: tls.key
          path: chave-privada.key
EOF
```

### Create a ConfigMap from a directory
```
mkdir -p ./cm_dir
cd ./cm_dir
cat <<EOF > db.properties
url=jdbc:mysql://localhost
port=3306
db=mydb
username=root
password=mypassword
EOF

cat <<EOF > ms.properties
url=https://kumabes-org.com.br/services/oauth2/token
client_id=client_id
client_secret=client_secret
grant_type=authorization_code
EOF
  
cd ..  

cat <<EOF > log4j.properties
#Define console appender
log4j.appender.console=org.apache.log4j.ConsoleAppender
logrj.appender.console.Target=System.out
log4j.appender.console.layout=org.apache.log4j.PatternLayout
log4j.appender.console.layout.ConversionPattern=%-5p %c{1} - %m%n

#Define rolling file appender
log4j.appender.file=org.apache.log4j.RollingFileAppender
log4j.appender.file.File=logs/main.log
log4j.appender.file.Append=true
log4j.appender.file.ImmediateFlush=true
log4j.appender.file.MaxFileSize=10MB
log4j.appender.file.MaxBackupIndex=5
log4j.appender.file.layout=org.apache.log4j.PatternLayout
log4j.appender.file.layout.ConversionPattern=%d %d{Z} [%t] %-5p (%F:%L) - %m%n
EOF

# Create the ConfigMap from dir
kubectl create configmap db-and-ms-config --from-file=./cm_dir/

# display details of the ConfigMap
kubectl describe configmaps db-and-ms-config

# display details of the ConfigMap in yaml format
kubectl get configmaps db-and-ms-config -o yaml

# Create the ConfigMap from single file
kubectl create configmap db-config --from-file=./cm_dir/db.properties

# Create the ConfigMap from multiple files
kubectl create configmap db-and-log4j-config --from-file=./cm_dir/db.properties --from-file=./log4j.properties

kubectl create configmap nginx-config --from-file=nginx.conf

cat <<EOF > application.properties
app.name=MyApp
app.version=1.0.0
EOF
## create a ConfigMap from an env-file, for example
kubectl create configmap app-config --from-env-file=application.properties
kubectl get configmaps app-config -o yaml

## Starting with Kubernetes v1.23, kubectl supports the --from-env-file argument to be specified multiple times to create a ConfigMap from multiple data sources.
kubectl create configmap config-multi-env-files \
        --from-env-file=configure-pod-container/configmap/game-env-file.properties \
        --from-env-file=configure-pod-container/configmap/ui-env-file.properties


## Define the key to use when creating a ConfigMap from a file
kubectl create configmap database-config --from-file=database=./cm_dir/db.properties

## Create ConfigMaps from literal values
kubectl create configmap special-config --from-literal=special.how=very --from-literal=special.type=charm
kubectl get configmaps special-config -o yaml
```