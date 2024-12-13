var location = 'swedencentral'

var hubVnetName = 'vnet-hub'
var hubVnetAddressRange = '192.168.128.0/24'
var spoke1VnetName = 'vnet-spoke1'
var spoke1VnetAddressRange = '192.168.129.0/24'
var spoke2VnetName = 'vnet-spoke2'
var spoke2VnetAddressRange = '192.168.130.0/24'

resource hubVnet 'Microsoft.Network/virtualNetworks@2024-03-01' = {
  name: hubVnetName
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: [
        hubVnetAddressRange
      ]
    }
    subnets: [
      {
        name: 'GatewaySubnet'
        properties: {
          addressPrefix: '192.168.128.0/26'
        }
      }
      {
        name: 'AzureBastionSubnet'
        properties: {
          addressPrefix: '192.168.128.64/26'
        }
      }
    ]
  }
}

resource spoke1Vnet 'Microsoft.Network/virtualNetworks@2024-03-01' = {
  name: spoke1VnetName
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: [
        spoke1VnetAddressRange
      ]
    }
    subnets: [
      {
        name: 'snet-vm'
        properties: {
          addressPrefix: '192.168.129.0/28'
        }
      }
      {
        name: 'snet-sql'
        properties: {
          addressPrefix: '192.168.129.16/28'
          privateEndpointNetworkPolicies: 'Enabled'
        }
      }
    ]
  }
}

resource spoke2Vnet 'Microsoft.Network/virtualNetworks@2024-03-01' = {
  name: spoke2VnetName
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: [
        spoke2VnetAddressRange
      ]
    }
    subnets: [
      {
        name: 'snet-private'
        properties: {
          addressPrefix: '192.168.130.0/28'
          defaultOutboundAccess: false
        }
      }      
    ]
  }
}

// Public IP for Bastion
resource bastionPip 'Microsoft.Network/publicIPAddresses@2024-03-01' = {
  name: 'pip-bastion'
  location: location
  properties: {
    publicIPAllocationMethod: 'Static'
  }
  sku: {
    name: 'Standard'
  }
  dependsOn: [
    hubVnet
  ]
}

// Peerings
resource hub2Spoke1 'Microsoft.Network/virtualNetworks/virtualNetworkPeerings@2024-03-01' = {
  parent: hubVnet
  name: '${hubVnetName}-${spoke1VnetName}'
  properties: {
    allowVirtualNetworkAccess: true
    allowForwardedTraffic: true
    allowGatewayTransit: false
    useRemoteGateways: false
    remoteVirtualNetwork: {
      id: spoke1Vnet.id
    }
  }
}

resource hub2Spoke2 'Microsoft.Network/virtualNetworks/virtualNetworkPeerings@2024-03-01' = {
  parent: hubVnet
  name: '${hubVnetName}-${spoke2VnetName}'
  properties: {
    allowVirtualNetworkAccess: true
    allowForwardedTraffic: true
    allowGatewayTransit: false
    useRemoteGateways: false
    remoteVirtualNetwork: {
      id: spoke2Vnet.id
    }
  }
}

resource spoke12Hub 'Microsoft.Network/virtualNetworks/virtualNetworkPeerings@2024-03-01' = {
  parent: spoke1Vnet
  name: '${spoke1VnetName}-${hubVnetName}'
  properties: {
    allowVirtualNetworkAccess: true
    allowForwardedTraffic: true
    allowGatewayTransit: false
    useRemoteGateways: false
    remoteVirtualNetwork: {
      id: hubVnet.id
    }
  }
}

resource spoke22Hub 'Microsoft.Network/virtualNetworks/virtualNetworkPeerings@2024-03-01' = {
  parent: spoke2Vnet
  name: '${spoke2VnetName}-${hubVnetName}'
  properties: {
    allowVirtualNetworkAccess: true
    allowForwardedTraffic: true
    allowGatewayTransit: false
    useRemoteGateways: false
    remoteVirtualNetwork: {
      id: hubVnet.id
    }
  }
}

resource spoke12spoke2 'Microsoft.Network/virtualNetworks/virtualNetworkPeerings@2024-03-01' = {
  parent: spoke1Vnet
  name: '${spoke1VnetName}-${spoke2VnetName}'
  properties: {
    allowVirtualNetworkAccess: true
    allowForwardedTraffic: true
    allowGatewayTransit: false
    useRemoteGateways: false
    remoteVirtualNetwork: {
      id: spoke2Vnet.id
    }
  }
}

resource spoke22spoke1 'Microsoft.Network/virtualNetworks/virtualNetworkPeerings@2024-03-01' = {
  parent: spoke2Vnet
  name: '${spoke2VnetName}-${spoke1VnetName}'
  properties: {
    allowVirtualNetworkAccess: true
    allowForwardedTraffic: true
    allowGatewayTransit: false
    useRemoteGateways: false
    remoteVirtualNetwork: {
      id: spoke1Vnet.id
    }
  }
}


// Bastion Host Premium SKU
resource bastion 'Microsoft.Network/bastionHosts@2024-03-01' = {
  name: 'bastion-hub'
  location: location
  sku: {
    name: 'Premium'
  }
  properties: {
    enableSessionRecording: true
    disableCopyPaste: true
    enableFileCopy: false
    enableIpConnect: true
    ipConfigurations: [
      {
        id: '${hubVnet.id}/subnets/AzureBastionSubnet'
        name: 'bastion-hub-ipconfig'
        properties: {
          privateIPAllocationMethod: 'Dynamic'
          publicIPAddress: {
            id: bastionPip.id
          }

          subnet: {
            id: '${hubVnet.id}/subnets/AzureBastionSubnet'
          }
        }
      }
    ]
  }
}

// Storage Account for session recording
resource storage 'Microsoft.Storage/storageAccounts@2023-05-01' = {
  name: 'sainsiders051224'
  location: location
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
  properties: {
    accessTier: 'Hot'
    allowBlobPublicAccess: true
    publicNetworkAccess: 'Enabled'    
  }

}

resource blobService 'Microsoft.Storage/storageAccounts/blobServices@2023-05-01' = {
  parent: storage
  name: 'default'
  properties: {
    cors: {
      corsRules: [
        {
          allowedOrigins: ['https://${bastion.properties.dnsName}']
          allowedMethods: ['GET']
          allowedHeaders: ['*']
          exposedHeaders: ['*']
          maxAgeInSeconds: 86400
        }
      ]
    }
  }
}

resource container 'Microsoft.Storage/storageAccounts/blobServices/containers@2023-05-01' = {
  parent: blobService
  name: 'sessionrecording'
  properties: {
    publicAccess: 'Container'
  }
}

// VM in spoke1 for session recording testing
resource nicVm1 'Microsoft.Network/networkInterfaces@2024-03-01' = {
  name: 'nic-vm-sr'
  location: location
  properties: {
    ipConfigurations: [
      {
        name: 'ipconfig-vm-sr'
        properties: {
          subnet: {
            id: '${spoke1Vnet.id}/subnets/snet-vm'
          }
          privateIPAllocationMethod: 'Dynamic'
        }
      }
    ]
  }
}

resource vm1 'Microsoft.Compute/virtualMachines@2024-07-01' = {
  name: 'vm-sr'
  location: location
  properties: {
    licenseType: 'Windows_Server'
    hardwareProfile: {
      vmSize: 'Standard_B2als_v2'
    }
    storageProfile: {
      imageReference: {
        publisher: 'MicrosoftWindowsServer'
        offer: 'WindowsServer'
        sku: '2025-datacenter-g2'
        version: 'latest'
      }
      osDisk: {
        createOption: 'FromImage'
        name: 'osdisk-vm-sr'
      }
    }
    osProfile: {
      computerName: 'vm-sr'
      adminUsername: 'casper'
      adminPassword: 'Lenander2024!'
    }
    networkProfile: {
      networkInterfaces: [
        {
          id: nicVm1.id
        }
      ]
    }
  }
}

// VM in spoke2 for testing private subnet
resource nicVm2 'Microsoft.Network/networkInterfaces@2024-03-01' = {
  name: 'nic-vm-private'
  location: location
  properties: {
    ipConfigurations: [
      {
        name: 'ipconfig-vm-private'
        properties: {
          subnet: {
            id: '${spoke2Vnet.id}/subnets/snet-private'
          }
          privateIPAllocationMethod: 'Dynamic'
        }
      }
    ]
  }
}

resource vm2 'Microsoft.Compute/virtualMachines@2024-07-01' = {
  name: 'vm-private'
  location: location
  properties: {
    licenseType: 'Windows_Server'
    hardwareProfile: {
      vmSize: 'Standard_B2als_v2'
    }
    storageProfile: {
      imageReference: {
        publisher: 'MicrosoftWindowsServer'
        offer: 'WindowsServer'
        sku: '2025-datacenter-g2'
        version: 'latest'
      }
      osDisk: {
        createOption: 'FromImage'
        name: 'osdisk-vm-private'
      }
    }
    osProfile: {
      computerName: 'vm-private'
      adminUsername: 'casper'
      adminPassword: 'Lenander2024!'
    }
    networkProfile: {
      networkInterfaces: [
        {
          id: nicVm2.id
        }
      ]
    }
  }
}

// Resources for Network Security Perimeter
resource sa2 'Microsoft.Storage/storageAccounts@2023-05-01' = {
  name: 'sa2insiders051224'
  location: location
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
  properties: {
    accessTier: 'Hot'
    allowBlobPublicAccess: false
    publicNetworkAccess: 'SecuredByPerimeter'
  }
  identity: {
    type: 'SystemAssigned'
  }
}

resource sqlServer 'Microsoft.Sql/servers@2024-05-01-preview' = {
  name: 'sqlinsiders051224'
  location: location
  properties: {
    administratorLogin: 'casper'
    administratorLoginPassword: 'Lenander2024!'
    version: '12.0'
    publicNetworkAccess: 'SecuredByPerimeter'
  }
  identity: {
    type: 'SystemAssigned'
  }  
}

resource sqlDb 'Microsoft.Sql/servers/databases@2024-05-01-preview' = {
  parent: sqlServer
  name: 'sqldbinsiders'
  location: location
  properties: {
    collation: 'SQL_Latin1_General_CP1_CI_AS'    
  }
  sku: {
    name: 'Basic'
    tier: 'Basic'
    capacity: 5    
  }
}

resource privateEndpoint 'Microsoft.Network/privateEndpoints@2024-03-01' = {
  name: 'pe-sqlinsiders051224'
  location: location
  properties: {
    subnet: {
      id: '${spoke1Vnet.id}/subnets/snet-sql'
    }
    privateLinkServiceConnections: [
      {
        name: 'pe-sqlinsiders051224'
        properties: {
          privateLinkServiceId: sqlServer.id
          groupIds: [
            'sqlServer'
          ]
        }
      }
    ]
  }
}

resource privateDnsZone 'Microsoft.Network/privateDnsZones@2020-06-01' = {
  name: 'privatelink${environment().suffixes.sqlServerHostname}'
  location: 'global'
  properties: {}
  dependsOn: [
    hubVnet
  ]
}

resource privateDnsZoneLinkSpoke1 'Microsoft.Network/privateDnsZones/virtualNetworkLinks@2020-06-01' = {
  parent: privateDnsZone
  name: 'privatelink${environment().suffixes.sqlServerHostname}-link-spoke1'
  location: 'global'
  properties: {
    registrationEnabled: false
    virtualNetwork: {
      id: spoke1Vnet.id
    }
  }
}

resource privateDnsZoneLinkSpoke2 'Microsoft.Network/privateDnsZones/virtualNetworkLinks@2020-06-01' = {
  parent: privateDnsZone
  name: 'privatelink${environment().suffixes.sqlServerHostname}-link-spoke2'
  location: 'global'
  properties: {
    registrationEnabled: false
    virtualNetwork: {
      id: spoke2Vnet.id
    }
  }
}

resource pvtEndpointDnsGroup 'Microsoft.Network/privateEndpoints/privateDnsZoneGroups@2021-05-01' = {
  parent: privateEndpoint
  name: 'mydnsgroupname'
  properties: {
    privateDnsZoneConfigs: [
      {
        name: 'config1'
        properties: {
          privateDnsZoneId: privateDnsZone.id
        }
      }
    ]
  }
}

// Network Security Perimeter
resource perimeter 'Microsoft.Network/networkSecurityPerimeters@2023-08-01-preview' = {
  name: 'perimeter-insiders'
  location: location  
}

resource profile 'Microsoft.Network/networkSecurityPerimeters/profiles@2023-08-01-preview' = {
  parent: perimeter
  name: 'insiders'
}

resource accessRuleInboundSub 'Microsoft.Network/networkSecurityPerimeters/profiles/accessRules@2023-08-01-preview' = {
  parent: profile
  name: 'inboundSub'
  properties: {
    direction: 'Inbound'
    subscriptions: [
      {
        id: subscription().id
      }
    ]        
  }  
}

resource accessRuleInboundIp 'Microsoft.Network/networkSecurityPerimeters/profiles/accessRules@2023-08-01-preview' = {
  parent: profile
  name: 'inboundIp'
  properties: {
    direction: 'Inbound'
    addressPrefixes: [
      '5.182.128.9/32'
    ]
  }
}

resource accessRuleOutbound 'Microsoft.Network/networkSecurityPerimeters/profiles/accessRules@2023-08-01-preview' = {
  parent: profile
  name: 'outbound'
  properties: {
    direction: 'Outbound'
    fullyQualifiedDomainNames: [
      'www.dr.dk'
    ]
  }
}

resource association1 'Microsoft.Network/networkSecurityPerimeters/resourceAssociations@2023-08-01-preview' = {
  parent: perimeter
  name: 'perimeter-association1'
  location: location
  properties: {
    accessMode: 'Enforced'
    profile: {
      id: profile.id
    }
    privateLinkResource: {
      id: sqlServer.id
    }
  }
}

resource association2 'Microsoft.Network/networkSecurityPerimeters/resourceAssociations@2023-08-01-preview' = {
  parent: perimeter
  name: 'perimeter-association2'
  location: location
  properties: {
    accessMode: 'Enforced'
    profile: {
      id: profile.id
    }
    privateLinkResource: {
      id: sa2.id
    }
  }
}

resource loganalytics 'Microsoft.OperationalInsights/workspaces@2023-09-01' = {
  name: 'log-insiders051224'
  location: 'eastus'
  properties: {
    sku: {
      name: 'PerGB2018'      
    }    
  }
}

resource diagnostic 'Microsoft.Insights/diagnosticSettings@2021-05-01-preview' = {
  scope: perimeter
  name: 'nspdiag'
  properties: {
    workspaceId: loganalytics.id  
    logs: [
      {
        enabled: true
        categoryGroup: 'allLogs'
      }
    ]    
  }
}

