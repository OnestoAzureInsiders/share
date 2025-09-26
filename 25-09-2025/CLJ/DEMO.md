##############################################################################################################################################################################################################################################################################
# Storage Accounts

### Identify

resources
| where type == 'microsoft.storage/storageaccounts'
| extend tls_version = properties.minimumTlsVersion
| where tls_version != 'TLS1_2'
| project name, tls_version, resourceGroup, subscriptionId

### Policy
Custom community policy
https://www.azadvertizer.net/azpolicyadvertizer/Deploy-Storage-sslEnforcement.html

# App Service

### Identify 
PowerShell fordi config settings ikke exposes... ([get-sttls.ps1](get-sttls.ps1))

### Policy
Built-in policy
https://www.azadvertizer.net/azpolicyadvertizer/ae44c1d1-0df2-4ca9-98fa-a3d3ae5b409d.html

# Basic Public IP

### Identify

resources
| where type == 'microsoft.network/publicipaddresses'
| extend sku = sku.name
| where sku == 'Basic'
| extend associatedTo = split(tostring(properties.ipConfiguration.id),'/')[8]
| project name, sku, associatedTo, resourceGroup, subscriptionId

# Standard HDD disks

### Identify

resources
| where type == "microsoft.compute/virtualmachines"
| extend osDiskType = properties.storageProfile.osDisk.managedDisk.storageAccountType
| where osDiskType == 'Standard_LRS'
| project name, osDiskType, resourceGroup, subscriptionId

### Policy 
Custom policy ([deny_vm_standard_hdd.json](deny_vm_standard_hdd.json))

##############################################################################################################################################################################################################################################################################