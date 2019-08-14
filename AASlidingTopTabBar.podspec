
Pod::Spec.new do |s|
s.name             = 'AASlidingTopTabBar'
s.version          = '0.1.0'
s.summary          = 'TabBar with tab on top written in swift.'

s.description      = <<-DESC
AASlidingTopTabBar allows you to pass viewcontroller in an array and it will arrange al your viewcontrollers as a tab bar with tab on top. USer can chaneg tab either tapping on menu of tab, or slide. AASlidigTopTabBar is similar to android tab bar.
DESC

s.homepage         = 'https://github.com/leoiphonedev/AASlidingTopTabBar'
s.license          = { :type => 'MIT', :file => 'LICENSE' }
s.author           = { '<Aman Aggarwal>' => '<aggarwalaman1985@gmail.com>' }
s.source           = { :git => 'https://github.com/leoiphonedev/AASlidingTopTabBar.git', :tag => s.version.to_s }

s.ios.deployment_target = '11.0'
s.source_files = 'AASlidingTopTabBar/AASlidingTabController.swift'

end
