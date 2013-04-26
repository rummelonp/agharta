# -*- coding: utf-8 -*-

require 'agharta/executes/filter'
require 'agharta/executes/sample'
require 'agharta/executes/stream'

module Agharta
  module Executes
    # Return list of executable objects
    #
    # @return [Array<Agharta::Executable>]
    def executables
      @executables ||= []
    end

    # Add executable object to list
    #
    # @param executable [Agharta::Executable]
    # @return [Agharta::Executable]
    def add_executable(executable)
      executables << executable
      executable
    end

    # Add filter stream to executable list
    #
    # @see Agharta::UserStream::Filter
    # @param options [Hash] Optional hash to use to parameter
    # @return [Agharta::Executes::Filter]
    def filter(options = {}, &block)
      add_executable(Filter.new(self, options, &block))
    end

    # Add sample stream to executable list
    #
    # @see Agharta::UserStream::Sample
    # @param options [Hash] Optional hash to use to parameter
    # @return [Agharta::Executes::Sample]
    def sample(options = {}, &block)
      add_executable(Sample.new(self, options, &block))
    end

    # Add user stream to executable list
    #
    # @see Agharta::UserStream::Stream
    # @param options [Hash] Optional hash to use to parameter
    # @return [Agharta::Executes::Stream]
    def stream(options = {}, &block)
      add_executable(Stream.new(self, options, &block))
    end
  end
end
