---
title: "Helm"
linkTitle: "Helm"
date: 2024-07-17
weight: 7
---

---

---

---

# HELM

## What is Helm?

Helm é um gerenciador de pacotes para Kubernetes. Ele usa 'gráficos' como formato de pacote, que é baseado em YAML. Helm foi aceito na Cloud Native Computing Foundation em 1º de junho de 2018 no nível de maturidade Incubadora e depois passou para o nível de maturidade Graduado em 1º de maio de 2020.

## Values.yaml

We have a single location, where we can declare every custom settings.

## Basic command:

```
helm install my-wordpress wordpress
helm upgrade wordpress
helm rollback wordpress
helm uninstall wordpress
```

## Installation

```
sudo snap install helm --classic
```

```
curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3
chmod 700 get_helm.sh
./get_helm.sh
```

```
pkg install helm
```

```
brew install helm
```

## Helm 2 vs Helm 3

- helm 1: February 2016
- helm 2: November 2016
- helm 3: November 2019

## helm 2

| CLIENT SIDE  | K8S SIDE                  | 3-Way Strategic Merge Patch |
| ------------ | ------------------------- | --------------------------- |
| helm cli --> | Tiller --> k8s api server | No                          |

## helm 3

| CLIENT SIDE  | K8S SIDE       | 3-Way Strategic Merge Patch |
| ------------ | -------------- | --------------------------- |
| helm cli --> | k8s api server | Yes                         |

## Snapshot concepts Helm 2

### Revision 1

```
apiVersion: v1
kind: Pod
metadata:
name: nginx
labels:
app: nginx
spec:
containers:
- name: nginx
image: nginx:1.25.2-alpine
ports:
- containerPort: 80
```

```
helm install my-nginx nginx
```

### Revision 2

```
apiVersion: v1
kind: Pod
metadata:
name: nginx
labels:
app: nginx
spec:
containers:
- name: nginx
image: nginx:1.25.3-alpine
ports:
- containerPort: 80
```

```
helm upgrade nginx
```

### Revision 3

> same revision 1

```
helm rollback nginx
```

## Snapshot concepts Helm 3

### 3-Way Strategic Merge Patch

2 (Previous Chart)<--> 1 (Current Chart)
^ ^
| |
3 (Live State)-----------

## Helm Components

- Helm CLI
- Helm Charts: Charts are a collection of files. They contain all the instructions that helm needs to be able to create the collection of objects that you need in your Kubernetes cluster.

## Examples:

### nginx

#### Template

```service.yaml
apiVersion: v1
kind: Service
metadata:
name: hello-world
spec:
type: NodePort
ports:
- port: 80
targetPort: http
protocol: TCP
name: http
selector:
app: hello-world
```

#### Template

```deployment.yaml
apiVersion: apps/v1
kind: Deployment
metadata:
name: hello-world
spec:
replicas: {{ .Values.replicaCount }}
selector:
matchLabels:
app: hello-world
template:
metadata:
labels:
app: hello-world
spec:
containers:
- name: nginx
image: {{ .Values.image.repository }}:{{ .Values.image.tag }}
ports:
- containerPort: 80
name: http
protocol: TCP
```

#### Values

```values.yaml
replicaCount: 1
image:
repository: nginx
tag: 1.19.0
```

## Helm Repositories

- [Artifact Hub](https://artifacthub.io/)
- Appscode
- TrueCharts
- Bitnami
- Community Operators

## Helm Charts

```Chart.yaml
apiVersion: v2 ## v1 use for helm 2 OR v2 form helm 3
appVersion: 5.8.1
version: 12.1.17
name: wordpress
description: Web publishing platform for building blogs and websites.
type: application ## application OR library
dependencies:
- condition: mariadb.enabled
name: mariadb
version: 9.X.X
repository: https://charts.bitnami.com/bitnami
keywords:
- wordpress
- cms
- blog
- website
maintainers:
- name: Bitnami
email: containers@bitnami.com
home: https://bitnami.com
icon: https://bitnami.com/assets/stacks/wordpress/img/wordpress-stack-220x234.png
```

## Helm Chart Structure

> hello-world-chart
> --> templates # Templates directory
> ----> values.yaml # Configuration values
> ----> Chart.yaml # Chart information
> ----> LICENSE # License for the chart
> ----> README.md # Readme file
> --> charts # Dependencies charts

## Working with Helm: basics

```

helm -h ## Helm provides a number of subcommands for working with charts. Use the -h flag to get help on the available subcommands.

helm repo -h ## Repositories are locations where charts can be stored. Use the repo subcommands to add, list, remove, and update repositories.

helm search -h ## Search provides the ability to search for Helm charts in the various places they can be stored including the Artifact Hub and repositories you have added. Use search subcommands to search different locations for charts.


helm search hub <WHAT_YOU_WANT_TO_SEARCH> ## search for charts in the Artifact Hub or your own hub instance

helm search repo <WHAT_YOU_WANT_TO_SEARCH> ## search repositories for a keyword in charts

## Example
$ helm search repo kube-prometheus-stack
NAME CHART VERSION APP VERSION DESCRIPTION
prometheus/kube-prometheus-stack 60.4.0 v0.74.0 kube-prometheus-stack collects Kubernetes manif...

## Add a repository
helm repo add prometheus https://prometheus-community.github.io/helm-charts
helm repo add actions-runner-controller https://actions-runner-controller.github.io/actions-runner-controller
helm repo update
```

## Install Helm Chart

```
helm install my-wordpress bitnami/wordpress

helm upgrade --install --namespace actions-runner-system --create-namespace \
--wait actions-runner-controller actions-runner-controller/actions-runner-controller
```

## Login at the repository

```
echo "$GITHUB_TOKEN" | docker login ghcr.io -u $GITHUB_ACTOR --password-stdin
echo "$GITHUB_TOKEN" | helm registry login ghcr.io -u $GITHUB_ACTOR --password-stdin
```

## Customize Helm Parameters

The first model that we have is the values.yaml file. This file is used to store the default values for the chart. When you install a chart, you can override these values by passing them as arguments to the helm install command.

```
helm install my-release bitnami/wordpress \
--set wordpressBlogName="My Blog" \
--set wordpressEmail="rodrigo.kumabe@gmail.com" \
--set mariadb.auth.rootPassword=secretpassword
```

```
helm install \
--values=custom-values.yaml \
my-release bitnami/wordpress
```

## Pull And Untar tarball

```
helm pull bitnami/wordpress
tar -xzf wordpress-23.0.7.tgz

OR

helm pull --untar bitnami/wordpress

AND

helm install my-wordpress ./wordpress
```

## Lifecycle management with Helm

each time that we pull a chart, we have a new version of the chart. This is because Helm uses a versioning system to manage the lifecycle of the chart. When you make changes to a chart, you should increment the version number in the Chart.yaml file. This will allow Helm to track the changes that you have made to the chart and ensure that the correct version of the chart is installed in your cluster.

```
helm install nginx-release bitnami/nginx --version 8.9.0

kubectl get pods

kubectl describe pods nginx-release-1234-dsavcc

helm upgrade nginx-release bitnami/nginx

kubectl get pods

kubectl describe pods nginx-release-9876-nckdn

helm list -n runners
NAME NAMESPACE REVISION UPDATED STATUS CHART APP VERSION
runners-enterprise runners 13 2024-07-18 18:23:28.8784941 -0300 -03 deployed gha-runner-scale-set-0.9.3 0.9.3

helm history runners-enterprise -n runners
REVISION UPDATED STATUS CHART APP VERSION DESCRIPTION
4 Wed Jun 12 10:54:23 2024 superseded gha-runner-scale-set-0.9.2 0.9.2 Upgrade complete
5 Tue Jun 18 12:58:57 2024 superseded gha-runner-scale-set-0.9.2 0.9.2 Upgrade complete
6 Mon Jul 8 19:03:32 2024 superseded gha-runner-scale-set-0.9.2 0.9.2 Upgrade complete
7 Mon Jul 8 19:18:16 2024 superseded gha-runner-scale-set-0.9.2 0.9.2 Upgrade complete
8 Mon Jul 8 19:21:54 2024 superseded gha-runner-scale-set-0.9.2 0.9.2 Upgrade complete
9 Mon Jul 8 19:27:30 2024 superseded gha-runner-scale-set-0.9.3 0.9.3 Upgrade complete
10 Mon Jul 8 19:33:21 2024 superseded gha-runner-scale-set-0.9.3 0.9.3 Upgrade complete
11 Mon Jul 8 20:20:18 2024 superseded gha-runner-scale-set-0.9.3 0.9.3 Upgrade complete
12 Mon Jul 15 19:14:45 2024 superseded gha-runner-scale-set-0.9.3 0.9.3 Upgrade complete
13 Thu Jul 18 18:23:28 2024 deployed gha-runner-scale-set-0.9.3 0.9.3 Upgrade complete

helm rollback runners-enterprise 12 -n runners
```

## Helm Charts Anatomy

- Writing Charts

```
helm create nginx-chart
ls nginx-chart
cd nginx-chart
vim Chart.yaml
cd templates
vim deployment.yaml
vim service.yaml
```

- Templating
- Functions

```
    {{- toYaml . | nindent 8 }}
    {{- include "nginx-chart.labels" . | nindent 8 }}
```

- Chart Hooks
- Chart Tests
- Provenance

#### Objects (Template Directive, Go Template Language)

- {{ .Release.Name }}
- {{ .Release.Namespace }}
- {{ .Release.IsUpgrade }}
- {{ .Release.IsInstall }}
- {{ .Release.Revision }}
- {{ .Release.Service }}
- {{ .Chart.Name }}
- {{ .Chart.ApiVersion }}
- {{ .Chart.Version }}
- {{ .Chart.Type }}
- {{ .Chart.Keywords }}
- {{ .Chart.Home }}
- {{ .Capabilities.KubeVersion }}
- {{ .Capabilities.ApiVersions }}
- {{ .Capabilities.HelmVersion }}
- {{ .Capabilities.GitCommit }}
- {{ .Capabilities.GitTreeState }}
- {{ .Capabilities.GoVersion }}
- {{ .Values.replicaCount }}
- {{ .Values.image }}

### Making sure Chart is working as intended

#### Verifying Helm Charts

- Lint

```
helm lint ./nginx-chart/
```

- Template

```
helm template ./nginx-chart/
helm template first-example ./nginx-chart/

helm template first-example ./nginx-chart/ --debug
```

- Dry Run

```
helm install hello-world-1 ./nginx-chart/ --dry-run
```

### Functions

```
image:
  repository: nginx

{{ upper .Values.image.repository }}            --> NGINX
{{ quote .Values.image.repository }}            --> "nginx"
{{ replace "x" "y" .Values.image.repository }}  --> "nginy"
{{ shuffle .Values.image.repository }}          --> "xignn"
```

#### Some functions:

- https://helm.sh/docs/chart_template_guide/function_list/#string-functions
- https://helm.sh/docs/chart_template_guide/function_list/
- abbrev
- abbrevboth
- camelcase
- cat
- contains
- hasPrefix
- hasSuffix
- indent
- initials
- kebabcase
- lower
- nindent
- nospace
- plural
- print
- printf
- println
- quote
- randAlpha
- randAlphaNum
- randAscii
- randNumeric
- repeat
- replace
- shuffle
- snakecase
- squote
- substr
- swapcase
- title
- trim
- trimAll
- trimPrefix
- trimSuffix
- trunc
- untitle
- upper
- wrap
- wrapWith

```
{{ default "nginx" .Values.image.repository }}

{{ .Values.image.repository | upper | quote }}
```

> Pipeline are set of functions

### Conditionals

> "-" it means the extra spaces are gone and so are those extra lines

```
{{- if .Values.orgLabel }}
labels:
  org: {{ .Values.orgLabel }}
{{- else if eq .Values.orgLabel "hr" }}
labels:
  org: human resources
{{- else }}
labels:
  org: N/A
{{- end }}
```

### With Blocks

```values.yaml
app:
  ui:
    bg: white
    fg: green
  db:
    name: teste
    url: jdbc://teste:1234
```

> "$" means root level

```
{{- with .Values.app }}
ui.background: {{ .ui.bg }}
ui.frontground: {{ .ui.fg }}
db.name: {{ .db.name }}
db.url: {{ .db.url }}
release: {{ $.Release.Name }}
{{- end }}
```

### Loops and Ranges

```values.yaml
regions:
  - "sa-east-1"
  - "us-east-1"
  - "us-east-2"
  - "us-west-1"
  - "us-west-2"
```

```
{{- range .Values.regions}}
- {{ . | quote }}
{{- end }}
```

```
    {{- range $key, $val := $.Values.serviceAccount.labels }}
    {{ $key }}: {{ $val }}
    {{- end }}
    app: webapp-color
```

### Named Templates / Partial

```_helpers.tpl
{{- define "labels" }}
    app.kubernetes.io/name: {{ .Release.Name }}
    app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}
```

```service.yaml
apiVersion: v1
kind: Service
metadata:
  name: {{ .Release.Name }}-nginx
  labels:
    {{- template "labels" . }}
spec:
  type: {{ .Values.service.type }}
  ports:
    - port: 80
      targetPort: http
      protocol: TCP
      name: http
  selector:
    app: hell-world
```

```deployment.yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: {{ .Release.Name }}-nginx
  labels:
    {{- template "labels" . }}
spec:
  selector:
    matchLabels:
      {{- include "labels" . | indent 2 }}

  template:
    metadata:
      labels:
        {{- include "labels" . | indent 4 }}
    spec:
      containers:
        - name: nginx
          image: nginx:1.16.0
          imagePullPolicy: IfNotPresent
          ports:
            - name: http
              containerPort: 80
              protocol: TCP
```

### Chart Hooks

basic flow when user installs or upgrade helm chart:

- helm install --> verify --> render --> |pre-upgrade hooks| --> install --> |post-upgrade hooks|
- helm delete --> verify --> render --> |pre-upgrade hooks| --> delete --> |post-upgrade hooks|
- helm upgrade --> verify --> render --> |pre-upgrade hooks| --> upgrade --> |post-upgrade hooks|
- helm rollback --> verify --> render --> |pre-upgrade hooks| --> rollback --> |post-upgrade hooks|

> |pre-upgrade hooks|: could backup database, post announcements to the customers.
> |post-upgrade hooks|: could send e-mail to the customers.

#### Creating Hooks

- create job in kubernetes

```job-backup.yaml
apiVersion: batch/v1
kind: Job
metadata:
  name: {{ .Release.Name }}-nginx
  annotations:
    "helm.sh/hook": pre-upgrade
    "helm.sh/hook-weight": "5"
    "helm.sh/hook-delete-policy": hook-succeeded ## hook-succeeded, hook-failed, before-hook-creation (default)
spec:
  template:
    metadata:
      name: {{ .Release.Name }}-nginx
    spec:
      containers:
        - name: pre-upgrade-backup-job
          image: "alpine"
          command: ["/bin/backup.sh"]
      restartPolicy: Never

```

### Packaging and Signing Charts

```
helm package ./nginx-chart
```

- private key
- provenance

#### dev

```
gpg --quick-generate-key "Rodrigo Kumabe"
```

#### prod

```
gpg --full-generate-key "Rodrigo Kumabe"
```

#### GnuPG older is more used than earlier

```
gpg --export-secret-keys > ~/.gnupg/secring.gpg
```

#### Package using the right way

```
helm package --sign \
  --key "Rodrigo Kumabe" \
  --keyring ~/.gnupg/secring.gpg \
  ./nginx-chart
```

```
gpg --list-keys
```

```
ls
nginx-chart nginx-chart-0.1.0.tgz nginx-chart-0.1.0.tgz.prov
```

##### verify signature

```
helm verify ./nginx-chart-0.1.0.tgz
```

```
gpg --export "Rodrigo Kumabe" > mypublickey
```

```
helm verify --keyring ./mypublic ./nginx-chart-0.1.0.tgz
```

```
gpg --recv-keys --keyserver keyserver.ubuntu.com 5465465464XVKVZXVJLXVCXC
```

```
helm install --verify nginx-chart-0.1.0
```

### Uploading Charts

- package
- index.yaml
- provenance

#### generate index.yaml

```
$ ls
nginx-chart nginx-chart-0.1.0.tgz nginx-chart-0.1.0.tgz.prov

$ mkdir nginx-chart-files

$ cp nginx-chart-0.1.0.tgz nginx-chart-0.1.0.tgz.prov ./nginx-chart-files

$ helm repo index nginx-chart-files/ --url https://example.com/charts
```

#### Use custom helm chart

```
helm repo add our-cool-charts https://example.com/charts
helm install my-new-release our-cool-charts/nginx-chart
```
