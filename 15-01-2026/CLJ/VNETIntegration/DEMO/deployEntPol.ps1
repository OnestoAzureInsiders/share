## Deploy
New-AzSubscriptionDeployment -Name "Deploy-EntPol" `
    -Location "West Europe" `
    -TemplateFile ".\CLJ\vNetIntegration\DEMO\mainEntPol.bicep"