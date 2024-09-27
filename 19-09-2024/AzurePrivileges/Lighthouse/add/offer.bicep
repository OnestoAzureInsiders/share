targetScope = 'subscription'

param definitionName string = 'AzureInsiders'
param assignmentName string = 'AzureInsidersAssignment'

var definitionNameGUID = guid(definitionName)
var assignmentNameGUID = guid(assignmentName)


//Resources
resource lighthouseDefinition 'Microsoft.ManagedServices/registrationDefinitions@2022-10-01' = {
  name: definitionNameGUID
  properties: {
    registrationDefinitionName: definitionName
    description: 'Azure Insiders'
    authorizations: [      
      {
        principalId: '<principalId>'
        roleDefinitionId: 'acdd72a7-3385-48ef-bd42-f606fba81ae7'
      }
    ]
    managedByTenantId: '<partnerTenantId>'
  }
}

resource lighthouseAssignment 'Microsoft.ManagedServices/registrationAssignments@2022-10-01' = {
  name: assignmentNameGUID
  properties: {
    registrationDefinitionId: resourceId('Microsoft.ManagedServices/registrationDefinitions', definitionNameGUID)
  }
  dependsOn: [
    lighthouseDefinition
  ]
}


