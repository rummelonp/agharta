# -*- coding: utf-8 -*-

require 'agharta/recipe'

module Agharta
  class FileRecipe < Recipe
    attr_reader :path

    def self.execute(recipe_path)
      new(recipe_path).execute
    end

    def initialize(recipe_path)
      @name = File.basename(recipe_path)
      @path = recipe_path
    end

    def execute
      load
      super
    end

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
