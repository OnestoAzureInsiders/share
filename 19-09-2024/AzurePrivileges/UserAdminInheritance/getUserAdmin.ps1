$tenantId = '<tenantId>'

Connect-AzAccount -TenantId $tenantId

## Using Az Role Assignments
$roleAssignments = Get-AzRoleAssignment -Scope '/' | Where-Object { $_.RoleDefinitionName -eq 'User Access Administrator' }

$roleAssignments | Select-Object DisplayName, SignInName, ObjectId | Format-Table -AutoSize

## Resource Graph Query

$query = @"
authorizationresources 
| where type == `"microsoft.authorization/roleassignments`"
| extend role = tostring(properties.roleDefinitionId),
    scope = tostring(properties.scope),
    objectId = tostring(properties.principalId)
| where scope == `"/`"
| where role == `"/providers/Microsoft.Authorization/RoleDefinitions/18d7d88d-d35e-4fb5-a5c3-7773c20a72d9`" // User Access Administrator
| project objectId
"@

$userAccessAdmins = Search-AzGraph -Query $query -UseTenantScope

$userAccessAdmins