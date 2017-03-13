
Pod::Spec.new do |s|


  s.name         = "EPhotoKit"
  s.version      = "0.0.1"
  s.summary      = "Pod handles photo related tasks"
  s.platform     = :ios, '7.0'
  s.requires_arc = true

  s.description  = <<-DESC
                   Pod handles photo related tasks, thank you.

                   DESC

  s.homepage     = "https://github.com/zhuhuihuihui/EPhotoKit"
  s.screenshots  = "https://dl.dropboxusercontent.com/s/u6qfqyuhe49hfmt/EColumnChartScreenShot.png", "https://dl.dropboxusercontent.com/s/bafyk9xj2mxchyg/ELineChartScreenShot.png"


  s.license      = { :type => 'MIT', :file => 'LICENSE' }

  s.author             = { "Scott Zhu" => "zhuhuihuihui@gmail.com" }
  s.social_media_url = "https://twitter.com/zhujianhui"

  

  s.source       = { :git => "https://github.com/zhuhuihuihui/EPhotoKit.git", :tag => s.version  }
  s.source_files  = 'EPhotoKit', 'EPhotoKit/**/*.{h,m}'
  s.public_header_files = 'EPhotoKit/**/*.h'
  s.frameworks = 'CoreGraphics', 'UIKit', 'Foundation'
  
end

