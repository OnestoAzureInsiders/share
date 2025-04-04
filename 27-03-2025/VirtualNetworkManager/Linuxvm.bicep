param vnetname string
param location string = resourceGroup().location
param vnetaddressprefix string
param vmname string
param type string = 'Spoke'
param tags object = {}
@secure()
param pwd string

resource nsg 'Microsoft.Network/networkSecurityGroups@2024-05-01' = {
  name: 'nsg-${vnetname}-default'
  location: location
  properties: {
    securityRules: [
      {
        name: 'Allow-Inbound-ICMP'
        properties: {
          protocol: 'ICMP'
          sourcePortRange: '*'
          destinationPortRange: '*'
          sourceAddressPrefix: '*'
          destinationAddressPrefix: '*'
          access: 'Allow'
          direction: 'Inbound'
          priority: 200
          description: 'Allow ICMP'
        }
      }
    ]
  }
}

resource virtualNetworks 'Microsoft.Network/virtualNetworks@2024-05-01' = {
  name: vnetname
  location: location
  tags: tags
  properties: {
    addressSpace: {
      addressPrefixes: [
        vnetaddressprefix
      ]
    }
    subnets: [
      {
        name: 'default'
        properties: {
          addressPrefix: vnetaddressprefix
          networkSecurityGroup: {
            id: nsg.id
          }
        }
      }
    ]
  }
  dependsOn: []
}

resource networkInterfaces 'Microsoft.Network/networkInterfaces@2021-05-01' = {
  name: '${vmname}-nic1'
  location: location
  properties: {
    enableIPForwarding: (type == 'Hub') ? true : null
    ipConfigurations: [
      {
        name: 'ipconfig1'
        properties: {
          subnet: {
            id: '${virtualNetworks.id}/subnets/default'
            }
          
          privateIPAllocationMethod: 'Dynamic'
        }
      }
    ]
  }
  dependsOn: []
}

resource virtualMachines 'Microsoft.Compute/virtualMachines@2021-07-01' = {
  name: vmname
  location: location
  properties: {
    hardwareProfile: {
      vmSize: 'Standard_B2ms'
    }
    osProfile: {
      computerName: vmname
      adminUsername: 'azureuser'
      adminPassword: 'Insider1234!' // Replace with a secure password or use a parameter
    }
    storageProfile: {
      imageReference: {
        publisher: 'Canonical'
        offer: 'UbuntuServer'
        sku: '18.04-LTS'
        version: 'latest'
      }
      osDisk: {
        createOption: 'FromImage'
        name: '${vmname}-osdisk'
      }
    }
    diagnosticsProfile: {
      bootDiagnostics: {
        enabled: true
      }
    }
    networkProfile: {
      networkInterfaces: [
        {
          id: networkInterfaces.id
        }
      ]
    }
  }
  dependsOn: []
}

resource customScriptExtensionSpoke 'Microsoft.Compute/virtualMachines/extensions@2024-11-01' = if (type == 'Spoke') {
  name: '${vmname}/CustomScriptExtension'
  location: location
  properties: {
    publisher: 'Microsoft.Azure.Extensions'
    type: 'CustomScript'
    typeHandlerVersion: '2.1'
    autoUpgradeMinorVersion: true
    settings: {
      fileUris: [] // Add URLs to your script files if needed
      commandToExecute: 'apt-get -y update && apt-get install -y apache2'
    }
  }
  dependsOn: [
    virtualMachines
  ]
}

resource customScriptExtensionHub 'Microsoft.Compute/virtualMachines/extensions@2024-11-01' = if (type == 'Hub') {
  name: '${vmname}/CustomScriptExtension'
  location: location
  properties: {
    publisher: 'Microsoft.Azure.Extensions'
    type: 'CustomScript'
    typeHandlerVersion: '2.1'
    autoUpgradeMinorVersion: true
    settings: {
      fileUris: [] // Add URLs to your script files if needed
      commandToExecute: '''sudo sysctl -w net.ipv4.ip_forward=1 && sudo bash -c 'echo 'net.ipv4.ip_forward=1' >> /etc/sysctl.conf' && sudo sysctl -p'''
    }
  }
  dependsOn: [
    virtualMachines
  ]
}
