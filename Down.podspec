Pod::Spec.new do |spec|
  spec.name         = "Down"
  spec.summary      = "Blazing fast Markdown rendering in Swift, built upon cmark."
  spec.version      = "0.11.0"
  spec.homepage     = "https://github.com/johnxnguyen/Down"
  spec.license      = { :type => "MIT", :file => "LICENSE" }
  spec.authors      = { "John Nguyen" => "polyxo@protonmail.com" }
  spec.source       = { :git => "https://github.com/johnxnguyen/Down.git", :tag => "v" + spec.version.to_s }
  spec.source_files = "Sources/Down/{AST,Enums & Options,Extensions,Renderers}/**/*.swift", "Sources/cmark/*.{h,c}", "Sources/Down/*"
  spec.ios.source_files = "Sources/Down/Views/**"
  spec.osx.source_files = "Sources/Down/Views/**"
  spec.public_header_files = "Sources/Down/*.h"
  spec.ios.deployment_target = "9.0"
  spec.tvos.deployment_target = "9.0"
  spec.osx.deployment_target = "10.11"
  spec.requires_arc = true
  spec.module_name = "Down"
  spec.preserve_paths = "Sources/cmark/include/module.modulemap", "Sources/cmark/*.inc", "Sources/cmark/COPYING"
  spec.pod_target_xcconfig = { 'SWIFT_INCLUDE_PATHS' => '$(SRCROOT)/Down/Sources/cmark/**' }
  spec.ios.resource = 'Sources/Down/Resources/DownView.bundle'
  spec.osx.resource = 'Sources/Down/Resources/DownView.bundle'
  spec.swift_versions = ['5.0', '5.1']
end
