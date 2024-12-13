@description('Environment for this resource')
@allowed(['prod','test','dev'])
param environment string

@minLength(1)
@maxLength(6)
@description('The abbreviated system id to use for this resource')
param sysid string

@description('Array of input objects to use for this sample. Defaults to empty array.')
param advancedInputs {
  @description('Name of this test input')
  name: string
  @description('Settings for this test input')
  settings: {
    @description('Whether or not a fictive firewall is open or not')
    open: 'yes' | 'no'
    @description('Whether or not the fictive resource is public or not. This setting is optional.')
    public: bool?
  }
}[] = []

@description('The location for this resource. Defaults to resource group location.')
@allowed([
  'eastus'
  'westus'
  'northeurope'
  'westeurope'
])
param location string = 'westeurope'
var locations = {
  eastus: 'eus'
  westus: 'wus'
  northeurope: 'neu'
  westeurope: 'weu'
}
var environments = {
  prod: 'p'
  test: 't'
  dev: 'd'
}
var namePrefix = 'tst'
var nameSuffix = take(uniqueString(resourceGroup().id,sysid,environment,location),4)
var resourceName = '${namePrefix}-${toLower(sysid)}-${locations[location]}-${environments[environment]}-${nameSuffix}'

output myResourceName string = resourceName
output myAdvancedOutput array = [for input in advancedInputs: {
  name: input.name
  open: input.settings.open
}]
