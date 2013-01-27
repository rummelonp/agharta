# -*- coding: utf-8 -*-

module Agharta
  module Recipes
    module UserStream
      Recipes.register self

      def stream(&block)
        Stream.start(self, &block)
      end

      def filter(&block)
        Filter.start(self, &block)
      end

      def sample(&block)
        Sample.start(self, &block)
      end
    end
  end
end

require 'agharta/recipes/user_stream/hooks'
require 'agharta/recipes/user_stream/client'
require 'agharta/recipes/user_stream/stream'
require 'agharta/recipes/user_stream/filter'
require 'agharta/recipes/user_stream/sample'
