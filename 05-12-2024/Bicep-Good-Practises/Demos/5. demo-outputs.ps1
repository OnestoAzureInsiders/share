$tenantId = "..."
$subscriptionId = "..."
$resourceGroup = "rg-azinsiders-outputtest-d-we-001"
$location = "westeurope"
$azContext = get-azcontext
if ($null -eq $azContext.Subscription.Id -or $subscriptionId -ne $azContext.Subscription.Id){
    connect-azaccount -subscriptionId $subscriptionId -tenantId $tenantId
}

$workDir = ".\..\bicep"
$demoDir = ".\..\Demos"
Push-Location $workDir

# Test 24-bit static CIDR reservation
if (-not (Get-AzResourceGroup -Name $resourceGroup -ErrorAction SilentlyContinue)){
    New-AzResourceGroup -Name $resourceGroup -Location $location
}
New-AzResourceGroupDeployment -Name "TestOutput" `
    -ResourceGroupName $resourceGroup `
    -TemplateFile 'main.bicep' `
    -verbose

Push-Location $demoDir