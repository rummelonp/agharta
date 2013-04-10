# -*- coding: utf-8 -*-

require 'agharta/user_stream/hooks/hook'

module Agharta
  module UserStream
    module Hooks
      class Event < Hook
        EVENT_NAMES = [
          :reply,
          :retweet,
          :direct_message,
          :block,
          :unblock,
          :favorite,
          :unfavorite,
          :follow,
          :unfollow,
          :list_created,
          :list_destroyed,
          :list_updated,
          :list_member_added,
          :list_member_removed,
          :list_user_subscribed,
          :list_user_unsubscribed,
          :user_update,
        ].freeze

        def initialize(context, *args, &block)
          options = args.last.is_a?(Hash) ? args.pop : {}
          validate!(args)
          @on = args
          @all = options.fetch(:all, false)
          @ignore_self = options.fetch(:ignore_self, false)
          super
        end

        def call(status)
          event = nil
          if status[:event]
            return if @ignore_self && current_user?(status[:source][:screen_name])
            event = status[:event].to_sym
          elsif current_user?(status[:in_reply_to_screen_name])
            return if @ignore_self && current_user?(status[:user][:screen_name])
            event = :reply
          elsif status[:retweeted_status]
            return unless current_user?(status[:retweeted_status][:user][:screen_name])
            event = :retweet
          elsif status[:direct_message]
            return if @ignore_self && current_user?(status[:direct_message][:sender_screen_name])
            event = :direct_message
          else
            return
          end
          if @all || @on.include?(event)
            invoke(status, :type => :event, :event => event)
          end
        end

        def on(*events)
          validate!(events)
          @on.concat(events)
        end

        def all!
          @all = true
        end

        def ignore_self!
          @ignore_self = true
        end

        private
        def validate!(events)
          events.each do |event|
            unless EVENT_NAMES.include?(event)
              raise ArgumentError, "No such event \"#{event}\""
            end
          end
        end
      end
    end
  end
end
