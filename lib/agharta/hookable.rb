# -*- coding: utf-8 -*-

require 'agharta/context'
require 'agharta/handlers'

module Agharta
  # @abstract Inherit this class when to create hookable class
  module Hookable
    include Context
    include Handlers

    # @param context [Agharta::Context]
    # @yield [status, options] Add block to handler when arity greater than zero
    # @yield Evaluate as event hook context when arity is zero
    # @yieldparam [Hash] status
    # @yieldparam [Hash] options
    def initialize(context, *args, &block)
      @context = context
      if block_given?
        if block.arity > 0
          add_handler(block)
        else
          instance_eval(&block)
        end
      end
    end

    # @abstract Should override
    def call(status)
      raise NotImplementedError, 'Should override'
    end

    # Return current user credentials
    #
    # @override
    # @return [Hash]
    def current_user
      @context.current_user
    end

    private
    def invoke(status, options = {})
      handlers.each do |handler|
        begin
          handler.call(status, options)
        rescue
          @context.logger.error "#{$!.class}: #{$!.message}"
        end
      end
    end

    def current_user?(screen_name)
      current_user[:screen_name] == screen_name
    end
  end
end
