Pod::Spec.new do |spec|
  spec.name         = "Down"
  spec.summary      = "Blazing fast Markdown rendering in Swift, built upon cmark."
  spec.version      = "0.8.6"
  spec.homepage     = "https://github.com/iwasrobbed/Down"
  spec.license      = { :type => "MIT", :file => "LICENSE" }
  spec.authors      = { "Rob Phillips" => "rob@robphillips.me" }
  spec.source       = { :git => "https://github.com/iwasrobbed/Down.git", :tag => "v" + spec.version.to_s }
  spec.source_files = "Source/{AST,cmark,Enums & Options,Extensions,Renderers}/**/*.{h,c,swift}", "Source/*"
  spec.ios.source_files = "Source/Views/**"
  spec.osx.source_files = "Source/Views/**"
  spec.public_header_files = "Source/*.h"
  spec.ios.deployment_target = "9.0"
  spec.tvos.deployment_target = "9.0"
  spec.osx.deployment_target = "10.11"
  spec.requires_arc = true
  spec.module_name = "Down"
  spec.preserve_paths = "Source/cmark/include/module.modulemap", "Source/cmark/*.inc", "Source/cmark/COPYING"
  spec.pod_target_xcconfig = { 'SWIFT_INCLUDE_PATHS' => '$(SRCROOT)/Down/Source/cmark/**' }
  spec.compiler_flags = '-Wno-shorten-64-to-32'
  spec.ios.resource = 'Resources/DownView.bundle'
  spec.osx.resource = 'Resources/DownView.bundle'
  spec.swift_version = "5.0"
end
