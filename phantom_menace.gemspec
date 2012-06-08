# -*- encoding: utf-8 -*-
require File.expand_path('../lib/phantom_menace/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["William Estoque"]
  gem.email         = ["william.estoque@gmail.com"]
  gem.description   = %q{Ruby Wrapper for Phantomjs with a Browser API}
  gem.summary       = %q{Phantomjs based browser with a ruby wrapper}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "phantom_menace"
  gem.require_paths = ["lib"]
  gem.version       = PhantomMenace::VERSION

  gem.add_development_dependency "rspec"
  gem.add_development_dependency "rake"
  gem.add_development_dependency "phantomjs.rb"
  gem.add_development_dependency "sinatra"
end
