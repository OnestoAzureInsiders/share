param name string = 'Enterprise-Policy-PoC'
param location string = 'europe'
param tags object = {}
param vnetId1 string
param vnetId2 string
param snetName1 string
param snetName2 string

resource enterprisePolicy 'Microsoft.PowerPlatform/enterprisePolicies@2020-10-30-preview' = {  
  name: name
  location: location
  kind: 'NetworkInjection'
  tags: tags
  properties: {
    networkInjection: {
      virtualNetworks: [
        {
          id: vnetId1
          subnet: {
            name: snetName1
          }
        }
        {
          id: vnetId2
          subnet: {
            name: snetName2
          }
        }
      ]
    }
  }
}
