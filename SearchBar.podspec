
Pod::Spec.new do |s|



  s.name         = “MDSearchBar"
  s.version      = "0.0.1"
  s.summary      = “iOS control”
  s.homepage = "https://github.com/Fox-0390/SearchBar"
  s.license      = "MIT"

  
  s.license = { :type => 'MIT', :file => 'LICENSE'}
  s.author = { “Inozemtsev Vladimir” => “bor-26@yandex.ru” }
  s.source = {
      :git => "https://github.com/Fox-0390/SearchBar",
      :tag => s.version.to_s
    }

  s.ios.deployment_target = '7.0'
  s.default_subspec = 'core'


end
