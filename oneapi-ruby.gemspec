# -*- encoding: utf-8 -*-
require File.expand_path('../lib/oneapi-ruby/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Tomo Krajina"]
  gem.email         = ["tkrajina@gmail.com"]
  gem.description   = %q{OneApi Ruby client}
  gem.summary       = %q{OneApi Ruby client}
  gem.homepage      = "https://github.com/parseco/oneapi-ruby"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "oneapi-ruby"
  gem.require_paths = ["lib"]
  gem.version       = OneApi::VERSION
end
