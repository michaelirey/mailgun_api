Gem::Specification.new do |s|
  s.name        = 'mailgat'
  s.version     = '0.0.1'
  s.date        = '2013-11-14'
  s.summary     = "Library for the Mailgun API"
  s.description = "A library for interfacing with the Mailgun API"
  s.authors     = ["Michael Irey"]
  s.email       = 'michael.irey@gmail.com'
  s.files       = `git ls-files`.split("\n")
  # s.files       = ["lib/mailgat.rb"]
  # s.files       = ["lib/mailgat.rb", "lib/mailgat/list.rb"]
  s.require_paths = ["lib"]
  s.homepage    = 'http://rubygems.org/gems/mailgat'
  s.license     = 'MIT'
end