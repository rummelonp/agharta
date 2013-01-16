# -*- coding: utf-8 -*-

module Agharta
  module Tasks
    class Execute < Thor::Group
      Tasks.register self

      def self.banner
        'agharta execute [recipe]'
      end

      desc 'execute recipe'

      argument :recipe_name, :optional => true

      def setup
        unless recipe_name
          self.class.help(shell)
          exit 0
        end
        @recipe = Agharta.find_recipe(recipe_name)
        unless File.exists?(@recipe)
          say "No such recipe \"#{recipe_name}\""
          exit 1
        end
      end

      def execute
        load @recipe
      end
    end
  end
end
