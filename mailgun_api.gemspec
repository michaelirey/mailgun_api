Gem::Specification.new do |s|
  s.name        = 'mailgun_api'
  s.version     = '0.0.2'
  s.date        = '2013-11-14'
  s.summary     = "Library for the Mailgun API"
  s.description = "A library for interfacing with the Mailgun API"
  s.authors     = ["Michael Irey"]
  s.email       = 'michael.irey@gmail.com'
  s.files       = ["lib/mailgun_api.rb", "lib/mailgun/list.rb"]
  # s.files       = `git ls-files`.split("\n")
  s.require_paths = ["lib"]
  s.add_dependency(%q<json>, [">= 1.5"])
  s.add_dependency(%q<rest-client>, [">= 1.6"])
  s.homepage    = 'http://rubygems.org/gems/mailgun_api'
  s.license     = 'MIT'
end