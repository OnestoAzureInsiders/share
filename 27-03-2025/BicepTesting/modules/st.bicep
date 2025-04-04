param name string
param location string

resource st 'Microsoft.Storage/storageAccounts@2024-01-01' = {
  name: name
  location: location
  kind: 'StorageV2'
  sku: {
    name: 'Standard_LRS'
  }
} 
