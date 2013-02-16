# -*- coding: utf-8 -*-

module Agharta
  module Handlers
    module Notify
      def self.new(context, *args, &block)
        notify_name = args.shift
        Notifies.find(notify_name).new(context, *args, &block)
      end
    end
  end
end
