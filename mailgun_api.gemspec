Gem::Specification.new do |s|
  s.name        = 'mailgun_api'
  s.version     = '0.0.1'
  s.date        = '2013-11-14'
  s.summary     = "Library for the Mailgun API"
  s.description = "A library for interfacing with the Mailgun API"
  s.authors     = ["Michael Irey"]
  s.email       = 'michael.irey@gmail.com'
  s.files       = `git ls-files`.split("\n")
  s.require_paths = ["lib"]
  s.add_dependency(%q<json>, [">= 1.5"])
  s.add_dependency(%q<rest-client>, [">= 1.6"])
  s.homepage    = 'http://rubygems.org/gems/mailgat'
  s.license     = 'MIT'
end