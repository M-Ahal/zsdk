Pod::Spec.new do |s|
  s.name             = 'zsdk'
  s.version          = '0.0.2'
  s.summary          = 'Zebra Link OS SDK Flutter'
  s.description      = <<-DESC
Zebra Link OS SDK Flutter Pod
                       DESC
  s.homepage         = 'http://example.com'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Your Company' => 'email@example.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.public_header_files = 'Classes/**/*.h'
  s.dependency 'Flutter'

  s.ios.deployment_target = '9.0'
  s.static_framework = true

  s.ios.vendored_frameworks = 'Libs/zsdk/ZSDK_API.xcframework'

  s.pod_target_xcconfig = {
    'DEFINES_MODULE' => 'YES',
    'VALID_ARCHS[sdk=iphonesimulator*]' => 'x86_64 arm64',
    'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => '',
    'ENABLE_BITCODE' => 'NO'
  }
end