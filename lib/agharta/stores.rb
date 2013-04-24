# -*- coding: utf-8 -*-

module Agharta
  module Stores
    # Return list of store classes
    #
    # @return [Array<Class>]
    def self.mappings
      @mappings ||= {}
    end

    # Register store
    #
    # @param store_name [Symbol]
    # @param klass [Class]
    # @return [Class]
    def self.register(store_name, klass)
      mappings[store_name.to_sym] = klass
    end

    # Find store from given name
    #
    # @param store_name [Symbol]
    # @return [Class]
    # @raise [ArgumentError] Error raised when store class not found
    def self.find(store_name)
      store = mappings[store_name.to_sym]
      raise ArgumentError, "No such store \"#{store_name}\"" unless store
      store
    end
  end
end

Dir[File.dirname(__FILE__) + '/stores/*.rb'].each do |file|
  require file
end
