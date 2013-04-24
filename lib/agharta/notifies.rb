# -*- coding: utf-8 -*-

module Agharta
  module Notifies
    # Return list of notify classes
    #
    # @return [Array<Class>]
    def self.mappings
      @mappings ||= {}
    end

    # Register notify
    #
    # @param notify_name [Symbol]
    # @param klass [Class]
    # @return [Class]
    def self.register(notify_name, klass)
      mappings[notify_name.to_sym] = klass
    end

    # Find notify from given name
    #
    # @param notify_name [Symbol]
    # @return [Class]
    # @raise [ArgumentError] Error raised when notify class not found
    def self.find(notify_name)
      store = mappings[notify_name.to_sym]
      raise ArgumentError, "No such notify \"#{notify_name}\"" unless store
      store
    end
  end
end

Dir[File.dirname(__FILE__) + '/notifies/*.rb'].each do |file|
  require file
end
