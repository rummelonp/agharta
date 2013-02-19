# -*- coding: utf-8 -*-

module Agharta
  class Recipe
    include Executable
    include Configuration
    include UserStream

    def self.register(klass)
      include(klass)
    end

    attr_reader :name

    def initialize(name = caller.first.split(':').first)
      @name = name
    end

    def execute
      executables.each do |executable|
        Process.fork { executable.execute }
      end
      Process.waitall
    end
  end
end
