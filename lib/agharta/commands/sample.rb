# -*- coding: utf-8 -*-

require 'logger'
require 'userstream'

module Agharta
  module Commands
    module Sample
      Agharta::Commands.register self

      def sample(&block)
        Process.fork do
          Sample::Client.new(&block).run!
        end
      end

      class Client
        attr_accessor :consumer_key
        attr_accessor :consumer_secret
        attr_accessor :oauth_token
        attr_accessor :oauth_token_secret

        def initialize(&block)
          instance_eval(&block)
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
          UserStream::Client.new(credentials)
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
