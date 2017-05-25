Pod::Spec.new do |spec|
  spec.name         = "Down"
  spec.summary      = "Blazing fast Markdown rendering in Swift, built upon cmark."
  spec.version      = "0.3.5"
  spec.homepage     = "https://github.com/iwasrobbed/Down"
  spec.license      = { :type => "MIT", :file => "LICENSE" }
  spec.authors      = { "Rob Phillips" => "rob@desideratalabs.co" }
  spec.source       = { :git => "https://github.com/iwasrobbed/Down.git", :tag => "v" + spec.version.to_s }
  spec.source_files = "Source/{cmark,Enums & Options,Extensions,Renderers}/**", "Source/*"
  spec.ios.source_files = "Source/Views/**"
  spec.osx.source_files = "Source/Views/**"
  spec.public_header_files = "Source/*.h"
  spec.ios.deployment_target = "8.0"
  spec.tvos.deployment_target = "9.0"
  spec.osx.deployment_target = "10.11"
  spec.requires_arc = true
  spec.module_name = "Down"
  spec.preserve_path = 'Source/cmark/module.modulemap'
  spec.pod_target_xcconfig = { 'SWIFT_INCLUDE_PATHS' => '$(SRCROOT)/Down/Source/cmark/**' }
  spec.ios.resource = 'Resources/DownView.bundle'
  spec.osx.resource = 'Resources/DownView.bundle'
end
