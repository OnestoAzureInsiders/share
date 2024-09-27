$tenantId = '<tenantId>'

$subscriptionId = '<subscriptionId>'

Connect-AzAccount -TenantId $tenantId

$token = Get-AzAccessToken

$headers = @{'Authorization' = "Bearer $($token.Token)"}

$uri = {https://management.azure.com/subscriptions/{0}/providers/Microsoft.ManagedServices/registrationAssignments?api-version=2022-10-01} -f $subscriptionId

$lightHouseAssignments = Invoke-RestMethod -Uri $uri -Headers $headers -Method Get

$lightHouseDefinitions = @()

foreach ($assignment in $lightHouseAssignments.value) {
    $defId = $assignment.properties.registrationDefinitionId.Split("/")[6]
    $uri = {https://management.azure.com/subscriptions/{0}/providers/Microsoft.ManagedServices/registrationDefinitions/{1}?api-version=2022-10-01} -f $subscriptionId, $defId
    $lightHouseDefinition = Invoke-RestMethod -Uri $uri -Headers $headers -Method Get
    $lightHouseDefinitions += $lightHouseDefinition
}

$lightHouseDefinitions.properties | Select-Object registrationDefinitionName, description, managedByTenantName, authorizations | Format-Table -AutoSize