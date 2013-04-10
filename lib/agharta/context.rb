# -*- coding: utf-8 -*-

module Agharta
  module Context
    # FIXME: better method name
    def name
      self.class.to_s.split('::').last.downcase
    end
  end
end
