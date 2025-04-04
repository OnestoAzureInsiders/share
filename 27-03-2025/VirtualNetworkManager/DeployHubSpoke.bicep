targetScope = 'subscription'
var numberOfSpokes = 4
var vnetnameprefix = 'vnet-spoke-p-weu-0'
var resourcegroupnameprefix = 'rg-insiderspoke-p-weu-0'
var location = 'westeurope'
var vnetaddressprefix = '10.150.0.0/16'
var resourcegroupHub = 'rg-insiderhub-p-weu-01'
var vnethubprefix = 'vnet-hub-p-weu-0'
var resourcegroupavnm = 'rg-insideravnm-p-weu-01'
@secure()
param pwd string

resource spokeResGRp 'Microsoft.Resources/resourceGroups@2021-04-01' = [for i in range(0, numberOfSpokes): {
  name: '${resourcegroupnameprefix}${i}'
  location: location
}]
 
module linuxvm 'Linuxvm.bicep' = [for i in range(0, numberOfSpokes): {
  name: 'linuxvm${i}'
  scope: spokeResGRp[i]
  params: {
    vnetname: '${vnetnameprefix}${i}'
    location: location
    vnetaddressprefix: cidrSubnet(vnetaddressprefix, 24, i)
    vmname: 'vmlinux${i}'
    type: 'Spoke'
    pwd: pwd
  }
  dependsOn:[
    spokeResGRp[i]
]
  }

] 

// Create HUB
resource hubResGrp 'Microsoft.Resources/resourceGroups@2021-04-01' =  {
  name: resourcegroupHub
  location: location
}

module hubvm 'Linuxvm.bicep' =  {
  name: 'linuxhubvm1'
  scope: hubResGrp
  params: {
    vnetname: '${vnethubprefix}2'
    location: location
    vnetaddressprefix: cidrSubnet(vnetaddressprefix, 24, 20)
    vmname: 'vmlinuxhub1'
    type: 'Hub'
    pwd: pwd
  }
  dependsOn:[
    
]
  }

  resource avnmResGRp 'Microsoft.Resources/resourceGroups@2021-04-01' = {
    name: resourcegroupavnm
    location: location
  }

  

 
