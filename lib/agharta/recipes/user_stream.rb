# -*- coding: utf-8 -*-

module Agharta
  module Recipes
    module UserStream
      Recipes.register self

      def stream(&block)
        Stream.start(&block)
      end

      def filter(&block)
        Filter.start(&block)
      end

      def sample(&block)
        Sample.start(&block)
      end
    end
  end
end

require 'agharta/recipes/user_stream/client'
require 'agharta/recipes/user_stream/stream'
require 'agharta/recipes/user_stream/filter'
require 'agharta/recipes/user_stream/sample'
