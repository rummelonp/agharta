# -*- coding: utf-8 -*-

require 'thor/group'

module Agharta
  module Tasks
    def self.mappings
      @mappings ||= {}
    end

    def self.register(task_name, klass)
      mappings[task_name.to_s] = klass
    end
  end
end

require 'agharta/tasks/actions'
require 'agharta/tasks/cli'
require 'agharta/tasks/user_add'
require 'agharta/tasks/user_list'
require 'agharta/tasks/console'
require 'agharta/tasks/edit'
require 'agharta/tasks/cat'
require 'agharta/tasks/execute'
