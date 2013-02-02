# -*- coding: utf-8 -*-

module Agharta
  class Recipe
    def self.register(klass)
      include(klass)
    end

    def self.execute(recipe_path)
      new(recipe_path).send(:execute)
    end

    attr_reader :name
    attr_reader :path

    def initialize(recipe_path)
      @name = File.basename(recipe_path)
      @path = recipe_path
    end

    private
    def execute
      eval(File.read(path), binding)
      Process.waitall
    end
  end
end
