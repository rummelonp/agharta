# -*- coding: utf-8 -*-

module Agharta
  module Context
    def name
      self.class.to_s.split('::').last.downcase
    end
  end
end
