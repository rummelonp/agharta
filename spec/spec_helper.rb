# -*- coding: utf-8 -*-

unless ENV['CI']
  require 'simplecov'
  SimpleCov.start do
    add_filter 'spec'
    add_group 'Agharta' do |source|
      source.filename =~ /lib\/agharta(|\/[^\/]+).rb/
    end
    add_group 'Tasks',      'lib/agharta/tasks'
    add_group 'UsetStream', 'lib/agharta/user_stream'
    add_group 'Handlers' do |source|
      source.filename =~ /lib\/agharta\/handlers/ ||
        source.filename =~ /lib\/agharta\/notifies/ ||
        source.filename =~ /lib\/agharta\/stores/
    end
    add_group 'Hooks',     'lib/agharta/hooks'
    add_group 'Extension', 'lib/agharta/core_ext'
  end
end

require 'agharta/recipe'
require 'agharta/tasks'
require 'rspec'

class DummyRecipe
  include Agharta::Configuration
  include Agharta::Context
  include Agharta::Executable
  include Agharta::UserStream
end

class DummyStream < Agharta::UserStream::Client
end

class DummyHook < Agharta::Hookable
  def call(status)
    invoke(status)
  end
end

class DummyHandler
  def initialize(context, *args, &block)
  end
  def call(status, options = {})
  end
end

RSpec.configure do |config|
  config.mock_with :rspec
end
