## Deploy
New-AzSubscriptionDeployment -Name "Deploy-VNET-Integration-PoC" `
    -Location "West Europe" `
    -TemplateFile ".\CLJ\vNetIntegration\DEMO\main.bicep"