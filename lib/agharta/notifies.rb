# -*- coding: utf-8 -*-

module Agharta
  module Notifies
    def self.mappings
      @mappings ||= {}
    end

    def self.register(notify_name, klass)
      mappings[notify_name.to_s] = klass
    end

    def self.find(notify_name)
      store = mappings[notify_name.to_s]
      raise NotFound, "No such notify \"#{notify_name}\"" unless store
      store
    end

    class NotFound < StandardError
    end
  end
end
