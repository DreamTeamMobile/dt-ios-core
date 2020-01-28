Pod::Spec.new do |s|
  s.name = 'DTCoreComponents'
  s.version = '1.1.1'
  s.license = 'MIT'
  s.summary = 'The set of extensions, frames, sources and other things that could be useful in iOS app development.'
  s.homepage = 'https://github.com/DreamTeamMobile/dt-ios-core'
  s.authors = { 'DreamTeam Mobile' => 'dta@dreamteam-mobile.com' }
  s.source = { :git => 'https://github.com/DreamTeamMobile/dt-ios-core.git', :tag => s.version }
  s.documentation_url = 'https://github.com/DreamTeamMobile/dt-ios-core/blob/master/README.md'

  s.static_framework = true

  s.ios.deployment_target = '11.0'

  s.swift_versions = ['5.0', '5.1']

  s.source_files = 'Sources/DTCoreComponents/**/*.swift'
  
  s.dependency 'AppCenter'
  s.dependency 'AppsFlyerFramework'
  s.dependency 'FBSDKCoreKit'
  s.dependency 'Firebase/Analytics'
  
  s.dependency 'Firebase/RemoteConfig'
  s.dependency 'KeychainAccess'
  s.dependency 'TPInAppReceipt'

end

