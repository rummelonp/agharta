# -*- coding: utf-8 -*-

module Agharta
  module Helper
    def home
      ENV['AGHARTA_HOME'] || File.join(Dir.home, '.agharta')
    end

    def recipe_dir
      File.join(home, 'recipes')
    end

    def find_recipe(recipe_name)
      File.join(recipe_dir, "#{recipe_name}.rb")
    end

    def editor
      ENV['EDITOR'] || 'vi'
    end
  end

  extend Helper
end
