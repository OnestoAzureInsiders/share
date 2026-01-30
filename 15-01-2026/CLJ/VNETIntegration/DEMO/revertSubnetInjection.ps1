$environmentId = '-----'
$policyArmId = '/subscriptions/----/resourceGroups/rg-datagwpoc-network-d-neu-001/providers/Microsoft.PowerPlatform/enterprisePolicies/Insiders-Enterprise-Policy'

Set-Location -Path .\CLJ\VNETIntegration\DEMO\EnterprisePolicyPwsh\Source\SubnetInjection
.\revertSubnetInjection.ps1 -environmentId $environmentId -policyArmId $policyArmId

Set-Location -Path ..\..\..\..\..\..\