# -*- coding: utf-8 -*-

module Agharta
  class Recipe
    def self.register(klass)
      include(klass)
    end

    def self.execute(recipe_path)
      new(recipe_path).execute
    end

    attr_reader :name
    attr_reader :path

    def initialize(recipe_path)
      @name = File.basename(recipe_path)
      @path = recipe_path
    end

    def execute
      if File.exists?(path)
        eval(File.read(path), binding)
      end
      clients.each do |client|
        Process.fork { client.start }
      end
      Process.waitall
    end
  end
end
