# -*- coding: utf-8 -*-

module Agharta
  module UserStream
    module Hooks
      class Hook
        include Handlers

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
