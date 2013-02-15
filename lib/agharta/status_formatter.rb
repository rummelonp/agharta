
module Agharta
  module StatusFormatter
    def self.mappings
      @mappings ||= {}
    end

    def self.register(formatter_name, klass)
      mappings[formatter_name.to_s] = klass
    end

    def self.call(status, options = {})
      type = options[:type].to_s
      formatter = mappings[type] || mappings['default']
      formatter.call(status, options)
    end

    status_message = lambda do |status|
      "#{status[:text]} from #{status[:source].gsub(/<\/?[^>]*>/, '')}"
    end

    status_formatter = lambda do |status, options|
      {
        :title => "@#{status[:user][:screen_name]} Say",
        :message => status_message.(status),
      }
    end

    register :default, status_formatter

    register :user, status_formatter

    register :keyword, lambda { |status, options|
      {
        :title => "@#{status[:user][:screen_name]} Say \"#{options[:keyword]}\"",
        :message => status_message.(status),
      }
    }

    register :event, lambda { |status, options|
      event = options[:event].to_s
      formatter = mappings[event]
      if formatter
        formatter.call(status, options)
      else
        message = "Not Supported Event \"#{event}\""
        {
          :title => message,
          :message => message,
        }
      end
    }

    register :reply, lambda { |status, options|
      {
        :title => "@#{status[:user][:screen_name]} Mentioned",
        :message => status_message.(status),
      }
    }

    register :retweet, lambda { |status, options|
      {
        :title => "@#{status[:user][:screen_name]} Retweeted",
        :message => status_message.(status[:retweeted_status]),
      }
    }

    register :direct_message, lambda { |status, options|
      {
        :title => "@#{status[:direct_message][:sender][:screen_name]} Sent message",
        :message => status[:direct_message][:text],
      }
    }

    register :favorite, lambda { |status, options|
      {
        :title => "@#{status[:source][:screen_name]} Favorited",
        :message => status[:target_object][:text],
      }
    }

    register :unfavorite, lambda { |status, options|
      {
        :title => "@#{status[:source][:screen_name]} Unfavorited",
        :message => status[:target_object][:text],
      }
    }

    register :follow, lambda { |status, options|
      {
        :title => "@#{status[:source][:screen_name]} Followed",
        :message => "@#{status[:target][:screen_name]}",
      }
    }

    register :list_member_added, lambda { |status, options|
      {
        :title => "@#{status[:source][:screen_name]} Added to list",
        :message => status[:target_object][:full_name],
      }
    }

    register :list_member_removed, lambda { |status, options|
      {
        :title => "@#{status[:source][:screen_name]} Removed from list",
        :message => status[:target_object][:full_name],
      }
    }

    register :list_user_subscribed, lambda { |status, options|
      {
        :title => "@#{status[:source][:screen_name]} Subscribed list",
        :message => status[:target_object][:full_name],
      }
    }

    register :list_user_unsubscribed, lambda { |status, options|
      {
        :title => "@#{status[:source][:screen_name]} Unsubscribed list",
        :message => status[:target_object][:full_name],
      }
    }
  end
end
