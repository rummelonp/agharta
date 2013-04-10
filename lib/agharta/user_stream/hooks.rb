# -*- coding: utf-8 -*-

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

      def keyword(*args, &block)
        add_hook(Keyword.new(self, *args, &block))
      end

      def user(*args, &block)
        add_hook(User.new(self, *args, &block))
      end

      def event(*args, &block)
        add_hook(Event.new(self, *args, &block))
      end
    end
  end
end

require 'agharta/user_stream/hooks/hook'
require 'agharta/user_stream/hooks/keyword'
require 'agharta/user_stream/hooks/user'
require 'agharta/user_stream/hooks/event'
