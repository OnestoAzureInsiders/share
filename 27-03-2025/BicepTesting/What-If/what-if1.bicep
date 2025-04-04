targetScope = 'subscription'

var location = 'swedencentral'
var rgName = 'rg-test'

module rg '../modules/rg.bicep' = {
  name: 'rg-deply'
  params: {
    name: 'rg-test'
    location: location
  }
}

module vnet '../modules/vnet.bicep' = {
  scope: resourceGroup(rgName)
  name: 'vnet-deploy'
  params: {
    name: 'vnet-test'
    location: location
    addressSpace: '192.168.0.0/24'
  }
  dependsOn: [
    rg
  ]
}
