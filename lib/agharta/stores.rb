# -*- coding: utf-8 -*-

module Agharta
  module Stores
    def self.mappings
      @mappings ||= {}
    end

    def self.register(store_name, klass)
      mappings[store_name.to_sym] = klass
    end

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
