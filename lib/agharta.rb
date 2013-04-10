# -*- coding: utf-8 -*-

require 'agharta/recipe'

module Agharta
  def self.new(name  = caller.first.split(':').first, &block)
    Recipe.new(name, &block)
  end
end
