# -*- encoding: utf-8 -*-

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'agharta/version'

Gem::Specification.new do |gem|
  gem.name          = 'agharta'
  gem.version       = Agharta::VERSION
  gem.authors       = ['Kazuya Takeshima']
  gem.email         = ['mail@mitukiii.jp']
  gem.description   = %q{TODO: Write a gem description}
  gem.summary       = %q{TODO: Write a gem summary}
  gem.homepage      = ''

  gem.add_runtime_dependency 'thor', '~> 0.16'
  gem.add_runtime_dependency 'pry', '~> 0.9'
  gem.add_runtime_dependency 'rainbow', '~> 1.1'
  gem.add_runtime_dependency 'oauth', '~> 0.4'
  gem.add_runtime_dependency 'twitter', '~> 4.4'
  gem.add_runtime_dependency 'tweetstream', '~> 2.4'

  gem.add_development_dependency 'rspec'
  gem.add_development_dependency 'guard-rspec'
  gem.add_development_dependency 'growl'
  gem.add_development_dependency 'simplecov'

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ['lib']
end
