# -*- encoding: utf-8 -*-

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'agharta/version'

Gem::Specification.new do |spec|
  spec.name          = 'agharta'
  spec.version       = Agharta::VERSION
  spec.authors       = ['Kazuya Takeshima']
  spec.email         = ['mail@mitukiii.jp']
  spec.description   = %q{Twitter Streaming API aggregator.}
  spec.summary       = %q{Twitter Streaming API aggregator.}
  spec.homepage      = 'https://github.com/mitukiii/agharta'
  spec.license       = 'MIT'

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'thor', '~> 0.16'
  spec.add_runtime_dependency 'pry', '~> 0.9'
  spec.add_runtime_dependency 'rainbow', '~> 1.1'
  spec.add_runtime_dependency 'oauth', '~> 0.4'
  spec.add_runtime_dependency 'faraday', '~> 0.8'
  spec.add_runtime_dependency 'yajl-ruby', '~> 1.1'
  spec.add_runtime_dependency 'multi_xml', '~> 0.5'
  spec.add_runtime_dependency 'twitter', '~> 4.4'
  spec.add_runtime_dependency 'tweetstream', '~> 2.4'

  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'guard-rspec'
  spec.add_development_dependency 'growl'
  spec.add_development_dependency 'simplecov'
  spec.add_development_dependency 'yard'
end
