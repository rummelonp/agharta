# -*- coding: utf-8 -*-

require 'logger'

module Agharta
  class MultiLogger
    def initialize(*devices)
      @loggers = devices.map { |d| ::Logger.new(d) }
    end

    def method_missing(method_name, *args, &block)
      return super unless respond_to?(method_name)
      @loggers.each { |l| l.send(method_name, *args, &block) }
    end

    def respond_to?(method_name, include_private = false)
      @loggers.all? { |l| l.respond_to?(method_name, include_private) } || super
    end

    undef :warn
  end
end
