# -*- coding: utf-8 -*-

require 'agharta/context'

module Agharta
  # @abstract Include this module when to create executable class
  module Executable
    include Context

    # @private
    RELOAD_SIGNALS = {
      :HUP => 'Reload',
    }.freeze

    # @private
    EXIT_SIGNALS = {
      :INT  => 'Interrupted',
      :TERM => 'Terminated',
      :QUIT => 'Quitted',
    }.freeze

    # @abstract Should override
    def execute
      raise NotImplementedError, 'Should override'
    end

    # Set up exit & reload signal handlers
    def trap
      EXIT_SIGNALS.each do |signal, desc|
        Signal.trap(signal) do
          Thread.start { receive_exit_signal(signal, desc) }.join
        end
      end
      RELOAD_SIGNALS.each do |signal, desc|
        Signal.trap(signal) do
          Thread.start { receive_reload_signal(signal, desc) }.join
        end
      end
    end

    # Call when receive reload signal.
    #   By default, do nothing.
    #
    # @abstract Override if need
    # @param signal [Symbol]
    # @param desc [String]
    def receive_reload_signal(signal, desc)
    end

    # Call when receive exit signal.
    #   By default, exit this process.
    #
    # @abstract Override if need
    # @param signal [Symbol]
    # @param desc [String]
    def receive_exit_signal(signal, desc)
      if respond_to?(:logger)
        logger.info desc
      end
      exit
    end
  end
end
