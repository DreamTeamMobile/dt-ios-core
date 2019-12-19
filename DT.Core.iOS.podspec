Pod::Spec.new do |s|
  s.name = 'DT.Core.iOS'
  s.version = '1.0.0'
  s.license = ''
  s.summary = ''
  s.homepage = 'https://github.com/DreamTeamMobile/dt-ios-core'
  s.authors = { 'DreamTeam Mobile' => 'dta@dreamteam-mobile.com' }
  s.source = { :git => 'https://github.com/DreamTeamMobile/dt-ios-core.git', :tag => s.version }
  s.documentation_url = 'https://github.com/DreamTeamMobile/dt-ios-core/README.md'

  s.ios.deployment_target = '12.0'

  s.swift_versions = ['5.0', '5.1']

  s.source_files = 'Source/*.swift'

end

