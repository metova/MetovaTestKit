Pod::Spec.new do |s|
  s.name         = "MTK"
  s.version      = "0.1.2"
  s.summary      = "Metova Test Kit"

  s.homepage = "http://metova.com"
  s.license  = { :type => "MIT", :file => "LICENSE" }
  s.authors  = { "Nick Griffith" => "nick.griffith@metova.com" }

  s.platform = :ios, '8.0'

  s.frameworks = 'Foundation', 'UIKit', 'XCTest'

  s.source              = { :git => "https://github.com/metova/MetovaTestKit.git", :tag => s.version.to_s }
  s.source_files        = "MetovaTestKit", "MetovaTestKit/**/*.{h,m,swift}"
  s.public_header_files = 'MetovaTestKit/**/*.h'
  s.exclude_files       = "MetovaTestKit/Exclude"
end
