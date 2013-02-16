# -*- coding: utf-8 -*-

module Agharta
  module UserStream
    module Hooks
      class Event < Hook
        EVENT_NAMES = [
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
          @ignore_self = options.fetch(:ignore_self, false)
          super
        end

        # TODO: implement reply
        # TODO: implement ifnore self
        def call(status)
          event = nil
          if status[:event]
            event = status[:event].to_sym
          elsif status[:direct_message]
            event = :direct_message
          elsif status[:retweeted_status]
            event = :retweet
          else
            return
          end
          return unless @on.include?(event)
          invoke(status, :type => :event, :event => event)
        end

        def on(*events)
          validate!(events)
          @on.concat(events)
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
