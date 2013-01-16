# -*- coding: utf-8 -*-

module Agharta
  module Environment
    def self.root
      ENV['AGHARTA_HOME'] || File.join(Dir.home, '.agharta')
    end

    def self.recipe_root
      File.join(root, 'recipes')
    end

    def self.recipe_path(recipe_name)
      File.join(recipe_root, "#{recipe_name}.rb")
    end

    def self.editor
      ENV['EDITOR'] || 'vi'
    end
  end
end
