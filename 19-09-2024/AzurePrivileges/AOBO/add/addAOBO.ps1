$tenantId = '<tenantId>'

$subscriptionId = '<subscriptionId>'

$foreignObjectId = '<partnerObjectId>'

Connect-AzAccount -TenantId $tenantId

New-AzRoleAssignment -PrincipalId $foreignObjectId -RoleDefinitionName 'Owner' -Scope "/subscriptions/$subscriptionId"