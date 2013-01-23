# -*- coding: utf-8 -*-

require 'logger'
require 'tweetstream'

module Agharta
  module Recipes
    module UserStream
      class Client
        include Configuration

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

        def loggers
          @loggers ||= []
        end

        def log(log)
          loggers << Logger.new(log)
        end

        def start
          raise NotImplementedError
        end

        private
        def tweetstream
          TweetStream::Client.new(credentials)
        end

        def on_status(status)
          loggers.each do |logger|
            next unless status.user
            logger.info [
              status.created_at,
              status.user.screen_name,
              status.text,
            ].join(' ')
          end
        end
      end
    end
  end
end
