# -*- coding: utf-8 -*-

module Agharta
  module Tasks
    class Execute < Thor::Group
      Tasks.register self

      def self.banner
        'agharta execute [recipe]'
      end

      include Agharta::Tasks::Actions

      desc 'execute recipe'

      argument :recipe_name, :optional => true

      def setup
        exit_with_help unless recipe_name
        @recipe_path = env.recipe_path(recipe_name)
        unless File.exists?(@recipe_path)
          exit_with_error "No such recipe \"#{recipe_name}\""
        end
      end

      def execute
        load @recipe_path
      end
    end
  end
end
