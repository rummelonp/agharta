# -*- coding: utf-8 -*-

module Agharta
  module UserStream
    module Hooks
      class Hook
        include Context
        include Handlers

        def initialize(context, *args, &block)
          raise NotImplementedError
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
