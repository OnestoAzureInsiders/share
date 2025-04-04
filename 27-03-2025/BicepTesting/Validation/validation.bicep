targetScope = 'subscription'

param location string = 'swedencentral'
var rgName = concat('rg-test-',location) // 'rg-test-${location}'

module rg '../modules/rg.bicep' = {  
  name: 'rg-deploy'
  params: {
    name: rgName
    location: location
  }
}

module st '../modules/st.bicep' = {
  scope: resourceGroup(rgName)
  name: 'st-deploy'
  params: {
    name: 'st-test'
    location: location
  }
  dependsOn: [
    rg
  ]
}
