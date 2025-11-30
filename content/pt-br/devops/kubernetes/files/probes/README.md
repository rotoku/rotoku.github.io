# Probes

As probes são uma forma de você monitorar o seu Pod e saber se ele está em um estado saudável ou não. Com elas é possível assegurar que seus Pods estão rodando e respondendo de maneira correta, e mais do que isso, que o Kubernetes está testando o que está sendo executado dentro do seu Pod.

Hoje nós temos disponíveis três tipos de probes, a livenessProbe, a readinessProbe e a startupProbe. Vamos ver no detalhe cada uma delas.

- A livenessProbe é a nossa probe de verificação de integridade, o que ela faz é verificar se o que está rodando dentro do Pod está saudável. O que fazemos é criar uma forma de testar se o que temos dentro do Pod está respondendo conforme esperado. Se por acaso o teste falhar, o Pod será reiniciado. 

- A readinessProbe é uma forma de o Kubernetes verificar se o seu container está pronto para receber tráfego, se ele está pronto para receber requisições vindas de fora. Essa é a nossa probe de leitura, ela fica verificando se o nosso container está pronto para receber requisições, e se estiver pronto, ele irá receber requisições, caso contrário, ele não irá receber requisições, pois será removido do endpoint do serviço, fazendo com que o tráfego não chegue até ele. A nossa probe da vez irá garantir que o nosso Pod está saudável para receber requisições.

- A startupProbe é responsável por verificar se o nosso container foi inicializado corretamente, e se ele está pronto para receber requisições. Ele é muito parecido com a readinessProbe, mas a diferença é que a startupProbe é executada apenas uma vez no começo da vida do nosso container, e a readinessProbe é executada de tempos em tempos.