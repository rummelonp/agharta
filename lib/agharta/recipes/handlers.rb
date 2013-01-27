# -*- coding: utf-8 -*-

module Agharta
  module Recipes
    module Handlers
      Recipes.register self

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
end

require 'agharta/recipes/handlers/handler'
require 'agharta/recipes/handlers/store'
require 'agharta/recipes/handlers/log'
require 'agharta/recipes/handlers/notify'
