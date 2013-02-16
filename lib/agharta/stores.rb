# -*- coding: utf-8 -*-

module Agharta
  module Stores
    def self.mappings
      @mappings ||= {}
    end

    def self.register(store_name, klass)
      mappings[store_name.to_s] = klass
    end

    def self.find(store_name)
      store = mappings[store_name.to_s]
      raise ArgumentError, "No such store \"#{store_name}\"" unless store
      store
    end
  end
end
