# -*- coding: utf-8 -*-

module Agharta
  module UserStream
    def stream(options = {}, &block)
      executable Stream.new(self, options, &block)
    end

    def filter(options = {}, &block)
      executable Filter.new(self, options, &block)
    end

    def sample(options = {}, &block)
      executable Sample.new(self, options, &block)
    end
  end
end

require 'agharta/user_stream/hooks'
require 'agharta/user_stream/client'
require 'agharta/user_stream/stream'
require 'agharta/user_stream/filter'
require 'agharta/user_stream/sample'
