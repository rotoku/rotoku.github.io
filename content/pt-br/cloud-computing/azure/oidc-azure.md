
---
title: "OIDC Azure"
weight: 2
---

---------
---------
---------

# OIDC Azure

[OIDC Azure](https://learn.microsoft.com/en-us/azure/active-directory/workload-identities/workload-identity-federation-create-trust?pivots=identity-wif-apps-methods-azcli)

https://learn.microsoft.com/en-us/azure/developer/github/connect-from-azure?tabs=azure-cli%2Clinux#use-the-azure-login-action-with-a-service-principal-secret

```
APP_NAME="kumabes-org"
```

echo "Checking Azure CLI login status..."
EXPIRED_TOKEN=$(az ad signed-in-user show --query 'id' -o tsv || true)

if [[ -z "$EXPIRED_TOKEN" ]]
then
    az login -o none
fi

ACCOUNT=$(az account show --query '[id,name]')
echo $ACCOUNT

## Get Subscription ID
```
SUB_ID=$(az account show --query id -o tsv)
echo $SUB_ID
```

## Get Tenant ID
```
TENANT_ID=$(az account show --query tenantId -o tsv)
echo $TENANT_ID
```

## Get App ID
```
APP_ID=$(az ad app list --filter "displayName eq '$APP_NAME'" --query [].appId -o tsv)
echo $APP_ID

if [[ -z "$APP_ID" ]]; then
    echo "Create Application!"
    APP_ID=$(az ad app create --display-name ${APP_NAME} --query appId -o tsv)
else
    echo "Application NOT FOUND!"
fi
```

## Create service principal
```
SP_ID=$(az ad sp list --filter "appId eq '$APP_ID'" --query [].id -o tsv)
echo $SP_ID
if [[ -z "$SP_ID" ]]; then
    echo "Creating service principal..."
    SP_ID=$(az ad sp create --id $APP_ID --query id -o tsv)

    echo "Sleeping for 30 seconds to give time for the SP to be created."
    sleep 30s

    echo "Creating role assignment..."
    az role assignment create --role contributor --subscription $SUB_ID --assignee-object-id $SP_ID --assignee-principal-type ServicePrincipal
    sleep 30s    
else
    echo "Existing Service Principal found."
fi
```

## Create federated-credential
```
az ad app federated-credential create --id $APP_ID --parameters credential.json
```

```
{
  "@odata.context": "https://graph.microsoft.com/v1.0/$metadata#applications('e4f34e13-8bb3-4aba-b8b4-46642bbc6de7')/federatedIdentityCredentials/$entity",
  "audiences": [
    "api://AzureADTokenExchange"
  ],
  "description": "java-gradle-springboot-application",
  "id": "40f11562-a2f7-485f-9070-af6c46dfc9c7",
  "issuer": "https://token.actions.githubusercontent.com",
  "name": "java-gradle-springboot-application",
  "subject": "repo:kumabes-org/java-gradle-springboot-application:environment:Production"
}
```
