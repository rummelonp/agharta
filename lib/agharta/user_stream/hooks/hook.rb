# -*- coding: utf-8 -*-

module Agharta
  module UserStream
    module Hooks
      class Hook
        include Context
        include Handlers

        def initialize(context, *args, &block)
          if block_given?
            if block.arity > 0
              handler(block)
            else
              instance_eval(&block)
            end
          end
        end

        def call(status)
          raise NotImplementedError
        end

        private
        def invoke(status, options = {})
          handlers.each { |h| h.call(status, options) }
        end
      end
    end
  end
end
