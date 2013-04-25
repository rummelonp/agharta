# -*- coding: utf-8 -*-

require 'agharta/stores'

module Agharta
  module Handlers
    # Return store handler from given notify name
    #
    # @see Agharta::Stores
    # @raise [ArgumentError] Error raised when store class not found
    # @overload new(context, store_name, options = {}, &block)
    #   @param context [Agharta::Context]
    #   @param notify_name [Symbol] Store adapter name
    #   @param options [Hash] Optional hash to give to store adapter class
    #   @return [Agharta::Handleable]
    module Store
      def self.new(context, *args, &block)
        store_name = args.shift
        Stores.find(store_name).new(context, *args, &block)
      end
    end
  end
end
