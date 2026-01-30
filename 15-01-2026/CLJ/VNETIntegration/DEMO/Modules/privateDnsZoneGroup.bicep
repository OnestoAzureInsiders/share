param privateEndpointName string
param privateDnsZoneResourceId array

param privateDnsZoneGroupName string = '${last(split(privateDnsZoneResourceId[0],'/'))}-${privateEndpointName}'

resource privateEndpoint 'Microsoft.Network/privateEndpoints@2024-03-01' existing = {
  name: privateEndpointName
}

resource privateDnsZoneGroup 'Microsoft.Network/privateEndpoints/privateDnsZoneGroups@2024-03-01' = {
  parent: privateEndpoint
  name: privateDnsZoneGroupName
  properties: {
    privateDnsZoneConfigs: [
      for zone in privateDnsZoneResourceId: {
        name: last(split(zone, '/'))
        properties: {
          privateDnsZoneId: zone
        }
      }
    ]
  }
}
