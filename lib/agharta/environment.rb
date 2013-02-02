# -*- coding: utf-8 -*-

require 'singleton'
require 'fileutils'
require 'yaml'

module Agharta
  class Environment
    include Singleton

    def root
      @root ||= ENV['AGHARTA_HOME'] || File.join(Dir.home, '.agharta')
    end

    def config_path
      @config_path ||= File.join(root, 'config.yml')
    end

    def recipes_root
      @recipes_root ||= File.join(root, 'recipes')
    end

    def logs_root
      @logs_root ||= File.join(root, 'logs')
    end

    def assets_root
      @assets_root ||= File.dirname(__FILE__) + '/../../assets'
    end

    def editor
      @editor ||= ENV['EDITOR'] || 'vi'
    end

    def empty_directory(destination)
      destination = send(destination)
      unless File.exists?(destination)
        FileUtils.mkdir_p(destination)
      end
    end

    def config(reload = false)
      if reload
        @config = load_config
      else
        @config ||= load_config
      end
    end

    def load_config
      YAML.load_file(config_path)
    rescue
      {}
    end

    def build_recipe_path(recipe_name, base_dir = recipes_root)
      File.join(base_dir, recipe_name)
    end

    def find_recipe(recipe_name)
      [recipes_root, assets_root].each do |base_dir|
        recipe_path = build_recipe_path(recipe_name, base_dir)
        if File.exists?(recipe_path)
          return recipe_path
        end
      end
      nil
    end

    def build_log_path(log_name)
      File.join(logs_root, log_name)
    end
  end
end
