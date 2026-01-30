targetScope = 'subscription'

var locationNeu = 'northeurope'
var locationWeu = 'westeurope'
var resourceGroupNameNeu = 'rg-datagwpoc-network-d-neu-001'
var resourceGroupNameWeu = 'rg-datagwpoc-network-d-weu-001'
var tags = {
  'Cost Center': 'Azure Insiders'
}

var vNetNameNeu = 'vnet-datagwpoc-d-neu-001'
var vNetNameWeu = 'vnet-datagwpoc-d-weu-001'

param timeStamp string = utcNow('yyyyMMddHHmm')

module rgNeu 'Modules/resourceGroup.bicep' = {
  params: {
    location: locationNeu
    resourceGroupName: resourceGroupNameNeu
    tags: tags
  }
}

module rgWeu 'Modules/resourceGroup.bicep' = {
  params: {
    location: locationWeu
    resourceGroupName: resourceGroupNameWeu
    tags: tags
  }
}

module nwNeu 'Modules/networkWatcher.bicep' = {
  scope: resourceGroup(resourceGroupNameNeu)
  params: {
    location: locationNeu
    networkWatcherName: 'nw-datagwpoc-d-neu-001'
    tags: tags
  }
  dependsOn: [
    rgNeu
  ]
}

module nwWeu 'Modules/networkWatcher.bicep' = {
  scope: resourceGroup(resourceGroupNameWeu)
  params: {
    location: locationWeu
    networkWatcherName: 'nw-datagwpoc-d-weu-001'
    tags: tags
  }
  dependsOn: [
    rgWeu
  ]
}

module vnetNeu 'Modules/virtualNetwork.bicep' = {
  scope: resourceGroup(resourceGroupNameNeu)
  params: {
    location: locationNeu
    addressSpace: '172.16.128.0/24'
    tags: tags
    subnets: [
      {
        subnetName: 'snet-datagwpoc-powerplatform-001'
        addressPrefix: '172.16.128.0/27'
        subnetDelegations: [
          {
            name: 'Microsoft.PowerPlatform/enterprisePolicies'
            properties: {
              serviceName: 'Microsoft.PowerPlatform/enterprisePolicies'
            }
          }
        ]
      }
      {
        subnetName: 'snet-datagwpoc-fabric-001'
        addressPrefix: '172.16.128.32/27'
        subnetDelegations: [
          {
            name: 'Microsoft.PowerPlatform/vnetaccesslinks'
            properties: {
              serviceName: 'Microsoft.PowerPlatform/vnetaccesslinks'
            }
          }
        ]
      }
      {
        subnetName: 'snet-datagwpoc-data-in-001'
        addressPrefix: '172.16.128.64/28'
      }
    ]
    virtualNetworkName: vNetNameNeu
  }
  dependsOn: [
    nwNeu
  ]
}

module vnetWeu 'Modules/virtualNetwork.bicep' = {
  scope: resourceGroup(resourceGroupNameWeu)
  params: {
    location: locationWeu
    addressSpace: '172.16.64.0/24'
    tags: tags
    subnets: [
      {
        subnetName: 'snet-datagwpoc-powerplatform-001'
        addressPrefix: '172.16.64.0/27'
        subnetDelegations: [
          {
            name: 'Microsoft.PowerPlatform/enterprisePolicies'
            properties: {
              serviceName: 'Microsoft.PowerPlatform/enterprisePolicies'
            }
          }
        ]
      }
      {
        subnetName: 'snet-insidersvm-001'
        addressPrefix: '172.16.64.64/28'
      }
    ]
    virtualNetworkName: vNetNameWeu
  }
  dependsOn: [
    nwWeu
  ]
}

module neuToWeuPeeringDeployment 'Modules/peering.bicep' = {
  name: 'neuToWeuPeering-${timeStamp}'
  scope: resourceGroup(resourceGroupNameNeu)
  params: {
    virtualNetworkName: vNetNameNeu
    remoteResourceGroup: resourceGroupNameWeu
    remoteVirtualNetworkName: vNetNameWeu
    remoteSubscriptionId: subscription().subscriptionId
    peeringName: 'peering-to-${vNetNameWeu}'
  }
  dependsOn: [
    vnetNeu
    vnetWeu
  ]
}

module weuToNeuPeeringDeployment 'Modules/peering.bicep' = {
  name: 'weuToNeuPeering-${timeStamp}'
  scope: resourceGroup(resourceGroupNameWeu)
  params: {
    virtualNetworkName: vNetNameWeu
    remoteResourceGroup: resourceGroupNameNeu
    remoteVirtualNetworkName: vNetNameNeu
    remoteSubscriptionId: subscription().subscriptionId
    peeringName: 'peering-to-${vNetNameNeu}'
  }
  dependsOn: [
    neuToWeuPeeringDeployment
  ]
}

/// SQL DB
module sqlServer 'Modules/sqlServer.bicep' = {
  name: 'sqlServer-${timeStamp}'
  scope: resourceGroup(resourceGroupNameNeu)
  params: {
    location: locationNeu
    login: 'admin@lenander.name'
    name: 'sqlsvrinsiders${substring(uniqueString(subscription().id),0,5)}'
    objectId: 'db2181fb-d096-4bbb-9ff9-683c47d34917'
    //clientIp: '185.107.203.82'
    publicNetworkAccess: 'Disabled'
    tags: tags
  }
}

module sqlDb 'Modules/sqlDb.bicep' = {
  scope: resourceGroup(resourceGroupNameNeu)
  params: {
    name: 'sqldb-insiders-neu-001'
    location: locationNeu
    sqlServerName: sqlServer.outputs.sqlServerName
    sampleName: 'AdventureWorksLT'
    tags: tags
  }
}

module privateDnsZone 'Modules/privateDnsZone.bicep' = {
  scope: resourceGroup(resourceGroupNameNeu)
  params: {
    privateDnsZoneName: 'privatelink.database.windows.net'
    vnetName: vNetNameNeu
    vnetResourceGroup: resourceGroupNameNeu
    tags: tags
  }
}

module privateDnsZoneVnetLink 'Modules/privateDnsZoneVnetLink.bicep' = {
  scope: resourceGroup(resourceGroupNameNeu)
  params: {
    parentDnsZone: 'privatelink.database.windows.net'
    vNetId: vnetWeu.outputs.id
  }
}

module privateEndpoint 'Modules/privateEndpoint.bicep' = {
  scope: resourceGroup(resourceGroupNameNeu)
  params: {
    groupId: 'sqlServer'
    privateEndpointName: 'pe-sqlsvrinsiders${substring(uniqueString(subscription().id),0,5)}'
    privateLinkServiceId: sqlServer.outputs.id
    subnetResourceId: vnetNeu.outputs.subnets[2].id
  }
}

module privateDnsZoneGroup 'Modules/privateDnsZoneGroup.bicep' = {
  scope: resourceGroup(resourceGroupNameNeu)
  params: {
    privateDnsZoneResourceId: [privateDnsZone.outputs.id]
    privateEndpointName: privateEndpoint.outputs.privateEndpointName
  }
}

module fabric 'Modules/fabric.bicep' = {
  scope: resourceGroup(resourceGroupNameNeu)
  params: {
    name: 'fabricinsiders'
    location: locationNeu
    member: ['admin@lenander.name']
    skuName: 'F2'
  }
}
