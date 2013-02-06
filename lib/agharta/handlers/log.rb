# -*- coding: utf-8 -*-

require 'logger'

module Agharta
  module Handlers
    class Log < Handler
      def initialize(context, *args, &block)
        device = args.first
        device = context.env.build_data_path(device) unless device.is_a?(IO)
        options = args.last.is_a?(Hash) ? args.last : {}
        shift_age = options.fetch(:shift_age, 0)
        shift_size = options.fetch(:shift_size, 1048576)
        @logger = Logger.new(device, shift_age, shift_size)
        @logger.progname = context.name
      end

      # TODO: format
      def call(status, options = {})
        if status[:user] && status[:text]
          @logger.info status[:user][:screen_name] + ' ' + status[:text]
        end
      end
    end
  end
end
