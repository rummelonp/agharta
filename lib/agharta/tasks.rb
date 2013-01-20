# -*- coding: utf-8 -*-

require 'thor/group'

module Agharta
  module Tasks
    def self.mappings
      @mappings ||= {}
    end

    def self.register(klass)
      task_name = klass.name.split('::').last.downcase
      mappings[task_name] = klass
    end
  end
end

require 'agharta/tasks/environment'
require 'agharta/tasks/actions'
require 'agharta/tasks/cli'
require 'agharta/tasks/edit'
require 'agharta/tasks/cat'
require 'agharta/tasks/execute'
