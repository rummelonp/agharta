# -*- coding: utf-8 -*-

module Agharta
  module Stores
    class FluentLogger
      Stores.register :fluent, self

      def initialize(context, *args, &block)
        begin
          require 'fluent-logger'
        rescue LoadError
          raise LoadError, 'Please install "fluent-logger" gem'
        end
        tag_prefix = args.first.is_a?(String) ? args.first : 'agharta'
        options = args.last.is_a?(Hash) ? args.last : {}
        @logger = Fluent::Logger.new(Fluent::Logger::FluentLogger, tag_prefix, options)
      end

      def call(status, options)
        tag = options[:type] || 'status'
        @logger.post(tag, status)
      end
    end
  end
end
