@description('The name of the IP range allocation')
param allocationName string

// @description('The type of allocation to make. Next available range or a specific range (NB: You must ensure the requested ranges is free)')
// @allowed(['NextAvailable','SpecificRanges'])
// param allocationType string = 'NextAvailable'

@description('The description of the Static CIDR allocation')
param allocationDescription string = ''

@description('The network mask of the desired range, e.g. 24. Defaults to 24 (class C range)')
@minValue(16)
@maxValue(29)
param networkMask int = 24

// @description('Array of specific CIDR IP ranges to allocate, e.g. [\'100.100.11.0/24\',\'100.100.12.0/24\']. To use this parameter, you must set allocationType to \'SpecificRanges\'')
// param cidrRanges string[] = []

@description('The name of the Virtual Network Management instance to use for IPAM')
param avnmInstanceName string

@description('Name of IP Pool to use for allocation of IP range')
param ipPoolName string

@description('This hashtable is used programmatically to calculate network sizes.')
var networkRanges = {
  '29': '8'
  '28': '16'
  '27': '32'
  '26': '64'
  '25': '128'
  '24': '256'
  '23': '512'
  '22': '1024'
  '21': '2048'
  '20': '4096'
  '19': '8192'
  '18': '16384'
  '17': '32768'
  '16': '65536'
}

resource vnetmgr 'Microsoft.Network/networkManagers@2024-01-01' existing = {
  name: avnmInstanceName
}

resource ippool 'Microsoft.Network/networkManagers/ipamPools@2024-01-01-preview' existing = {
  name: ipPoolName
  parent: vnetmgr
}

resource iprange 'Microsoft.Network/networkManagers/ipamPools/staticCidrs@2024-01-01-preview' = {
  name: allocationName
  parent: ippool
  properties: {
    numberOfIPAddressesToAllocate: networkRanges['${networkMask}']
    //numberOfIPAddressesToAllocate: allocationType == 'NextAvailable' ? networkRanges['${networkMask}'] : null
    // addressPrefixes: allocationType == 'SpecificRanges' ? cidrRanges : null
    description: allocationDescription
  }
}

// Output the assigned address range and the number of ip addresses in the range
// Use Bicep Cidr functions on the output to calculate possible subnets, e.g. "var subnets = [for i in range(0, 8): cidrSubnet(iprange.properties.addressPrefixes[0], 27, i)]" will return 8 subnets for a /24 vNet.
output addressPrefixes array = iprange.properties.addressPrefixes
output totalNumberOfIPAddresses string = iprange.properties.totalNumberOfIPAddresses
