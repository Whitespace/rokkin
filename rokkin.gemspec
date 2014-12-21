Gem::Specification.new do |s|
  s.name        = 'rokkin'
  s.version     = '0.0.4'
  s.executables << 'rokkin'
  s.date        = '2014-12-21'
  s.summary     = "Rokkin!"
  s.description = "A fast way to containerize your ruby webapps"
  s.authors     = ["Tom Clark"]
  s.email       = 'whitespace@gmail.com'
  s.files       = ["lib/rokkin.rb", "lib/Dockerfile", "lib/Procfile", "lib/.env", "lib/fig.yml"]
  s.homepage    = 'http://rubygems.org/gems/rokkin'
  s.license     = 'MIT'

  s.add_runtime_dependency "git",   ["~> 1.2.8"]
  s.add_runtime_dependency "thor",  ["~> 0.19.1"]
end
