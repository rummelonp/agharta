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

    # Return recipe name
    #
    # @return [String]
    attr_reader :name

    # @param name [String]
    def initialize(name = caller.first.split(':').first, &block)
      @name = name
      instance_eval(&block) if block_given?
    end

    # Return list of pid
    #
    # @return [Array<Integer>]
    def pids
      @pids ||= []
    end

    # Execute this recipe
    #
    # @override
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

    # Send kill signal to all pid of executable objects
    #
    # @override
    def receive_exit_signal(signal, desc)
      pids.each { |pid| Process.kill(signal, pid) }
      pids.clear
      $stderr.puts desc
    end
  end
end
