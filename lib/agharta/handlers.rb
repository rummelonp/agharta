# -*- coding: utf-8 -*-

require 'agharta/handlers/log'
require 'agharta/handlers/notify'
require 'agharta/handlers/store'

module Agharta
  module Handlers
    # Return list of handler objects
    #
    # @return [Array<Agharta::Handleable>]
    def handlers
      @handlers ||= []
    end

    # Add handler object to list
    #
    # @param handler [Agharta::Handleable]
    # @return [Agharta::Handleable]
    def add_handler(handler)
      handlers << handler
      handler
    end

    # Add log handler to list
    #
    # @see Agharta::Handlers::Log
    # @overload log(log_name, options = {})
    #   @param log_name [string] Log file name
    #   @param options [Hash] Optional hash to give to logger
    #   @option options [Integer, Symbol, String] :shift_age (nil)
    #   @option options [Integer] :shift_size (nil)
    #   @return [Agharta::Handleable]
    #   @example Log status to "my.log" when invoke hook
    #     hook.log('my.log', :shift_age => 0, :shift_size => 1048576)
    def log(*args, &block)
      add_handler(Log.new(self, *args, &block))
    end

    # Add notify handler to list
    #
    # @see Agharta::Handlers::Notify
    # @see Agharta::Notifies
    # @raise [ArgumentError] Error raised when notify class not found
    # @overload notify(notify_name, options = {})
    #   @param notify_name [Symbol] Notify adapter name
    #   @param options [Hash] Optional hash to give to notify adapter class
    #   @return [Agharta::Handleable]
    #   @example Push notification to im.kayac.com with given configuration when invoke hook
    #     recipe.notify(:im_kakac, {:username => 'mitukiii', :password => 'my_password', :linker => :tweetbot})
    #   @example Push notification to Prowl with given configuration when invoke hook
    #     recipe.notify(:prowl, :apikey => 'my_apikey', :linker => :tweetbot)
    def notify(*args, &block)
      add_handler(Notify.new(self, *args, &block))
    end

    # Add store handler to list
    #
    # @see Agharta::Handlers::Store
    # @see Agharta::Stores
    # @raise [ArgumentError] Error raised when store class not found
    # @overload store(store_name, options = {})
    #   @param store_name [Symbol] Store adapter name
    #   @param options [Hash] Optional hash to give to store adapter class
    #   @return [Agharta::Handleable]
    #   @example Log status by fluentd when invoke hook
    #     hook.store(:fluent, 'my_tag_prefix')
    def store(*args, &block)
      add_handler(Store.new(self, *args, &block))
    end
  end
end
