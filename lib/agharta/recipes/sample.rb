# -*- coding: utf-8 -*-

require 'logger'
require 'tweetstream'

module Agharta
  module Recipes
    module Sample
      Recipes.register self

      def sample(&block)
        if block_given?
          Process.fork do
            Client.new(&block).run!
          end
        else
          Client.new
        end
      end

      class Client
        attr_accessor :consumer_key
        attr_accessor :consumer_secret
        attr_accessor :oauth_token
        attr_accessor :oauth_token_secret

        def initialize(&block)
          instance_eval(&block) if block_given?
        end

        def set(key, value)
          send("#{key}=", value)
        end

        def loggers
          @loggers ||= []
        end

        def log(log)
          loggers << Logger.new(log)
        end

        def client
          TweetStream::Client.new(credentials)
        end

        def run!
          client.sample do |status|
            loggers.each do |logger|
              if status.user
                logger.info [
                  status.created_at,
                  status.user.screen_name,
                  status.text,
                ].join(' ')
              end
            end
          end
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
      end
    end
  end
end
