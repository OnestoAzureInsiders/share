//////////// Unødvendige depend-on
resource log 'Microsoft.OperationalInsights/workspaces@2023-09-01' = {
  name: 'log-test'
  location: 'swedencentral'
}

resource st 'Microsoft.Storage/storageAccounts@2024-01-01' = {
  name: 'stone'
  location: 'swedencentral'
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
}

resource diag 'Microsoft.Insights/diagnosticSettings@2021-05-01-preview' = {
  scope: st
  name: 'diag'
  properties: {
    workspaceId: log.id
  }
  dependsOn: [log]
}
