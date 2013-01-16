# -*- coding: utf-8 -*-

require 'thor/group'

module Agharta
  module Tasks
    def self.mappings
      @mappings ||= {}
    end

    def self.register(klass)
      mappings[klass.name.split('::').last.downcase] = klass
    end
  end
end

require 'agharta/tasks/actions'
require 'agharta/tasks/cli'
require 'agharta/tasks/edit'
require 'agharta/tasks/execute'
