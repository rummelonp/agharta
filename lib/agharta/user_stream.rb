# -*- coding: utf-8 -*-

require 'agharta/user_stream/filter'
require 'agharta/user_stream/sample'
require 'agharta/user_stream/stream'

module Agharta
  module UserStream
    # Add filter stream to executable list
    #
    # @see Agharta::UserStream::Filter
    # @param options [Hash] Optional hash to use to parameter
    # @return [Agharta::UserStream::Filter]
    def filter(options = {}, &block)
      add_executable(Filter.new(self, options, &block))
    end

    # Add sample stream to executable list
    #
    # @see Agharta::UserStream::Sample
    # @param options [Hash] Optional hash to use to parameter
    # @return [Agharta::UserStream::Sample]
    def sample(options = {}, &block)
      add_executable(Sample.new(self, options, &block))
    end

    # Add user stream to executable list
    #
    # @see Agharta::UserStream::Stream
    # @param options [Hash] Optional hash to use to parameter
    # @return [Agharta::UserStream::Stream]
    def stream(options = {}, &block)
      add_executable(Stream.new(self, options, &block))
    end
  end
end
