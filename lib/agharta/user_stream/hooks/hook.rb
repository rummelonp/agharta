# -*- coding: utf-8 -*-

module Agharta
  module UserStream
    module Hooks
      class Hook
        include Context
        include Handlers

        def initialize(context, *args, &block)
          @context = context
          if block_given?
            if block.arity > 0
              handler(block)
            else
              instance_eval(&block)
            end
          end
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

        def current_user
          @context.current_user
        end

        def current_user?(screen_name)
          current_user[:screen_name] == screen_name
        end
      end
    end
  end
end
