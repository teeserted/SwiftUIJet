Pod::Spec.new do |spec|
  spec.name         = "SwiftUIJet"
  spec.version      = "0.0.1"
  spec.summary      = "SwiftUI components library"
  spec.homepage     = "http://teeserted.com"
  spec.license      = { :type => "Apache License, Version 2.0", :file => "LICENSE" }
  spec.author             = { "vellovaherpuu" => "vello@teeserted.com" }

  spec.platform     = :ios, "13.0"
  spec.source       = { :git => "https://github.com/teeserted/SwiftUIJet.git", :tag => "#{spec.version}" }
  spec.swift_version = '5.0'
  
  spec.source_files  = "Classes", "SwiftUIJet/**/*.{h,m,swift}"
end
