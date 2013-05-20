# encoding: utf-8

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'attrio/version'

Gem::Specification.new do |gem|
  gem.name          = "attrio"
  gem.version       = Attrio::Version::STRING
  gem.authors       = ['Igor Alexandrov', 'Julia Egorova']  
  gem.email         = 'hello@jetrockets.ru'
  gem.summary       = "Attributes for Plain Old Ruby Objects"
  gem.homepage      = "https://github.com/jetrockets/attrio"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_development_dependency 'rspec'
  gem.add_development_dependency 'webmock', '~> 1.9.0'
  gem.add_development_dependency 'simplecov'
  gem.add_development_dependency 'coveralls', :require => false
  gem.add_development_dependency 'rake'
  gem.add_development_dependency 'bundler'
  gem.add_development_dependency "rake"
end
