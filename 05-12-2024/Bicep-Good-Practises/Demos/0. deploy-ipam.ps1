$tenantId = "...."
$subscriptionId = "..."
$location = "westeurope"
$azContext = get-azcontext
if ($null -eq $azContext.Subscription.Id -or $subscriptionId -ne $azContext.Subscription.Id){
    connect-azaccount -subscriptionId $subscriptionId -tenantId $tenantId
}

$workDir = ".\..\ipam"
$demoDir = ".\..\Demos"
Push-Location $workDir

New-AzSubscriptionDeployment -Name "AzInsiders-Ipam" -Location $location -TemplateFile "main_ipam.bicep" -verbose

Push-Location $demoDir