# -*- coding: utf-8 -*-

module Agharta
  module Handlers
    class Handler
      def initialize(context, *args, &block)
        raise NotImplementedError
      end

      def call(status, options = {})
        raise NotImplementedError
      end
    end
  end
end
