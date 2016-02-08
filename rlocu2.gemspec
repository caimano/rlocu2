Gem::Specification.new do |s|
  s.add_development_dependency('rspec', '~> 3.4', '>= 3.4.0')  # 05.02.2016
  s.add_development_dependency('webmock', '~> 1.22', '>= 1.22.6') # 05.02.2016
  s.add_runtime_dependency('faraday', '~> 0.9.2') # 08.02.2016
  s.name        = 'rlocu2'
  s.version     = '0.0.1'
  s.date        = '2016-02-05'
  s.summary     = "A ruby wrapper for Locu API 2.0"
  s.description = "The Locu API gives you access to real-time local business data, from opening hours to price lists, such as restaurant menus"
  s.authors     = ["Andrea Cadamuro"]
  s.email       = 'caimandrea@gmail.com'
  s.files = [
      'lib/rlocu2.rb',
      'lib/client/client.rb'
  ]

  s.homepage    = 'http://www.andreacadamuro.com'
  s.license     = 'MIT'

end