param timeStamp string = replace(replace(utcNow('u'), ' ', '_'), ':', '')
var location = 'westeurope'
var resGrp = 'rg-azinsiders-ipam-p-we-001'
var vNetMgrName = 'vnm-azinsiders-ipam-p-we-001'

targetScope = 'subscription'

// Deploy Resource Group for IPAM
module vnetMgrResGrp '../../../../Azure/Bicep/Network/ResourceGroup.bicep' = {
  scope: subscription()
  name: '${resGrp}-${timeStamp}'
  params: {
    name: resGrp
    location: location
    tags: {}
  }
}

// Deploy Virtual Network Manager for IPAM
module vNetMgr '../../../../Azure/Bicep/IPAM/vNetManager.bicep' = {
  scope: resourceGroup(resGrp)
  name: '${vNetMgrName}-${timeStamp}'
  dependsOn: [vnetMgrResGrp]
  params: {
    avnmInstanceName: vNetMgrName
    subscriptionScopes: [
      subscription().id
    ]
  }
}

var ipPools = {
  prod: {
    name: 'prod'
    addressRange: '100.100.0.0/16'
  }
  test: {
    name: 'test'
    addressRange: '100.102.0.0/16'
  }
  dev: {
    name: 'dev'
    addressRange: '100.104.0.0/16'
  }
}

// Deploy IP Pools
module vNetMgrIpPools '../../../../Azure/Bicep/IPAM/vNetManagerIpPool.bicep' = [for ippool in items(ipPools): {
  scope: resourceGroup(resGrp)
  name: '${ippool.value.name}-${timeStamp}'
  dependsOn: [vNetMgr]
  params: {
    addressPrefixes: [ippool.value.addressRange]
    avnmInstanceName: vNetMgrName
    ipPoolName: ippool.value.name
  }
}]

// @batchSize(1)
// module prodReservations '../../../../Azure/Bicep/IPAM/vNetManagerStaticCidrAllocation.bicep' = [for counter in range(0,11): {
//   scope: resourceGroup(resGrp)
//   name: 'staticcidr-prod-${counter}-${timeStamp}'
//   dependsOn: [vNetMgrIpPools]
//   params: {
//     allocationName: 'Corenetwork-${counter}'
//     avnmInstanceName: vNetMgrName
//     ipPoolName: 'prod'
//     networkMask: 24
//     allocationDescription: 'Reserved for core-networking'
//   }
// }]


// @batchSize(1)
// module testReservations '../../../../Azure/Bicep/IPAM/vNetManagerStaticCidrAllocation.bicep' = [for counter in range(0,11): {
//   scope: resourceGroup(resGrp)
//   name: 'staticcidr-test-${counter}-${timeStamp}'
//   dependsOn: [vNetMgrIpPools]
//   params: {
//     allocationName: 'Corenetwork-${counter}'
//     avnmInstanceName: vNetMgrName
//     ipPoolName: 'test'
//     networkMask: 24
//     allocationDescription: 'Reserved for core-networking'
//   }
// }]

// @batchSize(1)
// module devReservations '../../../../Azure/Bicep/IPAM/vNetManagerStaticCidrAllocation.bicep' = [for counter in range(0,11): {
//   scope: resourceGroup(resGrp)
//   name: 'staticcidr-dev-${counter}-${timeStamp}'
//   dependsOn: [vNetMgrIpPools]
//   params: {
//     allocationName: 'Corenetwork-${counter}'
//     avnmInstanceName: vNetMgrName
//     ipPoolName: 'dev'
//     networkMask: 24
//     allocationDescription: 'Reserved for core-networking'
//   }
// }]


// // Reserve the first 11 class C subnets of each environment, for platform components
// module prodReservations '../../../../Azure/Bicep/IPAM/vNetManagerStaticCidrAllocation.bicep' = {
//   scope: resourceGroup(resGrp)
//   name: 'staticcidr-prod-${timeStamp}'
//   dependsOn: [vNetMgrIpPools]
//   params: {
//     allocationName: 'Corenetwork'
//     avnmInstanceName: vNetMgrName
//     ipPoolName: 'prod'
//     allocationDescription: 'Reserved for core-networking'
//     cidrRanges: [for i in range(0,11):cidrSubnet('${ipPools.prod.addressRange}',24,i)]
//   }
// }

// module testReservations '../../../../Azure/Bicep/IPAM/vNetManagerStaticCidrAllocation.bicep' = {
//   scope: resourceGroup(resGrp)
//   name: 'staticcidr-test-${timeStamp}'
//   dependsOn: [
//     vNetMgrIpPools
//     prodReservations
//   ]
//   params: {
//     allocationName: 'Corenetwork'
//     avnmInstanceName: vNetMgrName
//     ipPoolName: 'test'
//     allocationDescription: 'Reserved for core-networking'
//     cidrRanges: [for i in range(0,11):cidrSubnet('${ipPools.test.addressRange}',24,i)]
//   }
// }

// module devReservations '../../../../Azure/Bicep/IPAM/vNetManagerStaticCidrAllocation.bicep' = {
//   scope: resourceGroup(resGrp)
//   name: 'staticcidr-dev-${timeStamp}'
//   dependsOn: [
//     vNetMgrIpPools
//     testReservations
//   ]
//   params: {
//     allocationName: 'Corenetwork'
//     avnmInstanceName: vNetMgrName
//     ipPoolName: 'dev'
//     allocationDescription: 'Reserved for core-networking'
//     cidrRanges: [for i in range(0,11):cidrSubnet('${ipPools.dev.addressRange}',24,i)]
//   }
// }
