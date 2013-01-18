# -*- coding: utf-8 -*-

module Agharta
  module Recipes
    def self.register(klass)
      include(klass)
    end
  end
end

require 'agharta/recipes/sample'
