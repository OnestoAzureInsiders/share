# Get Access Token
Connect-AzAccount
$token = (Get-AzAccessToken).Token | ConvertFrom-SecureString -AsPlainText

# Create Headers object
$headers = @{
    Authorization = "Bearer $token"
}

# Query Resource Graph for all Web Apps
$query = 'resources
| where type == "microsoft.web/sites"
| project name, resourceGroup, subscriptionId
| order by subscriptionId asc'
$body = @{
    query = $query
} | ConvertTo-Json
$uri = 'https://management.azure.com/providers/Microsoft.ResourceGraph/resources?api-version=2024-04-01'
$results = @()
$response = Invoke-RestMethod -Uri $uri -Headers $headers -Method POST -Body $body -ContentType 'application/json'
$results += $response.data
while ($null -ne $response.'$skipToken') {
    $nextBody = @{
        query   = $query
        options = @{
            '$skipToken' = $response.'$skipToken'
        }
    } | ConvertTo-Json
    $response = Invoke-RestMethod -Uri $uri -Body $nextBody -Headers $headers -Method Post -ContentType 'application/json'
    $results += $response.data
}

# For each Web App, get the minTlsVersion from its config
$combined = @()
foreach ($webApp in $results) {
    $uri = "https://management.azure.com/subscriptions/$($webApp.subscriptionId)/resourceGroups/$($webApp.resourceGroup)/providers/Microsoft.Web/sites/$($webApp.name)/config/web?api-version=2024-11-01"  
    $webAppDetails = Invoke-RestMethod -Uri $uri -Headers $headers -Method GET    
    $webApp | Add-Member -MemberType NoteProperty -Name 'minTlsVersion' -Value $webAppDetails.properties.minTlsVersion
    $combined += $webApp
}

# Output results to GridView
$combined | Out-GridView
