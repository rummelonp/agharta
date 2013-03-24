# -*- encoding: utf-8 -*-

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'agharta/version'

Gem::Specification.new do |gem|
  gem.name          = 'agharta'
  gem.version       = Agharta::VERSION
  gem.authors       = ['Kazuya Takeshima']
  gem.email         = ['mail@mitukiii.jp']
  gem.description   = %q{Twitter Streaming API aggregator.}
  gem.summary       = %q{Twitter Streaming API aggregator.}
  gem.homepage      = 'https://github.com/mitukiii/agharta'

  gem.add_runtime_dependency 'thor', '~> 0.16'
  gem.add_runtime_dependency 'pry', '~> 0.9'
  gem.add_runtime_dependency 'rainbow', '~> 1.1'
  gem.add_runtime_dependency 'oauth', '~> 0.4'
  gem.add_runtime_dependency 'faraday', '~> 0.8'
  gem.add_runtime_dependency 'yajl-ruby', '~> 1.1'
  gem.add_runtime_dependency 'twitter', '~> 4.4'
  gem.add_runtime_dependency 'tweetstream', '~> 2.4'
  gem.add_runtime_dependency 'prowl', '~> 0.1.3'

  gem.add_development_dependency 'rake'
  gem.add_development_dependency 'rspec'
  gem.add_development_dependency 'guard-rspec'
  gem.add_development_dependency 'growl'
  gem.add_development_dependency 'simplecov'
  gem.add_development_dependency 'yard'

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ['lib']
end
