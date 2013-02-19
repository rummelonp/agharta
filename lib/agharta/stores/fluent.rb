# -*- coding: utf-8 -*-

module Agharta
  module Stores
    class Fluent
      Stores.register :fluent, self

      def initialize(context, *args, &block)
        begin
          require 'fluent-logger'
        rescue LoadError
          raise LoadError, 'Please install "fluent-logger" gem'
        end
        tag_prefix = args.shift || 'agharta'
        @logger = ::Fluent::Logger::FluentLogger.new(tag_prefix, *args)
      end

      def call(status, options = {})
        tag = options[:type] || 'status'
        @logger.post(tag, status)
      end
    end
  end
end
