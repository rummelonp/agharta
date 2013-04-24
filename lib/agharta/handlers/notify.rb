# -*- coding: utf-8 -*-

require 'agharta/notifies'

module Agharta
  module Handlers
    # Return notify handler from given notify name
    #
    # @see Agharta::Notifies
    # @raise [ArgumentError] Error raised when notify class not found
    # @overload new(context, notify_name, options = {}, &block)
    #   @param context [Agharta::Context]
    #   @param notify_name [Symbol] Notify adapter name
    #   @param options [Hash] Optional hash to give to notify adapter class
    #   @return [Object]
    module Notify
      def self.new(context, *args, &block)
        notify_name = args.shift
        Notifies.find(notify_name).new(context, *args, &block)
      end
    end
  end
end
