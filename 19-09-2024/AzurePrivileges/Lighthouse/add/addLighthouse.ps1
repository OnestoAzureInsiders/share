$tenantId = '<tenantId>'

$subscriptionId = '<subscriptionId>'

$deploymentName = 'AzureInsiders'

Connect-AzAccount -TenantId $tenantId

Select-AzSubscription -SubscriptionId $subscriptionId

New-AzSubscriptionDeployment -Name $deploymentName -Location westeurope -TemplateFile 'offer.bicep'