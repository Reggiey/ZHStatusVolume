Pod::Spec.new do |s|
  
  s.name         = 'ZHStatusVolume'
  s.version      = '0.1.0'
  s.summary      = 'hide system volume hud, display upon status bar'

  s.description  = 'hide system volume hud, display upon status bar.'
  
  s.homepage     = 'https://github.com/lacklock/ZHStatusVolume'
  s.license      = { :type => 'MIT' }
  s.author       = { 'lacklock' => 'lacklock@gmail.com' }  
  
  s.source       = { :git => 'https://github.com/lacklock/ZHStatusVolume.git', :tag => "#{s.version}" }
  s.source_files = 'ZHStatusVolume/**'
  s.frameworks   = 'MediaPlayer','AVFoundation'
  
  s.platform     = :ios, '7.0'
  s.requires_arc = true

end
