# -*- coding: utf-8 -*-

unless ENV['CI']
  require 'simplecov'
  SimpleCov.start do
    add_filter 'spec'
  end
end

require 'agharta'
require 'rspec'
