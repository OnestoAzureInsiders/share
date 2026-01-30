param networkWatcherName string
param location string = resourceGroup().location
param tags object = {}

resource networkWatcher 'Microsoft.Network/networkWatchers@2024-03-01' = {
  name: networkWatcherName
  location: location
  tags: tags
}
