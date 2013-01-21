# -*- coding: utf-8 -*-

require 'pry'

module Agharta
  module Tasks
    class Console < Thor::Group
      Tasks.register 'console', self

      def self.banner
        'agharta console'
      end

      desc 'start console'

      def console
        Pry.start(Recipe.new)
      end
    end
  end
end
