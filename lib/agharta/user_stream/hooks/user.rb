# -*- coding: utf-8 -*-

module Agharta
  module UserStream
    module Hooks
      class User < Hook
        def initialize(context, *args, &block)
          options = args.last.is_a?(Hash) ? args.pop : {}
          @include = args
          @all = options.fetch(:all, false)
          super
        end

        def call(status)
          return unless status[:text]
          return unless status[:user]
          user = status[:user][:screen_name]
          if @all || @include.flatten.any? { |u| user == u }
            invoke(status, :type => :user, :user => user)
          end
        end

        def include(*keywords)
          @include.concat(keywords)
        end

        def all!
          @all = true
        end
      end
    end
  end
end
