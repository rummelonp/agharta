# -*- coding: utf-8 -*-

require 'agharta/recipe'

module Agharta
  class FileRecipe < Recipe
    # Return recipe path
    #
    # @return [String]
    attr_reader :path

    # Execute given path recipe
    #
    # @param recipe_path [String]
    def self.execute(recipe_path)
      new(recipe_path).execute
    end

    # @param recipe_path [String]
    def initialize(recipe_path)
      @name = File.basename(recipe_path)
      @path = recipe_path
    end

    # Execute this recipe
    #
    # @override
    def execute
      load
      super
    end

    # Send terminate signal to all pid of executable objects &
    #   execute this recipe again
    #
    # @override
    def receive_reload_signal(signal, desc)
      pids.each { |pid| Process.kill(:TERM, pid) }
      executables.clear
      pids.clear
      execute
    end

    private
    def load
      eval(File.read(path), binding)
    end
  end
end
