targetScope = 'resourceGroup'

param location string
param virtualNetworkName string
param addressSpace string
param dnsServers array = []
param subnets object[]
param tags object = {}

resource vnet 'Microsoft.Network/virtualNetworks@2024-03-01' = {
  name: virtualNetworkName
  location: location
  tags: tags
  properties: {
    addressSpace: {
      addressPrefixes: [addressSpace]
    }
    dhcpOptions: empty(dnsServers) ? {} : {
      dnsServers: dnsServers
    }
    subnets: [for sNet in subnets: {
      name:sNet.subnetName
      properties: {
        addressPrefix: sNet.addressPrefix
        networkSecurityGroup: contains(sNet, 'nsgName') ? {
          id: resourceId('Microsoft.Network/networkSecurityGroups', sNet.nsgName)
        }: null 
        routeTable: contains(sNet, 'routeTableName') ? {
          id: resourceId('Microsoft.Network/routeTables', sNet.routeTableName)
        } : null
        delegations: sNet.?subnetDelegations
        privateEndpointNetworkPolicies: sNet.?privateEndpointNetworkPolicies
        serviceEndpoints: contains(sNet, 'serviceEndpoints') && !empty(sNet.serviceEndpoints) ? sNet.serviceEndpoints : null
      }
    }]
  }
}

output id string = vnet.id
output subnets object[] = vnet.properties.subnets
