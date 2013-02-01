# -*- coding: utf-8 -*-

module Agharta
  module UserStream
    Recipe.register self

    def stream(options = {}, &block)
      Stream.start(self, options, &block)
    end

    def filter(options = {}, &block)
      Filter.start(self, options, &block)
    end

    def sample(options = {}, &block)
      Sample.start(self, options, &block)
    end
  end
end

require 'agharta/user_stream/hooks'
require 'agharta/user_stream/client'
require 'agharta/user_stream/stream'
require 'agharta/user_stream/filter'
require 'agharta/user_stream/sample'
