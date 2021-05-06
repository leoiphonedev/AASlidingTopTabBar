
Pod::Spec.new do |s|
s.name             = 'AASlidingTopTabBar'
s.version          = '0.3.0'
s.summary          = 'TabBar with tab on top written in swift.'
s.swift_version =  '5.0'

s.description      = <<-DESC
AASlidingTopTabBar allows you to pass viewcontroller in an array and it will arrange al your viewcontrollers as a tab bar with tab on top. USer can chaneg tab either tapping on menu of tab, or slide. AASlidigTopTabBar is similar to android tab bar.
DESC

s.homepage         = 'https://github.com/leoiphonedev/AASlidingTopTabBar'
s.license      = {
:type => 'MIT',
:file => 'LICENSE',
:text => 'The MIT License (MIT)

Copyright (c) 2019-present Aman Aggarwal

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.'
}
s.author           = { 'Aman Aggarwal' => '<aggarwalaman1985@gmail.com>' }
s.source           = { :git => 'https://github.com/leoiphonedev/AASlidingTopTabBar.git', :tag => s.version.to_s }

s.ios.deployment_target = '11.0'
s.source_files = 'AASlidingTopTabBar/AASlidingTabController.swift'

end
