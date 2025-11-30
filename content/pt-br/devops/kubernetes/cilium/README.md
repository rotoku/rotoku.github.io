# Cilium


## Create the Cluster Using kind
```
curl -LO https://raw.githubusercontent.com/cilium/cilium/HEAD/Documentation/installation/kind-config.yaml
kind create cluster --config=kind-config.yaml
```

## Install the Cilium CLI
```
CILIUM_CLI_VERSION=$(curl -s https://raw.githubusercontent.com/cilium/cilium-cli/main/stable.txt)
CLI_ARCH=amd64
if [ "$(uname -m)" = "aarch64" ]; then CLI_ARCH=arm64; fi
curl -L --fail --remote-name-all https://github.com/cilium/cilium-cli/releases/download/${CILIUM_CLI_VERSION}/cilium-linux-${CLI_ARCH}.tar.gz{,.sha256sum}
sha256sum --check cilium-linux-${CLI_ARCH}.tar.gz.sha256sum
sudo tar xzvfC cilium-linux-${CLI_ARCH}.tar.gz /usr/local/bin
rm cilium-linux-${CLI_ARCH}.tar.gz{,.sha256sum}
```

## Install Cilium
```
cilium install --version 1.16.5
cilium status
```

## Validate the Installation
```
cilium status --wait
cilium connectivity test
cilium connectivity test --request-timeout 30s --connect-timeout 10s
```

## Let’s go ahead and enable Hubble as well
```
# This command reconfigures and restarts the Cilium agents to ensure they have enabled the embedded Hubble services. The command will also install the cluster-wide Hubble components to enable cluster-wide network observability.
cilium hubble enable --ui
```

## Cilium Architecture
- Cilium Operator
- Cilium Agent
- Cilium Client
- Cilium CNI Plugin
- Hubble Server
- Hubble Relay
- Hubble CLI & GUI
- Cluster Mesh API Server

## Modelo OSI
1. Física
2. Ligação de Dados
3. Rede
4. Transporte
5. Sessão
6. Apresentação
7. Aplicação

## Tipos de Política de Rede
- The standard Kubernetes NetworkPolicy resource which supports layer 3 and 4 policies.
- The CiliumNetworkPolicy resource which supports Layers 3, 4, and 7 (application layer) policies.
- The CiliumClusterwideNetworkPolicy resource for specifying policies that apply to an entire cluster rather than a specified namespace.