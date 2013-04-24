# -*- coding: utf-8 -*-

require 'agharta/recipe'
require 'agharta/tasks/actions'
require 'pry'
require 'thor/group'

module Agharta
  module Tasks
    class Console < Thor::Group
      Tasks.register 'console', self

      # @private
      def self.banner
        'agharta console'
      end

      include Actions

      desc 'start console'

      def setup
        env.empty_directory(:data_root)
        env.empty_directory(:logs_root)
      end

      def console
        Pry.start(Recipe.new('console'))
      end
    end
  end
end
