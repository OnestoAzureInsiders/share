param location string
param name string
param tags object = {}
param login string
param objectId string
param clientIp string = ''
@allowed([
  'Enabled'
  'Disabled'
])
param publicNetworkAccess string

var tenantId = tenant().tenantId

resource sqlServer 'Microsoft.Sql/servers@2024-11-01-preview' = {
  name: name
  location: location
  tags: tags
  properties: {
    administrators: {
      administratorType: 'ActiveDirectory'
      login: login
      sid: objectId
      tenantId: tenantId
      principalType: 'User'
      azureADOnlyAuthentication: true      
    }
    publicNetworkAccess: publicNetworkAccess
    minimalTlsVersion: '1.2'
  }
}

resource sqlFirewallRule 'Microsoft.Sql/servers/firewallRules@2024-11-01-preview' = if (clientIp != '') {
  name: 'AllowAllWindowsAzureIps'
  parent: sqlServer
  properties: {
    startIpAddress: '0.0.0.0'
    endIpAddress: '0.0.0.0'
  }  
}

resource sqlClientIpFirewallRule 'Microsoft.Sql/servers/firewallRules@2024-11-01-preview' = if (clientIp != '') {
  name: 'AllowClientIp'
  parent: sqlServer
  properties: {
    startIpAddress: clientIp
    endIpAddress: clientIp
  }  
}

output sqlServerName string = sqlServer.name
output id string = sqlServer.id
