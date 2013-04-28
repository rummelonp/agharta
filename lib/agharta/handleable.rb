# -*- coding: utf-8 -*-

module Agharta
  # @abstract Inherit this class when to create handleable class
  module Handleable
    # @param context [Agharta::Context]
    def initialize(context, *args, &block)
      @context = context
    end

    # @abstract Should override
    def call(status)
      raise NotImplementedError, 'Should override'
    end
  end
end
