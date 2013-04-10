# -*- coding: utf-8 -*-

require 'agharta/user_stream/hooks/event'
require 'agharta/user_stream/hooks/keyword'
require 'agharta/user_stream/hooks/user'

module Agharta
  module UserStream
    module Hooks
      def hooks
        @hooks ||= []
      end

      def add_hook(hook)
        hooks << hook
        hook
      end

      def event(*args, &block)
        add_hook(Event.new(self, *args, &block))
      end

      def keyword(*args, &block)
        add_hook(Keyword.new(self, *args, &block))
      end

      def user(*args, &block)
        add_hook(User.new(self, *args, &block))
      end
    end
  end
end
