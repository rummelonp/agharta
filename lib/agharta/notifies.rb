# -*- coding: utf-8 -*-

module Agharta
  module Notifies
    def self.mappings
      @mappings ||= {}
    end

    def self.register(notify_name, klass)
      mappings[notify_name.to_sym] = klass
    end

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
