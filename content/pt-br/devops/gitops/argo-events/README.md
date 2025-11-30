# O que é Argo Events?
Argo Events é uma estrutura para automatizar fluxos de trabalho no Kubernetes. Ele pode consumir eventos de mais de 20 fontes de eventos, incluindo Amazon Simple Storage Service (S3), Amazon Simple Queue Service (SQS), Google Cloud Platform Pub/Sub, webhooks, programações e filas de mensagens. Com base nesses eventos, você pode acionar tarefas como:
- Kubernetes Objects
- Argo Workflows
- AWS Lambda
- Serverless workloads

Além disso, a Argo Events pode:

Dê suporte à personalização da lógica de restrições em nível de negócios para automatizar fluxos de trabalho.
Gerencie todos os tipos de eventos, desde lineares e simples até complexos e de múltiplas fontes.
Ajude a manter a conformidade com a especificação CloudEvents.
Isto faz parte de uma extensa série de guias sobre o Kubernetes .

- Event Source
- Sensor
- Eventbus
- Triggers

## Installation
### Installing Argo Events Using kubectl
#### First, create a namespace called argo-events:
```
kubectl create namespace argo-events
```

#### Deploy Argo Events and dependencies like ClusterRoles, Sensor Controller and EventSource Controller using this command:
```
kubectl apply -f https://raw.githubusercontent.com/argoproj/argo-events/stable/manifests/install.yaml
```

#### Note: You can install Argo Events with a validating admission webhook. This notifies you of errors when you apply a faulty spec, so you don’t need to check the CRD object status for errors later on. Here is how to install with validating admission controller:
```
kubectl apply -f https://raw.githubusercontent.com/argoproj/argo-events/stable/manifests/install-validating-webhook.yaml
```
### Using Helm Chart
#### Create a namespace called argo-events, and create a Helm repository called argoproj as follows:
```
helm repo add argo https://argoproj.github.io/argo-helm
```

#### Note: Be sure to update the image version in values.yaml to v1.0.0. The Helm chart for Argo Events is maintained by the community and the image version could be out of sync. Install the Argo Events Helm chart using the following command:
```
helm install argo-events argo/argo-events
```

### Using Kustomize
#### If you use the cluster-install or cluster-install-with-extension folder as your base for Kustomize, add the following to kustomization.yaml:
```
bases:
  - github.com/argoproj/argo-events/manifests/cluster-install
```

#### If you use the namespace-install folder as your base for Kustomize, add the following to kustomization.yaml:
```
bases:
  - github.com/argoproj/argo-events/manifests/namespace-install
```

### Step 2: Set Up a Sensor and Event Source
#### Now that Argo Events is installed, let’s set up a sensor and event source for the webhook. This will allow us to trigger Argo workflows via an HTTP Post request. First, deploy the eventbus:
```
kubectl -n argo-events apply -f https://raw.githubusercontent.com/argoproj/argo-events/stable/examples/eventbus/native.yaml
```
#### Use this command to create an event source for the webhook:
```
kubectl -n argo-events apply -f https://raw.githubusercontent.com/argoproj/argo-events/stable/examples/event-sources/webhook.yaml
```
#### Finally, create the webhook sensor:
```
kubectl -n argo-events apply -f https://raw.githubusercontent.com/argoproj/argo-events/stable/examples/sensors/webhook.yaml

```
#### A Kubernetes service should now be created for the event source. You can see the new service by running kubectl get services.
#### Finally, expose the event source pod for HTTP access. For example, the following command exposes the event source pod on port 12000 using port forward.
```
kubectl -n argo-events port-forward svc/webhook-eventsource-svc 12000:12000

kubectl -n argo-events get pods -l controller=eventsource-controller,eventsource-name=webhook,owner-name=webhook
```

### Step 3: Submit Post Request and See that a Workflow Runs
#### Let’s send a post request to http://localhost:12000/example—here is how to do it with curl – 
```
curl -d '{"message":"this is my first webhook"}' -H "Content-Type: application/json" -X POST http://localhost:12000/example
```

#### Run this command to see if an Argo workflow is created, triggered by our POST request:
```
kubectl -n argo-events get wf
```
#### You should see a context message indicating your webhook is running. Finally, ensure the pod defined in the workflow is running in your cluster. That’s it! You set up an event system that accepts POST requests and creates pods as part of an Argo workflow.

