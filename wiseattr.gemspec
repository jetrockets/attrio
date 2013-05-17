# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'wiseattr/version'

Gem::Specification.new do |gem|
  gem.name          = "wiseattr"
  gem.version       = Wiseattr::VERSION
  gem.authors       = ["JetRockets"]
  gem.email         = ["igor.alexandrov@gmail.com"]
  gem.summary       = "Attributes for Ruby Objects"
  gem.homepage      = "https://github.com/jetrockets/wiseattr"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
end
