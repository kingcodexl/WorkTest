Pod::Spec.new do |s|
  s.name         = "CrashlyticsFrameworkIOS"
  s.version      = "3.0.8"
  s.summary      = "The most powerful, yet lightest weight crash reporting solution for iOS and Android developers. | Crashlytics"
  s.homepage     = "http://crashlytics.com"
  s.license      = {
    :type => 'Copyright',
    :file => 'LICENSE'
  }
  s.author       = 'Crashlytics'
  s.source       = { :git => "https://github.com/tbaranes/CrashlyticsFrameworkIOS.git", :tag => s.version.to_s }
  s.platform     = :ios, '5.0'
  s.requires_arc = true
  s.ios.source_files = 'Crashlytics.framework/Headers/*.h'
  s.ios.vendored_frameworks = ['Crashlytics.framework',
                               'Fabric.framework']
  s.xcconfig = { 'FRAMEWORK_SEARCH_PATHS' => '$(inherited)' }
  s.preserve_paths = ['Crashlytics.framework',
                      'Fabric.framework']
end