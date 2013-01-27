# -*- coding: utf-8 -*-

module Agharta
  module Recipes
    def self.register(klass)
      include(klass)
    end
  end
end

require 'agharta/recipes/configuration'
require 'agharta/recipes/handlers'
require 'agharta/recipes/user_stream'
