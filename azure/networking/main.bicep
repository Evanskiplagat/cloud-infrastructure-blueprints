// Deploy a virtual network with segmented subnets and a reusable network security group.
param location string = resourceGroup().location
param vnetName string = 'cib-vnet-dev'
param addressSpace string = '10.20.0.0/16'
param appSubnetPrefix string = '10.20.1.0/24'
param aksSubnetPrefix string = '10.20.2.0/24'
param nsgName string = 'cib-core-nsg-dev'

resource nsg 'Microsoft.Network/networkSecurityGroups@2023-09-01' = {
  name: nsgName
  location: location
  properties: {
    securityRules: [
      {
        name: 'AllowHttpsInbound'
        properties: {
          access: 'Allow'
          direction: 'Inbound'
          priority: 100
          protocol: 'Tcp'
          sourceAddressPrefix: '*'
          sourcePortRange: '*'
          destinationAddressPrefix: '*'
          destinationPortRange: '443'
        }
      }
    ]
  }
}

resource vnet 'Microsoft.Network/virtualNetworks@2023-09-01' = {
  name: vnetName
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: [
        addressSpace
      ]
    }
    subnets: [
      {
        name: 'app-subnet'
        properties: {
          addressPrefix: appSubnetPrefix
          networkSecurityGroup: {
            id: nsg.id
          }
        }
      }
      {
        name: 'aks-subnet'
        properties: {
          addressPrefix: aksSubnetPrefix
          networkSecurityGroup: {
            id: nsg.id
          }
        }
      }
    ]
  }
}

output vnetId string = vnet.id

