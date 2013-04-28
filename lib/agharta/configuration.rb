# -*- coding: utf-8 -*-

require 'agharta/environment'

module Agharta
  module Configuration
    # @private
    OPTIONS_KEY = [
      :consumer_key,
      :consumer_secret,
      :oauth_token,
      :oauth_token_secret,
    ].freeze

    # @private
    attr_accessor *OPTIONS_KEY

    # @return [Agharta::Environment]
    def env
      @env ||= Environment.instance
    end

    # Set it to configuration
    #
    # @overload set(key, value)
    #   Given key and value
    #
    #   @param key [Symbol, String]
    #   @param value
    #   @example
    #     recipe.set(:consumer_key, 'consumer_key')
    # @overload set(options)
    #   Given hash
    #
    #   @param options [Hash]
    #   @return [Hash]
    #   @example
    #     recipe.set({:consumer_key => 'consumer_key'})
    def set(*args)
      if args.first.is_a?(Hash)
        args.first.each do |key, value|
          send("#{key}=", value)
        end
      else
        key, value = *args
        send("#{key}=", value)
      end
    end

    # Return current configuration
    #
    # @return [Hash]
    def options
      options = {}
      OPTIONS_KEY.each do |key|
        options[key] = send(key)
      end
      options
    end

    # When not given args & credentials not set, call {#default_credentials}.
    # When not given args & credentials have been set, call {#build_credentials}.
    # When given args, call {#set_credentials}.
    #
    # @return [Hash]
    # @overload credentials
    #   Return current credentials configuration
    #
    #   @see #default_credentials
    #   @see #build_credentials
    #   @example
    #      credentials = recipe.credentials
    # @overload credentials(screen_name)
    #   Set given user name credentials to configuration
    #
    #   @param screen_name [Symbol]
    #   @see #set_credentials
    #   @example
    #      recipe.credentials(:mitukiii)
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

    # Return current credentials configuration
    #
    # @return [Hash]
    def build_credentials
      {
        :consumer_key       => consumer_key,
        :consumer_secret    => consumer_secret,
        :oauth_token        => oauth_token,
        :oauth_token_secret => oauth_token_secret,
      }
    end

    # Return default credentials configuration
    #
    # @return [Hash]
    def default_credentials
      users = env.config[:twitter] || {}
      screen_name = users[:default]
      clean_options(users[screen_name] || {})
    end

    # Set given user name credentials to configuration.
    # When given symbol :default, set default credentials to configuration.
    #
    # @param screen_name [Symbol]
    # @return [Hash]
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
