param location string
param tags object = {}
param name string
param member array 
@allowed([
  'F2'
  'F4'
  'F8'
])
param skuName string

resource fabric 'Microsoft.Fabric/capacities@2023-11-01' = {
  
  location: location
  name: name 
  properties: {
    administration: {
      members: member
    }
  }
  sku: {
    name: skuName
    tier: 'Fabric'
  }
  tags: tags
}
