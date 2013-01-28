# -*- coding: utf-8 -*-

require 'logger'
require 'tweetstream'

module Agharta
  module UserStream
    class Client
      include Configuration
      include Handlers
      include Hooks

      def self.start(context, &block)
        client = new(context, &block)
        Process.fork { client.start } if block_given?
        client
      end

      def initialize(context, &block)
        @context = context
        set(@context.options)
        instance_eval(&block) if block_given?
      end

      def params
        @params ||= {}
      end

      def hooks
        @hooks ||= []
      end

      def start
        raise NotImplementedError
      end

      private
      def tweetstream
        TweetStream::Client.new(credentials)
      end

      def on_status(status)
        hooks.each { |h| h.call(status) }
      end
    end
  end
end
