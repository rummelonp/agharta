# -*- coding: utf-8 -*-

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

    def load!
      eval(File.read(path), binding)
    end

    def execute
      load!
      super
    end
  end
end
