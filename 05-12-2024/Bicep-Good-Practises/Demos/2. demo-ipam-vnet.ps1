$tenantId = "..."
$subscriptionId = "..."
$location = "westeurope"
$azContext = get-azcontext
if ($null -eq $azContext.Subscription.Id -or $subscriptionId -ne $azContext.Subscription.Id){
    connect-azaccount -subscriptionId $subscriptionId -tenantId $tenantId
}

$workDir = ".\..\ipam"
$demoDir = ".\..\Demos"
Push-Location $workDir

# Deploy Dev Virtual Network with IPAM range and no restrictions
New-AzSubscriptionDeployment -Name "AzDevVnet" -location $location -verbose `
    -TemplateFile "main_vNet.bicep" `
    -environment "dev" `
    -sysid "Insiders"


# Deploy Prod Virtual Network with IMAP range in restricted deployment stack
$params = @{
    "environment" = "prod"
    "sysid" = "Insiders"
}
New-AzSubscriptionDeploymentStack -Name "AzInsiders-Prod-Vnet" `
-Location "westeurope" `
-TemplateFile "main_vNet.bicep" `
-ActionOnUnmanage "deleteAll" `
-DenySettingsMode "denyWriteAndDelete" `
-DenySettingsApplyToChildScopes `
-TemplateParameterObject $params `
-Description "Azure Insiders Prod network"

Push-Location $demoDir

write-host "### Finished deploying vNets ###`r`n" -ForegroundColor Blue
write-host "Dev network without any restrictions `r`n`r`n" -ForegroundColor Blue
write-host "Prod network in a restricteddeployment stack: `r`n" -ForegroundColor Blue
write-host " - ActionOnUnmanage: deleteAll" -ForegroundColor Blue
write-host " - DenySettingsMode: denyWriteAndDelete" -ForegroundColor Blue
write-host " - DenySettingsApplyToChildScopes: true" -ForegroundColor Blue