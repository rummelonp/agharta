# -*- coding: utf-8 -*-

require 'agharta/user_stream/hooks/hook'

module Agharta
  module UserStream
    module Hooks
      class Keyword < Hook
        # @overload initialize(context, *includes, options = {})
        #   @param context [Agharta::Context]
        #   @param includes [Array<String>] Receive keywords
        #   @param options [Hash]
        #   @option options [Array<String, Regexp>] :exclude ([]) Exclude keywords
        #   @option options [Boolean] :ignore_self (false) Ignore self statuses
        #   @yield [status, options] Add block to handler when arity greater than zero
        #   @yield Evaluate as event hook context when arity is zero
        #   @yieldparam [Hash] status
        #   @yieldparam [Hash] options
        def initialize(context, *args, &block)
          options = args.last.is_a?(Hash) ? args.pop : {}
          @include = args
          @exclude = options.fetch(:exclude, [])
          @ignore_self = options.fetch(:ignore_self, false)
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
          return if @ignore_self && current_user?(status[:user][:screen_name])
          return unless @include.flatten.any? { |k| status[:text].match(k) }
          keyword = $&.to_s
          return if @exclude.flatten.any? { |k| status[:text].match(k) }
          invoke(status, :type => :keyword, :keyword => keyword)
        end

        # Set it to receive keywords
        #
        # @param keywords [Array<String, Regexp>]
        def include(*keywords)
          @include.concat(keywords)
        end

        # Set it to exclude keywords
        #
        # @param keywords [Array<String, Regexp>]
        def exclude(*keywords)
          @exclude.concat(keywords)
        end

        # Set to ignore self statuses
        def ignore_self!
          @ignore_self = true
        end
      end
    end
  end
end
