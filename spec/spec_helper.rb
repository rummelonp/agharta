# -*- coding: utf-8 -*-

unless ENV['CI']
  require 'simplecov'
  SimpleCov.start do
    add_group 'Agharta' do |source|
      source.filename =~ /lib\/agharta(|\/[^\/]+).rb/
    end
    add_group 'Tasks',      'lib/agharta/tasks'
    add_group 'UsetStream', 'lib/agharta/user_stream'
    add_group 'Handlers',   'lib/agharta/handlers'
  end
end

require 'agharta'
require 'rspec'

RSpec.configure do |config|
  config.mock_with :rspec
end
