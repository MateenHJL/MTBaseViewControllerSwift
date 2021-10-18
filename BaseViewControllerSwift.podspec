#
# Be sure to run `pod lib lint BaseViewControllerSwift.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'BaseViewControllerSwift'
  s.version          = '1.0.6'
  s.summary          = 'A short description of BaseViewControllerSwift.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/MateenHJL/BaseViewController'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { '13162378587@163.com' => '13162378587@163.com' }
  s.source           = { :git => 'https://github.com/MateenHJL/BaseViewController', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '9.0'

  s.source_files = 'BaseViewControllerSwift/Classes/**/*'
  
  s.pod_target_xcconfig = {
        'VALID_ARCHS' => 'x86_64 armv7 arm64'
  }
  
  s.dependency 'IQKeyboardManagerSwift'
  s.dependency 'UIView+Positioning'
  s.dependency 'BaseUIManagerSwift'
  s.dependency 'MTHttpEngine'
  
  s.static_framework = true
  
  # s.resource_bundles = {
  #   'BaseViewControllerSwift' => ['BaseViewControllerSwift/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
