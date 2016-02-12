Gem::Specification.new do |s|

  s.name        = 'rlocu2'
  s.version     = '0.1.0'
  s.date        = '2016-02-12'
  s.summary     = "A ruby wrapper for Locu API 2.0"
  s.description = "The Locu API gives you access to real-time local business data, from opening hours to price lists, such as restaurant menus"
  s.authors     = ["Andrea Cadamuro"]
  s.homepage    = 'https://github.com/caimano/rlocu2'
  s.license     = 'MIT'

  s.files = `git ls-files`.split("\n")
  s.test_files = `git ls-files -- {spec}/*`.split("\n")
  s.require_paths = ["lib"]

  s.add_runtime_dependency('faraday', '~> 0.9.2') # 08.02.2016
  s.add_runtime_dependency('faraday_middleware', '~> 0.10.0') # 09.02.2016
  s.add_runtime_dependency('json', '~> 1.8', '>= 1.8.3') # 09.02.2016

  s.add_development_dependency('rspec', '~> 3.4', '>= 3.4.0')  # 05.02.2016

end