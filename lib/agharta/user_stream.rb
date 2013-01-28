# -*- coding: utf-8 -*-

module Agharta
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

require 'agharta/user_stream/hooks'
require 'agharta/user_stream/client'
require 'agharta/user_stream/stream'
require 'agharta/user_stream/filter'
require 'agharta/user_stream/sample'
