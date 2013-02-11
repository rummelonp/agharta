# -*- coding: utf-8 -*-

module Agharta
  module UserStream
    module Hooks
      class Event < Hook
        def initialize(context, *args, &block)
          options = args.last.is_a?(Hash) ? args.pop : {}
          @on          = options.fetch(:on,          [])
          @ignore_self = options.fetch(:ignore_self, false)
          instance_eval &block if block_given?
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
          options = {
            :type => :event,
            :event => event
          }
          handlers.each { |h| h.call(status, options) }
        end

        def on(*events)
          @on.concat(events)
        end

        def ignore_self!
          @ignore_self = true
        end
      end
    end
  end
end
