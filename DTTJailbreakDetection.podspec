Pod::Spec.new do |s|
  s.name             = "DTTJailbreakDetection"
  s.version          = "0.3.0"
  s.summary          = "iOS device jailbreak detection library"
  s.homepage         = "https://github.com/drsiahaan/Test-jailbreak"
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { "Thi Doãn" => "t@thi.im" }
  s.source           = { :git => "https://github.com/drsiahaan/Test-jailbreak", :tag => s.version.to_s }

  s.platform     = :ios, '5.0'
  s.ios.deployment_target = '5.0'
  s.requires_arc = true

  s.source_files = 'Sources/DTTJailbreakDetection/**/*.{h,m}'
end
