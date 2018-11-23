#
# Be sure to run `pod lib lint IKCryptoKeyboard.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'IKCryptoKeyboard'
  s.version          = '1.0.0'
  s.summary          = 'this is crypto keyboard view controller.'
  
  s.dependency 'CryptoSwift'
# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
  this is crypto keyboard view controller,
  present modal view controller included crypto keyboard.
                       DESC

  s.homepage         = 'https://github.com/leibniz55/IKCryptoKeyboard'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'leibniz55' => 'leibniz55@naver.com' }
  s.source           = { :git => 'https://github.com/leibniz55/IKCryptoKeyboard.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '9.0'

  s.source_files = 'IKCryptoKeyboard/Classes/**/*'
  s.swift_version = '3.0'
  
  # s.resource_bundles = {
  #   'IKCryptoKeyboard' => ['IKCryptoKeyboard/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
