# -*- coding: utf-8 -*-

require 'agharta/stores'

module Agharta
  module Handlers
    module Store
      def self.new(context, *args, &block)
        store_name = args.shift
        Stores.find(store_name).new(context, *args, &block)
      end
    end
  end
end
