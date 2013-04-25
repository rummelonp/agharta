# -*- coding: utf-8 -*-

require 'agharta/handleable'

module Agharta
  module Stores
    class Fluent < Handleable
      Stores.register :fluent, self

      # @raise [Agharta::ConfigurationError] Error raised when configuration is not enough
      # @overload initialize(context, tag_prefix)
      #   @param context [Agharta::Context]
      #   @param tag_prefix [String]
      def initialize(context, *args, &block)
        begin
          require 'fluent-logger'
        rescue LoadError
          raise LoadError, 'Please install "fluent-logger" gem'
        end
        tag_prefix = args.shift || 'agharta'
        @logger = ::Fluent::Logger::FluentLogger.new(tag_prefix, *args)
      end

      # Sent status to fluentd
      #
      # @override
      # @param status [Hash]
      # @param options [Hash]
      def call(status, options = {})
        tag = options[:type] || 'status'
        @logger.post(tag, status)
      end
    end
  end
end
