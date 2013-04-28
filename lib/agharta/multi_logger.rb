# -*- coding: utf-8 -*-

require 'logger'

module Agharta
  class MultiLogger
    # @param devices [Array<IO, String>] IO or log path.
    def initialize(*devices)
      @loggers = devices.map { |device| ::Logger.new(device) }
    end

    # @private
    def method_missing(method_name, *args, &block)
      return super unless respond_to?(method_name)
      @loggers.each { |logger| logger.send(method_name, *args, &block) }
    end

    # @private
    def respond_to?(method_name, include_private = false)
      @loggers.all? { |logger| logger.respond_to?(method_name, include_private) } || super
    end

    # Delete Kernel#warn
    undef :warn
  end
end
