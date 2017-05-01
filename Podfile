# Uncomment this line to define a global platform for your project
 platform :ios, ‘9.0’
# Uncomment this line if you're using Swift
 use_frameworks!
source "https://github.com/CocoaPods/Old-Specs"

target 'SwimpyNew' do
pod 'Alamofire'
pod 'SwiftyJSON'
pod 'YYWebImage'
pod 'FBSDKCoreKit'
pod 'FBSDKShareKit'
pod 'FBSDKLoginKit'
pod 'IQKeyboardManager'
pod 'SZTextView'
pod 'XLPagerTabStrip' 
pod 'Fusuma', '~> 1.0.0'
pod 'RMMapper'
pod 'Google/SignIn'
pod 'DropDown'
pod 'SDWebImage'
pod 'Presentr'
pod 'SwiftMessages'
pod 'EZSwiftExtensions'
pod 'SFFocusViewLayout'
pod 'Material'
pod "ESPullToRefresh"
pod "MIBadgeButton-Swift", :git => 'https://github.com/mustafaibrahim989/MIBadgeButton-Swift.git', :branch => 'master'
end

post_install do |installer|
installer.pods_project.targets.each do |target|
target.build_configurations.each do |configuration|
configuration.build_settings['SWIFT_VERSION'] = “3.0”
end
end
end
