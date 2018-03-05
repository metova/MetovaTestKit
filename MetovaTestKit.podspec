Pod::Spec.new do |s|
  s.name         = 'MetovaTestKit'
  s.version      = '2.0.0'
  s.summary      = 'A collection of useful test helpers designed to ease the burden of writing tests for iOS applications.'

  s.homepage = 'http://metova.com'
  s.license  = { :type => 'MIT', :file => 'LICENSE' }
  s.authors  = { 'Nick Griffith' => 'nick.griffith@metova.com', 'Logan Gauthier' => 'logan.paul.gauthier@gmail.com' }

  s.source = { :git => 'https://github.com/metova/MetovaTestKit.git', :tag => s.version.to_s }

  s.platform = :ios, '8.0'
  s.swift_version = '4.0'

  s.frameworks            = 'XCTest'
  s.user_target_xcconfig  = { 'FRAMEWORK_SEARCH_PATHS' => '$(PLATFORM_DIR)/Developer/Library/Frameworks' }

  s.source_files        = 'MetovaTestKit', 'MetovaTestKit/**/*.{h,m,swift}'
  s.public_header_files = 'MetovaTestKit/**/*.h'
  s.exclude_files       = 'MetovaTestKit/Exclude'
end
