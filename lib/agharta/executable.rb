# -*- coding: utf-8 -*-

module Agharta
  module Executable
    RELOAD_SIGNALS = {
      :HUP => 'Reload',
    }.freeze

    EXIT_SIGNALS = {
      :INT  => 'Interrupted',
      :TERM => 'Terminated',
      :QUIT => 'Quitted',
    }.freeze

    def executables
      @executables ||= []
    end

    def add_executable(executable)
      executables << executable
      executable
    end

    def trap
      EXIT_SIGNALS.each do |signal, desc|
        Signal.trap(signal) do
          receive_exit_signal(signal, desc)
        end
      end
      RELOAD_SIGNALS.each do |signal, desc|
        Signal.trap(signal) do
          receive_reload_signal(signal, desc)
        end
      end
    end

    def receive_reload_signal(signal, desc)
    end

    def receive_exit_signal(signal, desc)
      if respond_to?(:logger)
        logger.info desc
      end
      exit
    end
  end
end
