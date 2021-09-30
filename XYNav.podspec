#
# Be sure to run `pod lib lint XYNav.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'XYNav'
  s.version          = '1.0'
  s.summary          = 'XYNav 是一个提供更多拓展性的 iOS 系统导航'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
  XYNav 是一个 iOS 导航控制器,使用方式完全与系统相同
  支持独立设置每个页面的navBar、
  支持全屏返回手势、可自定义手势响应区域、可禁用当前页面的返回手势
                       DESC

  s.homepage         = 'https://github.com/xiaoyouPrince/XYNav'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'xiaoyouPrince' => 'xiaoyouPrince@163.com' }
  s.source           = { :git => 'https://github.com/xiaoyouPrince/XYNav.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '9.0'
  
  s.swift_version = '5.0'

  s.source_files = 'XYNav/XYNav/Classes/**/*'
  
  # s.resource_bundles = {
  #   'XYNav' => ['XYNav/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
