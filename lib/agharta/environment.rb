# -*- coding: utf-8 -*-

require 'fileutils'
require 'singleton'
require 'yaml'

module Agharta
  class Environment
    include Singleton

    # Return agharta user home directory path
    #
    # @return [String]
    def root
      @root ||= ENV['AGHARTA_HOME'] || File.join(ENV['HOME'], '.agharta')
    end

    # Return agharta configuration file path
    #
    # @return [String]
    def config_path
      @config_path ||= File.join(root, 'config.yml')
    end

    # Return agharta recipes directory path
    #
    # @return [String]
    def recipes_root
      @recipes_root ||= File.join(root, 'recipes')
    end

    # Return agharta data directory path
    #
    # @return [String]
    def data_root
      @data_root ||= File.join(root, 'data')
    end

    # Return agharta logs directory path
    #
    # @return [String]
    def logs_root
      @logs_root ||= File.join(root, 'logs')
    end

    # Return agharta assets directory path
    #
    # @return [String]
    def assets_root
      @assets_root ||= File.dirname(__FILE__) + '/../../assets'
    end

    # Return editor executable name
    #
    # @return [String]
    def editor
      @editor ||= ENV['EDITOR'] || 'vi'
    end

    # Create given agharta directory if not exists
    #
    # @param destination [Symbol]
    # @example
    #   env.empty_directory(:data_root)
    def empty_directory(destination)
      destination = send(destination)
      unless File.exists?(destination)
        FileUtils.mkdir_p(destination)
      end
    end

    # Return configuration
    #
    # @param reload [Boolean] When given true, reload configuration from file
    # @return [Hash]
    def config(reload = false)
      if reload
        @config = load_config
      else
        @config ||= load_config
      end
    end

    # Load configuration
    #
    # @return [Hash]
    def load_config
      YAML.load_file(config_path)
    rescue
      {}
    end

    # Return recipe path from given recipe name
    #
    # @param recipe_name [String]
    # @option base_dir [String]
    # @return [String]
    def build_recipe_path(recipe_name, base_dir = recipes_root)
      File.join(base_dir, recipe_name)
    end

    # Find recipe from given recipe name
    #
    # @param recipe_name [String]
    # @return [String]
    # @return [nil] When given name recipe not exists
    def find_recipe(recipe_name)
      [recipes_root, assets_root].each do |base_dir|
        recipe_path = build_recipe_path(recipe_name, base_dir)
        if File.exists?(recipe_path)
          return recipe_path
        end
      end
      nil
    end

    # Return data path from given data name
    #
    # @param data_name [String]
    # @return [String]
    def build_data_path(data_name)
      File.join(data_root, data_name)
    end

    # Return log path from given log name
    #
    # @param log_name [String]
    # @return [String]
    def build_log_path(log_name)
      File.join(logs_root, log_name)
    end
  end
end
