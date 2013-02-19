# -*- coding: utf-8 -*-

module Agharta
  module Configuration
    OPTIONS_KEY = [
      :consumer_key,
      :consumer_secret,
      :oauth_token,
      :oauth_token_secret,
    ].freeze

    attr_accessor *OPTIONS_KEY

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

    def options
      options = {}
      OPTIONS_KEY.each do |key|
        options[key] = send(key)
      end
      options
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
      users = env.config[:twitter] || {}
      screen_name = users[:default]
      clean_options(users[screen_name] || {})
    end

    def set_credentials(screen_name)
      set(
        if screen_name == :default
          default_credentials
        else
          users = env.config[:twitter] || {}
          clean_options(users[screen_name] || {})
        end
      )
    end

    private
    def clean_options(options)
      clean_options = {}
      options.each do |key, value|
        clean_options[key] = value if respond_to?("#{key}=")
      end
      clean_options
    end
  end
end
