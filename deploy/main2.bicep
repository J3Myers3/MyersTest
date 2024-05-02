param sites_cmsqt3api_namePOCBicep string = 'cmsqt3apiPOCBicep'
param serverfarms_CMSQT3APIPlan_namePOCBicep string = 'CMSQT3APIPlan'
param location string = resourceGroup().location

resource serverfarms_CMSQT3APIPlan_namePOCBicep_resource 'Microsoft.Web/serverfarms@2023-01-01' = {
  name: serverfarms_CMSQT3APIPlan_namePOCBicep
  location: location
  sku: {
    name: 'S1'
    tier: 'Standard'
    size: 'S1'
    family: 'S'
    capacity: 1
  }
  kind: 'app'
  properties: {
    perSiteScaling: false
    elasticScaleEnabled: false
    maximumElasticWorkerCount: 1
    isSpot: false
    reserved: false
    isXenon: false
    hyperV: false
    targetWorkerCount: 0
    targetWorkerSizeId: 0
    zoneRedundant: false
  }
}

resource sites_cmsqt3api_namePOCBicep_resource 'Microsoft.Web/sites@2023-01-01' = {
  name: sites_cmsqt3api_namePOCBicep
  location: location
  kind: 'api'
  identity: {
    type: 'SystemAssigned'
  }
  properties: {
    enabled: true
    hostNameSslStates: [
      {
        name: '${sites_cmsqt3api_namePOCBicep}.azurewebsites.us'
        sslState: 'Disabled'
        hostType: 'Standard'
      }
      {
        name: '${sites_cmsqt3api_namePOCBicep}.scm.azurewebsites.us'
        sslState: 'Disabled'
        hostType: 'Repository'
      }
    ]
    serverFarmId: serverfarms_CMSQT3APIPlan_namePOCBicep_resource.id
    reserved: false
    isXenon: false
    hyperV: false
    vnetRouteAllEnabled: false
    vnetImagePullEnabled: false
    vnetContentShareEnabled: false
    siteConfig: {
      numberOfWorkers: 1
      acrUseManagedIdentityCreds: false
      alwaysOn: true
      http20Enabled: false
      functionAppScaleLimit: 0
      minimumElasticInstanceCount: 0
    }
    scmSiteAlsoStopped: false
    clientAffinityEnabled: true
    clientCertEnabled: false
    clientCertMode: 'Required'
    hostNamesDisabled: false
    customDomainVerificationId: '2215CC5E224B0DB6A585CC54A5508115FE03A3ED7DBEF747EA4DB887A892B174'
    containerSize: 0
    dailyMemoryTimeQuota: 0
    httpsOnly: true
    redundancyMode: 'None'
    publicNetworkAccess: 'Enabled'
    storageAccountRequired: false
    keyVaultReferenceIdentity: 'SystemAssigned'
  }
}

resource sites_cmsqt3api_namePOCBicep_ftp 'Microsoft.Web/sites/basicPublishingCredentialsPolicies@2023-01-01' = {
  parent: sites_cmsqt3api_namePOCBicep_resource
  name: 'ftp'
 // location: location
  properties: {
    allow: true
  }
}

resource sites_cmsqt3api_namePOCBicep_scm 'Microsoft.Web/sites/basicPublishingCredentialsPolicies@2023-01-01' = {
  parent: sites_cmsqt3api_namePOCBicep_resource
  name: 'scm'
 // location: location
  properties: {
    allow: true
  }
}

resource sites_cmsqt3api_namePOCBicep_web 'Microsoft.Web/sites/config@2023-01-01' = {
  parent: sites_cmsqt3api_namePOCBicep_resource
  name: 'web'
//  location: location
  properties: {
    numberOfWorkers: 1
    defaultDocuments: [
      'Default.htm'
      'Default.html'
      'Default.asp'
      'index.htm'
      'index.html'
      'iisstart.htm'
      'default.aspx'
      'index.php'
      'hostingstart.html'
    ]
    netFrameworkVersion: 'v6.0'
    requestTracingEnabled: false
    remoteDebuggingEnabled: false
    remoteDebuggingVersion: 'VS2019'
    httpLoggingEnabled: false
    acrUseManagedIdentityCreds: false
    logsDirectorySizeLimit: 35
    detailedErrorLoggingEnabled: false
    publishingUsername: '$cmsqt3api'
    scmType: 'None'
    use32BitWorkerProcess: true
    webSocketsEnabled: false
    alwaysOn: true
    managedPipelineMode: 'Integrated'
    virtualApplications: [
      {
        virtualPath: '/'
        physicalPath: 'site\\wwwroot'
        preloadEnabled: true
      }
    ]
    loadBalancing: 'LeastRequests'
    experiments: {
      rampUpRules: []
    }
    autoHealEnabled: false
    vnetRouteAllEnabled: false
    vnetPrivatePortsCount: 0
    publicNetworkAccess: 'Enabled'
    localMySqlEnabled: false
    managedServiceIdentityId: 641
    ipSecurityRestrictions: [
      {
        ipAddress: '20.158.52.0/24'
        action: 'Allow'
        tag: 'Default'
        priority: 100
        name: 'ui'
        description: 'qt3ui'
      }
      {
        ipAddress: '23.97.0.0/16'
        action: 'Allow'
        tag: 'Default'
        priority: 200
        name: 'ui'
        description: 'qt3ui'
      }
      {
        ipAddress:'20.141.0.0/16'
        action: 'Allow'
        tag: 'Default'
        priority: 300
        name: 'ui'
        description: 'uiqt3'
      }
      {
        ipAddress: '20.140.90.161/32'
        action: 'Allow'
        tag: 'Default'
        priority: 400
        name: 'ui'
        description: 'qt3ui'
      }
      {
        ipAddress: '104.152.72.0/24'
        action: 'Allow'
        tag: 'Default'
        priority: 500
        name: 'LMI'
        description: 'LMI'
      }
      {
        ipAddress: 'Any'
        action: 'Deny'
        priority: 2147483647
        name: 'Deny all'
        description: 'Deny all access'
      }
    ]
    ipSecurityRestrictionsDefaultAction: 'Deny'
    scmIpSecurityRestrictions: [
      {
        ipAddress: 'Any'
        action: 'Allow'
        priority: 2147483647
        name: 'Allow all'
        description: 'Allow all access'
      }
    ]
    scmIpSecurityRestrictionsDefaultAction: 'Allow'
    scmIpSecurityRestrictionsUseMain: false
    http20Enabled: false
    minTlsVersion: '1.2'
    scmMinTlsVersion: '1.2'
    ftpsState: 'FtpsOnly'
    preWarmedInstanceCount: 0
    elasticWebAppScaleLimit: 0
    functionsRuntimeScaleMonitoringEnabled: false
    minimumElasticInstanceCount: 0
    azureStorageAccounts: {}
  }
}

resource sites_cmsqt3api_namePOCBicep_sites_cmsqt3api_namePOCBicep_azurewebsites_us 'Microsoft.Web/sites/hostNameBindings@2023-01-01' = {
  parent: sites_cmsqt3api_namePOCBicep_resource
  name: '${sites_cmsqt3api_namePOCBicep}.azurewebsites.us'
  //location: location
  properties: {
    siteName: 'cmsqt3apiPOCBicep'
    hostNameType: 'Verified'
  }
}

resource sites_cmsqt3api_namePOCBicep_Microsoft_AspNetCore_AzureAppServices_SiteExtension 'Microsoft.Web/sites/siteextensions@2023-01-01' = {
  parent: sites_cmsqt3api_namePOCBicep_resource
  name: 'Microsoft.AspNetCore.AzureAppServices.SiteExtension'
 // location: location
}
