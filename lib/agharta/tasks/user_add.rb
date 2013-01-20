# -*- coding: utf-8 -*-

require 'oauth'
require 'yaml'

module Agharta
  module Tasks
    class UserAdd < Thor::Group
      Tasks.register 'user:add', self

      def self.banner
        'agharta user:add'
      end

      include Actions

      desc 'add new user'

      def setup
        @config = env.config
        env.empty_directory(:root)
      end

      def user_add
        consumer_key    = ask 'Consumer Key:'
        consumer_secret = ask 'Consumer secret:'

        consumer = OAuth::Consumer.new(
          consumer_key,
          consumer_secret,
          :site => 'https://api.twitter.com'
        )
        request_token = consumer.get_request_token

        say request_token.authorize_url
        system 'open', request_token.authorize_url

        pin = ask 'PIN:'

        access_token = request_token.get_access_token(
          oauth_verifier: pin
        )

        credentials = {
          :consumer_key       => consumer_key,
          :consumer_secret    => consumer_secret,
          :oauth_token        => access_token.token,
          :oauth_token_secret => access_token.secret,
        }

        client = Twitter::Client.new(credentials)
        user = client.verify_credentials

        credentials[:id] = user.id
        @screen_name = user.screen_name.to_sym

        @config[:twitter] ||= {}
        @config[:twitter][:default] ||= @screen_name
        @config[:twitter][@screen_name] = credentials
      end

      def teardown
        YAML.dump(@config, open(env.config_path, 'w'))
        say "Add #{@screen_name}"
      end
    end
  end
end
