
//////////////////////////////////////////////////////////
// Demo of "simple" module with simple output and plain params
//////////////////////////////////////////////////////////
module myTest 'Modules/simpleModule.bicep' = {
  name: 'myTest'
  params: {
    environment: 'dev'
    advancedInputs: [
      {
        name: 'flewer'
        settings: {
          open: 'yes'
        }
      }
      {
        name: 'Insiders'
        settings: {
          open: 'no'
          public: true
        }
      }
    ]
  }
}
output resourceName string = myTest.outputs.myResourceName


//////////////////////////////////////////////////////////
// Demo of "smart" module with smart params
// Demonstrate filling blocks in "advancedInputs"
//////////////////////////////////////////////////////////

// module tst 'Modules/smartModule.bicep' = {
//   name: 'testSmart'
//   params: {
//     environment: 'test'
//     sysid: 'AZure'
//     advancedInputs: [
//       {
//         name: 'flewer'
//         settings: {
//           open: 'yes'
//           public: true
//         }
//       }
//       {
//         name: 'Insiders'
//         settings: {
//           open: 'no'
//           public: true
//         }
//       }
//     ]
//   }
// }
// output resourceName string = tst.outputs.myResourceName
// output advancedOutput array = tst.outputs.myAdvancedOutput

//////////////////////////////////////////////////////////
// Demo of NSG module with smart params
// Demonstrate constructing NSG rulesets
//////////////////////////////////////////////////////////

// module nsg 'Modules/NetworkSecurityGroup.bicep' = {
//   name: 'nsg'
//   params: {
//     tags: {}
//     firewallSubnet: '100.100.0.0/26'
//     nsgName: 'myNsg'
//     useDefaultRuleSet: true
//     nsgRuleSet: [
//       {
//         name: 'Outlittletest'
//         properties: {
//           access: 'Allow'
//           description: 'test'
//           destinationAddressPrefix: '*'
//           destinationPortRange: '*'
//           direction: 'Inbound'
//           priority: 1010
//           protocol: '*'
//           sourceAddressPrefix: '*'
//           sourcePortRange: '*'
//         }
//       }
//       {
//         name: 'myTestRule'
//         properties: {
//           access: 'Allow'
//           description: 'test'
//           destinationAddressPrefix: '*'
//           destinationPortRange: '*'
//           direction: 'Inbound'
//           priority: 1000
//           protocol: '*'
//           sourceAddressPrefix: '*'
//           sourcePortRange: '*'
//         }
//       }
//     ]
//   }
// }
// output nsgResourceId string = nsg.outputs.nsgResourceId

//////////////////////////////////////////////////////////
// Demo of network module, using outputs frm NSG module
// Demonstrate use of "CTRL-SPACE" to fill out subnet params
//////////////////////////////////////////////////////////

// var vNetAddressRange = '100.100.90.0/24'
// module vNet 'Modules/virtualNetwork.bicep' = {
//   name: 'MyTstVnet'
//   params: {
//     subnets: [
//       {
//         addressPrefix: cidrSubnet(vNetAddressRange,27,0)
//         nsgName: nsg.outputs.nsgName
//         routeTableName: ''
//         subnetDelegation: []
//         subnetName: 'snet1'
//       }
//       {
//         addressPrefix: cidrSubnet(vNetAddressRange,26,1)
//         nsgName: ''
//         routeTableName: ''
//         subnetDelegation: []
//         subnetName: 'snet2'
//       }
//     ]
//     vNetAddressRange: vNetAddressRange
//     vNetName: 'MyTstVnet'
//   }
// }

