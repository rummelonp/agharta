# -*- coding: utf-8 -*-

module Agharta
  class Recipe
    include Recipes

    def self.execute(recipe_name)
      new.execute(recipe_name)
    end

    def execute(recipe_path)
      eval(File.read(recipe_path), binding)
      Process.waitall
    end
  end
end
