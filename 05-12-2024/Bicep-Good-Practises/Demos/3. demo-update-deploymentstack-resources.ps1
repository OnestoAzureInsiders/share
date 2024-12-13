$tenantId = "..."
$subscriptionId = "..."
$location = "westeurope"
$azContext = get-azcontext
if ($null -eq $azContext.Subscription.Id -or $subscriptionId -ne $azContext.Subscription.Id){
    connect-azaccount -subscriptionId $subscriptionId -tenantId $tenantId
}

$workDir = ".\..\deploymentStacks"
$demoDir = ".\..\Demos"
Push-Location $workDir

# Update Prod Virtual Network with IMAP range in restricted deployment stack,
## This will unlink and delete all network security groups
$params = @{
    "environment" = "prod"
    "sysid" = "Insiders"
}
Set-AzSubscriptionDeploymentStack -Name "AzInsiders-Prod-Vnet" `
-Location "westeurope" `
-TemplateFile "main_vNet.bicep" `
-ActionOnUnmanage "deleteAll" `
-DenySettingsMode "denyWriteAndDelete" `
-DenySettingsApplyToChildScopes `
-TemplateParameterObject $params `
-Description "Azure Insiders Prod network"

Push-Location $demoDir

write-host "### Finished Updating vNets ###`r`n" -ForegroundColor Blue
write-host "Prod network in a restricteddeployment stack: `r`n" -ForegroundColor Blue
write-host " - NSG's where deleted" -ForegroundColor Blue
