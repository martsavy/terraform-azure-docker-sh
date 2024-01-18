# Usage:

## 0. Clone current repo

## 1. Build and push docker image

### 1.1 Login to you account on docker hub
```
docker login
```
### 1.2 Build with tag:
```
cd application
```
#### 1.2.2 Build imange with tag. example: docker build -t amartsavy/my-sh-app:1.0 .
```
docker build -t <YOUR-DOCKERHUB-NAME>/my-sh-app:1.0 .
```
#### 1.2.3 Push image to Docker Hub. example: docker push amartsavy/my-sh-app:1.0
```
docker push <YOUR-DOCKERHUB-NAME>/my-sh-app:1.0
```

## 2. Create ServicePrincipal in Azure for get access terraform to Azure.
https://developer.hashicorp.com/terraform/tutorials/azure-get-started/azure-build

https://learn.microsoft.com/en-us/azure/developer/terraform/authenticate-to-azure?tabs=bash#create-a-service-principal

### 2.1 Login to Azure and create Azure AD application
```
az login
az account set --subscription <SUBSCRIPTION_ID>
az ad sp create-for-rbac --role Contributor --scopes /subscriptions/<SUBSCRIPTION_ID>
```
output example:
```
{
  "appId": "xxxxxx-xxx-xxxx-xxxx-xxxxxxxxxx",
  "displayName": "azure-cli-2024-xxxx",
  "password": "xxxxxx~xxxxxx~xxxxx",
  "tenant": "xxxxx-xxxx-xxxxx-xxxx-xxxxx"
}
```

### 2.2 Set local environment variables (PowerShell)
```
$Env:ARM_CLIENT_ID = "<APPID_VALUE>"
$Env:ARM_CLIENT_SECRET = "<PASSWORD_VALUE>"
$Env:ARM_SUBSCRIPTION_ID = "<SUBSCRIPTION_ID>"
$Env:ARM_TENANT_ID = "<TENANT_VALUE>"
```

## 3. Provision infrastructure:

### 3.1 Change variables

#### 3.1.1 open file: variables.tf

#### 3.1.2 set your value for variable "prefix" (replace default value "amartsavy-demo-sh")

#### 3.1.3 set docker image name by set value for variable "image" (replace default value "amartsavy/my-sh-app:1.0")

### 3.2 Provision infrastructure
```
cd ../infrastructure
terraform init
terraform plan
terraform apply
```
