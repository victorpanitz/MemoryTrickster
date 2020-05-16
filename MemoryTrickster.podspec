Pod::Spec.new do |s|
  s.name             = 'MemoryTrickster'
  s.version          = '0.1.0'
  s.summary          = 'Full access to memory with MemoryTrickster.'

  s.description      = <<-DESC
Accessing the memory validating corner case scenarios from the crash edge.
                       DESC

  s.homepage         = 'https://github.com/victorpanitz@gmail.com/MemoryTrickster'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Victor Panitz Magalhaes' => 'victorpanitz@gmail.com' }
  s.source           = { :git => 'https://github.com/victorpanitz@gmail.com/MemoryTrickster.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/VictorPanitz'

  s.ios.deployment_target = '10.0'

  s.source_files = 'MemoryTrickster/Classes/**/*' 

end
