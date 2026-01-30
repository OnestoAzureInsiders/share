param vnetName string
param vnetResourceGroup string
param privateDnsZoneName string
param tags object = {}

resource vnet 'Microsoft.Network/virtualNetworks@2024-05-01' existing = {
  scope: resourceGroup(vnetResourceGroup)
  name: vnetName
}

resource privateDnsZone 'Microsoft.Network/privateDnsZones@2024-06-01' = {
  name: privateDnsZoneName
  location: 'global'
  tags: tags
}

// resource privateDnsZoneLink 'Microsoft.Network/privateDnsZones/virtualNetworkLinks@2024-06-01' = {
//   parent: privateDnsZone
//   name: '${vnet.name}-link'
//   location: 'global'
//   properties: {
//     virtualNetwork: {
//       id: vnet.id
//     }
//     resolutionPolicy: contains(privateDnsZoneName, 'privatelink') ? 'NxDomainRedirect' : null
//     registrationEnabled: false
//   }
// }

output id string = privateDnsZone.id
