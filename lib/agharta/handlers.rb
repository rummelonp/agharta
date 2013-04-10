# -*- coding: utf-8 -*-

require 'agharta/handlers/log'
require 'agharta/handlers/notify'
require 'agharta/handlers/store'

module Agharta
  module Handlers
    def handlers
      @handlers ||= []
    end

    def add_handler(handler)
      handlers << handler
      handler
    end

    def log(*args, &block)
      add_handler(Log.new(self, *args, &block))
    end

    def notify(*args, &block)
      add_handler(Notify.new(self, *args, &block))
    end

    def store(*args, &block)
      add_handler(Store.new(self, *args, &block))
    end
  end
end
