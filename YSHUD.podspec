#
# Be sure to run `pod lib lint YSHUD.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'YSHUD'
  s.version          = '0.1.2'
  s.summary          = '对MBProgressHUD的二次封装'
  s.description      = <<-DESC
  对MBProgressHUD的二次封装, 方便调用
                       DESC

  s.homepage         = 'https://github.com/zys-developer/YSHUD'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'zys-developer' => 'zys_dev@163.com' }
  s.source           = { :git => 'https://github.com/zys-developer/YSHUD.git', :tag => s.version.to_s }

  s.ios.deployment_target = '10.0'
  s.swift_version = '5.0'

  s.source_files = 'YSHUD/Classes/**/*'
  s.resource_bundles = {
      'YSHUD' => ['YSHUD/Assets/*.png']
  }

  s.public_header_files = 'Pod/Classes/**/*.{h,swift}'
  s.dependency 'MBProgressHUD'
end
