# -*- coding: utf-8 -*-

require 'agharta/version'
require 'agharta/errors'
require 'agharta/core_ext'
require 'agharta/connection'
require 'agharta/status_formatter'
require 'agharta/context'
require 'agharta/multi_logger'
require 'agharta/simple_formatter'
require 'agharta/environment'
require 'agharta/tasks'
require 'agharta/executable'
require 'agharta/configuration'
require 'agharta/linker'
require 'agharta/handlers'
require 'agharta/stores'
require 'agharta/notifies'
require 'agharta/user_stream'
require 'agharta/recipe'
require 'agharta/file_recipe'

module Agharta
  def self.new(name  = caller.first.split(':').first)
    Recipe.new(name)
  end
end
