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

$params = @{
    "environment" = "prod"
    "sysid" = "Insiders"
}
# Update "Insiders-Prod-Vnet" deployment stack, using the Set-AzSubscriptionDeploymentStack cmdlet
# This will set the DenySettingsMode to "denyDelete" and the ActionOnUnmanage to "DetachAll"
$params = @{
    "environment" = "prod"
    "sysid" = "Insiders"
}
Set-AzSubscriptionDeploymentStack -Name "AzInsiders-Prod-Vnet" `
-Location "westeurope" `
-TemplateFile "main_vNet.bicep" `
-ActionOnUnmanage "DetachAll" `
-DenySettingsMode "denyDelete" `
-DenySettingsApplyToChildScopes `
-TemplateParameterObject $params `
-Description "Azure Insiders Prod network"

write-host "#########################################################################`r`n" -ForegroundColor Blue
write-host "DenySettingsMode is now set to denyDelete, meaning you can change, `r`nbut not delete resources `r`n" -ForegroundColor Blue
write-host "ActionOnUnmanage is now set to DetachAll, meaning all resources will be `r`nunlinked from the deployment stack if you remove them from the bicep file`r`n" -ForegroundColor Blue
write-host "#########################################################################"

Push-Location $demoDir
