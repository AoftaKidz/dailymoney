# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'DailyMoney' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for DailyMoney
  pod 'RealmSwift'
  pod 'DatePickerDialog'
  pod 'Charts', :git=>'https://github.com/danielgindi/Charts.git',:branch=>'pr/2378'
  pod 'Firebase/Database'
  pod 'Firebase/Core'
  pod 'Firebase/Auth'
  #pod 'Firebase/Firestore'
  
  post_install do |installer|
      installer.pods_project.targets.each do |target|
          target.build_configurations.each do |config|
              config.build_settings['SWIFT_VERSION'] = '3.0'
          end
      end
  end
end

target 'DailyWidget' do
    # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
    use_frameworks!
    
    # Pods for DailyMoney
    pod 'RealmSwift'
    pod 'Charts', :git=>'https://github.com/danielgindi/Charts.git',:branch=>'pr/2378'
    
end
