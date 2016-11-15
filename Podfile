# Uncomment this line to define a global platform for your project
 platform :ios, ‘9.0’
# Uncomment this line if you're using Swift
 use_frameworks!
source "https://github.com/CocoaPods/Old-Specs"

target 'SwimpyNew' do
pod 'Alamofire', '~> 4.0'
pod 'SwiftyJSON'
pod 'YYWebImage'
pod 'FBSDKCoreKit'
pod 'FBSDKShareKit'
pod 'FBSDKLoginKit'
pod 'IQKeyboardManager'
pod 'NVActivityIndicatorView'
pod 'SZTextView'
pod 'XLPagerTabStrip'
pod 'Fusuma', '~> 1.0.0'
pod 'RMMapper'
pod 'Google/SignIn'
end

post_install do |installer|
installer.pods_project.targets.each do |target|
target.build_configurations.each do |configuration|
configuration.build_settings['SWIFT_VERSION'] = “3.0”
end
end
end
