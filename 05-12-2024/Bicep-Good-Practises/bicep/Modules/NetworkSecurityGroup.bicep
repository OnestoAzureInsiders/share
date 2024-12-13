param nsgName string
@description('The default ruleset of this template will deny all inbound traffic by default, with priority 4000. Add any supplementary rules with this property')
param nsgRuleSet {
  name: string
  properties: {
    @description('The priority of the rule. The value can be between 100 and 4096. The priority number must be unique for each rule in the collection. The lower the priority number, the higher the priority of the rule.')
    priority: int
    access: 'Allow' | 'Deny'
    direction: 'Inbound' | 'Outbound'
    @description('Network protocol this rule applies to.')
    protocol: '*' | 'Ah' | 'Esp' | 'Icmp' | 'Tcp' | 'Udp'
    @description('The CIDR or source IP range. Asterisk \'*\' can also be used to match all source IPs. Default tags such as \'VirtualNetwork\', \'AzureLoadBalancer\' and \'Internet\' can also be used. If this is an ingress rule, specifies where network traffic originates from.')
    sourceAddressPrefix: string
    @description('The source port or range. Integer or range between 0 and 65535. Asterisk \'*\' can also be used to match all ports.')
    sourcePortRange: string
    @description('The destination port or range. Integer or range between 0 and 65535. Asterisk \'*\' can also be used to match all ports.')
    destinationPortRange: string
    @description('The destination address prefix. CIDR or destination IP range. Asterisk \'*\' can also be used to match all source IPs. Default tags such as \'VirtualNetwork\', \'AzureLoadBalancer\' and \'Internet\' can also be used.')
    destinationAddressPrefix: string
    @description('A description for this rule. Restricted to 140 chars.')
    description: string
  }
}[] = []
param tags object
param location string = resourceGroup().location
@description('The IP subnet range of Azure Firewall (e.g. \'100.100.0.0/26\'), to allow inbound access from the Azure Firewall subnet. Must be set if enableDefaultRuleSet is True. Can be empty (\'\') if not needed')
param firewallSubnet string
@description('If set to true, a default ruleset will be created, disabling all inbound access (priority 4000) and allowing access from the Azure Firewall subnet only (priority 3000, Firewall must sNat traffic for this to work). This can be combined with additional rules specified by parameter nsgRuleSet')
param useDefaultRuleSet bool


var defaultRuleSet = [
  {
    name: 'AllowAzureFirewallSnat'
    properties: {
      description: 'Allow access from Azure Firewall sNat address'
      protocol: '*'
      sourcePortRange: '*'
      destinationPortRange: '*'
      sourceAddressPrefix: firewallSubnet
      destinationAddressPrefix: '*'
      access: 'Allow'
      priority: 3000
      direction: 'Inbound'
    }
  }
  {
    name: 'DenyAllInboundTraffic'
    properties: {
      description: 'Overrides default rules, to disable all inbound traffic'
      protocol: '*'
      sourcePortRange: '*'
      destinationPortRange: '*'
      sourceAddressPrefix: '*'
      destinationAddressPrefix: '*'
      access: 'Deny'
      priority: 4000
      direction: 'Inbound'
    }
  }
]

resource nsg 'Microsoft.Network/networkSecurityGroups@2021-03-01' = {
  name: nsgName
  location: location
  properties: {
    securityRules: useDefaultRuleSet ? union(defaultRuleSet,nsgRuleSet) : nsgRuleSet
  }
  tags: tags
}

output nsgResourceId string = nsg.id
output nsgName string = nsg.name
