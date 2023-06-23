Pod::Spec.new do |s|
  s.name         = 'DTCore'
  s.version      = '1.4.1'
  s.summary      = 'Shared code between applications'
  s.homepage     = 'https://github.com/DreamTeamMobile/dt-ios-core'
  s.license      = { :type => 'MIT', :text => 'Copyright 2022 Dream Team Apps' }
  s.platform     = :ios, '14.0'
  s.authors      = 'Dream Team Apps'
  s.source       = { :git => 'https://github.com/DreamTeamMobile/dt-ios-core.git', :tag => s.version.to_s }
  s.swift_version = '5.0'
  
  s.source_files = 'DTCore/Sources/**/*.swift'
end

