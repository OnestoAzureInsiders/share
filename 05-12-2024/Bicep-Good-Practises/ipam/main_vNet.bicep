@allowed(['prod','test','dev'])
param environment string
@description('The system identifier for the environment')
param sysid string 
param timeStamp string = replace(replace(utcNow('u'), ' ', '_'), ':', '')

targetScope = 'subscription'

////////////////////////////////////
// Common variables used in deplyment
////////////////////////////////////
// var globalEnvConfig = loadJsonContent('../lzGlobalEnvironmentConfig.json')
// var localEnvConfig = loadJsonContent('./localEnvironmentConfig.json')
//var lzConfig = union(localEnvConfig[environment],localEnvConfig.common)
var environmentTypes = {
  prod: {
    environment: 'Production'
    abbreviation: 'p'
  }
  test: {
    environment: 'Test'
    abbreviation: 't'
  }
  dev: {
    environment: 'Development'
    abbreviation: 'd'
  }
}
var envShort = environmentTypes[environment].abbreviation
var envLong = environmentTypes[environment].environment
var location = 'westeurope'
var locationShort = 'we'
var vNetMgrRg = 'rg-azinsiders-ipam-p-we-001'
var vNetMgrName = 'vnm-azinsiders-ipam-p-we-001'
var fwIp = '100.100.0.4'
var fwSubnet = '100.100.0.0/26'
var appGwSubnet = '100.100.1.0/26'
var tags = {
  Environment: envLong
  SYSID: sysid
}


////////////////////////////////////
// Variables for network
////////////////////////////////////

var vNetResourceGroup = 'rg-${sysid}-network-${envShort}-${locationShort}-001'
var vNetName = 'vnet-${sysid}-${envShort}-${locationShort}-001'
var rtName = 'rt-${sysid}-${envShort}-${locationShort}-001'
var snetPrefix = 'snet-${sysid}-${envShort}-${locationShort}'
var nsgPrefix = 'nsg-${sysid}-${envShort}-${locationShort}'

////////////////////////////////////
// Deploy resources
////////////////////////////////////

// Deploy network resource groups
module resGrp '../../../../Azure/Bicep/Network/ResourceGroup.bicep' = {
  scope: subscription()
  name: '${vNetResourceGroup}-${timeStamp}'
  params: {
    name: vNetResourceGroup
    tags: tags
    location: location
  }
}

// Reserve/fetch IP address range
module iprange '../../../../Azure/Bicep/IPAM/vNetManagerStaticCidrAllocation.bicep' = {
  scope: resourceGroup(vNetMgrRg)
  name: 'iprange-${sysid}-${environment}-${timeStamp}'
  params: {
    allocationName: vNetName
    avnmInstanceName: vNetMgrName
    ipPoolName: environment
  }
}

// Deploy route table
module rt '../../../../Azure/Bicep/Network/routeTable.bicep' = {
  scope: resourceGroup(vNetResourceGroup)
  name: rtName
  dependsOn: [resGrp]
  params: {
    firewallIp: fwIp
    routeTableName: rtName
    useDefaultRoute: true
  }
}

// Define subnets (for ease of block re-use in vNet and NSG's)
var subnets = {
  web_in: {
    subnetName: '${snetPrefix}-web-in'
    nsgName:  '${nsgPrefix}-web-in'
    subnet: cidrSubnet(iprange.outputs.addressPrefixes[0],27,0)
  }
  web_out: {
    subnetName: '${snetPrefix}-web-out'
    nsgName:  '${nsgPrefix}-web-out'
    subnet: cidrSubnet(iprange.outputs.addressPrefixes[0],27,1)
  }
  data: {
    subnetName: '${snetPrefix}-data'
    nsgName:  '${nsgPrefix}-data'
    subnet: cidrSubnet(iprange.outputs.addressPrefixes[0],27,2)
  }
  keyvault: {
    subnetName: '${snetPrefix}-keyvault'
    nsgName:  '${nsgPrefix}-keyvault'
    subnet: cidrSubnet(iprange.outputs.addressPrefixes[0],27,3)
  }
  devopsagent: {
    subnetName: '${snetPrefix}-devopsagent'
    nsgName:  '${nsgPrefix}-devopsagent'
    subnet: cidrSubnet(iprange.outputs.addressPrefixes[0],27,4)
  }
}

module vNet '../../../../Azure/Bicep/Network/virtualNetwork.bicep' = {
  scope: resourceGroup(vNetResourceGroup)
  name: '${vNetName}-${timeStamp}'
  dependsOn: [
    resGrp
    iprange
  ]
  params: {
    subnets: [
      {
        addressPrefix: subnets.web_in.subnet
        nsgName: nsgWebIn.outputs.nsgName               // Create implicit dependency on the NSG creation, controls creation order.
        routeTableName: rt.outputs.routeTableName
        subnetName: subnets.web_in.subnetName
        subnetDelegation: []
        enableDefaultOutboundAccess: false
      }
      {
        addressPrefix: subnets.web_out.subnet
        nsgName: nsgWebOut.outputs.nsgName              // Create implicit dependency on the NSG creation, controls creation order.
        routeTableName: rt.outputs.routeTableName
        subnetName: subnets.web_out.subnetName
        subnetDelegation: []
        enableDefaultOutboundAccess: false
      }
      {
        addressPrefix: subnets.data.subnet
        nsgName: nsgData.outputs.nsgName                // Create implicit dependency on the NSG creation, controls creation order.
        routeTableName: rt.outputs.routeTableName
        subnetName: subnets.data.subnetName
        subnetDelegation: []
        enableDefaultOutboundAccess: false
      }
      {
        addressPrefix: subnets.keyvault.subnet
        nsgName: nsgKeyvault.outputs.nsgName            // Create implicit dependency on the NSG creation, controls creation order.
        routeTableName: rt.outputs.routeTableName
        subnetName: subnets.keyvault.subnetName
        subnetDelegation: []
        enableDefaultOutboundAccess: false
      }
      {
        addressPrefix: subnets.devopsagent.subnet
        nsgName: nsgDevOpsAgent.outputs.nsgName         // Create implicit dependency on the NSG creation, controls creation order.
        routeTableName: rt.outputs.routeTableName
        subnetName: subnets.devopsagent.subnetName
        subnetDelegation: []
        enableDefaultOutboundAccess: false
      }
    ]
    vNetAddressRange: iprange.outputs.addressPrefixes[0]
    vNetName: vNetName
  }
}

// Deploy Network security group(s)

module nsgWebIn '../../../../Azure/Bicep/Network/NetworkSecurityGroup.bicep' = {
  scope: resourceGroup(vNetResourceGroup)
  name: 'nsg-web-in-${timeStamp}'
  dependsOn: [
    resGrp
    iprange
  ]
  params: {
    tags: tags
    firewallSubnet: fwSubnet
    nsgName: subnets.web_in.nsgName
    useDefaultRuleSet: true
    nsgRuleSet: [
      {
        name: 'AllowIntraSubnetCommunication'
        properties: {
          access: 'Allow'
          description: 'Allow communication between services in the same subnet'
          destinationAddressPrefix: subnets.web_in.subnet
          destinationPortRange: '*'
          direction: 'Inbound'
          priority: 1000
          protocol: '*'
          sourceAddressPrefix: subnets.web_in.subnet
          sourcePortRange: '*'
        }
      }
      {
        name: 'AllowInboundHttpsFromAppGateway'
        properties: {
          access: 'Allow'
          description: 'Allow inbound communication from the shared Application Gateway'
          destinationAddressPrefix: '*'
          destinationPortRange: '443'
          direction: 'Inbound'
          priority: 1050
          protocol: 'Tcp'
          sourceAddressPrefix: appGwSubnet
          sourcePortRange: '*'
        }
      }
    ]
  }
}

module nsgWebOut '../../../../Azure/Bicep/Network/NetworkSecurityGroup.bicep' = {
  scope: resourceGroup(vNetResourceGroup)
  name: 'nsg-web-out-${timeStamp}'
  dependsOn: [
    resGrp
    iprange
  ]
  params: {
    tags: tags
    firewallSubnet: fwSubnet
    nsgName: subnets.web_out.nsgName
    useDefaultRuleSet: true
  }
}

module nsgData '../../../../Azure/Bicep/Network/NetworkSecurityGroup.bicep' = {
  scope: resourceGroup(vNetResourceGroup)
  name: 'nsg-data-${timeStamp}'
  dependsOn: [
    resGrp
    iprange
  ]
  params: {
    tags: tags
    firewallSubnet: fwSubnet
    nsgName: subnets.data.nsgName
    useDefaultRuleSet: true
    nsgRuleSet: [
      {
        name: 'AllowInboundHttpsFromWebOut'
        properties: {
          access: 'Allow'
          description: 'Allow inbound https from the web-out subnet'
          destinationAddressPrefix: '*'
          destinationPortRange: '443'
          direction: 'Inbound'
          priority: 1000
          protocol: 'Tcp'
          sourceAddressPrefix: subnets.web_out.subnet
          sourcePortRange: '*'
        }
      }
      {
        name: 'AllowInboundSqlFromWebOut'
        properties: {
          access: 'Allow'
          description: 'Allow inbound SQL from the web-out subnet'
          destinationAddressPrefix: '*'
          destinationPortRange: '1433'
          direction: 'Inbound'
          priority: 1010
          protocol: 'Tcp'
          sourceAddressPrefix: subnets.web_out.subnet
          sourcePortRange: '*'
        }
      }
    ]
  }
}

module nsgKeyvault '../../../../Azure/Bicep/Network/NetworkSecurityGroup.bicep' = {
  scope: resourceGroup(vNetResourceGroup)
  name: 'nsg-keyvault-${timeStamp}'
  dependsOn: [
    resGrp
    iprange
  ]
  params: {
    tags: tags
    firewallSubnet: fwSubnet
    nsgName: subnets.keyvault.nsgName
    useDefaultRuleSet: true
    nsgRuleSet: [
      {
        name: 'AllowInboundHttpsFromWebOut'
        properties: {
          access: 'Allow'
          description: 'Allow Inbound Https from the web-out subnet, to fetch secrets'
          destinationAddressPrefix: '*'
          destinationPortRange: '443'
          direction: 'Inbound'
          priority: 1000
          protocol: 'Tcp'
          sourceAddressPrefix: subnets.web_out.subnet
          sourcePortRange: '*'
        }
      }
    ]
  }
}

module nsgDevOpsAgent '../../../../Azure/Bicep/Network/NetworkSecurityGroup.bicep' = {
  scope: resourceGroup(vNetResourceGroup)
  name: 'nsg-devopsagent-${timeStamp}'
  dependsOn: [
    resGrp
    iprange
  ]
  params: {
    tags: tags
    firewallSubnet: fwSubnet
    nsgName: subnets.devopsagent.nsgName
    useDefaultRuleSet: true
  }
}
