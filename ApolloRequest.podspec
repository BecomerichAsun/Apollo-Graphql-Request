#
# Be sure to run `pod lib lint UUApolloRequest.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#
Pod::Spec.new do |s|
  s.name         = "ApolloRequest" #和文件名保持一致
  s.version      = "1.0.0" #新版本一般都是0.1.0(我也不知道为啥,猜的)
  s.summary      = "Apollo网络请求库封装"

  s.homepage     = 'https://github.com/BecomerichAsun/Apollo-Graphql-Request'
  s.license   = { :type => 'MIT', :file => 'LICENSE' } 
  s.author             = { 'Asun' => 'becomerichios@163.com' }

  s.ios.deployment_target = '9.0'

  s.source       = { :git => "https://github.com/BecomerichAsun/Apollo-Graphql-Request", :tag => s.version.to_s }
  
  s.source_files  = 'AsunApolloRequest/Classes/**/*'
  
  s.resources = 'AsunApolloRequest/Assets/loading.gif'


  s.frameworks = 'UIKit'

  s.swift_version = '5.0'

  s.dependency  'ApolloAlamofire','~> 0.4.0'
  s.dependency  'Apollo/WebSocket', '~> 0.10.1'
  s.dependency  'HandyJSON', '~> 5.0.0-beta.1'
  s.dependency  'SwiftyJSON', '~> 5.0.0'
  s.dependency  'YYImage', '~> 1.0.4'
  s.dependency  'SwiftyJSON', '~> 5.0.0'
  s.dependency  'YYImage', '~> 1.0.4'

  end
