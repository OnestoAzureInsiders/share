param name string
param location string
param sqlServerName string
param tags object = {}
param sku object = {
  name: 'Basic'
  tier: 'Basic'
  capacity: 5
}
param redundancy string = 'Local'
param maxSizesBytes int = 2147483648 // 2 GB
@allowed([
  'None'
  'AdventureWorksLT'
  'WideWorldImportersFull'
  'WideWorldImportersStd'
])
param sampleName string = 'None'

resource sqlServer 'Microsoft.Sql/servers@2024-11-01-preview' existing = {
  name: sqlServerName
}

resource sqlDb 'Microsoft.Sql/servers/databases@2024-11-01-preview' = {
  parent: sqlServer
  name: name
  location: location
  sku: sku
  properties: {
    collation: 'SQL_Latin1_General_CP1_CI_AS'
    requestedBackupStorageRedundancy: redundancy
    maxSizeBytes: maxSizesBytes
    sampleName: sampleName == 'None' ? null : sampleName
  }
  tags: tags
}
