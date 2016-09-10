Pod::Spec.new do |s|
  s.name     = 'ZTNetwork'
  s.version  = '1.0.4'
  s.license  = { :type => "MIT", :file => "FILE_LICENSE" }
  s.summary  = 'Core'
  s.homepage = 'https://gitlab.com/zt/ztnetwork'
  #s.social_media_url = 'https://xx'
  s.authors  = { 'mapengzhen' => 'mpz129@sina.com' }
  s.source   = { :git => 'https://gitlab.com/zt/ZTNetwork.git', :tag => s.version }
  s.requires_arc = true

  s.ios.deployment_target = '6.0'
  s.dependency 'ZTCore'
  s.dependency 'AFNetworking'

  s.public_header_files = 'ZTNetwork/**/*.h'
  s.source_files =  "ZTNetwork", "ZTNetwork/**/*.{h,m}"
  s.resources = ["ZTNetwork/**/*.png", "ZTNetwork/**/*.{xib,storyboard,xcdatamodeld,xcdatamodel,txt,plist,cer,html}"]

  s.frameworks = 'CoreGraphics', 'Foundation', 'UIKit'
end
