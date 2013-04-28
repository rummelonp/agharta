# -*- coding: utf-8 -*-

module Agharta
  module Tasks
    # Return list of task classes
    #
    # @return [Array<Class>]
    def self.mappings
      @mappings ||= {}
    end

    # Register task
    #
    # @param task_name [Symbol]
    # @param klass [Class]
    # @return [Class]
    def self.register(task_name, klass)
      mappings[task_name.to_sym] = klass
    end
  end
end

Dir[File.dirname(__FILE__) + '/tasks/*.rb'].each do |file|
  require file
end
