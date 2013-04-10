# -*- coding: utf-8 -*-

module Agharta
  class Recipe
    include Executable
    include Configuration
    include UserStream

    attr_reader :name

    def initialize(name = caller.first.split(':').first)
      @name = name
    end

    def pids
      @pids ||= []
    end

    def execute
      executables.each do |executable|
        pids << Process.fork do
          executable.trap
          executable.execute
        end
      end
      trap
      Process.waitall
    end

    def receive_exit_signal(signal, desc)
      pids.each { |pid| Process.kill(signal, pid) }
      pids.clear
      $stderr.puts desc
    end
  end
end
