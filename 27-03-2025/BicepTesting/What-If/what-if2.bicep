targetScope = 'subscription'

var rgName = 'rg-test'

module snet '../modules/snet.bicep' = {
  scope: resourceGroup(rgName)
  name: 'snet-deploy'
  params: {
    name: 'snet-test'
    addressPrefix: cidrSubnet('192.168.0.0/24',28,1)
    vnetName: 'vnet-test'
  }
}
