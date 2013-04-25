# -*- coding: utf-8 -*-

require 'agharta/user_stream/hooks/hook'

module Agharta
  module UserStream
    module Hooks
      class User < Hook
        # @overload initialize(context, *includes, options = {})
        #   @param context [Agharta::Context]
        #   @param includes [Array<String>] Receive user screen names
        #   @param options [Hash]
        #   @option options [Boolean] :all (false) Receive all user statuses
        #   @option options [Boolean] :ignore_self (false) Ignore self statuses
        #   @yield [status, options] Add block to handler when arity greater than zero
        #   @yield Evaluate as event hook context when arity is zero
        #   @yieldparam [Hash] status
        #   @yieldparam [Hash] options
        def initialize(context, *args, &block)
          options = args.last.is_a?(Hash) ? args.pop : {}
          @include = args
          @all = options.fetch(:all, false)
          super
        end

        # Call when receive status.
        #   Invoke handlers if match conditions.
        #
        # @override
        # @param status [Hash]
        def call(status)
          return unless status[:text]
          return unless status[:user]
          user = status[:user][:screen_name]
          if @all || @include.flatten.any? { |u| user == u }
            invoke(status, :type => :user, :user => user)
          end
        end

        # Set it to receive user screen name
        #
        # @param keywords [Array<String>]
        def include(*keywords)
          @include.concat(keywords)
        end

        # Set to receive all event
        def all!
          @all = true
        end
      end
    end
  end
end
