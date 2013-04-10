# -*- coding: utf-8 -*-

require 'logger'

module Agharta
  class MultiLogger
    def initialize(*devices)
      @loggers = devices.map { |device| ::Logger.new(device) }
    end

    def method_missing(method_name, *args, &block)
      return super unless respond_to?(method_name)
      @loggers.each { |logger| logger.send(method_name, *args, &block) }
    end

    def respond_to?(method_name, include_private = false)
      @loggers.all? { |logger| logger.respond_to?(method_name, include_private) } || super
    end

    # Delete Kernel#warn
    undef :warn
  end
end
