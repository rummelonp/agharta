# -*- coding: utf-8 -*-

module Agharta
  module Recipes
    module Handlers
      class Handler
        include Configuration

        def initialize(context, *args, &block)
          # do something...
        end

        def call(status)
          # do something...
        end
      end
    end
  end
end
