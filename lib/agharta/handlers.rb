# -*- coding: utf-8 -*-

module Agharta
  module Handlers
    def handlers
      @handlers ||= []
    end

    def handler(handler)
      handlers << handler
      handler
    end

    def store(*args, &block)
      handler Store.new(self, *args, &block)
    end

    def log(*args, &block)
      handler Log.new(self, *args, &block)
    end

    def notify(*args, &block)
      handler Notify.new(self, *args, &block)
    end
  end
end

require 'agharta/handlers/handler'
require 'agharta/handlers/store'
require 'agharta/handlers/log'
require 'agharta/handlers/notify'
