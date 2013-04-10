# -*- coding: utf-8 -*-

require 'agharta/file_recipe'
require 'agharta/tasks/actions'
require 'thor/group'

module Agharta
  module Tasks
    class Execute < Thor::Group
      Tasks.register :execute, self

      def self.banner
        'agharta execute [recipe]'
      end

      include Actions

      desc 'execute recipe'

      argument :recipe_name, :optional => true

      def setup
        help unless recipe_name
        @recipe_path = env.find_recipe(recipe_name)
        unless @recipe_path
          error "No such recipe \"#{recipe_name}\""
        end
        env.empty_directory(:data_root)
        env.empty_directory(:logs_root)
      end

      def execute
        FileRecipe.execute(@recipe_path)
      end
    end
  end
end
