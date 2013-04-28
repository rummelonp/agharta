# -*- coding: utf-8 -*-

module Agharta
  module StatusFormatter
    # Return list of formatter classes
    #
    # @return [Array<Class>]
    def self.mappings
      @mappings ||= {}
    end

    # Register formatter
    #
    # @param formatter_name [Symbol]
    # @param klass [Class]
    # @return [Class]
    def self.register(formatter_name, klass)
      mappings[formatter_name.to_sym] = klass
    end

    # Return formatted string from given status
    #
    # @param status [Hash]
    # @param options [Hash]
    # @option options [Symbol] :type (nil)
    def self.call(status, options = {})
      type = (options[:type] || :default).to_sym
      formatter = mappings[type]
      formatter.call(status, options)
    end

    module Helper
      # @param status [Hash]
      # @return [String]
      def self.status_text_with_source(status)
        "#{status[:text]} from #{status[:source].gsub(/<\/?[^>]*>/, '')}"
      end
    end

    module Default
      StatusFormatter.register :default, self
      StatusFormatter.register :user, self

      # @param status [Hash]
      # @param options [Hash]
      # @return [String]
      def self.call(status, options)
        if status[:text] && status[:user]
          {
            :title => "@#{status[:user][:screen_name]} Say",
            :message => Helper.status_text_with_source(status),
          }
        else
          {
            :title => 'Not format supportted status',
            :message => status.inspect,
          }
        end
      end
    end

    module Keyword
      StatusFormatter.register :keyword, self

      # @param status [Hash]
      # @param options [Hash]
      # @return [String]
      def self.call(status, options)
        {
          :title => "@#{status[:user][:screen_name]} Say \"#{options[:keyword]}\"",
          :message => Helper.status_text_with_source(status),
        }
      end
    end

    module Event
      StatusFormatter.register :event, self

      # @param status [Hash]
      # @param options [Hash]
      # @return [String]
      def self.call(status, options)
        event = options[:event]
        if respond_to?(event)
          send(event, status, options)
        else
          {
            :title => "Not format supported event \"#{event}\"",
            :message => status.inspect,
          }
        end
      end

      # @param status [Hash]
      # @param options [Hash]
      # @return [String]
      def self.reply(status, options)
        {
          :title => "@#{status[:user][:screen_name]} mentioned",
          :message => Helper.status_text_with_source(status),
        }
      end

      # @param status [Hash]
      # @param options [Hash]
      # @return [String]
      def self.retweet(status, options)
        {
          :title => "@#{status[:user][:screen_name]} retweeted",
          :message => Helper.status_text_with_source(status[:retweeted_status]),
        }
      end

      # @param status [Hash]
      # @param options [Hash]
      # @return [String]
      def self.direct_message(status, options)
        {
          :title => "@#{status[:direct_message][:sender_screen_name]} sent @#{status[:direct_message][:recipient_screen_name]} a message",
          :message => status[:direct_message][:text],
        }
      end

      # @param status [Hash]
      # @param options [Hash]
      # @return [String]
      def self.favorite(status, options)
        {
          :title => "@#{status[:source][:screen_name]} favorited",
          :message => status[:target_object][:text],
        }
      end

      # @param status [Hash]
      # @param options [Hash]
      # @return [String]
      def self.unfavorite(status, options)
        {
          :title => "@#{status[:source][:screen_name]} unfavorited",
          :message => status[:target_object][:text],
        }
      end

      # @param status [Hash]
      # @param options [Hash]
      # @return [String]
      def self.follow(status, options)
        {
          :title => "@#{status[:source][:screen_name]} followed",
          :message => "@#{status[:target][:screen_name]}",
        }
      end

      # @param status [Hash]
      # @param options [Hash]
      # @return [String]
      def self.list_member_added(status, options)
        {
          :title => "@#{status[:source][:screen_name]} added to the list",
          :message => status[:target_object][:full_name],
        }
      end

      # @param status [Hash]
      # @param options [Hash]
      # @return [String]
      def self.list_member_removed(status, options)
        {
          :title => "@#{status[:source][:screen_name]} removed from the list",
          :message => status[:target_object][:full_name],
        }
      end

      # @param status [Hash]
      # @param options [Hash]
      # @return [String]
      def self.list_user_subscribed(status, options)
        {
          :title => "@#{status[:source][:screen_name]} subscribed to your list",
          :message => status[:target_object][:full_name],
        }
      end

      # @param status [Hash]
      # @param options [Hash]
      # @return [String]
      def self.list_user_unsubscribed(status, options)
        {
          :title => "@#{status[:source][:screen_name]} unsubscribed to your list",
          :message => status[:target_object][:full_name],
        }
      end
    end
  end
end
