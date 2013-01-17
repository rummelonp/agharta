# -*- coding: utf-8 -*-

module Agharta
  class Recipe
    include Agharta::Commands

    def initialize(recipe_path)
      @recipe_path = recipe_path
    end

    def execute
      eval(File.read(@recipe_path), binding)
      Process.waitall
    end
  end
end
