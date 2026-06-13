#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint dn_signals.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'dn_signals'
  s.version          = '0.0.1'
  s.summary          = 'Flutter wrapper for Tencent GDT Action SDK.'
  s.description      = <<-DESC
Flutter wrapper for Tencent GDT Action SDK. Initialization and reporting are controlled from Dart.
                       DESC
  s.homepage         = 'https://datanexus.qq.com/doc/develop/guider/sdk/ios/init'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'DataNexus' => 'opensource@example.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*.{h,m}', 'Vendor/GDTActionSDK/*.h'
  s.public_header_files = 'Classes/**/*.h'
  s.vendored_libraries = 'Vendor/GDTActionSDK/libGDTActionSDK.a'
  s.frameworks = 'AdSupport', 'AppTrackingTransparency', 'CoreTelephony', 'Security', 'StoreKit', 'SystemConfiguration', 'UIKit'
  s.libraries = 'c++', 'sqlite3', 'z'
  s.dependency 'Flutter'
  s.platform = :ios, '13.0'

  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = {
    'DEFINES_MODULE' => 'YES',
    'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386',
    'HEADER_SEARCH_PATHS' => '"${PODS_TARGET_SRCROOT}/Vendor/GDTActionSDK"'
  }

  # If your plugin requires a privacy manifest, for example if it uses any
  # required reason APIs, update the PrivacyInfo.xcprivacy file to describe your
  # plugin's privacy impact, and then uncomment this line. For more information,
  # see https://developer.apple.com/documentation/bundleresources/privacy_manifest_files
  # s.resource_bundles = {'dn_signals_privacy' => ['Resources/PrivacyInfo.xcprivacy']}
end
