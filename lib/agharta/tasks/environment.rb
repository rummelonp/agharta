# -*- coding: utf-8 -*-

require 'fileutils'
require 'yaml'

module Agharta
  module Tasks
    module Environment
      def self.root
        @root ||= ENV['AGHARTA_HOME'] || File.join(Dir.home, '.agharta')
      end

      def self.config_path
        File.join(root, 'config.yml')
      end

      def self.recipes_root
        @recipes_root ||= File.join(root, 'recipes')
      end

      def self.editor
        @editor ||= ENV['EDITOR'] || 'vi'
      end

      def self.empty_directory(destination)
        destination = send(destination)
        unless File.exists?(destination)
          FileUtils.mkdir_p(destination)
        end
      end

      def self.config
        YAML.load_file(config_path)
      rescue
        {}
      end

      def self.build_recipe_path(recipe_name)
        File.join(recipes_root, recipe_name)
      end
    end
  end
end
