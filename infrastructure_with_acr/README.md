# Usage:

## 0. Clone current repo

## 1. Create ServicePrincipal in Azure for get access terraform to Azure.
https://developer.hashicorp.com/terraform/tutorials/azure-get-started/azure-build

https://learn.microsoft.com/en-us/azure/developer/terraform/authenticate-to-azure?tabs=bash#create-a-service-principal

### 1.1 Login to Azure and create Azure AD application
!! note: you should create AAD application with **"Owner"** role for create resource "azurerm_role_assignment"
```
az login
az account set --subscription <SUBSCRIPTION_ID>
az ad sp create-for-rbac --role Owner --scopes "/subscriptions/<SUBSCRIPTION_ID>"
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

### 1.2 Set local environment variables (PowerShell)
```
$Env:ARM_CLIENT_ID = "<APPID_VALUE>"
$Env:ARM_CLIENT_SECRET = "<PASSWORD_VALUE>"
$Env:ARM_SUBSCRIPTION_ID = "<SUBSCRIPTION_ID>"
$Env:ARM_TENANT_ID = "<TENANT_VALUE>"
```
### 1.3 Login to Azure as a service (need for the next step 3. Provision infrastructure)
```
az login --service-principal -u $Env:ARM_CLIENT_ID -p $Env:ARM_CLIENT_SECRET --tenant $Env:ARM_TENANT_ID
```

## 2. Provision infrastructure:

### 2.1 Change variables

#### 2.1.1 open file: variables.tf

#### 2.1.2 set your value for variable "prefix" (replace default value "amartsavy-demo-tf-sh-acr")

#### 2.1.3 set docker image name by set value for variable "image" (replace default value "amartsavy/my-sh-app:1.0")

### 2.2 Provision infrastructure

#### 3.2.1 Init 
```
cd infrastructure_with_acr
terraform init
```

#### 2.2.2 Provision only Azure Cointainer Registry
```
terraform apply -target="azurerm_container_registry.example"
```
##### note: you get expected warning: "Warning: Applied changes may be incomplete"

#### 2.2.2 Provision all other resources (include docker image)
```
terraform apply
```

## 3. Check results (first open could be long, is around 15-30sec)

After 2.2.2 has been finished successfully, you can see output like:
```
Outputs:
app_url = "https://amartsavy-demo-tf-sh-acr-example.azurewebsites.net"
linux_web_app_name = "amartsavy-demo-tf-sh-acr-example"

```

Open url, you should see pretty the same picture (first open could be long, is around 15-30sec):
![result](result.png)