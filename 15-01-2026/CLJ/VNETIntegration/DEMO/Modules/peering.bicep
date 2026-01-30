param virtualNetworkName string
param allowForwardedTraffic bool = true
param allowGatewayTransit bool = false
param allowVirtualNetworkAccess bool = true
param useRemoteGateways bool = false
param remoteResourceGroup string
param remoteVirtualNetworkName string
param remoteSubscriptionId string 
param peeringName string


resource virtualNetwork 'Microsoft.Network/virtualNetworks@2024-03-01' existing = {
  name: virtualNetworkName
}

resource peering 'Microsoft.Network/virtualNetworks/virtualNetworkPeerings@2024-03-01' = {
  parent: virtualNetwork
  name: peeringName
  properties: {
    allowForwardedTraffic: allowForwardedTraffic
    allowGatewayTransit: allowGatewayTransit
    allowVirtualNetworkAccess: allowVirtualNetworkAccess
    useRemoteGateways: useRemoteGateways
    remoteVirtualNetwork: {
      id: resourceId(remoteSubscriptionId, remoteResourceGroup, 'Microsoft.Network/virtualNetworks', remoteVirtualNetworkName)
    }
  }
}
