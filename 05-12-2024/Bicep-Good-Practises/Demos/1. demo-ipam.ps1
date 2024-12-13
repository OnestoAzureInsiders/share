$tenantId = "..."
$subscriptionId = "..."
$ipamRg = "rg-azinsiders-ipam-p-we-001"
$location = "westeurope"
$azContext = get-azcontext
if ($null -eq $azContext.Subscription.Id -or $subscriptionId -ne $azContext.Subscription.Id){
    connect-azaccount -subscriptionId $subscriptionId -tenantId $tenantId
}

$workDir = ".\..\ipam"
$demoDir = ".\..\Demos"
Push-Location $workDir

$commonParams = @{
    avnmInstanceName = "vnm-azinsiders-ipam-p-we-001"
    ipPoolName = "prod"
    allocationDescription = "Azure Insiders demo"
}

# Test 24-bit static CIDR reservation
$Output1 = New-AzResourceGroupDeployment -Name "Az24-bitPool1" -ResourceGroupName $ipamRg -verbose `
    -TemplateFile '../../../../Azure/Bicep/IPAM/vNetManagerStaticCidrAllocation.bicep' `
    -TemplateParameterObject $commonParams `
    -allocationName "24-bitPool1" `
    -networkMask 24


# Test 25-bit static CIDR reservation
$Output2 = New-AzResourceGroupDeployment -Name "Az25-bitPool1" -ResourceGroupName $ipamRg -verbose `
-TemplateFile '../../../../Azure/Bicep/IPAM/vNetManagerStaticCidrAllocation.bicep' `
-TemplateParameterObject $commonParams `
-allocationName "25-bitPool1" `
-networkMask 25

# Test 24-bit static CIDR reservation 2
$Output3 = New-AzResourceGroupDeployment -Name "Az24-bitPool2" -ResourceGroupName $ipamRg -verbose `
    -TemplateFile '../../../../Azure/Bicep/IPAM/vNetManagerStaticCidrAllocation.bicep' `
    -TemplateParameterObject $commonParams `
    -allocationName "24-bitPool2" `
    -networkMask 24

# Test 25-bit static CIDR reservation
$Output4 = New-AzResourceGroupDeployment -Name "Az25-bitPool2" -ResourceGroupName $ipamRg -verbose `
    -TemplateFile '../../../../Azure/Bicep/IPAM/vNetManagerStaticCidrAllocation.bicep' `
    -TemplateParameterObject $commonParams `
    -allocationName "25-bitPool2" `
    -networkMask 25 `


write-host "### IP RANGES RETURNED ###"
Write-host "24-bitPool1: $($Output1.Outputs.addressPrefixes.value)"
Write-host "25-bitPool1: $($Output2.Outputs.addressPrefixes.value)"
Write-host "24-bitPool2: $($Output3.Outputs.addressPrefixes.value)"
Write-host "25-bitPool2: $($Output4.Outputs.addressPrefixes.value)"

Push-Location $demoDir