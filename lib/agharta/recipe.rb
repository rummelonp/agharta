# -*- coding: utf-8 -*-

module Agharta
  class Recipe
    def initialize(recipe_path)
      @recipe_path = recipe_path
    end

    def execute
      eval(File.read(@recipe_path), binding)
    end
  end
end
