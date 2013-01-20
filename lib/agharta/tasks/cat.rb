# -*- coding: utf-8 -*-

module Agharta
  module Tasks
    class Cat < Thor::Group
      Tasks.register self

      def self.banner
        'agharta cat [recipe]'
      end

      include Actions

      desc 'cat recipe'

      argument :recipe_name, :optional => true

      def setup
        help unless recipe_name
        @recipe_path = env.build_recipe_path(recipe_name)
        unless File.exists?(@recipe_path)
          error "No such recipe \"#{recipe_name}\""
        end
      end

      def cat
        system 'cat', @recipe_path
      end
    end
  end
end
