
Pod::Spec.new do |s|


  s.name         = "SearchBar"
  s.version      = "0.0.2"
  s.summary = "iOS control."
  s.homepage = "https://github.com/Fox-0390/SearchBar"
  s.license    = { :type => 'MIT', :file => 'LICENSE'}
  s.author     = { "Vladimir" => "bor-26@yandex.ru" }
  s.source     = {
      :git => "https://github.com/Fox-0390/SearchBar.git",
      :tag => "0.0.2"
    }
  s.ios.deployment_target = '7.0'
  s.requires_arc = true
  s.source_files = 'SearchBox/SearchBarTextField.m','SearchBox/SearchBarTextField.h','SearchBox/UICustomTextField.m','SearchBox/UICustomTextField.h','UIKit/UIKit.h','SearchBox/lupa@2x.png','SearchBox/refresh@2x.png','SearchBox/lock@2x.png','SearchBox/unrefresh@2x.png','SearchBox/lock_2@2x.png','lock_3@2x.png'
end
