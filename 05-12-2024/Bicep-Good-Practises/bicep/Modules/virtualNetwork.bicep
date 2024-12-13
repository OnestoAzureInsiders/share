@description('Name of the virtual network')
param vNetName string
@description('Address Range of this virtual network')
param vNetAddressRange string
@description('Array of subnet objects, specifying the subnets to create in this virtual network.')
param subnets {
    @description('The address prefix of this subnet, e.g. \'100.102.11.0/24\'')
    addressPrefix: string
    @description('Name of subnet')
    subnetName: string
    @description('Name of Network Security Group (NSG) to apply to this subnet. NSG must reside in the same resource group as the virtual network.')
    nsgName: string
    @description('Name of route table to apply to this subnet. Route table must reside in the same resource group as the virtual network.')
    routeTableName: string
    @description('Array of delegations. This property can be omitted if no delegations are to be made. Array can only have 1 member.')
    subnetDelegation: {
      @description('Name of the delegation, unique within a subnet, e.g. \'Sql\'. This name can be used to access the resource.')
      name: string
      properties: {
        @description('The name of the service to whom the subnet should be delegated (e.g. Microsoft.Sql/servers).')
        serviceName: string
      }
    }[]
    @description('whether or not to enable default outbound access. Defaults to false, which means you must use a NAT gateway or Azure Firewall to provide outbound internet access')
    enableDefaultOutboundAccess: bool?
}[]
param location string = resourceGroup().location
param tags object = {}
param dnsServers array = []  // Add DNS server here if needed
@description('Specify which Private Endpoint network policies to enable')
@allowed(['Enabled','Disabled','NetworkSecurityGroupEnabled','RouteTableEnabled'])
param privateEndpointNetworkPolicies string = 'Enabled'  // Controls if private endpoints can be used with NSGs and Route tables

targetScope = 'resourceGroup'

resource vNet 'Microsoft.Network/virtualNetworks@2024-01-01' = {
  name: vNetName
  location: location
  tags: tags
  properties: {
    addressSpace: {
      addressPrefixes: [
        vNetAddressRange
      ]
    }
    dhcpOptions: empty(dnsServers) ? {} : {
      dnsServers: dnsServers
    }
    subnets: [for sNet in subnets: {
      name:sNet.subnetName
      properties: {
        addressPrefix: sNet.addressPrefix
        networkSecurityGroup: empty(sNet.nsgName) ? null : {
          id: resourceId('Microsoft.Network/networkSecurityGroups', sNet.nsgName)
        }
        routeTable: empty(sNet.routeTableName) ? null : {
          id: resourceId('Microsoft.Network/routeTables', sNet.routeTableName)
        }
        delegations: sNet.subnetDelegation!
        privateEndpointNetworkPolicies: privateEndpointNetworkPolicies
        defaultOutboundAccess: sNet.?enableDefaultOutboundAccess ?? false
      }
    }]
  }
}

output vNetResourceId string = vNet.id
output allSubnets array = subnets
