# -*- coding: utf-8 -*-

module Agharta
  module Commands
    def self.register(klass)
      include(klass)
    end
  end
end

require 'agharta/commands/sample'
