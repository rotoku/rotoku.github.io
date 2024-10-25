# Sonarqube


|REF|TIPO|DESCRIÇÃO|PORTA|
|---|---|---|---|
|1|Deployment|Sonarqube|5432|
|2|Service|Sonarqube|5432|
|3|Service|Sonarqube|30432|


minikube service postgresql-service-nodeport --url
minikube service sonarqube-service --url