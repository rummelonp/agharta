# -*- coding: utf-8 -*-

module Agharta
  # @todo Refactor
  # @abstract Include this module when to create executable class
  module Executable
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

    # Return list of executable objects
    #
    # @return [Array<Agharta::Executable>]
    def executables
      @executables ||= []
    end

    # Add executable object to list
    #
    # @param executable [Agharta::Executable]
    # @return [Agharta::Executable]
    def add_executable(executable)
      executables << executable
      executable
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
