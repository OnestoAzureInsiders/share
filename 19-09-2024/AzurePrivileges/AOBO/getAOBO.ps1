$tenantId = '<tenantId>'

$subscriptionId = '<subscriptionId>'

Connect-AzAccount -TenantId $tenantId

$roles = Get-AzRoleAssignment -Scope "/subscriptions/$subscriptionId" 

$roles | Where-Object { $_.ObjectType -eq 'Unknown' }