// Provision a basic AKS cluster for demo and portfolio scenarios.
param location string = resourceGroup().location
param clusterName string = 'cib-aks-dev'
param dnsPrefix string = 'cib-aks-dev'
param kubernetesVersion string = '1.29.4'
param agentCount int = 2
param vmSize string = 'Standard_D4s_v5'

resource aks 'Microsoft.ContainerService/managedClusters@2024-01-01' = {
  name: clusterName
  location: location
  identity: {
    type: 'SystemAssigned'
  }
  properties: {
    dnsPrefix: dnsPrefix
    kubernetesVersion: kubernetesVersion
    agentPoolProfiles: [
      {
        name: 'systempool'
        count: agentCount
        vmSize: vmSize
        mode: 'System'
        osType: 'Linux'
        type: 'VirtualMachineScaleSets'
      }
    ]
    networkProfile: {
      networkPlugin: 'azure'
      loadBalancerSku: 'standard'
    }
  }
}

output aksId string = aks.id

