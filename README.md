# Azure Infrastructure #

This is Terraform for creating an AKS Landing Zone in Azure.  There are 4 key Terraform scripts in this repo to break the construction up logically into different areas that different groups might control.

1.  Networking.  This will create a Hub Resource Group and a VNet as well as an Azure Firewall with Policies for AKS.
2.  AKS Resource group and AKS components.  This script will create a Resource Group for AKS as well as a separate spoke VNet that is peered with the Hub Net.  Optionally you can use this script to create necessary components like managed identities, KeyVault, ACR, etc.
3.  AKS Cluster.  This script provisions an AKS cluster with Cilium dataplane using Azure CNI networking
4.  AKS Worker Nodes.  This script simply adds worker nodes to an existing AKS Cluster
