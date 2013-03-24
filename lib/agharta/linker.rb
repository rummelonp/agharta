# -*- coding: utf-8 -*-

module Agharta
  module Notifies
    module Linker
      def self.mappings
        @mappings ||= {}
      end

      def self.register(linker_name, klass)
        mappings[linker_name.to_sym] = klass
      end

      def self.find(linker_name)
        mappings[linker_name.to_s.to_sym] || NoLinker
      end

      class NoLinker
        def initialize(context)
        end

        def call(status, options)
          nil
        end
      end

      class Tweetbot
        Linker.register :tweetbot, self

        def initialize(context)
          @context = context
        end

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

        def tweet(status_id)
          "tweetbot://#{current_user_name}/status/#{status_id}"
        end

        def mentions
          "tweetbot://#{current_user_name}/mentions"
        end

        def direct_messages
          "tweetbot://#{current_user_name}/direct_messages"
        end

        def profile(screen_name)
          "tweetbot://#{current_user_name}/user_profile/#{screen_name}"
        end

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
end
