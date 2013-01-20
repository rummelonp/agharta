# -*- coding: utf-8 -*-

module Agharta
  module Tasks
    class Edit < Thor::Group
      Tasks.register :edit, self

      def self.banner
        'agharta edit [recipe]'
      end

      include Actions

      desc 'open or edit recipe'

      argument :recipe_name, :optional => true

      def setup
        help unless recipe_name
        env.empty_directory(:recipes_root)
      end

      def edit
        system env.editor, env.build_recipe_path(recipe_name)
      end
    end
  end
end
