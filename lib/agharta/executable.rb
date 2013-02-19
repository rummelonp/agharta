# -*- coding: utf-8 -*-

module Agharta
  module Executable
    EXIT_SIGNALS = {
      :INT  => 'Interrupted',
      :TERM => 'Terminated',
      :QUIT => 'Quitted',
    }.freeze

    def executables
      @executables ||= []
    end

    def executable(executable)
      executables << executable
      executable
    end

    def trap
      EXIT_SIGNALS.each do |signal, desc|
        Signal.trap(signal) do
          receive_signal(signal, desc)
        end
      end
    end

    def receive_signal(signal, desc)
      if respond_to?(:logger)
        logger.info desc
      end
      exit
    end
  end
end
