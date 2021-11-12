Pod::Spec.new do |s|
  s.name = 'DTCore'
  s.version = '1.3.2.44'
  s.license = 'MIT'
  s.summary = 'The set of extensions, frames, sources and other things that could be useful in iOS app development.'
  s.homepage = 'https://github.com/DreamTeamMobile/dt-ios-core'
  s.authors = { 'DreamTeam Mobile' => 'dta@dreamteam-mobile.com' }
  s.source = { :git => 'https://github.com/DreamTeamMobile/dt-ios-core.git', :tag => s.version }
  s.documentation_url = 'https://github.com/DreamTeamMobile/dt-ios-core/blob/master/README.md'

  s.ios.deployment_target = '11.0'

  s.swift_versions = ['5.0', '5.1']

  s.source_files = 'DTCore/Sources/**/*.swift'

end

