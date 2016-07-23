Pod::Spec.new do |s|


s.name         = "CycleScrollView"
s.version      = "1.0.0"
s.summary      = "高度自定义轮播图"

s.homepage     = "https://github.com/liguangyi1991/CycleScrollView.git"

s.license      = "MIT"

s.author       = { "liguangyi1991" => "1452167012@qq.com" }

s.platform     = :ios
s.platform     = :ios, "7.0"


s.source       = { :git => "https://github.com/liguangyi1991/CycleScrollView.git", :tag => "1.0.0"}


s.source_files = 'CycleScrollView/Lib/**/*{h,m}'


s.requires_arc = true

s.dependency 'SDWebImage', '~> 3.8.1'

end
