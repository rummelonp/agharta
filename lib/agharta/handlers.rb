# -*- coding: utf-8 -*-

module Agharta
  module Handlers
    Recipe.register self

    def handlers
      @handlers ||= []
    end

    def store(*args, &block)
      handler = Store.new(self, *args, &block)
      handlers << handler
      handler
    end

    def log(*args, &block)
      handler = Log.new(self, *args, &block)
      handlers << handler
      handler
    end

    def notify(*args, &block)
      handler = Notify.new(self, *args, &block)
      handlers << handler
      handler
    end
  end
end

require 'agharta/handlers/handler'
require 'agharta/handlers/store'
require 'agharta/handlers/log'
require 'agharta/handlers/notify'
