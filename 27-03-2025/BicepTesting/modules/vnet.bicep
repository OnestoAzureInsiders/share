param name string
param location string
param addressSpace string

resource vnet 'Microsoft.Network/virtualNetworks@2024-05-01' = {
  name: name
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: [
        addressSpace
      ]
    }
    subnets: [
      {
        name: 'default'
        properties: {
          addressPrefix: cidrSubnet(addressSpace,28,0)
        }
      }
    ]    
  }
}
