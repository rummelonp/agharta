# -*- coding: utf-8 -*-

module Agharta
  # @abstract Include this module when to create executable or hookable object
  module Context
    # Return context name
    #
    # @return [String]
    def name
      self.class.to_s.split('::').last.downcase
    end

    # @abstract Should override
    def current_user
      raise NotImplementedError, 'Should override'
    end
  end
end
