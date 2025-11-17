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

  # Only link for device builds
  s.pod_target_xcconfig = { 
    'DEFINES_MODULE' => 'YES', 
    'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64', 
    'ENABLE_BITCODE' => 'NO',
    'LIBRARY_SEARCH_PATHS' => '$(PODS_TARGET_SRCROOT)/Libs/zsdk'
  } 
  
  s.script_phases = [
    {
      :name => 'Build ZSDK',
      :execution_position => :before_compile,
      :script => <<-SCRIPT
        if [ "$EFFECTIVE_PLATFORM_NAME" = "-iphonesimulator" ]; then
          echo "Skipping ZSDK library linking for simulator"
        else
          echo "Linking ZSDK library for device"
          # Add any device-specific linking commands here if needed
        fi
      SCRIPT
    }
  ]
  
  # Only vendor the library for device builds
  s.ios.vendored_libraries = 'Libs/zsdk/libzsdk.a'
end