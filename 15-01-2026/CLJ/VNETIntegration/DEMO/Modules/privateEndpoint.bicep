param privateEndpointName string
param location string = resourceGroup().location
param subnetResourceId string
param privateLinkServiceId string
param groupId string
param tags object = {}

resource privateEndpoint 'Microsoft.Network/privateEndpoints@2024-03-01' = {
  name: privateEndpointName
  location: location
  properties: {
    customNetworkInterfaceName: 'nic-${privateEndpointName}'
    subnet: {
      id: subnetResourceId      
    }
    privateLinkServiceConnections: [
      {
        name: privateEndpointName
        properties: {
          privateLinkServiceId: privateLinkServiceId
          groupIds: [
            groupId
          ]
        }
      }
    ]
  }
  tags: tags
}

output privateEndpointName string = privateEndpoint.name
