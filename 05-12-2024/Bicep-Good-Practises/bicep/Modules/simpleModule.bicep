@description('Environment for this resource')
@allowed(['prod','test','dev'])
param environment string

@description('Array of objects to use for this sample, e.g. [{name: \'MyTestParam\', settings: {open: \'yes\', public: true}},{name: \'MySampleParam\', settings: {open: \'no\', public: true}}]. Defaults to empty array.')
param advancedInputs array = []

@description('The location for this resource. Defaults to resource group location.')
param location string = resourceGroup().location
var namePrefix = 'fix'
var nameSuffix = take(uniqueString(resourceGroup().id,environment,location),5)
var resourceName = '${namePrefix}-${environment}-${location}-${nameSuffix}'

output myResourceName string = resourceName
output myAdvancedOutput array = [for input in advancedInputs: {
  name: input.name
  open: input.settings.open
}]
