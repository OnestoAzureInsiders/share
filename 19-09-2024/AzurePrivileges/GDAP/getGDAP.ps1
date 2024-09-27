$tenantId = '<tenantId>'

Connect-AzAccount -TenantId $tenantId

$resource = 'https://admin.microsoft.com'

$token = Get-AzAccessToken -ResourceUrl $resource

$headers = @{'Authorization' = "Bearer $($token.Token)"}

$uri = 'https://admin.microsoft.com/fd/commerceMgmt/partnermanage/gdapRelationships?api-version=3.0'

$partners = Invoke-RestMethod -Uri $uri -Headers $headers -Method Get -ContentType 'application/json'

$partners.relationships | Where-Object { $_.status -eq 'active' }