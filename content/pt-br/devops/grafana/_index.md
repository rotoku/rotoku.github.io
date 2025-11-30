---
title: "Grafana"
linkTitle: "Grafana"
date: 2023-07-16
weight: 5
---

---

---

---

# Grafana

## Installation
```
sudo apt update -y

sudo apt-get install -y apt-transport-https software-properties-common wget

sudo mkdir -p /etc/apt/keyrings/

wget -q -O - https://apt.grafana.com/gpg.key | gpg --dearmor | sudo tee /etc/apt/keyrings/grafana.gpg > /dev/null

## Use this for stable
echo "deb [signed-by=/etc/apt/keyrings/grafana.gpg] https://apt.grafana.com stable main" | sudo tee -a /etc/apt/sources.list.d/grafana.list

## Use this for beta
echo "deb [signed-by=/etc/apt/keyrings/grafana.gpg] https://apt.grafana.com beta main" | sudo tee -a /etc/apt/sources.list.d/grafana.list

sudo apt update -y

# Installs the latest OSS release:
sudo apt-get install grafana -y

# Installs the latest Enterprise release:
sudo apt-get install grafana-enterprise -y

sudo systemctl start grafana-server

sudo service grafana-server start

sudo systemctl enable grafana-server
```

## Uninstall on Debian or Ubuntu
```
sudo systemctl stop grafana-server

sudo service grafana-server stop

sudo apt-get remove grafana

sudo apt-get remove grafana-enterprise

sudo rm -i /etc/apt/sources.list.d/grafana.list
```


## 4 Golden Signals

1. Latência
2. Tráfego
3. Saturação (uso excedente da aplicação)
4. Erros

## Metodologias USE e RED

### Método USE

- Utilization
- Saturation
- Errors

### Método RED

- Rate
- Errors
- Duration

## Benefícios

- Redução do tempo médio de detecção de incidentes, o MTTD (Mean Time To Detect).
- Redução do tempo médio de reparo, o MTTR (Mean Time To Repair).
- Comprimento do Acordo de nível de serviço (SLA, SLO, EB e SLI)
- Baseline comportamental
- Ações de escalabilidade automática e preditiva
- acionamentos e alertas automatizados
- Medição da experiêcia do usuário

## Variáveis
