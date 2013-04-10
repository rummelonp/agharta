# -*- coding: utf-8 -*-

module Agharta
  module Handlers
    def handlers
      @handlers ||= []
    end

    def add_handler(handler)
      handlers << handler
      handler
    end

    def store(*args, &block)
      add_handler(Store.new(self, *args, &block))
    end

    def log(*args, &block)
      add_handler(Log.new(self, *args, &block))
    end

    def notify(*args, &block)
      add_handler(Notify.new(self, *args, &block))
    end
  end
end

require 'agharta/handlers/store'
require 'agharta/handlers/log'
require 'agharta/handlers/notify'
