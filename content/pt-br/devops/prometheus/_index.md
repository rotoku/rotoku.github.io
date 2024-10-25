---
title: "Prometheus"
linkTitle: "Prometheus"
date: 2024-08-31
weight: 6
---

---------------
---------------
---------------

# Prometheus

## Observability basics

## Prometheus architecture

## Prometheus Installation/Configuration
### Bare-Metal/VM
```bash
wget https://github.com/prometheus/prometheus/releases/download/v2.54.1/prometheus-2.54.1.linux-amd64.tar.gz
tar xvzf prometheus-2.54.1.linux-amd64.tar.gz
rm -rf prometheus-2.54.1.linux-amd64.tar.gz
cd prometheus-2.54.1.linux-amd64/
./prometheus
```

### Prometheus Installation systemd
```
sudo useradd --no-create-home --shell /bin/false prometheus
sudo mkdir /etc/prometheus
sudo mkdir /var/lib/prometheus
sudo chown prometheus:prometheus /etc/prometheus
sudo chown prometheus:prometheus /var/lib/prometheus
wget https://github.com/prometheus/prometheus/releases/download/v2.54.1/prometheus-2.54.1.linux-amd64.tar.gz
tar xvzf prometheus-2.54.1.linux-amd64.tar.gz
rm -rf prometheus-2.54.1.linux-amd64.tar.gz
cd prometheus-2.54.1.linux-amd64/
sudo cp prometheus /usr/local/bin/
sudo cp promtool /usr/local/bin/
sudo chown prometheus:prometheus /usr/local/bin/prometheus
sudo chown prometheus:prometheus /usr/local/bin/promtool
sudo cp -r consoles /etc/prometheus
sudo cp -r console_libraries /etc/prometheus
sudo chown -R prometheus:prometheus /etc/prometheus/consoles
sudo chown -R prometheus:prometheus /etc/prometheus/console_libraries

sudo cp prometheus.yml /etc/prometheus/prometheus.yml
sudo chown prometheus:prometheus /etc/prometheus/prometheus.yml

sudo -u prometheus /usr/local/bin/prometheus \
    --config.file /etc/prometheus/prometheus.yml \
    --storage.tsdb.path /var/lib/prometheus/ \
    --web.console.templates=/etc/prometheus/consoles \
    --web.console.libraries=/etc/prometheus/console_libraries

sudo vim /etc/systemd/system/prometheus.service
```

```/etc/systemd/system/prometheus.service
[Unit]
Description=Prometheus
Documentation=https://prometheus.io/docs/introduction/overview/
Wants=network-online.target
After=network-online.target

[Service]
User=prometheus
Group=prometheus
Type=simple
ExecReload=/bin/kill -HUP \$MAINPID
ExecStart=/usr/local/bin/prometheus \
    --config.file /etc/prometheus/prometheus.yml \
    --storage.tsdb.path /var/lib/prometheus/ \
    --web.console.templates=/etc/prometheus/consoles \
    --web.console.libraries=/etc/prometheus/console_libraries \
    --web.listen-address=0.0.0.0:9090 \
    --web.external-url=
SyslogIdentifier=prometheus
Restart=always

[Install]
WantedBy=multi-user.target
```

```
sudo systemctl daemon-reload
sudo systemctl start prometheus
sudo systemctl status prometheus
sudo systemctl enable prometheus
```

### node_exporter
```
wget https://github.com/prometheus/node_exporter/releases/download/v1.8.2/node_exporter-1.8.2.linux-amd64.tar.gz
tar xvzf node_exporter-1.8.2.linux-amd64.tar.gz
rm -rf node_exporter-1.8.2.linux-amd64.tar.gz
cd node_exporter-1.8.2.linux-amd64
./node_exporter
``` 

### node_exporter systemd
```
wget https://github.com/prometheus/node_exporter/releases/download/v1.8.2/node_exporter-1.8.2.linux-amd64.tar.gz
tar xvzf node_exporter-1.8.2.linux-amd64.tar.gz
rm -rf node_exporter-1.8.2.linux-amd64.tar.gz
cd node_exporter-1.8.2.linux-amd64
sudo cp node_exporter /usr/local/bin
sudo useradd --no-create-home --shell /bin/false node_exporter
sudo chown -R node_exporter:node_exporter /usr/local/bin/node_exporter
sudo vim /etc/systemd/system/node_exporter.service
``` 

```/etc/systemd/system/node_exporter.service
[Unit]
Description=Node Exporter
Wants=network-online.target
After=network-online.target

[Service]
User=node_exporter
Group=node_exporter
Type=simple
ExecStart=/usr/local/bin/node_exporter

[Install]
WantedBy=multi-user.target
```

```
sudo systemctl daemon-reload
sudo systemctl start node_exporter
sudo systemctl status node_exporter
sudo systemctl enable node_exporter
```

### Authentication/Encryption
```
sudo openssl req -new -newkey rsa:2048 -days 365 -nodes -x509 -keyout node_exporter.key -out node_exporter.crt -subj "/C=BR/ST=São Paulo/L=São Bernardo do Campo/O=Kumabe/CN=gary-lnx.kumabe.com.br" -addext "subjectAltName = DNS:gary-lnx.kumabe.com.br"
```

```config.yml
tls_server_config:
  cert_file: node_exporter.crt
  key_file: node_exporter.key
```

```
sudo mkdir /etc/node_exporter
sudo mv node_exporter.* /etc/node_exporter
sudo mv config.yml /etc/node_exporter
sudo chown -R node_exporter:node_exporter /etc/node_exporter
vim /etc/systemd/system/node_exporter.service
```

```/etc/systemd/system/node_exporter.service
[Unit]
Description=Node Exporter
Wants=network-online.target
After=network-online.target

[Service]
User=node_exporter
Group=node_exporter
Type=simple
ExecStart=/usr/local/bin/node_exporter --web.config.file=/etc/node_exporter/config.yml

[Install]
WantedBy=multi-user.target
```


```
sudo systemctl daemon-reload
sudo systemctl restart node_exporter
```

### Update certs at prometheus server
```
scp <USERNAME>:<PASSWORD>@<HOSTNAME>:/etc/node_exporter/node_exporter.crt /etc/prometheus
``` 

### Update prometheus.yml
```/etc/prometheus/prometheus.yml
# my global config
global:
  scrape_interval: 15s # Set the scrape interval to every 15 seconds. Default is every 1 minute.
  evaluation_interval: 15s # Evaluate rules every 15 seconds. The default is every 1 minute.
  # scrape_timeout is set to the global default (10s).

# Alertmanager configuration
alerting:
  alertmanagers:
    - static_configs:
        - targets:
          # - alertmanager:9093

# Load rules once and periodically evaluate them according to the global 'evaluation_interval'.
rule_files:
  # - "first_rules.yml"
  # - "second_rules.yml"

# A scrape configuration containing exactly one endpoint to scrape:
# Here it's Prometheus itself.
scrape_configs:
  # The job name is added as a label `job=<job_name>` to any timeseries scraped from this config.
  - job_name: "prometheus"

    # metrics_path defaults to '/metrics'
    # scheme defaults to 'http'.

    static_configs:
      - targets: ["localhost:9090"]
  - job_name: "gary-lnx"
    scheme: https
    tls_config:
      ca_file: /etc/prometheus/node_exporter.crt
      insecure_skip_verify: true
    static_configs:
      - targets: ["gary-lnx:9100"]
```

```
sudo systemctl restart prometheus
```

### Authentication Approach
```gerador_de_senha.py
import getpass
import bcrypt

password = getpass.getpass("password: ")
hashed_password = bcrypt.hashpw(password.encode("utf-8"),bcrypt.gensalt())
print(hashed_password.decode())
```


```/etc/node_exporter/config.yml
tls_server_config:
  cert_file: node_exporter.crt
  key_file: node_exporter.key
basic_auth_users:
  prometheus: <PASSWORD_HASH>
```

```
sudo systemctl restart node_exporter
```

### Update config from Prometheus Server
```/etc/prometheus/prometheus.yml
# my global config
global:
  scrape_interval: 15s # Set the scrape interval to every 15 seconds. Default is every 1 minute.
  evaluation_interval: 15s # Evaluate rules every 15 seconds. The default is every 1 minute.
  # scrape_timeout is set to the global default (10s).

# Alertmanager configuration
alerting:
  alertmanagers:
    - static_configs:
        - targets:
          # - alertmanager:9093

# Load rules once and periodically evaluate them according to the global 'evaluation_interval'.
rule_files:
  # - "first_rules.yml"
  # - "second_rules.yml"

# A scrape configuration containing exactly one endpoint to scrape:
# Here it's Prometheus itself.
scrape_configs:
  # The job name is added as a label `job=<job_name>` to any timeseries scraped from this config.
  - job_name: "prometheus"

    # metrics_path defaults to '/metrics'
    # scheme defaults to 'http'.

    static_configs:
      - targets: ["localhost:9090"]
  - job_name: "gary-lnx"
    scheme: https
    tls_config:
      ca_file: /etc/prometheus/node_exporter.crt
      insecure_skip_verify: true
    basic_auth:
      username: prometheus
      password: <PASSWORD_IN_PLAIN_TEXT>        
    static_configs:
      - targets: ["gary-lnx:9100"]        
```

```
sudo systemctl restart prometheus
```


### Docker Engine Metrics
```/etc/docker/daemon.json
{
  "metrics-addr" : "127.0.0.1:9323",
  "experimental" : true
}
```

```
sudo systemctl restart docker
curl localhost:9323/metrics
```

### cAdvisor Metrics
```docker-compose.yml
version: '3.4'
services:
  cadvisor:
    image: gcr.io/cadvisor/cadvisor
    container_name: cadvisor
    privileged: true
    devices:
      - "/dev/kmsg:/dev/kmsg"
    volumes:
      - /:/rootfs:ro
      - /var/run:/var/run:ro
      - /sys:/sys:ro
      - /var/lib/docker/:/var/lib/docker:ro
      - /dev/disk/:/dev/disk:ro
    ports:
      - 8080:8080
```



## Metrics Overview

## Prometheus Exporters

## PromQL Selectors/Modifiers/Operators/Functions/Quantiles
```
node_filesystem_avail_bytes / node_filesystem_size_bytes *1000

rate(node_network_transmit_bytes_total{instance="gary-lnx:9100", device="wlp1s0"}[5m])
```
### Rules
```node-rules.yaml
groups:
  - name: node
    interval: 15s
    rules:
      - record: node_network_receive_bytes_rate
        expr: rate(node_network_receive_bytes_total{job="nodes"}[2m])
      - record: node_network_receive_bytes_rate_avg
        expr: avg by(instance) (node_network_receive_bytes_rate)
      - record: node_filesystem_free_percent
        expr: 100 * node_filesystem_free_bytes{job="nodes"} / node_filesystem_size_bytes{job="nodes"}        
```

```api-rules.yaml
groups:
  - name: api
    interval: 15s
    rules:
      - record: avg_latency_2m
        expr: rate(http_request_total_sum{job="api"}[2m]) / rate(http_request_total_count{job="api"}[2m])
```

## Dashboarding & Visualization
```
ls /etc/prometheus/consoles
http://localhost:9090/consoles/index.html.example
cd /etc/prometheus/consoles
sudo vim demo.html
```

```/etc/prometheus/consoles/demo.html
{{ template "head" . }}
{{ template "prom_content_head" . }}

<h1>Memory details</h1>
<strong>active memory:</strong> {{template "prom_query_drilldown"(args "node_memory_Active_bytes")}}

<div id="graph"></div>

<script>
  new PromConsole.Graph({
    node: document.querySelector("#graph"),
    expr: "rate(node_memory_Active_bytes[5m])"
  });
</script>

{{ template "prom_content_tail" . }}
{{ template "tail" }}
```

```node-stats.html
{{ template "head" . }}
{{ template "prom_content_head" . }}
<h1>Node Stats</h1>
<h3>Memory</h3>
<strong>Memory utilization:</strong> {{template "prom_query_drilldown"(args "100-(node_memory_MemAvailable_bytes/node_memory_MemTotal_bytes*100)")}}
<br/>
<strong>Memory Size:</strong> {{template "prom_query_drilldown" (args "node_memory_MemTotal_bytes/1000000" "Mb") }}
<h3>CPU</h3>
<strong>CPU Count:</strong> {{template "prom_query_drilldown"(args "count(node_cpu_seconds_total{mode='idle'})")}}
<br/>
<strong>CPU Utilization:</strong> {{template "prom_query_drilldown" (args "sum(rate(node_cpu_seconds_total{mode!='idle'}[2m]))*100/8" "%") }}
<div id="cpu"></div>
<script>
  new PromConsole.Graph({
    node: document.querySelector("#cpu"),
    expr: "sum(rate(node_cpu_seconds_total{mode!='idle'}[2m]))*100/2"
  });
</script>
<h3>Network</h3>
<div id="network"></div>
<script>
  new PromConsole.Graph({
    node: document.querySelector("#network"),
    expr: "rate(node_network_receive_bytes_total[2m])"
  });
</script>
{{ template "prom_content_tail" . }}
{{ template "tail" }}
```

## Application Instrumentation
```
```

## Service Discovery
### Introduction
### File
### AWS
### Re-Labeling
```
scrape_configs:
  - job_name: "prometheus"
    static_configs:
      - targets: ["localhost:9090"]

  - job_name: "nodes"
    relabel_configs:
      - source_labels: [env]
        regex: prod
        action: keep # keep|drop
    file_sd_configs:
      - files:
        - file-sd.json
```

#### For the demo job, configure re-label configs to scrape only targets with env="prod" label and drop all other targets.
```
  - job_name: "demo"
    file_sd_configs:
      - files:
          - /etc/prometheus/file-sd.json
    relabel_configs:
      - source_labels: [env]
        regex: prod
        action: keep
```

#### We have decided to scrape the metrics from targets that have the following labels only: team=api env=prod .Make the required changes for demo job.
```
    relabel_configs:
      - source_labels: [team, env]
        regex: api;prod
        action: keep
```

```
  - job_name: "demo"
    file_sd_configs:
      - files:
          - /etc/prometheus/file-sd.json
    relabel_configs:
      - source_labels: [team]
        regex: (api|database)
        action: replace
        target_label: organization
        replacement: org-$1 
```

```By default, the labels that start with__ will get dropped after the re-labeling process. Now, we want to keep all of those labels as well and change the name so it removes the__meta_ text from the name.
    relabel_configs:
      - regex: __meta_(.*)__
        action: labelmap
        replacement: $1
```

```
scrape_configs:
  - job_name: "prometheus"
    static_configs:
      - targets: ["localhost:9090"]

  - job_name: "nodes"
    relabel_configs:
      - source_labels: [team, env]
        regex: (.*);(.*)
        action: replace
        target_label: info
        replacement: $1-$2
    file_sd_configs:
      - files:
        - file-sd.json
```

```
scrape_configs:
  - job_name: "prometheus"
    static_configs:
      - targets: ["localhost:9090"]

  - job_name: "nodes"
    relabel_configs:
      - regex: size
        action: labeldrop
    file_sd_configs:
      - files:
        - file-sd.json
```

```Update the Prometheus configuration to rename the metric node_cpu_seconds_total to host_cpu_seconds_total.
scrape_configs:
  - job_name: "prometheus"
    static_configs:
      - targets: ["localhost:9090"]

  - job_name: "nodes"
    metric_relabel_configs:
      - source_labels: [__name__]
        regex: node_cpu_seconds_total
        action: replace
        replacement: host_cpu_seconds_total
        target_label: __name__
    file_sd_configs:
      - files:
        - file-sd.json
```

```
scrape_configs:
  - job_name: "prometheus"
    static_configs:
      - targets: ["localhost:9090"]

  - job_name: "nodes"
    metric_relabel_configs:
      - source_labels: [__name__]
        regex: node_arp_entries
        action: keep
    file_sd_configs:
      - files:
        - file-sd.json
```

``` It has been determined that the metric node_network_transmit_drop_total is no longer needed, configure a metric_relabel policy to drop this metric.
  - job_name: "demo"
    file_sd_configs:
      - files:
          - /etc/prometheus/file-sd.json
    metric_relabel_configs:    
      - source_labels: [__name__]
        regex: node_network_transmit_drop_total
        action: drop
``` 

```
scrape_configs:
  - job_name: "prometheus"
    static_configs:
      - targets: ["localhost:9090"]

  - job_name: "nodes"
    metric_relabel_configs:
      - source_labels: [mountpoint]
        regex: (.*)
        action: replace
        target_label: path
        replacement: $1
    file_sd_configs:
      - files:
        - file-sd.json
```

#### For network related metrics like node_network_receive_bytes_total, the device label provides the interface. Rename this label to interface instead of device, and then delete the old device label as well so that there isn’t an extra unnecessary label.
```
    metric_relabel_configs:
      - source_labels: [device]
        regex: (.*)
        action: replace
        target_label: interface
        replacement: $1
```

## Push Gateway

### Introduction

### Installation
```
wget https://github.com/prometheus/pushgateway/releases/download/v1.4.3/pushgateway-1.4.3.linux-amd64.tar.gz
tar xvf pushgateway-1.4.3.linux-amd64.tar.gz
cd pushgateway-1.4.3.linux-amd64
sudo useradd --no-create-home --shell /bin/false pushgateway
sudo cp pushgateway /usr/local/bin
chown pushgateway:pushgateway /usr/local/bin/pushgateway
sudo vi /etc/systemd/system/pushgateway.service
```

```/etc/systemd/system/pushgateway.service
[Unit]
Description=Prometheus Pushgateway
Wants=network-online.target
After=network-online.target
[Service]
User=pushgateway
Group=pushgateway
Type=simple
ExecStart=/usr/local/bin/pushgateway
[Install]
WantedBy=multi-user.target
```

```
sudo systemctl daemon-reload
sudo systemctl restart pushgateway
sudo systemctl enable pushgateway
sudo systemctl status pushgateway

curl localhost:9091/metrics

vi /etc/prometheus/prometheus.yml
```

```/etc/prometheus/prometheus.yml
scrape_configs:
  - job_name: pushgateway
    honor_labels: true
    static_configs:
      - targets: ["192.168.1.168:9091"]
```

### Pushing Metrics
Metrics can be pushed to the Pushgateway using one of the following methods:
- Send HTTP Requests to Pushgateway
- Prometheus Client Libraries

Send HTTP POST request using the following URL :
```
http://<pushgateway_address>:<port>/metrics/job/<job_name>/<label1>/<value1>/<label2>/<value2>
```
<job_name> will be the job label of the metrics pushed
<label>/<value> in the url path is used as a grouping key – allows for grouping metrics together to update/delete multiple metrics at once

```
echo "processing_time_seconds 120" | curl --data-binary @- http://localhost:9091/metrics/job/video_processing
```


```
cat <<EOF | curl --data-binary @- http://localhost:9091/metrics/job/video_processing/instance/mp4_node1
processing_time_seconds{quality="hd"} 120
processed_videos_total{quality="hd"} 10
processed_bytes_total{quality="hd"} 4400
EOF
```

```
cat <<EOF | curl --data-binary @- http://localhost:9091/metrics/job/video_processing/instance/mov_node1
processing_time_seconds{quality="hd"} 400
processed_videos_total{quality="hd"} 250
processed_bytes_total{quality="hd"} 96000
EOF
```


```
cat <<EOF | curl --data-binary @- http://localhost:9091/metrics/job/video_processing/instance/mp4_node1
processing_time_seconds{quality="hd"} 999
EOF
```

```
cat <<EOF | curl -X PUT --data-binary @- http://localhost:9091/metrics/job/video_processing/instance/mp4_node1
processing_time_seconds{quality="hd"} 666
EOF
```

```
curl -X DELETE http://localhost:9091/metrics/job/video_processing/instance/mp4_node1
```

### Client Library
Metrics can be pushed to the Pushgateway through client libraries
There are 3 functions within a client library to push metrics:

push    --> Any existing metrics for this job are removed and the pushed metrics are added                        --> PUT
pushadd --> Pushed metrics override existing metrics with same names. All other metrics in group remain unchanged --> POST
delete  --> All metrics for a group are removed                                                                   --> DELETE

```Main.py
from prometheus_client import CollectorRegistry, Gauge, pushadd_to_gateway

registry = CollectorRegistry()
test_metric = Gauge('test_metric', 'This is an example metric', registry=registry)
test_metric.set(10)
pushadd_to_gateway('user2:9091', job='batch',registry=registry)
```

## Alerting(Alertmanager & notifications)

- Alerts at Prometheus
- Alerts at Grafana
- Alertmanager

### Introduction

```/etc/prometheus/prometheus.yaml
.
.
.
# Load rules once and periodically evaluate them according to the global 'evaluation_interval'.
rule_files:
  - "rules.yaml"
.
.
.  
```

```/etc/prometheus/rules.yaml
groups:
  - name: my-alerts
    interval: 15s
    rules:
      - alert: NodeDown
        expr: up{job="ervil"} == 0
        for: 2m
        labels:
          team: infra
          env: prod
        annotations:
          message: "Instance {{ .Labels.instance }} is currently down"    
      - alert: NodeDown
        expr: up{job="gary-lnx"} == 0
        for: 2m
        labels:
          team: infra
          env: prod
        annotations:
          message: "Instance {{ .Labels.instance }} is currently down" 
```


```/etc/prometheus/rules.yaml
groups:
  - name: node
    interval: 15s
    rules:
      - record: node_memory_memFree_percent
        expr: 100 - (100 * node_memory_MemFree_bytes{job="node"} / node_memory_MemTotal_bytes{job="node"})
      - alert: LowMemory
        expr: node_memory_memFree_percent < 20
      - alert: node down
        expr: up{job="node"} == 0
        for: 5m        
```

```
groups:
  - name: node
    interval: 15s
    rules:
      - alert: LowDiskSpace
        expr: 100 * node_filesystem_free_bytes{job="nodes"} / node_filesystem_size_bytes{job="nodes"} < 10
        labels:
          severity: warning
          environment: prod
```

#### Alert States
Inactive – Expression has not returned any results
Pending – expression returned results but it hasn’t been long enough to be considered firing(5m in this case)
Firing – Active for more than the defined for clause(5m in this case)

### Labels & Annotations
Labels can be added to alerts to provide a mechanism to classify and match specific alerts in Alertmanager
```
groups:
  - name: node
    interval: 15s
    rules:
      - alert: node down
        expr: up{job="node"} == 0
        labels:
          severity: warning

      - alert: Multiple Nodes down
        expr: avg without(instance) (up{job="node"}) <= 0.5
        labels:
          severity: critical
```
Annotations can be used to provide additional information, however unlike labels they do no play a part in the alerts identity So they cannot be use for routing in Alertmanager
Annotations are templated using Go templating language.
To access alert labels use {{.Labels}}
To get instance label use {{.Labels.instance}}
To get the firing sample value use {{.Value}}

```
groups:
  - name: node
    rules:
      - alert: node_filesystem_free_percent
        expr: 100 * node_filesystem_free_bytes{job="node"} / node_filesystem_size_bytes{job="node"} < 70
        annotations:
          message: "filesystem {{.Labels.device}} on {{.Labels.instance}} is low on space, current available space is {{.Value}}"
```
### Alertmanager Architecture
Alertmanager is responsible for receiving alerts generated from Prometheus and converting them into notifications. These notifications can include, pages, webhooks, email messages, and chat messages

### Alertmanager Installation
```
wget https://github.com/prometheus/alertmanager/releases/download/v0.27.0/alertmanager-0.27.0.linux-amd64.tar.gz
tar xzf alertmanager-0.27.0.linux-amd64.tar.gz
cd alertmanager-0.27.0.linux-amd64
ls -l
total 65916
-rwxr-xr-x 1 rkumabe rkumabe 37345962 Feb 28  2024 alertmanager     # Alertmanager executable
-rw-r--r-- 1 rkumabe rkumabe      356 Feb 28  2024 alertmanager.yml # configuration file
-rwxr-xr-x 1 rkumabe rkumabe 30130103 Feb 28  2024 amtool           # command-line utility tool
-rw-r--r-- 1 rkumabe rkumabe    11357 Feb 28  2024 LICENSE
-rw-r--r-- 1 rkumabe rkumabe      457 Feb 28  2024 NOTICE
drw-r--r-- 1 rkumabe rkumabe        0 Feb 28  2024 data             # stores notification states
```

### Alertmanager Installation systemd
```
wget https://github.com/prometheus/alertmanager/releases/download/v0.27.0/alertmanager-0.27.0.linux-amd64.tar.gz
tar xzf alertmanager-0.27.0.linux-amd64.tar.gz
cd alertmanager-0.27.0.linux-amd64
sudo useradd --no-create-home --shell /bin/false alertmanager
sudo mkdir /etc/alertmanager
sudo mv alertmanager.yml /etc/alertmanager
sudo chown -R alertmanager:alertmanager /etc/alertmanager
sudo mkdir /var/lib/alertmanager
sudo chown -R alertmanager:alertmanager /var/lib/alertmanager
sudo cp alertmanager /usr/local/bin
sudo cp amtool /usr/local/bin
sudo chown alertmanager:alertmanager /usr/local/bin/alertmanager
sudo chown alertmanager:alertmanager /usr/local/bin/amtool
sudo vim /etc/systemd/system/alertmanager.service
```

```/etc/systemd/system/alertmanager.service
[Unit]
Description=Alert Manager
Wants=network-online.target
After=network-online.target
[Service]
Type=simple
User=alertmanager
Group=alertmanager
ExecStart=/usr/local/bin/alertmanager \
  --config.file=/etc/alertmanager/alertmanager.yml \
  --storage.path=/var/lib/alertmanager
Restart=always
[Install]
WantedBy=multi-user.target
```

```
sudo systemctl daemon-reload
sudo systemctl start alertmanager
sudo systemctl enable alertmanager
sudo systemctl status alertmanager
```

### Configuration

#### Default Example
```/etc/alertmanager/alertmanager.yml
route:
  group_by: ['alertname']
  group_wait: 30s
  group_interval: 5m
  repeat_interval: 5m
  receiver: 'web.hook'
receivers:
  - name: 'web.hook'
    webhook_configs:
      - url: 'http://127.0.0.1:5001/'
inhibit_rules:
  - source_match:
      severity: 'critical'
    target_match:
      severity: 'warning'
    equal: ['alertname', 'dev', 'instance']
```

#### Example using slack_config
```/etc/alertmanager/alertmanager.yml
global:
  resolve_timeout: 5m
  slack_api_url: '<SLACK_WEBHOOK>'
route:
  group_by: ['alertname']
  group_wait: 30s
  group_interval: 5m
  repeat_interval: 1h
  receiver: 'slack'
receivers:
  - name: 'slack'
    slack_configs:
      - channel: '#testing'
        send_resolved: true
        icon_url: 'https://www.usatoday.com/gcdn/authoring/authoring-images/2023/08/25/USAT/70680172007-alertsm.png?crop=2099,1187,x0,y156&width=2099&height=1187&format=pjpg&auto=webp'
        title: |-
          [{{ .Status | toUpper}}{{if eq .Status "firing" }}:{{ .Alerts.Firing | len }}{{ end }}] {{ .CommonLabels.alertname }} na instância {{ .CommonLabels.instance }}
        text: >-
          {{ range .Alerts -}}
          *Alerta*: {{ .Annotations.title }}{{ if .Labels.severity }} - `{{ .labels.severity }}` {{ end }}

          *Descrição*: {{ .Annotations.description }}

          *Detalhes*:
            {{ range .Labels.SortedPairs}} - *{{ .Name }}*: `{{ .Value }}`
            {{ end }}
          {{ end }}  
inhibit_rules:
  - source_match:
      severity: 'critical'
    target_match:
      severity: 'warning'
    equal: ['alertname', 'instance']
```

#### Verificando os logs da máquina
```
journalctl -u alertmanager.service --reverse
```


#### Example using smtp
```/etc/alertmanager/alertmanager.yml
global:
  smtp_smarthost: 'mail.example.com:25'
  smtp_from: 'test@example.com'
route:
  receiver: staff
  group_by: ['alertname', 'job']
  routes:
    - match_re:
        job: (node|windows)
      receiver: infra-email
    - matchers:
        job: kubernetes
      receiver: k8s-slack
receivers:
  - name: 'k8s-slack'
    slack_configs:
      - channel: '#alerts'
        text: 'https://exampl.com/alerts/{{ .GroupLabels.app }}/
```

```/etc/alertmanager/alertmanager.yml
route:
  routes:
    # database team.
    - match:
        team: database
      receiver: database-pager
      routes:
        - match:
            severity: page
          receiver: database-pager
        - match:
            severity: email
          receiver: database-email
    # api team.
    - match:
        team: api
      receiver: api-pager
      routes:
        - match:
            severity: page
            env: dev
          receiver: api-ticket
        - match:
            severity: page
          receiver: api-pager
        - match:
            severity: ticket
          receiver: api-ticket
```
#### Restarting Alertmanager
As with Prometheus, Alertmanager does not automatically pickup changes to its config file. One of the following must be performed, for changes to take effect:
- Restart Alertmanager
- Send a SIGHUP
  - Sudo killall –HUP alertmanager
- HTTP Post to /-/reload endpoint

#### Continue
What if we want an alert to match two routes.
In this example, we want all alerts to be sent to the receiver alert-logs and then if it has the label jobs=Kubernetes it should also match the following line and be sent to k8s-email receiver
By default, the first matching route wins. So a specific alert would stop going down the route tree after the first match
To continue processing down the tree we can add continue: true

#### Grouping
By default Alertmanager will group all alerts for a route into a single group, which results in you receiving one big notification
The group_by field allows you to specifiy a list of labels to group alerts by
A default route has its alerts grouped by the team label
The infra team has alerts grouped based on region and env labels.
The child routes will inherit the grouping policy and group based on same 2 labels

### Receivers & Notifiers

Receivers are responsible for taking grouped alerts and producing notifications
Receivers contain various notifiers, which are responsible for handling the actual notifications

```/etc/alertmanager/alertmanager.yml
route:
  receiver: infra-pager
receivers:
  - name: infra-pager
    slack_configs:
      - api_url: https://hooks.slack.com/services/XXXXXXXX
        channel: "#pages"
    email_configs:
      - to: "receiver_mail_id@gmail.com"
        from: "ervil2008@gmail.com"
        smarthost: smtp.gmail.com:587
        auth_username: "ervil2008@gmail.com"
        auth_identity: "ervil2008@gmail.com"
        auth_password: "password"
```

#### [Configuration](https://prometheus.io/docs/alerting/latest/configuration/)

#### Global Config

Certain notifier configs/settings will be the same across all receivers and can be moved to global config section

```/etc/alertmanager/alertmanager.yml
global:
victorops_api_key: XXX
receivers:
- name: infra-pager
victorops_configs:
- routing_key: some-route
```

```/etc/alertmanager/alertmanager.yml
global:
smtp_smarthost: 'smtp.gmail.com:587'
smtp_from: 'alertmanager@kodekloud.com'
smtp_auth_username: xxxx
smtp_auth_identity: xxxx
smtp_auth_password: xxxx
receivers:
- name: 'infra'
email_configs:
- to: 'infra@kodekloud.com'
- name: 'frontent'
email_configs:
- to: 'frontend@kodekloud.com'
- name: 'k8s'
email_configs:
- to: 'k8s@kodekloud.com'
```
#### Notification Templates
Messages from notifiers can be configured by making use of the Go templating system.

GroupLabels – contains the group labels of the notification
CommonLabels – labels that are common across all alerts in the notification
CommonAnnotations – similar to CommonLabels, but for annotations
ExternalURL – URL of this Alertmanager
Status – will be set to firing if at least one alert in the notification is firing, if all are
resolved then it will be set to resolved
Receiver – name of the receiver
Alerts –  List of all the alerts in the notification
          Labels – labels for the alert
          Annotations – annotation for the alert
          status – firing|resolved
          StartsAt – When the alert started firing
          EndsAt – When the alert has stopped firing

```/etc/alertmanager/alertmanager.yml
route:
  receiver: 'slack'
receivers:
  - name: slack
    slack_configs:
      - api_url: https://hooks.slack.com/xxx
        channel: '#alerts'
        title: '{{.GroupLabels.severity}} alerts in region {{.GroupLabels.region}}'
```

```/etc/alertmanager/alertmanager.yml
route:
  receiver: 'slack'
receivers:
  - name: slack
    slack_configs:
      - api_url: https://hooks.slack.com/xxx
        channel: '#alerts'
        title: '{{.GroupLabels.severity}} alerts in region {{.GroupLabels.region}}'
        text: {{.Alerts | len}} alerts:
```

When you can’t squeeze the template string onto one line use > to place the template below

### Alertmanager Demo


### Silences
Alerts can be silenced to prevent generating notifications for a period of time.
This can be useful during maintenance windows when you expect there to be some temporary issues

### LABS

```/etc/prometheus/rules.yaml
groups:
  - name: node
    rules:
      - alert: NodeDown
        expr: up{job="nodes"} == 0
        for: 10s
        labels:
          severity: critical
          team: global-infra
      - alert: HostOutOfMemory
        expr: node_memory_MemAvailable_bytes{job="nodes"} / node_memory_MemTotal_bytes{job="nodes"} * 100 < 10
        for: 10s
        labels:
          severity: warning
          team: internal-infra          
        annotations:
          message: "node {{.Labels.instance}} is seeing high memory usage, currently available memory: {{.Value}}%"
```

```/etc/alertmanager/alertmanager.yml
global:
  smtp_smarthost: 'localhost:25'
  smtp_from: 'alertmanager@prometheus-server.com'
route:
  group_by: ['alertname']
  group_wait: 10s
  group_interval: 2m
  repeat_interval: 1h
  receiver: 'general-email'
  routes:
    - match:
        team: global-infra
      receiver: global-infra-email
    - match:
        team: internal-infra
      receiver: internal-infra-email    
receivers:
  - name: 'web.hook'
    webhook_configs:
      - url: 'http://127.0.0.1:5001/'        
  - name: 'global-infra-email'
    email_configs:
      - to: "root@prometheus-server.com"
        require_tls: false
  - name: 'internal-infra-email'
    email_configs:
      - to: "admin@prometheus-server.com"
        require_tls: false        
  - name: 'general-email'
    email_configs:       
      - to: "admin@prometheus-server.com"
        require_tls: false
```

## Monitoring Kubernetes

### Introduction
- Monitor applications running on Kubernetes infrastructure
- Monitor Kubernetes Cluster
  - Control-Plane Components(api-server, coredns, kube-scheduler)
  - Kubelet(cAdvisor) – exposing container metrics
  - Kube-state-metrics – cluster level metrics(deployments, pod metrics)
  - Node-exporter – Run on all nodes for host related metrics(cpu, mem, network)

### What is Helm?
- Helm is a package manager for Kubernetes
- All application and Kubernetes configs necessary for an application can be bundled into a package and easily deployed
- A helm chart is a collection of template & YAML files that convert into Kubernetes manifest files
- Helm charts can be shared with others by uploading a chart to a repository

### Operator
- https://github.com/prometheus-community/helm-charts/tree/main/charts/kube-prometheus-stack
- https://github.com/prometheus-operator/prometheus-operator
- https://github.com/prometheus-operator/kube-prometheus
  - Alert Manager
  - Prometheus Rule
  - Alertmanager Config
  - Service Monitor
  - Pod Monitor
  - Node Exporter
  
### How to install
- https://helm.sh/docs/intro/install/
```
helm repo add Prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update
helm show values prometheus-community/kube-prometheus-stack > values.yaml
helm install prometheus prometheus-community/kube-prometheus-stack
helm install \
  --namespace monitoring \
  --create-namespace \
  prometheus prometheus-community/kube-prometheus-stack

kubectl get svc
kubectl port-forward --address 0.0.0.0 svc/prometheus-kube-prometheus-prometheus 9090:9090 -n monitoring
kubectl port-forward --address 0.0.0.0 svc/prometheus-grafana 80:3000 -n monitoring
```

### Uninstall Helm Chart
```
helm uninstall prometheus
```

### Prometheus Configuration
```

```

### Deploy Demo Application
- [Gestão escolar](https://github.com/kumabes-org/hoshi)


### Additional Scrape Configs
```
helm show values prometheus-community/kube-prometheus-stack > values.yaml

helm upgrade \
  --namespace monitoring \
  --create-namespace \
  prometheus prometheus-community/kube-prometheus-stack \
  -f values.yaml
```

### Service Monitors
#### CRDs
The prometheus operator comes with several custom resource definitions that provide a high level abstraction for deploying prometheus as well as configuring it.

```
kubectl get crd
```
- prometheuses.monitoring.coreos.com: Used to create a prometheus instance
- servicemonitors.monitoring.coreos.com: Add additional targets for prometheus to scrape


#### Service Monitors
- Service monitors define a set of targets for prometheus to monitor and scrape
- They allow you to avoid touching prometheus configs directly and give you a declarative Kubernetes syntax to define targets

```service-monitor.yml
apiVersion: monitoring.coreos.com/v1
kind: ServiceMonitor
metadata:
  name: hoshi-service-monitor
  labels:
    release: prometheus
    app: hoshi
spec:
  jobLabel: job
  endpoints:
    - interval: 30s
      port: 3000
      path: /swagger-stats/metrics
  selector:
    matchLabels:
      app: hoshi
```

### Adding Rules
To add rules, the prometheus operator has a CRD called prometheusrules which handles registering new rules to a prometheus instance
```
apiVersion: monitoring.coreos.com/v1
kind: PrometheusRule
metadata:
  labels:
    release: prometheus
  name: api-rules
spec:
  groups:
    - name: api
      rules:
        - alert: down
          expr: up == 0
          for: 0m
          labels:
            severity: critical
          annotations:
            summary: Prometheus target missing {{$labels.instance}}
```
### Alertmanager Rules
To add Alertmanager rules, the prometheus operator has a CRD called AlertmanagerConfig which handles registering new rules to Alertmanager
```
apiVersion: monitoring.coreos.com/v1alpha1
kind: AlertmanagerConfig
metadata:
  name: alert-config
  labels:
    resource: prometheus
spec:
  route:
    groupBy: ["severity"]
    groupWait: 30s
    groupInterval: 5m
    repeatInterval: 12h
    receiver: "webhook"
  receivers:
    - name: "webhook"
      webhookConfigs:
        - url: "http://example.com/"
```

```values.yaml
.
.
.

  alertmanagerConfigSelector:
    matchLabels:
      resource: prometheus
.
.
.      
```    

```    
helm upgrade \
  --namespace monitoring \
  --create-namespace \
  prometheus prometheus-community/kube-prometheus-stack \
  -f values.yaml
```    

### [Using kube-prometheus Operator](https://github.com/prometheus-operator/kube-prometheus)

#### Download and Install
```
git clone https://github.com/prometheus-operator/kube-prometheus

cd kube-prometheus

kubectl apply --server-side -f manifests/setup

kubectl wait \
	--for condition=Established \
	--all CustomResourceDefinition \
	--namespace=monitoring

kubectl apply -f manifests/

cd ../

rm -rf kube-prometheus

kubectl get pods -n monitoring

kubectl get svc -n monitoring
kubectl port-forward --address 0.0.0.0 svc/prometheus-k8s 9090:9090 -n monitoring
kubectl port-forward --address 0.0.0.0 svc/grafana 3000:3000 -n monitoring
kubectl port-forward --address 0.0.0.0 svc/alertmanager-main 9093:9093 -n monitoring
```

#### Service Monitor
```
kubectl get servicemonitors grafana -n monitoring -o yaml
kubectl get servicemonitors prometheus-k8s -n monitoring -o yaml
```

```service-monitors-grafana.yaml
apiVersion: monitoring.coreos.com/v1
kind: ServiceMonitor
metadata:
  annotations:
    kubectl.kubernetes.io/last-applied-configuration: |
      {"apiVersion":"monitoring.coreos.com/v1","kind":"ServiceMonitor","metadata":{"annotations":{},"labels":{"app.kubernetes.io/component":"grafana","app.kubernetes.io/name":"grafana","app.kubernetes.io/part-of":"kube-prometheus","app.kubernetes.io/version":"11.2.1"},"name":"grafana","namespace":"monitoring"},"spec":{"endpoints":[{"interval":"15s","port":"http"}],"selector":{"matchLabels":{"app.kubernetes.io/name":"grafana"}}}}
  creationTimestamp: "2024-10-12T12:06:22Z"
  generation: 1
  labels:
    app.kubernetes.io/component: grafana
    app.kubernetes.io/name: grafana
    app.kubernetes.io/part-of: kube-prometheus
    app.kubernetes.io/version: 11.2.1
  name: grafana
  namespace: monitoring
  resourceVersion: "12014"
  uid: c446f3f4-df00-4a7a-b0ec-534c65fef154
spec:
  endpoints:
  - interval: 15s
    port: http
  selector:
    matchLabels:
      app.kubernetes.io/name: grafana
```

#### Create Deployment, ConfigMap and Service

```nginx-configmap.yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: nginx-config
data:
  nginx.conf: |
    server {
        listen 80;

        location / {
          root /usr/share/nginx/html;
          index index.html index.htm;
        }

        location /metrics {
          stub_status on;
          access_log off;
        }
    }
```

```nginx-deployment.yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: nginx-deployment
spec:
  selector:
    matchLabels:
      app: nginx
  template:
    metadata:
      labels:
        app: nginx
      annotations:
        prometheus.io/scrape: 'true'
        prometheus.io/port: '9113'
    spec:
      nodeSelector:
        kubernetes.io/os: linux
        agentpool: linuxagent1
      containers:
        - name: nginx
          image: nginx
          ports:
            - containerPort: 80
              name: http
          resources:
            limits:
              memory: 128Mi
              cpu: 0.25
            requests:
              memory: 128Mi
              cpu: 0.25              
          volumeMounts:
            - mountPath: /etc/nginx/conf.d/default.conf
              name: nginx-config
              subPath: nginx.conf
        - name: nginx-exporter
          image: nginx/nginx-prometheus-exporter
          args:
            - '-nginx.scrape-uri=http://localhost/metrics'
          ports:
            - containerPort: 9113
              name: metrics
          resources:
            limits:
              memory: 128Mi
              cpu: 0.25
            requests:
              memory: 128Mi
              cpu: 0.25              
      volumes:
        - configMap:
            defaultMode: 420
            name: nginx-config
          name: nginx-config
```

```nginx-service.yaml
apiVersion: v1
kind: Service
metadata:
  name: nginx-service
  labels:
    app: nginx
spec:
  ports:
    - port: 9113
      name: metrics
  selector:
    app: nginx
```

```
kubectl port-forward --address 0.0.0.0 svc/nginx-service 9113:9113
```

#### Create ServiceMonitor
```nginx-servicemonitor.yaml
apiVersion: monitoring.coreos.com/v1
kind: ServiceMonitor
metadata:
  name: nginx-servicemonitor
  labels:
    app: nginx
spec:
  selector:
    matchLabels:
      app: nginx
  endpoints:
    - interval: 10s
      path: /metrics
      targetPort: 9113
```

#### Create PodMonitor
```nginx-pod.yaml
apiVersion: v1
kind: Pod
metadata:
  labels:
    app: nginx
  name: nginx-pod
spec:
  nodeSelector:
    kubernetes.io/os: linux
    agentpool: linuxagent1    
  containers:
  - image: nginx
    name: nginx
    ports:
      - containerPort: 80
        name: http
    resources:
      limits:
        memory: 128Mi
        cpu: 0.25
      requests:
        memory: 128Mi
        cpu: 0.25              
    volumeMounts:
      - mountPath: /etc/nginx/conf.d/default.conf
        name: nginx-config
        subPath: nginx.conf
  - name: nginx-exporter
    image: nginx/nginx-prometheus-exporter
    args:
      - '-nginx.scrape-uri=http://localhost/metrics'
    ports:
      - containerPort: 9113
        name: metrics
    resources:
      limits:
        memory: 128Mi
        cpu: 0.25
      requests:
        memory: 128Mi
        cpu: 0.25              
  volumes:
    - configMap:
        defaultMode: 420
        name: nginx-config
      name: nginx-config            

```

```nginx-podmonitor.yaml
apiVersion: monitoring.coreos.com/v1
kind: PodMonitor
metadata:
  name: nginx-podmonitor
  labels:
    app: nginx
spec:
  namespaceSelector:
    matchNames:
      - default
  selector:
    matchLabels:
      app: nginx
  podMetricsEndpoints:
    - interval: 10s
      path: /metrics
      targetPort: 9113
```

#### Prometheus Rules
```nginx-prometheusrule.yaml
apiVersion: monitoring.coreos.com/v1
kind: PrometheusRule
metadata:
  name: nginx-prometheus-rule
  namespace: monitoring
  labels:
    prometheus: k8s
    role: alert-rules
    app.kubernetes.io/name: kube-prometheus
    app.kubernetes.io/part-of: kube-prometheus
spec:
  groups:
    - name: nginx-prometheus-rule
      rules:
        - alert: NginxDown
          expr: nginx_up == 0
          for: 1m
          labels:
            severity: critical
          annotations:
            summary: "Nginx está fora"
            description: "O nosso servidor web Nginx está fora {{ .Labels.instance }}!"
```

O que podemos saber sobre os nodes do nosso cluster?
Algumas métricas que podemos extrair sobre os nodes do nosso cluster são:

- Quantos nós temos no nosso cluster?
- Qual a quantidade de CPU e memória que cada nó tem?
- O nó está disponível para receber novos pods?
- Qual a quantidade de informação que cada nó está recebendo e enviando?
- Quantos pods estão rodando em cada nó?
- Vamos responder essas quatro perguntas utilizando o PromQL e as métricas que estamos coletando do nosso cluster Kubernetes.

Quantos nós temos no nosso cluster?
Para responder essa pergunta, vamos utilizar a métrica kube_node_info que nos mostra informações sobre os nós do nosso cluster. Podemos utilizar a função count para contar quantas vezes a métrica kube_node_info aparece no nosso cluster.
```
count(kube_node_info)
```
No nosso cluster, temos 2 nós, então a resposta para essa pergunta é 2.

Qual a quantidade de CPU e memória que cada nó tem?
Para responder essa pergunta, vamos utilizar a métrica kube_node_status_allocatable que nos mostra a quantidade de CPU e memória que cada nó tem disponível para ser utilizado.
```
kube_node_status_allocatable
```
Aqui ele vai te trazer todas as informações sobre CPU, memória, pods, etc. Mas nós só queremos saber sobre CPU e memória, então vamos filtrar a nossa consulta para trazer apenas essas informações.
```
kube_node_status_allocatable{resource="cpu"}
kube_node_status_allocatable{resource="memory"}
```
Fácil, agora precisamos somente de um pouco de matemática para converter os valores referente a memória para gigabytes.
```
kube_node_status_allocatable{resource="memory"} / 1024 / 1024 / 1024
```
Pronto, agora ficou um pouco mais fácil de ler a quantidade de memória que temos em cada nó.

O nó está disponível para receber novos pods?
Para responder essa pergunta, vamos utilizar a métrica kube_node_status_condition que nos mostra o status de cada nó do nosso cluster.
```
kube_node_status_condition{condition="Ready", status="true"}
```
Com a consulta acima, estamos perguntando para métrica kube_node_status_condition se o nó está pronto para receber novos pods. Se o nó estiver pronto, ele vai retornar o valor 1, caso contrário, ele vai retornar o valor 0.

Isso porque estamos perguntando para a métrica kube_node_status_condition se o nó está com a condição Ready e se o status dessa condição é true, se mudassemos o status para false, ele iria retornar o valor 0. Simplão demais!

Qual a quantidade de informação que cada nó está recebendo e enviando?
Aqui vamos levar em consideração que estamos falando de trafego de rede, o quanto o nosso nó está recebendo e enviando de dados pela rede.

Para isso vamos utilizar a métrica node_network_receive_bytes_total e node_network_transmit_bytes_total que nos mostra a quantidade de bytes que o nó está recebendo e enviando.
```
node_network_receive_bytes_total
node_network_transmit_bytes_total
```
Perceba que a saída dessa consulta ela traz a quantidade de bytes por pod, mas nós queremos saber a quantidade de bytes por nó, então vamos utilizar a função sum para somar a quantidade de bytes que cada pod está recebendo e enviando.
```
sum by (instance) (node_network_receive_bytes_total)
sum by (instance) (node_network_transmit_bytes_total)
```
Pronto, dessa forma teriamos a quantidade de bytes que cada nó está recebendo e enviando. No meu caso, como somente tenho dois nodes, o resultado foram duas linhas, uma para cada nó, mostrando a quantidade de bytes que cada nó está recebendo e enviando.

Agora vamos converter esses bytes para megabytes, para ficar mais fácil de ler.
```
sum by (instance) (node_network_receive_bytes_total) / 1024 / 1024
sum by (instance) (node_network_transmit_bytes_total) / 1024 / 1024
```
Vamos para a próxima pergunta.

Quantos pods estão rodando em cada nó?
Para responder essa pergunta, vamos utilizar a métrica kube_pod_info que nos mostra informações sobre os pods que estão rodando no nosso cluster.
```
kube_pod_info
```
Caso eu queria saber o número de pods que estão rodando em cada nó, eu poderia utilizar a função count para contar quantas vezes a métrica kube_pod_info aparece em cada nó.
```
count by (node) (kube_pod_info)
```
Pronto, agora eu sei quantos pods estão rodando em cada nó. No meu caso o meu cluster está bem sussa, somente 9 pods em um nó e 10 no outro, um dia de alegriaaaaa!



## Anothers Tips and Tricks

```
curl http://localhost:9090/api/v1/query?query=node_filesystem_avail_bytes

curl -s http://localhost:9090/api/v1/targets

curl https://economia.awesomeapi.com.br/json/last/USD-BRL | jq .

```

## Lista dos Collectors habilitados por padrão
[Lista dos Collectors habilitados por padrão](https://github.com/prometheus/node_exporter#enabled-by-default)

## Lista dos Collectors desabilitados por padrão
[Lista dos Collectors desabilitados por padrão](https://github.com/prometheus/node_exporter#disabled-by-default)

## Habilitando uma métrica no node_exporter
```
sudo mkdir -p /etc/node_exporter
sudo vim /etc/node_exporter/node_exporter_options
```

```/etc/node_exporter/node_exporter_options
OPTIONS="--collector.systemd"
```

```
sudo vim /etc/systemd/system/node_exporter.service
```

```/etc/systemd/system/node_exporter.service
[Unit]
Description=Node Exporter
Wants=network-online.target
After=network-online.target

[Service]
User=node_exporter
Group=node_exporter
Type=simple
EnvironmentFile=/etc/node_exporter/node_exporter_options
ExecStart=/usr/local/bin/node_exporter $OPTIONS

[Install]
WantedBy=multi-user.target
```

```
sudo systemctl daemon-reload
```

```
sudo systemctl restart node_exporter
sudo systemctl status node_exporter
```

## Algumas Queries

```
### Quantas CPU tem a minha máquina
count(node_cpu_seconds_total{job="gary-lnx", mode="idle"})

### Qual a porcentagem de uso de CPU da minha máquina
100 - avg by (cpu) (irate(node_cpu_seconds_total{job="gary-lnx", mode="idle"}[5m])) * 100

### Qual a porcentagem de uso de memória da minha máquina
100 - (node_memory_MemAvailable_bytes / node_memory_MemTotal_bytes) * 100

### Qual a porcentagem de uso de disco da minha máquina
100 - (node_filesystem_avail_bytes{mountpoint="/"} / node_filesystem_size_bytes{mountpoint="/"})*100

### Quanto de espaço está em uso na partição / em gigas
(node_filesystem_size_bytes{mountpoint="/"} - node_filesystem_avail_bytes{mountpoint="/"})/1024/1024/1024
```
