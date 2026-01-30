targetScope = 'subscription'

var location = 'europe'
var resourceGroupNameNeu = 'rg-datagwpoc-network-d-neu-001'
var resourceGroupNameWeu = 'rg-datagwpoc-network-d-weu-001'

var tags = {
  'Cost Center': 'Azure Insiders'
}

var vNetNameNeu = 'vnet-datagwpoc-d-neu-001'
var vNetNameWeu = 'vnet-datagwpoc-d-weu-001'

var snetName = 'snet-datagwpoc-powerplatform-001'

module entPol 'Modules/enterprisePolicy.bicep' = {
  scope: resourceGroup(resourceGroupNameNeu)
  params: {
    name: 'Insiders-Enterprise-Policy'
    location: location
    tags: tags
    snetName1: snetName
    snetName2: snetName
    vnetId1: resourceId(subscription().subscriptionId,resourceGroupNameNeu,'Microsoft.Network/virtualNetworks',vNetNameNeu)
    vnetId2: resourceId(subscription().subscriptionId,resourceGroupNameWeu,'Microsoft.Network/virtualNetworks',vNetNameWeu)
  }
}
