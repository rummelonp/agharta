# -*- coding: utf-8 -*-

require 'tweetstream'

module Agharta
  module UserStream
    class Client
      include Executable
      include Context
      include Configuration
      include Hooks

      def initialize(context, options = {}, &block)
        @context = context
        set(@context.options)
        params.merge!(options)
        instance_eval(&block) if block_given?
      end

      def log_path
        @log_path ||= env.build_log_path("#{@context.name}.log")
      end

      def logger
        @logger ||= MultiLogger.new($stdout, log_path).tap { |l| l.progname = name }
      end

      def params
        @params ||= {}
      end

      def hooks
        @hooks ||= []
      end

      def current_user
        @current_user ||= Twitter::Client.new(credentials).verify_credentials
      end

      private
      def invoke(status)
        hooks.each do |hook|
          begin
            hook.call(status)
          rescue
            logger.error "#{$!.class}: #{$!.message}"
          end
        end
      end

      def connection
        connection = TweetStream::Client.new(credentials)
        connection.on_anything(&method(:on_anything))
        connection.on_error(&method(:on_error))
        connection.on_unauthorized(&method(:on_unauthorized))
        connection.on_reconnect(&method(:on_reconnect))
        connection.on_no_data_received(&method(:on_no_data_received))
        connection
      end

      def on_anything(status)
        invoke(status)
      end

      def on_error(message)
        logger.error message
      end

      def on_unauthorized
        logger.error 'Unuahtorized'
      end

      def on_reconnect(timeout, retries)
        logger.error "Reconnect: timeout/#{timeout}, retries/#{retries}"
      end

      def on_no_data_received
        logger.info "No Data Received"
      end
    end
  end
end
