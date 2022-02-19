@description('Default location for resources')
param location string = resourceGroup().location
@description('Unique app ID suffix for resources')
param appId string = uniqueString(resourceGroup().id)
@description('The app plan SKU configuration to use')
@allowed([
  'free'
  'basic'
])
param skuConfiguration string = 'free'

var skus = {
  free: {
    tier: 'Free'
    name: 'F1'
  }
  basic: {
    tier: 'Basic'
    name: 'B1'
  }
}

resource appPlan 'Microsoft.Web/serverfarms@2021-03-01' = {
  name: 'blogServer-${appId}'
  location: location
  sku: skus[skuConfiguration]
  kind: 'linux'
  properties: {
    reserved: true
  }
}

resource blogSite 'Microsoft.Web/sites@2021-03-01' = {
  name: 'wordpress-${appId}'
  location: location
  properties: {
    serverFarmId: appPlan.id
    siteConfig: {
      linuxFxVersion: 'DOCKER|nginx:latest'
    }
  }
}
