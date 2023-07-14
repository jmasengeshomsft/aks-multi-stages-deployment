# Azure Infrastructure #

This is Terraform for creating an AKS Landing Zone in Azure.  There are 5 key Terraform scripts in this repo to break the construction up logically into different areas that different groups might control.

1.  **Networking (lz-networking)**.  This will create a Hub Resource Group and a VNet as well as an Azure Firewall with Policies for AKS.
2.  **AKS Resource group and AKS components (aks-core-infra)**.  This script will create a Resource Group for AKS as well as a separate spoke VNet that is peered with the Hub Net.  Optionally you can use this script to create necessary components like managed identities, KeyVault, ACR, etc.
3.  **AKS Networking**. This module creates two subnets (nodes and pods) for the clusters. The nodes subnet is associated to the route table in the spoke. Two NSGs for the subnets are created with detault routes.
4.  **AKS Cluster (aks-cluster)**.  This script provisions an AKS cluster with Cilium dataplane using Azure CNI networking
5.  **AKS Worker Nodes (aks-workers)**.  This script simply adds worker nodes to an existing AKS Cluster


### High Level Architecture  (Hub/Spoke)

   ![image](https://github.com/jmasengeshomsft/aks-multi-stages-deployment/assets/86074746/f6a61e94-5928-4271-bc59-3d0aa27fc9a4)

## Hub-Spoke Networking Deployment (lz-Networking)

<img width="848" alt="image" src="https://github.com/jmasengeshomsft/aks-multi-stages-deployment/assets/86074746/ae7f95d8-8937-40c3-8a72-4cb316077f5d">

## Spoke Core Resources (AKS-Core-Infra)

<img width="865" alt="image" src="https://github.com/jmasengeshomsft/aks-multi-stages-deployment/assets/86074746/3f2799b0-41ee-4ac6-a7a7-e56ce398af00">

## Cluster Networking (cluster-networking)

<img width="1508" alt="image" src="https://github.com/jmasengeshomsft/aks-multi-stages-deployment/assets/86074746/518118e0-dd66-4b75-a171-41c053583643">

## AKS Cluster

![image](https://github.com/jmasengeshomsft/aks-multi-stages-deployment/assets/86074746/a0c21703-caf3-4ed6-804c-c7d91eaf49d4)

## AKS Node Pool

![image](https://github.com/jmasengeshomsft/aks-multi-stages-deployment/assets/86074746/8c9dd9b0-bf48-4f9f-843d-11dd81682fc2)


# Deployment with TF-Controller

The Terraform CRDs used to create the above resourcs are in TF-Controller directory. 

<img width="1387" alt="image" src="https://github.com/jmasengeshomsft/aks-multi-stages-deployment/assets/86074746/5a1fb401-4746-426a-890a-89a4df4b588f">


As an example, below is the CRD for the Landing Zone: 

```
apiVersion: infra.contrib.fluxcd.io/v1alpha1
kind: Terraform
metadata:
  name: az-lz
  namespace: flux-system
spec:
  interval: 2m
  destroyResourcesOnDeletion: true
  approvePlan: auto
  path: ./lz-networking
  sourceRef:
    kind: GitRepository
    name: aks-playground-source
    namespace: flux-system
  runnerPodTemplate:
    spec:
      envFrom:
        - secretRef:
            name: azure-tf-credentials
  enableInventory: true
  vars:
  - name: location        
    value: "eastus"
  - name: hub_prefix     
    value: "contoso"
  - name: vm_sku
    value: "Standard_A0"
  - name: fw_sku
    value:  "Basic"
  - name: fw_policy_sku
    value: "Basic"
  - name: hub_address_space                  
    value: "10.100.0.0/22"
  - name: bastion_subnet_address_space        
    value: "10.100.3.0/27"
  - name: firewall_subnet_address_space       
    value: "10.100.3.64/26"
  - name: mgmt_firewall_subnet_address_space 
    value: "10.100.3.128/26"
  - name: applicationgw_subnet_address_space 
    value: "10.100.1.0/24"
  - name: jumpbox_subnet_address_space        
    value: "10.100.0.0/24"
  - name: aks_spoke_address_space             
    value: "10.101.0.0/16"
  - name: plendpoints_subnet_address_space    
    value: "10.101.80.0/24"
  - name: default_spoke_name 
    value: "jm-contoso-dev"
  varsFrom:
  - kind: Secret
    name: vm-admin-password-secret
```

### References:

1. **Azurerm AKS Cluster Module**: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/kubernetes_cluster
2. **Azurerm AKS Nodepool Module**: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/kubernetes_cluster_node_pool
3. **AKS Landing Zone Accelerator Project**: https://github.com/Azure/AKS-Landing-Zone-Accelerator
4. **Control Egress Traffic on AKS**: https://learn.microsoft.com/en-us/azure/aks/limit-egress-traffic

