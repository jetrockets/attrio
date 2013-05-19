# encoding: utf-8

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'wiseattr/version'

Gem::Specification.new do |gem|
  gem.name          = "wiseattr"
  gem.version       = Attrio::VERSION::STRING
  gem.authors       = ['Igor Alexandrov', 'Julia Egorova']  
  gem.email         = 'hello@jetrockets.ru'
  gem.summary       = "Attributes for Plain Old Ruby Objects"
  gem.homepage      = "https://github.com/jetrockets/attrio"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
end
