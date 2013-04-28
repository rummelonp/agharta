# -*- coding: utf-8 -*-

require 'agharta/recipe'

module Agharta
  # Delegate to a {Agharta::Recipe}
  #
  # @return [Agharta::Recipe]
  def self.new(name  = caller.first.split(':').first, &block)
    Recipe.new(name, &block)
  end
end
