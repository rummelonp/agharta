# -*- coding: utf-8 -*-

module Agharta
  module Recipes
    module Configuration
      Recipes.register self

      attr_accessor :consumer_key
      attr_accessor :consumer_secret
      attr_accessor :oauth_token
      attr_accessor :oauth_token_secret

      def env
        @env ||= Environment.instance
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

      def credentials(screen_name = nil)
        if screen_name.nil?
          if build_credentials.values.compact.empty?
            default_credentials
          else
            build_credentials
          end
        else
          set_credentials(screen_name)
        end
      end

      def build_credentials
        {
          :consumer_key       => consumer_key,
          :consumer_secret    => consumer_secret,
          :oauth_token        => oauth_token,
          :oauth_token_secret => oauth_token_secret,
        }
      end

      def default_credentials
        users = env.config[:twitter]
        screen_name = users[:default]
        credentials = users[screen_name] || {}
        credentials.select { |k, v| respond_to?("#{k}=") }
      end

      def set_credentials(screen_name)
        credentials = (
          if screen_name == :default
            default_credentials
          else
            env.config[:twitter][screen_name]
          end
        ).select { |k, v| respond_to?("#{k}=") }
        set(credentials)
      end
    end
  end
end
