# -*- coding: utf-8 -*-

require 'pry'

module Agharta
  module Tasks
    class Console < Thor::Group
      Tasks.register 'console', self

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
