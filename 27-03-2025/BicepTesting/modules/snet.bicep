param name string
param vnetName string
param addressPrefix string

resource vnet 'Microsoft.Network/virtualNetworks@2024-05-01' existing = {
  name: vnetName
}

resource snet 'Microsoft.Network/virtualNetworks/subnets@2024-05-01' = {
  parent: vnet
  name: name
  properties: {
    addressPrefix: addressPrefix
  }
}
