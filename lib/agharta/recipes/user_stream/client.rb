# -*- coding: utf-8 -*-

require 'logger'
require 'tweetstream'

module Agharta
  module Recipes
    module UserStream
      class Client
        attr_accessor :consumer_key
        attr_accessor :consumer_secret
        attr_accessor :oauth_token
        attr_accessor :oauth_token_secret

        def self.start(&block)
          client = new(&block)
          Process.fork { client.start } if block_given?
          client
        end

        def initialize(&block)
          instance_eval(&block) if block_given?
        end

        def set(*args)
          if args.first.is_a?(Hash)
            args.first.each do |k, v|
              send("#{k}=", v)
            end
          else
            key, value = *args
            send("#{key}=", value)
          end
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
        def credentials
          {
            :consumer_key       => consumer_key,
            :consumer_secret    => consumer_secret,
            :oauth_token        => oauth_token,
            :oauth_token_secret => oauth_token_secret,
          }
        end

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
