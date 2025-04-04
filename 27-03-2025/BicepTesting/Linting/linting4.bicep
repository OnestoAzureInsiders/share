//////////// Literal admin

// Fejl
resource vm1 'Microsoft.Compute/virtualMachines@2023-03-01' = {
  name: 'name1'
  location: 'swedencentral'
  properties: {
    osProfile: {
      adminUsername: 'adminUsername'
    }
  }
}

// // Stadig fejl
// var defaultAdmin = 'administrator'
// resource vm 'Microsoft.Compute/virtualMachines@2023-03-01' = {
//   name: 'name'
//   location: 'swedencentral'
//   properties: {
//     osProfile: {
//       adminUsername: defaultAdmin
//     }
//   }
// }

// // Virker
// param adminUsername string
// resource vm2 'Microsoft.Compute/virtualMachines@2023-03-01' = {
//   name: 'name2'
//   location: 'swedencentral'
//   properties: {
//     osProfile: {
//       adminUsername: adminUsername
//     }
//   }
// }
