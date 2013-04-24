# -*- coding: utf-8 -*-

module Agharta
  module Linker
    # Return list of linker classes
    #
    # @return [Array<Class>]
    def self.mappings
      @mappings ||= {}
    end

    # Register linker
    #
    # @param linker_name [Symbol]
    # @param klass [Class]
    # @return [Class]
    def self.register(linker_name, klass)
      mappings[linker_name.to_sym] = klass
    end

    # Find linker from given name
    #
    # @param linker_name [Symbol]
    # @return [Class]
    def self.find(linker_name)
      mappings[linker_name.to_s.to_sym] || NoLinker
    end

    class NoLinker
      # @param context [Agharta::Context]
      def initialize(context)
      end

      # Do nothing
      #
      # @param status [Hash]
      # @param options [Hash]
      # @return [nil]
      def call(status, options)
        nil
      end
    end

    class Tweetbot
      Linker.register :tweetbot, self

      # @param context [Agharta::Context]
      def initialize(context)
        @context = context
      end

      # Return tweetbot uri from given status
      #
      # @param status [Hash]
      # @param options [Hash]
      # @return [String]
      # @return [nil] If not support status
      def call(status, options)
        case (options[:type] || :default).to_sym
        when :user, :keyword, :default
          tweet(status[:id])
        when :event
          case options[:event]
          when :reply
            mentions
          when :retweet
            profile(status[:user][:screen_name])
          when :direct_message
            direct_messages
          when :favorite, :unfavorite, :follow, :list_member_added, :list_member_removed, :list_user_subscribed, :list_user_unsubscribed
            profile(status[:source][:screen_name])
          end
        end
      end

      # Return status uri
      #
      # @param status_id [Integer]
      # @return [String]
      def tweet(status_id)
        "tweetbot://#{current_user_name}/status/#{status_id}"
      end

      # Return mentions uri
      #
      # @return [String]
      def mentions
        "tweetbot://#{current_user_name}/mentions"
      end

      # Return direct messages uri
      #
      # @return [String]
      def direct_messages
        "tweetbot://#{current_user_name}/direct_messages"
      end

      # Return profile uri
      #
      # @param screen_name [String]
      # @return [String]
      def profile(screen_name)
        "tweetbot://#{current_user_name}/user_profile/#{screen_name}"
      end

      # Return list uri
      #
      # @param list_id [Integer]
      # @return [String]
      def list(list_id)
        "tweetbot://#{current_user_name}/list/#{list_id}"
      end

      private
      def current_user_name
        @context.current_user[:screen_name]
      end
    end
  end
end
