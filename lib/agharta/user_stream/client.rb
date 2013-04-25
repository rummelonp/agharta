# -*- coding: utf-8 -*-

require 'agharta/configuration'
require 'agharta/context'
require 'agharta/executable'
require 'agharta/hooks'
require 'agharta/multi_logger'
require 'tweetstream'
require 'twitter'

module Agharta
  module UserStream
    # @abstract UserStream client base class
    class Client
      include Configuration
      include Context
      include Executable
      include Hooks

      # @param context [Agharta::Context]
      # @param options [Hash] hash to use to parameter
      def initialize(context, options = {}, &block)
        @context = context
        set(@context.options)
        params.merge!(options)
        instance_eval(&block) if block_given?
      end

      # Return log path of this stream
      #
      # @return [String]
      def log_path
        @log_path ||= env.build_log_path("#{@context.name}.log")
      end

      # Return logger of this stream
      #
      # @return [Agharta::MultiLogger]
      def logger
        @logger ||= MultiLogger.new($stdout, log_path).tap { |l| l.progname = name }
      end

      # Return parameter to use to streaming API
      #
      # @return [Hash]
      def params
        @params ||= {}
      end

      # Return current user credentials
      #
      # @override
      # @return [Hash]
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
