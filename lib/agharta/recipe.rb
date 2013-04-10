# -*- coding: utf-8 -*-

require 'agharta/configuration'
require 'agharta/core_ext'
require 'agharta/executable'
require 'agharta/user_stream'

module Agharta
  class Recipe
    include Configuration
    include Executable
    include UserStream

    attr_reader :name

    def initialize(name = caller.first.split(':').first, &block)
      @name = name
      instance_eval(&block) if block_given?
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
