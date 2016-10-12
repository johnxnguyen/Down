Pod::Spec.new do |spec|
  spec.name         = "Down"
  spec.summary      = "Blazing fast Markdown rendering in Swift, built upon cmark."
  spec.version      = "0.3"
  spec.homepage     = "https://github.com/iwasrobbed/Down"
  spec.license      = { :type => "MIT", :file => "LICENSE" }
  spec.authors      = { "Rob Phillips" => "rob@desideratalabs.co" }
  spec.source       = { :git => "https://github.com/iwasrobbed/Down.git", :tag => "v" + spec.version.to_s }
  spec.source_files = "Source/**/*"
  spec.public_header_files = "Source/*.h"
  spec.platform		= :ios, "8.0"
  spec.requires_arc = true
  spec.module_name = "Down"
  spec.preserve_path = 'Source/cmark/module.modulemap'
  spec.pod_target_xcconfig = { 'SWIFT_INCLUDE_PATHS' => '$(SRCROOT)/Down/Source/cmark/**' }
  spec.resource = 'Resources/DownView.bundle'
end