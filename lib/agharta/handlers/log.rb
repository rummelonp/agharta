# -*- coding: utf-8 -*-

require 'logger'

module Agharta
  module Handlers
    class Log < Handler
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
        @logger.info "#{time} #{data[:title]}: #{data[:message]}"
      end
    end
  end
end
