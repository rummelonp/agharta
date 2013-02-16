# -*- coding: utf-8 -*-

require 'logger'

module Agharta
  module Handlers
    class Log
      include Configuration

      def initialize(context, *args, &block)
        device = args.first
        device = env.build_data_path(device) unless device.is_a?(IO)
        options = args.last.is_a?(Hash) ? args.last : {}
        shift_age = options.fetch(:shift_age, 0)
        shift_size = options.fetch(:shift_size, 1048576)
        @logger = Logger.new(device, shift_age, shift_size)
        @logger.progname = context.name
        @logger.formatter = SimpleFormatter.new
      end

      def call(status, options = {})
        data = StatusFormatter.call(status, options)
        time = Time.now.strftime('[%m/%d %a] (%H:%M:%S)')
        message = "#{time} #{data[:title]}: #{data[:message]}"
        @logger.info message.colorize(/@[a-zA-Z0-9_]+/, :bright, :underline)
      end
    end
  end
end
