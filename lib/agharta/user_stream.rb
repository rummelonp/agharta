# -*- coding: utf-8 -*-

require 'agharta/user_stream/filter'
require 'agharta/user_stream/sample'
require 'agharta/user_stream/stream'

module Agharta
  module UserStream
    def filter(options = {}, &block)
      add_executable(Filter.new(self, options, &block))
    end

    def sample(options = {}, &block)
      add_executable(Sample.new(self, options, &block))
    end

    def stream(options = {}, &block)
      add_executable(Stream.new(self, options, &block))
    end
  end
end
